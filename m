Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbeCLDvZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 23:51:25 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:38924 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeCLDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 23:51:21 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: zhengsq@rock-chips.com
X-FST-TO: jacob2.chen@rock-chips.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: zhengsq@rock-chips.com
X-UNIQUE-TAG: <966b5f5922e3939a72b72d118396097f>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Reply-To: zhengsq@rock-chips.com
Subject: Re: [v6-1,15/17] arm64: dts: rockchip: add isp0 node for rk3399
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Jacob Chen <jacob2.chen@rock-chips.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <1520825831-24229-1-git-send-email-zhengsq@rock-chips.com>
From: Shunqian Zheng <zhengsq@rock-chips.com>
Message-ID: <ef1dd0cf-a9ca-7590-0bdf-a0aa303776b6@rock-chips.com>
Date: Mon, 12 Mar 2018 11:51:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1520825831-24229-1-git-send-email-zhengsq@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, sorry, I used a wrong Message-Id in In-reply-to, please ignore this one.

Sorry about that.


On 2018年03月12日 11:37, Shunqian Zheng wrote:
> rk3399 have two ISP, but we havn't test isp1, so just add isp0 at present.
>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 2605118..5729786 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1614,6 +1614,24 @@
>   		status = "disabled";
>   	};
>   
> +	isp0: isp0@ff910000 {
> +		compatible = "rockchip,rk3399-cif-isp";
> +		reg = <0x0 0xff910000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru SCLK_ISP0>,
> +			 <&cru ACLK_ISP0>, <&cru ACLK_ISP0_WRAPPER>,
> +			 <&cru HCLK_ISP0>, <&cru HCLK_ISP0_WRAPPER>;
> +		clock-names = "clk_isp",
> +			      "aclk_isp", "aclk_isp_wrap",
> +			      "hclk_isp", "hclk_isp_wrap";
> +		assigned-clocks = <&cru SCLK_ISP0>, <&cru ACLK_ISP0>;
> +		assigned-clock-rates = <500000000>, <400000000>;
> +
> +		power-domains = <&power RK3399_PD_ISP0>;
> +		iommus = <&isp0_mmu>;
> +		status = "disabled";
> +	};
> +
>   	isp0_mmu: iommu@ff914000 {
>   		compatible = "rockchip,iommu";
>   		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
