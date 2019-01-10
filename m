Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6883F21841
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547115619;
	bh=s8XyETGOhdB8SD6+zYKlnM2UV7T/75KmbPkW+K+6HQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NZ9eJauxU8UYDPzit8A+946WbxFM4vRMqcOvu10UOtzn9M7yzNswIcPzDIldWGHNc
	 n/4A4CAyLYWmUyNN0evufnKtUZuOLMC51f4h8Q7bHSaZws8Zi0mjmGe89ja4kCG6bI
	 lULg4diTAZ7BedzAXNjTHrDlPDjqsdDCTGdz4emw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfAJKUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:20:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42364 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAJKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:20:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so9446848otk.9;
        Thu, 10 Jan 2019 02:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erabJoUdEcwQirUCWmkQJ9vJZtqewSYaYSiCYietYOA=;
        b=nnSmrM8xECxxSVyrbo6gxeUeBRWNowxZCrHlsAZ69ZD5EqTispYXydyR4dvKPLLNhe
         OtrTdHu0OSHrRCyXeyfyuSAt8KZrMlIyz6LWpCmc+n62mVA8rlkplEPpm28veSsVe4V5
         SoGC0DTklBAmZHrRIn6A+L7Rt0/X+EPOGO9lA6xHuVQ26vdQ7RuXZSkVnjbkoAa+SSE2
         rFkpp5GXlvoIlomfjRmI6SrpjaEZe//ugSrBccFpHg2BX28q4j/T94C3slBK1eI38pgq
         p/ePQNr1qIk5IGVNZ4Sol2EbffrjFsHZdbyjsr9xaZpzLHyIRabcAVP4Elhb4sDyiJmN
         Jnww==
X-Gm-Message-State: AJcUukeCq4ZtP8G7CpOvWReL9IofADh6qB0uNyJ24Kgbi+C8fJC8TNar
        FMeFsyLAX4ArYF4rihTW3Kv6EyKv+vyR1AdRjQw=
X-Google-Smtp-Source: ALg8bN53ljxeT9TlHd8DjDlHyNKZ1ZK9WrmcawSYtzrL56qs6lrE8IM+0mx6g0cYfcYEocCsja3hr6vIqETPMvlK27w=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr6063772ota.244.1547115616722;
 Thu, 10 Jan 2019 02:20:16 -0800 (PST)
MIME-Version: 1.0
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
In-Reply-To: <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jan 2019 11:20:05 +0100
Message-ID: <CAJZ5v0hPnoLzJPRgE43NrB2Vt4BZYx=jgw_-WHoAiBQvhviY1A@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:53 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/12/2018 12:30, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add two new metrics for CPU idle states, "above" and "below", to count
> > the number of times the given state had been asked for (or entered
> > from the kernel's perspective), but the observed idle duration turned
> > out to be too short or too long for it (respectively).
> >
> > These metrics help to estimate the quality of the CPU idle governor
> > in use.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2: Fix a leftover in the documentation from the previous versions
> >        of the patch and a typo in the changelog.
> >
> > ---
> >  Documentation/ABI/testing/sysfs-devices-system-cpu |    7 ++++
> >  Documentation/admin-guide/pm/cpuidle.rst           |   10 ++++++
> >  drivers/cpuidle/cpuidle.c                          |   31 ++++++++++++++++++++-
> >  drivers/cpuidle/sysfs.c                            |    6 ++++
> >  include/linux/cpuidle.h                            |    2 +
> >  5 files changed, 55 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > @@ -202,7 +202,6 @@ int cpuidle_enter_state(struct cpuidle_d
> >       struct cpuidle_state *target_state = &drv->states[index];
> >       bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
> >       ktime_t time_start, time_end;
> > -     s64 diff;
> >
> >       /*
> >        * Tell the time framework to switch to a broadcast timer because our
> > @@ -248,6 +247,9 @@ int cpuidle_enter_state(struct cpuidle_d
> >               local_irq_enable();
> >
> >       if (entered_state >= 0) {
> > +             s64 diff, delay = drv->states[entered_state].exit_latency;
> > +             int i;
> > +
> >               /*
> >                * Update cpuidle counters
> >                * This can be moved to within driver enter routine,
> > @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
> >               dev->last_residency = (int)diff;
>
> Shouldn't we subtract the 'delay' from the computed 'diff' in any case ?

No.

> Otherwise the 'last_residency' accumulates the effective sleep time and
> the time to wakeup. We are interested in the sleep time only for
> prediction and metrics no ?

Yes, but 'delay' is the worst-case latency and not the actual one
experienced, most of the time, and (on average) we would underestimate
the sleep time if it was always subtracted.

The idea here is to only count the wakeup as 'above' if the total
'last_residency' is below the target residency of the idle state that
was asked for (as in that case we know for certain that the CPU has
been woken up too early) and to only count it as 'below' if the
difference between 'last_residency' and 'delay' is greater than or
equal to the target residency of a deeper idle state (as in that case
we know for certain that the CPU has been woken up too late).

Of course, this means that there is a "gray area" in which we are not
really sure if the sleep time has matched the idle state that was
asked for, but there's not much we can do about that IMO.
