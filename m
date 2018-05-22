Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbeEVMZx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:25:53 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:25:50 -0400
Date: Tue, 22 May 2018 14:25:35 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: michael@amarulasolutions.com, robh+dt@kernel.org,
        fabio.estevam@nxp.com, mark.rutland@arm.com,
        Anson Huang <Anson.Huang@nxp.com>, matteo.lisi@engicam.com,
        shawnguo@kernel.org, kernel@pengutronix.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: linux-clk@vger.kernel.org, Linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1439344955.9677.1526991935718@email.1und1.de>
In-Reply-To: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:ouQjGeir+P7IWYJXKqZd3vALLyiVYNdM7khQg6os1yfgF2fNmsH
 K8JcwNHD4P1gwUeNMEX3l8TITuq3Jn5XyeAFVFfvVQe9CvXio2Dx0fo60gy+o28KU018u05
 tUQRuXZtn4fxJjMY12I6rjfGz0tXN1RBx331HaZgDMQGdLFh1Rf260h3V48nD44RNnLzEPa
 SW+KCZ1fv+Q+BZWxKtLxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WdUY2Vz494M=:1dZCGKw4AKfX33OrgfuKif
 +EPy85+oJ56wEhLOHncRS9fU84QB8J7MHnb9velmxXM1W6Gg7iZUodRjTUfgLE4c0gLwsRoLz
 HcQ0Rj4gkaOg3SMmctEefjp5JLlJ0KwloV0luT5I12o9rQBCW4kZFj69NmovENxZCLUX12O8u
 +S6MJiQS0YCjMovOdbLxYyar+ljt+zO4gLaktqJMVXYlIoevGomhsNn8iqIviyzD6QQMzJAVY
 r4mGK7F4Tc4PaDkGHWPnmIkFN/zo9pGqagniH/w4jHCUQu5RaBFLKd4vDKIW+4XyxHqA0JZ+Q
 ZcFFBRbvRby/Sc7Z4St7vU1Py6R73UjTH/tw0eJhPgKJgNCAlqX/dCNuGo54TkcRMfrIJW4nM
 L4oNV69CO6eY01oBZw5kRtt5LHyx8EL8uzqbkjA7AZTUq2CSLQWwWUZmyBSp5r1VrM4qqJ4rl
 l9uNyF2sL/iIOIRGI5kHdiwc5uzfc9F6Hrs+YNCareXg8DeXo+S9bxUNoumZW1+fHtPnw1LYD
 MpJNolPfzNhzoo02xoDg1MSJr2k8jH+i4XVYJPBn/tfRJsid2i3YHG8v9ysHZKJ8aHumS9eBS
 meaynjqGigRFV2zAwanvnA2rtyMgmYQRS/BdnEKLmJpZfdxfJ2Yp+BSAC/SCd7wj/RSQV1nt/
 Ae2zJrPEmpNdpidh3k0PvTYRgT1ocTgRrG2ry9nzPUcRlIilkx36p2Fu1nAvnRDdm+lWt6Fnb
 R2OXPQqLBiNjj0lq
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

