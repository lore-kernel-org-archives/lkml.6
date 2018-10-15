Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494BAC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FF920881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VZoHcjfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FF920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeJPDBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:01:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeJPDBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:01:37 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9FJEtNC071882;
        Mon, 15 Oct 2018 14:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539630895;
        bh=M4PHgn4lSUF/mVrSfvSpqE5wU5Oc8XQ41BK4YAWBuUE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VZoHcjfyDHeiSHuJMghvdVZsmS3uEdDcuNvAeGyNNYJqC8aAayJbR65HtPhhgozim
         gaPtNEoXWLv9JZA1hPop8nlknIpYEgORn7J3ss5/s42O6qL21o7bZB7tnEAI6rcyI2
         TXIn/MxLJxUj2RtfAccmAis2NVvyfk+nDxx9h0UY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FJEtMC018310;
        Mon, 15 Oct 2018 14:14:55 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 14:14:54 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 14:14:54 -0500
Received: from [172.22.143.15] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FJEs6g026875;
        Mon, 15 Oct 2018 14:14:54 -0500
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-3-dmurphy@ti.com> <20181011182734.GA7973@amd>
 <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
 <20181012162619.GA28573@bogus> <20181012180312.GB5565@amd>
 <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
 <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
 <73647af4-0258-49a9-d9b6-eeef7e7813dc@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <5c7f03cc-4d45-6010-523d-46721c218731@ti.com>
Date:   Mon, 15 Oct 2018 14:14:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <73647af4-0258-49a9-d9b6-eeef7e7813dc@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 10/15/2018 02:13 PM, Jacek Anaszewski wrote:
> On 10/15/2018 02:56 AM, Rob Herring wrote:
>> On Sat, Oct 13, 2018 at 1:46 PM Jacek Anaszewski
>> <jacek.anaszewski@gmail.com> wrote:
>>>
>>> On 10/12/2018 08:03 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>>>>
>>>>>>>> NAK.
>>>>>>>
>>>>>>> Thanks for the NAK.
>>>>>>>
>>>>>>> This NAK was NAK'd by other maintainer in the V2 RFC patchset
>>>>>>>
>>>>>>> https://lore.kernel.org/patchwork/patch/993171/
>>>>>>
>>>>>> I confirm. LM3697 is a standalone device and not a cell of any
>>>>>> MFD device.
>>>>>>
>>>>>> Waiting for DT maintainer's ack.
>>>>>
>>>>> You all sort out what you want... I can't follow it all, and I'm not
>>>>> going to spend the time trying to figure out what is going on here.
>>>>
>>>> This is what I want:
>>>>
>>>>> As this is worded, changing the driver is a Linux problem and irrelevant
>>>>> to the binding. Now if you want to move documentation to a location that
>>>>> makes more sense, then fine. But structure patches that way and make it
>>>>> clear that from an binding ABI perspective, nothing is changing.
>>>>
>>>> ...but apparently I did not have enough authority to get it.
>>>>
>>>> (I'm ok with move, and it is possible that binding does need some
>>>> fixups besides the move; still it should be done as fixup not as a new
>>>> binding).
>>>
>>> There is a fundamental question - should the bindings be considered
>>> an ABI, even though there is no mainline "*.dts" implementation basing
>>> on these bindings?
>>
>> In theory there could be out of tree users. Having a dts file using it
>> in tree shouldn't be a requirement to maintain the ABI IMO. However, a
>> lack of dts is one piece of determining whether this is in use or not.
>>
>>> This patch fixes the issues of bindings in a way that would change
>>> the ABI, if only it existed. But it apparently doesn't exist in
>>> mainline. Unless a DT documentation itself constitutes an ABI.
>>>
>>> I'd like to have it clarified at this occasion, and that's why
>>> I kindly ask for DT maintainer's ack or NACK for this modification
>>> of bindings.
>>>
>>> For a reference we have a nice summary of the MFD driver and related
>>> bindings' flaws in [0] and [1].
>>>
>>> [0] https://lkml.org/lkml/2018/9/7/774
>>> [1] https://lkml.org/lkml/2018/9/11/984
>>
>> Given this one seems to have not really been finished, it's probably
>> okay to make changes in this case. Still, it would be good to see
>> patches structured so that it's obvious we're breaking things. But how
>> the patches are structured doesn't matter until there's some agreement
>> on the end result.
> 
> OK, so if I'm getting it right, the correct patch structure in this case
> means that changes removing bindings from MFD and moving them along
> with the modifications to the LED subsystem should be placed in a single
> patch.
> 
> Dan, could you please arrange the next patch set version accordingly?

Yes I can squash the DT bindings patches and call it a "move and modify"

Dan

> 


-- 
------------------
Dan Murphy
