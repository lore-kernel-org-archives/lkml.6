Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB91C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D949720823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUE6cW53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfARL45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:56:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42658 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfARL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:56:57 -0500
Received: by mail-ua1-f67.google.com with SMTP id d21so4577256uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ONW9bfE6i1Oa5o6/qTPyn+92p86n1PcxECQuQGQfmQ=;
        b=aUE6cW53PrYI/10aWB4ZONz1hFTb/yhaoXDZaQRO1Pf4HZGwfGiUecZJammlKoUtNt
         593WN0tSeNVgXYe0/a8Cs7vMHcmKwWLF+MCpKOjfnA0Suh7w6L4j1jiM8UIC9xdteKfm
         e+Tjrfl7ZU4/PSY/VMowqgONnLiLHIJr4deHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ONW9bfE6i1Oa5o6/qTPyn+92p86n1PcxECQuQGQfmQ=;
        b=Um7amg7aGaxIC2dsDjzZw3478YZPy/xkU/E9+wqg307XWQzcT+sCwNNUhXIeRiBqtm
         ASS8KpHzrhOd1T6jO8TRU6p/CyyJDof//z7rY+i9LTrr03sIa/MHvEB6JFcGdeCOmRKD
         mpvA09kwg0Y32z2C1+bK838IysFz8BkS07puPKX8kTHelAsmm5KIlA+l9qhh/Zut+253
         3v9ikGHlMVlq3/mnPRT2YDLYX2itp6RS1oQf8ai+f1c1rJfXapUY/xIsfHtx3lEjYrGO
         IjaKJxCraHQjVUV/ASVtSpzfvLB3EbbwpH7OTtRwONsJfGF8PFXrl/u0SNawWMqtUy/6
         4YLA==
X-Gm-Message-State: AJcUukeuujEX0dt/S/8CkxPZHd8LD/AW94NvbNc0R4ZHLcMMMCwgcVqf
        QY7Mt3nx08ISXvj2AYyrKLq1yGsgxZH27hKh6xlPzw==
X-Google-Smtp-Source: ALg8bN4n8QkzAWlLGs/JxMN+adW915f5e6mZgKyx2R8DNhqginJfToHmOkKMm31QuCbC3Zmbxl5+kJZhkKDRxhogAiM=
X-Received: by 2002:ab0:526:: with SMTP id 35mr7486129uax.25.1547812615297;
 Fri, 18 Jan 2019 03:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20190103120612.GC23511@e107155-lin> <CAPDyKFp-JB85TZOs+oso0iidaAsm1A=UDrg=gv+QZ4VJ9gW=fA@mail.gmail.com>
 <20190117174410.GA8839@e107155-lin>
In-Reply-To: <20190117174410.GA8839@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Jan 2019 12:56:18 +0100
Message-ID: <CAPDyKFqhQnDJzp4UAwLBNRj2kQbxtJxfm4QOi7wPWzcwA=b2mg@mail.gmail.com>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 at 18:44, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jan 16, 2019 at 10:10:08AM +0100, Ulf Hansson wrote:
> > On Thu, 3 Jan 2019 at 13:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> > > > Over the years this series have been iterated and discussed at various Linux
> > > > conferences and LKML. In this new v10, a quite significant amount of changes
> > > > have been made to address comments from v8 and v9. A summary is available
> > > > below, although let's start with a brand new clarification of the motivation
> > > > behind this series.
> > >
> > > I would like to raise few points, not blockers as such but need to be
> > > discussed and resolved before proceeding further.
> > > 1. CPU Idle Retention states
> > >         - How will be deal with flattening (which brings back the DT bindings,
> > >           i.e. do we have all we need) ? Because today there are no users of
> > >           this binding yet. I know we all agreed and added after LPC2017 but
> > >           I am not convinced about flattening with only valid states.
> >
> > Not exactly sure I understand what you are concerned about here. When
> > it comes to users of the new DT binding, I am converting two new
> > platforms in this series to use of it.
> >
>
> Yes that's exactly my concern. So if someone updates DT(since it's part
> of the kernel still), but don't update the firmware(for complexity reasons)
> the end result on those platform is broken CPUIdle which is a regression/
> feature break and that's what I am objecting here.

There is not going to be a regression if that happens, you have got
that wrong. Let me clarify why.

For Hikey example, which is one of those platforms I convert into
using the new hierarchical DT bindings for the CPUs. It still uses the
existing PSCI FW, which is supporting PSCI PC mode only.

In this case, the PSCI FW driver, observes that there is no OSI mode
support in the FW, which triggers it to convert the hierarchically
described idle states into regular flattened cpuidle states. In this
way, the idle states can be manged by the cpuidle framework per CPU,
as they are currently.

So, why convert Hikey to the new DT bindings? It makes Linux aware of
the topology, thus it can monitor when the last CPU in the cluster
enters idle - and then take care of "last man activities".

>
> > Note, the flattened model is still a valid option to describe the CPU
> > idle states after these changes. Especially when there are no last man
> > standing activities to manage by Linux and no shared resource that
> > need to prevent cluster idle states, when it's active.
>
> Since OSI vs PC is discoverable, we shouldn't tie up with DT in anyway.

As stated above, we aren't. OSI and PC mode are orthogonal to the DT bindings.

>
> >
> > >         - Will domain governor ensure not to enter deeper idles states based
> > >           on its sub-domain states. E.g.: when CPUs are in retention, so
> > >           called container/cluster domain can enter retention or below and not
> > >           power off states.
> >
> > I have tried to point this out as a known limitation in genpd of the
> > current series, possibly I have failed to communicate that clearly.
> > Anyway, I fully agree that this needs to be addressed in a future
> > step.
> >
>
> Sorry, I might have missed to read. The point is if we are sacrificing
> few retention states with this new feature, I am sure PC would perform
> better that OSI on platforms which has retention states. Another
> reason for having comparison data or we should simply assume and state
> clearly OSI may perform bad on such system until the support is added.