> Anson Huang <Anson.Huang@nxp.com> hat am 22. Mai 2018 um 05:25 geschrieben:
> 
> 
> i.MX6UL has GPIO clock gates in CCM CCGR, add
> them into clock tree for clock management.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6ul.c             |  5 +++++
>  include/dt-bindings/clock/imx6ul-clock.h | 31 ++++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index ba563ba..3ea2d97 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -360,6 +360,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  	clks[IMX6UL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf",	base + 0x68,	28);
>  	if (clk_on_imx6ull())
>  		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		 base + 0x80,	18);
> +	clks[IMX6UL_CLK_GPIO2]		= imx_clk_gate2("gpio2",	"ipg",		base + 0x68,	30);
>  
>  	/* CCGR1 */
>  	clks[IMX6UL_CLK_ECSPI1]		= imx_clk_gate2("ecspi1",	"ecspi_podf",	base + 0x6c,	0);
> @@ -376,6 +377,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  	clks[IMX6UL_CLK_GPT1_SERIAL]	= imx_clk_gate2("gpt1_serial",	"perclk",	base + 0x6c,	22);
>  	clks[IMX6UL_CLK_UART4_IPG]	= imx_clk_gate2("uart4_ipg",	"ipg",		base + 0x6c,	24);
>  	clks[IMX6UL_CLK_UART4_SERIAL]	= imx_clk_gate2("uart4_serial",	"uart_podf",	base + 0x6c,	24);
> +	clks[IMX6UL_CLK_GPIO1]		= imx_clk_gate2("gpio1",	"ipg",		base + 0x6c,	26);
> +	clks[IMX6UL_CLK_GPIO5]		= imx_clk_gate2("gpio5",	"ipg",		base + 0x6c,	30);
>  
>  	/* CCGR2 */
>  	if (clk_on_imx6ull()) {
> @@ -389,6 +392,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  	clks[IMX6UL_CLK_I2C3]		= imx_clk_gate2("i2c3",		"perclk",	base + 0x70,	10);
>  	clks[IMX6UL_CLK_OCOTP]		= imx_clk_gate2("ocotp",	"ipg",		base + 0x70,	12);
>  	clks[IMX6UL_CLK_IOMUXC]		= imx_clk_gate2("iomuxc",	"lcdif_podf",	base + 0x70,	14);
> +	clks[IMX6UL_CLK_GPIO3]		= imx_clk_gate2("gpio3",	"ipg",		base + 0x70,	26);
>  	clks[IMX6UL_CLK_LCDIF_APB]	= imx_clk_gate2("lcdif_apb",	"axi",		base + 0x70,	28);
>  	clks[IMX6UL_CLK_PXP]		= imx_clk_gate2("pxp",		"axi",		base + 0x70,	30);
>  
> @@ -405,6 +409,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  	clks[IMX6UL_CLK_UART6_IPG]	= imx_clk_gate2("uart6_ipg",	"ipg",		base + 0x74,	6);
>  	clks[IMX6UL_CLK_UART6_SERIAL]	= imx_clk_gate2("uart6_serial",	"uart_podf",	base + 0x74,	6);
>  	clks[IMX6UL_CLK_LCDIF_PIX]	= imx_clk_gate2("lcdif_pix",	"lcdif_podf",	base + 0x74,	10);
> +	clks[IMX6UL_CLK_GPIO4]		= imx_clk_gate2("gpio4",	"ipg",		base + 0x74,	12);
>  	clks[IMX6UL_CLK_QSPI]		= imx_clk_gate2("qspi1",	"qspi1_podf",	base + 0x74,	14);
>  	clks[IMX6UL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74,	16);
>  	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20);
> diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
> index 9564597..1291328 100644
> --- a/include/dt-bindings/clock/imx6ul-clock.h
> +++ b/include/dt-bindings/clock/imx6ul-clock.h
> @@ -242,20 +242,25 @@
>  #define IMX6UL_CLK_CKO2_PODF		229
>  #define IMX6UL_CLK_CKO2			230
>  #define IMX6UL_CLK_CKO			231
> +#define IMX6UL_CLK_GPIO1		232
> +#define IMX6UL_CLK_GPIO2		233
> +#define IMX6UL_CLK_GPIO3		234
> +#define IMX6UL_CLK_GPIO4		235
> +#define IMX6UL_CLK_GPIO5		236

this change looks like a breakage of devicetree ABI. You are changing the mean of the existing clock IDs on i.MX6ULL, which probably regress the combination of older DTBs with newer kernel.

>  
>  /* For i.MX6ULL */
> -#define IMX6ULL_CLK_ESAI_PRED		232
> -#define IMX6ULL_CLK_ESAI_PODF		233
> -#define IMX6ULL_CLK_ESAI_EXTAL		234
> -#define IMX6ULL_CLK_ESAI_MEM		235
> -#define IMX6ULL_CLK_ESAI_IPG		236
> -#define IMX6ULL_CLK_DCP_CLK		237
> -#define IMX6ULL_CLK_EPDC_PRE_SEL	238
> -#define IMX6ULL_CLK_EPDC_SEL		239
> -#define IMX6ULL_CLK_EPDC_PODF		240
> -#define IMX6ULL_CLK_EPDC_ACLK		241
> -#define IMX6ULL_CLK_EPDC_PIX		242
> -#define IMX6ULL_CLK_ESAI_SEL		243
> -#define IMX6UL_CLK_END			244
> +#define IMX6ULL_CLK_ESAI_PRED		237
> +#define IMX6ULL_CLK_ESAI_PODF		238
> +#define IMX6ULL_CLK_ESAI_EXTAL		239
> +#define IMX6ULL_CLK_ESAI_MEM		240
> +#define IMX6ULL_CLK_ESAI_IPG		241
> +#define IMX6ULL_CLK_DCP_CLK		242
> +#define IMX6ULL_CLK_EPDC_PRE_SEL	243
> +#define IMX6ULL_CLK_EPDC_SEL		244
> +#define IMX6ULL_CLK_EPDC_PODF		245
> +#define IMX6ULL_CLK_EPDC_ACLK		246
> +#define IMX6ULL_CLK_EPDC_PIX		247
> +#define IMX6ULL_CLK_ESAI_SEL		248
> +#define IMX6UL_CLK_END			249
>  
>  #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
