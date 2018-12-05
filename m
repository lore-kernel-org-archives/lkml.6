Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61924C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18356206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544048437;
	bh=VQoqSaVMZFDthQAo7eBJd3roUYPT88/va0T3vvGe+EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cxkGbZ50zetQ0feisvcIMPrUFy4GZcB3grhdqNFkmIiIig6zi5F/Nu5gvS/J6sWzK
	 XvZQcysDjejsFMlSpFekouL+xaPWwAfMpnb8LTbXgTyF+olSm1AEtXOojWh1kKD+63
	 sSOcyDBWaMnelG/3Yoade0GWKyNuLt7N/rSdjjN8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18356206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeLEWUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:20:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43225 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLEWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:20:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so20173720otr.10;
        Wed, 05 Dec 2018 14:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HhPdi+y+PxZsxr2Dncydj46LHKsX2ak15vIhUv+lItc=;
        b=sibTYiIkAROwQw8WZM+f7nMm90v50d5ujJVxIjlcDO1p5XvP4sjtuJ+WLmLhlsXtZ0
         MlI9s6GQ2t6rGb2sDaAYLboblcyGcn466PJzQVDYywrzntyYotzntJ5tFHaDVvEBI9Nx
         51ap7+zLjHafRgoxGDo7CmYJHZOt6M8KfXtYNhrTuCnI7G1wSb6z8YIP+ByX3wNERItO
         iyXicyTOoFKQ6PdFPu9vLMw6aILbmbfsD4wSnHgKt2evEbpSovZ2+4lQtm9RzUrqSm23
         zrY3NZw3tLjr6aGcCB2NXj9A9+svdF9Q+9R4wbCMyEyhXH/zpV0YcPQyjuTHYTMU79A1
         0XIw==
X-Gm-Message-State: AA+aEWaWJNHt3boOGdjuYm/PjV6YqFM9DPPx8X/UWgG0Qyr4acdtLdCG
        FAXrPR/DGYet5ooRvdztnw==
X-Google-Smtp-Source: AFSGD/UDpDV5DZVv/lre9oa+tGgJpJxtDhScU/QWJV2juRAyPI5q2oqBsYJDLG4sQUTHudV1y5dZow==
X-Received: by 2002:a9d:72e:: with SMTP id 43mr17153105ote.207.1544048433869;
        Wed, 05 Dec 2018 14:20:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t8sm8925706otp.69.2018.12.05.14.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:20:32 -0800 (PST)
Date:   Wed, 5 Dec 2018 16:20:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Nava kishore Manne <navam@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Message-ID: <20181205222032.GA810@bogus>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
 <20181204220612.GA640@bogus>
 <SN4PR0201MB3536E825E836337D1535B812B8A80@SN4PR0201MB3536.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0201MB3536E825E836337D1535B812B8A80@SN4PR0201MB3536.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:29:36PM +0000, Jolly Shah wrote:
> Hi Rob,
> 
> Thanks for the review. Please find my responses inline.

You need to fix your mail client to wrap lines.
 
> Thanks,
> Jolly Shah
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Tuesday, December 04, 2018 2:06 PM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> > Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
> > 
> > On Fri, Nov 16, 2018 at 03:56:50PM -0800, Jolly Shah wrote:
> > > Base firmware node and clock child node binding are part of mainline kernel.
> > This patchset adds documentation to describe rest of the firmware child node
> > bindings.
> > > Complete firmware DT node example is shown below for ease of
> > understanding:
> > 
> > Shouldn't there be a fpga mgr node too? Called pcap IIRC.
> > 
> [Jolly] As you suggested, we only added child nodes if the 
> sub-functions have their own resources (clks, irqs, etc.). FPGA doesn't 
> have any resources so not added . Firmware driver would still register 
> it as mfd device to instantiate the driver.

Okay, but won't their need to be child devices for 


