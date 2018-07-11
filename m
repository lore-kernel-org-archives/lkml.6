Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C707220877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3YWy/kV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C707220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeGKIa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:30:28 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33185 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeGKIa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:30:28 -0400
Received: by mail-it0-f68.google.com with SMTP id y124-v6so17149630itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ik17im91F5KmQ9BwhQwAFv8p9cnR5TafQO88otY/fJ0=;
        b=Y3YWy/kVgWNLBRMtigMcnp7oqncmJduHyhkfxk8Wn8aSoNwsBJY1d1h4CfaLZRAb19
         08uY6G5dKsVFUXRHzaIYX2bhJV1AaXf8xBY4xk08PKkCyhWGT+LzU6ubjwjuXnZa7V9q
         J9jTtYw2M9wsZ88UetObjRrrxkTooKgT+qVpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ik17im91F5KmQ9BwhQwAFv8p9cnR5TafQO88otY/fJ0=;
        b=r2gKIS3mrCVx/O2suehlo8IsWzCUiEFffa0hD8zjRNIgCjMcMI9HQZMei/TsBR4gYW
         yViPgvRFopTB4YDZmti14Lavi6b7d2UBIkC281yCa8xChcXgoWzV1K4YdZ/1KdPNGXHH
         h9uvP1dwd4S8DAh2l1pMP35kCkXKwlGYlprMD1b9JgufTT7+uZSKpQ15mwScOOp9wQga
         fl5r6Y0nLCgaf2FV7+QWLErRqPNLUixIv9gwFzzBIB/UsV8qfQu6FiUqy2AHiAdP4mY+
         rl6Ow14T3VPOkh+4cEmQA7ZrmkZHWK1Gcl30lkzbg95ZFwBdARRDrCuk01GcemCJ4FXz
         R+1w==
X-Gm-Message-State: APt69E313jmR0aCy1ztvwRqVF83tsM0hNAo56c9TPNv5EGESwKsjEMXM
        bJ84Zi2JJvxXWjHmk+JJEuI1OVoJFoQqQAg1znya6A==
X-Google-Smtp-Source: AAOMgpc7KaT5yegsGJdq72BfuZH4nIgj04qvTM0Z1DVbII3blSlMazc6MTt+4/MhN3j+7m+zYiq9Vyt05jDI1vNi8g8=
X-Received: by 2002:a24:d909:: with SMTP id p9-v6mr20978764itg.89.1531297640140;
 Wed, 11 Jul 2018 01:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org> <20180708140157.GA28878@leoy-ThinkPad-X240s>
In-Reply-To: <20180708140157.GA28878@leoy-ThinkPad-X240s>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 11 Jul 2018 10:27:09 +0200
Message-ID: <CAKfTPtBMWCT+sy0WQ7cH8Z-On+NH5NO7u3v7eLkOp0pZ+2gKGg@mail.gmail.com>
Subject: Re: [PATCH] arm64: hikey960: update idle-states
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Sun, 8 Jul 2018 at 16:02, <leo.yan@linaro.org> wrote:
>
> Hi Vincent,
>
> On Fri, Jul 06, 2018 at 08:57:26AM +0200, Vincent Guittot wrote:
> > Update entry/exit latency and residency time of hikey960 to use more
> > realistic figures based on unitary tests done on the platform.
> >
> > The complete results (in us) :
> >                   big cluster
> >                   cluster  CPU
> > max entry latency     800  400
> > max exit latency     2900  550
> > residency  903Mhz    5000 1500
> > residency 2363Mhz       0 1500
> >
> >                   little cluster
> >                   cluster  CPU
> > max entry latency     500  400
> > max exit latency     1600  650
> > residency  533Mhz    8000 4500
> > residency 1844Mhz       0 1500
> >
> > We can see that the residency time depends of the running OPP which is not
> > handled for now. Then we also have to take into account the constraint of
> > a residency time shorter than the tick to get full advantage of idle loop
> > reordering(tick is stopped if idle duration is higher than tick period).
> > Finally the selected residency value are :
> >                  big cluster
> >                   cluster  CPU
> > residency            3700 1500
> >
> >                   little cluster
> >                   cluster  CPU
> > residency            3500 1500
> >
> > A simple test with a task waking up every 11,111ms shows improvement:
>
> Should s/11,111ms/11.111ms ?

As Daniel explained, I have used the french notation. Will use the
other one in the next version

>
> > - 5% a lowest OPP
> > - 22% at highest OPP
> >
> > The period has been chosen:
> > - to be shorter than old cluster residency time and longer than new
> > residency time od cluster off C-state
>
> Should s/od/of/ ?

Yes

>
> Except these two minor typos, the patch is very good improvement.
>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

