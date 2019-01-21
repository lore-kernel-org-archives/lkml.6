Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A00C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA4D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxW54gPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfAUSK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:10:59 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38680 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfAUSK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:10:58 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so13128847vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ePGi1djNrCeIe0SI/B0q3yqtNYdAyN7eGE08EryoL/0=;
        b=gxW54gPYqgd3oTD+2FiBOY8WU4X15k/HQpiznmX+YBsp3ScTtvThRett4h5Ohc1w5v
         PGMozH/7inppv4DGAeYnkuU78bd/Mgfd0gE7929eKu8+JpUdzgt9eoLkLkAI/q1xvHtt
         KSc+Cud1cSzCMUQg0ru58sRILp67nYudW8A54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ePGi1djNrCeIe0SI/B0q3yqtNYdAyN7eGE08EryoL/0=;
        b=J1+b9zqRvveTd1XGIvDQKmMjmZYosuUGVL8738LzueVZdKBt9rcIdEIkFCCItVJnK8
         LxPsXiSuDXe/yAQH8tjHU955QCzQTBUeods9FX+fEuJFSHPGY7Q6YbHcSTPWB3icUNIM
         X1xpRUV6fKCJJBS2NwByPhf/AWJo/6lojDenBXhAgniJIov5GAi1fc+wDZ6UstgrypkJ
         UdoQbdc+fF1sL1T0qp2r105IdOIxBqS4ebHBa0+smqlSIsqmQBeyS7UacQBw9tJLHmRg
         WZ8mFWa97OlwJ/I3Dm+LKJSbQrEoqp/55/Y3OoJkJqGE5aqoefY3ODL+wEKUuSucwSVx
         G/Fw==
X-Gm-Message-State: AJcUukcAFGamrYY9FyL3cEvdxmDL4oCh+/VpBhCBJ5F8Q2XKxVgszFqP
        e4kJj90KbYCT1Hqv/AHEhjUQ7a5yXAUCtOkIr+uTeA==
X-Google-Smtp-Source: ALg8bN61RxJ/jaz67t4gV1ts4vsmaEX9bRHTvAlmqTojVyhV1CPgcervE7+p6DWSLYSwomf/xac3W0FjsMxs2oXVfC8=
X-Received: by 2002:a05:6102:193:: with SMTP id r19mr12983458vsq.9.1548094256924;
 Mon, 21 Jan 2019 10:10:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <7f94696460848a6bcfe5aee5ffda7fe556240736.1547458732.git.amit.kucheria@linaro.org>
 <20190114220101.GN261387@google.com>
In-Reply-To: <20190114220101.GN261387@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Jan 2019 23:40:45 +0530
Message-ID: <CAHLCerPtVeNo_bMn78RPz8Gz5zgw9jKyWYVRSMpLasbiiSPjnA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] arm64: dts: sdm845: wireup the thermal trip points
 to cpufreq
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 3:31 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Mon, Jan 14, 2019 at 03:51:10PM +0530, Amit Kucheria wrote:
> > Since all cpus in the big and little clusters, respectively, are in the
> > same frequency domain, use all of them for mitigation in the
> > cooling-map. We end up with two cooling devices - one each for the big
> > and little clusters.
> >
> > At the lower trip points we restrict ourselves to throttling only a few
> > OPPs. At higher trip temperatures, allow ourselves to be throttled to
> > any extent.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 177 ++++++++++++++++++++++++---
> >  1 file changed, 161 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts=
/qcom/sdm845.dtsi
> > index fb7da678b116..7973e88bdf94 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >
> > ...
> >
> > @@ -1719,18 +1728,35 @@
> >                       thermal-sensors =3D <&tsens0 1>;
> >
> >                       trips {
> > -                             cpu_alert0: trip0 {
> > +                             cpu0_alert0: trip-point@0 {
>
> Thanks for adapting the trip point names and labels in anticipation of
> further additions!
>
> Seems you aren't overly convinced about the 'target/threshold'
> terminology used by some other arm64 platforms ;-)

target and threshold have an air of finality to them and doesn't lend
itself to having a few trip points on the way to the critical trip,
IMO.

Let me know if you feel otherwise.

> >                                       temperature =3D <95000>;
> >                                       hysteresis =3D <2000>;
> >                                       type =3D "passive";
> >                               };
>
> I realized that we still have the potential problem of a name change
> in the trip point node name if a 'threshold' node for IPA is added,
> since this node will have a lower temperature than 95=C2=B0. If this is
> something to be concerned about it might be worth to add that extra
> trip point already to avoid headaches or funky trip point enumeration,
> even if we know that the value might not be the final one.

I will squash both the DT changes in to a single change introducing 2
passive trips and 1 critical trip to avoid the churn. See if you like
it better.

> (I'm aware that we are also changing the node names and labels right
> now, it seems less problematic at this point since the SDM845 thermal
> zones are a fairly recent addition)
>
> > -                             cpu_crit0: trip1 {
> > +                             cpu0_crit: cpu_crit@0 {
>
> nit: does the @0 add any value here? IIUC there can be only one
> critical trip point, hence there will never be a cpu_crit@1 or
> higher.

Agreed. Will remove.

> >                                       temperature =3D <110000>;
> >                                       hysteresis =3D <1000>;
> >                                       type =3D "critical";
> >                               };
> >                       };
> > +
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&cpu0_alert0>;
> > +                                     cooling-device =3D <&CPU0 THERMAL=
_NO_LIMIT 4>,
> > +                                                      <&CPU1 THERMAL_N=
O_LIMIT 4>,
> > +                                                      <&CPU2 THERMAL_N=
O_LIMIT 4>,
> > +                                                      <&CPU3 THERMAL_N=
O_LIMIT 4>;
> > +                             };
>
> Out of curiosity: how did you determing the max cooling state of 4?

Just some basic testing by pinning a dhrystone benchmark to each of
the cores along with some stress-ng threads. Lopping off the top 4
OPPs seemed to mitigate anything I could throw at the board.

I'm unable to do the "device in a closed car on a hot summer day" type
of tests on the dev board. Nevertheless, I've changed the patch now to
only remove the boost frequency at 75 degrees and then full throttling
at 95 degrees.

I'd appreciate more "real world" testing to validate these.

Thanks for the review.

Regards,
Amit
