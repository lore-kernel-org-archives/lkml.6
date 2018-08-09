Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3061C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F70C21E97
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwd21ZlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F70C21E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbeHIRNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:13:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40875 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbeHIRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:13:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so5388226wrs.7;
        Thu, 09 Aug 2018 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rVY2CntUZxwS+MczehAbrCGXxypI9JwNkpkRgFA2fbA=;
        b=dwd21ZlLs6rfP1gi1YT1/juD/Dvi0/zIE6XfNwm742+wKK4mcLr2pheXBY4LivEyKR
         iXjvXCFJMGoxDwaJF2K2Udrbl3UINcFJwcjyZsYQ4j9IHCZRjQR2WmBRKXR1caLc6raG
         O0opxURCTqR5omMrbIWPN8Y2+TtnSgUDPEsgKei4DdP9P3B4SSp3mhk1wqua66hWW+Xj
         JzYUqF2N3RspRnxWOQBWIML38ZdTCn4uTHtN3tMd9J6Tx6CDCafXQiD8tRxo1Frdbl+G
         MlrOk1SOyrmEdQEQNqikVLyuqtWUpYvJNqfThEgHk++h52f7oy9dSQ5NJd4ivEGGYNvc
         lWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rVY2CntUZxwS+MczehAbrCGXxypI9JwNkpkRgFA2fbA=;
        b=rGoKrFW0NvLHRvtbt258aN8CJ6rpnjFoSi8OndTl9e9W9/LL/4FQ/d1h+anZpj/SrT
         Oa1uYrXxJmY5RRqez0hjYUUaDj62SHSZ1L/gk1rdUKilaUBQiIyMRoCtE2CBBI6QNDt4
         o6b3n9PFFhFu1cqZa/CsPLv+7jB+SPWOFIGxEugJTDMRrKT7peRPrRqXX65RR3R16/xu
         kMN9jGqnQ7JG+4ndGVdArmsZ71bA5t8+YKXVnsmeZoi5JSE5ARO5MtHbnkusqxrU22hJ
         6ErYX2w4BhIF2dUTeUMVNpbLlggrkLC4Ncjq4yMfkas6FMd4to94b10alwRhf5UYT/lt
         2e6A==
X-Gm-Message-State: AOUpUlHXzXjEzBWZzE3MD/SMwcJt/QzKlXuvLg56L1tVCx/4X2U7qmde
        Gh+NMJ2q9NbCWp3aG+xDEDH52TkR
X-Google-Smtp-Source: AA+uWPyBSuCQrKloqf4etgLKa1gBX1jgrqJVEaio5lYgpqlmRugWu1r80j9Rbuf0KhbKCV5FlA4oig==
X-Received: by 2002:adf:ec41:: with SMTP id w1-v6mr1691387wrn.128.1533826106818;
        Thu, 09 Aug 2018 07:48:26 -0700 (PDT)
Received: from [192.168.1.18] (blc170.neoplus.adsl.tpnet.pl. [83.28.196.170])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4736582wmc.38.2018.08.09.07.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 07:48:25 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd> <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd> <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
 <53691469-4554-42a8-c182-762c1a3939b7@gmail.com>
 <01bbf05a-8e5e-d3ce-857a-ac5c6efb779c@ti.com>
 <683f9e60-9ad8-93d8-e4ed-dbfdae78c307@gmail.com>
 <c028fb73-8df5-9402-d96e-c907199356ed@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <04c37241-78c6-529f-4c07-db6f16b4f92a@gmail.com>