I now understand that I misread your question. We are not scarifying
any idle states at all. Not in PC mode and not in OSI mode.

>
> > Note that, this isn't a specific limitation to how idle states are
> > selected for CPUs and CPU clusters by genpd, but is rather a
> > limitation to any hierarchical PM domain topology managed by genpd
> > that has multiple idle states.
> >
>
> Agreed, but with flattened mode we compile the list of valid states so
> the limitation is automatically eliminated.

What I was trying to point out above, was a limitation in genpd and
with its governors. If the PM domains have multiple idle states and
also have multiple sub-domain levels, the selection of idle state may
not be correct. However, that scenario doesn't exist for Hikey/410c.

Apologize for the noise, I simply thought it was this limitation you
referred to.

>
> > Do note, I already started hacking on this and intend to post patches
> > on top of this series, as these changes isn't needed for those two
> > ARM64 platforms I have deployed support for.
> >
>
> Good to know.
>
> > >         - Is the case of not calling cpu_pm_{enter,exit} handled now ?
> >
> > It is still called, so no changes in regards to that as apart of this series.
> >
>
> OK, so I assume for now we are not going to support retention states with OSI
> for now ?
>
> > When it comes to actually manage the "last man activities" as part of
> > selecting an idle state of the cluster, that is going to be addressed
> > on top as "optimizations".
> >
>
> OK
>
> > In principle we should not need to call cpu_pm_enter|exit() in the
> > idle path at all,
>
> Not sure if we can do that. We need to notify things like PMU, FP, GIC
> which have per cpu context too and not just "cluster" context.
>
> > but rather only cpu_cluster_pm_enter|exit() when a cluster idle state is
> > selected.
>
> We need to avoid relying on concept of "cluster" and just think of power
> domains and what's hanging on those domains.

I fully agree. I just wanted to use a well know term to avoid confusion.

> Sorry for naive question, but
> does genpd have concept of notifiers. I do understand that it's more
> bottom up approach where each entity in genpd saves the context and requests
> to enter a particular state. But with CPU devices like GIC/VFP/PMU, it
> needs to be more top down approach where CPU genpd has to enter a enter
> so it notifies the devices attached to it to save it's context.

No, genpd don't have on/off notifiers . There have been attempts to
add them, but those didn't make it.

Anyway, it's nice that you brings this up! The problem is well
described and the approach you suggest may very well be the right one.

In principle, I am also worried that the cpu_cluster_pm_enter|exist()
notifiers, doesn't scale. We may fire them when we shouldn't and
consumers may get them when they don't need them.

> Not ideal
> but that's current solution. Because with the new DT bindings, platforms
> can express if PMU/GIC is in per cpu domain or any pd in the hierarchy and
> we ideally need to honor that. But that's optimisation, just mentioning.

Overall, it's great that you mention this - and I just want to
confirm. I have this in mind when I am thinking of the next steps.

In regards to the next steps, hopefully we can move forward with
$subject series soon, so we really can start discussing the next steps
for real. I even think we need some of them to be implemented, before
we can see the full benefits made to latency and energy efficiency.

>
> > That should improve latency when
> > selecting an idle state for a CPU. However, to reach that point
> > additional changes are needed in various drivers, such as the gic
> > driver for example.
> >
>
> Agreed.
>
> > >
> > > 2. Now that we have SDM845 which may soon have platform co-ordinated idle
> > >    support in mainline, I *really* would like to see some power comparison
> > >    numbers(i.e. PC without cluster idle states). This has been the main theme
> > >    for most of the discussion on this topic for years and now we are close
> > >    to have some platform, we need to try.
> >
> > I have quite recently been talking to Qcom folkz about this as well,
> > but no commitments are made.
> >
>
> Indeed that's the worrying. IMO, this is requested since day#1 and not
> even simple interest is shown, but that's another topic.

Well, at least we keep talking about it and I am sure we will be able
to compare at some point.

Another option is simply to implement support for OSI mode in the
public ARM Trusted Firmware, any of us could do that. That would open
up for testing for a bunch of "open" platforms, like Hikey for
example.

>
> > Although I fully agree that some comparison would be great, it still
> > doesn't matter much, as we anyway need to support PSCI OSI mode in
> > Linux. Lorenzo have agreed to this as well.
> >
>
> OK, I am fine if others agree. Since we are sacrificing on few (retention)
> states that might disappear with OSI, I am still very much still interested
> as OSI might perform bad that PC especially in such cases.
>
> > >
> > > 3. Also, after adding such complexity, we really need a platform with an
> > >    option to build and upgrade firmware easily. This will help to prevent
> > >    this being not maintained for long without a platform to test, also
> > >    avoid adding lots of quirks to deal with broken firmware so that newer
> > >    platforms deal those issues in the firmware correctly.
> >
> > I don't see how this series change anything from what we already have
> > today with the PSCI FW. No matter of OSI or PC mode is used, there are
> > complexity involved.
> >
>
> I agree, but PC is already merged, mainitained and well tested regularly
> as it's default mode that must be supported and TF-A supports/maintains
> that. OSI is new and is on platform which may not have much commitments
> and can be thrown away and any bugs we find in future many need to worked
> around in kernel. That's what I meant as worrying.

I see what you are saying. Hopefully my earlier answers above will
make you less worry. :-)

>
> > Although, of course I agree with you, that we should continue to try
> > to convince ARM vendors about moving to the public version of ATF and
> > avoid proprietary FW binaries as much as possible.
> >
>
> Indeed.
>
> --
> Regards,
> Sudeep

Kind regards
Uffe
