Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0AAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1701520854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XftQEVf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfAVSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:18:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40525 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAVSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:18:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so11868217plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NVx6E9EXWd7voBS4o/usru2EgOg1o16DwxkCr2d+GAw=;
        b=XftQEVf22uyXP6E7ZlchEh/RXGd2VYFTCVP8MnCCRPHvCGW38ZGjktEwHBWkdegqNA
         bLfGvNc4qVzgCbJ053fjlDCVRfYpwPk2zlhx/9tpI5GEbnoZ99pG2ie1hVwA9+MMEpH3
         HCi6jabLU0PV2Y02XtFkfzMp6r9U8LfJnSW7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NVx6E9EXWd7voBS4o/usru2EgOg1o16DwxkCr2d+GAw=;
        b=mI84uWJ85o9DGCwoVEJDLqksmRThvM/ZD6kVAy9fY0Nqt70QFvMqQPugcLAKRvpP9h
         kvC2O+5hMJdfKRF79y/EIPqqKfai2Q8VVb6up9vawcL/hmpdA78AjNdImtE5U20SqXZW
         JXPGi9qAp0OG5GEUBVVys9CzABA0yiexxCn2EstD9s3J5nhI1D/xAdwjBbO/QKold64E
         2UT9OtZBbNMQ0xHaiZ/RW+H/gYb//09Mnh5ZKNHJwyFO0QQOm11Y9qmESpMiMGc20K3A
         mMVwvVtSpx3Nvjk9xOSMhZRdSlL3dN1RDLVLV+BJnPXkkUKCnkpz5lGv4w6fsaO43b8t
         G6cw==
X-Gm-Message-State: AJcUukd39Y09rfU5sNRtZOtjfLSatSHIyui1OiGkWdYr0bgNAfcopN1O
        PeN5UPunoyfsVH2ig5RkE8HRng==
X-Google-Smtp-Source: ALg8bN4VefpS7GhLIKrpPRc7rBsTYFXHvB+iZ/7utuDtiLnWgLRaGrHHLSfkjnliv/hrlBDLdFG5QQ==
X-Received: by 2002:a17:902:f20b:: with SMTP id gn11mr33999379plb.274.1548181103636;
        Tue, 22 Jan 2019 10:18:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id w185sm23627174pfb.135.2019.01.22.10.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 10:18:22 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:18:22 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
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
Subject: Re: [PATCH v2 8/9] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190122181822.GF261387@google.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <7f94696460848a6bcfe5aee5ffda7fe556240736.1547458732.git.amit.kucheria@linaro.org>
 <20190114220101.GN261387@google.com>
 <CAHLCerPtVeNo_bMn78RPz8Gz5zgw9jKyWYVRSMpLasbiiSPjnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHLCerPtVeNo_bMn78RPz8Gz5zgw9jKyWYVRSMpLasbiiSPjnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:40:45PM +0530, Amit Kucheria wrote:
> On Tue, Jan 15, 2019 at 3:31 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Mon, Jan 14, 2019 at 03:51:10PM +0530, Amit Kucheria wrote:
> > > Since all cpus in the big and little clusters, respectively, are in the
> > > same frequency domain, use all of them for mitigation in the
> > > cooling-map. We end up with two cooling devices - one each for the big
> > > and little clusters.
> > >
> > > At the lower trip points we restrict ourselves to throttling only a few
> > > OPPs. At higher trip temperatures, allow ourselves to be throttled to
> > > any extent.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 177 ++++++++++++++++++++++++---
> > >  1 file changed, 161 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index fb7da678b116..7973e88bdf94 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > >
> > > ...
> > >
> > > @@ -1719,18 +1728,35 @@
> > >                       thermal-sensors = <&tsens0 1>;
> > >
> > >                       trips {
> > > -                             cpu_alert0: trip0 {
> > > +                             cpu0_alert0: trip-point@0 {
> >
> > Thanks for adapting the trip point names and labels in anticipation of
> > further additions!
> >
> > Seems you aren't overly convinced about the 'target/threshold'
> > terminology used by some other arm64 platforms ;-)
> 
> target and threshold have an air of finality to them and doesn't lend
> itself to having a few trip points on the way to the critical trip,
> IMO.
> 
> Let me know if you feel otherwise.

I can see your point, and it's also true that target/threshold seem to
imply the use of power_allocator, which may not always be the case.

> > >                                       temperature = <95000>;
> > >                                       hysteresis = <2000>;
> > >                                       type = "passive";
> > >                               };
> >
> > I realized that we still have the potential problem of a name change
> > in the trip point node name if a 'threshold' node for IPA is added,
> > since this node will have a lower temperature than 95°. If this is
> > something to be concerned about it might be worth to add that extra
> > trip point already to avoid headaches or funky trip point enumeration,
> > even if we know that the value might not be the final one.
> 
> I will squash both the DT changes in to a single change introducing 2
> passive trips and 1 critical trip to avoid the churn.

Sounds good, thanks!

> See if you like it better.

I didn't really dislike it, was just wondering if renaming nodes could
break existing users. I imagine it's not a huge problem after all,
since users with an older kernel version won't see the DT change and
probably should use the phandle anyway.

> > (I'm aware that we are also changing the node names and labels right
> > now, it seems less problematic at this point since the SDM845 thermal
> > zones are a fairly recent addition)
> >
> > > -                             cpu_crit0: trip1 {
> > > +                             cpu0_crit: cpu_crit@0 {
> >
> > nit: does the @0 add any value here? IIUC there can be only one
> > critical trip point, hence there will never be a cpu_crit@1 or
> > higher.
> 
> Agreed. Will remove.
> 
> > >                                       temperature = <110000>;
> > >                                       hysteresis = <1000>;
> > >                                       type = "critical";
> > >                               };
> > >                       };
> > > +
> > > +                     cooling-maps {
> > > +                             map0 {
> > > +                                     trip = <&cpu0_alert0>;
> > > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> > > +                                                      <&CPU1 THERMAL_NO_LIMIT 4>,
> > > +                                                      <&CPU2 THERMAL_NO_LIMIT 4>,
> > > +                                                      <&CPU3 THERMAL_NO_LIMIT 4>;
> > > +                             };
> >
> > Out of curiosity: how did you determing the max cooling state of 4?
> 
> Just some basic testing by pinning a dhrystone benchmark to each of
> the cores along with some stress-ng threads. Lopping off the top 4
> OPPs seemed to mitigate anything I could throw at the board.

Thanks for sharing your approach!

> I'm unable to do the "device in a closed car on a hot summer day" type
> of tests on the dev board. Nevertheless, I've changed the patch now to
> only remove the boost frequency at 75 degrees and then full throttling
> at 95 degrees.
> 
> I'd appreciate more "real world" testing to validate these.

Sure, we'll run some tests with the new configuration on our site.

Thanks

Matthias
