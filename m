Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB0C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC5A205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC5A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeKASQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:16:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52242 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeKASQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:16:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA19Dvhk043673;
        Thu, 1 Nov 2018 04:13:57 -0500
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA19Dv5E070052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 04:13:57 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 1 Nov
 2018 04:13:56 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 1 Nov 2018 04:13:56 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA19Dr5P013962;
        Thu, 1 Nov 2018 04:13:54 -0500
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        <jason@lakedaemon.net>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, <tglx@linutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <b3a71622-7734-04be-0b0c-38e9dc6542d4@ti.com>
 <63ba5353-8470-b4c1-64a8-a1df5bf48614@ti.com>
 <86va5myz7t.wl-marc.zyngier@arm.com>
 <81136b74-4b45-f44b-0168-23d191a4fb5e@ti.com>
 <49029695-79a0-141b-a9da-9764cb0ed60f@ti.com>
 <86bm792mv2.wl-marc.zyngier@arm.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f7b6d570-a8f4-6f8b-7995-eac69fef8fa1@ti.com>
Date:   Thu, 1 Nov 2018 11:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86bm792mv2.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 11/1/18 11:00 AM, Marc Zyngier wrote:
> On Thu, 01 Nov 2018 07:55:12 +0000,
> Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>
>> Lokesh,
>>
>> On 10/29/18 3:04 PM, Lokesh Vutla wrote:
>>>>> With the above information, linux should send a message to
>>>>> system-controller using TISCI protocol. After policing the given
>>>>> information, system-controller does the following:
>>>>> - Attaches the interrupt(INTA input) to the device resource index
>>>>> - Muxes the interrupt(INTA input) to corresponding vint(INTA output)
>>>>> - Muxes the vint(INTR input) to GIC irq(INTR output).
>>>>
>>>> Isn't there a 1:1 mapping between *used* INTR inputs and outputs?
>>>> Since INTR is a router, there is no real muxing. I assume that the
>>>> third point above is just a copy-paste error.
>>>
>>> Right, my bad. INTR is just a router and no read muxing.
>>
>> INTR can mux M interrupt inputs to N interrupt outputs.
>> One selects which interrupt input is outputted on the given interrupt
>> output.
>> It is perfectly valid (but not sane) to select the same interrupt input
>> to be routed to _all_ interrupt output for example.
>>
>> Not sure if we are going to use this for anything but 1:1 mapping, but
>> might worth keeping in mind...
> 
> It's not obvious how you'd use this "feature". Interrupt replicator,
> should one of the output be tied to another part of the system? Or
> maybe that's just the result of reusing some generic block...

I think the intention is that different virtualized OS would got
assigned with different range of NAVSS GIC irqs and there might be a
case when more than one virtualized environment need to get a GIC irq
for the same virt. Timer interrupts comes to mind first, but there could
be other cases when the same virt should trigger on multiple GIC line.

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
