Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D71C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84B22084A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WH3nhTdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84B22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeH2KoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:44:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55460 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2KoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:44:02 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so6144249itj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 23:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDtuyrNjsAUOSm7C0dJxw58/ulD9T0Me5w8fLKOpAX4=;
        b=WH3nhTdqEmyxnJnWvP1iuAyPBATZi8TBTaeLAt/M5v8GeN8JT7s+N0okORl565eAi8
         iWOKsrte3mvtpEYfV4wUQX1YzuznSdlDwPFPHyOJe+o2mVpW69Zz9sRtGPogDzlWWrI2
         7IVaDJNz+q61yufhGiL9wy9eiK7nRCL1azRuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDtuyrNjsAUOSm7C0dJxw58/ulD9T0Me5w8fLKOpAX4=;
        b=JDHEgqYqbhXj5ieGSqTiytwSSYEY5qRNLPRIirN6t/BU/ZufPHch0cHzx4b8B6AFdn
         Wp7nel1h84TjQXDnwfwadRuzUfR8Dp2D51cBUZIq5+65mGCpX7JA957LKqwxNZ0EcmFQ
         28iuA3OiHm4VJaqxhQRRWDmtl2QPb/DUi9DZsQe6BJ3dAKAwpdAt1llY1tEmdEBvpzn4
         gLwUH3SlexKoMMJYOY3h1yshDq30XfwY/VbsnuEzDe8O/xDcaK3PGc1KsGJB6VirusPo
         PRP/hDLJR/l0attggWnQIW2FfWxD72MznewwAwgM01DxobxcxF/5O8FCo0Wxyblzivj0
         WfJQ==
X-Gm-Message-State: APzg51BeXQBmPxxHnx8Vuq+S2VT98LvC4JTLlvejQGQpbQtA3gF10nRS
        pqLyY/C5A3OcmXfaGouG4z2IxJjUuSEKO0HWeSWQxQ==
X-Google-Smtp-Source: ANB0VdbwihQoE0AzovqoTWtw3T0ES9LVJzYsrlam8B6fmlqO+AHPxiO9fItUaTF06TVnGI/8dxMX6yjysk0lxHqq8is=
X-Received: by 2002:a24:e00e:: with SMTP id c14-v6mr4426146ith.108.1535525319931;
 Tue, 28 Aug 2018 23:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <1534869685-22221-1-git-send-email-vincent.guittot@linaro.org>
 <87ftz6ww1h.fsf@e105922-lin.cambridge.arm.com> <CAKfTPtBGJf3tPgUXwVGbQBxgCwuW4TKhLtyeXYp5SZZxmyXEsg@mail.gmail.com>
 <87k1oaa6ym.fsf@e105922-lin.cambridge.arm.com>
In-Reply-To: <87k1oaa6ym.fsf@e105922-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 29 Aug 2018 08:48:29 +0200
Message-ID: <CAKfTPtD5zxpjxHyT9h0RH2KcJTx4NkkMuBKpAfzRStOLqNRfVw@mail.gmail.com>
Subject: Re: [PATCH] dt-binding: arm/cpus.txt: fix dynamic-power-coefficient unit
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 at 16:42, Punit Agrawal <punit.agrawal@arm.com> wrote:
>
> Vincent Guittot <vincent.guittot@linaro.org> writes:
>
> > Hi Amit,
> >
> > On Wed, 22 Aug 2018 at 12:11, Punit Agrawal <punit.agrawal@arm.com> wrote:
> >>
> >> Hi Vincent,
> >>
> >> Thanks for the patch. One comment about the choice of units below.
> >>
> >> Vincent Guittot <vincent.guittot@linaro.org> writes:
> >>
> >> > The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
> >> > its usage in the code assumes that unit is mW/GHz/V^2
> >>
> >> Instead of choosing GHz as the base, I'd prefer to use uW/MHz/V^2. It'll
> >> avoid introducing fractional GHz value for frequency calculations.
> >
> > I don't understand your concern about fractional Ghz value for
> > frequency calculation ?
> > I mean, why it's a problem for frequency with Ghz vs Mhz but not a
> > problem for voltage with V vs mV ?
> > Don't we have the same "problem" in both case ?
>
> You're right. It's the same problem in both cases.
>
> >>
> >> > In drivers/thermal/cpu_cooling.c, the code is :
> >> >
> >> > power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> >> > do_div(power, 1000000000);
> >> >
> >> > which can be summarized as :
> >> > power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
> >>
> >> Which would then translate to -
> >>
> >> power (mW) = power (uW) / 1000 = capacitance * freq_mhz * (voltage_mv/1000)^2
> >
> > Not sure that the equation above is correct. If we consider uW/MHz/V^2
> > for the unit, the equation becomes :
> > power (mW) = power (uW) / 1000 = capacitance * freq_mhz *
> > (voltage_mv/1000)^2 / 1000
>
> Yes, I missed the "/ 1000" at the end.
>
> > which can be rearranged as
> > power (mW) = power (uW) / 1000 = capacitance * freq_mhz/ 1000 *
> > (voltage_mv/1000)^2
> >
> > TBH, I don't really mind between  mW/GHz/V^2 or uW/MHz/V^2 as they are
> > the same at the end
> > but I don't catch your reasoning
>
> The problem I was thinking of doesn't hold as it's the same issue with
> voltage.
>
> One benefit to go with uW/MHz/V^2 might be the extra resolution that it
> provides. I'd prefer to go with uW/MHz/V^2 if there's no compelling
> reason to go with anything else.

Ok, I'm going to update the patch with uW/MHz/V^2

Thanks
>
>
> [...]
>
> >> >
> >> > Furthermore, if we test basic values like :
> >> > voltage_mv = 1000mV = 1V
> >> > freq_mhz = 1000Mhz = 1Ghz
> >> >
> >> > The minimum possible power, when dynamic-power-coefficient equals 1, will
> >> > be :
> >> > min power = 1 * 1000  * (1000000)^2 = 10^15 mW
> >> > which is not realistic
> >> >
> >> > With the unit used by the code, the min power is
> >> > min power =  1 * 1 * 1^2 = 1mW which is far more realistic
> >> >
> >> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> > ---
> >> >  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> >> > index 29e1dc5..0148d7d 100644
> >> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> >> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> >> > @@ -274,7 +274,7 @@ described below.
> >> >               Usage: optional
> >> >               Value type: <prop-encoded-array>
> >> >               Definition: A u32 value that represents the running time dynamic
> >> > -                         power coefficient in units of mW/MHz/uV^2. The
> >> > +                         power coefficient in units of mW/GHz/V^2. The
> >> >                           coefficient can either be calculated from power
> >> >                           measurements or derived by analysis.
> >> >
> >> > @@ -285,7 +285,7 @@ described below.
> >> >
> >> >                           Pdyn = dynamic-power-coefficient * V^2 * f
> >> >
> >> > -                         where voltage is in uV, frequency is in MHz.
> >> > +                         where voltage is in V, frequency is in GHz.
> >> >
> >> >  Example 1 (dual-cluster big.LITTLE system 32-bit):
