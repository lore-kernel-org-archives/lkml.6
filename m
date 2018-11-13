Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474DEC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D5B208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0mbiz4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D5B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbeKNELY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:11:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32959 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeKNELY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:11:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so21093506qko.0;
        Tue, 13 Nov 2018 10:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOTKAdiEih3UxLayt9rjnzizaD0QtZJNKnfLj/zblBg=;
        b=h0mbiz4y1DIBrhkdHXaD5WWW3GvUm14K3Jdav2b5R54F/NIVikqlbemjWOLNR/liaN
         0Ui7nKBaN3hgPi6vAwdTHCMk0kvgeODrsx/ElpY+0SSyPYrqIDvU6EfmuAahZ+Zf+duO
         4YGYwv64X6sG2i7Bqi93I8rDVDY+f0K1nGirkK6aVyDmq2h6ImHTMuV891Q/YTAiO9xK
         WsdExf9JKsViP5BnQiYdfgTPoIYFH8BBjZnT3EJ0necTRF27wY+4PJ1YRWzrpuXjmdJV
         uKpGUf076mgHR2Buega1qNI3IYvW2bK6l4MlZf6Z1bLCa6qD2GdIp6fE1foD4OV2uNTB
         +WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOTKAdiEih3UxLayt9rjnzizaD0QtZJNKnfLj/zblBg=;
        b=YDxKm6UYePhI3RKRyhgiCeh9Z0h2DkWasDtmITfVeySfNz6RrBLnCSOoqcWBwxLHRN
         0BoCPHQctVi1Kbor1najp8QwwXyZwauB0oUgsMA+3RuU8UOq+MmY1VhfJOkmg6dua/oV
         uZZSc4aHxQ0dWPTAbn41LXnM9OOLZTGEWOH5TP+7xYXyajqYtP4/G6DBMCOejU4H0z0k
         E8OeTl0XB2GLmx+tt3dNeYWo/BuOTKlit8raRRfoUpWVZrU8p3rugyOcIXNh/+NbOy8G
         eht+NyDlknxKp1NZmjJZM6sWzzooYB1roGvJ6iyKFkK0IvOyUKIey8Bv6u98tzpiKOQY
         4aEg==
X-Gm-Message-State: AGRZ1gKdVowfelx17fRkNbtjxa8IUXOvdDkXS2wkVWpXmksSh9KSP4eB
        M7vgB/EyN/4iEo/M/N4O+VbSqMimhfs4pu6trzM=
X-Google-Smtp-Source: AJdET5fCaL0sjZDRdCWg1FweK/N1xfjlPLgHAp39a837uJcVy0j7vY8oRk2ol/dM2Ttl7QW+9rJ4troLILCAJGIMxRw=
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr5932811qkl.70.1542132729369;
 Tue, 13 Nov 2018 10:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
 <20181113171729.19645-2-andriy.shevchenko@linux.intel.com> <9037d76f47233e187276ba84cbb0f46427e2e1eb.camel@perches.com>
In-Reply-To: <9037d76f47233e187276ba84cbb0f46427e2e1eb.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Nov 2018 20:11:57 +0200
Message-ID: <CAHp75Ve4xN_tMxRm0SUWW0XBmMQU4NkUt-dBwPo9w8CHLTVxGw@mail.gmail.com>
Subject: Re: [PATCH v3 01/20] lib/vsprintf: Print time and date in human
 readable format via %pt
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 7:37 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-11-13 at 19:17 +0200, Andy Shevchenko wrote:
> > There are users which print time and date represented by content of
> > struct rtc_time in human readable format.
> >
> > Instead of open coding that each time introduce %ptR[dt][rv] specifier.
> >
> > Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
>
> This bit should be removed as it's not true anymore.

Oops, right.

-- 
With Best Regards,
Andy Shevchenko
