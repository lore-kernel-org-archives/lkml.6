Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F5CC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB36B218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hmS6JdPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfAZASl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 19:18:41 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39139 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAZASl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 19:18:41 -0500
Received: by mail-vs1-f66.google.com with SMTP id h78so6732828vsi.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 16:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qbi7lORVPyiZteD4/sEEJ0V25ERsWaShsnd+VMBpmgI=;
        b=hmS6JdPaC0KfUp1h8YVuF0XnklW85Wkvucs5EGQUEU8hWlwmGm9HymU/vaKkcn0v3D
         n/rukdNrr/8cZPMWkneMtyypZ0coo90t7rEG9lfRnKAUfhKu9lAZ/QEvQ687NRhHw1Ra
         XlRNkXfFv7ySplrf+z2CucNXwXg5LC34LkSa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qbi7lORVPyiZteD4/sEEJ0V25ERsWaShsnd+VMBpmgI=;
        b=JLocueuoY6QHDcExDuFJg70lt+r9NKeYq9xiULC18dDaAJ08W3ML25G0vhHji7IUlW
         NIymrUg7fM6rmxMJbc/l0qUki7w6i1rQpoCD0RcDbzZm/ozS858Du0WeHoWpWaFIftdI
         qEij9fCT1fvwXkIC5ypf7ACLeo8jkGn/qRuoSOMJuLt1yIKBabZOCoSXSzZi5RKYr919
         CJrPhwB5YeNmfQjvvVn+76wnRC9N49AGjjh8NVekNMoBLtc2xNxV78sw9M8fqLhJ065q
         ytl+jw03QgqcgjRkAe0Ypd2QPTYnY81PlMKyOhzRPbrNjUbMKSkd1Hm5lMUv2yeT0pXt
         YqTw==
X-Gm-Message-State: AJcUukcFVRlRn9b3niJdL4wj0ytDh4tJP7cSXPo/4EsKjrnQpg6pr0tZ
        uCWwDceAWO2I7dD/Apw/s1Fuwik8BrY=
X-Google-Smtp-Source: ALg8bN5nOpAIjcNJH73xINighsPfqEcRKi/+0HMEAsiHduu9oZrDCVJUMaF9Br8PBbm5kQBlbC4EXQ==
X-Received: by 2002:a67:b245:: with SMTP id s5mr5396692vsh.200.1548461919603;
        Fri, 25 Jan 2019 16:18:39 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id j95sm38640892uad.6.2019.01.25.16.18.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 16:18:38 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id u19so3859230uae.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 16:18:38 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr5201133uap.14.1548461917695;
 Fri, 25 Jan 2019 16:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20190125203140.GA1814@embeddedor>
In-Reply-To: <20190125203140.GA1814@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 26 Jan 2019 13:18:25 +1300
X-Gmail-Original-Message-ID: <CAGXu5j+N+tqx+1z-1zq2_Egantdcr6YSm_1s4XeSUN427zDhQA@mail.gmail.com>
Message-ID: <CAGXu5j+N+tqx+1z-1zq2_Egantdcr6YSm_1s4XeSUN427zDhQA@mail.gmail.com>
Subject: Re: [PATCH] lib/cmdline.c: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 9:31 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> lib/cmdline.c:137:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> lib/cmdline.c:140:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> lib/cmdline.c:143:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> lib/cmdline.c:146:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> lib/cmdline.c:149:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/cmdline.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/cmdline.c b/lib/cmdline.c
> index 171c19b6888e..dc59d6216318 100644
> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -135,18 +135,23 @@ unsigned long long memparse(const char *ptr, char **retptr)
>         case 'E':
>         case 'e':
>                 ret <<= 10;
> +               /* fall through */
>         case 'P':
>         case 'p':
>                 ret <<= 10;
> +               /* fall through */
>         case 'T':
>         case 't':
>                 ret <<= 10;
> +               /* fall through */
>         case 'G':
>         case 'g':
>                 ret <<= 10;
> +               /* fall through */
>         case 'M':
>         case 'm':
>                 ret <<= 10;
> +               /* fall through */
>         case 'K':
>         case 'k':
>                 ret <<= 10;
> --
> 2.20.1
>


-- 
Kees Cook
