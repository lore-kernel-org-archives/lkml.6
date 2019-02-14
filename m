Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40CD2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vC5GQ+r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392572AbfBNGzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:55:45 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42647 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389635AbfBNGzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:55:45 -0500
Received: by mail-yb1-f193.google.com with SMTP id j189so1975054ybj.9;
        Wed, 13 Feb 2019 22:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gVqHgDJ/AwjDhbbHVaWbg7stObrhk7MEiRTwD4YqPUk=;
        b=vC5GQ+r5EP8MyedzxBIjtPNF8wi2rjqQHX6FD7sVXblZ44R4/KgX6nDswKJKGs7yfQ
         tBP58jr08suiIrcaJuKDc8gEOtrcexjVCWTU+LJtYSJOF1Y0Ptk37A10wpgyzo3fRnpW
         97tYdniYeg5cMG9sKSwhJxbdTQbRtPDRXcH5n4BkQFScNs1qAN0LGisT3lsVY0aH008O
         64FB/QK6j1nFw8f+TUbr22g92nL1ztiR85cP08dw2LWhahaUOPs230ya4iXDfyN4ZS0h
         nYM7A5UBvhzGIm2BIhufovwjZtIyHzeTa85E+Nw/xrcY8ttkxC+hg6TdmyUK+QKFBpKd
         R70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gVqHgDJ/AwjDhbbHVaWbg7stObrhk7MEiRTwD4YqPUk=;
        b=peiZSl/uNrXJip1UPkIOqklk4s1R++WjqlZhpKjxyx401Ajko5xeWmcs/U6hur1IIU
         cEQTrwX9yCpPEM6J5SQ7P2eLs4S9+EBdavyoxkp9yTw70fdNN8vmB4cLFoBdFqu1T9e1
         S1F+csgz1JyS9+q/utpJ8pHwZbaDlgBymy9qQId3oMf66TOwqn/gXpPd2+0hSYRfYmBB
         nw6cNV4WkhWA08bvojRnc4wpdo0pqucTgnOv6vL9U9deaadgSRCu4DNDRd4OrSBlmBJW
         4Fv5y+erm2Xrb2X4eycaTyE8BjwMiFhYu5luzyatvptUdO/8XQbEStcUmULliNwqeQUf
         fbpg==
X-Gm-Message-State: AHQUAuYEqp4isFixB00oF14WCdwOfPPoEY69JvXpvwTJZoE02smKwqbq
        Zhhi6Sl8AchOeY0d230U4Xo=
X-Google-Smtp-Source: AHgI3IazbMIhq9s+Samk44DAyzVkbcZ9NDQlf/6jCw18GJkMmNvanvGGrfGvwqOxcxVj+VZMLWMeUw==
X-Received: by 2002:a25:2391:: with SMTP id j139mr1728481ybj.516.1550127343657;
        Wed, 13 Feb 2019 22:55:43 -0800 (PST)
Received: from localhost.localdomain ([46.216.144.58])
        by smtp.gmail.com with ESMTPSA id k62sm1134794ywk.84.2019.02.13.22.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 22:55:42 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1guAvs-0006pH-1s; Thu, 14 Feb 2019 09:55:40 +0300
Date:   Thu, 14 Feb 2019 09:55:40 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190214065540.GA16597@jeknote.loshitsa1.net>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:43:29PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 12-02-19 21:59, Yauhen Kharuzhy wrote:
> > Add support for LEDs connected to the Intel Cherry Trail Whiskey Cove
> > PMIC. Charger and general-purpose leds are supported. Hardware blinking
> > is implemented, breathing is not.
> > 
> > This driver was tested with Lenovo Yoga Book notebook.
> 
> Thank you for working on this. The CHT Whiskey Cove PMIC is
> also used on the GPD win and GPD pocket devices and there LED1
> by default indicates the charging status.
> 
> Since your driver forces the LED into SWCTL mode on probe()
> this means that any kernel with it enabled will break the
> charging LEDs OOTB function, this is undesirable.
> 
> I believe it would be best to add a custom "mode" attribute
> to the led classdev, with "manual" and "on-when-charging"
> modes, this would then control bits 0-1 of reg 0x5e1f and
> by default these bits should be left as is when the driver
> loads.
> 
> Note that in my experience the "charging" mode only works
> when bits 0-1 have the value 10. I've some written notes from
> when I played with this myself and they say:
> 
>    -CHT WC powerled control 0x5e1f: bits 0-1:
>     0: ????
>     1: Off
>     2: On when charging
>     3: On
>    -CHT WC powerled pattern control 0x5e20: bits 1-2:
>     0: Off
>     1: On
>     2: Blinking
>     3: Glowing

