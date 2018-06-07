Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PWmxKjgpGVttAgAAmS7hNA
	; Thu, 07 Jun 2018 12:47:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 92DE6608BA; Thu,  7 Jun 2018 12:47:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 07D77607E7;
	Thu,  7 Jun 2018 12:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07D77607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932463AbeFGMr4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:47:56 -0400
Received: from foss.arm.com ([217.140.101.70]:51206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753325AbeFGMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:47:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17F4715AD;
        Thu,  7 Jun 2018 05:47:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D82B33F59D;
        Thu,  7 Jun 2018 05:47:51 -0700 (PDT)
Date: Thu, 7 Jun 2018 13:47:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Manish Narani <manish.narani@xilinx.com>
Cc: robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mdf@kernel.org, stefan.krsmanovic@aggios.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org
Subject: Re: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties details
Message-ID: <20180607124743.fqo7f7nxonn2k3b5@lakrids.cambridge.arm.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
 <1528373500-24663-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528373500-24663-2-git-send-email-manish.narani@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 05:41:39PM +0530, Manish Narani wrote:
> This patch adds details of SD tap value properties in device tree.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 60481bf..0e08877 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -15,6 +15,8 @@ Required Properties:
>      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP Arasan SDHCI 8.9a PHY
> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> @@ -26,6 +28,30 @@ Required Properties for "arasan,sdhci-5.1":
>    - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
>    - phy-names:  MUST be "phy_arasan".
> 
> +Required Properties for "xlnx,zynqmp-8.9a":
> +  - xlnx,mio_bank: The value will be 0/1/2 depending on MIO bank selection.

For all of these properties, please s/_/-/, folowing the usual property
name conventions.

It's not clear to me why you need this property. The code in patch 3
only seems to use this to determine which properties to read, choosing
between <prop>_b0 or <prop>_b2. I don't see why you dont have the base
<prop> alone...

Is this a HW detail, or configuration that you prefer?

> +  - xlnx,device_id: Unique Id of the device, value will be 0/1.

What's this used for?

> +  - xlnx,itap_delay_sd_hsd: Input Tap Delay for SD HS.

What unit at hese delays in?

Please follow the conventions in
Documentation/devicetree/bindings/property-units.txt.

> +  - xlnx,itap_delay_sdr25: Input Tap Delay for SDR25.
> +  - xlnx,itap_delay_sdr50: Input Tap Delay for SDR50.
> +  - xlnx,itap_delay_sdr104_b0: Input Tap Delay for SDR104.
> +  - xlnx,itap_delay_sdr104_b2: Input Tap Delay for SDR104.

As above, Given you have to specify the bank, I don't see why you need
multiple properties.

Thanks,
Mark.

> +  - xlnx,itap_delay_sd_ddr50: Input Tap Delay for SD DDR50.
> +  - xlnx,itap_delay_mmc_hsd: Input Tap Delay for MMC HS.
> +  - xlnx,itap_delay_mmc_ddr50: Input Tap Delay for MMC DDR50.
> +  - xlnx,itap_delay_mmc_hs200_b0: Input Tap Delay for MMC HS200.
> +  - xlnx,itap_delay_mmc_hs200_b2: Input Tap Delay for MMC HS200.
> +  - xlnx,otap_delay_sd_hsd: Output Tap Delay for SD HS.
> +  - xlnx,otap_delay_sdr25: Output Tap Delay for SDR25.
> +  - xlnx,otap_delay_sdr50: Output Tap Delay for SDR50.
> +  - xlnx,otap_delay_sdr104_b0: Output Tap Delay for SDR104.
> +  - xlnx,otap_delay_sdr104_b2: Output Tap Delay for SDR104.
> +  - xlnx,otap_delay_sd_ddr50: Output Tap Delay for DDR50.
> +  - xlnx,otap_delay_mmc_hsd: Output Tap Delay for MMC HS.
> +  - xlnx,otap_delay_mmc_ddr50: Output Tap Delay for MMC DDR50.
> +  - xlnx,otap_delay_mmc_hs200_b0: Output Tap Delay for MMC HS200.
> +  - xlnx,otap_delay_mmc_hs200_b2: Output Tap Delay for MMC HS200.
> +
>  Optional Properties:
>    - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
>      used to access core corecfg registers.  Offsets of registers in this
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
