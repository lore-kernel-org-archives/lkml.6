Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FDEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0A120882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXn62z7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0A120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbeGYT5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:57:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42403 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbeGYT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:57:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so5864707pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtnFKsjdf5AXtuXrRH8WoWw7CIc5wRumDDY/tnTQAiM=;
        b=AXn62z7oTQdQIYt0E+NSdTBQzAaDLzMl/vvA1/8zXWGyQjl5rSv+IC5ImrXZg0b5+C
         4pMudP2jd6Z3kXqaR4dCYo1fdc7hL6mgGNP9y/OB8eqI60mFvFjoP5P97yFxISL0NwWx
         19zMwO+rxQy0BS8Zi1WvHShYg7I6c+xWTRLDobGs63qbIWLxnQwKxMNrib+WK8p+JsKQ
         ifEfDjLJ2w/uBIUcrcS7OmxYQGXMM2L5Hah02lKzcMgy5N7nKH/k068PPejWp9Xre5jn
         Kq/d/bHeMUbQuWuJ7Rba+nPrmUUEMc6rs4TgwbMHWUTC4fBz1c3Hip5JOayr74igv6Ua
         cNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtnFKsjdf5AXtuXrRH8WoWw7CIc5wRumDDY/tnTQAiM=;
        b=AZtcAepPMWGuPqU5UU6fyaeT8yQ+WlpPOEbRgEF95gvoaOeyT2sOPLaXrqF1JtkEkj
         AnK8Wd3YOI8P3HLddoYV/UgVXPqI/dXZT4/oPB1JSIPWjY4TU7XwJf/KQXNB/tbGoM2A
         HFqp03r4Aau+KfzT/8c4o2vnS1TZK0fXzVZ9twAT+T6/KJhfnViQkVvIpCV4c4ihVFDR
         2Dssg0SI8YaBL+WNTifH+0JAX5+YZrBrnURHuC6BCavs4DtJ50+naz06Sik5weADzXYp
         pS3AF+jyk5gjlMceevn1S7hsBCtUfm+pLohdTx9KWqNkBCid7IJpk3wJQtv08exXtGiC
         QPbQ==
X-Gm-Message-State: AOUpUlHdWAH7N+2ko6B3JSAJda6oSvDKvTtWJwmQTbQpG3iiBwnW73YW
        Srl9cS43IjYoc6vx8Av+k929AZvA9gKSFuxNXNs=
X-Google-Smtp-Source: AAOMgpe/6nRgFZPLoUxfVURZSzlKb/mvcR1Olk58hZYVnV+S3XM8AbpEID1PBkV2oP8AIq5JuYhfgTkEat1HOScvAcQ=
X-Received: by 2002:a63:2506:: with SMTP id l6-v6mr21317479pgl.237.1532544286456;
 Wed, 25 Jul 2018 11:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180719132834.GF18667@krava> <20180719191253.3843-1-xiyou.wangcong@gmail.com>
 <20180720115217.GQ2494@hirez.programming.kicks-ass.net> <CAM_iQpWVhLZKo9j6COGkvryGrxJq6sEXzh2S-ikza2H3=pAyqw@mail.gmail.com>
 <CAM_iQpV33dj-_bwYp3QJdPKihR8HyPzKMOpi1Lrqm7VtN3bZ8w@mail.gmail.com>
 <CAM_iQpXUsVW7a0+_Z_R-k8xGEQBSKd5Oz7j5+z=G1kQHoDfCqQ@mail.gmail.com> <20180724091824.GM2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180724091824.GM2494@hirez.programming.kicks-ass.net>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 25 Jul 2018 11:44:34 -0700
Message-ID: <CAM_iQpVT73pofGYYys+OC5OCs8w+Q+rnfnwBaQQRuobnqcEJUg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: fix a possible deadlock scenario
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 2:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 23, 2018 at 06:44:43PM -0700, Cong Wang wrote:
> > On Mon, Jul 23, 2018 at 6:35 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > >
> > > Hi, Peter, Andi
> > >
> > > While reviewing the deadlock, I find out it looks like we could have the
> > > following infinite recursion too:
> > >
> > > perf_event_account_interrupt()
> > > __perf_event_account_interrupt()
> > > perf_adjust_period()
> > > event->pmu->stop
> > > x86_pmu_stop()
> > > x86_pmu.disable()
> >
> > Hmm, x86_pmu_stop() calls __test_and_clear_bit(), so
> > we should not call x86_pmu.disable() twice here.
>
> Right, but since we set HES_UPTODATE after calling
> x86_perf_event_update() that can in fact recurse.

I don't see how HES_UPTODATE flag or x86_perf_event_update()
could affect the path on this call chain.


>
> Now, I don't think that'll be fatal, but it might be good to test that.
>
> If you pick these patches:
>
>   https://lkml.kernel.org/r/20170928121823.430053219@infradead.org
>
> use force_early_printk (and actually configure a serial early_printk)
> and put a printk() in x86_pmu_stop() and then run the perf_fuzzer or
> something to try and reproduce.

Is this patchset to make printk() working in NMI context?
But printk() is already used in NMI context, see perf_event_print_debug()
which is called in intel_pmu_handle_irq().


>
> But paranoia suggets moving that HES_UPTODATE thing one line up.
>
> > > intel_pmu_disable_event()
> > > intel_pmu_pebs_disable()
> > > intel_pmu_drain_pebs_buffer()
> > > intel_pmu_drain_pebs_nhm()
> > > <repeat....>
> > >
> > > This time is pure hardware events, attr.freq must be non-zero.
> > >
> > > And, we could enter this infinite recursion in NMI handler too:
> > >
> > > intel_pmu_handle_irq()
> > > perf_event_overflow()
> > > __perf_event_overflow()
> > > __perf_event_account_interrupt()
> > > ....
> > >
> > > Or this is impossible too?
>
> I'm not sure I see this second one.. can you be a little more specific?

In fact, it is this:

intel_pmu_handle_irq()
x86_pmu.drain_pebs()
intel_pmu_drain_pebs_nhm()
perf_event_account_interrupt()
__perf_event_account_interrupt()
perf_adjust_period()
event->pmu->stop()
x86_pmu_stop()
x86_pmu.disable()
intel_pmu_disable_event()
intel_pmu_pebs_disable()
intel_pmu_drain_pebs_buffer()
<repeat....>


Thanks!
