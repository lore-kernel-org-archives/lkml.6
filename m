Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5851D2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SRD0XwD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfBTFyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:54:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41740 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfBTFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:54:37 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1K5sIOZ019096;
        Tue, 19 Feb 2019 23:54:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550642058;
        bh=sz7cGng5/KGycFJZzxpMVGsRKEFdiA/HXVdfQSBlvYQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SRD0XwD+qiZlm16rvhAjKUOTx9ypLmSGQoptxLQGzMoya0EjpLoxx/tiV219uN5//
         FpSYjHkZ6P1Khsrdaa9nZRT3IQockvxRA/PDkn9V+Ms/qwxjeFvJZE3oRERyTRN2u5
         rCmfnDsdq67rhc8pyFqNkeT04g0gg6RFOqrxhGuQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1K5sIsM099366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 23:54:18 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 23:54:18 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 23:54:17 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1K5sDjN023318;
        Tue, 19 Feb 2019 23:54:14 -0600
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
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
 <20190218143245.GC15711@atomide.com>
 <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
 <20190219153537.GJ15711@atomide.com>
 <6aa37276-0833-fdf5-575b-c3ca14f776a6@ti.com>
 <20190219171104.GM15711@atomide.com> <20190219175651.GN15711@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <884a59a0-81e8-738e-9f26-c2b66ec71af1@ti.com>
Date:   Wed, 20 Feb 2019 11:23:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190219175651.GN15711@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 19/02/19 11:26 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [190219 17:11]:
>> * Lokesh Vutla <lokeshvutla@ti.com> [190219 16:19]:
>>> yes. How different is this from any of the above mentioned drivers using
>>> firmware specific ids. Like sci pm domain[1] driver utilizes the same
>>> device id for enabling any device in the system. Similarly clock
>>> driver[2] uses the same device ids and clock ids specified by firmware.
>>> There are more which similarly represents firmware ids from DT.
>>>
>>> [1] Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>> [2] Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>>
>> That's horrible. We really must not use any firmware invented
>> numbers in the device as they do not describe hardware.
> 
> No firmware invented numbers in the device tree I mean naturally.
> Drivers do whatever they need to do to deal with the firmware.

Let's look at these similar other examples available inside Linux:

1: ./Documentation/devicetree/bindings/arm/arm,scmi.txt mentions the following:
- #clock-cells : Should be 1. Contains the Clock ID value used by SCMI commands.
- #power-domain-cells : Should be 1. Contains the device or the power
                                        domain ID value used by SCMI commands.

2: Documentation/devicetree/bindings/arm/arm,scpi.txt mentions the following:
- #power-domain-cells : Should be 1. Contains the device or the power
                             domain ID value used by SCPI commands.

3: Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
the firmware specified identifier are defined in the following header files:
	include/dt-bindings/clock/tegra186-clock.h
	include/dt-bindings/power/tegra186-powergate.h
	include/dt-bindings/reset/tegra186-reset.h

4. Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
mentions the following:
"Output clocks are registered based on clock information received
from firmware. Output clocks indexes are mentioned in
include/dt-bindings/clock/xlnx,zynqmp-clk.h."

5. Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt mentions the
following:
 - #power-domain-cells:  Must be 1. Contains the Resource ID used by
                          SCU commands.
                          See detailed Resource ID list from:
                          include/dt-bindings/firmware/imx/rsrc.h
- The clock consumer should specify the desired clock by having the clock
ID in its "clocks" phandle cell.
See the full list of clock IDs from: include/dt-bindings/clock/imx8qxp-clock.

6. Documentation/devicetree/bindings/arm/psci.txt have the following properties:
- cpu_suspend   : Function ID for CPU_SUSPEND operation
- cpu_off       : Function ID for CPU_OFF operation
- cpu_on        : Function ID for CPU_ON operation
- migrate       : Function ID for MIGRATE operation

All the above examples uses the firmware identifiers for devices/clocks or for
other functionalities and use them directly in DT. These are all somewhat
similar to TI sysfw which runs on a micro-controller and tries to abstract
certain functionalities from HLOS. There are many more such examples but I
listed only a few users. The feedback you are providing is not going to work for
any of the above listed firmware interfaces.

Thanks and regards,
Lokesh
