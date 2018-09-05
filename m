Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835B8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E792075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lL29RMK0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Io5rBUZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E792075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIEN2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:28:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIEN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:28:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F64A607B5; Wed,  5 Sep 2018 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536137956;
        bh=9xwyrnshkOGixIrtkC0iuHyGTi/oQcfwLpnzFO3v4NU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lL29RMK0NbybkFkE/JeUc6MGyt7MMnzEyQmV647yqr/h+NBz89vtBycV5zZ5/7aPS
         f45/+/yXtSWyZvIWQ8H+uiHl8XK/0V+4wP+o3bPJkg10X1RWpFn0gPV5+pmP+ATqal
         TrO3LE0TOyBzYzT7SH1yzXiRhxOel6CuInbKLOv0=
Received: from [10.79.41.39] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F119660558;
        Wed,  5 Sep 2018 08:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536137954;
        bh=9xwyrnshkOGixIrtkC0iuHyGTi/oQcfwLpnzFO3v4NU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Io5rBUZaRDmUGLnHHfqyPDBzFzSESjtRBmjn0xZCGYJrpykDB5mNAih3JKkEQePHG
         T5ergtW6xSeeIZTXUjGZtzq8qyZnlvKdfPHKZuLryS6Bbpc0JSRwDeGTW44rzwZARO
         17tftD/qWBSBnk9RmkkVc/QZ9u2Deq1gU0DztIsg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F119660558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v2 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        kishon@ti.com, michal.simek@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     v.anuragkumar@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <1535976844-12494-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1535976844-12494-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <2831a270-a4d1-ba51-e13f-85c029bbe8c0@codeaurora.org>
Date:   Wed, 5 Sep 2018 14:29:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535976844-12494-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2018 5:44 PM, Anurag Kumar Vulisha wrote:
> This patch adds the document describing dt bindings for ZynqMP
> phy. ZynqMP SOC has a High Speed Processing System Gigabit
> Transceiver which provides PHY capabilties to USB, SATA,
> PCIE, Display Port and Ehernet SGMII controllers.
>
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>   changes in v2:
> 	1. None
> ---
>   .../devicetree/bindings/phy/phy-zynqmp.txt         | 104 +++++++++++++++++++++
>   1 file changed, 104 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-zynqmp.txt b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
> new file mode 100644
> index 0000000..2eed553
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
> @@ -0,0 +1,104 @@
> +Xilinx ZynqMP PHY binding
> +
> +This binding describes a ZynqMP PHY device that is used to control ZynqMP
> +High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides four lanes
> +and are used by USB, SATA, PCIE, Display port and Ethernet SGMMI controllers.
> +
> +Phy provider node
> +=================
> +
> +Required properties:
> +- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
> +		  "xlnx,zynqmp-psgtr-v1.1" has "xlnx,tx_termination_fix" removed
This is not very clear. You can rather mention this statement for the 
property.
e.g. In "xlnx,tx_termination_fix" you can write - this is not required 
for "xlnx,zynqmp-psgtr-v1.1.

> +
> +- reg           : Address and length of register sets for each device in
> +                  "reg-names"
> +
> +- reg-names     : The names of the register addresses corresponding to the
> +		  registers filled in "reg":
> +			- serdes: SERDES block register set
> +			- siou: SIOU block register set
> +
> +Optional properties:
> +- xlnx,tx_termination_fix : Include this for fixing functional issue with the
> +		  TX termination resistance in GT, which can be out of spec for
> +		  the XCZU9EG silicon version.
> +
> +Required nodes	:  A sub-node is required for each lane the controller
> +		   provides.
> +
> +Phy sub-nodes
> +=============
> +
> +Required properties:
> +lane0:
> +- #phy-cells	: Should be 4
> +
> +lane1:
> +- #phy-cells	: Should be 4
> +
> +lane2:
> +- #phy-cells	: Should be 4
> +
> +lane3:
> +- #phy-cells	: Should be 4
> +
> +Example:
> +	serdes: zynqmp_phy@fd400000 {

phy is not just the serdes. Also s/zynqmp_phy/phy

This could be:
                     zynqmp_phy: phy@fd400000

regards
Vivek
> +		compatible = "xlnx,zynqmp-psgtr-v1.1";
> +		status = "okay";
> +		reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
> +		reg-names = "serdes", "siou";
> +
> +		lane0: lane@0 {
> +			#phy-cells = <4>;
> +		};
> +		lane1: lane@1 {
> +			#phy-cells = <4>;
> +		};
> +		lane2: lane@2 {
> +			#phy-cells = <4>;
> +		};
> +		lane3: lane@3 {
> +			#phy-cells = <4>;
> +		};
> +	};
> +
> +Specifying phy control of devices
> +=================================
> +
> +Device nodes should specify the configuration required in their "phys"
> +property, containing a phandle to the phy port node and a device type.
> +
> +phys = <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_NUM LANE_FREQ>;
> +
> +PHANDLE                 = &lane0 or &lane1 or &lane2 or &lane3
> +CONTROLLER_TYPE         = PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_USB
> +			  or PHY_TYPE_DP or PHY_TYPE_SGMII
> +CONTROLLER_INSTANCE     = Depends on controller type used, can be any of
> +				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
> +				PHY_TYPE_SATA : 0 or 1
> +				PHY_TYPE_USB  : 0 or 1
> +				PHY_TYPE_DP   : 0 or 1
> +				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
> +LANE_NUM                = Depends on which lane clock is used as ref clk, can be
> +			  0 or 1 or 2 or 3
> +LANE_FREQ               = Frequency that controller can operate, can be any of
> +			  19.2Mhz,20Mhz,24Mhz,26Mhz,27Mhz,28.4Mhz,40Mhz,52Mhz,
> +			  100Mhz,108Mhz,125Mhz,135Mhz,150Mhz
> +
> +Example:
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +	usb@fe200000 {
> +		...
> +		phys	  = <&lane2 PHY_TYPE_USB3 0 2 2600000>;
> +		...
> +	};
> +
> +	ahci@fd0c0000 {
> +		...
> +		phys	  = <&lane3 PHY_TYPE_SATA 1 1 125000000>;
> +		...
> +	};

