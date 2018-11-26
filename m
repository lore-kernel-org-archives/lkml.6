Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A881C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0DF2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0DF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeKZViV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:38:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34451 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeKZViU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:38:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so16159327otk.1;
        Mon, 26 Nov 2018 02:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRFYRo+sjNMPxHBMy7hrd+Ibh+38iwghuBIzq6g46Oo=;
        b=IrrU6o3Ys26yane8dV2AGpjuPtLnsxdPseCS0WrsENJaL/tG+50E94PHHDKP8PPnBc
         a2WUFbMPrcJNPMY6nqnPL+bOYHB4/CN7DkH5qT4oVtJRge8+hZkjJuiJKbIcC7iDNk1c
         qY2n2RGlNt2vNuwwrVx6nEiH+KM8jsU1nUaVjrmxK903+81u8PVsgE/C+LplykdfwmiL
         SQxLZuRWUIrPzIJ8und3WwoVKdgRkcXiWH24PbMshRIpphxV6YZBhW5Rrne7UuHrVLe2
         F60E5d8+tfGVQHpof5xbZ36resyKbMQl9XarTYnWQz4cmTt3l8PDJR4Q3RrYKjeYQeSp
         KUgQ==
X-Gm-Message-State: AA+aEWbacKP6yQRLWWUL27MjnpZy/6xHQyPczdRPehMpT1Y0W2vX2fjs
        SJptLpY+rBP8gkZ7vexIzT1MA3BySUN5WRG+ipvT0sHA
X-Google-Smtp-Source: AFSGD/VzAUl6tqh9l5mWypoFOAIbgaEjeL04qgEvQ3+FXKQZsTn4wSIydbbxWwxkVnuD1hwEDoYVwjBlztI/WCOyZTc=
X-Received: by 2002:a05:6830:1289:: with SMTP id z9mr11438374otp.281.1543229077834;
 Mon, 26 Nov 2018 02:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20181031111444.3472-1-malat@debian.org>
In-Reply-To: <20181031111444.3472-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 26 Nov 2018 11:44:25 +0100
Message-ID: <CA+7wUsxQEeFrPaSYymwrH31e0po0_5b7zCQG=6yKM064LikGiQ@mail.gmail.com>
Subject: Re: [PATCH] remove old GCC version implementation
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:15 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> GCC 4.6 is the minimum supported now.
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  scripts/mod/file2alias.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 28a61665bb9c..4b59564d4706 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -83,11 +83,7 @@ extern struct devtable *__start___devtable[], *__stop___devtable[];
>  #endif /* __MACH__ */
>
>  #if !defined(__used)
> -# if __GNUC__ == 3 && __GNUC_MINOR__ < 3
> -#  define __used                       __attribute__((__unused__))
> -# else
> -#  define __used                       __attribute__((__used__))
> -# endif
> +#define __used                 __attribute__((__used__))
>  #endif

Superseded by:

https://patchwork.kernel.org/patch/10693483/

>  /* Define a variable f that holds the value of field f of struct devid
> --
> 2.11.0
>
