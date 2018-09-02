Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF1BC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6411F20862
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbMPCj62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6411F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeIBVGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 17:06:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41731 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeIBVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 17:06:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so7525560pgv.8;
        Sun, 02 Sep 2018 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HJo10hAbdSnGmW/9lZut1t871eKQQQ+SyvkQnds/Lco=;
        b=nbMPCj62SHUbrxVlXEy80GrEhcLpgvNhOdWpgqK7g6+PM4zrOwTFlQDHbVLp0qUqsE
         tXWx4lEris5p6FJS+Mvlmyc/HLtIX4YsURSJM4PwXd7Ad7VWVv020GMsbTsXLxlpR6k0
         EMJ4zfU0y4fenPWGYb/6lXSg76nEtMK4Bs3SLpPm+IaXzafcgn5GJxR4U7DNtuwTneHo
         wLRMznP6QwIyb0icpVIdCUaw0Y+YrOkNBEsaDCrpMRvObnS0IyHqi7n01urjpQmIlwT5
         1xleTLUogTtqqxGhpboQR5LG/gRt0G32kfJylOCIR1wAlWfNoNR17kKOMUc4xXmQpbFi
         Fc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HJo10hAbdSnGmW/9lZut1t871eKQQQ+SyvkQnds/Lco=;
        b=g+HxvzNtrgwccbDbb+cJp2wiud+6+hNstwRSUCsEyfMc4uRi0eNkx1x+nV+LzkcGP8
         6EDzk9BGC8Vh/TAYjo5h57/01X1OtH1az7rENrQMqLCj57M23vvtWrqGPRkZWN+UGNRf
         h0d5m++LHzNmspB3co8R7QR65JRIT5zjUe5pgtVjt6ahtgfoRUX5/o0Lar2PgA8paBNW
         ZohAlKl4IBk/ewz8dai0OZmdH8hrLmQe4ouHsNPvwJL0Tjr6l5VVQXAzRtk5+7wfNn9I
         1GjCfYmrqmDG2k4IES7p/YD2cGlMayPTMj+su7LZsXWajVPU8CG2wDoSedhNJoIPbaMQ
         SSmw==
X-Gm-Message-State: APzg51CbP/0xN7Cwy4HxNxpeF0QKLX8I1+g0yEQ5/mXYZIhyMQOEtsO+
        eL0M/x/veIRKDnzNwPy4qOY=
X-Google-Smtp-Source: ANB0VdaMPGJ2E4zy6bCOmdkVCOQJ/2kcKgvgQ99TiFTOsu+S2FA0hbnHVyOUEpzMBrqb1pax+/NSLQ==
X-Received: by 2002:a63:d645:: with SMTP id d5-v6mr22796487pgj.450.1535906997782;
        Sun, 02 Sep 2018 09:49:57 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f75-v6sm27492533pfk.85.2018.09.02.09.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 09:49:56 -0700 (PDT)
Subject: Re: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Eric Anholt <eric@anholt.net>,
        Phil Elwell <phil@raspberrypi.org>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, serge@raspberrypi.org
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
 <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
 <67224834.51159.1535905604770@email.1und1.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net>
Date:   Sun, 2 Sep 2018 09:49:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <67224834.51159.1535905604770@email.1und1.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 09:26 AM, Stefan Wahren wrote:
> Hi Guenter,
> 
>> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 16:23 geschrieben:
>>
>>
>> On 09/02/2018 04:20 AM, Stefan Wahren wrote:
>>> This series is an early stage of the hwmon driver for the fan on the
>>> Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
>>> Device Tree Overlay.
>>>
>>> Changes by Stefan based on [2]:
>>> - reformat the downstream patches for submission
>>> - drop reboot notification
>>> - fix remaining checkpatch issues
>>> - add COMPILE_TEST to Kconfig
>>>
>>> The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
>>> i see two options:
>>>
>>> 1) integrate the driver function into the pwm-fan driver (new compatible)
>>> 2) implement the core function as a PWM driver and use the pwm-fan driver on top
>>>
>>
>> I don't really see the point of thise driver. Why not implement either of those ?
> 
> i'm not sure about your question. Since the fan is placed over the SoC, the fan should takes care of the SoC temperature. AFAIK the firmware should have exclusive access to the I2C. So why we need this mailbox interface instead of a I2C driver.
> 

The driver sets pwm values. The pwm-fan driver sets pwm values. A pwm driver
sets pwm values. The pwm-fan driver uses a pwm driver to set pwm values.
You appear to be arguing that the pwm-fan driver for Rpi is different than
a pwm-fan driver for all other hardware and should _not_ use a pwm driver
to set pwm values.

As you don't understand my question, I don't understand your rationale either.
I will require detailed explanations why 2) is not feasible, and why 1) is not
feasible either. Until then, NACK.

Guenter

>> 2) sounds like a perfect fit to me.
>>
>> Guenter
>>
>>> [1] - https://www.raspberrypi.org/products/poe-hat/
>>> [2] - https://github.com/raspberrypi/linux/commit/0f937c8dc3201ebffa6c617c616fd7c65db65959
>>>
>>> Serge Schneider (2):
>>>     dt-bindings: hwmon: Add RPi PoE HAT documentation
>>>     hwmon: Add RPi PoE HAT fan driver
>>>
>>>    .../devicetree/bindings/hwmon/rpi-poe-fan.txt      |  55 +++
>>>    Documentation/hwmon/rpi-poe-fan                    |  15 +
>>>    drivers/hwmon/Kconfig                              |  11 +
>>>    drivers/hwmon/Makefile                             |   1 +
>>>    drivers/hwmon/rpi-poe-fan.c                        | 414 +++++++++++++++++++++
>>>    include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>>>    6 files changed, 498 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt
>>>    create mode 100644 Documentation/hwmon/rpi-poe-fan
>>>    create mode 100644 drivers/hwmon/rpi-poe-fan.c
>>>
>>
> 

