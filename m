Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7417D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fbvQibqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfBYTdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:33:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37714 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:33:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id a17so8501270ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eX6EJTdHV8W5AjvTP6REm4fH1/SpIVw5AXuQai7r+rs=;
        b=fbvQibqKvsZ6TRQfCU6cGibqZcZ87dkwtjA8KtIPZ6wWDDn704Ai3q33CF+FYWFp1c
         sxWyiI9MXYFsIaoDQUeuHfpjNrWYoqijK1OEaLSWBKHhpSDvvpYxxKVmTMd+1GI4omWm
         22LCyZVVQG/NRJmjY8D8dym5KoSNrBHDpldadFcV0k5XWgOo561ObwwPgdFMdtAtap1X
         3l6HAXBEjULMRIwwuqlKs97RTSoaAD/XeICSI9VgvLN9rWGIcLEeV76PQM68ffaypbht
         RJwK4pdHwk9qKGVB95p88b7GnaCgiq9J3vazjHpU+xB/TOAUVYxGaG44oG6BmC6o4olr
         H5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eX6EJTdHV8W5AjvTP6REm4fH1/SpIVw5AXuQai7r+rs=;
        b=LFZLjlv1dArFu+H3yir+4xhKCypK6mRbYwUYptY18JOXVDtZtdaZqq34zMPxRq7c8q
         8zhYW1mQgk3iCo57Wp2B9JuR12M5gKgiCm4fPMel0fpxVZpEPBDQcKrPu5urNHVTMpur
         DZv3jq2PoM/pAXAMs6jnKzsMFf7BQn9ne/zGeE5y2oEPQ4joQLswojJmPwl5SAHVO7tk
         M5Cl00GxHwkU2Ao3VyVS3zTyB/Iy2qMZTBQehzhTi5eluYKJ0S1VmttmlYggjdZMe1Vd
         AeUzMA6ChAIoO4NjdepYk1ferDXjjsuxjaobc/sDRx3QOrvSSXiuRdgQTIiMxBSrS7Ur
         fnEA==
X-Gm-Message-State: AHQUAuaNL2mi+TF3PhsOQ7648Bd2NPWg6hWztM2ZE4VvKeczyLTa+Nno
        KzKe92/HPlwb0SzgsmmNAl837g==
X-Google-Smtp-Source: AHgI3IbIilnOZiPAqOZ5AONrpIASHaGfLRcB3yWwGkOBQBfwSU28ZmV8PkOeMH01udfQTWuRrqP3bg==
X-Received: by 2002:a2e:98c8:: with SMTP id s8mr10931450ljj.84.1551123199758;
        Mon, 25 Feb 2019 11:33:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.85])
        by smtp.gmail.com with ESMTPSA id j14sm2739819lfc.28.2019.02.25.11.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:33:18 -0800 (PST)
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To:     Vignesh R <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <95344724-214f-20b7-b629-149ddf396117@cogentembedded.com>
Date:   Mon, 25 Feb 2019 22:33:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4910fda5-133d-7ebb-6ab3-49e0839ea920@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/2019 09:21 PM, Vignesh R wrote:

[...]

>>> HyperBus specification can be found at[1]
>>> HyperFlash datasheet can be found at[2]
>>>
>>> [1] https://www.cypress.com/file/213356/download
>>> [2] https://www.cypress.com/file/213346/download
>>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>>     Table 12-5741. HyperFlash Access Sequence
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
[...]
>>> diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
>>> new file mode 100644
>>> index 000000000000..d3d44aab7503
>>> --- /dev/null
>>> +++ b/drivers/mtd/hyperbus/core.c
[...]
>>> +int hb_register_device(struct hb_device *hbdev)
>>> +{
>>> +	struct resource res;
>>> +	struct device *dev;
>>> +	struct device_node *np;
>>> +	struct map_info *map;
>>> +	struct hb_ops *ops;
>>> +	int err;
>>> +
>>> +	if (!hbdev || !hbdev->dev || !hbdev->np) {
>>> +		pr_err("hyperbus: please fill all the necessary fields!\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	np = hbdev->np;
>>> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
>>> +		return -ENODEV;
>>> +
>>> +	hbdev->memtype = HYPERFLASH;
>>> +
>>> +	if (of_address_to_resource(np, 0, &res))
>>
>>     Isn't the direct mapping property of the HF controller, not of HyperFlash
>> itself?
>>
> 
> As I said in the cover letter, I could not find many examples of HF
> controllers, but couple of them that I studied provide MMIO access to
> flash. So, reg property of flash node would represent local address on
> the HyperBus and controller node would set up ranges properly to provide
> translation from CS to SoC address space.
> For example see patch 4/5 where reg property would indicate CS and Size
> of flash. This scheme is similar to whats described here [1]
> HBMC controllers usually have different MMIO regions to access flashes
> connected to different CS. So using ranges for address translation along
> with flash node describing local address works pretty well.
> 
> My understanding is that this part of code will be common for most MMIO
> based HB controllers and hence made part of core layer. But, if
> controllers uses different IO space for read vs write, then this needs a
> bit of thinking. In that case, mapping needs to be moved to controller
> drivers.
> 
> [1]https://elinux.org/Device_Tree_Usage#Ranges_.28Address_Translation.29
> 
>>> +		return -EINVAL;
>>> +
>>> +	dev = hbdev->dev;
>>> +	map = &hbdev->map;
>>> +	map->size = resource_size(&res);
>>> +	map->virt = devm_ioremap_resource(dev, &res);
>>> +	if (IS_ERR(map->virt))
>>> +		return PTR_ERR(map->virt);
>>> +
>>> +	map->name = dev_name(dev);
>>> +	map->bankwidth = 2;
>>> +
>>> +	simple_map_init(map);
>>
>>    It's not that simple, I'm afraid -- e.g. Renesas RPC-IF has read and write
>> mappings in the separate memory resources.
>>
> 
> Hmm, could you point me to public datasheet of the controller?

   See chapter 20 in [1]. Note that it's not the same SoC I'm developing for (R-Car
gen3 family, with NDA docs) but should be mostly the same RPC-IF core.

[1] https://www.renesas.com/us/en/doc/products/mpumcu/doc/rz/r01uh0746ej0200-rza2m.pdf?key=74862185b5e22ad09e648d21a35de615

> simple_map_init() provides default implementation for map operations
> which is overridden, if hb_ops is populated.
> I think, Renesas RPC-IF can populate custom hb_ops struct and use
> appropriate MMIO base for read vs write, while still reusing the map
> framework. Wouldnt that work?

   It probably would...

[...]

MBR, Sergei
