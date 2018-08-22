Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922D0C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFE02147C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTLMlQiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFE02147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeHVR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:58:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46551 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbeHVR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:58:00 -0400
Received: by mail-io0-f196.google.com with SMTP id y12-v6so1560296ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xP+JO/TeSw6TeqtvXZDE98vzn2kuvQC7gPS35TWtmao=;
        b=kTLMlQiPpKYwB5uD8u5TqaDAMoMdcYckhpNCZG6UCxpasSV7iFIyUq/cm5TvK4ZZSz
         +orYYnGxGdQlYIZMUqcxcmuuDu1lFtCvxAuuw/oCSs+5UusCEsLBY7cTt0hCF/ar+Gg6
         H7V6D+zCwhKXlWHiQzs5EievfeDSRk6s3MPRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xP+JO/TeSw6TeqtvXZDE98vzn2kuvQC7gPS35TWtmao=;
        b=RLXPi+5orwE5FGG4wm3Ls5su+48Rny7qW6RtXTWTivjLy18mMJnXcMujJfLZshRb0I
         ZRcKtoj9hJrxLWFQOdOY2DT+xa/wiDO5GM7ln0Caws9gpxAV5SS9IkHYHIlqqZ2XfTto
         nSx9zpApgMucZPXHLw8PDRpjzsDrLLF2g5rOygSuqLmLz2vjl5Ouit7JZsBZA8fwsojl
         mYEHRSow643exLM3oIL9y6dVL/VKw37IywVn2l/JJoSeQfW9YsMJ/FYyJoDutn36WUnp
         fjmDU+0o6wZ6EjWjMYUAISleP1vMtJLG/kZm8p+Ro6e8mZ/u5z07EgFw7YrmeRPxoZOw
         CtkQ==
X-Gm-Message-State: AOUpUlGWyAenGo9Y7jNqNbeZ4hHpnb0pteSTQQw9gFPpatj/GFCD2mlj
        eD9zPNag1i/PU5eqau6YhX9MbUrb5Qc/pOQlp85wpA==
X-Google-Smtp-Source: AA+uWPyECcZTo9Blsd/kL8sWRQYhxk9d/D3vMQOweQpECvPdD0ZXS6iktzOICoKi6dw5lgvpP8hgMOZ34gg1M+9wNfo=
X-Received: by 2002:a5e:8a4b:: with SMTP id o11-v6mr32646839iom.183.1534948370476;
 Wed, 22 Aug 2018 07:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <1534869685-22221-1-git-send-email-vincent.guittot@linaro.org> <87ftz6ww1h.fsf@e105922-lin.cambridge.arm.com>
In-Reply-To: <87ftz6ww1h.fsf@e105922-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Aug 2018 16:32:39 +0200
Message-ID: <CAKfTPtBGJf3tPgUXwVGbQBxgCwuW4TKhLtyeXYp5SZZxmyXEsg@mail.gmail.com>
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

Hi Amit,

On Wed, 22 Aug 2018 at 12:11, Punit Agrawal <punit.agrawal@arm.com> wrote:
>
> Hi Vincent,
>
> Thanks for the patch. One comment about the choice of units below.
>
> Vincent Guittot <vincent.guittot@linaro.org> writes:
>
> > The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
> > its usage in the code assumes that unit is mW/GHz/V^2
>
> Instead of choosing GHz as the base, I'd prefer to use uW/MHz/V^2. It'll
> avoid introducing fractional GHz value for frequency calculations.

I don't understand your concern about fractional Ghz value for
frequency calculation ?
I mean, why it's a problem for frequency with Ghz vs Mhz but not a
problem for voltage with V vs mV ?
Don't we have the same "problem" in both case ?

>
> > In drivers/thermal/cpu_cooling.c, the code is :
> >
> > power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> > do_div(power, 1000000000);
> >
> > which can be summarized as :
> > power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
>
> Which would then translate to -
>
> power (mW) = power (uW) / 1000 = capacitance * freq_mhz * (voltage_mv/1000)^2

Not sure that the equation above is correct. If we consider uW/MHz/V^2
for the unit, the equation becomes :
power (mW) = power (uW) / 1000 = capacitance * freq_mhz *
(voltage_mv/1000)^2 / 1000
which can be rearranged as
power (mW) = power (uW) / 1000 = capacitance * freq_mhz/ 1000 *
(voltage_mv/1000)^2

TBH, I don't really mind between  mW/GHz/V^2 or uW/MHz/V^2 as they are
the same at the end
but I don't catch your reasoning

Regards,
Vincent

>
> Thanks,
> Punit
>
> >
> > Furthermore, if we test basic values like :
> > voltage_mv = 1000mV = 1V
> > freq_mhz = 1000Mhz = 1Ghz
> >
> > The minimum possible power, when dynamic-power-coefficient equals 1, will
> > be :
> > min power = 1 * 1000  * (1000000)^2 = 10^15 mW
> > which is not realistic
> >
> > With the unit used by the code, the min power is
> > min power =  1 * 1 * 1^2 = 1mW which is far more realistic
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> > index 29e1dc5..0148d7d 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -274,7 +274,7 @@ described below.
> >               Usage: optional
> >               Value type: <prop-encoded-array>
> >               Definition: A u32 value that represents the running time dynamic
> > -                         power coefficient in units of mW/MHz/uV^2. The
> > +                         power coefficient in units of mW/GHz/V^2. The
> >                           coefficient can either be calculated from power
> >                           measurements or derived by analysis.
> >
> > @@ -285,7 +285,7 @@ described below.
> >
> >                           Pdyn = dynamic-power-coefficient * V^2 * f
> >
> > -                         where voltage is in uV, frequency is in MHz.
> > +                         where voltage is in V, frequency is in GHz.
> >
> >  Example 1 (dual-cluster big.LITTLE system 32-bit):
