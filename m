Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C105D222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q9JOUjU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfBMEXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:23:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57972 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfBMEXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:23:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1D4NDX4126177;
        Tue, 12 Feb 2019 22:23:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550031793;
        bh=w3g572h+/a9Ug8FKJQmOpurnxf+kco42ybZ0QjAXzQk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q9JOUjU+OcwXHdHVVODzTZo3UmTlZ57v2se0Y7ioWPqQRm+AUZBj/6A23kVWbUg16
         XCIrxAsbv0spjuJ4MLvmCrwd16bNqYxucgFu5R8bTnZCgMJqTb+C3HijiZSZteenFZ
         /oZupLYNznHQJw6+nVZymOrRmR6//NQkWoI0A3hw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1D4NDRH010593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 22:23:13 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 22:23:13 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 22:23:13 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1D4N8kb014510;
        Tue, 12 Feb 2019 22:23:09 -0600
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
 <20190212163018.GL5720@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <5b5d86b9-2aa7-718c-c1da-70bbf9bf589e@ti.com>
Date:   Wed, 13 Feb 2019 09:52:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190212163018.GL5720@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 12/02/19 10:00 PM, Tony Lindgren wrote:
> Hi,
> 
> * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
>> +The Interrupt Router (INTR) module provides a mechanism to route M
>> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
>> +to be driven per N output. There is one register per output (MUXCNTL_N) that
>> +controls the selection.
>> +
>> +
>> +                                 Interrupt Router
>> +                             +----------------------+
>> +                             |  Inputs     Outputs  |
>> +        +-------+            | +------+             |
>> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
>> +        +-------+            | +------+             |      controller
>> +                             |    .        +-----+  |      +-------+
>> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
>> +        | INTA  |----------->|    .        +-----+  |      +-------+
>> +        +-------+            |    .          .      |
>> +                             | +------+      .      |
>> +                             | | irqM |    +-----+  |
>> +                             | +------+    |  N  |  |
>> +                             |             +-----+  |
>> +                             +----------------------+
> 
> Is this always one-to-one mapping or can the same interrupt be routed to
> multiple targets like to the SoC and some coprocessor?

Yes, it is always one-to-one. Output of INTR can only be attached to one of the
processor.

> 
>> +Configuration of these MUXCNTL_N registers is done by a system controller
>> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
>> +controller will keep track of the used and unused registers within the Router.
>> +Driver should request the system controller to get the range of GIC IRQs
>> +assigned to the requesting hosts. It is the drivers responsibility to keep
>> +track of Host IRQs.
>> +
>> +Communication between the host processor running an OS and the system
>> +controller happens through a protocol called TI System Control Interface
>> +(TISCI protocol). For more details refer:
>> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> 
> Care to describe a bit why the interrupts need to be routed by a system
> controller?

K3 architecture defines a heterogeneous system where multiple heterogeneous
cores are serving its own usecases. Given that there are multiple ways in which
a device IRQ can be routed using INTR, like either it can be routed to HLOS
core(A53 int this case) or it can be routed to any other coprocessor available
in the system(like R5). If every sw running in each co-processor is allowed to
program this INTR then there is a high probability that one sw executing on one
core can damage other heterogeneous core.  Mainly to avoid this damage the
configuration of all the INTRs and INTAs are done in a centralized place(sysfw).
Any user for programming its IRQ route should send a message to sysfw with the
parameters. These parameters are policed by sysfw and does the configuration.


Thanks and regards,
Lokesh
