Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D18C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17798206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Siqs1CzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfAMQg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 11:36:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39686 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfAMQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 11:36:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so16949386ljh.6;
        Sun, 13 Jan 2019 08:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q3/z1xIwkt41XAHr9AISnbGWpHZIbMdKJRVX3kecyds=;
        b=Siqs1CzX+0ozOj7gew4YdPDFgCRYvgb6Cre0f+GTlrXy+UcVsYYPlSZinoRgkosnqF
         KwZjPpOY+Jm3Abhjim9WZo33LeoeVG6JLQOYamYyC8UPDPvXntfAL+pf9qn1bF2kcvn1
         qtTnNeGq407VGbI8/s/hBtq8Qq5zmHEEb4IqujMiO9dOeNY6sXnvWAgzaIiMy4mCK56n
         NCJTh9esTncbDmZVbuRXZwZzYrsUaTlaz6VVjKDYJnEjY9XP1WacrpdkoHK5emAQBIhc
         Q9iE7352OS+r8c3H9mynRTBaUJRPngxbl8lX1poQvohX7e0VCshAGHxo7sHWGCfnnh8Q
         CMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q3/z1xIwkt41XAHr9AISnbGWpHZIbMdKJRVX3kecyds=;
        b=lmVjHYiHKk448kZXpHrewI3SUGnejff5icwF45D31QWxOoaGr7E39hmhyYvmzBOqgp
         LOCrNBPhphnPC0YEv0D335ecCIBIONuPt2kelPj27XNcr02B1A5BtPudCv4vImENNG5z
         qgqJh7qufYHu7b2MWixRJmzSqTnbnXVb+IBQ31RNLjw8/dp68qzjG9f1/z3kTZ8tUkRh
         80+xaBl4md5mf8rwcOjRSxal2TSeGNNU5cstEMLD/q8YUXp0JZEKvUfFNv+w6VCWmdKS
         exZ2jGd2BzRP2L3hk0K37ymsrdwNJbWRqM0kAudqYp6QYIu+BkOTJaYSpzjW3Sdufy3S
         7mZA==
X-Gm-Message-State: AJcUukcT4qb917JqM/x2wKGjCGwQmADA9kEjhtpKDRSXhCS/KtH3LuhR
        xH/9HpXUhY45o+JyKK+ROrRqnRnz
X-Google-Smtp-Source: ALg8bN7jnzSMh8ng+SKT1db2QLA2VlXSnasNCM0zFwwC6v0WorsnHLOMO2T+U4z8GA/0gdHMEyGQUA==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr12477959lja.24.1547397412072;
        Sun, 13 Jan 2019 08:36:52 -0800 (PST)
Received: from [192.168.1.18] (chf153.neoplus.adsl.tpnet.pl. [83.31.3.153])
        by smtp.gmail.com with ESMTPSA id 67-v6sm17017528ljc.26.2019.01.13.08.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 08:36:51 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd> <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
 <90a2ed79-b437-af14-4538-430d8723cc6b@gmail.com>
 <38daf022-e4e4-799d-4c75-ee851315290d@gmail.com>
 <9ed1c2e6-62ff-6b4c-6b38-48d6176bcd88@gmail.com>
Message-ID: <89bcd492-916e-10a1-d6a2-4f5614112c2c@gmail.com>
Date:   Sun, 13 Jan 2019 17:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9ed1c2e6-62ff-6b4c-6b38-48d6176bcd88@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vesa,

