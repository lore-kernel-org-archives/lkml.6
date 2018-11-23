Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9A220820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VqhbQgKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9A220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503261AbeKWVGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:06:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35866 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394114AbeKWVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:05:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANALp5w115251;
        Fri, 23 Nov 2018 04:21:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542968511;
        bh=N38F4k+IGdato5QACpPxG2W7HGT+D8Tnbuks2AvCsd4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VqhbQgKrkzeaAH6+f7pRA+rUHjssA4hNgYuhIH9UEh1ztlDyTNn7PiEpgPpGz9md6
         oat2bfM2yzL2C+8WlUpWTW2GiWWwArTkNdsau7rUN6pG16QfjxGW7VUJChKK2fWJVX
         fGQz8e6XsRf2jM2luEXQwGOOUcwuERH4S9Yar0UI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANALpvx046282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 04:21:51 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 04:21:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 04:21:46 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANALg6F006083;
        Fri, 23 Nov 2018 04:21:43 -0600
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
To:     Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
 <20181117160502.dhlqbx5qnmdp5iog@kahuna>
 <b8c1d975-2b4f-5530-2089-dc04c04f8d86@ti.com>
 <12c1d6e2-aba4-be0d-bfc5-1fb5d3ab45f8@ti.com>
 <9f87eb33-45b4-905a-2afd-5bbb450fc6c6@ti.com>
 <a411e291-d02d-064e-d08c-9ab7a1b1409e@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <0b796f85-5002-8eca-3e51-de239f7b3b41@ti.com>
Date:   Fri, 23 Nov 2018 12:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a411e291-d02d-064e-d08c-9ab7a1b1409e@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 12:44, Vignesh R wrote:
> On 20/11/18 4:07 PM, Tero Kristo wrote:
>> On 20/11/2018 12:09, Vignesh R wrote:
>>> On 19/11/18 12:49 PM, Tero Kristo wrote:
>>>> On 17/11/2018 18:05, Nishanth Menon wrote:
>>>>> On 11:31-20181113, Vignesh R wrote:
>>>>>> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
>>>>>
>>> [...]
>>>>>
>>>>> Thanks for reducing the combinations down to the minimum needed. We can
>>>>> worry about the DS and isolation bits when we have a real user for
>>>>> them.
>>>>>
>>>>> Acked-by: Nishanth Menon <nm@ti.com>
>>>>>
>>>>> Tero: v4.21-rc1 perhaps ?
>>>>>
>>>>
>>>> Yeah, looks fine, queueing up for 4.21.
>>>>
>>>
>>> Thank you all for the review!
>>>
>>> Tero,
>>>
>>> Is there a branch with these patches that I can use as base for my next
>>> set of DT patches?
>>
>> Don't have a branch for these atm, but I can create one if you need it.
> 
> Yes, that would be great. Thanks!
> 

Pushed 4.20-rc1-am65x-queue into my public tree.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
