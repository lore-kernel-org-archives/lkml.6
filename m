Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0352FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEE720834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEE720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeK2UO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:14:29 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34923 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeK2UO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:14:29 -0500
Received: by mail-vk1-f194.google.com with SMTP id b18so263777vke.2;
        Thu, 29 Nov 2018 01:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olnlU5dmK6IWh9jXpjZg9E16wm+szT1tPxr1pJg/5GI=;
        b=Xzr12pODNm2j6v6iBUEHbyHKyGKNTgcTgsz5vFRy8S7HuzW80AM1E6UNVKb4xMLpM8
         eHv24AxhdBojJo6U6r8l4HRKQwRoiOv8nJU1BBqUCnc8iW63YnYhY9XR1wLosGpZ1Vq9
         gmDaVmNB201hMvM+oNUYBuGtKSVKaOAk2rASQT0GJZX6FV6a66bBMwbH0WBAHgVy89f9
         XGufbGP+OUPfEtrsRlfnFRQwjChBOkIMiL8ArjVwFSif9td6+2PgS/2i9A6NDVKvtv3u
         bODIMUVycGM3OOuXIzsFv7miMo25UeSaMxQLwz9fZcNsGnO2C1H8y7mTZfLHI7X1NjsG
         G5Gw==
X-Gm-Message-State: AA+aEWYOLsOdDCHyCTLXCSJ/tdL8eX0YOOKnb4wSkGmQpa49PhhNI6sg
        EZj4ERQvh75cTAO/yeYuzPTHIFtjq+OjM3Z54Yg=
X-Google-Smtp-Source: AFSGD/UcIHPcAY2p/+Jq62wFeUci1YDpgd0KJvmPwS0QxB5qk0uAxD08BHEERHY+2BjwgDW5y+lSEse1ZkS0nUlhmH0=
X-Received: by 2002:a1f:1881:: with SMTP id 123mr276284vky.40.1543482588329;
 Thu, 29 Nov 2018 01:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com> <20181128190537.14074-21-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20181128190537.14074-21-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Nov 2018 10:09:35 +0100
Message-ID: <CAMuHMdV_-R9xJ79oBFzGpZrj8ksbLxa-0x0d0nuDHWjtRspu3Q@mail.gmail.com>
Subject: Re: [PATCH v4 20/21] mk68/mac: Switch to use %ptR
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-m68k (now for real, stumbling to Senseo machine)

On Wed, Nov 28, 2018 at 8:07 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
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
