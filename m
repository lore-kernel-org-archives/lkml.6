Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7E3C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB1F21D08
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boaxsOQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB1F21D08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeHIOei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:34:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55452 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:34:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so6121128wmc.5;
        Thu, 09 Aug 2018 05:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KLuTkwBa9CGD+7zt4I3wty3YunbIAitEBdzY+OSbGM=;
        b=boaxsOQgO0oDjrzVN/97whNVyP8GtMvSyJIPOMo5W3cvhlv3o65pruAsvHkK2w5mbw
         4qDUGBD2RRL08bq564gyvv6DHbXZWStW79X8N9fEfK/2lu992ELtQfLoSmyTT5LStGko
         Jm3AfXuAzrstPpnb3Fl8Kg8NX00AvG8IT9g5eBsuQ20Zgzofd55p7zNDmmeMSVx4qApB
         f/RIp97mPkFdEqUlkM9/hvSHFLOBuH+rBV8EOytbk0Ku9sqE/FNcXAmRjkTPajRgF3A8
         sxsdWSUcTKxY2Tu+OcmXq4RzfiZmK+WfLNFdti6EUGiQqY8zTHQTjrTx34NOi81dJ7aU
         fq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KLuTkwBa9CGD+7zt4I3wty3YunbIAitEBdzY+OSbGM=;
        b=iwdcuY/4Im/p/emGRnz/eSzgj30dDsYkUbbwokqFICUnqt7/BgZvNxe5AoMTILesJc
         Tj6COjtYYnJkt8AKxyqTLKmnYFXFbw34sfSEwp47OhD0sdVUCJtA3KhOrv1eZyj9nkyH
         iEweqBgt6igUywxUgPUbYADmfu4Ytl99ZagLivVGB8ykl2bp2dyeIh5eBv7ka14Fvan+
         W/3q5EN3wygMQXa+C0dE8L5C8RUCi9ZtqerO6iaLCT43dqs5QluAuxRUxGOFXlDPgC7O
         XfC9iDlzz1wJ7vvXdtP11Ug2KQdK8sPNIfSIYGhvgZVs6JaH681yl4PxTgWVtmYG+vIR
         ATwQ==
X-Gm-Message-State: AOUpUlEwGSN/K1h3a5yPmdHh2bVEJWvImzEv0G+lHq/7t8GT3rsDbTe7
        HayZzOPZ0ou3B2qTgTUdomhbYZvz
X-Google-Smtp-Source: AA+uWPyElouu6ihbfYTSPdhgzZxmLoed3Qr0DVGb927tWZXCmNeku7ZYycjWSeHS+tS6CDzWXth29w==
X-Received: by 2002:a1c:4b0c:: with SMTP id y12-v6mr1358829wma.22.1533816599952;
        Thu, 09 Aug 2018 05:09:59 -0700 (PDT)
Received: from [192.168.1.18] (blc170.neoplus.adsl.tpnet.pl. [83.28.196.170])
        by smtp.gmail.com with ESMTPSA id f132-v6sm14351827wme.24.2018.08.09.05.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 05:09:58 -0700 (PDT)
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
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <683f9e60-9ad8-93d8-e4ed-dbfdae78c307@gmail.com>
Date:   Thu, 9 Aug 2018 14:09:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <01bbf05a-8e5e-d3ce-857a-ac5c6efb779c@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 08/08/2018 11:45 PM, Dan Murphy wrote:
> Jacek
> 
> On 08/08/2018 04:09 PM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> On 08/08/2018 11:04 PM, Dan Murphy wrote:
>>> On 08/08/2018 04:02 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>> +	- #size-cells : 0
>>>>>>> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
>>>>>>> +		0 - All HVLED outputs are controlled by bank A
>>>>>>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
>>>>>>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
>>>>>>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
>>>>>>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
>>>>>>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
>>>>>>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
>>>>>>> +		7 - All HVLED outputs are controlled by bank B
>>>>>>
>>>>>> This is quite long way to describe a bitmask, no? Could we make
>>>>>> it so that control-bank-cfg is not needed?
>>>>>
>>>>> The problem we have here is there is a potential to control
>>>>> 3 different LED string but only 2 sinks.  So control bank A can control 2 LED strings and control
>>>>> bank b can control 1 LED string.  
>>>>>
>>>>
>>>> Can we forget about the LED strings, and just expose the sinks as
>>>> Linux LED devices?
>>>
>>> 2 sinks 3 LED strings.  How do you know which LED string is which and what bank it belongs
>>> to when setting the brightness.  Each Bank has a separate register for brightness control.
>>
>> Just a blind shot, without going into details - could you please check
>> if led-sources property documented in the common LED bindings couldn't
>> help here?
>>
> 
> I could change the name to led-sources.  But this part does not really follow the 1 output to a
> 1 LED string topology.

led-sources was designed for describing the topology where one LED can
be connected to more then one output, see bindings of
max77693-led (in Documentation/devicetree/bindings/mfd/max77693.txt).

Here the topology is a bit different - more than one LED (string) can be
connected to a single bank, but this is accomplished inside the chip.
Logically LEDs configured that way can be treated as a single LED
(string) connected to two outputs, and what follows they should be
described by a single DT child node.

led-sources will fit very well for this purpose. You could do
the following mapping:

0 - HVLED1
1 - HVLED2
2 - HVLED3

Then, in the child DT nodes you would use these identifiers to describe
the topology:

Following node would describe strings connected to the outputs
HVLED1 and HVLED2 controlled by bank A.

led@0 {
	reg = <0>;
	led-sources = <0>. <1>;
	label = "white:first_backlight_cluster";
	linux,default-trigger = "backlight";
};


IOW I agree with Pavel, but I propose to use already documented common
DT LED property.

-- 
Best regards,
Jacek Anaszewski