I'm going to send a new version with fix in the commit

Thanks
>
> > - to prevent any sync with tick (4ms) when running tests that can add
> > some variances between tests
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 45 ++++++++++++++++++-------------
> >  1 file changed, 27 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > index 421d454..890d23e 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > @@ -61,7 +61,7 @@
> >                       reg = <0x0 0x0>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&A53_L2>;
> > -                     cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
> > +                     cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> >                       capacity-dmips-mhz = <592>;
> >                       clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
> >                       operating-points-v2 = <&cluster0_opp>;
> > @@ -75,7 +75,7 @@
> >                       reg = <0x0 0x1>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&A53_L2>;
> > -                     cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
> > +                     cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> >                       capacity-dmips-mhz = <592>;
> >                       clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
> >                       operating-points-v2 = <&cluster0_opp>;
> > @@ -87,7 +87,7 @@
> >                       reg = <0x0 0x2>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&A53_L2>;
> > -                     cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
> > +                     cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> >                       capacity-dmips-mhz = <592>;
> >                       clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
> >                       operating-points-v2 = <&cluster0_opp>;
> > @@ -99,7 +99,7 @@
> >                       reg = <0x0 0x3>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&A53_L2>;
> > -                     cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
> > +                     cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> >                       capacity-dmips-mhz = <592>;
> >                       clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
> >                       operating-points-v2 = <&cluster0_opp>;
> > @@ -111,7 +111,7 @@
> >                       reg = <0x0 0x100>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&A73_L2>;
> > -                     cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
> > +                     cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
> >                       capacity-dmips-mhz = <1024>;
> >                       clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
> >                       operating-points-v2 = <&cluster1_opp>;
> > @@ -125,7 +125,7 @@
> >                       reg = <0x0 0x101>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&A73_L2>;
> > -                     cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
> > +                     cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
> >                       capacity-dmips-mhz = <1024>;
> >                       clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
> >                       operating-points-v2 = <&cluster1_opp>;
> > @@ -137,7 +137,7 @@
> >                       reg = <0x0 0x102>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&A73_L2>;
> > -                     cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
> > +                     cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
> >                       capacity-dmips-mhz = <1024>;
> >                       clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
> >                       operating-points-v2 = <&cluster1_opp>;
> > @@ -149,7 +149,7 @@
> >                       reg = <0x0 0x103>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&A73_L2>;
> > -                     cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
> > +                     cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
> >                       capacity-dmips-mhz = <1024>;
> >                       clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
> >                       operating-points-v2 = <&cluster1_opp>;
> > @@ -158,31 +158,40 @@
> >               idle-states {
> >                       entry-method = "psci";
> >
> > -                     CPU_SLEEP: cpu-sleep {
> > +                     CPU_SLEEP_0: cpu-sleep-0 {
> >                               compatible = "arm,idle-state";
> >                               local-timer-stop;
> >                               arm,psci-suspend-param = <0x0010000>;
> > -                             entry-latency-us = <40>;
> > -                             exit-latency-us = <70>;
> > -                             min-residency-us = <3000>;
> > +                             entry-latency-us = <400>;
> > +                             exit-latency-us = <650>;
> > +                             min-residency-us = <1500>;
> >                       };
> > -
> >                       CLUSTER_SLEEP_0: cluster-sleep-0 {
> >                               compatible = "arm,idle-state";
> >                               local-timer-stop;
> >                               arm,psci-suspend-param = <0x1010000>;
> >                               entry-latency-us = <500>;
> > -                             exit-latency-us = <5000>;
> > -                             min-residency-us = <20000>;
> > +                             exit-latency-us = <1600>;
> > +                             min-residency-us = <3500>;
> > +                     };
> > +
> > +
> > +                     CPU_SLEEP_1: cpu-sleep-1 {
> > +                             compatible = "arm,idle-state";
> > +                             local-timer-stop;
> > +                             arm,psci-suspend-param = <0x0010000>;
> > +                             entry-latency-us = <400>;
> > +                             exit-latency-us = <550>;
> > +                             min-residency-us = <1500>;
> >                       };
> >
> >                       CLUSTER_SLEEP_1: cluster-sleep-1 {
> >                               compatible = "arm,idle-state";
> >                               local-timer-stop;
> >                               arm,psci-suspend-param = <0x1010000>;
> > -                             entry-latency-us = <1000>;
> > -                             exit-latency-us = <5000>;
> > -                             min-residency-us = <20000>;
> > +                             entry-latency-us = <800>;
> > +                             exit-latency-us = <2900>;
> > +                             min-residency-us = <3500>;
> >                       };
> >               };
> >
> > --
> > 2.7.4
> >
