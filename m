Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98809C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6614421902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap1/Dz+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393576AbfBNCRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:17:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40433 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfBNCRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:17:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj4so2246049plb.7;
        Wed, 13 Feb 2019 18:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiQC8o7iQoPNPYXrd3RGheePtzZatKHYThOt5bDEYeg=;
        b=ap1/Dz+iTqSI1yFI/8/m9yPo4oxncQXP70CraSrg0FnuugljkKtwMlshPaHSoveiHA
         04d3ibftDKEqjl2EjB5MGrjJeWMji7KZUgkhRaUrQg+tmW0RSlDopzE/e1dj0duhOKZf
         hIpGmACWRQJAW+J1IA5zZAVrpzrav14t8HwtPivO3/VUP15x4H+bw5kmC9ReSGxs6ihL
         wK5CBnuAuVYkRtmFQHCniUgRsg+8YUxhnktF0XT/X/xzE31yFdDtF9hB9tSFWJVe/SIF
         PuFde+QbdidvZylBeeEgvft71qFPgY8KRoZhSY2RBQrteb84G2KWYrGSsSl/ep8/M/EO
         2Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiQC8o7iQoPNPYXrd3RGheePtzZatKHYThOt5bDEYeg=;
        b=LFIa6A8Bkh27rtXGgKA2EI6WDHpA1aoR9naOojf53NDXJBurGs3KOjZcrPbclKxsGH
         eYXEqNq9QbVkKtIn6e5H4+CekE6wXXBALZzJnWwr8SzVIQlzl1ppVMpnD4jlroNv24HT
         009sPXY2L5yPZXm59MiplLzl4K4tXkj/9lNaFowh9kYDoJ7zGKyw54XJOvWoR9c13y7+
         SnyLoyk6g2ElAlzBwrgzPO7wg08yAIk42OIWVJa93VE8INfVKc0HxO0VaKhvteZl00Vr
         co7Ys5gIf6kGG8xcv7bp8l/BKiWH264r47p9+sB/w3fX+FUoBVIWcWrF32HxgJ3fcX2P
         I7IA==
X-Gm-Message-State: AHQUAuYVrmjezHdmEui2Lb25Q+CSK+xbFhbxdBfFKY2HEFN65GRQq9io
        I4N4QdvGM43r/hHrbwIt7tvhOCuFbrE23qj0X/U=
X-Google-Smtp-Source: AHgI3Ia7t4UG24tT4Ex7JcSeEInPfy/umL61cYYZpXgtPDhfvU649okrrViB4TSxQAMJ6lyMpQqYGN9ZEZg2HKlsVAU=
X-Received: by 2002:a17:902:1a2:: with SMTP id b31mr1525730plb.87.1550110638772;
 Wed, 13 Feb 2019 18:17:18 -0800 (PST)
MIME-Version: 1.0
References: <1550091448-28578-1-git-send-email-info@metux.net>
In-Reply-To: <1550091448-28578-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Feb 2019 04:17:07 +0200
Message-ID: <CAHp75VeZSrxoxd298eFiJj-N_MRsCXa2GEAXry5jCUi6twt_Xg@mail.gmail.com>
Subject: Re: APUv2/v3 board support V2
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:57 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Hi folks,
>
>
> this is version 2 of my APUv2/APUv3 series. Heavily reworked,
> hope I've now addressed all issues of the last one.

Thanks!
It looks indeed better.

I dunno how you created this message, I hope you used --cover-letter
parameter to git-format-patch.
Just don't forget to add -v<N>, where <N> is version.

Also makes sense to do --thread to put proper references to emails.

> Major changes are:
>  * using gpiod_lookup_table instead of hardcoded gpio numbers
>  * moved the PCHs gpio register definitions to the gpio drivers'
>    header (but keeping the actual assignments in the board driver,
>    as they're board speficic)
>  * moved IO resource definition from board to gpio driver
>    (the FCHs mmio base address could be changed, but nobody
>    seems to ever do it)
>  * added gpio line names
>  * moved the gpio driver's pdata definitions to::
>    include/linux/platform_data/gpio/gpio-amd-fch.h
>  * reduced some code redundancies and various cleanups
>
> Possibly debatable:
>  * does is the assigned key code fit well ? (KEY_SETUP seemed the
>    best candidate to me, but I'm open to suggestions)
>  * should the pch gpio become a sub-device of some toplevel PCH
>    device ? (which then could also maintain the base address, etc)
>
> Note: the keyboard device needs separate patch for gpiod_lookup_table
> support in gpio-keys-polled driver. I'll sent it separately.
>
>
> --mtx
>
>
> --
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287



-- 
With Best Regards,
Andy Shevchenko
