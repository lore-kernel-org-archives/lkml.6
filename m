Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeCQOxL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 10:53:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40420 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbeCQOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 10:53:09 -0400
X-Google-Smtp-Source: AG47ELshY+1WxmKVvPmTq2vPEQfH1P1bo6OhpMvRo3a8Jpz5JNoAQDiOvwXePbzkEHcIeHdkyM6PZ8oZ9JemlDH4/sc=
MIME-Version: 1.0
In-Reply-To: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 Mar 2018 11:53:08 -0300
Message-ID: <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Sat, Mar 17, 2018 at 3:57 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Update sw1a/vldo4's voltage range according to latest pfuze3000
> datasheet from:
>
> http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-udoo-neo.dtsi  | 2 +-
>  arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
>  arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
>  arch/arm/boot/dts/imx7d-sdb.dts         | 6 +++---
>  arch/arm/boot/dts/imx7s-warp.dts        | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> index 53b3eac..1de0a0f 100644
> --- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> @@ -142,7 +142,7 @@
>                 regulators {
>                         sw1a_reg: sw1a {
>                                 regulator-min-microvolt = <700000>;
> -                               regulator-max-microvolt = <1475000>;
> +                               regulator-max-microvolt = <3300000>;

This change does not look like a safe thing to do without carefully
checking each one of the board schematics.

Even if the regulator itself is capable of driving a higher voltage,
it does not mean that the circuitry that consumes such regulator is
allowed to receive the higher voltages.
