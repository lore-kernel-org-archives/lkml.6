Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5BEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9D42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="EJ0CesKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfBZLIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:08:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45986 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:08:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id h10so9292996lfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 03:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MmT2bhGXf855NhayL42e55l02s2pwbtP++zHTAeMAB4=;
        b=EJ0CesKu9JJXTrSgIGnzNfwmDzOa/sCoUwTHteG6cDHIfDPVoV0G46+NH8wSJCPUTC
         UzWYrvGtUWtIrlFrF/NZdhoILm9aVnmZmlytvzZTdqSpQnWSrh2RsXA2aJDSHXpqo/gU
         WvVXqsHSV31dHg5jzI08chgk9ttfqns8Ou5Kbud6TY35v59rhVEd7UP4p9U7dWedQAUy
         +qCMgFfHd03ktyj9kG26yCd90zIZh2hKqRnnfwi7gGnKTGIftBzBDLaXftNrFzfGkXvQ
         0MEQtF+OpDV0Bjaf3R6qz+fFJdiEl8Wf5vLSvszcQULs3GZqUIgB1p8A9/FRzCA7ZZZ+
         xEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MmT2bhGXf855NhayL42e55l02s2pwbtP++zHTAeMAB4=;
        b=mcAzkrHm4tbyP3IwkY3j7xgRv69vJrsfNS6rD9MU9GEN88weHXBKvwSFrFeUORPskl
         RQH4ZrBN3+xMIYh5gWjH/RBZqjftQ03B53DOTAArnf+djk7RPShbDEgjO03n0DoqUchY
         EkPeY3V2ODyLxYAc1wLfXk75sJG6tuLmq7PjxrWb5rgV8KNsHOT+6PMiXE7lhbtPIajl
         E/mkGFN1b/shNm9Ua1D3CEtgecG5UeQDrq3GgE2uZ3Re9/77luzJF8IiUPavocfyP0vF
         FOAlGCrkaS8/8CWhu3EQNtALFJaFMupi2s2VRYE0gBkMb+212lVhf1OR6OQXiu7qN3gg
         B8Rw==
X-Gm-Message-State: AHQUAua+Q5zmic6q/LAfdVAUgBDUD3XCfVljVQG7EUYF831ltkUAetHB
        KgNOvVzwhtm+TumsEZVTSOJjGg==
X-Google-Smtp-Source: AHgI3IargzVnZuZNT2i0KKBttBtDjolDxs+rDNmvDRV1sPMNY6K9rgEJZHp9WqwS+8eYM/RD3ucJaA==
X-Received: by 2002:a19:4354:: with SMTP id m20mr12920293lfj.115.1551179317931;
        Tue, 26 Feb 2019 03:08:37 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.91])
        by smtp.gmail.com with ESMTPSA id g194sm3077350lfg.55.2019.02.26.03.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 03:08:37 -0800 (PST)
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
 <95344724-214f-20b7-b629-149ddf396117@cogentembedded.com>
 <1137312b-c326-9e41-4667-e2126649f384@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a208a121-53a7-7d9a-c2db-ba135e17d3a0@cogentembedded.com>
Date:   Tue, 26 Feb 2019 14:08:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1137312b-c326-9e41-4667-e2126649f384@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2019 01:26 PM, Vignesh R wrote:

>> [...]

>>>>> HyperBus specification can be found at[1]
>>>>> HyperFlash datasheet can be found at[2]
>>>>>
>>>>> [1] https://www.cypress.com/file/213356/download
>>>>> [2] https://www.cypress.com/file/213346/download
>>>>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>>>>     Table 12-5741. HyperFlash Access Sequence
>>>>>
>>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> [...]
>>>>> diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
>>>>> new file mode 100644
>>>>> index 000000000000..d3d44aab7503
>>>>> --- /dev/null
>>>>> +++ b/drivers/mtd/hyperbus/core.c
>> [...]
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	dev = hbdev->dev;
>>>>> +	map = &hbdev->map;
>>>>> +	map->size = resource_size(&res);
>>>>> +	map->virt = devm_ioremap_resource(dev, &res);
>>>>> +	if (IS_ERR(map->virt))
>>>>> +		return PTR_ERR(map->virt);
>>>>> +
>>>>> +	map->name = dev_name(dev);
>>>>> +	map->bankwidth = 2;
>>>>> +
>>>>> +	simple_map_init(map);
>>>>
>>>>    It's not that simple, I'm afraid -- e.g. Renesas RPC-IF has read and write
>>>> mappings in the separate memory resources.
>>>>
>>>
>>> Hmm, could you point me to public datasheet of the controller?
>>
>>    See chapter 20 in [1]. Note that it's not the same SoC I'm developing for (R-Car
>> gen3 family, with NDA docs) but should be mostly the same RPC-IF core.
>>
>> [1] https://www.renesas.com/us/en/doc/products/mpumcu/doc/rz/r01uh0746ej0200-rza2m.pdf?key=74862185b5e22ad09e648d21a35de615
> 
> Thanks for the info!
> 
>>> simple_map_init() provides default implementation for map operations
>>> which is overridden, if hb_ops is populated.
>>> I think, Renesas RPC-IF can populate custom hb_ops struct and use
>>> appropriate MMIO base for read vs write, while still reusing the map
>>> framework. Wouldnt that work?
>>
>>    It probably would...
>
> Looking at above link, I see there are two HBMC controllers on Renesas
> SoC. One is a dedicated HBMC controller(chapter 21) very similar to that

   We don't have this one in the R-Car gen3 -- I wasn't even aware of it. :-)
RZ/A2 is newer than gen3 SoCs.

> on TI SoC and a SPI Multi I/O Bus Controller (chapter 20) that also
> supports Hyperbus protocol.

   That matches to the gen3 RPC-IF core.

> AFAICS, passing custom hb_ops is good enough to support both HW needs.
> Let me know if something is missing. I would greatly appreciate if you
> could test this series with your HW.

   Yes, I have stated the conversion from the simple mapping driver.

MBR, Sergei
