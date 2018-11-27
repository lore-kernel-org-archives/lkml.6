Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0AD21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tILrW8KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0AD21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeK0Ryl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:54:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbeK0Ryl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:54:41 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC28A208E4;
        Tue, 27 Nov 2018 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543301868;
        bh=sAQFdGTu7EaEXxYSPwCvjnKgxjzLtKhfFl6IsnoqMo0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tILrW8KXvwsDnb3lTPWEGvPiwcFo3RlGt9EXPx1OXmY92Qqx2VTAmWr/sRXIl1ezA
         2rGV/r5k/wUsoorLUYJ1du3lsU9j6A1zC8XyvUZbhhMDceM+/hBERSyX3BrSTw8kB4
         vlvOPd8b4Au+qHRKO2prVmmu/aGhxxwVaqAEzd7M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAD=FV=X3C=oKep1kPWjasLDZdFKfhCs0JMWTOensgYDj=apvuQ@mail.gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <1541414117-27864-1-git-send-email-tdas@codeaurora.org>
 <CAD=FV=X3C=oKep1kPWjasLDZdFKfhCs0JMWTOensgYDj=apvuQ@mail.gmail.com>
Message-ID: <154330186815.88331.12720647562079303842@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] arm64: dts: sdm845: Add videocc node
Date:   Mon, 26 Nov 2018 22:57:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-11-26 16:35:50)
> Hi,
> =

> On Mon, Nov 5, 2018 at 2:35 AM Taniya Das <tdas@codeaurora.org> wrote:
> >
> > This adds the video clock controller node to sdm845 based on the exampl=
es
> > in the bindings.
> >
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts=
/qcom/sdm845.dtsi
> > index b72bdb0..91a281b 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -8,6 +8,7 @@
> >  #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
> >  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> > +#include <dt-bindings/clock/qcom,videocc-sdm845.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/phy/phy-qcom-qusb2.h>
> >  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> > @@ -1256,6 +1257,13 @@
> >                         #power-domain-cells =3D <1>;
> >                 };
> >
> > +               videocc: clock-controller@ab00000 {
> > +                       compatible =3D "qcom,sdm845-videocc";
> > +                       reg =3D <0xab00000 0x10000>;
> > +                       #clock-cells =3D <1>;
> > +                       #power-domain-cells =3D <1>;
> =

> Any reason not to include "#reset-cells =3D <1>;" here?  The bindings
> list it as optional but I see no reason why we should leave it off.
> The file "include/dt-bindings/clock/qcom,videocc-sdm845.h" seems to
> include some #defines for resets.  Even though the driver doesn't seem
> like it supports it yet, it still should be fine to list it here.

We should update the binding to make it a required property. It doesn't
make any sense why that property would be optional given that the
hardware either has support for resets or it doesn't.

