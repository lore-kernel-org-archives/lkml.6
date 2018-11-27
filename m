Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63FDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C742208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QVeB8Rl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C742208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeK1COe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:14:34 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53042 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeK1COd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:14:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wARFFLtm093657;
        Tue, 27 Nov 2018 09:15:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543331721;
        bh=TjH96HAlbehP3DgCs94YvkfYAyB6/y9hWw6pfLRHTF8=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=QVeB8Rl2sq1xkdt00G7R6/QJIjb2GA0YTIsC6rZoT6N4m0XE6xB+5Xo/Q9x3Dr8Da
         mRUmTi/tXq1II2ZM21pAwsdXKc0SgV/O8uWq6da9MTGy/tUlJY2jvAjqJthejND5cG
         JgJ/vE7eDQrlCLqN/zp3qMJnEmupVToaKjWk8zFg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wARFFLwL061501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 09:15:21 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 27
 Nov 2018 09:15:20 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 27 Nov 2018 09:15:20 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wARFFGdn024408;
        Tue, 27 Nov 2018 09:15:16 -0600
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     David Lechner <david@lechnology.com>, <tony@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <a4fe952b-9065-d91b-4c07-984ec3f5b276@lechnology.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFD5F83.3070807@ti.com>
Date:   Tue, 27 Nov 2018 17:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <a4fe952b-9065-d91b-4c07-984ec3f5b276@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/11/18 23:14, David Lechner wrote:
> On 11/22/18 5:38 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> This patch adds the bindings for the Programmable Real-Time Unit
>> and Industrial Communication Subsystem (PRU-ICSS) present on various
>> TI SoCs. The IP is present on multiple TI SoC architecture families
>> including the OMAP architecture SoCs such as AM33xx, AM437x and
>> AM57xx; and on a Keystone 2 architecture based 66AK2G SoC. It is
>> also present on the Davinci based OMAPL138 SoCs and K3 architecture
>> based AM65x SoCs as well (not covered for now). Details have been
>> added to include bindings for various core sub-modules like the PRU
>> Cores, the PRUSS Interrupt Controller, and other sub-modules used
>> for Industrial Communication purposes, covering the MDIO, MII_RT
>> and the IEP sub-modules. The binding mostly uses standard DT
>> properties.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   .../devicetree/bindings/soc/ti/ti,pruss.txt        | 360 +++++++++++++++++++++
>>   1 file changed, 360 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>> new file mode 100644
>> index 0000000..24fedad
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
> 
> ...
> 
>> +
>> +PRU-ICSS SoC Bus Parent Node
>> +=============================
>> +This node represents the integration of the PRU-ICSS IP into a SoC, and is
>> +required for all SoCs. The PRU-ICSS parent nodes need to be defined as child
>> +nodes of this node.
>> +
>> +Required Properties:
>> +--------------------
>> +- compatible     : should be one of,
>> +                       "ti,am3356-pruss-soc-bus" for AM335x family of SoCs
>> +                       "ti,am4376-pruss-soc-bus" for AM437x family of SoCs
>> +                       "ti,am5728-pruss-soc-bus" for AM57xx family of SoCs
>> +                       "ti,k2g-pruss-soc-bus" for 66AK2G family of SoCs
>> +- reg            : address and size of the PRUSS CFG sub-module registers
>> +                   dictating the interconnect configuration
> 
> I haven't looked into Tony's suggestion of using ti-sysc yet, so this may be a
> moot point, but how will this work with AM18xx that does not have a PRUSS CFG
> register? It seems to me that reg here should be the address and size of the
> entire PRUSS IP block and the CFG register should be a syscon node or something
> like that.

The reg property description is incorrect in the patch. It should have been

reg		: address of SYSCFG register.

The SYSCFG register is used to enable and reset the module.

But based on Tony's suggestion this wrapper driver will change to ti,sysc for
OMAP like SoCs.

For AM18xx it could be a simple wrapper driver that just populates the children?

> 
>> +- #address-cells : should be 1
>> +- #size-cells    : should be 1
>> +- ranges         : standard ranges definition
>> +
> 
> ...
> 
>> +
>> +PRUSS INTC Child Node
>> +======================
>> +Each PRUSS has a single interrupt controller instance that is common to both
>> +the PRU cores. Each interrupt controller can detect 64 input events which are
>> +then mapped to 10 possible output interrupts through two levels of mapping. The
>> +input events can be triggered by either the PRUs and/or various other PRUSS
>> +internal and external peripherals. The first 2 output interrupts are fed
>> +exclusively to the internal PRU cores, with the remaining 8 connected to
>> +external interrupt controllers including the MPU.
> 
> FYI, on AM18xx, there is a PRUSSEVTSEL bit in CFGCHIP3[3] (already a syscon node
> in the device tree) that allows selecting one of two groups of 32 input events
> out of this group of 64. This is perhaps getting out of the scope of this patch
> series, but I just want to make sure we end up with something that can be easily
> extended for this case. For example, I was thinking that this binding could be
> modified so that #interrupt-cells could be 1 or 2. If it is 2, then the first
> cell specifies the PRUSSEVTSEL value and the second value is the event number.
> 

this is da850.dtsi correct?

As PRUSSEVTSEL is not SYSEVENT specific but applies to all the SYSEVENTs at a time.
I don't think interrupt-cells is the right place to specify this.

Can it be set in DT in the board file? But this can't change once booted so maybe restrictive.

If runtime change is required it can only be done before a PRU boots.

How about providing this info in the resource table and/or application DT node?

> 
>> +
>> +Required Properties:
>> +--------------------
>> +- compatible           : should be one of,
>> +                             "ti,am3356-pruss-intc" for AM335x family of SoCs
>> +                             "ti,am4376-pruss-intc" for AM437x family of SoCs
>> +                             "ti,am5728-pruss-intc" for AM57xx family of SoCs
>> +                             "ti,k2g-pruss-intc" for 66AK2G family of SoCs
>> +- reg                  : base address and size for the PRUSS INTC sub-module
>> +- reg-names            : should contain the string "intc"
>> +- interrupt-controller : mark this node as an interrupt controller
>> +- #interrupt-cells     : should be 1. Client users shall use the PRU System
>> +                         event number (the interrupt source that the client
>> +                         is interested in) as the value of the interrupts
>> +                         property in their node
>> +
>> +
>> +PRU Child Node
>> +===============
>> +Each PRUSS has dual PRU cores, each represented by a PRU child node. Each node
>> +can optionally be rendered inactive by using the standard DT string property,
>> +"status".
>> +
>> +Required Properties:
>> +--------------------
>> +- compatible     : should be
>> +                       "ti,am3356-pru" for AM335x family of SoCs
>> +                       "ti,am4376-pru" for AM437x family of SoCs
>> +                       "ti,am5728-pru" for AM57xx family of SoCs
>> +                       "ti,k2g-pru" for 66AK2G family of SoCs
>> +- reg            : base address and size for each of the 3 sub-module address
>> +                   spaces as mentioned in reg-names, and in the same order as
>> +                   the reg-names
>> +- reg-names      : should contain each of the following 3 names, the binding is
>> +                   agnostic of the order of these reg-names
>> +                       "iram" for Instruction RAM,
>> +                       "control" for the CTRL sub-module registers,
>> +                       "debug" for the Debug sub-module registers,
>> +- firmware-name  : should contain the name of the default firmware image file
>> +                   located on the firmware search path
> 
> What does the default firmware do? It doesn't seem like this could be useful
> since the PRU doesn't have a definite purpose.

There is no such firmware. I think I'll drop "default" from the description.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
