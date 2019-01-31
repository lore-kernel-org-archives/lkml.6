Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456FBC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144D120989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfAaD2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:28:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45471 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaD2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:28:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so1367905edb.12;
        Wed, 30 Jan 2019 19:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15XSS+f8Da6LSGwP1uW4xYq3+UFXhrjBBfi+sQNl2lY=;
        b=f7pFVgJQLen1NRSM8huICsbneheLXX7ZpXGm6HhR0LUtNgntA4TazbvU7XrEMOsjIk
         RR/UZVEkBHeHrecCkxL4fEd+3fBji66WPqGxBFkPtqVym2rswZneoohItzV5/J7Eg2i6
         eyfH0i/2Bc6BU5OCodFAnVosoDcJDz/1r1gFlcR/Qjm/OGOErug8fbhVkT4QGljtXMb9
         H7MHIgqAVEjovxycOz138wJZXpNFtGsYYZYFBfwB4PNowiKp9qj06mRAa6WhSK1zqt42
         ha+PvToehk4BtkD7OSWjuHNfoa6FjohmQ1S0jln/ZBL/6HCvn5o43wVRQT5vMWNTIk3k
         d3Ow==
X-Gm-Message-State: AJcUukcDPkbsWrbvPc7ESTap/jiRqQKfekBmYewQWOPdLAjGxeAVgmHv
        N0CSHRoHaruvCvoLTyiylgXvIwitbXI=
X-Google-Smtp-Source: ALg8bN6iWpa6PWtbtlxcbGBOb23i0/fAszRk7MzbVjuD0uLZR4rXolUY+rxqWtScq0JfS4+AVYDqZg==
X-Received: by 2002:a50:b5c6:: with SMTP id a64mr32917216ede.112.1548905314638;
        Wed, 30 Jan 2019 19:28:34 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id p30sm940735eda.68.2019.01.30.19.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 19:28:34 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id g67so943602wmd.2;
        Wed, 30 Jan 2019 19:28:33 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr27581378wme.111.1548905313480;
 Wed, 30 Jan 2019 19:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20190130084203.25053-1-wens@csie.org> <20190130084203.25053-11-wens@csie.org>
 <20190130092927.x65ihy3je5n6324w@flea> <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
In-Reply-To: <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 31 Jan 2019 11:28:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v670VszWfTNK9vtoBFWAuHVVHXmwrA84YfBFLLM5XX_6xg@mail.gmail.com>
Message-ID: <CAGb2v670VszWfTNK9vtoBFWAuHVVHXmwrA84YfBFLLM5XX_6xg@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm64: dts: allwinner: h5: Add CPU Operating
 Performance Points table
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andre Przywara <andre.przywara@arm.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 5:41 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Jan 30, 2019 at 5:29 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Wed, Jan 30, 2019 at 04:42:03PM +0800, Chen-Yu Tsai wrote:
> > >                       enable-method = "psci";
> > >                       clocks = <&ccu CLK_CPUX>;
> > >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > > +                     operating-points-v2 = <&cpu_opp_table>;
> > > +                     #cooling-cells = <2>;
> > > +             };
> > > +     };
> > > +
> > > +     cpu_opp_table: opp_table {
> > > +             compatible = "operating-points-v2";
> > > +             opp-shared;
> > > +
> > > +             opp@408000000 {
> > > +                     opp-hz = /bits/ 64 <408000000>;
> > > +                     opp-microvolt = <1000000 1000000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@648000000 {
> > > +                     opp-hz = /bits/ 64 <648000000>;
> > > +                     opp-microvolt = <1040000 1040000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@816000000 {
> > > +                     opp-hz = /bits/ 64 <816000000>;
> > > +                     opp-microvolt = <1080000 1080000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@912000000 {
> > > +                     opp-hz = /bits/ 64 <912000000>;
> > > +                     opp-microvolt = <1120000 1120000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@960000000 {
> > > +                     opp-hz = /bits/ 64 <960000000>;
> > > +                     opp-microvolt = <1160000 1160000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1008000000 {
> > > +                     opp-hz = /bits/ 64 <1008000000>;
> > > +                     opp-microvolt = <1200000 1200000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1056000000 {
> > > +                     opp-hz = /bits/ 64 <1056000000>;
> > > +                     opp-microvolt = <1240000 1240000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1104000000 {
> > > +                     opp-hz = /bits/ 64 <1104000000>;
> > > +                     opp-microvolt = <1260000 1260000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1152000000 {
> > > +                     opp-hz = /bits/ 64 <1152000000>;
> > > +                     opp-microvolt = <1300000 1300000 1310000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> >
> > What is the frequency and voltage that U-Boot sets up?
>
> 1008 MHz, and whatever voltage the board design defaults to (typically
> the higher setting).

FYI I got this wrong. U-boot's default is 816 MHz. However it seems even
this is misleading, as cpufreq in Linux reports:

    cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 792000 KHz
    cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
to: 816000 KHz

So there seems tp be an off-by-1 error in some multiplier calculation.

>
> > We've had the issue with the A33 that it's started at 1008MHz, with
> > the matching voltage, and ramping up the frequency to 1.2GHz on boards
> > without PMIC support would increase the frequency but not the voltage,
> > resulting in a brownout.
>
> Which is why I added the regulator to all boards before this patch. At
> least for Linux, once the regulator supply is described in the device
> tree, if the driver is missing, regulator_get_* and thus cpufreq should
> fail with -EPROBE_DEFER.

I believe despite the above, this still stands. So we should be OK.
