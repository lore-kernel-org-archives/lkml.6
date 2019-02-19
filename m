Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE95C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F3A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mNKReiKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfBSQTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:19:54 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34738 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSQTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:19:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1JGJRV7068946;
        Tue, 19 Feb 2019 10:19:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550593167;
        bh=jOHJT6UlWarzkLKFO+IUQMq3LQJx+t9vnGb9QzLYNGE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mNKReiKMsPr1GCPgDNz7PB6+FcgtZfH5chulHPIJdVQHJH0YYEIWqwKCao768O8D1
         9lWqzJfXVytHmGGfsPmMkBCAqNBeTnJadD7VG4tf+rgfncJ15TjfVLR/y5VlAKnvLq
         8dUW4S0F7jCPebaypB0SYW7N3+5jiMGqieUyJ+H8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1JGJRNs080509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 10:19:27 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 10:19:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 10:19:27 -0600
Received: from [172.22.216.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1JGJM1E018181;
        Tue, 19 Feb 2019 10:19:23 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Tony Lindgren <tony@atomide.com>
CC:     <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20190213152620.GS5720@atomide.com>
 <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
 <20190218143245.GC15711@atomide.com>
 <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
 <20190219153537.GJ15711@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <6aa37276-0833-fdf5-575b-c3ca14f776a6@ti.com>
Date:   Tue, 19 Feb 2019 21:49:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190219153537.GJ15711@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/2019 9:05 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190219 08:51]:
>> Hi Tony,
>>
>> On 18/02/19 8:02 PM, Tony Lindgren wrote:
>>> * Lokesh Vutla <lokeshvutla@ti.com> [190216 03:30]:
>>>> On 2/15/2019 9:46 PM, Tony Lindgren wrote:
>>>>> The dts node for the interrupt controller should describe a
>>>>> proper Linux device, that is with reg entries and so on.
>>>>
>>>> You are asking to just keep the compatible property :)
>>>
>>> Right, and then I realized this node is missing the standard
>>> reg entry too. And you're saying the registers are not even
>>> accissible from Linux.
>>>
>>> So based on that IMO you should not even have a device tree
>>> node for it at all. You should just have the interrupt
>>
>> Practically lets look at what all I am adding in the DT node. Below is one such
>> example:
>>
>> main_intr: interrupt-controller0 {
>> 	compatible = "ti,sci-intr";
>> 	interrupt-controller;
>> 	interrupt-parent = <&gic500>;
>> 	#interrupt-cells = <4>;
>> 	ti,sci = <&dmsc>;
>> 	ti,sci-dst-id = <56>;
>> 	ti,sci-rm-range-girq = <0x1>;
>> };
>>
>> The following 4 properties are required at least for probing, to represent the
>> hierarchy and for  interrupt definition:
>> 	compatible = "ti,sci-intr";
>> 	interrupt-controller;
>> 	interrupt-parent = <&gic500>;
>> 	#interrupt-cells = <4>;
>>
>> The remaining 3 properties represents the TISCI interface. Let's go step by step:
>> * ti,sci = <&dmsc> :This is the phandle to the firmware protocol driver using
>> which the messages are sent
>> * ti,sci-dst-id = <56> : This is the TISCI device ID for the parent controller
>> for which your irqs needs to be connected. As I said this cannot be queried from
>> sysfw and this is the input to the messages that are send to sysfw.
> 
> Let's not add anything that does not describe hardware to the device
> tree. This is ID is an invented number used by the firmware.
> 
>> *  ti,sci-rm-range-girq = <0x1>: This define the ids using which the parent-irq
>> ranges that are allocated to this interrupt router instance can be queried from
>> sysfw.
>> If the above 2 properties are to be added as driver phandle then for every
>> instance of interrupt router in the SoC, a new compatible needs to be created. I
>> don't think this is a desirable solution.
> 
> To me it seems that the interrupt router _must_ have proper IO
> configuration registers available to the Linux running SoC.
> 
> Are you sure the interrupt route does not have proper IO
> configuration registers available for the Linux running SoC?
> 
> If the there are not, I'd be surprised how the SoC is designed :)
> 
> So assuming it does, you should just use the standard device tree
> reg property to differentiate between the various interrupt router
> instances. And then you can have the driver talk to the firmware
> in a way where the driver instances are separate even if no IO
> access to these shared registers is done by the Linux running SoC.
> 
> But see also the mux comment below.
> 
>> With this can you tell me how can we not have a device-tree and still support
>> irq allocation?
> 
> Using standard dts reg property to differentiate the interrupt
> router instances. And if the interrupt router is a mux, you should
> treat it as a mux rather than a chained interrupt controller.
> 
> We do have drivers/mux nowadays, not sure if it helps in this case
> as at least timer interrupts need to be configured very early.
> 
>> Also, this is not the first time a driver based on a firmware is being added.
>> K2g clock, power and reset drivers are based on this where device ids are being
>> passed from consumers. Similarly arm scpi based drivers are also available.
> 
> Having drivers communicate with firmware is quite standard.

yes. How different is this from any of the above mentioned drivers using
firmware specific ids. Like sci pm domain[1] driver utilizes the same
device id for enabling any device in the system. Similarly clock
driver[2] uses the same device ids and clock ids specified by firmware.
There are more which similarly represents firmware ids from DT.

[1] Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
[2] Documentation/devicetree/bindings/clock/ti,sci-clk.txt

Thanks and regards,
Lokesh

> 
> However, stuffing firmware specific data to the device tree
> does not describe the hardware and must not be done.
> 
> Regards,
> 
> Tony
> 
