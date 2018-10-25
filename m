Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2ECC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6546A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJZClb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:41:31 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45320 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeJZClb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:41:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9PI7Z7p101387;
        Thu, 25 Oct 2018 13:07:35 -0500
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9PI7ZLG077535
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 13:07:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 13:07:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 13:07:34 -0500
Received: from [172.22.66.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9PI7YKJ008151;
        Thu, 25 Oct 2018 13:07:34 -0500
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Rob Herring <robh@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <lee.jones@linaro.org>,
        <tony@atomide.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com> <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com> <20181024145434.GC9327@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
Date:   Thu, 25 Oct 2018 13:07:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024145434.GC9327@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob

On 10/24/2018 09:54 AM, Rob Herring wrote:
> On Wed, Oct 24, 2018 at 07:07:57AM -0500, Dan Murphy wrote:
>> Pavel
>>
>> On 10/24/2018 04:04 AM, Pavel Machek wrote:
>>> Hi!
>>>
>>>> The LM3697 is a single function LED driver. The single function LED
>>>> driver needs to reside in the LED directory as a dedicated LED driver
>>>> and not as a MFD device.  The device does have common brightness and ramp
>>>
>>> So it is single function LED driver. That does not mean it can not
>>> share bindings with the rest. Where the bindings live is not imporant.
>>>
>>
>> It can share bindings that are correctly done, not ones that are incomplete and incorrect.
>>
>> Where bindings live is important to new Linux kernel developers and product 
>> developers looking for the proper documentation on the H/W bindings.
>>
>>>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>>>> current LED and general bindings guidelines.
>>>
>>> What you forgot to tell us in the changelog:
>>
>> I can add this to the changelog.
>>
>>>
>>>> +Optional child properties:
>>>> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
>>>> +				the a higher brightness level.
>>>> +				Range from 2048 us - 117.44 s
>>>
>>> The other binding uses "ramp-up-msec". Tell us why you are changing this, or
>>> better don't change things needlessly.
>>>
>>> We don't want to be using "runtime-ramp-up-msec" for one device and
>>> "ramp-up-msec" for the other.
>>
>> This is another example of how the original bindings were incorrect and misleading.
>>
>> The LM3697 have 2 ramp implementations that can be used.
>>
>> Startup/Shutdown ramp and Runtime Ramp.  Same Ramp rates different registers and
>> different end user experience.
>>
>> So having a single node call ramp-up-msec is misleading and it does not
>> indicate what the H/W will do.
> 
> The existing ones aren't documented (present in the example is not 
> documented). This seems like something that should be common rather than 
> TI specific. Though it also seems more like something the user would 
> want to control (i.e. sysfs) rather than fixed in DT.
> 

Changing the runtime ramping or startup/shutdown ramping could also be done via sysfs.
I am not dedicated to having it in the DT file I was following prior art.

Jacek

Do you have an opinion on this?

Dan

> Rob
> 


-- 
------------------
Dan Murphy