On 1/9/19 7:46 AM, Vesa Jääskeläinen wrote:
> Hi Jacek,
> 
> On 07/01/2019 23.13, Jacek Anaszewski wrote:
>> Hi Vesa,
>>
>> On 1/5/19 1:39 AM, Vesa Jääskeläinen wrote:
>>> Hi Jacek,
>>>
>>> On 04/01/2019 23.37, Jacek Anaszewski wrote:
>>>> But, aside from that hypothetic issue, we need a solution for
>>>> LEDn_BRIGHTNESS feature of lp5024, i.e. setting color intensity
>>>> via a single register write. How would you propose to address that?
>>>
>>> You could model it to something like this in device tree:
>>>
>>> led-module @ <i2c-address> {
>>>      compatible = "lp5024";
>>>
>>>      // There is in hardware setup to use either linear or
>>>      // logarithmic scaling:
>>>      //enable-logarithmic-brightness;
>>>
>>>      led0 {
>>>          // this will create led instance for LED0 in lp5024
>>>          label = "lp-led0";
>>>
>>>          // This specifies LED number within lp5024
>>>          led-index = <0>;   // set output-base as 0*3 == 0
>>>
>>>          element-red {
>>>              // refers to OUT0
>>>              output-offset = <0>;
>>>          };
>>>
>>>          element-green {
>>>              // refers to OUT1
>>>              output-offset = <1>;
>>>          };
>>>
>>>          element-blue {
>>>              // refers to OUT2
>>>              output-offset = <2>;
>>>          };
>>>
>>>      };
>>>
>>>      led1 {
>>>          // this will create led instance for LED1 in lp5024
>>>          label = "lp-led1";
>>>
>>>          // This specifies LED number within lp5024
>>>          led-index = <1>;   // set output-base as 1*3 == 3
>>>
>>>          element-red {
>>>              // refers to OUT3
>>>              output-offset = <0>;
>>>          };
>>>
>>>          element-green {
>>>              // refers to OUT4
>>>              output-offset = <1>;
>>>          };
>>>
>>>          element-blue {
>>>              // refers to OUT5
>>>              output-offset = <2>;
>>>          };
>>>
>>>      };
>>>
>>>      bank-led {
>>>          // this will create led instance for bank leds in lp5024
>>>          label = "lp-bank-led";
>>>
>>>          // configured bank led configuration
>>>          led-index = <2 3 4 5 6 7>;
>>>          // As here is list of led-indices this entry is
>>>          // assumed to be bank configuration. Bank mode is enable
>>>          // for the indices.
>>>
>>>          // set output-base as BANK A
>>>
>>>          element-red {
>>>              // refers to BANK A
>>>              output-offset = <0>;
>>>          };
>>>
>>>          element-green {
>>>              // refers to BANK B
>>>              output-offset = <1>;
>>>          };
>>>
>>>          element-blue {
>>>              // refers to BANK C
>>>              output-offset = <2>;
>>>          };
>>>      };
>>> };
>>>
>>> This would then create three led instances and each led instance has 
>>> brightness setting and that goes straight to hardware.
>>>
>>> If one would want to override hardware control for brightness then I 
>>> suppose you would define in led node something like:
>>>
>>>      brightness-model = "hsl"
>>>
>>> This would then pick red, green and blue elements for hsl 
>>> calculations and others color elements for linear. LED specific 
>>> hardware brightness would then be either 0 or 0xFF depending if all 
>>> of LED color elements are zero or not.
>>>
>>> Would that kind of model work?
>>
>> I'd prefer to have single RGB LED device. And your DT design
>> is unnecessarily complex and a bit confusing.
> 
> As this chip series is kinda designed for N x RGB LED's my idea was that 
> if from user space point of view we model it as N times of individual 
> RGB LED instances that may not even have anything to do with together. 
> Eg. could be used for different purposes and such.

Actually the only differences between your DT design and that
initially proposed by Dan are element-* nodes describing
IOUT -> color mapping.

I am not sure if LEDn_BRIGHTNESS feature would work as intended
when colors are not assigned to IOUTs in the order shown on the
Figure 14. in the data sheet. I'm afraid that we would be changing
hue as well (sticking to the HSV nomenclature). Let's not bother with
covering arrangements not being in line with the data sheet
recommendations.

Of course the element-color nodes will be necessary for leds-pwm,
like in your github example.

> And in device tree one would define logical connections for the leds so 
> they would be mapped logically correct to user space.
> 
> If one would define it like:
> 
> led1 {
>      // this will create led instance for LED1 in lp5024
>      label = "lp-led1";
> 
>      // This specifies LED number within lp5024
>      led-sources = <1>;
> };
> (note changed led-index to led-sources as that is what Pavel had and 
> preferred)
> 
> We could assume that it is RGB led in this driver's case and create it 
> automatically with elements "red", "green", and "blue". And this could 
> then be mapped automatically to HSL color elements or what ever the 
> model would be.
> 
> If you would model it differently in your hardware design then you would 
> need to define more device tree nodes. Eg. if your order of LEDs would 
> not be red, green, blue. Or if you would have non-RGB led(s) in there.
> 
>> Also, you provided scarce information about sysfs interface.
>> It would be nice to see the sequence of commands.
> 
> In this case it could be:
> 
> # Note: Updated color to value array model.
> 
> $ ls /sys/class/leds
> lp-led0    lp-led1    lp-bank-led
> 
> $ ls /sys/class/leds/lp-led0
> brightness    color
> 
> $ ls /sys/class/leds/lp-led1
> brightness    color
> 
> $ ls /sys/class/leds/lp-bank-led
> brightness    color
> 
> # Idea of above is that as brightness is for triplet:
> #   OUT(LED*3 + 0), OUT(LED*3 + 1), OUT(LED*3 + 2),
> # Then if we model it like RGB LED then brightness would automatically
> # map to correct OUTputs and be grouped from user space point of view
> # logically in correct place.
> 
> # set first led to red
> echo "255 0 0" > /sys/class/leds/lp-led0/color
> 
> # set second led to green
> echo "0 255 0" > /sys/class/leds/lp-led1/color
> 
> # set bank led to blue
> echo "0 0 255" > /sys/class/leds/lp-bank-led/color
> 
> # Set hardware brightness control to middle
> echo "128" > /sys/class/leds/lp-bank-led/brightness
> 
> # If we would have software controlled virtual brightness enabled for
> # particular led classdev then there would be some math in either user
> # or in kernel space.
> 
> Thanks,
> Vesa Jääskeläinen
> 

-- 
Best regards,
Jacek Anaszewski
