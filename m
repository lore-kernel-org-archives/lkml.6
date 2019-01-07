Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C81C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E50B2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ewiw0WV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfAGWJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:09:08 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:32826 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfAGWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:09:08 -0500
Received: by mail-ua1-f67.google.com with SMTP id t8so666171uap.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J33h6qXf6ElT9XL2i8kx3wn14Hryf/VSZjLaXuvQAVI=;
        b=Ewiw0WV6aqZk5P40wvwdHy0u7d0SdrL2Qf4s3P2ZEzPAc7+DQFq7fRCypHJv22ICOM
         KdOKhdF1N5w+jLSIDPl35f104iajGnFG2Vf05Tlsgu0wmvVSxDY1FYjnyHrstEXg9zFe
         Tt44vc7wjwEYsET2Ne8yq/PEUELjWp2J0pTxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J33h6qXf6ElT9XL2i8kx3wn14Hryf/VSZjLaXuvQAVI=;
        b=jz5jj5d5Y33AJsEjOVaMrZpbEEqjGJkCAAL70Ly99PNC00ij9llLwtinpF1yOpjdBI
         Yr6uJg8ndI1ZDT6puhHC6T0Z9/6WFUnlEX13cAT6m6nOzZGX5li9r0we9gDPUbWsSLC+
         R2Lyht1dh7iHtsD3RGJY/WUAYiDgM1P3kRvjGmvE+NtLWWWp5RsRkLW9sr5S16RgmAwI
         FINmjL8wFVSl6BCtCLmxcP/OvrQFr3HBQN9hvORvueBzf8ivugOfLi/AqQyA3o1XYPPy
         OJU88MKPvd24u3GbhB6nrIT5ETXYDkKXPbWky/2IHIemfBcnK+V71UCGA/Y0ksKz6oKK
         THiQ==
X-Gm-Message-State: AJcUukfvoqdRb62IvuCsEKEu+4s3OJcaXAk/b7EPcJOP/ZbqkX5iEFlB
        17SZ4TQovd4Cxm8Vcsv5dNF2FdUGvO0=
X-Google-Smtp-Source: ALg8bN641CqM7NDE9en9V247s+ruvIbrZD13zj3JCpjZ4qB6FKcUdzxlNhsPzDC4GGcVhQCVUozCig==
X-Received: by 2002:ab0:4a99:: with SMTP id s25mr17888628uae.34.1546898946786;
        Mon, 07 Jan 2019 14:09:06 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id p136sm19006763vsc.18.2019.01.07.14.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 14:09:05 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id y27so1266362vsi.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:09:05 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr8745238vsl.66.1546898945316;
 Mon, 07 Jan 2019 14:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20190104214727.29431-1-mcroce@redhat.com>
In-Reply-To: <20190104214727.29431-1-mcroce@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 7 Jan 2019 14:08:54 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLY6WGHssefD5=gHay1faFGH-Rofhj0Lr_SUMwSLW=Nkw@mail.gmail.com>
Message-ID: <CAGXu5jLY6WGHssefD5=gHay1faFGH-Rofhj0Lr_SUMwSLW=Nkw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysctl.c: fix typo
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 1:47 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> Fix spelling mistake: "lenght" -> "length"
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 1825f712e73b..6b2691f5d4c9 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -191,7 +191,7 @@ extern int no_unaligned_warning;
>   *     file position 0 and the value must be fully contained in the buffer
>   *     sent to the write syscall. If dealing with strings respect the file
>   *     position, but restrict this to the max length of the buffer, anything
> - *     passed the max lenght will be ignored. Multiple writes will append
> + *     passed the max length will be ignored. Multiple writes will append
>   *     to the buffer.
>   *
>   * These write modes control how current file position affects the behavior of
> --
> 2.20.1
>


-- 
Kees Cook
