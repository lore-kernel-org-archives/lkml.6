Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7DABAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3526C208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFSOA/PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3526C208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965863AbeFOLhd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:37:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40644 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965701AbeFOLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:37:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so3286437wmc.5;
        Fri, 15 Jun 2018 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L2SUcCfd3jQHd1PtiVd6J+1UNXWZYXb+ve0+z/6ZUJg=;
        b=EFSOA/PWIYfZ8nxQQgX78gbajSafTuXtgEhs3J5EN8DZcRCyavmJzedjjkmbH6xmch
         mIrcbbhICBzSIX0TDCKagJ+5cpMzpqDJ4Ffv3iR4IXS/NFjIYza0Mp4fg7u1rBF8HKka
         tIt49Lm3LeMlR1LI01m8I8Aw6OxGFtdPoNzCRiIqAleDz5VMsJNSr/gzsaEb/Y24qUiT
         aMKBe7wNKKaXqqvlkxf3rurw0Q73IIDcYJxFvwVIVD1WFZH4Dj+pBO/Q0VbCm03lfuNX
         W60eqgksYVGWe8NiTp2vdonqnwaiig9GAfY4EDP0kjsIWj3gxbOzGOgS1FnAdEIIwzXr
         mk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L2SUcCfd3jQHd1PtiVd6J+1UNXWZYXb+ve0+z/6ZUJg=;
        b=SoM1zbRSGRiXYV7t0uK6Htds/eGIXxCQNJ98e4VG5IeN0h7X8p3BorP+xSHD4e9bAz
         C2QsR/iseFtFjXrDzeZjaFNnMBBcSwk4TMl4D6Cck0+P2o856euQYRQDyI6N6MyALvMU
         9FM2jBJOM+Zkc7ie4qrnm8IrNtfmaFEspRB40cDo76o/1i0wxn0GobF/nmM88F+SHhb5
         n4Zy8OBImko8MzsM572MIkd+1KynfCTjZtFAdakOvRrklU5qJ3cj+kdp28Sk6somQb20
         eYfdEWzfntikQ9M6pbheo6uXAeq/eKRnFwrOqVxPLNRDLpUBBwzzL2Jm0qqAA+YUk1dR
         CLew==
X-Gm-Message-State: APt69E0pNH15JRdRhjEj2ivPTYgQDu+S/eCVBCwYoUK5sTwQKhi/mipb
        GNtKpFn5slowi2otHHlBuLs=
X-Google-Smtp-Source: ADUXVKLYafKc1ywbQ5Ye5dk0UCDMPi+4V84twb6GYn7Sbq70lg0g9BERyM6hj+bB8Dzv0kt9JDm/uQ==
X-Received: by 2002:a1c:eecd:: with SMTP id j74-v6mr1067208wmi.137.1529062650209;
        Fri, 15 Jun 2018 04:37:30 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c53-v6sm18006950wrg.12.2018.06.15.04.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 04:37:29 -0700 (PDT)
Date:   Fri, 15 Jun 2018 13:37:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180615113728.h7snxhe2juaqvjyx@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <20180615112606.GA3986@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180615112606.GA3986@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 June 2018 13:26:06 Pavel Machek wrote:
> Hi!
> 
> > Hi! With up-to-date thinkpad_acpi.ko driver on ThinkPad T480s I'm seeing
> > a strange behavior of LEDs which are integrated into mic mute (Fn+F4)
> > and mute (Fn+F1) keys.
> > 
> > When thinkpad_acpi.ko is not loaded, then mute key is working fine. When
> > pressed, it correctly generates KEY_MUTE on AT Translated Set 2 keyboard
> > input device and also turn on/of mute led. But when micmute key is
> > pressed then, nothing happen. No key event is reported and also led is
> > not turned on/off.
> > 
> > On the other hand, when thinkpad_acpi.ko is loaded, then both buttons
> > mute and micmute correctly generates input events; mute via AT keyboard
> > and micmute via ThinkPad Extra Buttons. But led is not changed. When
> > thinkpad_acpi.ko is loaded it turn off both leds (mute and micmute) and
> > leds after pressing any of those buttons, leds are not turned on again.
> 
> With thinkpad_acpi.ko loaded, kernel should handle the LEDs, right?

I suppose. But I would be happy even with working "hardware" controlling
(which is working fine when thinkpad_acpi.ko is unloaded).

> Do we have a support for that?

In thinkpad_acpi.c there are some TPACPI_LED_MUTE and TPACPI_LED_MICMUTE
keywords. And also function static int mute_led_on_off(). So some kind
of support there is.

> Do they have directories in /sys/class/leds? What are the triggers there?

No.

$ ll /sys/class/leds
total 0
drwxr-xr-x  2 root root 0 Jun 15 13:27 ./
drwxr-xr-x 51 root root 0 Jun 15 13:27 ../
lrwxrwxrwx  1 root root 0 Jun 15 13:27 input0::capslock -> ../../devices/platform/i8042/serio0/input/input0/input0::capslock/
lrwxrwxrwx  1 root root 0 Jun 15 13:27 input0::numlock -> ../../devices/platform/i8042/serio0/input/input0/input0::numlock/
lrwxrwxrwx  1 root root 0 Jun 15 13:27 input0::scrolllock -> ../../devices/platform/i8042/serio0/input/input0/input0::scrolllock/
lrwxrwxrwx  1 root root 0 Jun 15 13:27 phy0-led -> ../../devices/pci0000:00/0000:00:1c.6/0000:3d:00.0/leds/phy0-led/
lrwxrwxrwx  1 root root 0 Jun 15 13:27 tpacpi::kbd_backlight -> ../../devices/platform/thinkpad_acpi/leds/tpacpi::kbd_backlight/
lrwxrwxrwx  1 root root 0 Jun 15 13:27 tpacpi::power -> ../../devices/platform/thinkpad_acpi/leds/tpacpi::power/
lrwxrwxrwx  1 root root 0 Jun 15 13:27 tpacpi::standby -> ../../devices/platform/thinkpad_acpi/leds/tpacpi::standby/
lrwxrwxrwx  1 root root 0 Jun 15 13:27 tpacpi::thinklight -> ../../devices/platform/thinkpad_acpi/leds/tpacpi::thinklight/
lrwxrwxrwx  1 root root 0 Jun 15 13:27 tpacpi::thinkvantage -> ../../devices/platform/thinkpad_acpi/leds/tpacpi::thinkvantage/

But looks like that thinkpad_acpi.c does not define any struct
led_classdev nor struct tpacpi_led_classdev for MUTE or MICMUTE.

Henrique, any idea why there are no exported led classes for mute and
micmute? And how are suppose to be controlled?

> With thinkpad_acpi.ko unloaded, hardware drives the LEDs, so nothing
> for us to do...

So somehow tell thinkpad_acpi.ko to let hardware control those LEDs when
thinkpad_acpi.ko is loaded?

-- 
Pali Rohár
pali.rohar@gmail.com
