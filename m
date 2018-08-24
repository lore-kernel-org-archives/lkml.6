Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FA2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5132098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcU16ezP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5132098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeHXP6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:58:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50576 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeHXP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:58:48 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so1843368ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 05:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=niQE6jyGBbRr8yzQ4viQxVuBxrs5KmE4XPlcPkT/GLA=;
        b=OcU16ezP/RJz23SO5Ter7xmVJLmt8kUwb1TraI/LHHDI5OFDo+cfC1fLl95d/C4VZx
         nTaVgvRSLBJkeaCit0+HzYq+hvYn2twn5raZh+00znI4N6mw/9TBHCeJMOmElKEDNQTr
         2s152LEMRHqkOF+GLBuKFn7JzSJAWQXiIQPeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=niQE6jyGBbRr8yzQ4viQxVuBxrs5KmE4XPlcPkT/GLA=;
        b=WN12NUvsxmwXkN5S1p/WS3tPc/gQNjKeykcntG7lW+v8WOyRvVIoJirpypgo79if7p
         l7dCicoU57FyhM+rnydF59aWSPFbkfEXbAej/iZCBE8yPwaqoEsnfWh4+t3tW1e6Dbyl
         oKnjwtXKqHvu1965PN/G5zwAtDb74osRwWYoSc7QEZU4wLg/nPGgRuWh716d8b7FZm+j
         6uFLPcyL7kpY1Lmak3K4gwhDvY8mk5CqwEsP5UzXomM2ZcW8zwACOxFEESqMLQOEIWzS
         vsKCXc7sQD0R1ujT+tR0xfkce790YSWJi/CA+ieEM5NfxfCEr33llfLSj4uUzvL4q/qN
         2Tpw==
X-Gm-Message-State: APzg51BBPWFbn7BbM7ANL9gL/+YZ2W69sJEBqFYWh5VcHuV9uvyiYAXa
        Q3kzE+2VH7mjjaijo82WmNcglUXaCsmir7zzODKWpA==
X-Google-Smtp-Source: ANB0VdbgrmNEeZ4lIwAoeffxcH8cUm5sowzryLxWt5q3GiGGiVygIkp0e6mIqng+XhvoyKiA9q0DZS8QF8J/oYQkiKw=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr1034014jad.107.1535113460983;
 Fri, 24 Aug 2018 05:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 05:24:20
 -0700 (PDT)
In-Reply-To: <20180815104449.GA29108@red-moon>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan> <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan> <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com> <20180808180248.GC27850@codeaurora.org>
 <20180809102504.GB13428@e107981-ln.cambridge.arm.com> <20180810201815.GE5081@codeaurora.org>
 <20180815104449.GA29108@red-moon>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Aug 2018 14:24:20 +0200
Message-ID: <CAPDyKFr6vx+rHj0kP5e_7_NzK413df7J72QPoH7eDbK5386D-w@mail.gmail.com>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Lina Iyer <ilina@codeaurora.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo, Sudeep, Mark

On 15 August 2018 at 12:44, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Fri, Aug 10, 2018 at 02:18:15PM -0600, Lina Iyer wrote:
>
> [...]
>
>> >>But, the OSI feature is critical for QCOM mobile platforms. The
>> >>last man activities during cpuidle save quite a lot of power.
>> >
>> >What I expressed above was that, in PSCI based systems (OSI or PC
>> >alike), it is up to firmware/hardware to detect "the last man" not
>> >the kernel.
>> >
>> >I need to understand what you mean by "last man activities" to
>> >provide feedback here.
>> >
>> When the last CPU goes down during deep sleep, the following would be
>> done
>> - Lower resource requirements for shared resources such as clocks,
>>  busses and regulators that were used by drivers in AP. These shared
>>  resources when not used by other processors in the SoC may be turned
>>  off and put in low power state by a remote processor. [1][2]
>> - Enable and setup wakeup capable interrupts on an always-on interrupt
>>  controller, so the GIC and the GPIO controllers may be put in low
>>  power state. [3][4]
>> - Write next known wakeup value to the timer, so the blocks that were
>>  powered off, may be brought back into operational before the wakeup.
>>  [4][5]
>>
>> These are commonly done during suspend, but to achieve a good power
>> efficiency, we have to do this when all the CPUs are just executing CPU
>> idle. Also, they cannot be done from the firmware (because the data
>> required for all this is part of Linux). OSI plays a crucial role in
>> determining when to do all this.
>
> No it does not. It is the power domain cpumasks that allow this code to
> make an educated guess on the last cpu running (the kernel), PSCI OSI is
> not crucial at all (it is crucial in QC platforms because that's the
> only mode supported but that's not a reason I accept as valid since it
> does not comply with the PSCI specifications).

We can keep argue on this back and forward, but it seems to lead
nowhere. As a matter of fact I am also surprised that this kind of
discussion pops up, again. I thought we had sorted this out,
especially since we have also met face to face, discussing this in
detail, several times by now. Well, well, let's try again. :-)

First, in regards to complying with the PSCI spec, to me, that sounds
like nonsense, sorry! Is the spec stating that the PSCI FW needs to
support all the idle states in PC mode, when the optional OSI mode
also is supported? To me, it looks like the QCOM PSCI FW supports PC
mode, but in that mode only a subset of the idle states can be
reached, so that should be fine, no?

Moving forward, I am wondering if a more detailed technical
description, comparing the benefits from OSI mode vs the benefits from
PC mode could help? Or is just a waste of everybody time, as you all
already know this? Anyway I am willing to try, just tell me and I
provide you with the best details I can give, about why OSI is better
suited for these kind of QCOM SoCs. I trust Lina to help to fill in,
if/when needed.

Why? Simply because I doubt we ever see the QCOM FW for the battery
driven embedded devices to support all idles states in the PC mode, so
doing a comparison on for example the 410c platform, just doesn't
seems to be possible, sorry!

I also have another, quite important, concern. That is, ARM decided to
put the OSI mode into the PSCI spec, I assume there were reasons for
it. Then, when the ARM community wants to implement support for OSI
mode, you are now requiring us to proof the justification of it in the
spec. To me, that is, nicely stated, weird. :-) But it also worries
me, ARM vendors observes the behavior.

That said, in the end we are discussing a quite limited amount of
lines of code to support PSCI OSI (some which may not even be
considered as OSI specific). It's ~200 lines of code, where most of
the code lives in a separate new c-file (psci_pm_domain.c).
Additionally, existing PC mode only platforms should still work as
before, without drawbacks.

Really, why are we arguing about this at all?

>
> As I mentioned in another thread[1] the generic part of this
> series may be applicable in a platform agnostic way to the
> CPUidle framework, whether that's beneficial it has to be proven
> and it is benchmark specific anyway.

I don't think this can be made fully platform agnostic. Or maybe you
are suggesting another helper layer above the new genpd
infrastructure?

Anyway, my point is, the genpd backend driver requires knowledge about
the FW and the last man standing algorithm, hence a platform agnostic
backend doesn't sound feasible to me.

>
> Lorenzo
>
> [1]: https://marc.info/?l=linux-pm&m=153382916513032&w=2

Kind regards
Uffe
