Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2CFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3F620839
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVnhrFbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeHXNAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:00:08 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50831 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeHXNAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:00:08 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so1296138ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fPzEj+3eewhBZ7+76CHA6pVfTZBMnW7nLtyGE98+Irg=;
        b=IVnhrFblG3jvcJExREx8jjaU18CRJyPPW3a0Rg2dWX4t7h1Mc0WBZvYIkU8ALhQPMW
         16rOerXQmiTpBNM+0m2fyiwJuHgFm0f9cPaKxe5U8RhsOB7VcbllQHk0+1o6pPC2hd/X
         jB0x5qJjtN4FmYhAq7KY4lOfjac96ei6dv62s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fPzEj+3eewhBZ7+76CHA6pVfTZBMnW7nLtyGE98+Irg=;
        b=YR1U2B9Vhwqam8boWODuCs3wWQDbsLyodkkc0T/LCcjL2jX4gPLEvTAwvM6d298h0B
         0SPc7itQwoI3yZzTLR6RxHiy71gOHIPpsMEg755KPQqPXbKvOp88NRvJY6IpHY4sneY+
         /PplqQPdaSOyZhLhXrdHf8oQEuPPC3RMLG9kGx2Sfkwg6UZb1d1TsP6fkLGJgaDE+B9g
         w0MmjRgTn9xzGBa/GigCpVE2AiA3UpJcsX5Evjf3XhjHIvvvg69WVyAJRFZEETAlJGYy
         11XDF/NEx9TVmAodVadW5C9w/IvM0PEpot3R9/gnCVe7DjYejvcMV1Q6PpBdFZ43ZSBm
         wNRg==
X-Gm-Message-State: APzg51B9LI7mTJRuGoFrJLrzaaVPNVYyowGm9b9udk6p5gtQiAaAZThS
        O4xvSNuskkkscylcJ/l47SLeYWnLxDeyP4RKGzNw7Q==
X-Google-Smtp-Source: ANB0VdaQnU5G4f4JAUJ2yCsmXuccfAs1Zl2nK53bMVPC6GUkiQNZXf1FBarsQe17qxDQ2bIDWiCTZJArNJv1GFTIb6k=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr734917ita.64.1535102779966;
 Fri, 24 Aug 2018 02:26:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 02:26:19
 -0700 (PDT)
In-Reply-To: <20180809153925.GA20329@red-moon>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-8-ulf.hansson@linaro.org> <3574880.GjmnMm1lMq@aspire.rjw.lan>
 <10360149.m4MlxDWZY5@aspire.rjw.lan> <CAPDyKFonHYSq32WxvB1x5PXissXZvraqazgU_ZyLR=tsyD9vAA@mail.gmail.com>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com> <20180809153925.GA20329@red-moon>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Aug 2018 11:26:19 +0200
