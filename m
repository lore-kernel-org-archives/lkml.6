Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946666AbeCBQBz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:01:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1946608AbeCBQBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:01:53 -0500
Subject: Re: [PATCH] arm64: dts: hisi: add hns-dsaf cpld control for the hip07
 SoC
To: Huazhong Tan <tanhuazhong@huawei.com>
References: <1516278697-244377-1-git-send-email-tanhuazhong@huawei.com>
CC: <linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5A997559.9060103@hisilicon.com>
Date: Fri, 2 Mar 2018 16:01:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1516278697-244377-1-git-send-email-tanhuazhong@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.47]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huazhong,

On 2018/1/18 12:31, Huazhong Tan wrote:
> Add cpld-syscon node to support the cpld control for hns-dsaf
> on the hip07 SoC.
> 
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> ---

Applied into hisilicon dt tree.
Thanks!

BR,
Wei

>  arch/arm64/boot/dts/hisilicon/hip07.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> index 2c01a21..4bd6416 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> @@ -1127,6 +1127,12 @@
>  			reg = <0x0 0xc0000000 0x0 0x10000>;
>  		};
>  
> +		dsa_cpld: dsa_cpld@78000010 {
> +			compatible = "syscon";
> +			reg = <0x0 0x78000010 0x0 0x100>;
> +			reg-io-width = <2>;
> +		};
> +
>  		pcie_subctl: pcie_subctl@a0000000 {
>  			compatible = "hisilicon,pcie-sas-subctrl", "syscon";
>  			reg = <0x0 0xa0000000 0x0 0x10000>;
> @@ -1258,6 +1264,7 @@
>  			port@0 {
>  				reg = <0>;
>  				serdes-syscon = <&serdes_ctrl>;
> +				cpld-syscon = <&dsa_cpld 0x0>;
>  				port-rst-offset = <0>;
>  				port-mode-offset = <0>;
>  				mc-mac-mask = [ff f0 00 00 00 00];
> @@ -1267,6 +1274,7 @@
>  			port@1 {
>  				reg = <1>;
>  				serdes-syscon= <&serdes_ctrl>;
> +				cpld-syscon = <&dsa_cpld 0x4>;
>  				port-rst-offset = <1>;
>  				port-mode-offset = <1>;
>  				mc-mac-mask = [ff f0 00 00 00 00];
> 
