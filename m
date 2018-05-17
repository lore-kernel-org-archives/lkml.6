Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeEQHYj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:24:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeEQHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:24:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 227BA60209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Amit Kucheria'" <amit.kucheria@linaro.org>
Cc: "'Michael Turquette'" <mturquette@baylibre.com>, <sboyd@kernel.org>,
        "'Rob Herring'" <robh@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>, <nm@ti.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        "'Andy Gross'" <andy.gross@linaro.org>,
        "'David Brown'" <david.brown@linaro.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM list'" <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        "'lakml'" <linux-arm-kernel@lists.infradead.org>,
        "'Rajendra Nayak'" <rnayak@codeaurora.org>,
        <nicolas.dechesne@linaro.org>, <celster@codeaurora.org>,
        <tfinkel@codeaurora.org>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org> <1526375616-16904-11-git-send-email-ilialin@codeaurora.org> <CAHLCerOxcUMTztT75rdkS-rrQWqEEgoVQr45Ueh_JRPE7CCm7Q@mail.gmail.com>
In-Reply-To: <CAHLCerOxcUMTztT75rdkS-rrQWqEEgoVQr45Ueh_JRPE7CCm7Q@mail.gmail.com>
Subject: RE: [PATCH v7 10/14] dt-bindings: qcom_spmi: Add support for SAW documentation
Date: Thu, 17 May 2018 10:24:05 +0300
Message-ID: <017401d3edb0$0e3d6d10$2ab84730$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGnp1nyG6UZbI+UZ9yYhcbjWitfQAIo5tdvAd+Cwb6ka825oA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4H7OjFn020596



> -----Original Message-----
> From: amit.kucheria@verdurent.com <amit.kucheria@verdurent.com> On
> Behalf Of Amit Kucheria
> Sent: Wednesday, May 16, 2018 16:13
> To: Ilia Lin <ilialin@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>; sboyd@kernel.org; Rob
> Herring <robh@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Viresh
> Kumar <viresh.kumar@linaro.org>; nm@ti.com; lgirdwood@gmail.com;
> broonie@kernel.org; Andy Gross <andy.gross@linaro.org>; David Brown
> <david.brown@linaro.org>; catalin.marinas@arm.com;
> will.deacon@arm.com; Rafael J. Wysocki <rjw@rjwysocki.net>; linux-
> clk@vger.kernel.org; devicetree@vger.kernel.org; LKML <linux-
> kernel@vger.kernel.org>; Linux PM list <linux-pm@vger.kernel.org>; linux-
> arm-msm@vger.kernel.org; linux-soc@vger.kernel.org; lakml <linux-arm-
> kernel@lists.infradead.org>; Rajendra Nayak <rnayak@codeaurora.org>;
> nicolas.dechesne@linaro.org; celster@codeaurora.org;
> tfinkel@codeaurora.org
> Subject: Re: [PATCH v7 10/14] dt-bindings: qcom_spmi: Add support for SAW
> documentation
> 
> On Tue, May 15, 2018 at 12:13 PM, Ilia Lin <ilialin@codeaurora.org> wrote:
> > Add support for SAW controlled regulators.
> > The regulators defined as SAW controlled in the device tree will be
> > controlled through special CPU registers instead of direct SPMI
> > accesses.
> > This is required especially for CPU supply regulators to synchronize
> > with clock scaling and for Automatic Voltage Switching.
> > Document it.
> 
> Replace this boiler plate with what this patch actual does. Besides changing
> the subject, it could be, for example,
> 
> "Document the DT bindings for the SAW regulators.
> 
> The saw-slave property allows ganging (grouping) of several regulators so
> that their outputs can be combined... blah blah.
> 
> The saw-leader is the only one that then is configurable in DT"

Actually, I invested some fantasy to write this explanation. But I'll try to revise it.

> 
> 
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/regulator/qcom,spmi-regulator.txt     | 45
> ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > index 57d2c65..406f2e5 100644
> > ---
> > a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-
> regulator.
> > +++ txt
> > @@ -110,6 +110,11 @@ Qualcomm SPMI Regulators
> >         Definition: Reference to regulator supplying the input pin, as
> >                     described in the data sheet.
> >
> > +- qcom,saw-reg:
> > +       Usage: optional
> > +       Value type: <phandle>
> > +       Description: Reference to syscon node defining the SAW registers.
> > +
> >
> >  The regulator node houses sub-nodes for each regulator within the
> > device. Each  sub-node is identified using the node's name, with valid
> > values listed for each @@ -201,6 +206,17 @@ see regulator.txt - with
> additional custom properties described below:
> >                         2 = 0.55 uA
> >                         3 = 0.75 uA
> >
> > +- qcom,saw-slave:
> > +       Usage: optional
> > +       Value type: <boo>
> > +       Description: SAW controlled gang slave. Will not be configured.
> > +
> > +- qcom,saw-leader:
> > +       Usage: optional
> > +       Value type: <boo>
> > +       Description: SAW controlled gang leader. Will be configured as
> > +                    SAW regulator.
> > +
> >  Example:
> >
> >         regulators {
> > @@ -221,3 +237,32 @@ Example:
> >
> >                 ....
> >         };
> > +
> > +Example 2:
> > +
> > +       saw3: syscon@9A10000 {
> > +               compatible = "syscon";
> > +               reg = <0x9A10000 0x1000>;
> > +       };
> > +
> > +       ...
> > +
> > +       spm-regulators {
> > +               compatible = "qcom,pm8994-regulators";
> > +               qcom,saw-reg = <&saw3>;
> > +               s8 {
> > +                       qcom,saw-slave;
> > +               };
> > +               s9 {
> > +                       qcom,saw-slave;
> > +               };
> > +               s10 {
> > +                       qcom,saw-slave;
> > +               };
> > +               pm8994_s11_saw: s11 {
> > +                       qcom,saw-leader;
> > +                       regulator-always-on;
> > +                       regulator-min-microvolt = <900000>;
> > +                       regulator-max-microvolt = <1140000>;
> > +               };
> > +       };
> > --
> > 1.9.1
> >
