Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C67C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D59420823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549404966;
	bh=umpQPksptIkOehMreOlU/V5d6V4wOERTvvCniVu/IH0=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=nA8heTguxNCosFUjta4cI/otSEy4axHblzZxExrZF8wwXUI6lhDOsY/RdPeJcsTlf
	 rOjqH+MiHmJs32AwYm9IM4khFqR11+wqcTeWaS0E26GZRa1xbBd1SbHN3xf7xzn0h7
	 Gl7Bld08d2zLUFOqUBihNvFaUfhZlFbv5ffiIZHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfBEWQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:16:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfBEWQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:16:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAFF20823;
        Tue,  5 Feb 2019 22:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549404963;
        bh=umpQPksptIkOehMreOlU/V5d6V4wOERTvvCniVu/IH0=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=fHpwgn1kOYFXyRd7g/acRnekadp+MshVAaVzAFGpgOmHj7JRoixFHhtshJ2esF4UX
         yIZ5ZF093htnRA61zrvQSgifMrEvhcmpe8qWbTMSsatYdX9KFVzfINqlIPE8d9opRT
         vWakjWimk9TpxzeUBi02Wsbq60fE4RFEwfdmwDN0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: Add support for the MSM8998 mmcc
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940496255.169292.11279175475668034167@swboyd.mtv.corp.google.com>
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org> <1548866159-30304-1-git-send-email-jhugo@codeaurora.org> <154940414347.169292.9150834270087697417@swboyd.mtv.corp.google.com> <ba5d7855-9dd2-5a99-ae8c-a7fce125ca25@codeaurora.org>
User-Agent: alot/0.8
To:     Jeffrey Hugo <jhugo@codeaurora.org>, bjorn.andersson@linaro.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org
In-Reply-To: <ba5d7855-9dd2-5a99-ae8c-a7fce125ca25@codeaurora.org>
Date:   Tue, 05 Feb 2019 14:16:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-02-05 14:08:43)
> On 2/5/2019 3:02 PM, Stephen Boyd wrote:
> > Quoting Jeffrey Hugo (2019-01-30 08:35:59)
> >> Document the multimedia clock controller found on MSM8998
> >>
> >> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> >> ---
> >>   Documentation/devicetree/bindings/clock/qcom,mmcc.txt | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/D=
ocumentation/devicetree/bindings/clock/qcom,mmcc.txt
> >> index 8b0f784..ae85bca 100644
> >> --- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
> >> +++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
> >> @@ -10,11 +10,18 @@ Required properties :
> >>                          "qcom,mmcc-msm8960"
> >>                          "qcom,mmcc-msm8974"
> >>                          "qcom,mmcc-msm8996"
> >> +                       "qcom,mmcc-msm8998"
> >>  =20
> >>   - reg : shall contain base register location and length
> >>   - #clock-cells : shall contain 1
> >>   - #reset-cells : shall contain 1
> >>  =20
> >> +For MSM8998 only:
> >> +       - clocks: a list of phandles and clock-specifier pairs,
> >> +                 one for each entry in clock-names.
> >> +       - clock-names: "xo" for the xo clock,
> >> +                      "gpll0" for the global pll 0 clock.
> >=20
> > Wouldn't the DSI plls also be listed here? And anything else that is
> > external to this clock controller?
> >=20
>=20
> We can't get the DSI plls from DT as far as I am aware (upstream).  That =

> is why I mentioned in the cover letter we need to rely on the global=20
> namespace.

Why not? Because the DSI PLL isn't a clk provider? Or it doesn't have
#clock-cells? Please try to use the DSI PLLs from DT or at least specify
them in the binding as optional clocks that may not matter if DSI is not
enabled for example.

>=20
> Also, the DSI plls, etc present a chicken and egg situation, as the plls =

> require mmcc, and mmcc requires the plls.  I forsee an unsolvable=20
> EPROBE_DEFER issue.
>=20

We've "solved" that problem with orphan clks and the clk parent rewrite
series. Maybe you can try it out to help flush out any bugs lurking
there.
