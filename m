Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBF6ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD9B20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJniqlJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD9B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeKIGkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:40:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46954 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeKIGkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:40:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so10691649lfc.13;
        Thu, 08 Nov 2018 13:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ZrLDzr5UDASDfWeU+H+M0TKVQA0kGb6EIkO6ezvVzQ=;
        b=YJniqlJn07z9cBLODktODaNpEYqjB7/u7Mm0+gXE0GW8h/KSbSEwkKGRRyqHeGVroz
         ey1Rx8A5EtIYhDL0LIH8wM1n5dCN7SBfa/I4TwlegVZZ9naIDn6/PY4PrHIjIwx4IYjg
         K3rB1IQzD0wheYdE5rhS3z8JHGjOtNUF94r0CggsJA5WC1mxvDnh1VSezZmLyb7dMv2X
         lOBCKWnz2SU9ggWa9WUGpXh+gJvKbPs6J79Dx26WZyHN5uMCuBZ7CV3wntk1WQg45vK4
         1iTRO4sV7F3ptW4rso2gPvCEh6Z4zn0361lbqTQTa2xCdohKpsHVzOAN72hCcWzEEAwe
         wjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ZrLDzr5UDASDfWeU+H+M0TKVQA0kGb6EIkO6ezvVzQ=;
        b=nkoZOgSLJIxriYKiDORjIbijS84R4RKTiPkIeQl/a0v/gID+Po8lpmuVGTTwQTHvR3
         pL8Jq2QTI4Vqzhj51s0Lh276Khu5za5ovbhqWNMXWLcUOoNWT2tzrVFw1cAzxaeFpZos
         coIzS3vcqzIQ+//HZXW/1NC/8SnV1i35pfY8PfRHIhkmfLB93zTxisGEMh5um4jQ278c
         02YJsvFq8fNCrkzyL5/uG6Ph8zUq4YNcxlA5zSxmOD2Pz/1TbOzFE5ZahRf/IXZYZv51
         7Lbd2KXkG8UTEQUhcW9E8yOZtgJo+PIXmtVD/md7U4jlMDGHIp+fENAZDIzHy/Gd0RF1
         5Kmw==
X-Gm-Message-State: AGRZ1gJbl/7vm34GlCcvwAyiMci2YGGtRWVg04Jwy8d4d2hNAOirtqdd
        Rys1sWeUGed17GMu57FSKoQ=
X-Google-Smtp-Source: AJdET5eoQZ6SMqJ2Ig2GWi2H6yQGxpxPf1LNilYQgAM+KWYrk2E/JiEMxPlbJ3U38YyrhgNREd6gMA==
X-Received: by 2002:a19:280f:: with SMTP id o15mr3635426lfo.0.1541711003805;
        Thu, 08 Nov 2018 13:03:23 -0800 (PST)
Received: from [192.168.1.18] (dkl219.neoplus.adsl.tpnet.pl. [83.24.15.219])
        by smtp.gmail.com with ESMTPSA id m63-v6sm1012542lje.81.2018.11.08.13.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 13:03:23 -0800 (PST)
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
To:     Rob Herring <robh@kernel.org>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>, xiaotong.lu@spreadtrum.com
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
 <CAL_Jsq+NNx-oCY-RtG0F=WKknF3OD52sgtgVgFPz1mrYQbaeKw@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9a0027bf-0bb9-f11a-54ac-3c4d4b078fe2@gmail.com>
Date:   Thu, 8 Nov 2018 22:03:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+NNx-oCY-RtG0F=WKknF3OD52sgtgVgFPz1mrYQbaeKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

On 11/08/2018 04:13 PM, Rob Herring wrote:
> On Tue, Nov 6, 2018 at 4:07 PM Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>>
>> Add common LED function definitions for use in Device Tree.
>> The function names were extracted from existing dts files
>> after eliminating oddities.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Simon Shields <simon@lineageos.org>
>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> ---
>>  include/dt-bindings/leds/functions.h | 101 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>>  create mode 100644 include/dt-bindings/leds/functions.h
>>
>> diff --git a/include/dt-bindings/leds/functions.h b/include/dt-bindings/leds/functions.h
>> new file mode 100644
>> index 0000000..3f94e09
>> --- /dev/null
>> +++ b/include/dt-bindings/leds/functions.h
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#define LED_FUNCTION_2G "2g"
>> +#define LED_FUNCTION_ACTIVITY "activity"
>> +#define LED_FUNCTION_ADSL "adsl"
>> +#define LED_FUNCTION_ALARM "alarm"
>> +#define LED_FUNCTION_ALIVE "alive"
>> +#define LED_FUNCTION_ALL "all"
>> +#define LED_FUNCTION_APP "app"
>> +#define LED_FUNCTION_AUX "aux"
>> +#define LED_FUNCTION_BACKUP "backup"
>> +#define LED_FUNCTION_BACKLIGHT "backlight"
>> +#define LED_FUNCTION_BACKLIGHT_CLUSTER "backlight_cluster"
> 
> I'd prefer we go further and only define 1 endorsed function name.
> Backlight, disk, network, fault/error all seem to have a few

OK, I'll try to remove semantically akin duplicates.

> duplicates. I'm also thinking the functions make linux,default-trigger
> redundant in some cases.

Yes, this is tempting. Needs more thorough analysis, though.

