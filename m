Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C345222E2
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TxoUSYdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbfBPDa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 22:30:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38676 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfBPDa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 22:30:26 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1G3U3aZ066248;
        Fri, 15 Feb 2019 21:30:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550287803;
        bh=106JMjXimU+WPPBqfrwCpGITtJ6kNNDBeFVCsvLZiSA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TxoUSYdRxyoQqJlkWurK/NV0joRVSvmNdNDO4AVyOvRW7o7buzbLjGkN0vPtNE5nL
         29MZv58ba5i8C2qCecNeoUNBsltaN3/REjk0t1YDtubWyJb+49Ir0VGLRBkeNqKCw9
         wMnoiyuWVqGR5g7XUNrGBSOz1dxFYUzEO2kZSnTo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1G3U29W105079
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 21:30:02 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 21:30:01 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 21:30:01 -0600
Received: from [172.22.218.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1G3Tupg002588;
        Fri, 15 Feb 2019 21:29:57 -0600
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
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
Date:   Sat, 16 Feb 2019 08:59:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215161629.GK5720@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 2/15/2019 9:46 PM, Tony Lindgren wrote:
> Hi,
> 
> * Lokesh Vutla <lokeshvutla@ti.com> [190214 18:03]:
>> On 2/14/2019 11:16 PM, Tony Lindgren wrote:
>>> But I'd rather have a proper hardware based phandle + index
>>> type mapping in the dts if possible though.
>>
>> The idea about sysfw here is that Linux is not aware of anything about
>> this device(Interrupt Router). It cannot even access any of its
>> registers. As a user Linux should know who is the parent to which the
>> Interrut router output should be configured. Then query sysfw about the
>> range of gic irqs allocated to it. Now for configuration, Linux should
>> pass the the input to interrupt router, gic irq no, and gic id(by which
>> sysfw uniquely identifies GIC interrupt controller with the SoC).  Based
>> on these parameters Interrupt Router registers gets configured.
> 
> If the interrupt router hardawre is hidden away from Linux,
> just leave it out of the device tree completely and have the
> interrupt controller driver request the routing.

Yes while requesting you should at-least specify which is your
destination interrupt-controller Else how does the sysfw even know to
whom the requester wants the routing to happen to. You do know that we
are dealing with a heterogeneous system where there are more the one
destination interrupt controllers(GIC, R5 VIM  etc etc..). This is what
the DT property is specifying and we cannot query a device based on a name.

> 
> The dts node for the interrupt controller should describe a
> proper Linux device, that is with reg entries and so on.

You are asking to just keep the compatible property :)

I am no where denying that. But the cases where the firmware does the
configuration DT spec[1] clearly mentions about the interface.

Please take a look at arm-psci devicetree binding documentation where
the function ids are represented using which each psci function is invoked.

[1]
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf

Thanks and regards,
Lokesh
