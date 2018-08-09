Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B90F21EC4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B90F21EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbeHISuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:50:15 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7484 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHISuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:50:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6c6ab60000>; Thu, 09 Aug 2018 09:24:22 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Aug 2018 09:24:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Aug 2018 09:24:35 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Aug
 2018 16:24:32 +0000
Date:   Thu, 9 Aug 2018 19:24:26 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 01/40] dt-bindings: Add Tegra PMC pad configuration
 bindings
Message-ID: <20180809192426.3f3b7c16@dhcp-10-21-25-168>
In-Reply-To: <20180809121350.GO21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
        <1533141150-10511-2-git-send-email-avienamo@nvidia.com>
        <20180809121350.GO21639@ulmo>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2018 14:13:50 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Aug 01, 2018 at 07:31:51PM +0300, Aapo Vienamo wrote:
> > Document the PMC pinctrl bindings for pad power state and signaling
> > voltage configuration. Both nvidia,tegra186-pmc.txt and
> > nvidia,tegra20-pmc.txt are modified as they both cover SoC generations
> > for which these bindings apply.
> > 
> > Add a header defining Tegra PMC pad voltage configurations.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  92 ++++++++++++++++++
> >  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++++++++++++++++++++
> >  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 ++++
> >  3 files changed, 213 insertions(+)
> >  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > index 5a3bf7c..d7fed4d 100644
> > --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > @@ -34,3 +34,95 @@ Board DTS:
> >  	pmc@c360000 {
> >  		nvidia,invert-interrupt;
> >  	};
> > +
> > +== Pad Control ==
> > +
> > +On Tegra SoCs a pad is a set of pins which are configured as a group.
> > +The pin grouping is a fixed attribute of the hardware. The PMC can be
> > +used to set pad power state and signaling voltage. A pad can be either
> > +in active or power down mode. The support for power state and signaling
> > +voltage configuration varies depending on the pad in question. 3.3 V and
> > +1.8 V signaling voltages are supported on pins where software
> > +controllable signaling voltage switching is available.
> > +
> > +Pad configurations are described is with pin configuration nodes which  
> 
> The "is" in the middle there seems to be left-over from a previous
> formulation of the sentence.
> 
> > +are placed under the pmc node and they are referred to by the pinctrl
> > +client properties. For more information see
> > +Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> > +
> > +Following pads are present on Tegra186:  
> 
> "The following pads..."
> 
> > +csia		csib		dsi		mipi-bias
> > +pex-clk-bias	pex-clk3	pex-clk2	pex-clk1
> > +usb0		usb1		usb2		usb-bias
> > +uart		audio		hsic		dbg
> > +hdmi-dp0	hdmi-dp1	pex-cntrl	sdmmc2-hv
> > +sdmmc4		cam		dsib		dsic
> > +dsid		csic		csid		csie
> > +dsif		spi		ufs		dmic-hv
> > +edp		sdmmc1-hv	sdmmc3-hv	conn
> > +audio-hv	ao-hv
> > +
> > +Required pin configuration properties:
> > +  - pins: Must contain name of the pad(s) to be configured.  
> 
> "the name". Also, I'm assuming that this can take a list of names, so
> perhaps this should read:
> 
> 	- pins: A list of strings, each of which contains the name of a pad
> 	    to be configured.
> 
> > +
> > +Optional pin configuration properties:
> > +  - low-power-enable: Configure the pad into power down mode
> > +  - low-power-disable: Configure the pad into active mode  
> 
> Do we need both of these? low-power could be a boolean property to mean
> that the pad(s) should be configured in power down mode. If absent it
> would mean that the pad(s) should be configured in normal mode. The only
> reason why I can think of them to have to be separate is if we want to
> define a configuration where the power mode is not touched. But is that
> really something we need or want?

These are standard pinctrl properties. While not relevant to the OS and
driver agnostic bindings documentation, the way Linux pinctrl works
would make omitting either of those properties tricky to implement in a
pinctrl provider driver. As far as I can tell, the power state should
be stated explicitly if it's modified in any of the pin configurations.

> > +  - power-source: Must contain either TEGRA_IO_PAD_VOLTAGE_1V8 or
> > +    TEGRA_IO_PAD_VOLTAGE_3V3 to select between signaling voltages.
> > +    The values are defined in
> > +    include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.  
> 
> Why is this called "power-source"? This defines the signaling voltage of
> the pad, so why not something like "power-level", or "voltage", or
> "output-voltage"?
> 
> Or is this because it is a mux that will internally select either a
> 1.8 V or a 3.3 V source? In which case I guess this is okay. Perhaps
> give some explanation of the mechanics of the underlying hardware to
> make this more obvious.

