Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeCPMSB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:18:01 -0400
Received: from foss.arm.com ([217.140.101.70]:55152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeCPMR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:17:59 -0400
Subject: Re: [PATCH v2 02/13] ARM: dts: ipq4019: Add a few peripheral nodes
To: Sricharan R <sricharan@codeaurora.org>, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, sboyd@codeaurora.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-3-git-send-email-sricharan@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <eb50deb1-0530-866f-502e-e675cdd1e732@arm.com>
Date: Fri, 16 Mar 2018 12:17:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521193101-4586-3-git-send-email-sricharan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/18 09:38, Sricharan R wrote:
> Now with the driver updates for some peripherals being there,
> add i2c, spi, pcie, bam, qpic-nand, scm nodes to enhance the available
> peripheral support.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 134 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index 10d112a..e38fffa 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -25,7 +25,9 @@

[...]

> +		pcie0: pci@40000000 {
> +			compatible = "qcom,pcie-ipq4019", "snps,dw-pcie";
> +			reg =  <0x40000000 0xf1d
> +				0x40000f20 0xa8
> +				0x80000 0x2000
> +				0x40100000 0x1000>;
> +			reg-names = "dbi", "elbi", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000
> +				  0x82000000 0 0x48000000 0x48000000 0 0x10000000>;
> +
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_NONE>;

There is no such thing as IRQ_TYPE_NONE. Please replace this with the
actual trigger information.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
