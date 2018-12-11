Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB664C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7882081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dekquo6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7882081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeLKM3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:29:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43213 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:29:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so6570534pgk.10;
        Tue, 11 Dec 2018 04:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fviaOuLg+5HEMbPXn/VS/NYB3t6jd2kDqQAWBGUaYng=;
        b=Dekquo6wvz5BaqNZU5998jEuQIl+pkeA4x5SG7LayWDmzOU1kk78YadfkHbvC5lygc
         7zVmcXqnW3M8mclYodsAHUg2Eo8/strNvg9202ZaOHBYEpdaF5bEvSv6yEJMh7xmI2Za
         I/2xSeWuvQCIVh9vlh7j8SgtMFfo5/InDhZQI5doX9nFOQTEtz006mJjmyDeZQa44Nbn
         SNfKTj8armty9fiaGKOWpYNQnxik0pfDiN3m7VzmYvM6fzM8MrkWVwZkU1rXvZ2Jls1k
         luXLjPWL7I+vIknFEjCZ6zSp6CDrlQL0CZ9cp+JneFk84EkGTm1VcNsvmLp6ZE+vUPhT
         XSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fviaOuLg+5HEMbPXn/VS/NYB3t6jd2kDqQAWBGUaYng=;
        b=CLpNNg67p8ki+2yv+98UbMvab/8hjSuZ1uUkO72f0vXUfbX9sJs8g5P6kXHIK5j7Cg
         hgCFTNMnJFC4S4bvmxl0x7kkPJGtHgAo86pDIOntK3/gZ+T6mRWD8j9biiT2InGj0LnH
         2UeaNVdmuveI0Fx43CZJkefoLx47kteYu1nnx/c44RqsTot3QzZE7VJ67CFu5zlv0B4q
         WTfvSNRM+wveBxuUD8k+baBDg/JDSIqeLZaRKQV2ybec0AGcVfi9Z+56J84Q/tW72pWp
         XEdlCqzbd18nlDtFvCFZBMZw+QzNYobdVtkU0Lg3PGaNILraG7YcbAyqVyeGVJ5tn86S
         Rt1g==
X-Gm-Message-State: AA+aEWaXDAh9wXVpgjFAAERBgyYUuSUkxAMf9Abag2NkoZ0Y2mZtGEzC
        Y8PW79k1X1Gr8dpjqJIxnx9lWoaKIP7hqZIbbcQ=
X-Google-Smtp-Source: AFSGD/W4XUD/v2nqk8ciGeefGAgIch9OsxIUDREMnbZpfjySavASDlLOKPxf4CN5e+oPGP9hSKF0V0cYWbf6uDrnStc=
X-Received: by 2002:a63:d450:: with SMTP id i16mr14176351pgj.246.1544531372284;
 Tue, 11 Dec 2018 04:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20181204212330.69515-1-andriy.shevchenko@linux.intel.com>
 <20181204212330.69515-21-andriy.shevchenko@linux.intel.com> <8224399.K2TIF5fxr2@aspire.rjw.lan>
In-Reply-To: <8224399.K2TIF5fxr2@aspire.rjw.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Dec 2018 14:29:20 +0200
Message-ID: <CAHp75Vc_vQE60UQQWGHJ8BvZSCK-VoU6n76pE-=SDKpkz2MU5w@mail.gmail.com>
Subject: Re: [PATCH v6 20/20] PM: Switch to use %ptR
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, December 4, 2018 10:23:30 PM CET Andy Shevchenko wrote:
> > Use %ptR instead of open coded variant to print content of
> > struct rtc_time in human readable format.
> >
> > Cc: linux-pm@vger.kernel.org
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Do you want me to take this patch?

Alexandre took all of them, thanks!

>
> > ---
> >  drivers/base/power/trace.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> > index 1cda505d6a85..b11f47a1e819 100644
> > --- a/drivers/base/power/trace.c
> > +++ b/drivers/base/power/trace.c
> > @@ -118,9 +118,7 @@ static unsigned int read_magic_time(void)
> >       unsigned int val;
> >
> >       mc146818_get_time(&time);
> > -     pr_info("RTC time: %2d:%02d:%02d, date: %02d/%02d/%02d\n",
> > -             time.tm_hour, time.tm_min, time.tm_sec,
> > -             time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
> > +     pr_info("RTC time: %ptRt, date: %ptRd\n", &time, &time);
> >       val = time.tm_year;                             /* 100 years */
> >       if (val > 100)
> >               val -= 100;
> >
>
>


-- 
With Best Regards,
Andy Shevchenko
