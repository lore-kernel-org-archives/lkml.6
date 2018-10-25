Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53794ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE852082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE852082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeJZDGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:06:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34862 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeJZDGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:06:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9PIW9it045116;
        Thu, 25 Oct 2018 13:32:09 -0500
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9PIW9qJ101312
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 13:32:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 13:32:09 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 13:32:09 -0500
Received: from [172.22.66.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9PIW9GC003015;
        Thu, 25 Oct 2018 13:32:09 -0500
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <lee.jones@linaro.org>, <tony@atomide.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com> <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com> <20181024145434.GC9327@bogus>
 <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
 <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <dfee9293-490f-2d47-c75b-971735683d41@ti.com>
Date:   Thu, 25 Oct 2018 13:32:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 10/25/2018 01:27 PM, Jacek Anaszewski wrote:
> On 10/25/2018 08:07 PM, Dan Murphy wrote:
>> Rob
>>
>> On 10/24/2018 09:54 AM, Rob Herring wrote:
>>> On Wed, Oct 24, 2018 at 07:07:57AM -0500, Dan Murphy wrote:
>>>> Pavel
>>>>
>>>> On 10/24/2018 04:04 AM, Pavel Machek wrote:
>>>>> Hi!
>>>>>
>>>>>> The LM3697 is a single function LED driver. The single function LED
>>>>>> driver needs to reside in the LED directory as a dedicated LED driver
>>>>>> and not as a MFD device.  The device does have common brightness and ramp
>>>>>
>>>>> So it is single function LED driver. That does not mean it can not
>>>>> share bindings with the rest. Where the bindings live is not imporant.
>>>>>
>>>>
>>>> It can share bindings that are correctly done, not ones that are incomplete and incorrect.
>>>>
>>>> Where bindings live is important to new Linux kernel developers and product 
>>>> developers looking for the proper documentation on the H/W bindings.
>>>>
>>>>>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>>>>>> current LED and general bindings guidelines.
>>>>>
>>>>> What you forgot to tell us in the changelog:
>>>>
>>>> I can add this to the changelog.
>>>>
>>>>>
>>>>>> +Optional child properties:
>>>>>> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
>>>>>> +				the a higher brightness level.
>>>>>> +				Range from 2048 us - 117.44 s
>>>>>
>>>>> The other binding uses "ramp-up-msec". Tell us why you are changing this, or
>>>>> better don't change things needlessly.
>>>>>
>>>>> We don't want to be using "runtime-ramp-up-msec" for one device and
>>>>> "ramp-up-msec" for the other.
>>>>
>>>> This is another example of how the original bindings were incorrect and misleading.
>>>>
>>>> The LM3697 have 2 ramp implementations that can be used.
>>>>
>>>> Startup/Shutdown ramp and Runtime Ramp.  Same Ramp rates different registers and
>>>> different end user experience.
>>>>
>>>> So having a single node call ramp-up-msec is misleading and it does not
>>>> indicate what the H/W will do.
>>>
>>> The existing ones aren't documented (present in the example is not 
>>> documented). This seems like something that should be common rather than 
>>> TI specific. Though it also seems more like something the user would 
>>> want to control (i.e. sysfs) rather than fixed in DT.
>>>
>>
>> Changing the runtime ramping or startup/shutdown ramping could also be done via sysfs.
>> I am not dedicated to having it in the DT file I was following prior art.
>>
>> Jacek
>>
>> Do you have an opinion on this?
> 
> This is this problem with the Device Tree's scope of responsibility.
> It is defined as a means for "describing the hardware", but often
> this rule is abused by the properties that fall into "configuration"
> category. E.g. default-state, retain-state-suspended from leds-gpio.txt
> or linux-default-trigger from common LED bindings.
> 
> In some cases this is justified. The question is whether it is something
> that necessarily needs to be configured on driver probing? If not, then
> I'd go for sysfs interface.
> 

Appreciate the feedback.  I think you and Rob are right. This should be a sysfs
entry.  I can think of instances where the ramp times might want to be modified 
or even turned off.

I will change that implementation.

Dan

-- 
------------------
Dan Murphy
