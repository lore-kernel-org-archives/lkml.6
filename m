Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A81C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B494E20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbgR3kSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B494E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeKLFwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:52:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40713 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeKLFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:52:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so5761369lji.7;
        Sun, 11 Nov 2018 12:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dDszItsRtiD12XGE4UD85I07IoLyBorkN/gdUm+VTX0=;
        b=RbgR3kSyIMG/O9om5mBTa3QsHDG8R8NM/Y3dlOtksM/ur1ZA9bsjTEruLe4HYPzmZ8
         3J2ciXJ4/iE30qXA2Omnu2yK82tzRWs/sFnKOjjNubgAEyjiLtcOIE7kEDJC6vf0nXfX
         HNCr5UKno7K9E0dzMjLces4msYSNA7H8+9kTEQHcVlvZ7nbtXYdBfuaOfcYIK6MFODN1
         DYJgvkKBnk1wHSn+2zMNhUt1LLYelxhfIImUM1ihjyZAqc+hE7xMuRFWMyjFMrd/agOc
         MPwheOY4ZiJltVay4pAMvj5DrqKCCTlOq1dTUi7S0QtsLwUz3O8BkZSintHhDZZz4Htp
         0V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dDszItsRtiD12XGE4UD85I07IoLyBorkN/gdUm+VTX0=;
        b=IZQjBTd+5HpvvtOrpJG8hWAlUDFk6oiEBU1HoyEWswQU6VHCFHpB1KDLQMhodEK59G
         PWkziRf2SAenER+/pKYrzBo1vnW/1OROJqPLVRtjg4OjR88sL2bgAtFLiuRzptRtQObt
         xWFlz1shR4VoVLQvyE5DcLrxBYe99evuD0fOSS6jQkFp/Gq0kdkmv12sgLEHjlRrTvwB
         eZmkJwl/HDW3FkKU/ouW6fgC0gpw6ZVQhMeERG2Rknjpe4FSthApSw5PnPbsbjuCdBpm
         I4HG0/DgGR4CRXnkPFu+GxnWgwCK8fKu1qsQHBMrxB535zA1ks8KimSj7FbMHrVv8Pdy
         o11A==
X-Gm-Message-State: AGRZ1gJo4e1WTOwz5rwOqLEh+QbBAJx4LX4OL90qqaM9/PtksZ0xzTXX
        IGxq8roxlLwhgkl8Qp74lvY=
X-Google-Smtp-Source: AJdET5cRLyzciHkhle4V6EEkOD10MLrRPI5KzUf+2Z4cqT2p+WgwCj33EtU//2uHgz4soGSquxCjqQ==
X-Received: by 2002:a2e:4745:: with SMTP id u66-v6mr9944475lja.37.1541966565371;
        Sun, 11 Nov 2018 12:02:45 -0800 (PST)
Received: from [192.168.1.18] (cjk171.neoplus.adsl.tpnet.pl. [83.31.60.171])
        by smtp.gmail.com with ESMTPSA id 65sm2669564lfp.55.2018.11.11.12.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 12:02:44 -0800 (PST)
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
 <20181111113157.GK27666@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <96296b4d-d49e-2b08-4306-196605a9f5dc@gmail.com>
Date:   Sun, 11 Nov 2018 21:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181111113157.GK27666@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thanks for the review.

On 11/11/2018 12:31 PM, Pavel Machek wrote:
> Hi!
> 
>> Add common LED function definitions for use in Device Tree.
>> The function names were extracted from existing dts files
>> after eliminating oddities.
> 
> Thanks for doing this.
> 
>> diff --git a/include/dt-bindings/leds/functions.h b/include/dt-bindings/leds/functions.h
>> new file mode 100644
>> index 0000000..3f94e09
>> --- /dev/null
>> +++ b/include/dt-bindings/leds/functions.h
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
> 
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
> Sounds like one of backlight and backlight_cluster should be deprecated?

I think so.

>> +#define LED_FUNCTION_BEEP "beep"
>> +#define LED_FUNCTION_BLUETOOTH "bluetooth"
>> +#define LED_FUNCTION_BOOT "boot"
>> +#define LED_FUNCTION_BOTTOM "bottom"
> 
> I believe some of these should get comments. For example what does
> "all" and "bottom" LEDs do?

It would be best to ask the author, but for now,
I'd just remove all of "bottom", "up", "left", "right"
etc.

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
> 
> What does this one do?

I'd opt for something like "diagnostics", but this is a blind shot.
Let's remove it then and, and let people add more meaningful
definition in case it is needed.

>> +#define LED_FUNCTION_DISK "disk"
> 
> We have disk, hd, hdd and sata. Deprecate some?

Disk should be the best choice, especially given that we have
identically named trigger.

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
> 
>> +#define LED_FUNCTION_HD "hd"
>> +#define LED_FUNCTION_HDD "hdd"
>> +#define LED_FUNCTION_HDDERR "hdderr"
> 
> Ok, I'll 

Hmm?

> 
>> +#define LED_FUNCTION_HEALTH "health"
>> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
> 
> Sounds same as alive, deprecate alive?

Heartbeat may be designated specifically for registration
for events from the trigger with the same name.

>> +#define LED_FUNCTION_WIFI "wifi"
>> +#define LED_FUNCTION_WIRELESS "wireless"
>> +#define LED_FUNCTION_WLAN "wlan"
> 
> Same as wifi and wireless, I guess, deprecate some?

I'd remove "wireless" and "wlan".

> I'll touch same subject in another email.
> 									Pavel
> 

-- 
Best regards,
Jacek Anaszewski
