Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936097AbeCHQ6A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:58:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935930AbeCHQ5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:57:53 -0500
Subject: Re: [PATCH v8 3/5] arm64: dts: add ufs dts node
To: Li Wei <liwei213@huawei.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <vinholikatti@gmail.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <khilman@baylibre.com>, <arnd@arndb.de>,
        <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>, <yamada.masahiro@socionext.com>,
        <riku.voipio@linaro.org>, <treding@nvidia.com>, <krzk@kernel.org>,
        <eric@anholt.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-4-liwei213@huawei.com>
CC: <zangleigang@hisilicon.com>, <gengjianfeng@hisilicon.com>,
        <guodong.xu@linaro.org>, <zhangfei.gao@linaro.org>,
        <fengbaopeng@hisilicon.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5AA16B6F.2000702@hisilicon.com>
Date: Thu, 8 Mar 2018 16:57:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180213101412.5717-4-liwei213@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li Wei,

On 2018/2/13 10:14, Li Wei wrote:
> arm64: dts: add ufs node for Hisilicon.
> 
> Signed-off-by: Li Wei <liwei213@huawei.com>

Fine to me. Thanks!

Acked-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index ab0b95ba5ae5..d0dfa97fdad1 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -904,6 +904,25 @@
>  			reset-gpios = <&gpio11 1 0 >;
>  		};
>  
> +		/* UFS */
> +		ufs: ufs@ff3b0000 {
> +			compatible = "hisilicon,hi3660-ufs", "jedec,ufs-1.1";
> +			/* 0: HCI standard */
> +			/* 1: UFS SYS CTRL */
> +			reg = <0x0 0xff3b0000 0x0 0x1000>,
> +				<0x0 0xff3b1000 0x0 0x1000>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
> +				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
> +			clock-names = "ref_clk", "phy_clk";
> +			/* offset: 0x84; bit: 12 */
> +			/* offset: 0x84; bit: 7  */
> +			resets = <&crg_rst 0x84 12>,
> +				<&crg_rst 0x84 7>;
> +			reset-names = "rst", "assert";
> +		};
> +
>  		/* SD */
>  		dwmmc1: dwmmc1@ff37f000 {
>  			#address-cells = <1>;
> 