> I'm not a huge fan of making these defines, but it does make it
> perfectly clear if folks use standard names or not.
> 
>> +#define LED_FUNCTION_BEEP "beep"
>> +#define LED_FUNCTION_BLUETOOTH "bluetooth"
>> +#define LED_FUNCTION_BOOT "boot"
>> +#define LED_FUNCTION_BOTTOM "bottom"
>> +#define LED_FUNCTION_BRICK_STATUS "brick-status"
>> +#define LED_FUNCTION_CEL "cel"
>> +#define LED_FUNCTION_CEL_PWR "cel-pwr"
>> +#define LED_FUNCTION_CEL_RESET "cel-reset"
>> +#define LED_FUNCTION_CHRG "chrg"
>> +#define LED_FUNCTION_COM "com"
>> +#define LED_FUNCTION_COPY "copy"
>> +#define LED_FUNCTION_CPU "cpu"
>> +#define LED_FUNCTION_DEBUG "debug"
>> +#define LED_FUNCTION_DIA "dia"
>> +#define LED_FUNCTION_DISK "disk"
>> +#define LED_FUNCTION_DISPLAY_CLUSTER "display_cluster"
>> +#define LED_FUNCTION_DOWN "down"
>> +#define LED_FUNCTION_DSL "dsl"
>> +#define LED_FUNCTION_ENOCEAN "enocean"
>> +#define LED_FUNCTION_ENTER "enter"
>> +#define LED_FUNCTION_ERROR "error"
>> +#define LED_FUNCTION_ESATA "esata"
>> +#define LED_FUNCTION_ETHERNET_STATUS "ethernet-status"
>> +#define LED_FUNCTION_FAIL "fail"
>> +#define LED_FUNCTION_FAULT "fault"
>> +#define LED_FUNCTION_FLASH "flash"
>> +#define LED_FUNCTION_FRONT "front"
>> +#define LED_FUNCTION_FUNC "func"
>> +#define LED_FUNCTION_GPIO "gpio"
>> +#define LED_FUNCTION_GSM "gsm"
>> +#define LED_FUNCTION_HD "hd"
>> +#define LED_FUNCTION_HDD "hdd"
>> +#define LED_FUNCTION_HDDERR "hdderr"
>> +#define LED_FUNCTION_HEALTH "health"
>> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
>> +#define LED_FUNCTION_HOME "home"
>> +#define LED_FUNCTION_INDICATOR "indicator"
>> +#define LED_FUNCTION_INET "inet"
>> +#define LED_FUNCTION_INFO "info"
>> +#define LED_FUNCTION_INTERNET "internet"
>> +#define LED_FUNCTION_KEYPAD "keypad"
>> +#define LED_FUNCTION_LAN "lan"
>> +#define LED_FUNCTION_LEFT "left"
>> +#define LED_FUNCTION_LIVE "live"
>> +#define LED_FUNCTION_MICROSD "microsd"
>> +#define LED_FUNCTION_MISC "misc"
>> +#define LED_FUNCTION_MMC "mmc"
>> +#define LED_FUNCTION_NAND "nand"
>> +#define LED_FUNCTION_NETWORK "network"
>> +#define LED_FUNCTION_ON "on"
>> +#define LED_FUNCTION_OS "os"
>> +#define LED_FUNCTION_PANEL "panel"
>> +#define LED_FUNCTION_PMU_STAT "pmu_stat"
>> +#define LED_FUNCTION_PROG "prog"
>> +#define LED_FUNCTION_PROGRAMMING "programming"
>> +#define LED_FUNCTION_PULSE "pulse"
>> +#define LED_FUNCTION_PWR "pwr"
>> +#define LED_FUNCTION_QSS "qss"
>> +#define LED_FUNCTION_REAR "rear"
>> +#define LED_FUNCTION_REBUILD "rebuild"
>> +#define LED_FUNCTION_RIGHT "right"
>> +#define LED_FUNCTION_ROUTER "router"
>> +#define LED_FUNCTION_RS "rs"
>> +#define LED_FUNCTION_RX "rx"
>> +#define LED_FUNCTION_SATA "sata"
>> +#define LED_FUNCTION_SD "sd"
>> +#define LED_FUNCTION_SLEEP "sleep"
>> +#define LED_FUNCTION_STANDBY "standby"
>> +#define LED_FUNCTION_STATUS "status"
>> +#define LED_FUNCTION_SW "sw"
>> +#define LED_FUNCTION_SWRDY "swrdy"
>> +#define LED_FUNCTION_SYSTEM "system"
>> +#define LED_FUNCTION_TEL "tel"
>> +#define LED_FUNCTION_TOP "top"
>> +#define LED_FUNCTION_TORCH "torch"
>> +#define LED_FUNCTION_TV "tv"
>> +#define LED_FUNCTION_TX "tx"
>> +#define LED_FUNCTION_UP "up"
>> +#define LED_FUNCTION_USB "usb"
>> +#define LED_FUNCTION_USB_COPY "usb_copy"
>> +#define LED_FUNCTION_USER "user"
>> +#define LED_FUNCTION_USR "usr"
>> +#define LED_FUNCTION_WAN "wan"
>> +#define LED_FUNCTION_WIFI "wifi"
>> +#define LED_FUNCTION_WIRELESS "wireless"
>> +#define LED_FUNCTION_WLAN "wlan"
>> +#define LED_FUNCTION_WMODE "wmode"
>> +#define LED_FUNCTION_WPS "wps"
>> --
>> 2.1.4
>>
> 

-- 
Best regards,
Jacek Anaszewski
