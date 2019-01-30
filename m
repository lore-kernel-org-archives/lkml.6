Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B32C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29A02184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIi2HoN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbfA3Thu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:37:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36455 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfA3Tht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:37:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so639591ljk.3;
        Wed, 30 Jan 2019 11:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Elo3/JXipF3FwxvD0Zr6N6lx3RzkXmsEwagJJ0bd9aI=;
        b=CIi2HoN2fz23srqKLqbQ1Ik0qlI45hajHB+o+AOmMU7XtX+D+Qv7XVEMYvza6v7LDV
         wy5ydoJNwZ4pofGnSkcW45vaFkFNGY6CPPjs3Inz11M6q0godmLHi6VC66LRXIEaLOBd
         OXmIzvUisCzHzqWgWTswzerUVzM06MOmDrNCAFFwE5cfTSinjpmoGnaOUftZrX9AL/PD
         PKWJRTX8RW9oXvoWfuGLYm/oVWs8ONM5lOt6muGON3C0Cq2I/8N612TxJWJ3xVLY3WV8
         r9ib/2eYSzSC1wSTlasbIGlNlb0DkDgDW0PkujdvTjoQuRCoJeHtUGp9rytUhzVygCym
         3V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Elo3/JXipF3FwxvD0Zr6N6lx3RzkXmsEwagJJ0bd9aI=;
        b=U7LOoh6nlUXjzZ6jRi5WbhaXR3NOMPzwMxDe2ll5f6V9wDi69h9HBljBi+XbXfPGxv
         yx05U4xu2aY52WzsLdu7prP3TAqGVP3URJz7y8FaFF0B+ggF0NBIP6yQjEVL3n55mV7u
         18V/fuXC8jxEX3Imm4EUa8OxCBQ7Xyowrlxev7R1tmIazr99IMrU9tVzx/KiaYtO30o7
         /oEjjzJtGQ7yMNAWmXt+XyMMgwUSqYnEr1NJdNkybIYs7MIwmpuy/Jyos6yE23tVLVPg
         3hx0IR2Y54iSSOWQcew76nh4lcFQ8/lWpk+DfZHpIn27Rk1nb+C2C5PsBEp7zOS8E9j2
         ur4Q==
X-Gm-Message-State: AJcUukemOr5iZOE9cqerfp38mVDOODG/SHnMyUmg4h4JwtGs2vT8FYdt
        h7Ns7vdnIJW5gU6IvicRACDN2HDs
X-Google-Smtp-Source: ALg8bN7lfpt3tTPPs/4v0UhUBPb5EDXvbK4HtmbKTrECJtxHanQGBdmErk1MCjTvzXkAIKWdng2TGw==
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr26170949lji.30.1548877067218;
        Wed, 30 Jan 2019 11:37:47 -0800 (PST)
Received: from [192.168.1.18] (dks71.neoplus.adsl.tpnet.pl. [83.24.22.71])
        by smtp.gmail.com with ESMTPSA id l3-v6sm425753ljg.21.2019.01.30.11.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:37:46 -0800 (PST)
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190130183005.833-1-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f3792d44-1a43-318b-1b12-d6d69275c3a8@gmail.com>
Date:   Wed, 30 Jan 2019 20:37:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130183005.833-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the RFC.

One vital thing is missing - documentation of brightness file must
be updated to define its semantics for LED multi color class.

Either we need brightness-model file returning only "onoff" option
available, or, for time being, fix the max_brightness for LED multi
color class to 1 (which will map to max intensity level for each color).

Best regards,
Jacek Anaszewski

On 1/30/19 7:30 PM, Dan Murphy wrote:
> Add a documentation of LED Multicolor LED class specific
> sysfs attributes.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   .../ABI/testing/sysfs-class-led-multicolor    | 38 +++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
> new file mode 100644
> index 000000000000..19f8da9b150e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
> @@ -0,0 +1,38 @@
> +What:		/sys/class/leds/<led>/color/sync_enable
> +Date:		January 2019
> +KernelVersion:	5.0
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:	read/write
> +		Writing a 1 to this file will enable the sychronization of all
> +		the defined color LEDs within the LED node.  Writing a 0 to
> +		this file will disable syncing.
> +
> +What:		/sys/class/leds/<led>/color/sync
> +Date:		January 2019
> +KernelVersion:	5.0
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:	write only
> +		Writing a 1 to this file while sync_enable is set to 1 will
> +		synchronize all defined LEDs within the LED node.  All LEDs
> +		defined will be configured based on the brightness that has
> +		been requested.
> +
> +		If sync_enable is set to 0 then writing a 1 to sync has no
> +		affect on the LEDs.
> +
> +What:		/sys/class/leds/<led>/color/<led color>
> +Date:		January 2019
> +KernelVersion:	5.0
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:	read/write
> +		These files are dynamically created based on the colors defined
> +		by the registrar of the class.
> +		The led color(s) can be but not limited to red, green, blue,
> +		white, amber and violet.  If sync is enabled then writing the
> +		brightness value of the LED is deferred until a 1 is
> +		written to /sys/class/leds/<led>/color/sync.  If syncing is
> +		disabled then the LED brightness value will be written
> +		immediately to the LED driver.
> +
> +		The value of the color is from 0 to
> +		/sys/class/leds/<led>/max_brightness.
> 