Date:   Thu, 9 Aug 2018 16:48:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c028fb73-8df5-9402-d96e-c907199356ed@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 08/09/2018 03:30 PM, Dan Murphy wrote:
> Jacek and Pavel
> 
> On 08/09/2018 07:09 AM, Jacek Anaszewski wrote:
>> Dan,
>>
>> On 08/08/2018 11:45 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 08/08/2018 04:09 PM, Jacek Anaszewski wrote:
>>>> Hi Dan,
>>>>
>>>> On 08/08/2018 11:04 PM, Dan Murphy wrote:
>>>>> On 08/08/2018 04:02 PM, Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>>>>> +	- #size-cells : 0
>>>>>>>>> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
>>>>>>>>> +		0 - All HVLED outputs are controlled by bank A
>>>>>>>>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
>>>>>>>>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
>>>>>>>>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
>>>>>>>>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
>>>>>>>>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
>>>>>>>>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
>>>>>>>>> +		7 - All HVLED outputs are controlled by bank B
>>>>>>>>
>>>>>>>> This is quite long way to describe a bitmask, no? Could we make
>>>>>>>> it so that control-bank-cfg is not needed?
>>>>>>>
>>>>>>> The problem we have here is there is a potential to control
>>>>>>> 3 different LED string but only 2 sinks.  So control bank A can control 2 LED strings and control
>>>>>>> bank b can control 1 LED string.  
>>>>>>>
>>>>>>
>>>>>> Can we forget about the LED strings, and just expose the sinks as
>>>>>> Linux LED devices?
>>>>>
>>>>> 2 sinks 3 LED strings.  How do you know which LED string is which and what bank it belongs
>>>>> to when setting the brightness.  Each Bank has a separate register for brightness control.
>>>>
>>>> Just a blind shot, without going into details - could you please check
>>>> if led-sources property documented in the common LED bindings couldn't
>>>> help here?
>>>>
>>>
>>> I could change the name to led-sources.  But this part does not really follow the 1 output to a
>>> 1 LED string topology.
>>
>> led-sources was designed for describing the topology where one LED can
>> be connected to more then one output, see bindings of
>> max77693-led (in Documentation/devicetree/bindings/mfd/max77693.txt).
>>
>> Here the topology is a bit different - more than one LED (string) can be
>> connected to a single bank, but this is accomplished inside the chip.
>> Logically LEDs configured that way can be treated as a single LED
>> (string) connected to two outputs, and what follows they should be
>> described by a single DT child node.
>>
>> led-sources will fit very well for this purpose. You could do
>> the following mapping:
>>
>> 0 - HVLED1
>> 1 - HVLED2
>> 2 - HVLED3
>>
>> Then, in the child DT nodes you would use these identifiers to describe
>> the topology:
>>
>> Following node would describe strings connected to the outputs
>> HVLED1 and HVLED2 controlled by bank A.
>>
>> led@0 {
>> 	reg = <0>;
>> 	led-sources = <0>. <1>;
>> 	label = "white:first_backlight_cluster";
>> 	linux,default-trigger = "backlight";
>> };
>>
>>
>> IOW I agree with Pavel, but I propose to use already documented common
>> DT LED property.
>>
> 
> I agree to use the led-sources but I still believe this approach may be confusing to other sw devs
> and will lead to configuration issues by users.
> 
> This implementation requires the sw dev to know which strings are controlled by which bank.
> And this method may produce a misconfiguration like something below where HVLED2 is declared in
> both bank A and bank B
> 
> led@0 {
> 	reg = <0>;
> 	led-sources = <0>. <1>;
> 	label = "white:first_backlight_cluster";
> 	linux,default-trigger = "backlight";
> };
> 
> led@1 {
> 	reg = <1>;
> 	led-sources = <1>. <2>;
> 	label = "white:keypad_cluster";
> 	linux,default-trigger = "backlight";
> };
> 
> The driver will need to be intelligent and declare a miss configuration on the above.
> Not saying this cannot be done but I am not sure why we want to add all of these extra LoC and intelligence
> in the kernel driver.

It is better do add some complexity to the driver than to the
user configurable settings like DT. Besides - you will only need to
check if given led-source is already taken by another node.

> The driver cannot make assumptions on the intention.  And the device tree documentation will need to
> pretty much need a lengthy explanation on how to configure the child nodes.

Some description will be needed for sure, but I don't expect it
to be overwhelmingly lengthy.

> The implementation I suggested removes that ambiguity.  It is a simple integer that is written to the device
> as part of the device configuration, which the config is a setting for the device.

Your control-bank-cfg seemed like having much room for improvement,
and it would for sure raise questions on why it was implemented that
way. Documenting all available combinations of the configuration is
seldom the best solution. It often obscures the issue.

> The child nodes denote which bank the exposed LED node will control.  Removing any need
> for the sw developers new or old to know the specific device configurations.

In your bindings device configuration is scattered among global
control-bank-cfg property and child node's reg property.
In my proposal each child node contains all the needed configuration,
also in the form of two properties - led-sources and reg. IMHO having
all the LED class device related configuration in one place simplifies
the analysis.

-- 
Best regards,
Jacek Anaszewski
