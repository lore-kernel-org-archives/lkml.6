Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC114C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C0B21D69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XyjFIQbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C0B21D69
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeHIPzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:55:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:55:39 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w79DUcOM092817;
        Thu, 9 Aug 2018 08:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533821438;
        bh=WDJmLj5gHewxdBT5JJbFJtWx8A/+k3TIJK2DLQ1wejc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XyjFIQbrSaWiSQIyoktdsiJE6z6Has5SWLSgim4jfxoaM5tVmp1dnP6vXBFuvzxf9
         OP1riPI9BABOlFObpPUzbLcppM4sd7AOJ4A8UjKB2RfTRCubN6VfZmRl2XtAItBl/0
         cz2f5L6GaPlvxlsPJ3hoXix9jUb1hvrqwdiffzUQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w79DUcsJ002291;
        Thu, 9 Aug 2018 08:30:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 9 Aug
 2018 08:30:38 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 9 Aug 2018 08:30:38 -0500
Received: from [172.22.163.232] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w79DUcB1032305;
        Thu, 9 Aug 2018 08:30:38 -0500
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd> <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd> <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
 <53691469-4554-42a8-c182-762c1a3939b7@gmail.com>
 <01bbf05a-8e5e-d3ce-857a-ac5c6efb779c@ti.com>
 <683f9e60-9ad8-93d8-e4ed-dbfdae78c307@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c028fb73-8df5-9402-d96e-c907199356ed@ti.com>
Date:   Thu, 9 Aug 2018 08:30:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <683f9e60-9ad8-93d8-e4ed-dbfdae78c307@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek and Pavel

On 08/09/2018 07:09 AM, Jacek Anaszewski wrote:
> Dan,
> 
> On 08/08/2018 11:45 PM, Dan Murphy wrote:
>> Jacek
>>
>> On 08/08/2018 04:09 PM, Jacek Anaszewski wrote:
>>> Hi Dan,
>>>
>>> On 08/08/2018 11:04 PM, Dan Murphy wrote:
>>>> On 08/08/2018 04:02 PM, Pavel Machek wrote:
>>>>> Hi!
>>>>>
>>>>>>>> +	- #size-cells : 0
>>>>>>>> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
>>>>>>>> +		0 - All HVLED outputs are controlled by bank A
>>>>>>>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
>>>>>>>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
>>>>>>>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
>>>>>>>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
>>>>>>>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
>>>>>>>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
>>>>>>>> +		7 - All HVLED outputs are controlled by bank B
>>>>>>>
>>>>>>> This is quite long way to describe a bitmask, no? Could we make
>>>>>>> it so that control-bank-cfg is not needed?
>>>>>>
>>>>>> The problem we have here is there is a potential to control
>>>>>> 3 different LED string but only 2 sinks.  So control bank A can control 2 LED strings and control
>>>>>> bank b can control 1 LED string.  
>>>>>>
>>>>>
>>>>> Can we forget about the LED strings, and just expose the sinks as
>>>>> Linux LED devices?
>>>>
>>>> 2 sinks 3 LED strings.  How do you know which LED string is which and what bank it belongs
>>>> to when setting the brightness.  Each Bank has a separate register for brightness control.
>>>
>>> Just a blind shot, without going into details - could you please check
>>> if led-sources property documented in the common LED bindings couldn't
>>> help here?
>>>
>>
>> I could change the name to led-sources.  But this part does not really follow the 1 output to a
>> 1 LED string topology.
> 
> led-sources was designed for describing the topology where one LED can
> be connected to more then one output, see bindings of
> max77693-led (in Documentation/devicetree/bindings/mfd/max77693.txt).
> 
> Here the topology is a bit different - more than one LED (string) can be
> connected to a single bank, but this is accomplished inside the chip.
> Logically LEDs configured that way can be treated as a single LED
> (string) connected to two outputs, and what follows they should be
> described by a single DT child node.
> 
> led-sources will fit very well for this purpose. You could do
> the following mapping:
> 
> 0 - HVLED1
> 1 - HVLED2
> 2 - HVLED3
> 
> Then, in the child DT nodes you would use these identifiers to describe
> the topology:
> 
> Following node would describe strings connected to the outputs
> HVLED1 and HVLED2 controlled by bank A.
> 
> led@0 {
> 	reg = <0>;
> 	led-sources = <0>. <1>;
> 	label = "white:first_backlight_cluster";
> 	linux,default-trigger = "backlight";
> };
> 
> 
> IOW I agree with Pavel, but I propose to use already documented common
> DT LED property.
> 

I agree to use the led-sources but I still believe this approach may be confusing to other sw devs
and will lead to configuration issues by users.

This implementation requires the sw dev to know which strings are controlled by which bank.
And this method may produce a misconfiguration like something below where HVLED2 is declared in
both bank A and bank B

led@0 {
	reg = <0>;
	led-sources = <0>. <1>;
	label = "white:first_backlight_cluster";
	linux,default-trigger = "backlight";
};

led@1 {
	reg = <1>;
	led-sources = <1>. <2>;
	label = "white:keypad_cluster";
	linux,default-trigger = "backlight";
};

The driver will need to be intelligent and declare a miss configuration on the above.
Not saying this cannot be done but I am not sure why we want to add all of these extra LoC and intelligence
in the kernel driver.
The driver cannot make assumptions on the intention.  And the device tree documentation will need to
pretty much need a lengthy explanation on how to configure the child nodes.

The implementation I suggested removes that ambiguity.  It is a simple integer that is written to the device
as part of the device configuration, which the config is a setting for the device.

The child nodes denote which bank the exposed LED node will control.  Removing any need
for the sw developers new or old to know the specific device configurations.


Dan
-- 
------------------
Dan Murphy
