Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8230ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7E02088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HoKy0lS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7E02088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeIRCxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:53:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54384 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeIRCxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:53:21 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8HLO9Js008023;
        Mon, 17 Sep 2018 16:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537219449;
        bh=awpKjWHMLTtfaOjrTYbznoo3DZkkrpxrbfNqhIYC7zY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HoKy0lS+FpqzWhZLeRAW/Klx1kD0Q5N6i18/a0//2itaEijI8qACJCSGFbTn9uTyf
         p/lZ2r+471Dm7X972XCt/g10Acd5aXe9SvIuMvm4klGwVW/2ytzKK9OH9J8B8mZqls
         ZW4j+RXnrDS+GkIZ9mufW5ncsNQWW1df5kEXLHm8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8HLO9aO024243;
        Mon, 17 Sep 2018 16:24:09 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 17
 Sep 2018 16:24:09 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 17 Sep 2018 16:24:09 -0500
Received: from [172.22.161.49] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8HLO8f5002661;
        Mon, 17 Sep 2018 16:24:08 -0500
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux-omap@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com> <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com> <20180914081822.GA21830@amd>
 <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com> <20180914214220.GA2081@amd>
 <be2ee681-7ae0-6545-0208-6ae5c1b7affd@gmail.com>
 <5a249ae3-e3f7-8eff-4022-ed982e364326@ti.com>
 <7a6e83ad-2bc9-c776-21bf-e1d51413b0af@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4feebb0e-c3e8-13ec-c6c3-5328fa8fffb7@ti.com>
Date:   Mon, 17 Sep 2018 16:23:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7a6e83ad-2bc9-c776-21bf-e1d51413b0af@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 09/17/2018 02:22 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 09/17/2018 05:24 PM, Dan Murphy wrote:
>> Jacek
>>
>> On 09/15/2018 03:00 PM, Jacek Anaszewski wrote:
>>> Hi Pavel.
>>>
>>> On 09/14/2018 11:42 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>> You may want to learn more about device tree and/or talk to the device
>>>>>> tree maintainers. This is an old article. https://lwn.net/Articles/561462/
>>>>>
>>>>> The article title is "Device trees as ABI". A device tree is defined
>>>>> in the "*.dts" file that is then compiled to a dtb blob, which
>>>>> constitutes the ABI. And this ABI should be kept backwards compatible.
>>>>>
>>>>> What is discussed here is a documentation of bindings, i.e. according
>>>>> to ePAPR: "requirements for how specific types and classes of devices
>>>>> are represented in the device tree".
>>>>>
>>>>> >From the bindings documented in the
>>>>> Documentation/devicetree/bindings/mfd/ti-lmu.txt only
>>>>> ti,lm3532-backlight is used in the mainline dts file
>>>>> (arch/arm/boot/dts/omap4-droid4-xt894.dts).
>>>>>
>>>>> Having the above it seems that there is no risk of breaking any
>>>>> users.
>>>>
>>>> DTBs and bindings are supposed to be portable between operating
>>>> systems. You are right there are no _mainline_ _Linux_ users.
>>>
>>> No mainline users means no users we should care of.
>>> Other people also don't care - see patch [0].
>>>
>>>>>> NAK on this patch. I see that this binding has problems, but
>>>>>> introducing different binding for subset of devices is _not_ a fix.
>>>>>>
>>>>>>>> What about the multi function devices? They should have same binding.
>>>>>>>
>>>>>>> The MFD devices defined are not in contention here only the SFD.
>>>>>>
>>>>>> I'd like to see common solutions for SFD and MFD, as the hardware is
>>>>>> similar, and that includes the code. Having code that is easier to
>>>>>> maintain is important, and having many drivers are harder to maintain
>>>>>> than one driver.
>>>>>>
>>>>>> Milo's code looks better than yours in that regard. I disagree about
>>>>>> Milo's code being "nightmare" to modify, and care about "easy to
>>>>>> maintain" more than "binary size".
>>>>>
>>>>> Easy to maintain will be a dedicated LED class driver.
>>>>
>>>> You mean, 3 dedicated LED class drivers and 3 MFD drivers with LED
>>>> parts? We'll need complex driver anyway, and I'd really like to have
>>>> just one.
>>>
>>> In the LED subsystem we can wrap common functionalities
>>> into a library object. MFD driver will be able to reuse it then.
>>
>> I am currently working on that code now.  I expect a RFC on this this week.
> 
> Will it affect the shape of the driver for lm3697 as of v7 [0]?
> Or the patch set [0] state should be deemed "awaiting merge"?
> 

It will probably affect the driver to call into the library.  We can pull it in and
modify or we can modify after the common code is there.

It should not affect the bindings though.

Dan

> [0] https://lkml.org/lkml/2018/9/11/760
> 


-- 
------------------
Dan Murphy
