Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E999C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4501E21564
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF1T3oyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4501E21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeGDRAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:00:53 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44112 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeGDRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:00:50 -0400
Received: by mail-vk0-f68.google.com with SMTP id 125-v6so3422079vke.11;
        Wed, 04 Jul 2018 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MN+Mid/JXxBQFpgoLr4mZiOYYM12A1skz4d9JMA09ao=;
        b=aF1T3oyUsSzqcoJKmRo5Hzg+pL7TNCj098JM4ZgEP74KN9fMWej10uPHZX0JwNuun2
         Ez1tnTMhcekJqNp3B3Nxvl++HiFqfF5yCMVeRB86wF0OHBq5mdiZyKECY4dBxrYw0jXL
         V6fDaw5www+Jm2wD0DyydCj10OOapxkZWUEVvLlbNHsDDi2kHGJDj43QV2nQ/UbI/SMT
         T03WuaRJYeznlHCEy1NGouUZBVdFe+KH2q9uucr8PStlxrNkmXIulGM7fbpJUd+eXaQy
         Xz5UHb6dQU1vgHXBWJ6zONe6MeQUvLjS+Wx7UB9h2Id7Cb1L8c08F/WjChNmqOxPHcit
         egAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MN+Mid/JXxBQFpgoLr4mZiOYYM12A1skz4d9JMA09ao=;
        b=Ua6mNkmrUNuMrvUt9sZdAImGlT4cBwd82ZgHNtydeoCXi/3BfBVbOEgRmgbtk8St/L
         z+udcH2SW9PTzGwgAFGtF7+HnOwP0eqyTYus67/Mn3vaiKF5LoKhONj1V/aHgbjxaaKG
         EgGG4fNwBPyWcR1EZzC/rYgclKCd1SJ2iazubd5TXUZNm0QGfb8mE2OBnv30r8ae11cR
         EiZ9Hanb4IFM0Cs4eSBwST+mhuMooJ41KVgOkAGg7igO4rniI/GXOO3SaV/VEDNVQ5Ms
         LgXoFoD8R6wdvEpIVRp5BPKdfgoW24QcDUVlogP+0IT5ZoI9k53wKFXJdmbdJiHdjFez
         N3cQ==
X-Gm-Message-State: APt69E2eJJesdi8rjg+KTSeWUjuLSBljY1lDWsD3kEhCaBbyM+P47X3g
        OqmLchgMBtITWWGYt2QlbxN72FC6fHtwO4aHFI3rASxtyt4=
X-Google-Smtp-Source: AAOMgpfnyTqiEILdxbO+xRtk1+Vv8T5X1xPXbYkwLc8RFZInrHa66o7EIMZv9QwGEmNSpaTM0Xuwkjet687JFB4kC2Q=
X-Received: by 2002:a1f:820e:: with SMTP id e14-v6mr1504917vkd.187.1530723649134;
 Wed, 04 Jul 2018 10:00:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:00:48 -0700 (PDT)
In-Reply-To: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net>
References: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 20:00:48 +0300
Message-ID: <CAHp75Vc+2rjFcLfuV5ao0eGmz2aF4jRS_YTZQTaRx=45sOSFOw@mail.gmail.com>
Subject: Re: [PATCH] Fix platform data in leds-pca955x.c
To:     Rob Landley <rob@landley.net>
Cc:     clg@kaod.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Andrew Jeffery <andrew@aj.id.au>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 3:46 AM, Rob Landley <rob@landley.net> wrote:
> I have some questions about recent changes to leds-pca955x.c since 4.13:
>
> How is non-of platform data supposed to work now? Commit ed1f4b9676a8 switched
> struct led_platform_data *pdata in the _probe() function to a locally defined
> structure that platform data can't provide because it's not in any header it
> can #include.
>
> This is disguised by dev_get_platdata() returning a void * so changing the type
> of pdata the returned pointer is assigned to didn't require a new typecast,
> instead existing board definitions still compile but quietly break at runtime.
> (Specifically the SH7760 board I use at work broke in the pdata->num_leds !=
> chip->bits sanity check, and then userpace sees an empty /sys/class/leds and I
> started start digging because "huh"?)
>
> Why did the type change, anyway? The generic led_platform_data it was
> using before has all the fields the device tree's actually initializing, at
> least if you use flags for the new gpio stuff.
>
> Commit 561099a1a2e9 added CONFIG_LEDS_PCA955X_GPIO, but the initialization
> code adds gpio logic outside this config symbol: probe only calls
> devm_led_classdev_register() within a case statement that depends on setting the
> right "this is not GPIO" value.
>
> The "GPIO" indicator could have been a flag in the existing LED structure's
> flags field, but instead of a bit it's #defining three symbols. The
> PCA955X_TYPE_* macros with the new type constants only exist in the device tree
> header. Strangely, the old default "this is an LED" value isn't zero, zero is
> PCA955X_TYPE_NONE which is unused (never set anywhere in the tree), and would
> cause the LED to be skipped: you have to set a field platform data can't
> access, using a macro platform data probably doesn't have, in order for
> devm_led_classdev_register() to get called on that LED at all. Why?
>
> This is especially odd since if you did want to skip an LED, there was already a
> way to indicate that: by giving it an empty string as a name. (It doesn't seem
> to have come up, but it's the obvious way to do it.) Except commit 390c97dc6e34
> deals with that by writing the index number as a string to the platform data
> struct. Leaving aside "why did you do that?", isn't the platform data supposed to
> be in a read only section when it's actual platform data? And since the probe
> function then immediately copies the data into the another structure, can't we
> just fill out the other one directly without overwriting our arguments?
>
> As for the lifetime rules, the local pca955x_led (writeable copy initialized from
> the read-only platform data) had the name[] array locally living in the
> struct, but the device tree commits added char *default_trigger pointing to
> external memory. Is there a reason this is now inconsistent?
>
> Here's the patch I whipped up at work today (applied to v4.14) that undid enough
> of this to make the driver work again with platform data on the board we ship:

No platform data, please.

So, we have two options here:
- use Unified Device Properties API
- introduce something like LED_LOOKUP_TABLE (see analogue with GPIO /
regulator / PWM)

Looking at the platform data LED framework provides I don't see for
now a necessity of creating lookup tables (though it might be better
choice in long term).

For now, you can switch to unified device properties API (basically
un-ifdef pca955x_pdata_of_init() and replacing of_* by device_* or
fwnode_* compatible calls) and providing a static table of built-in
device properties in the platform code in question.
(see include/linux/property.h, for example users of
PROPERTY_ENTRY_U*() macros, like arch/arm/mach-pxa/raumfeld.c)


-- 
With Best Regards,
Andy Shevchenko
