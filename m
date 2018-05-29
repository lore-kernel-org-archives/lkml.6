Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935843AbeE2PPM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:15:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40101 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935212AbeE2PPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:15:05 -0400
X-Google-Smtp-Source: AB8JxZpTFmH/pCH2OZyk0R3jU9GwASsl2j+iRbJ0aw+YsPh7yxzBEH01NtiGQnEGPNkACV7WLKVrwbs7uRayYQiOXsg=
MIME-Version: 1.0
In-Reply-To: <20180529150455.17300-4-peron.clem@gmail.com>
References: <20180529150455.17300-1-peron.clem@gmail.com> <20180529150455.17300-4-peron.clem@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 May 2018 12:15:04 -0300
Message-ID: <CAOMZO5CPUcTVkRhLDbBoZ2_WHy0UBOPDvEWBvTDp4DcCEjo6pw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Documentation: DT: add i.MX EPIT timer binding
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TFFhnR000837

On Tue, May 29, 2018 at 12:04 PM, Clément Péron <peron.clem@gmail.com> wrote:
> From: Clément Peron <clement.peron@devialet.com>
>
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---
>  .../devicetree/bindings/clock/imx6q,epit.txt  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6q,epit.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/imx6q,epit.txt b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
> new file mode 100644
> index 000000000000..d54d455cebdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
> @@ -0,0 +1,25 @@
> +Binding for the i.MX6 EPIT timer
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible: should be "fsl,imx6q-epit"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: Should contain EPIT controller interrupt
> +- clocks: list of clock specifiers, must contain an entry for each required
> +  entry in clock-names
> +- clock-names : as described in the clock bindings

Please list the name of each required clock here.

I see that the driver does not request a "ckil" clock.
