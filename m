Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7815C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764CE2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x+cJFl7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfB0KLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:11:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42090 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfB0KLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:11:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1RABV7i038275;
        Wed, 27 Feb 2019 04:11:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551262291;
        bh=Qs2liJLGMWU770amCHkKQGol3ULiosdr5P4zmUSVilE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x+cJFl7XHAd/Q0VcdtIi6a3sonDFIYCRG0lSyNGNXD1rBuSwWoyUsKj5CBB/8cGQJ
         BTh8FkhIeitAPTuAYeJGGNyMW8omGiGwSOa8PnS1c2AgODdB2zMDVx1OGwMED8nf45
         kHbZPsV1+ELWHypXKR+5FcUJvOyWC1ux3B5a+Ff8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1RABVYr024897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 04:11:31 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 27
 Feb 2019 04:11:30 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 27 Feb 2019 04:11:30 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1RABPY8002039;
        Wed, 27 Feb 2019 04:11:26 -0600
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Nori, Sekhar" <nsekhar@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
 <7e79fff7-2565-28f7-7b2b-bb3098f1a928@cogentembedded.com>
 <3952b327-3aff-a32e-4280-6ab24c32cfd9@ti.com>
 <20190227105937.527c6573@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <acde502c-63fb-e272-d701-4ee63eac4eaa@ti.com>
Date:   Wed, 27 Feb 2019 15:42:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227105937.527c6573@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/02/19 3:29 PM, Boris Brezillon wrote:
> On Wed, 27 Feb 2019 15:22:19 +0530
> Vignesh Raghavendra <vigneshr@ti.com> wrote:
> 
>> On 26/02/19 11:46 PM, Sergei Shtylyov wrote:
>>> On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:
>>>   
>
[...]
>>>> + */
>>>> +
>>>> +struct hb_device {
>>>> +	struct map_info map;
>>>> +	struct device *dev;
>>>> +	struct device_node *np;
>>>> +	struct mtd_info *mtd;
>>>> +	struct hb_ops *ops;
>>>> +	enum hb_memtype memtype;
>>>> +	bool needs_calib;
>>>> +	bool registered;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct hb_ops - struct representing custom Hyperbus operations
>>>> + * @read16: read 16 bit of data, usually from register/ID-CFI space
>>>> + * @write16: write 16 bit of data, usually to register/ID-CFI space
>>>> + * copy_from: copy data from flash memory
>>>> + * copy_to: copy data to flash_memory
>>>> + */
>>>> +
>>>> +struct hb_ops {
>>>> +	u16 (*read16)(struct hb_device *hbdev, unsigned long addr);
>>>> +	void (*write16)(struct hb_device *hbdev, unsigned long addr, u16 val);
>>>> +
>>>> +	void (*copy_from)(struct hb_device *hbdev, void *to,
>>>> +			  unsigned long from, ssize_t len);
>>>> +	void (*copy_to)(struct hb_device *dev, unsigned long to,
>>>> +			const void *from, ssize_t len);  
>>>
>>>    ... else these methods won't fly if you need to "massage" the controller
>>> registers inside them...
>>>   
>>
>> If accessing controller register is the only need, wouldn't a private
>> data pointer within struct hb_device be sufficient to hold pointer to
>> controller specific struct?
>>
>> struct hb_device {
>> 	...
>> 	void *priv; /* points to controller's private data */
>> };
>>
>>
>> Or do you see a need for separate structure for the HyperBus controller?
> 
> Sorry to chime in. Just want to share my experience here: properly
> splitting the controller/device representation is always a good thing.
> When it's not done from the beginning and people start to add their own
> controller drivers as if it was a flash device driver it becomes messy
> pretty quickly and people add hacks to support that (look at the raw
> NAND framework if you need a proof). So, I'd recommend having this
> separation now, even if the onle controllers we support have a 1:1
> relationship between HB controller and HB device.
> 
>>

Alright, will separate controller and slave representation. Thanks for
the feedback!


-- 
Regards
Vignesh
