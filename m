Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A7C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B2A20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfA3Jld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:41:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39081 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfA3Jld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:41:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so18445123edt.6;
        Wed, 30 Jan 2019 01:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buxflIHyotlTgXFeXzNxI+t8izXs+EpCHmUVPB6PVhM=;
        b=r0xVvwbRcEh6QNxv+k9uTvNNaIuuapunv/B1pmYU9WTD4uOp9eUrvZSZXZqfX491Yd
         2Zh5jCCjEqNG2NW68z0g/UQaH4CKtjqwaOD7aLTyrTLWKBiVkLruJ0caePkzMc8DQMbJ
         WfK+ZElJDUISxTD5yTFs8di55oXCLa56b5uGa9Fg9FVpqHCRPkqu7qhC1JEa/+s5HkkR
         a9ZwuS35oJDLGjU7ni6q/0/u+gqZ74KNKcpKNKhUQITgkJAVJzTGe8VurKGNzL4JDid/
         n1SGybC8B/cpq/LJHlHktdPYfOHWRmLORlMffCifG32rlDoEpiwwOAdmIKq1fZ1H4AJk
         hmUg==
X-Gm-Message-State: AJcUukczdfAGuE33gSHKVxFMQWxvC9Xyjb2qyumMN81Qm9b8zwURdrlO
        0mhqRfVf0uXYte0hIANEFvDOSz54k88=
X-Google-Smtp-Source: ALg8bN7Iwa7NfEdv4PYRSxGpOB2a0WG25y3tPmSFz2sXxDg2grMgWCPT3WLOwEj2NDM2SQcuMm28Ag==
X-Received: by 2002:a17:906:b3ce:: with SMTP id cg14mr22921696ejb.43.1548841290412;
        Wed, 30 Jan 2019 01:41:30 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id r1sm379454eds.1.2019.01.30.01.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:41:29 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id q18so25224435wrx.9;
        Wed, 30 Jan 2019 01:41:29 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr30349882wrv.188.1548841289046;
 Wed, 30 Jan 2019 01:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20190130084203.25053-1-wens@csie.org> <20190130084203.25053-11-wens@csie.org>
 <20190130092927.x65ihy3je5n6324w@flea>
In-Reply-To: <20190130092927.x65ihy3je5n6324w@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 30 Jan 2019 17:41:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
Message-ID: <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
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

On Wed, Jan 30, 2019 at 5:29 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Jan 30, 2019 at 04:42:03PM +0800, Chen-Yu Tsai wrote:
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +     };
> > +
> > +     cpu_opp_table: opp_table {
> > +             compatible = "operating-points-v2";
> > +             opp-shared;
> > +
> > +             opp@408000000 {
> > +                     opp-hz = /bits/ 64 <408000000>;
> > +                     opp-microvolt = <1000000 1000000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@648000000 {
> > +                     opp-hz = /bits/ 64 <648000000>;
> > +                     opp-microvolt = <1040000 1040000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@816000000 {
> > +                     opp-hz = /bits/ 64 <816000000>;
> > +                     opp-microvolt = <1080000 1080000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@912000000 {
> > +                     opp-hz = /bits/ 64 <912000000>;
> > +                     opp-microvolt = <1120000 1120000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@960000000 {
> > +                     opp-hz = /bits/ 64 <960000000>;
> > +                     opp-microvolt = <1160000 1160000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1008000000 {
> > +                     opp-hz = /bits/ 64 <1008000000>;
> > +                     opp-microvolt = <1200000 1200000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1056000000 {
> > +                     opp-hz = /bits/ 64 <1056000000>;
> > +                     opp-microvolt = <1240000 1240000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1104000000 {
> > +                     opp-hz = /bits/ 64 <1104000000>;
> > +                     opp-microvolt = <1260000 1260000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1152000000 {
> > +                     opp-hz = /bits/ 64 <1152000000>;
> > +                     opp-microvolt = <1300000 1300000 1310000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
>
> What is the frequency and voltage that U-Boot sets up?

1008 MHz, and whatever voltage the board design defaults to (typically
the higher setting).

> We've had the issue with the A33 that it's started at 1008MHz, with
> the matching voltage, and ramping up the frequency to 1.2GHz on boards
> without PMIC support would increase the frequency but not the voltage,
> resulting in a brownout.

Which is why I added the regulator to all boards before this patch. At
least for Linux, once the regulator supply is described in the device
tree, if the driver is missing, regulator_get_* and thus cpufreq should
fail with -EPROBE_DEFER.

Or we could drop the extra OPPs.


ChenYu
