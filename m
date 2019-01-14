Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1A8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B6720659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q88daTCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfANUaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:30:03 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44106 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfANUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:30:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EKTsmd027791;
        Mon, 14 Jan 2019 14:29:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547497794;
        bh=gE4aDq819BqHX4oqEG8ZcwcQ+kaX90+XltDgzinPKf8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q88daTCi2OgMbbWa996e/qbVDstMukE+nHCDy0LYGJaz1rXMCspaHArXXe6Dz5Wew
         L2EYs1bzseoAwUsxol7o7Vr7YtiFFX8Dj50QiR7mZKjsD30lOUMZQ/bpfILSJ0tSip
         vKlhi4+qVf1DsVUY7r56ekDyRxemh2xBZMFM7jr0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EKTsVN012152
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 14:29:54 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 14:29:53 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 14:29:54 -0600
Received: from [172.22.100.22] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EKTrPR012705;
        Mon, 14 Jan 2019 14:29:53 -0600
Subject: Re: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and lp5018
 RGB driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <6c62956e-7789-58ba-5437-f2e033f2825c@gmail.com>
 <366cbf6d-94fa-fea9-be58-07ddb09cff3a@ti.com>
 <df59c10d-7038-cb4a-45f0-7420254c6398@gmail.com>
 <ec0393b7-118e-1f3b-d5af-86ecdf66412a@ti.com>
 <ae700129-7b59-c92b-0c0a-b57a6f230ff7@gmail.com>
 <adcd7987-f7fc-ae1f-9aa4-cebcbf01ad58@ti.com>
 <1702dfd6-b08f-c1ff-e46d-1366618bedb0@gmail.com>
 <72112839-11d4-54be-df94-b2322f77cb0f@ti.com>
 <8b126077-c200-ed34-03b7-6d43a22fb0c9@gmail.com>
 <92cc81dc-7280-8bf0-9536-9c4d990eaf3b@ti.com>
 <459a4d7a-980b-5a46-9bd8-7a7afb37e1c3@gmail.com>
 <76577ad1-8c29-c5f6-e253-a8541a150dc0@ti.com>
 <3674d644-ccf6-d545-fc41-6bdf8960df44@gmail.com>
 <0140ad64-432e-7723-2415-0b3a8ac4d8dc@ti.com>
 <ed78b2fd-7ab8-d7c3-cf28-4d5b06783fb3@gmail.com>
 <1c452daa-d77e-5d31-3694-b9dfda9cc8f3@ti.com>
 <9c129b00-39e6-dd29-c2a7-0506a1780fb8@gmail.com>
 <17752128-5a08-4122-9502-47f2fca9a8bb@ti.com>
 <5204698e-bd20-9989-9c85-09db7984ed28@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8f67b130-23d6-d4f3-9732-47661bafc958@ti.com>
Date:   Mon, 14 Jan 2019 14:29:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5204698e-bd20-9989-9c85-09db7984ed28@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 1/14/19 2:28 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 1/14/19 9:14 PM, Dan Murphy wrote:
> [...]
>>>>>> One last question I am going to add the LP5036 and 30 which have the same technology but slightly different register maps.
>>>>>> Should I rename the driver to LP5036.c as the 30, 24 and 18 would technically be subsets?
>>>>>
>>>>> How about leds-lp50xx.c ? You can also create a library like
>>>>> drivers/leds/leds-lp55xx-common.c if that would simplify the code.
>>>>>
>>>>
>>>> A library would be overkill.
>>>> Is it just the DT that we don't want to use wild cards in naming?
>>>
>>> DT is for concrete board and cpu, so it doesn't make sense to
>>> use wildcards in *.dts file names.
>>>
>>>> leds-lp50xx.c is a fine name to me.
>>>
>>> Apart of that, I've been also mulling over if we shouldn't go for single
>>> "color" sysfs file for setting r,g,b components at one go.
>>> I don't see any downsides. There is no risk that number of elements will
>>> grow, and the benefit will be an atomic way of setting color - the
>>> feature people are looking for. Vesa was mentioning the case where lack
>>> of it had been a real problem [0].
>>>
>>
>> Well thats what I did and have it working.  I was going to submit v2 today after I write the documentation.
>>
>> I basically exposed a "hue" file that takes in a 24 bit R,G,B value and sets the registers accordingly.
>>
>> I figured hue would be good as that may be the same ABI we have when the RGB framework comes in.
>>
>> The change over would be transparent to the past users.
> 
> I'd prefer "color" over "hue". The latter implies HSV color space, which
> was the first thing that came to my mind when reading your message.
> 

Done

Dan
-- 
------------------
Dan Murphy
