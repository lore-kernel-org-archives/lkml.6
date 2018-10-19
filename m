Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492A9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE367205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L/RGYbCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE367205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJSTsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:48:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43566 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeJSTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:48:46 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9JBgsU4077802;
        Fri, 19 Oct 2018 06:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539949374;
        bh=9gHq1cF63AmQeQCfVFhHe9ubx3kFwWjdkdmq93kmVv8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L/RGYbCQ+WSsRZcKOsuiHiiB/ER7ym0nHeh47tq7n43vVEoVM/acKil9BTbY7X+vh
         pMETPzcnU/55n3/KXUWJJg6z2rH9RfkGqaO8SVBFh/JYVF2jwJ4vfmtcAYyDskr7hR
         LURfhk6zz7DOFmsvY+BX/q56SbsclS39M3D1pFgY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9JBgslN008220;
        Fri, 19 Oct 2018 06:42:54 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 19
 Oct 2018 06:42:54 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 19 Oct 2018 06:42:54 -0500
Received: from [172.22.151.114] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9JBgs1L019890;
        Fri, 19 Oct 2018 06:42:54 -0500
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
 <20181012162619.GA28573@bogus> <20181012180312.GB5565@amd>
 <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
 <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
 <73647af4-0258-49a9-d9b6-eeef7e7813dc@gmail.com>
 <5c7f03cc-4d45-6010-523d-46721c218731@ti.com> <20181015214512.GA2001@amd>
 <aa401333-9650-c925-2085-6e6d17b576bd@ti.com> <20181018221048.GA6364@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b3d390c8-46bf-2c94-fad5-ec85b1cca2fe@ti.com>
Date:   Fri, 19 Oct 2018 06:42:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018221048.GA6364@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 05:10 PM, Pavel Machek wrote:
> Hi!
> 
>>>>>> Given this one seems to have not really been finished, it's probably
>>>>>> okay to make changes in this case. Still, it would be good to see
>>>>>> patches structured so that it's obvious we're breaking things. But how
>>>>>> the patches are structured doesn't matter until there's some agreement
>>>>>> on the end result.
>>>>>
>>>>> OK, so if I'm getting it right, the correct patch structure in this case
>>>>> means that changes removing bindings from MFD and moving them along
>>>>> with the modifications to the LED subsystem should be placed in a single
>>>>> patch.
>>>>>
>>>>> Dan, could you please arrange the next patch set version accordingly?
>>>>
>>>> Yes I can squash the DT bindings patches and call it a "move and modify"
>>>
>>> You can do move without problems. But if you plan to modify them,
>>> please try to change as little as possible, make it separate patch and
>>> explain why new version is better than old one.
>>>
>>
>> I have been thinking of how to do this.  Since the 2 devices are part of the current
>> binding there really is not a way to move them.  Since there are still MFD capable
>> devices available.
>>
>> I would still need to remove the current active binding and create a new binding in the LED
>> bindings directory.
>>
>> I would have to remove and create in the same patch.
> 
> Yeah, and this all is a sign that you should just keep the current
> binding, and make your code use it, see?


No I don't actually see this as a sign.  This is just operational issues
nothing to do with actually correcting the incomplete unused bindings.

And actually moving and creating the bindings in the same patch makes
sense as the change is self contained in a single patch and is easier to
track.

> 
> You are free to use Sebastian's updated binding. It has "suggested by:
> Rob" or something like that on it, so it should be fine.
> 
> You can add note to bindings/leds pointing to mfd binding.
> 
> Now... this is what I've suggested before. If you don't agree, you may
> want to contact Tony Lindgren, IIRC he works for TI, too, and might be
> willing to help.

I will ping Tony just to close the loop.  I will be posting v4 today after making the changes.
I was hoping to have some code review prior to posting v4 but have not received any comments so
v4 will just be a patch rearrangement.

Dan

> 
> Thank you,
> 									Pavel
> 


-- 
------------------
Dan Murphy
