Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37F2C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7BC20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7BC20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeK2UNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:13:19 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46458 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeK2UNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:13:18 -0500
Received: by mail-ua1-f68.google.com with SMTP id v24so371290uap.13;
        Thu, 29 Nov 2018 01:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3nTxsrQDaiUsm6TZwuSmObyCRqM1rpa915guw2Nrfo=;
        b=js6Tqw91JKMU8i/VOaCatKsMvVOHGwH8xDhUUz3W6a0ttENNEI7snTAUcrkmm4FcFI
         8d/pdNh+6zAeBfBs5TBzjeJYLTxEKDbeV/DEffQgG9KWY5fGVvMJ8j2ioS48YIx9bp3r
         ylzoMHQzc1uQ7wOUvjpeY6g2jZ/L5hmDDcNEms1JzYx/vZMxBzy7h00fq7xtCgFWrE+g
         YmRUSIQ93JNkBQUn9i3NPppxCLlwCW6Cxnzplua6syRtmtUa7lnGacdC2GzhtqZSjg00
         VWLESi6uXYp3Bal0FdJVTEqEuMHU8Sb2r3L0bZhDMV8tYqxo4mKDYA4ybivC7bV3s8kP
         KcmA==
X-Gm-Message-State: AA+aEWY9gm7u8LDnuhduvBYKYw8IqblOVFIZGDnVQOSbKWKWk8lo3F8H
        6aoqwPffkDexjdTOHX5jAE1hZ50X5hpxIFazds7lJg==
X-Google-Smtp-Source: AFSGD/X18QpdZLhxnHsrcEynZXLKWkExVnv9ptZ7RSbfH/E/524nFxEzHpJ21oW0NGEK7B3ip5ArABjQ7RguO+ZI1cU=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr291678uap.0.1543482517346;
 Thu, 29 Nov 2018 01:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com> <20181128190537.14074-21-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20181128190537.14074-21-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Nov 2018 10:08:25 +0100
Message-ID: <CAMuHMdVRDa9CoeAKsxh7ka9rdfbKoDDg-PeGosy_ryqYyDXohA@mail.gmail.com>
Subject: Re: [PATCH v4 20/21] mk68/mac: Switch to use %ptR
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-m68k

On Wed, Nov 28, 2018 at 8:07 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Use %ptR instead of open coded variant to print content of
> struct rtc_time in human readable format.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/m68k/mac/misc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
> index ebb3b6d169ea..71c4735a31ee 100644
> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -605,13 +605,9 @@ int mac_hwclk(int op, struct rtc_time *t)
>                 unmktime(now, 0,
>                          &t->tm_year, &t->tm_mon, &t->tm_mday,
>                          &t->tm_hour, &t->tm_min, &t->tm_sec);
> -               pr_debug("%s: read %04d-%02d-%-2d %02d:%02d:%02d\n",
> -                        __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
> -                        t->tm_hour, t->tm_min, t->tm_sec);
> +               pr_debug("%s: read %ptR\n", __func__, t);
>         } else { /* write */
> -               pr_debug("%s: tried to write %04d-%02d-%-2d %02d:%02d:%02d\n",
> -                        __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
> -                        t->tm_hour, t->tm_min, t->tm_sec);
> +               pr_debug("%s: tried to write %ptR\n", __func__, t);
>
>                 switch (macintosh_config->adb_type) {
>                 case MAC_ADB_IOP:
> --
> 2.19.2