At least in the case of SDMMC, the pad is powered from an external
adjustable regulator, however the pad must be configured to a voltage
matching the voltage that is supplied to the pad from the regulator. The
TRM does not go into much detail on the actual mechanisms behind this.
I wanted to avoid introcuding new vendor specific properties and just
stick with the standard pinctrl ones.

> > +
> > +Note: The power state can be configured on all of the above pads except
> > +      for ao-hv. Following pads have software configurable signaling
> > +      voltages: sdmmc2-hv, dmic-hv, sdmmc1-hv, sdmmc3-hv, audio-hv,
> > +      ao-hv.
> > +
> > +Pad configuration state example:
> > +	pmc: pmc@7000e400 {
> > +		compatible = "nvidia,tegra186-pmc";
> > +		reg = <0 0x0c360000 0 0x10000>,
> > +		      <0 0x0c370000 0 0x10000>,
> > +		      <0 0x0c380000 0 0x10000>,
> > +		      <0 0x0c390000 0 0x10000>;
> > +		reg-names = "pmc", "wake", "aotag", "scratch";
> > +
> > +		...
> > +
> > +		sdmmc1_3v3: sdmmc1-3v3 {
> > +			pins = "sdmmc1-hv";
> > +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> > +		};
> > +
> > +		sdmmc1_1v8: sdmmc1-1v8 {
> > +			pins = "sdmmc1-hv";
> > +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> > +		};  
> 
> Wouldn't these be implicitly low-power-disable? What if these are off by
> default? Selecting these states would change the power source but keep
> them in power down, no? Don't we want something like the below instead?

The power state isn't modified. By default the pads are powered.

> 		sdmmc1_3v3: sdmmc1-3v3 {
> 			pins = "sdmmc1-hv";
> 			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> 			/* low-power-disable implied here */
> 		};
> 
> 		sdmmc1_1v8: sdmmc1-1v8 {
> 			pins = "sdmmc1-hv";
> 			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> 			/* low-power-disable implied here */
> 		};
> 
> 		sdmmc1_off: sdmmc1-off {
> 			pins = "sdmmc1-hv";
> 			low-power;
> 		};
> 
> That would allow the SDHCI driver to select between the two signaling
> modes and a separate state for powering down the pad.
> 
> > +
> > +		hdmi_off: hdmi-off {
> > +			pins = "hdmi";
> > +			low-power-enable;
> > +		}
> > +
> > +		hdmi_on: hdmi-on {
> > +			pins = "hdmi";
> > +			low-power-disable;
> > +		}  
> 
> These would similarily become:
> 
> 		hdmi_off: hdmi-off {
> 			pins = "hdmi";
> 			low-power;
> 		};
> 
> 		hdmi_on: hdmi-on {
> 			pins = "hdmi";
> 		};
> 
> > diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> > index a74b37b..5363b90 100644
> > --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> > +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> > @@ -195,3 +195,106 @@ Example:
> >  		power-domains = <&pd_audio>;
> >  		...
> >  	};
> > +
> > +== Pad Control ==
> > +
> > +On Tegra SoCs a pad is a set of pins which are configured as a group.
> > +The pin grouping is a fixed attribute of the hardware. The PMC can be
> > +used to set pad power state and signaling voltage. A pad can be either
> > +in active or power down mode. The support for power state and signaling
> > +voltage configuration varies depending on the pad in question. 3.3 V and
> > +1.8 V signaling voltages are supported on pins where software
> > +controllable signaling voltage switching is available.
> > +
> > +The pad configuration state nodes are placed under the pmc node and they
> > +are referred to by the pinctrl client properties. For more information
> > +see Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> > +The pad name should be used as the value of the pins property in pin
> > +configuration nodes.
> > +
> > +Following pads are present on Tegra124 and Tegra132:
> > +audio		bb		cam		comp
> > +csia		csb		cse		dsi
> > +dsib		dsic		dsid		hdmi
> > +hsic		hv		lvds		mipi-bias
> > +nand		pex-bias	pex-clk1	pex-clk2
> > +pex-cntrl	sdmmc1		sdmmc3		sdmmc4
> > +sys_ddc		uart		usb0		usb1
> > +usb2		usb_bias
> > +
> > +Following pads are present on Tegra210:
> > +audio		audio-hv	cam		csia
> > +csib		csic		csid		csie
> > +csif		dbg		debug-nonao	dmic
> > +dp		dsi		dsib		dsic
> > +dsid		emmc		emmc2		gpio
> > +hdmi		hsic		lvds		mipi-bias
> > +pex-bias	pex-clk1	pex-clk2	pex-cntrl
> > +sdmmc1		sdmmc3		spi		spi-hv
> > +uart		usb0		usb1		usb2
> > +usb3		usb-bias  
> 
> What about chips prior to Tegra124?

PMC pad configuration of this sort was introduced in Tegra124.

 -Aapo
