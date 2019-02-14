Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71D5222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L/ejjcrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390012AbfBNCmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:42:24 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33754 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfBNCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:42:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E2erlV089155;
        Wed, 13 Feb 2019 20:40:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550112053;
        bh=dDO+outF8+tsszf6ZRjZL6qnfcq9sWxqkfZKNtPDvME=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L/ejjcrWXj7wouqy+R4wumEuk49bdOYY1d9axjbJWvbhO8FihYhy0zYW1ZGVC8geQ
         YpdpKHexbo1DuQhdQvr7pxIGXhQPmsIwZ6q+AFs29n4XATUkvuk8Oc2uv16JkL0Ar2
         zooF/dQSV95W8nXjDfBPLTuI98X9Kq/dvkkcAtWo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E2er5c114864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 20:40:53 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 20:40:53 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 20:40:53 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E2eqPY031858;
        Wed, 13 Feb 2019 20:40:52 -0600
Subject: Re: [PATCH v2 03/14] dt-binding: irqchip: Add pruss-intc-irq driver
 for PRUSS interrupts
To:     Roger Quadros <rogerq@ti.com>, <tony@atomide.com>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-4-git-send-email-rogerq@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <aaf5e1c7-ae07-ab01-8047-cb95def2d740@ti.com>
Date:   Wed, 13 Feb 2019 20:40:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549290167-876-4-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 8:22 AM, Roger Quadros wrote:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
> interrupt controller (INTC) that can handle various system input
> events and post interrupts back to the device-level initiators.
> The INTC can support upto 64 input events with individual control
> configuration and hardware prioritization. These events are mapped
> onto 10 interrupt signals through two levels of many-to-one mapping
> support. Different interrupt signals are routed to the individual
> PRU cores or to the host CPU.
> 
> The PRUSS INTC platform driver manages this PRUSS interrupt
> controller and implements an irqchip driver to provide a Linux
> standard way for the PRU client users to enable/disable/ack/
> re-trigger a PRUSS system event. The system events to interrupt
> channels and host interrupts relies on the mapping configuration
> provided through a firmware resource table for now. This will be
> revisited and enhanced in the future for a better interface. The
> mappings will currently be programmed during the boot/shutdown
> of the PRU.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../interrupt-controller/ti,pruss-intc-irq.txt     | 51 ++++++++++++++++++++++

Better to name the file just ti,pruss-intc.txt.

Also, one minor nit, %s/dt-binding/dt-bindings/ on the the patch title.

regards
Suman

>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
> new file mode 100644
> index 0000000..c70221c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
> @@ -0,0 +1,51 @@
> +PRU ICSS INTC on TI SoCs
> +========================
> +
> +Each PRUSS has a single interrupt controller instance that is common to both
> +the PRU cores. Each interrupt controller can detect 64 input events which are
> +then mapped to 10 possible output interrupts through two levels of mapping. The
> +input events can be triggered by either the PRUs and/or various other PRUSS
> +internal and external peripherals. The first 2 output interrupts are fed
> +exclusively to the internal PRU cores, with the remaining 8 connected to
> +external interrupt controllers including the MPU.
> +
> +Required Properties:
> +--------------------
> +- compatible           : should be one of,
> +                             "ti,am3356-pruss-intc" for AM335x family of SoCs
> +                             "ti,am4376-pruss-intc" for AM437x family of SoCs
> +                             "ti,am5728-pruss-intc" for AM57xx family of SoCs
> +                             "ti,k2g-pruss-intc" for 66AK2G family of SoCs
> +- reg                  : base address and size for the PRUSS INTC sub-module
> +- reg-names            : should contain the string "intc"
> +- interrupts     : all the interrupts generated towards the main host
> +                   processor in the SoC. The format depends on the
> +                   interrupt specifier for the particular SoC's MPU
> +                   parent interrupt controller
> +- interrupt-names: should use one of the following names for each interrupt,
> +                   the name should match the corresponding host interrupt
> +                   number,
> +                       "host2", "host3", "host4", "host5", "host6",
> +                       "host7", "host8" or "host9"
> +                   NOTE: AM437x and 66AK2G SoCs do not have "host7" interrupt
> +                         connected to MPU
> +- interrupt-controller : mark this node as an interrupt controller
> +- #interrupt-cells     : should be 1. Client users shall use the PRU System
> +                         event number (the interrupt source that the client
> +                         is interested in) as the value of the interrupts
> +                         property in their node
> +
> +Example:
> +--------
> +		pruss_intc: intc@20000 {
> +			compatible = "ti,am3356-pruss-intc";
> +			reg = <0x20000 0x2000>;
> +			reg-names = "intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupts = <20 21 22 23 24 25 26 27>;
> +			interrupt-names = "host2", "host3", "host4",
> +					  "host5", "host6", "host7",
> +					  "host8", "host9";
> +		};
> +
> 