> 
> > >
> > > firmware {
> > > 	zynqmp_firmware: zynqmp-firmware {
> > > 		compatible = "xlnx,zynqmp-firmware";
> > > 		method = "smc";
> > > 		#power-domain-cells = <1>;
> > > 		#reset-cells = <1>;
> > >
> > > 		zynqmp_clk: clock-controller {
> > > 			#clock-cells = <1>;
> > > 			compatible = "xlnx,zynqmp-clk";
> > > 			clocks = <&pss_ref_clk>, <&video_clk>,
> > <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> > > 			clock-names = "pss_ref_clk", "video_clk",
> > "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> > > 		};
> > >
> > > 		zynqmp_power: zynqmp-power {
> > > 			compatible = "xlnx,zynqmp-power";
> > > 			interrupts = <0 35 4>;
> > > 		};
> > >
> > > 		nvmem_firmware {
> > > 			compatible = "xlnx,zynqmp-nvmem-fw";
> > > 			#address-cells = <1>;
> > > 			#size-cells = <1>;
> > >
> > > 			/* Data cells */
> > > 			soc_revision: soc_revision {
> > > 				reg = <0x0 0x4>;
> > > 			};
> > > 		};
> > >
> > > 		afi0: afi0 {
> > > 			compatible = "xlnx,afi-fpga";
> > > 			config-afi = <0 2>, <1 1>, <2 1>;
> > > 		};
> > >
> > > 		qspi: spi@ff0f0000 {
> > 
> > Why is this under firmware node?
> [Jolly] Qspi is a user of eemi API provided by firmware node to 
> perform privileged register writes. Alternatively, we can keep such 
> user nodes outside of firmware node and keep nodes which firmware is 
> provider for like clock, reset, pins and power.
> Please suggest.

Child nodes of the firmware should be providers, not consumers (of the 
firmware). If you had a firmware interface to that provided a SPI 
interface, then it would be here. But just having a special mechanism to 
access the registers. 

> > 
> > > 			compatible = "xlnx,zynqmp-qspi-1.0";

If this same block works with unprivileged accesses, then you will need 
some way to distinguish that.

> > > 			clock-names = "ref_clk", "pclk";
> > > 			clocks = <&misc_clk &misc_clk>;
> > > 			interrupts = <0 15 4>;
> > > 			interrupt-parent = <&gic>;
> > > 			num-cs = <1>;
> > > 			reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000
> > 0x8000000>;
> > > 		};
> > >
> > > 		serdes: zynqmp_phy@fd400000 {
> > 
> > And this?
> 
> [Jolly] Same as above.
> 
> > 
> > > 			compatible = "xlnx,zynqmp-psgtr";
> > > 			status = "okay";
> > > 			reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000
> > 0x0 0x1000>,
> > > 				<0x0 0xff5e0000 0x0 0x1000>;
> > > 			reg-names = "serdes", "siou", "lpd";
> > >
> > > 			lane0: lane@0 {
> > > 				#phy-cells = <4>;
> > > 			};
> > > 			lane1: lane@1 {
> > > 				#phy-cells = <4>;
> > > 			};
> > > 			lane2: lane@2 {
> > > 				#phy-cells = <4>;
> > > 			};
> > > 			lane3: lane@3 {
> > > 				#phy-cells = <4>;
> > > 			};
> > > 		};
> > >
> > > 		pinctrl_uart1_default: uart1-default {
> > 
> > This goes under a pinctrl node.
> [Jolly] Pincontrol node is not added as it doesn't have any 
> resources. As I understand, you suggest to still add pincontrol node 
> and this under pincontrol node.

These nodes are resources, so yes you should have a child here.
> 
> > 
> > > 			mux {
> > > 				groups = "uart0_4_grp";
> > > 				function = "uart0";
> > > 			};
> > >
> > > 			conf {
> > > 				groups = "uart0_4_grp";
> > > 				slew-rate = <SLEW_RATE_SLOW>;
> > > 				io-standard = <IO_STANDARD_LVCMOS18>;
> > > 			};
> > >
> > > 			conf-rx {
> > > 				pins = "MIO18";
> > > 				bias-high-impedance;
> > > 			};
> > >
> > > 			conf-tx {
> > > 				pins = "MIO19";
> > > 				bias-disable;
> > > 				schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
> > > 			};
> > > 		};
> > > 		zynqmp-r5-remoteproc@0 {
> > 
> > Wrong unit-address and this doesn't belong here.
> [Jolly]  Again as it is one of the user of firmware APIs, its kept 
> here. Alternatively, we can keep such user nodes outside of firmware 
> node and keep nodes which firmware is provider for like clock, reset, 
> pins and power.
> Please suggest.

Yes, it should be outside this.

> > 
> > > 			compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
> > 
> > 'remoteproc' is what the h/w block is called?
> 
> [Jolly] The hw block is called rpu. 

Then call it that in the DT.

Rob
