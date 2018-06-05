Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeFEPXb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:23:31 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38288 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeFEPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:23:27 -0400
X-Google-Smtp-Source: ADUXVKIhQShG/3b5ZklmFm1QMt6BaCFOAziX06SanvdVLQJT7wkSUhgms62pm+d0MqJSmeFYWhMHKg==
Date: Tue, 5 Jun 2018 09:23:23 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?iso-8859-1?Q?Cl=E9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: timer: add i.MX EPIT timer binding
Message-ID: <20180605152323.GA25218@rob-hp-laptop>
References: <20180604100035.19558-1-peron.clem@gmail.com>
 <20180604100035.19558-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180604100035.19558-3-peron.clem@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 12:00:33PM +0200, Clément Péron wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
> 
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxepit.txt b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> new file mode 100644
> index 000000000000..de2e6ef68d24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> @@ -0,0 +1,21 @@
> +Binding for the i.MX Enhanced Periodic Interrupt Timer (EPIT)
> +
> +The Enhanced Periodic Interrupt Timer (EPIT) is a 32-bit set-and-forget timer
> +that is capable of providing precise interrupts at regular intervals with
> +minimal processor intervention.
> +
> +Required properties:
> +- compatible: should be "fsl,<chip>-epit", "fsl,imx31-epit" where <chip> is
> +  imx25, imx6qdl, imx6sl, imx6sul or imx6sx.
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: Should contain EPIT controller interrupt
> +- clocks : The clock provided by the SoC to drive the timer.
> +
> +Example for i.MX6QDL:
> +	epit1: epit@20d0000 {

I think I already mentioned this, but:

timer@...

> +		compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
> +		reg = <0x020d0000 0x4000>;
> +		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clks IMX6QDL_CLK_EPIT1>;
> +	};
> -- 
> 2.17.0
> 
