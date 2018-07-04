Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B54C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE43218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="eG3wQpKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE43218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeGDR7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:59:31 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39468 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeGDR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:59:29 -0400
Received: by mail-io0-f195.google.com with SMTP id e13-v6so5519505iof.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D8pyX4sx1jmabSlfZmPRxbe1SdLbpr1HqfZmZIm38As=;
        b=eG3wQpKeCUEr6q4ulTdIr3STQApyIOJvCWtSw8OY3kLP9+z32H/ZT1iJQvUIs2R5iI
         CRn6vL1kH9ofkrhg11R4EUkPwtZHBxy51xNjyKa5tqnG0WNCO0KmYHWmFzygP2gK5Kym
         7NdLBsJ/oLEd0lOL8MvPXNf32fbT4crc+IgGUbzsxBI2h+PK8i+rAgS0BRqLeHqFALCb
         8SAnW2e5FBGIdZxrnHz9c9DLPTkuWPryziBfSXhVDp0gEjk3b9sXjWP0an7pU3s5APDk
         iR5Enoo8zDHZGraMiBkoMP0HdudLGw2B+a/NdJyg6/TqwV5SYLJJ+hBE1O/bEn/VfQF1
         DWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D8pyX4sx1jmabSlfZmPRxbe1SdLbpr1HqfZmZIm38As=;
        b=KZUQtNzuMsJB4Yu2lO7ra86mh0Faqw9gDwM+mniCueUTinWrlEDFnYIU6JNOU93Nzl
         or5qf+aFMQWDM1yjlH1hhJBq/tiIYdKcNqnFPy4GtqprkXqAEsSC0P4pA6A2auJQTJzZ
         FfpFp9VueyFcphWpGFeDVdxT0Eggx2+Ymhfz39NG0DlQ2u4rU0c24YuP25Z0JAdye/Gd
         6Eh5h6AnttsFWNpvWiEkyoMBwY+jim28+V54t6IVxPIujiJzGYp0I/K0G6MFSrypVfGg
         sMQjKj60wGyXXm2/ay9LuSC7Mc+pds1ihekM1h7qkxLZXIed5hyMfDsE4XQgA/eT5Uzi
         v19Q==
X-Gm-Message-State: APt69E0ExuLn3UX3+h383s4ymwa84hjb0Vr5sjXs1HkFVHHdlvU2oxw6
        9QKUmGN4iLMLNAsTYQq8Jw5UA2c3A1k=
X-Google-Smtp-Source: AAOMgpeNF9w+3KGei/IMFdN3aa7KblrS5D7rmWbuwwTICj+Z4JRFcpUUmbic39iQA8KC3h94E9hQwA==
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr2332615ioh.175.1530727168843;
        Wed, 04 Jul 2018 10:59:28 -0700 (PDT)
Received: from [192.168.43.158] ([172.58.139.43])
        by smtp.googlemail.com with ESMTPSA id d14-v6sm2229967itc.34.2018.07.04.10.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 10:59:28 -0700 (PDT)
Subject: Re: [PATCH] Fix platform data in leds-pca955x.c
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     clg@kaod.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Andrew Jeffery <andrew@aj.id.au>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net>
 <CAHp75Vc+2rjFcLfuV5ao0eGmz2aF4jRS_YTZQTaRx=45sOSFOw@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <6842e605-d299-7476-dc15-b27eb7b3bf41@landley.net>
