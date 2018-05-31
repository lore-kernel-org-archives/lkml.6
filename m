Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeEaImC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:42:02 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42460 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeEaIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:41:59 -0400
X-Google-Smtp-Source: ADUXVKKCP1IPcMMN4x1Rz9WDWGlV7NeKKl91IgNp+L6F+WQ4MuglhlobxE5iQY2QQHurrgR1XuDvEi/QnZ+sqYl/8Wk=
MIME-Version: 1.0
References: <20180530120327.27681-1-peron.clem@gmail.com> <20180530120327.27681-6-peron.clem@gmail.com>
 <a4042956-24e1-6132-4606-b5b8f4e30023@mentor.com>
In-Reply-To: <a4042956-24e1-6132-4606-b5b8f4e30023@mentor.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Thu, 31 May 2018 10:41:47 +0200
Message-ID: <CAJiuCcefvMg6r=06O8m1TYa0hat_dHydcoJ7PN58qUru1K8zMQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] ARM: dts: imx6qdl: add missing compatible and
 clock properties for EPIT
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4V8giup025809

Hi Vladimir,

On Thu, 31 May 2018 at 10:33, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
>
> On 05/30/2018 03:03 PM, Clément Péron wrote:
> > From: Colin Didier <colin.didier@devialet.com>
> >
> > Add missing compatible and clock properties for EPIT node.
> >
> > Signed-off-by: Colin Didier <colin.didier@devialet.com>
> > Signed-off-by: Clément Peron <clement.peron@devialet.com>
> > Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index c003e62bf290..0feec516847a 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -844,13 +844,23 @@
> >                       };
> >
> >                       epit1: epit@20d0000 { /* EPIT1 */
>
> epit1: timer@20d0000 { ...
>
> And /* EPIT1 */ comment can be removed, it is quite clear from the same
> line context.
>
> Formally it is a subject to another patch, but I think this can be
> accepted as a part of this one.

Should I also update other boards ?
I only did it for imx6qdl.dtsi, but the EPIT is present in other boards
but i can't test it myself.

>
> > +                             compatible = "fsl,imx6q-epit", "fsl,imx31-epit";
> >                               reg = <0x020d0000 0x4000>;
> >                               interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
> > +                             clocks = <&clks IMX6QDL_CLK_IPG_PER>,
> > +                                      <&clks IMX6QDL_CLK_EPIT1>;
> > +                             clock-names = "ipg", "per";
> > +                             status = "disabled";
> >                       };
> >
> >                       epit2: epit@20d4000 { /* EPIT2 */
>
> Same as above.
>
> > +                             compatible = "fsl,imx6q-epit", "fsl,imx31-epit";
> >                               reg = <0x020d4000 0x4000>;
> >                               interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
> > +                             clocks = <&clks IMX6QDL_CLK_IPG_PER>,
> > +                                      <&clks IMX6QDL_CLK_EPIT2>;
> > +                             clock-names = "ipg", "per";
> > +                             status = "disabled";
> >                       };
> >
> >                       src: src@20d8000 {
> >
>
> --
> With best wishes,
> Vladimir
