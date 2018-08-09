Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3823C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE2921EA3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U2JxX5Tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE2921EA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbeHIR0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34658 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732713AbeHIR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:35 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w79F1DxN101500;
        Thu, 9 Aug 2018 10:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533826873;
        bh=a1iv1j0RWfVqiVNMphfQ9phxIU4pQgD5s2vOhVJ7MZM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U2JxX5TnNidu3id1MC103GDmYAeTDJIQNecrPoVhjnjXipBmX+1ZEFMq4gtaoQeXX
         3UVPgNLGbyjxEHdnIZRdKIKZwP8wMhhGFGkXCXgdy973TZSuvMoPCyUEnjHAEzkdBs
         hcLs4EYz7mKIcjzle2Xpe7N6ZEgVVwjjaxkk2MH4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w79F1DhC023659;
        Thu, 9 Aug 2018 10:01:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 9 Aug
 2018 10:01:13 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 9 Aug 2018 10:01:13 -0500
Received: from [172.22.163.232] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w79F1CBX021838;
        Thu, 9 Aug 2018 10:01:12 -0500
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
 <c028fb73-8df5-9402-d96e-c907199356ed@ti.com>
 <04c37241-78c6-529f-4c07-db6f16b4f92a@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <0852bdeb-a16e-a635-4f10-34be283f9073@ti.com>
Date:   Thu, 9 Aug 2018 10:01:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <04c37241-78c6-529f-4c07-db6f16b4f92a@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 09:48 AM, Jacek Anaszewski wrote:
> Dan,
> 
> On 08/09/2018 03:30 PM, Dan Murphy wrote:
>> Jacek and Pavel
>>
>> On 08/09/2018 07:09 AM, Jacek Anaszewski wrote:
>>> Dan,
>>>
>>> On 08/08/2018 11:45 PM, Dan Murphy wrote:
>>>> Jacek
>>>>
>>>> On 08/08/2018 04:09 PM, Jacek Anaszewski wrote:
>>>>> Hi Dan,
>>>>>
>>>>> On 08/08/2018 11:04 PM, Dan Murphy wrote:
>>>>>> On 08/08/2018 04:02 PM, Pavel Machek wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>>>> +	- #size-cells : 0
>>>>>>>>>> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
>>>>>>>>>> +		0 - All HVLED outputs are controlled by bank A
>>>>>>>>>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
>>>>>>>>>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
>>>>>>>>>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
>>>>>>>>>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
>>>>>>>>>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
>>>>>>>>>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
>>>>>>>>>> +		7 - All HVLED outputs are controlled by bank B
>>>>>>>>>
>>>>>>>>> This is quite long way to describe a bitmask, no? Could we make
>>>>>>>>> it so that control-bank-cfg is not needed?
>>>>>>>>
>>>>>>>> The problem we have here is there is a potential to control
>>>>>>>> 3 different LED string but only 2 sinks.  So control bank A can control 2 LED strings and control
>>>>>>>> bank b can control 1 LED string.  
>>>>>>>>
>>>>>>>
>>>>>>> Can we forget about the LED strings, and just expose the sinks as
>>>>>>> Linux LED devices?
>>>>>>
>>>>>> 2 sinks 3 LED strings.  How do you know which LED string is which and what bank it belongs
>>>>>> to when setting the brightness.  Each Bank has a separate register for brightness control.
>>>>>
>>>>> Just a blind shot, without going into details - could you please check
>>>>> if led-sources property documented in the common LED bindings couldn't
>>>>> help here?
>>>>>
>>>>
>>>> I could change the name to led-sources.  But this part does not really follow the 1 output to a
>>>> 1 LED string topology.
>>>
>>> led-sources was designed for describing the topology where one LED can
>>> be connected to more then one output, see bindings of
>>> max77693-led (in Documentation/devicetree/bindings/mfd/max77693.txt).
>>>
>>> Here the topology is a bit different - more than one LED (string) can be
>>> connected to a single bank, but this is accomplished inside the chip.
>>> Logically LEDs configured that way can be treated as a single LED
>>> (string) connected to two outputs, and what follows they should be
>>> described by a single DT child node.
>>>
>>> led-sources will fit very well for this purpose. You could do
>>> the following mapping:
>>>
>>> 0 - HVLED1
>>> 1 - HVLED2
>>> 2 - HVLED3
>>>
>>> Then, in the child DT nodes you would use these identifiers to describe
>>> the topology:
>>>
>>> Following node would describe strings connected to the outputs
>>> HVLED1 and HVLED2 controlled by bank A.
>>>
>>> led@0 {
>>> 	reg = <0>;
>>> 	led-sources = <0>. <1>;
>>> 	label = "white:first_backlight_cluster";
>>> 	linux,default-trigger = "backlight";
>>> };
>>>
>>>
>>> IOW I agree with Pavel, but I propose to use already documented common
>>> DT LED property.
>>>
>>
>> I agree to use the led-sources but I still believe this approach may be confusing to other sw devs
>> and will lead to configuration issues by users.
>>
>> This implementation requires the sw dev to know which strings are controlled by which bank.
>> And this method may produce a misconfiguration like something below where HVLED2 is declared in
>> both bank A and bank B
>>
>> led@0 {
>> 	reg = <0>;
>> 	led-sources = <0>. <1>;
>> 	label = "white:first_backlight_cluster";
>> 	linux,default-trigger = "backlight";
>> };
>>
>> led@1 {
>> 	reg = <1>;
>> 	led-sources = <1>. <2>;
>> 	label = "white:keypad_cluster";
>> 	linux,default-trigger = "backlight";
>> };
>>
>> The driver will need to be intelligent and declare a miss configuration on the above.
>> Not saying this cannot be done but I am not sure why we want to add all of these extra LoC and intelligence
>> in the kernel driver.
> 
> It is better do add some complexity to the driver than to the
> user configurable settings like DT. Besides - you will only need to
> check if given led-source is already taken by another node.

Yes I know that the driver can check the string but if the same string is declared by another child then
the driver must exit with -EINVAL.  Again a lot of code for little pay off.
I believe we should keep drivers as simple as possible.

I will add the changes.

> 
>> The driver cannot make assumptions on the intention.  And the device tree documentation will need to
>> pretty much need a lengthy explanation on how to configure the child nodes.
> 
> Some description will be needed for sure, but I don't expect it
> to be overwhelmingly lengthy.
> 
>> The implementation I suggested removes that ambiguity.  It is a simple integer that is written to the device
>> as part of the device configuration, which the config is a setting for the device.
> 
> Your control-bank-cfg seemed like having much room for improvement,
> and it would for sure raise questions on why it was implemented that
> way. Documenting all available combinations of the configuration is
> seldom the best solution. It often obscures the issue.

Unfortunately in either case this high level of documentation will need to be done.
I believe both solutions will raise questions and concerns.

There does not seem to be a good way to describe this device.
Both solutions are wrought with issues and concerns.

But like I said I will re-write the code with the above suggestion.

> 
>> The child nodes denote which bank the exposed LED node will control.  Removing any need
>> for the sw developers new or old to know the specific device configurations.
> 
> In your bindings device configuration is scattered among global
> control-bank-cfg property and child node's reg property.
> In my proposal each child node contains all the needed configuration,
> also in the form of two properties - led-sources and reg. IMHO having
> all the LED class device related configuration in one place simplifies
> the analysis.
> 

Dan
-- 
------------------
Dan Murphy