Message-ID: <CAPDyKFp=AuqEPHKYgi-+DAhejQZSHixmtLORj_Rkn3m8fUoqJw@mail.gmail.com>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 August 2018 at 17:39, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Mon, Aug 06, 2018 at 11:20:59AM +0200, Rafael J. Wysocki wrote:
>
> [...]
>
>> >>> > @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>> >>> >     return false;
>> >>> >  }
>> >>> >
>> >>> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>> >>> > +{
>> >>> > +   struct generic_pm_domain *genpd = pd_to_genpd(pd);
>> >>> > +   ktime_t domain_wakeup, cpu_wakeup;
>> >>> > +   s64 idle_duration_ns;
>> >>> > +   int cpu, i;
>> >>> > +
>> >>> > +   if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>> >>> > +           return true;
>> >>> > +
>> >>> > +   /*
>> >>> > +    * Find the next wakeup for any of the online CPUs within the PM domain
>> >>> > +    * and its subdomains. Note, we only need the genpd->cpus, as it already
>> >>> > +    * contains a mask of all CPUs from subdomains.
>> >>> > +    */
>> >>> > +   domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
>> >>> > +   for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
>> >>> > +           cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
>> >>> > +           if (ktime_before(cpu_wakeup, domain_wakeup))
>> >>> > +                   domain_wakeup = cpu_wakeup;
>> >>> > +   }
>> >>
>> >> Here's a concern I have missed before. :-/
>> >>
>> >> Say, one of the CPUs you're walking here is woken up in the meantime.
>> >
>> > Yes, that can happen - when we miss-predicted "next wakeup".
>> >
>> >>
>> >> I don't think it is valid to evaluate tick_nohz_get_next_wakeup() for it then
>> >> to update domain_wakeup.  We really should just avoid the domain power off in
>> >> that case at all IMO.
>> >
>> > Correct.
>> >
>> > However, we also want to avoid locking contentions in the idle path,
>> > which is what this boils done to.
>>
>> This already is done under genpd_lock() AFAICS, so I'm not quite sure
>> what exactly you mean.
>>
>> Besides, this is not just about increased latency, which is a concern
>> by itself but maybe not so much in all environments, but also about
>> possibility of missing a CPU wakeup, which is a major issue.
>>
>> If one of the CPUs sharing the domain with the current one is woken up
>> during cpu_power_down_ok() and the wakeup is an edge-triggered
>> interrupt and the domain is turned off regardless, the wakeup may be
>> missed entirely if I'm not mistaken.
>>
>> It looks like there needs to be a way for the hardware to prevent a
>> domain poweroff when there's a pending interrupt or I don't quite see
>> how this can be handled correctly.
>>
>> >> Sure enough, if the domain power off is already started and one of the CPUs
>> >> in the domain is woken up then, too bad, it will suffer the latency (but in
>> >> that case the hardware should be able to help somewhat), but otherwise CPU
>> >> wakeup should prevent domain power off from being carried out.
>> >
>> > The CPU is not prevented from waking up, as we rely on the FW to deal with that.
>> >
>> > Even if the above computation turns out to wrongly suggest that the
>> > cluster can be powered off, the FW shall together with the genpd
>> > backend driver prevent it.
>>
>> Fine, but then the solution depends on specific FW/HW behavior, so I'm
>> not sure how generic it really is.  At least, that expectation should
>> be clearly documented somewhere, preferably in code comments.
>>
>> > To cover this case for PSCI, we also use a per cpu variable for the
>> > CPU's power off state, as can be seen later in the series.
>>
>> Oh great, but the generic part should be independent on the underlying
>> implementation of the driver.  If it isn't, then it also is not
>> generic.
>>
>> > Hope this clarifies your concern, else tell and will to elaborate a bit more.
>>
>> Not really.
>>
>> There also is one more problem and that is the interaction between
>> this code and the idle governor.
>>
>> Namely, the idle governor may select a shallower state for some
>> reason, for example due to an additional latency limit derived from
>> CPU utilization (like in the menu governor), and how does the code in
>> cpu_power_down_ok() know what state has been selected and how does it
>> honor the selection made by the idle governor?
>
> That's a good question and it maybe gives a path towards a solution.
>
> AFAICS the genPD governor only selects the idle state parameter that
> determines the idle state at, say, GenPD cpumask level it does not touch
> the CPUidle decision, that works on a subset of idle states (at cpu
> level).
>
> That's my understanding, which can be wrong so please correct me
> if that's the case because that's a bit confusing.
>
> Let's imagine that we flattened out the list of idle states and feed
> CPUidle with it (all of them - cpu, cluster, package, system - as it is
> in the mainline _now_). Then the GenPD governor can run-through the
> CPUidle selection and _demote_ the idle state if necessary since it
> understands that some CPUs in the GenPD will wake up shortly and break
> the target residency hyphothesis the CPUidle governor is expecting.
>
> The whole idea about this series is improving CPUidle decision when
> the target idle state is _shared_ among groups of cpus (again, please
> do correct me if I am wrong).

Absolutely, this is one of the main reason for the series!

>
> It is obvious that a GenPD governor must only demote - never promote a
> CPU idle state selection given that hierarchy implies more power
> savings and higher target residencies required.

Absolutely. I apologize if I have been using the word "promote"
wrongly, I realize it may be a bit confusing.

>
> This whole series would become more generic and won't depend on
> PSCI OSI at all - actually that would become a hierarchical
> CPUidle governor.

Well, to me we need a first user of the new infrastructure code in
genpd and PSCI is probably the easiest one to start with. An option
would be to start with an old ARM32 platform, but it seems a bit silly
to me.

In regards to OS-initiated mode vs platform coordinated mode, let's
discuss that in details in the other email thread instead.

>
> I still think that PSCI firmware and most certainly mwait() play the
> role the GenPD governor does since they can detect in FW/HW whether
> that's worthwhile to switch off a domain, the information is obviously
> there and the kernel would just add latency to the idle path in that
> case but let's gloss over this for the sake of this discussion.

Yep, let's discuss that separately.

That said, can I interpret your comments on the series up until this
change, that you seems rather happy with where the series is going?

Kind regards
Uffe
