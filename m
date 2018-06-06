Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EltKQmv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ED0B601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932414AbeFFINM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:13:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39497 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbeFFINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:13:10 -0400
X-Google-Smtp-Source: ADUXVKKvMQ7D5Iqkzkg4UxspQbinQazH9tfN+gCyWw8tVG+PaR6PmkHnZu+x50G6xZbgRkqr3oKnQLHH2UVk6qikFBk=
MIME-Version: 1.0
References: <20180604100035.19558-1-peron.clem@gmail.com> <20180604100035.19558-3-peron.clem@gmail.com>
 <20180605152323.GA25218@rob-hp-laptop>
In-Reply-To: <20180605152323.GA25218@rob-hp-laptop>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Wed, 6 Jun 2018 10:12:58 +0200
Message-ID: <CAJiuCcfZAu1hOg8buf78h5cRaHGzqpmOrLQC9dmYVwO6dcGG7g@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: timer: add i.MX EPIT timer binding
To: Rob Herring <robh@kernel.org>
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
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 5 Jun 2018 at 17:23, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 04, 2018 at 12:00:33PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> >
> > Add devicetree binding document for NXP's i.MX SoC specific
> > EPIT timer driver.
> >
> > Signed-off-by: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> > ---
> >  .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit=
.txt
> >
> > diff --git a/Documentation/devicetree/bindings/timer/fsl,imxepit.txt b/=
Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> > new file mode 100644
> > index 000000000000..de2e6ef68d24
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> > @@ -0,0 +1,21 @@
> > +Binding for the i.MX Enhanced Periodic Interrupt Timer (EPIT)
> > +
> > +The Enhanced Periodic Interrupt Timer (EPIT) is a 32-bit set-and-forge=
t timer
> > +that is capable of providing precise interrupts at regular intervals w=
ith
> > +minimal processor intervention.
> > +
> > +Required properties:
> > +- compatible: should be "fsl,<chip>-epit", "fsl,imx31-epit" where <chi=
p> is
> > +  imx25, imx6qdl, imx6sl, imx6sul or imx6sx.
> > +- reg: physical base address of the controller and length of memory ma=
pped
> > +  region.
> > +- interrupts: Should contain EPIT controller interrupt
> > +- clocks : The clock provided by the SoC to drive the timer.
> > +
> > +Example for i.MX6QDL:
> > +     epit1: epit@20d0000 {
>
> I think I already mentioned this, but:
My bad, will update it

>
> timer@...
>
> > +             compatible =3D "fsl,imx6qdl-epit", "fsl,imx31-epit";
> > +             reg =3D <0x020d0000 0x4000>;
> > +             interrupts =3D <0 56 IRQ_TYPE_LEVEL_HIGH>;
> > +             clocks =3D <&clks IMX6QDL_CLK_EPIT1>;
> > +     };
> > --
> > 2.17.0
> >
