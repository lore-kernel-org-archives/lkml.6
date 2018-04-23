Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754772AbeDWLIj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:08:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33883 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeDWLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:08:37 -0400
X-Google-Smtp-Source: AIpwx4/aBkI6Z9eDVYv1s3WxMDSLudyoynQL8SRnJQvh1kDg8JE6GBagbvPqJ3YXZLbkGehncPhdVNzWJRSHGMuNZ54=
MIME-Version: 1.0
In-Reply-To: <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com> <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Apr 2018 08:08:36 -0300
Message-ID: <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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

On Mon, Apr 23, 2018 at 12:46 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Add FEC support on i.MX6SX Sabre Auto board.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 70 ++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 812f40b..eadd483 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -41,6 +41,40 @@
>         clock-frequency = <24576000>;
>  };
>
> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet1_1>;
> +       phy-mode = "rgmii";
> +       phy-handle = <&ethphy1>;
> +       pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;

This property does not exist in mainline, only in the NXP vendor kernel.
