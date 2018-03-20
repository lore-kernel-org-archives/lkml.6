Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935391AbeCTAud convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 20:50:33 -0400
Received: from mx.socionext.com ([202.248.49.38]:13824 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934310AbeCTAuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 20:50:32 -0400
From: "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To: "'Masahiro Yamada'" <yamada.masahiro@socionext.com>,
        =?utf-8?B?U3V6dWtpLCBLYXRzdWhpcm8v6Yi05pyoIOWLneWNmg==?=
        <suzuki.katsuhiro@socionext.com>
Cc: "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20180319012158.26411-1-suzuki.katsuhiro@socionext.com> <CAK7LNAQ__FYvJdvxPhzazyi4fSCwkMzCWGVVjy5FKfOp+-hfcg@mail.gmail.com>
In-Reply-To: <CAK7LNAQ__FYvJdvxPhzazyi4fSCwkMzCWGVVjy5FKfOp+-hfcg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: uniphier: add syscon property for UniPhier sound system
Date: Tue, 20 Mar 2018 09:50:26 +0900
Message-ID: <000001d3bfe5$700b96a0$5022c3e0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTvyCuNy3eRnP45UWnGwTt5cZSeqPXCfAAgAFCL2A=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yamada-san,

Thank you for reviewing.


> -----Original Message-----
> From: Masahiro Yamada [mailto:yamada.masahiro@socionext.com]
> Sent: Monday, March 19, 2018 11:36 PM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>;
> devicetree@vger.kernel.org; Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi
> Brar <jaswinder.singh@linaro.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] arm64: dts: uniphier: add syscon property for UniPhier sound
> system
> 
> 2018-03-19 10:21 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> > This patch adds syscon property for specifying soc-glue core into
> > device-tree of LD11/LD20 SoC.
> >
> > Currently, soc-glue core is used for changing the state of S/PDIF
> > signal output pin to signal output state or Hi-Z state.
> >
> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> > ---
> >  arch/arm/boot/dts/uniphier-pxs2.dtsi             | 4 +++-
> 
> 
> Please split PXs2 changes into a different patch.
> 
> 
> >  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 4 +++-
> >  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 4 +++-
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> > index 595045441c9c..c72c0a123c87 100644
> > --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> > +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> > @@ -243,6 +243,8 @@
> >                         resets = <&sys_rst 40>;
> >                         #sound-dai-cells = <1>;
> >
> > +                       socionext,syscon = <&sg>;
> 
> 
> Remove unneeded blank line between properties.
> 
> 
> > +
> >                         i2s_port0: port@0 {
> >                                 i2s_hdmi: endpoint {
> >                                 };
> > @@ -418,7 +420,7 @@
> >                         };
> >                 };
> >
> > -               soc-glue@5f800000 {
> > +               sg: soc-glue@5f800000 {
> >                         compatible = "socionext,uniphier-pxs2-soc-glue",
> >                                      "simple-mfd", "syscon";
> >                         reg = <0x5f800000 0x2000>;
> 
> 
> Could you use 'soc_glue', please?
> I saw a conflict between 'sg' and 'soc_glue' among Socionext engineers
> and I prefer the latter.

I see, I'll fix and send v2 series.


Regards,
--
Katsuhiro Suzuki


> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