Maybe you are right, I will check but at Linux Yoga Book this LED
doesn't work as HW-controlled charging status indicator, so I didn't
discovery this.

I used this source as reference; https://github.com/jekhor/yogabook-linux-android-kernel/blob/cm-13.0/drivers/misc/charger_gp_led.c

> Also note that the 0x5e20 notes do not match with your
> defines, I believe this is a small bug in your code, see
> comments in line below.
> 
> As for the 0x5e20 settings, I believe another custom
> sysfs attribute, called "breathing" would be a good idea to
> export the breathing functionality.
> 
> The way I see this working is that writing "1" to this will
> turn on glowing mode, and writing 0 to it, or 0 to brightness
> will turn it off. Reading it will return 1/0 depending on
> whether the LED is in glowing mode or not.

Jacek? Pavel? I thought about pattern_set() implementation for 'breathing'
mode in future but this doesn't seem simple, maybe custom attribute will has
sense?

> 
> For an example of adding custom sysfs attributes to a
> led-class device see kbd_led_groups and kbd_led_attrs in:
> drivers/platform/x86/dell-laptop.c
> 
> > +
> > +#define CHT_WC_LED1_CTRL		0x5e1f
> > +#define CHT_WC_LED1_FSM			0x5e20
> > +#define CHT_WC_LED1_PWM			0x5e21
> > +
> > +#define CHT_WC_LED2_CTRL		0x4fdf
> > +#define CHT_WC_LED2_FSM			0x4fe0
> > +#define CHT_WC_LED2_PWM			0x4fe1
> > +
> > +/* HW or SW control of charging led */
> > +#define CHT_WC_LED1_SWCTL		BIT(0)
> > +#define CHT_WC_LED1_ON			BIT(1)
> > +
> > +#define CHT_WC_LED2_ON			BIT(0)
> > +#define CHT_WC_LED_I_MA2_5		(2 << 2)
> > +/* LED current limit */
> > +#define CHT_WC_LED_I_MASK		GENMASK(3, 2)
> > +
> > +#define CHT_WC_LED_F_1_4_HZ		(0 << 4)
> > +#define CHT_WC_LED_F_1_2_HZ		(1 << 4)
> > +#define CHT_WC_LED_F_1_HZ		(2 << 4)
> > +#define CHT_WC_LED_F_2_HZ		(3 << 4)
> > +#define CHT_WC_LED_F_MASK		0x30
> > +
> > +#define CHT_WC_LED_EFF_ON		BIT(1)
> > +#define CHT_WC_LED_EFF_BLINKING		BIT(2)
> > +#define CHT_WC_LED_EFF_BREATHING	BIT(3)
> > +#define CHT_WC_LED_EFF_MASK		0x06
> 
> So your MASK is correct here, but the values used should
> be based on that, so you get:
> 
> #define CHT_WC_LED_EFF_ON		(1 << 1)
> #define CHT_WC_LED_EFF_BLINKING		(2 << 1)
> #define CHT_WC_LED_EFF_BREATHING	(3 << 1)
> 
> Note that this effectively only changes the value of
> CHT_WC_LED_EFF_BREATHING, so that it now to fits in your
> mask.
> 
> Regards,

Hm, it seems lost in refactoring time, thanks. My original defines were:

#define CHT_WC_LED_EFF_ON               (1<<1)
#define CHT_WC_LED_EFF_BLINKING         (2<<1)
#define CHT_WC_LED_EFF_BREATHING        (3<<1)
#define CHT_WC_LED_EFF_MASK             0x06

I will revert this in next version.

-- 
Yauhen Kharuzhy
