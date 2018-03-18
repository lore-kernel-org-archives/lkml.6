Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbeCRNDs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 09:03:48 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39587 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeCRNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 09:03:44 -0400
X-Google-Smtp-Source: AG47ELsixqtr7AszgvBIiHLpjRv2EnE4l+8SDMDh7iylVyDL5prs5HM0U03ppkp9QBqbtNNEVNBFAwjNKFEJPefllwM=
MIME-Version: 1.0
In-Reply-To: <1521342853-2941-2-git-send-email-Anson.Huang@nxp.com>
References: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com> <1521342853-2941-2-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 18 Mar 2018 10:03:43 -0300
Message-ID: <CAOMZO5CG6XuJ7N8W--zEwEVd9JHj887_7aNp+K8D-Xt1OnKh7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock source
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 12:14 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 72da5ac..83f7cac 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -18,6 +18,14 @@
>                 reg = <0x80000000 0x80000000>;
>         };
>
> +       clocks {
> +               codec_osc: anaclk2 {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <24576000>;
> +               };
> +       };

The clocks container should be removed and the clock node could be put
directly into the root node.

Also, I do not see 'codec_osc' being used in this dts.
