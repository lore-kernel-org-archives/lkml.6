Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDCDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15A32083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FCLmgLr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBTRSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:18:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42018 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:18:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KHHhto102413;
        Wed, 20 Feb 2019 11:17:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550683063;
        bh=rPoFQSzC+GGsfVyODESrqjeKkCqvKgkYGCLIAc8r0/o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FCLmgLr1ny2q2zpCxog2TyXwvlBJFnq9FDAQtHbe3vFB2ErUT1nwMkPqRIYzs8GKz
         JJnWqO+V9Ed3HzgQtWC2IVWvMRFvahZODKEeW/p1pCUF/mSpWREpLmtAp9wL0fJ7m8
         nLs7LupXLUqssk4emT+wPqLKXdmhRb6eeoxT1lCA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KHHhCF123643
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 11:17:43 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 11:17:43 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 11:17:43 -0600
Received: from [172.22.219.123] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KHHc1Q030260;
        Wed, 20 Feb 2019 11:17:39 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Tony Lindgren <tony@atomide.com>
CC:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        <jason@lakedaemon.net>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <marc.zyngier@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, <tglx@linutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
 <20190218143245.GC15711@atomide.com>
 <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
 <20190219153537.GJ15711@atomide.com> <20190220163651.GS15711@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <ffc39399-a6bc-aabf-b701-d419346f9a71@ti.com>
Date:   Wed, 20 Feb 2019 22:47:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190220163651.GS15711@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 2/20/2019 10:06 PM, Tony Lindgren wrote:
> Hi,
> 
> Some more info on chained irq vs mux below that might
> help.
> 
> * Tony Lindgren <tony@atomide.com> [190219 15:36]:
>> * Lokesh Vutla <lokeshvutla@ti.com> [190219 08:51]:
>>> With this can you tell me how can we not have a device-tree and still support
>>> irq allocation?
>>
>> Using standard dts reg property to differentiate the interrupt
>> router instances. And if the interrupt router is a mux, you should
>> treat it as a mux rather than a chained interrupt controller.
>>
>> We do have drivers/mux nowadays, not sure if it helps in this case
>> as at least timer interrupts need to be configured very early.
> 
> Adding Linus Walleij to Cc since he posted a good test to
> consider if something should use chained (or nested) irq:
> 
> "individual masking and ACKing bits and can all be used at the
>  same time" [0]

Interrupt Router just routes M inputs to N outputs. One input can only
be mapped to one output. This is a clear case of a hierarchical domain
and the driver is implementing it.

Thanks and regards,
Lokesh

> 
> Not sure if we have that documented somewhere?
> 
> But seems like the interrupt router should be set up as
> a separate mux driver talking with firmware that the
> interrupt controller driver calls on request_irq(>
> Cheers,
> 
> Tony
> 
> 
> [0] https://marc.info/?l=linux-omap&m=155065629529311&w=2
> 
