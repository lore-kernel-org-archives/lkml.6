Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeCRTy0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 15:54:26 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40930 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeCRTyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 15:54:20 -0400
X-Google-Smtp-Source: AG47ELuRBarjY0XLEx4kHUeddGz1T4zqDEFzP+l9veob2x7iNicGjG56XsauxG1Bqk75rk2jd7xDKLRXTb64Zo5xtis=
MIME-Version: 1.0
In-Reply-To: <1521272215-22514-1-git-send-email-Anson.Huang@nxp.com>
References: <1521272215-22514-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 18 Mar 2018 16:54:19 -0300
Message-ID: <CAOMZO5DJ5-AdudGhk6VfTazJXBpReGHW-bxKM1=bLZO90PnXsg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7s: add anatop vdd1p2 regulator
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
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

On Sat, Mar 17, 2018 at 4:36 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Add i.MX7S/D anatop vdd1p2 regulator.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index cd6964f..1210028 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -565,6 +565,21 @@
>                                         anatop-max-voltage = <1200000>;
>                                         anatop-enable-bit = <0>;
>                                 };
> +
> +                               reg_1p2: regulator-vdd1p2@30360220 {
> +                                       reg = <0x30360220>;
> +                                       compatible = "fsl,anatop-regulator";
> +                                       regulator-name = "vdd1p2";
> +                                       regulator-min-microvolt = <1100000>;
> +                                       regulator-max-microvolt = <1300000>;
> +                                       anatop-reg-offset = <0x220>;
> +                                       anatop-vol-bit-shift = <8>;
> +                                       anatop-vol-bit-width = <5>;
> +                                       anatop-min-bit-val = <0x14>;
> +                                       anatop-min-voltage = <1100000>;
> +                                       anatop-max-voltage = <1300000>;
> +                                       anatop-enable-bit = <0>;
> +                               };

Do you also plan to add a consumer for it?
