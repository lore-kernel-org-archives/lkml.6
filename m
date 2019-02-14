Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50190C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224212080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UmPLlVjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406395AbfBNSDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:03:12 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfBNSDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:03:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EI2lYe056926;
        Thu, 14 Feb 2019 12:02:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550167367;
        bh=TyeFhSeiB4gBSfF4UAN/KmwNu1tdEGuwbrCrHcFDv50=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UmPLlVjL87IB7ScVdeoaXCx6gH7AOhEeJzlDjYIdf0XuJo+yHaHEjV+DUS/U3YU6E
         q4RQmsj/M/nX1eMrkANBBoF1tXVGPGIHiF/hTEYx7OG6WAAWPqwJc0canaL8aUQ7dr
         K2lyfXQfwBrXG9ob9xDOnt8DBgWPP/nsgQ/Ypi8I=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EI2ltF031838
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 12:02:47 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 12:02:47 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 12:02:47 -0600
Received: from [172.22.218.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EI2g69012059;
        Thu, 14 Feb 2019 12:02:43 -0600
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
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
 <20190213152620.GS5720@atomide.com>
 <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
Date:   Thu, 14 Feb 2019 23:32:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214174612.GF5720@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 2/14/2019 11:16 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190214 17:32]:
>> Hi Tony,
>> 	Please do not snip the on going discussion.
>>
>> On 2/14/2019 9:11 PM, Tony Lindgren wrote:
>>> * Lokesh Vutla <lokeshvutla@ti.com> [190214 08:39]:
>>>> IMHO, device ids are something which can be used in DT. There are many other
>>>> things like the interrupt ranges etc.. which are discoverable from sysfw and we
>>>> are implementing it.
>>>
>>> We need to describe hardware in the device tree, not firmware.
>>>
>>> If you have something discoverable from the firmware, you should
>>> have the device driver query it from sysfw based on a hardware
>>> property, not based on some invented enumeration in the firmware.
>>
>> Yes we are already querying sysfw for all the irq ranges that can be
>> discoverable. The topic of discussion here is about the parent interrupt
>> controller id. I am not sure how you are expecting an id be discoverable
>> from system firmware especially with a name.
> 
> Well names are quite standard in dts (but should be used with
> the phandle + offset). Think for example interrupt-names and
> reg-names :)
> 
>>> If there is some device to firmware translation needed, hide that
>>> into the device driver and keep it out of the device tree.
>>
>> If preferred this can be moved to of_match_data attached to each
>> compatible property. Then for each SoC a new compatible needs to be created.
> 
> Hiding the ID into the device driver and compatible property
> makes sense to me if the id is based on SoC + firmware.
> 
> But I'd rather have a proper hardware based phandle + index
> type mapping in the dts if possible though.

The idea about sysfw here is that Linux is not aware of anything about
this device(Interrupt Router). It cannot even access any of its
registers. As a user Linux should know who is the parent to which the
Interrut router output should be configured. Then query sysfw about the
range of gic irqs allocated to it. Now for configuration, Linux should
pass the the input to interrupt router, gic irq no, and gic id(by which
sysfw uniquely identifies GIC interrupt controller with the SoC).  Based
on these parameters Interrupt Router registers gets configured.

So for the above configuration we need the gic_id for which the dt
property "ti,sci-dst-id" is used.

Thanks and regards,
Lokesh

> 
> What does this id really consist of?
> 
> Regards,
> 
> Tony
> 
