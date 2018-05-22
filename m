Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeEVRwy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:52:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42372 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbeEVRwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:52:51 -0400
Date: Tue, 22 May 2018 19:52:30 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH 1/5] mtd: rawnand: tegra: add devicetree binding
Message-ID: <20180522195230.471a796e@bbrezillon>
In-Reply-To: <8bd0f80a9db9abc7af192d1c7d449887b1392ff7.1526990589.git.stefan@agner.ch>
References: <cover.1526990589.git.stefan@agner.ch>
        <8bd0f80a9db9abc7af192d1c7d449887b1392ff7.1526990589.git.stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stefan,

On Tue, 22 May 2018 14:07:05 +0200
Stefan Agner <stefan@agner.ch> wrote:

> From: Lucas Stach <dev@lynxeye.de>
> 
> This adds the devicetree binding for the Tegra 2 NAND flash
> controller.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../bindings/mtd/nvidia,tegra20-nand.txt      | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> new file mode 100644
> index 000000000000..522d442937a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> @@ -0,0 +1,29 @@
> +NVIDIA Tegra NAND Flash controller
> +
> +Required properties:
> +- compatible: Must be one of:
> +  - "nvidia,tegra20-nand"
> +- reg: MMIO address range
> +- interrupts: interrupt output of the NFC controller
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - nand
> +- resets: Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names: Must include the following entries:
> +  - nand
> +
> +Optional properties:
> +- nvidia,wp-gpios: GPIO used to disable write protection of the flash
> +
> +  Example:
> +	nand@70008000 {
> +		compatible = "nvidia,tegra20-nand";
> +		reg = <0x70008000 0x100>;
> +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
> +		clock-names = "nand";
> +		resets = <&tegra_car 13>;
> +		reset-names = "nand";
> +	};

Can you represent the controller and NAND chip separately as
recommended here [1].

Thanks,

Boris

[1]https://elixir.bootlin.com/linux/v4.17-rc6/source/Documentation/devicetree/bindings/mtd/nand.txt#L56
