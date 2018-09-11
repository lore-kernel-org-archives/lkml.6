Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63983C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1994B20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gSnz/goH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1994B20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIKXhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:37:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56600 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:37:55 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BIbG26056194;
        Tue, 11 Sep 2018 13:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536691036;
        bh=uKg3XeHKlWyIXyDh/aCTvfeNKme6VHdahO0XV4y7b3w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gSnz/goHeyWwRfuVsgQmOPW1uFxj0fHmL0JUyMlvm6+FFHPNEIFuPfi+bcYXa/JOP
         IHwCbPO/vxY//pilt/BiD5N1B+tbqByUXmoS6ckG/7pBXBsgpoGObXgPeIg5Oi+0+6
         MDYKL1crbhLLR8G9r0NTeMSZ85JrYeZdDSQcOavc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BIbGIf001361;
        Tue, 11 Sep 2018 13:37:16 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 13:37:16 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 13:37:16 -0500
Received: from [172.22.156.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BIbFWS021390;
        Tue, 11 Sep 2018 13:37:15 -0500
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180906135005.6718-1-dmurphy@ti.com>
 <20180906211617.GB16899@amd> <b8ac9d52-f16d-5fc4-0e9a-9246b9f984c5@ti.com>
 <20180907133228.GA16297@amd> <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
 <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
 <20a814ce-a4c5-0649-6677-6b85a5fd2321@ti.com>
 <59561e0f-e3b9-7898-a300-90b198ad14e6@gmail.com>
 <20d9ea9e-bbb8-2240-97cc-615e3fbcef8c@ti.com>
 <5127d46f-2d43-41e8-dde0-5ee42a9d47bb@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ff86540b-c362-ad06-225f-29daab1defdf@ti.com>
Date:   Tue, 11 Sep 2018 13:37:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5127d46f-2d43-41e8-dde0-5ee42a9d47bb@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 09/11/2018 01:27 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 09/10/2018 09:51 PM, Dan Murphy wrote:
>> Jacek
>>
>> On 09/10/2018 02:07 PM, Jacek Anaszewski wrote:
>>> Dan, Pavel,
>>>
>>> On 09/10/2018 04:37 PM, Dan Murphy wrote:
>>>> Jacek
>>>>
>>>> On 09/08/2018 02:53 PM, Jacek Anaszewski wrote:
>>>>> Dan,
>>>>>
>>>>> On 09/07/2018 03:52 PM, Dan Murphy wrote:
>>>>> [...]
>>>>>>>
>>>>>>>> And I think Jacek pointed out that the bindings references in this bindings
>>>>>>>> don't even exist.
>>>>>>>>
>>>>>>>> I am thinking we need to deprecate this MFD driver and consolidate these drivers
>>>>>>>> in the LED directory as we indicated before.  I did not find any ti-lmu support
>>>>>>>> code.
>>>>>>>>
>>>>>>>> ti-lmu common core code and then the LED children appending the feature differentiation.
>>>>>>>
>>>>>>>> Need some maintainer weigh in here.
>>>>>>>
>>>>>>> Hehe. I'm maintnainer. Fun.
>>>>>>
>>>>>> I know.  I want to see if there was any other opinion.  Especially for the LED driver.
>>>>>>
>>>>> [...]
>>>>>
>>>>> I have a question - is this lm3697 LED controller a cell of some MFD
>>>>> device? Or is it a self-contained chip?
>>>>>
>>>>
>>>> This is a self contained chip.  And the LM3697 only function is a LED driver.
>>>> It does not have any other special functions like the LM363X drivers for GPIO and Regulator support.
>>>
>>> This is an argument for merging it as a standalone LED class driver
>>> then. It is even more justifiable, taking into account uncertainties
>>> related to the proper way of adding the support for it to the existing
>>> MFD driver, whereas the code reuse would be the only advantage of having
>>> thus support in MFD subsystem.
>>>
>>
>> Does the argument carry over to the other devices?
> 
> If we want to be consequent - yes.
> 
>> Like the LM3632 (part of the ti-lmu) has flash and torch and no other special functions
>> so it would look like the lm3601x family with different register mappings.
> 
> Yes, this is obvious candidate for LED class flash driver.
> 
>> The LM3631 seems to also be just a LED driver with no extra functionality
>>
>> I could go buy an EVM and put together a driver for that device as well using the lm3601x as
>> reference.
> 
> I'm not going to encourage you to make this expense, but to put it
> politically - I'd happily welcome those drivers in the LED subsystem ;-)
> 

Understood.  I am waiting on hardware to test.

Dan

-- 
------------------
Dan Murphy
