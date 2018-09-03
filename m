Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC548C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4148220856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+My7R7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4148220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeICWx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:53:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37579 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeICWx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:53:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id f1-v6so502391plt.4;
        Mon, 03 Sep 2018 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0jZJ0JBmB3TAdm0LG7EBuyxLYRy3bCh9BozrnB1RkrQ=;
        b=O+My7R7MIRDAWHFtXXqgVvN5UKs9aoRSyasgctFJY7JaDJ92yXmqVvS22a2VB6yXlT
         iMlpuBJKxruKos7OLaYkz4e7T5XFknXfL58GBhHnTaRQ0uwXjT45RH+eSG3pti750orV
         7/apeLJ+HQ+MncbChOTgiCotQYduOVuKAaAEUgxkaPR5ece3KTXlO+YtyB0OxZUHAf+1
         X/BAzf6UB7ED5dw54eMGQZABacH5rQaVGycnlBRQu1E6wyUfaOhrl97grEUfRrNO0HZ7
         Cr8nEvgHlKqLJMtUorNo2gKMkV0O5BMQH3U7vNWGZ9qH8sSDpbcyWzfcbzdfq97YJCSw
         97FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0jZJ0JBmB3TAdm0LG7EBuyxLYRy3bCh9BozrnB1RkrQ=;
        b=NJBEtJiCi0HnEDvncvo1MZOPzJLE6SGzw5eyVZPV0c2IPPXo5B+4ggjSGCPSlYITJs
         8yIMsSrhzLeCZR33KhrgZ/bwj1jRX/UftbJruNjieDq3Lgz+1i5G6P6g5Tr7g8a0HhvY
         uFJTjS+bJIIykz9sAeNNcoDhp9rzKYu5IirfJX6NnGcjQvjaNxLLRY6hK0sGEnosyp4m
         ngkovGFm5CjgBOjQ7PLm6qVSDVC6j0dubF8txrTuo3NsaO9FEI+Zryow82rm0YjK6+JW
         +dleKwBUQPBtYKFAykcc5AmO6/ttuiLcHWyKk7vp9B0TzKPXtCZLBItYj0Hispq06zVN
         EBCg==
X-Gm-Message-State: APzg51AKPLvi//cM1WYH46vWvDBZMcxcZl9BnQ2WVzXkV4irAHQLvaBZ
        bisojkDtb3ERceTYuF2Y4MY=
X-Google-Smtp-Source: ANB0VdYoZPjofX7sy8irBq163ttqsfKO4q8IX0movD4Sc4zKC8iKIv/Ye+O/sX7L3SCdXelN2j1H7Q==
X-Received: by 2002:a17:902:7586:: with SMTP id j6-v6mr29425119pll.295.1535999522705;
        Mon, 03 Sep 2018 11:32:02 -0700 (PDT)
Received: from [10.10.115.170] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id g15-v6sm38244650pfg.98.2018.09.03.11.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:32:01 -0700 (PDT)
Subject: Re: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@raspberrypi.org,
        linux-rpi-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Elwell <phil@raspberrypi.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
 <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
 <67224834.51159.1535905604770@email.1und1.de>
 <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net>
 <829194253.51526.1535908415057@email.1und1.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <642d46f3-7c1d-2b97-5d49-8772c75be530@gmail.com>
Date:   Mon, 3 Sep 2018 11:31:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <829194253.51526.1535908415057@email.1und1.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/2018 10:13 AM, Stefan Wahren wrote:
> Hi Guenter,
> 
>> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 18:49 geschrieben:
>>
>>
>> On 09/02/2018 09:26 AM, Stefan Wahren wrote:
>>> Hi Guenter,
>>>
>>>> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 16:23 geschrieben:
>>>>
>>>>
>>>> On 09/02/2018 04:20 AM, Stefan Wahren wrote:
>>>>> This series is an early stage of the hwmon driver for the fan on the
>>>>> Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
>>>>> Device Tree Overlay.
>>>>>
>>>>> Changes by Stefan based on [2]:
>>>>> - reformat the downstream patches for submission
>>>>> - drop reboot notification
>>>>> - fix remaining checkpatch issues
>>>>> - add COMPILE_TEST to Kconfig
>>>>>
>>>>> The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
>>>>> i see two options:
>>>>>
>>>>> 1) integrate the driver function into the pwm-fan driver (new compatible)
>>>>> 2) implement the core function as a PWM driver and use the pwm-fan driver on top
>>>>>
>>>>
>>>> I don't really see the point of thise driver. Why not implement either of those ?
>>>
>>> i'm not sure about your question. Since the fan is placed over the SoC, the fan should takes care of the SoC temperature. AFAIK the firmware should have exclusive access to the I2C. So why we need this mailbox interface instead of a I2C driver.
>>>
>>
>> The driver sets pwm values. The pwm-fan driver sets pwm values. A pwm driver
>> sets pwm values. The pwm-fan driver uses a pwm driver to set pwm values.
>> You appear to be arguing that the pwm-fan driver for Rpi is different than
>> a pwm-fan driver for all other hardware and should _not_ use a pwm driver
>> to set pwm values.
> 
> thanks for your explanation. Now i think i understand and sorry for the confusion. We need a driver which translate the pwm values into the mailbox properties. "My" RFC series is only a starting point (not intended for merge and not an option) for a discussion and i'm perfectly fine with 2).
> Both options would be feasible in general. I only wanted to know your opinion before i start to implement one of them.

Is not there a way to expose the PWM pins directly to the kernel instead 
of going through the firmware to do that for us? I am just asking 
because sometimes this appears to be possible, guess not in this case?
-- 
Florian
