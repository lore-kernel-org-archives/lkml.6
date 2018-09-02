Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50C420857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 18:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBu+6fGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50C420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeIBWbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 18:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbeIBWbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 18:31:45 -0400
Received: from archlinux (unknown [176.12.107.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D7720843;
        Sun,  2 Sep 2018 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535912107;
        bh=csh8erRommbsesy8wMRWaZTeTauBXkvMUuZzJwWGhN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LBu+6fGIqZM651TanQ0Ds47db2f2hjmA7lRLK34SgenyxUte2AcEQLvYK08bD1ZWn
         xXfmyXKMLVptbvZCW6tHTX837hpevcRdmqh7XiYfVVRlsBaOXRMNfZOSAbOfEFSbf2
         pGLSt2INuDmb94fldtA6+KZTurM7z8RzNosZwtko=
Date:   Sun, 2 Sep 2018 19:14:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <geert@linux-m68k.org>, <eugen.hristev@microchip.com>,
        <rdunlap@infradead.org>, <lukas@wunner.de>,
        <freeman.liu@spreadtrum.com>, <vilhelm.gray@gmail.com>,
        <tglx@linutronix.de>, <baolin.wang@linaro.org>,
        <gregkh@linuxfoundation.org>, <sgoud@xilinx.com>,
        <anirudh@xilinx.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Message-ID: <20180902191459.5f597c94@archlinux>
In-Reply-To: <1535624539-7839-2-git-send-email-manish.narani@xilinx.com>
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
        <1535624539-7839-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 15:52:17 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> Xilinx AMS have several ADC channels that can be used for measurement of
> different voltages and temperatures. Document the same in the bindings.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 159 +++++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> new file mode 100644
> index 0000000..8cc96f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> @@ -0,0 +1,159 @@
> +Xilinx AMS controller
> +
> +The AMS includes an ADC as well as on-chip sensors that can be used to
> +sample external voltages and monitor on-die operating conditions, such as
> +temperature and supply voltage levels. The AMS has two SYSMON blocks.
> +PL-SYSMON block is capable of monitoring off chip voltage and temperature.
> +PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring from
> +external master. Out of this interface currently only DRP is supported.
> +Other block PS-SYSMON is memory mapped to PS. Both of block has built-in
> +alarm generation logic that is used to interrupt the processor based on
> +condition set.

I guess anyone reading this because they have the hardware would know what
PS and PL are, but it would still be nice to define those acronyms!

Google suggest, Programmable Logic (FPGA bit I guess) and Process Space
(Arm core bit?)  As I read this, from a driver point of view it doesn't
really matter - these are just blocks of channels that are there?

This binding is complex enough I definitely want some DT binding
review. 



> +
> +All designs should have AMS registers, but PS and PL are optional. The
> +AMS controller can work with only PS, only PL and both PS and PL
> +configurations. Please specify registers according to your design. Devicetree
> +should always have AMS module property. Providing PS & PL module is optional.
> +
> +Required properties:
> +	- compatible: Should be "xlnx,zynqmp-ams"
> +	- reg:  Should specify AMS register space
> +	- interrupts: Interrupt number for the AMS control interface
> +	- interrupt-names: Interrupt name, must be "ams-irq"
> +	- clocks: Should contain a clock specifier for the device
> +	- ranges: keep the property empty to map child address space
> +	          (for PS and/or PL) nodes 1:1 onto the parent address
> +	          space
> +
> +AMS device tree subnode:
> +	- compatible: Should be "xlnx,zynqmp-ams-ps" or "xlnx,zynqmp-ams-pl"
> +	- reg:  Register space for PS or PL
> +
> +Optional properties:
> +
> +Following optional property only valid for PL.
> +	- xlnx,ext-channels: List of external channels that are connected to the
> +	                     AMS PL module.
> +
> +	  The child nodes of this node represent the external channels which are
> +	  connected to the AMS Module. If the property is not present
> +	  no external channels will be assumed to be connected.
> +
> +	  Each child node represents one channel and has the following
> +	  properties:
> +		Required properties:
> +			* reg: Pair of pins the channel is connected to.
> +				0: VP/VN
Hmm. So we have this table here of the ones that may or may not be connected
with different numbering from the overall table.  Given these indexes
are arbitrary can we unify them?

I.e. use the index from below but state here which values can be used?

> +				1: VUSER0
> +				2: VUSER1
> +				3: VUSER3
> +				4: VUSER4
> +				5: VAUXP[0]/VAUXN[0]
> +				6: VAUXP[1]/VAUXN[1]
> +				...
> +				20: VAUXP[15]/VAUXN[15]
> +			  Note each channel number should only be used at most
> +			  once.
> +		Optional properties:
> +			* xlnx,bipolar: If set the channel is used in bipolar
> +			  mode.
> +
> +
> +Example:
> +	xilinx_ams: ams@ffa50000 {
> +		compatible = "xlnx,zynqmp-ams";
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 56 4>;
> +		interrupt-names = "ams-irq";
> +		clocks = <&clkc 70>;
> +		reg = <0x0 0xffa50000 0x0 0x800>;
> +		reg-names = "ams-base";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ams_ps: ams_ps@ffa50800 {
> +			compatible = "xlnx,zynqmp-ams-ps";
> +			reg = <0x0 0xffa50800 0x0 0x400>;
> +		};
> +
> +		ams_pl: ams_pl@ffa50c00 {
> +			compatible = "xlnx,zynqmp-ams-pl";
> +			reg = <0x0 0xffa50c00 0x0 0x400>;
> +			xlnx,ext-channels {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				channel@0 {
> +					reg = <0>;
> +					xlnx,bipolar;
> +				};
> +				channel@1 {
> +					reg = <1>;
> +				};
> +				channel@8 {
> +					reg = <8>;
> +					xlnx,bipolar;
> +				};
> +			};
> +		};
> +	};
> +
> +AMS Channels Details:
> +
> +Sysmon Block	|Channel|			Details					|Measurement
> +		 Number									 Type
> +---------------------------------------------------------------------------------------------------------
> +AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.			|Voltage
> +		|1	|Battery voltage measurement, VCC_PSBATT.			|Voltage
> +		|2	|PL Internal voltage measurement, VCCINT.			|Voltage
> +		|3	|Block RAM voltage measurement, VCCBRAM.			|Voltage
> +		|4	|PL Aux voltage measurement, VCCAUX.				|Voltage
> +		|5	|Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.	|Voltage
> +		|6	|VCC_PSINTFP_DDR voltage measurement.				|Voltage
> +---------------------------------------------------------------------------------------------------------
> +PS Sysmon	|7	|LPD temperature measurement.					|Temperature
> +		|8	|FPD Temperature Measurment (REMOTE).				|Temperature
> +		|9	|VCC PS LPD voltage measurement (supply1).			|Voltage
> +		|10	|VCC PS FPD voltage measurement (supply2).			|Voltage
> +		|11	|PS Aux voltage reference (supply3).				|Voltage
> +		|12	|DDR I/O VCC voltage measurement.				|Voltage
> +		|13	|PS IO Bank 503 voltage measurement (supply5).			|Voltage
> +		|14	|PS IO Bank 500 voltage measurement (supply6).			|Voltage
> +		|15	|VCCO_PSIO1 voltage measurement.				|Voltage
> +		|16	|VCCO_PSIO2 voltage measurement.				|Voltage
> +		|17	|VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).			|Voltage
> +		|18	|VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).			|Voltage
> +		|19	|VCC_PSADC voltage measurement.					|Voltage
> +---------------------------------------------------------------------------------------------------------
> +PL Sysmon	|20	|PL Temperature measurement.					|Temperature
> +		|21	|PL Internal Voltage Voltage measurement, VCCINT.		|Voltage
> +		|22	|PL Auxiliary Voltage measurement, VCCAUX.			|Voltage
> +		|23	|ADC Reference P+ Voltage measurement.				|Voltage
> +		|24	|ADC Reference N- Voltage measurement.				|Voltage
> +		|25	|PL Block RAM Voltage measurement, VCCBRAM.			|Voltage
> +		|26	|LPD Internal Voltage measurement, VCC_PSINTLP (supply4).	|Voltage
> +		|27	|FPD Internal Voltage measurement, VCC_PSINTFP (supply5).	|Voltage
> +		|28	|PS Auxiliary Voltage measurement (supply6).			|Voltage
> +		|29	|PL VCCADC Voltage measurement (vccams).			|Voltage
> +		|30	|Differencial analog input signal Voltage measurment.		|Voltage
> +		|31	|VUser0 Voltage measurement (supply7).				|Voltage
> +		|32	|VUser1 Voltage measurement (supply8).				|Voltage
> +		|33	|VUser2 Voltage measurement (supply9).				|Voltage
> +		|34	|VUser3 Voltage measurement (supply10).				|Voltage
> +		|35	|Auxiliary ch 0 Voltage measurement (VAux0).			|Voltage
> +		|36	|Auxiliary ch 1 Voltage measurement (VAux1).			|Voltage
> +		|37	|Auxiliary ch 2 Voltage measurement (VAux2).			|Voltage
> +		|38	|Auxiliary ch 3 Voltage measurement (VAux3).			|Voltage
> +		|39	|Auxiliary ch 4 Voltage measurement (VAux4).			|Voltage
> +		|40	|Auxiliary ch 5 Voltage measurement (VAux5).			|Voltage
> +		|41	|Auxiliary ch 6 Voltage measurement (VAux6).			|Voltage
> +		|42	|Auxiliary ch 7 Voltage measurement (VAux7).			|Voltage
> +		|43	|Auxiliary ch 8 Voltage measurement (VAux8).			|Voltage
> +		|44	|Auxiliary ch 9 Voltage measurement (VAux9).			|Voltage
> +		|45	|Auxiliary ch 10 Voltage measurement (VAux10).			|Voltage
> +		|46	|Auxiliary ch 11 Voltage measurement (VAux11).			|Voltage
> +		|47	|Auxiliary ch 12 Voltage measurement (VAux12).			|Voltage
> +		|48	|Auxiliary ch 13 Voltage measurement (VAux13).			|Voltage
> +		|49	|Auxiliary ch 14 Voltage measurement (VAux14).			|Voltage
> +		|50	|Auxiliary ch 15 Voltage measurement (VAux15).			|Voltage
> +---------------------------------------------------------------------------------------------------------

Thanks,

Jonathan
