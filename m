Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE38C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA44208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgjCV92m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA44208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeGaKAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:00:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53597 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeGaKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:00:36 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so3155615itw.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsedL34Iwh9QW83RmG9rZsf9noYCWwlKl4IRxDF7iGc=;
        b=fgjCV92mgEngHdTlf+Ld73WZoQpxzJfGzbKnUeuZTY88l5cPGCEW5C46m2tpOhbvWp
         4PK2+zQxynjt1E/lZZNmiVE8N0QtvpY4P7dhYgjPqgeMW11PYPuTT9lm52Yq6edbiMuQ
         W6zjF6nFqm5pOX7pAHcV93VcvE6zwF4K/4wXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsedL34Iwh9QW83RmG9rZsf9noYCWwlKl4IRxDF7iGc=;
        b=ExMhsRrlSWw17wtG0DwlSITsH1rHI+pBlBbFenAwuW/7zoiaWhWLh9iKcuLVXfAMR0
         ZAHTX66yR9VVSwiqrZP1v8gWyW2aHzaDY2V0JfqIiucOadAB2DVXsKe2uTTxyDpLXKFP
         4iSrvTNyXPpCuEQFTCPASmwSkyguvmSpeb2Pv5CUfliTBB3uD82917oQiSY8JWKJibOD
         wqCkP3iYTzo5S8wQ0/85LFOM5NJDL7ErrCIq3xP5ZhZF5ouhcpyZlgLeTca6M+MdqiSg
         PVN+OdbHln8AhAjOxa0lQ5fSGYmbt24Fs/p90KelAndA3/CG5pa7ESusLUFEV2AT2zbA
         KCmA==
X-Gm-Message-State: AOUpUlFTPbjOi2VXzRPu56y3mlWk2VP/z2Gr+V3JDh4jdLNipqLHYNRT
        KQTffP6eXORwqbbodbukt4yuXkNgie1o5Sx61SiiKw==
X-Google-Smtp-Source: AAOMgpcXRJj67xD8TNgwTzyeunYaUcXYh0jhzwxW+rcHKjSLvszd7Vs5xfhT9ivC57/GIEfQBg0+bg12vQpQ56/CfAA=
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr2024266itb.8.1533025285670;
 Tue, 31 Jul 2018 01:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-7-git-send-email-vincent.guittot@linaro.org>
 <CANRm+Cz0-61-WOT8CLf02G-aHEwrff6WVWd6mp0DKV+GfFyvWw@mail.gmail.com>
 <CAKfTPtBMSvfLYAZz6p+uj0G2uq87QzXBOnTHMmzV=niwd0nMjA@mail.gmail.com> <CANRm+Cw7Rg1mFgqAzbS-72z=RZ4mBV_vp=0obC7YPyR5ZdqXVA@mail.gmail.com>
In-Reply-To: <CANRm+Cw7Rg1mFgqAzbS-72z=RZ4mBV_vp=0obC7YPyR5ZdqXVA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 31 Jul 2018 10:21:14 +0200
Message-ID: <CAKfTPtDG3d5HtmTXmz4SB9J9Ncv-ATPXsh_VsyJAB9516GLQKg@mail.gmail.com>
Subject: Re: [PATCH 06/11] sched/irq: add irq utilization tracking
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 at 05:32, Wanpeng Li <kernellwp@gmail.com> wrote:

> > > >
> > > >  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > > >         if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
> > > > -               sched_rt_avg_update(rq, irq_delta + steal);
> > > > +               update_irq_load_avg(rq, irq_delta + steal);
> > >
> > > I think we should not add steal time into irq load tracking, steal
> > > time is always 0 on native kernel which doesn't matter, what will
> > > happen when guest disables IRQ_TIME_ACCOUNTING and enables
> > > PARAVIRT_TIME_ACCOUNTING? Steal time is not the real irq util_avg. In
> > > addition, we haven't exposed power management for performance which
> > > means that e.g. schedutil governor can not cooperate with passive mode
> > > intel_pstate driver to tune the OPP. To decay the old steal time avg
> > > and add the new one just wastes cpu cycles.
> >
> > In fact, I have kept the same behavior as with rt_avg, which was
> > already adding steal time when computing scale_rt_capacity, which is
> > used to reflect the remaining capacity for FAIR tasks and is used in
> > load balance. I'm not sure that it's worth using different variables
> > for irq and steal.
> > That being said, I see a possible optimization in schedutil when
> > PARAVIRT_TIME_ACCOUNTING is enable and IRQ_TIME_ACCOUNTING is disable.
> > With this kind of config, scale_irq_capacity can be a nop for
> > schedutil but scales the utilization for scale_rt_capacity
>
> Yeah, this is what in my mind before, you can make a patch for that. :)

ok, I'm going to prepare a patch

Thanks

>
> Regards,
> Wanpeng Li
