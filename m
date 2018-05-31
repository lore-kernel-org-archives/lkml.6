Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeEaI1K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:27:10 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:51819 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeEaI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:27:05 -0400
Subject: Re: [PATCH v4 3/5] Documentation: DT: add i.MX EPIT timer binding
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Colin Didier <colin.didier@devialet.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180530120327.27681-1-peron.clem@gmail.com>
 <20180530120327.27681-4-peron.clem@gmail.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <0eb40af3-b741-2e65-3af9-f150345beb3c@mentor.com>
Date: Thu, 31 May 2018 11:26:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180530120327.27681-4-peron.clem@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On 05/30/2018 03:03 PM, Clément Péron wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
> 
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxepit.txt | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxepit.txt b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> new file mode 100644
> index 000000000000..90112d58af10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> @@ -0,0 +1,24 @@
> +Binding for the i.MX EPIT timer
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +

no, this leftover reference to clock-bindings.txt is invalid, please remove it.

Instead you may add a simple description of the timer module.

> +Required properties:
> +- compatible: should be "fsl,imx31-epit"

To satisfy compatibles with multiple SoCs, apparently you may follow a model,
which is used with other Freescale controllers, for instance

gpio/fsl-imx-gpio.txt	- compatible : Should be "fsl,<soc>-gpio"
mmc/fsl-imx-esdhc.txt	- compatible : Should be "fsl,<chip>-esdhc"
serial/fsl-imx-uart.txt	- compatible : Should be "fsl,<soc>-uart"
timer/fsl,imxgpt.txt	- compatible : should be "fsl,<soc>-gpt"

and so on, I hope it would cover Rob's ask.

> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: Should contain EPIT controller interrupt
> +- clocks: list of clock specifiers, must contain an entry for each required
> +  entry in clock-names
> +- clock-names : should include entries "ipg", "per"
> +
> +Example for i.MX6QDL:
> +	epit1: epit@20d0000 {
> +		compatible = "fsl,imx6q-epit", "fsl,imx31-epit";
> +		reg = <0x020d0000 0x4000>;
> +		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clks IMX6QDL_CLK_IPG_PER>,
> +			<&clks IMX6QDL_CLK_EPIT1>;
> +		clock-names = "ipg", "per";
> +	};
> 

--
With best wishes,
Vladimir
