Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ADDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028692082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028692082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeLDWGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:06:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34485 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeLDWGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:06:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so15777142oig.1;
        Tue, 04 Dec 2018 14:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=od9oqItzrIx6N8qhcUsce2UF97+Rcb6AAq1qNYdYUms=;
        b=gYf8HiwdROXEjwk2lBeu5evPeME6l3v9r7TqxugCOwkZV/pNbpiSS6lggy+xGyZEDU
         e0Hx90NjWHyLKnss4iAjESQ44LkHjb/zVRsnT88VyDXPoinErGKvOvN+bgw/IKHUqN0R
         vBge/Hh7kL6X47/QcX9lsnZJ5+RFAkgVej7cOYzkvWgKdSjN+X/NQanMkgs4CL7IEAj8
         T+sEV0d7OHbTM5c40nhkoJR1jFCtQlBMFgWF9IQ/Mr85mW+5p+g7EbhDXDmMxiiFfG7g
         RCzQiHbjCpiHV4chNOI9v4ewOj1KntdcYu8musf2Vfdu0FeyRY8ZNHYtJl0JPH9IUWw3
         JeEA==
X-Gm-Message-State: AA+aEWaZpEiGi+6o368A4tgHKnPwSvwPUaEOEO43K96biXBymw3SwcqB
        dfpTgxwgPUQgpdQ4MOPfpKXcV/Q=
X-Google-Smtp-Source: AFSGD/WFRoAGzTQtbPEZRj9VxZdwqWdXKlYK5I/jF+u+lIfGPuL/upokUdvnnmaByUAIONIwAbc4Ew==
X-Received: by 2002:aca:ad14:: with SMTP id w20mr12901459oie.3.1543961173364;
        Tue, 04 Dec 2018 14:06:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x4sm6353853otk.37.2018.12.04.14.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 14:06:12 -0800 (PST)
Date:   Tue, 4 Dec 2018 16:06:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        nava.manne@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Message-ID: <20181204220612.GA640@bogus>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542412619-387-1-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 03:56:50PM -0800, Jolly Shah wrote:
> Base firmware node and clock child node binding are part of mainline kernel. This patchset adds documentation to describe rest of the firmware child node bindings. 
> Complete firmware DT node example is shown below for ease of understanding:

Shouldn't there be a fpga mgr node too? Called pcap IIRC.

> 
> firmware {
> 	zynqmp_firmware: zynqmp-firmware {
> 		compatible = "xlnx,zynqmp-firmware";
> 		method = "smc";
> 		#power-domain-cells = <1>;
> 		#reset-cells = <1>;
> 
> 		zynqmp_clk: clock-controller {
> 			#clock-cells = <1>;
> 			compatible = "xlnx,zynqmp-clk";
> 			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> 			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> 		};
> 
> 		zynqmp_power: zynqmp-power {
> 			compatible = "xlnx,zynqmp-power";
> 			interrupts = <0 35 4>;
> 		};
> 
> 		nvmem_firmware {
> 			compatible = "xlnx,zynqmp-nvmem-fw";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			/* Data cells */
> 			soc_revision: soc_revision {
> 				reg = <0x0 0x4>;
> 			};
> 		};
> 
> 		afi0: afi0 {
> 			compatible = "xlnx,afi-fpga";
> 			config-afi = <0 2>, <1 1>, <2 1>;
> 		};
> 
> 		qspi: spi@ff0f0000 {

Why is this under firmware node?

> 			compatible = "xlnx,zynqmp-qspi-1.0";
> 			clock-names = "ref_clk", "pclk";
> 			clocks = <&misc_clk &misc_clk>;
> 			interrupts = <0 15 4>;
> 			interrupt-parent = <&gic>;
> 			num-cs = <1>;
> 			reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000 0x8000000>;
> 		};
> 
> 		serdes: zynqmp_phy@fd400000 {

And this?

> 			compatible = "xlnx,zynqmp-psgtr";
> 			status = "okay";
> 			reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>,
> 				<0x0 0xff5e0000 0x0 0x1000>;
> 			reg-names = "serdes", "siou", "lpd";
> 
> 			lane0: lane@0 {
> 				#phy-cells = <4>;
> 			};
> 			lane1: lane@1 {
> 				#phy-cells = <4>;
> 			};
> 			lane2: lane@2 {
> 				#phy-cells = <4>;
> 			};
> 			lane3: lane@3 {
> 				#phy-cells = <4>;
> 			};
> 		};
> 
> 		pinctrl_uart1_default: uart1-default {

This goes under a pinctrl node.

> 			mux {
> 				groups = "uart0_4_grp";
> 				function = "uart0";
> 			};
> 
> 			conf {
> 				groups = "uart0_4_grp";
> 				slew-rate = <SLEW_RATE_SLOW>;
> 				io-standard = <IO_STANDARD_LVCMOS18>;
> 			};
> 
> 			conf-rx {
> 				pins = "MIO18";
> 				bias-high-impedance;
> 			};
> 
> 			conf-tx {
> 				pins = "MIO19";
> 				bias-disable;
> 				schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
> 			};
> 		};
> 		zynqmp-r5-remoteproc@0 {

Wrong unit-address and this doesn't belong here.

> 			compatible = "xlnx,zynqmp-r5-remoteproc-1.0";

'remoteproc' is what the h/w block is called?

> 			reg = <0x0 0xFFE00000 0x0 0x10000>,
> 				<0x0 0xFFE20000 0x0 0x10000>,
> 				<0x0 0xff340000 0x0 0x100>;
> 			reg-names = "tcm_a", "tcm_b", "ipi";
> 			dma-ranges;
> 			core_conf = "split0";
> 			memory-region = <&rproc_0_fw_reserved>,
> 					<&rproc_0_dma_reserved>;
> 			tcm-pnode-id = <0xf>, <0x10>;
> 			rpu-pnode-id = <0x7>;
> 			interrupt-parent = <&gic>;
> 			interrupts = <0 29 4>;
> 		};
> 	};
> };