Date:   Wed, 4 Jul 2018 12:59:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc+2rjFcLfuV5ao0eGmz2aF4jRS_YTZQTaRx=45sOSFOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2018 12:00 PM, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 3:46 AM, Rob Landley <rob@landley.net> wrote:
>> I have some questions about recent changes to leds-pca955x.c since 4.13:
>>
>> How is non-of platform data supposed to work now? Commit ed1f4b9676a8 switched
>> struct led_platform_data *pdata in the _probe() function to a locally defined
>> structure that platform data can't provide because it's not in any header it
>> can #include.
>>
>> This is disguised by dev_get_platdata() returning a void * so changing the type
>> of pdata the returned pointer is assigned to didn't require a new typecast,
>> instead existing board definitions still compile but quietly break at runtime.
>> (Specifically the SH7760 board I use at work broke in the pdata->num_leds !=
>> chip->bits sanity check, and then userpace sees an empty /sys/class/leds and I
>> started start digging because "huh"?)
>>
>> Why did the type change, anyway? The generic led_platform_data it was
>> using before has all the fields the device tree's actually initializing, at
>> least if you use flags for the new gpio stuff.
>>
>> Commit 561099a1a2e9 added CONFIG_LEDS_PCA955X_GPIO, but the initialization
>> code adds gpio logic outside this config symbol: probe only calls
>> devm_led_classdev_register() within a case statement that depends on setting the
>> right "this is not GPIO" value.
>>
>> The "GPIO" indicator could have been a flag in the existing LED structure's
>> flags field, but instead of a bit it's #defining three symbols. The
>> PCA955X_TYPE_* macros with the new type constants only exist in the device tree
>> header. Strangely, the old default "this is an LED" value isn't zero, zero is
>> PCA955X_TYPE_NONE which is unused (never set anywhere in the tree), and would
>> cause the LED to be skipped: you have to set a field platform data can't
>> access, using a macro platform data probably doesn't have, in order for
>> devm_led_classdev_register() to get called on that LED at all. Why?
>>
>> This is especially odd since if you did want to skip an LED, there was already a
>> way to indicate that: by giving it an empty string as a name. (It doesn't seem
>> to have come up, but it's the obvious way to do it.) Except commit 390c97dc6e34
>> deals with that by writing the index number as a string to the platform data
>> struct. Leaving aside "why did you do that?", isn't the platform data supposed to
>> be in a read only section when it's actual platform data? And since the probe
>> function then immediately copies the data into the another structure, can't we
>> just fill out the other one directly without overwriting our arguments?
>>
>> As for the lifetime rules, the local pca955x_led (writeable copy initialized from
>> the read-only platform data) had the name[] array locally living in the
>> struct, but the device tree commits added char *default_trigger pointing to
>> external memory. Is there a reason this is now inconsistent?
>>
>> Here's the patch I whipped up at work today (applied to v4.14) that undid enough
>> of this to make the driver work again with platform data on the board we ship:
> 
> No platform data, please.

Why?

Platform data is what this was using before the device tree migration broke it,
without regression testing any existing boards using the driver. I just put it
back to working with the existing structures defined in the existing board file,
which is as straightforward "undoing the regression" as I can.

I'm happy to migrate the whole thing to device tree, but that's bigger than
fixing an LED driver regression, and too big a change for this product release.

> So, we have two options here:
> - use Unified Device Properties API
> - introduce something like LED_LOOKUP_TABLE (see analogue with GPIO /
> regulator / PWM)
> 
> Looking at the platform data LED framework provides I don't see for
> now a necessity of creating lookup tables (though it might be better
> choice in long term).

I... don't see that necessity either?

The data structure the driver needed in 4.13 contained all the information
needed to run the device. The new data structure this driver created locally in
the C file had no obvious reason to exist, and didn't have visiblity outside the
driver file despite being the new input format the driver expected. How was that
thought through?

The new OF probe is allocating a temporary structure to copy data into from the
fdt, then feeding the intermediate structure to a probe function that allocates
_another_ set of structures to copy the data into from there, except the old
code copied _everything_ into the new structures and the new one is leaving
gratuitous pointers to the intermediate structures so they can't be freed. How
does that make sense?

I have no idea why they did any of this, but I don't see how my patch made it
worse. What's there is crazy, my fix was to back up to "not crazy". I'm all for
a better fix on top of that later, but "it works again" is the important bit.

(I admit I gave the device tree codepath exactly as much testing as the device
tree developers gave the platform data codepath, but it should work.)

> For now, you can switch to unified device properties API (basically
> un-ifdef pca955x_pdata_of_init() and replacing of_* by device_* or
> fwnode_* compatible calls) and providing a static table of built-in
> device properties in the platform code in question.

Ah, a static table of built-in device properties. You mean like:

+static struct led_info sh7760_led_info[] = {
+    { .name = "peer_com" },
+    { .name = "run" },
+    { .name = "gen_fault" },
+    { .name = "bat_fault" },
+    { .name = "eth_10" },
+    { .name = "bat_chg" },      /* Used as binary (low active) output */
+    { .name = "bat_load" },     /* Used as binary (low active) output */
+    { .name = "bo_on_n" },      /* Used as binary (low active) output */
+};
+
+static struct led_platform_data sh7760_led_platform_data = {
+    .num_leds = 8,
+    .leds = sh7760_led_info,
+};
+
+static struct i2c_board_info __initdata sh7760_i2c0_devices[] = {
+    {
+        I2C_BOARD_INFO("pca9551", 0x60),    /* Use 7-bit addresses */
+        .platform_data = &sh7760_led_platform_data,
+    },
+};

I.E. the existing format that worked fine back in 3.x?

I've been trying to clean the board support patches up to get it all posted
upstream for a couple months now. Porting the product to a reasonably current
kernel was the first step. (Would have been 4.16 and then 4.17 but the flash
driver grew a weird data corruption bug in the dev cycle for 4.15 I haven't had
spare bandwidth to track down yet, it takes about fifteen minutes of jffs2
stressing to manifest, then you have to reformat the partition.)

I can post a 4.17 version of the patch if you like? (I have to port 3 _other_
patches to test that version on the actual hardware, and then the filesystem
will eat itself at some random point because of the flash issue unless that got
fixed since 4.16, but I can do that thursday if you think it would help?)

> (see include/linux/property.h, for example users of
> PROPERTY_ENTRY_U*() macros, like arch/arm/mach-pxa/raumfeld.c

Will that work with the driver as-is? Given that the structure the driver is
taking as external input is local to the driver .c file, I don't see how?

If an identical structure _is_ present in include/linux/property.h, presumably
not with the pca955x name in the generic header, then why is leds-pca955x.c
defining its own local copy of it? And who regression tests keeping the two in sync?

Or are you saying "let's create a third format and convert all the existing
users to something _other_ than device tree"? If so... why?

Rob
