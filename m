Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FC12082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPtE53q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FC12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeKXMuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 07:50:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36496 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeKXMuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 07:50:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so4018263pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 18:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RZkyLHU2aNHt1BBAhRCWOt7m4B6ldNg4tf1ZoxGZyf8=;
        b=UPtE53q+bVhPcUVyETHMCLSQcWNU5e8j1lH/hWR6vYEza7QBD0DyIFRwQwAbqJZFM9
         ssxrYilx7/xAkkr+hiv+Snpeg0QWdKQ+2y3wQhn5l/+t/EmG+iYC3Anh971DA/pqVp3W
         YzCZjL7ICwWwCocZ9IxxtHME0InduEjXj2uLo4nHCnkbjASDsvUPcmTaCc3Khy439pNb
         A4dDSe7Yjlz3UagaSXuQowbbDoc6c23CTWacxeHzXAAI317UhoWoio6xiuD4yqgzILRN
         iMpaHYv62p55NsyHBqRauET1z1dCXWwCkuB5Y62nWFo+eMmUMmhaXl9hm2SvbHt6KUNC
         j+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RZkyLHU2aNHt1BBAhRCWOt7m4B6ldNg4tf1ZoxGZyf8=;
        b=QDdsmdTFAWnXgtsyfVzWN7d2cofIVijJfly0MPxiNANaWnR5rHrws6BmzuUiztqBkP
         9PSZ8mUUyLfvjG0uzigJ+LBE4ZAHY2i9XrjWnxxNnGGjDXZI6+LOTayuDEwSeA5rj9b/
         gNIhCeNyaSgKagpjhG91HeHRIeD5Iyf38F/+hpcnxfACc+AvBhHwwc/07nQSUS/Z7im0
         jxrjO7YverVeJsPT5FDVx+Y02bcPzJzkHY+eW3Z9L58uO+Miqa2HMKznxO3G/uxNzRy3
         +sIgyWXdsHYUfceE2rNb9fiqTPR7dktbjSY0NwHAQpQEbIgWnNQEA7a8e00dv4PcuUj3
         f59w==
X-Gm-Message-State: AA+aEWY5VkdHe5ZJi/c97M4WA50XwSfJ/aAr3PSGw435FyDmcv4urrQ3
        KqFQyh8l6wVNnsnVCp44euIoI/G6u6c=
X-Google-Smtp-Source: AFSGD/VpO6piIzhEzizFKEasNJkMAxYYsKSPMZLu2rhmHwvCpBmlWKZebhsa6+arMRacUa/jdF7hXA==
X-Received: by 2002:a63:4745:: with SMTP id w5mr16648121pgk.377.1543025044284;
        Fri, 23 Nov 2018 18:04:04 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id b26sm25598576pfe.91.2018.11.23.18.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:04:03 -0800 (PST)
Subject: Re: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
 <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com>
 <mvmk1l8m5hg.fsf@linux-m68k.org>
Cc:     fthain@telegraphics.com.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, schivers@csc.com.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <9035c015-85ef-6d14-d12c-f1d5002ee49a@gmail.com>
Date:   Sat, 24 Nov 2018 15:03:54 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <mvmk1l8m5hg.fsf@linux-m68k.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 20.11.2018 um 23:02 schrieb Andreas Schwab:
> On Nov 20 2018, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> Yes you already see the same as I see: this chip MK68901 has
>> no less than four timers. I bet the kernel is just using one of them,
>> out of habit.
>
> Note that not all timers can be used freely.  Some of them are hardwired
> to generate the clock for the serial interfaces.

Timer A is used by the DMA sound driver - no workaround possible there.

Timer B is used by the framebuffer driver, but it's used only once to 
reprogram the screen base address at driver init. This one could 
potentially be used after framebuffer init to improve the clocksource 
accuracy.

Timer D is already used to generate timer interrupts used to poll the 
ROM port network card / USB adapters. This timer is initialized early in 
the boot process, which prevents using the MFP UART as serial console 
(something that I hadn't properly considered before). I'll send a patch 
for that. I'll also consider using timer B or timer C interrupts instead 
to poll ROM port hardware.

There are no serial drivers anymore that could use the MFP UART 
hardware, so that point is somewhat moot at present.

Cheers,

	Michael

> Andreas.
>
