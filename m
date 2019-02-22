Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ABE2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u60RQXTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfBVKKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:10:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52278 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfBVKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:10:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1MA9kDu109161;
        Fri, 22 Feb 2019 04:09:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550830186;
        bh=apoHTan6JzXHFpHaPCv8g4uTUzEl9U7WoWzQbZC2Obs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u60RQXTNB2dSIKO6jvg4FdaFHk2BgD97HNOfmsuxowGHPllgv2z4+Fb+0uIkjj8F3
         Q6ZTd65yaJdFPcwoKIas+n75sHxy9wd2xZpHxizKrswzpIiHEAMdeS1Ty7etSN70yT
         IW2BXG4fAqDZUB2s8PiMfRDys83eh16ISUuuscV0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1MA9kLk047704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Feb 2019 04:09:46 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 22
 Feb 2019 04:09:45 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 22 Feb 2019 04:09:45 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1MA9gLs016416;
        Fri, 22 Feb 2019 04:09:43 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>
CC:     <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <41a9780b-d971-2b20-1ecb-c55852292563@ti.com>
 <20190218143508.GD15711@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <69b430b2-42a8-4c5a-0a6c-a05f2416fa0b@ti.com>
Date:   Fri, 22 Feb 2019 12:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218143508.GD15711@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/02/2019 16.35, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190216 03:30]:
>> On 2/12/2019 1:12 PM, Lokesh Vutla wrote:
>>> +TISCI Interrupt Router Node:
>>> +----------------------------
>>> +- compatible:		Must be "ti,sci-intr".
>>> +- interrupt-controller:	Identifies the node as an interrupt controller
>>> +- #interrupt-cells:	Specifies the number of cells needed to encode an
>>> +			interrupt source. The value should be 4.
>>> +			First cell should contain the TISCI device ID of source
>>> +			Second cell should contain the interrupt source offset
>>> +			within the device
>>> +			Third cell specifies the trigger type as defined
>>> +			in interrupts.txt in this directory.
>>> +			Fourth cell should be 1 if the irq is coming from
>>> +			interrupt aggregator else 0.
>>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>>
>> Please help me here. As said this is the TISCI device id for the host
>> interrupt controller. While sending message to the system co-processor
>> this ID needs to be specified so that the irq route gets discovered and
>> configured. Atleast with the current design device Ids are not
>> discoverable. Can you mention what can be improved here? Is there any
>> such example where a firmware supports querying the deivce ids?
>>
>> Also do you have any further comments on this patch?
> 
> No reg property above. So if the interrupt router is not accessible
> by Linux like you're saying, you should not set up a dts node for
> it at all.

It is accessible via tisci but no direct register access.

> 
> Regards,
> 
> Tony
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
