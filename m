Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FBFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4777320842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r00p6xUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfBZK0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:26:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56512 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:26:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1QAPoJH091285;
        Tue, 26 Feb 2019 04:25:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551176750;
        bh=T372Cq9lmdmNNtnM60Jq1siPeD7EEYNpMZ4m+HjOyVU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=r00p6xUlliasczHLu3wqbzN/oHU5zeSWA2ctj/8UPczMm+ug6DLj+dsX/fdsKlVJ4
         ugKyVt9O7/n24gQC0xt7v1T7XDIkZo26/W2M/6yOTryzQJNvtrfN9EwGDS3artQG5+
         feE/j8wn5uM/AiUWNOMMWnEhIUlYTyvUq6o9TxF4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1QAPogY117052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 04:25:50 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 04:25:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 04:25:49 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1QAPixE030514;
        Tue, 26 Feb 2019 04:25:45 -0600
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Nori, Sekhar" <nsekhar@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
 <42d0fd7b-42e0-605c-70ee-6e308908fc90@cogentembedded.com>
 <4910fda5-133d-7ebb-6ab3-49e0839ea920@ti.com>
 <95344724-214f-20b7-b629-149ddf396117@cogentembedded.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <1137312b-c326-9e41-4667-e2126649f384@ti.com>
Date:   Tue, 26 Feb 2019 15:56:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <95344724-214f-20b7-b629-149ddf396117@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/02/19 1:03 AM, Sergei Shtylyov wrote:
> On 02/25/2019 09:21 PM, Vignesh R wrote:
> 
> [...]
> 
>>>> HyperBus specification can be found at[1]
>>>> HyperFlash datasheet can be found at[2]
>>>>
>>>> [1] https://www.cypress.com/file/213356/download
>>>> [2] https://www.cypress.com/file/213346/download
>>>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>>>     Table 12-5741. HyperFlash Access Sequence
>>>>
>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> [...]
>>>> diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
>>>> new file mode 100644
>>>> index 000000000000..d3d44aab7503
>>>> --- /dev/null
>>>> +++ b/drivers/mtd/hyperbus/core.c
> [...]
>>>> +int hb_register_device(struct hb_device *hbdev)
>>>> +{
>>>> +	struct resource res;
>>>> +	struct device *dev;
>>>> +	struct device_node *np;
>>>> +	struct map_info *map;
>>>> +	struct hb_ops *ops;
>>>> +	int err;
>>>> +
>>>> +	if (!hbdev || !hbdev->dev || !hbdev->np) {
>>>> +		pr_err("hyperbus: please fill all the necessary fields!\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	np = hbdev->np;
>>>> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
>>>> +		return -ENODEV;
>>>> +
>>>> +	hbdev->memtype = HYPERFLASH;
>>>> +
>>>> +	if (of_address_to_resource(np, 0, &res))
>>>
>>>     Isn't the direct mapping property of the HF controller, not of HyperFlash
>>> itself?
>>>
>>
>> As I said in the cover letter, I could not find many examples of HF
>> controllers, but couple of them that I studied provide MMIO access to
>> flash. So, reg property of flash node would represent local address on
>> the HyperBus and controller node would set up ranges properly to provide
>> translation from CS to SoC address space.
>> For example see patch 4/5 where reg property would indicate CS and Size
>> of flash. This scheme is similar to whats described here [1]
>> HBMC controllers usually have different MMIO regions to access flashes
>> connected to different CS. So using ranges for address translation along
>> with flash node describing local address works pretty well.
>>
>> My understanding is that this part of code will be common for most MMIO
>> based HB controllers and hence made part of core layer. But, if
>> controllers uses different IO space for read vs write, then this needs a
>> bit of thinking. In that case, mapping needs to be moved to controller
>> drivers.
>>
>> [1]https://elinux.org/Device_Tree_Usage#Ranges_.28Address_Translation.29
>>
>>>> +		return -EINVAL;
>>>> +
>>>> +	dev = hbdev->dev;
>>>> +	map = &hbdev->map;
>>>> +	map->size = resource_size(&res);
>>>> +	map->virt = devm_ioremap_resource(dev, &res);
>>>> +	if (IS_ERR(map->virt))
>>>> +		return PTR_ERR(map->virt);
>>>> +
>>>> +	map->name = dev_name(dev);
>>>> +	map->bankwidth = 2;
>>>> +
>>>> +	simple_map_init(map);
>>>
>>>    It's not that simple, I'm afraid -- e.g. Renesas RPC-IF has read and write
>>> mappings in the separate memory resources.
>>>
>>
>> Hmm, could you point me to public datasheet of the controller?
> 
>    See chapter 20 in [1]. Note that it's not the same SoC I'm developing for (R-Car
> gen3 family, with NDA docs) but should be mostly the same RPC-IF core.
> 
> [1] https://www.renesas.com/us/en/doc/products/mpumcu/doc/rz/r01uh0746ej0200-rza2m.pdf?key=74862185b5e22ad09e648d21a35de615

Thanks for the info!

> 
>> simple_map_init() provides default implementation for map operations
>> which is overridden, if hb_ops is populated.
>> I think, Renesas RPC-IF can populate custom hb_ops struct and use
>> appropriate MMIO base for read vs write, while still reusing the map
>> framework. Wouldnt that work?
> 
>    It probably would...
> 


Looking at above link, I see there are two HBMC controllers on Renesas
SoC. One is a dedicated HBMC controller(chapter 21) very similar to that
on TI SoC and a SPI Multi I/O Bus Controller (chapter 20) that also
supports Hyperbus protocol.

AFAICS, passing custom hb_ops is good enough to support both HW needs.
Let me know if something is missing. I would greatly appreciate if you
could test this series with your HW.



-- 
Regards
Vignesh
