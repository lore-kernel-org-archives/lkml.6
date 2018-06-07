Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +JFsHmmAGFtrLwAAmS7hNA
	; Thu, 07 Jun 2018 00:46:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2FA39607F7; Thu,  7 Jun 2018 00:46:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilpLBmi1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 96859608B8;
	Thu,  7 Jun 2018 00:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96859608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeFGAqa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 20:46:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51629 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeFGAq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 20:46:28 -0400
Received: by mail-it0-f68.google.com with SMTP id n7-v6so10658560itn.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 17:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b5jR4waz0kJTh2Dr0wl4gGj/NkC95TTbHHWtCGqHHlw=;
        b=ilpLBmi1KtyhIKLJ5wMzndh+2ZC5FOhjEY5ilXJGq1/wzpWsDtDPP9pSDJcGui2GQa
         B/CeA5yaOgwySQRQJ3P/jD+vWUSwjFU3P5elPMNan0i/ozUzseFbf7o7JwRknJg+nlVe
         IN/LweTSXuiS1wG3SON1iJYQgcqIwZerwRAyZOnXtV0miX568SG+nyMMXWUdgRxWlmt2
         IcgCACeOcWAbkMG+lhhYGOAfFDaKwujmBlkPBpyBy21gkxx48Kc71gq9/YdErtOczb6g
         +6ZHV+4YijbTuTjxpBff5TwYK2GqgrMsM5v+/joRx8wmumXU+va/nhRMWtYDTPtsz/K7
         oZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b5jR4waz0kJTh2Dr0wl4gGj/NkC95TTbHHWtCGqHHlw=;
        b=t/aT9VkOqTdkRIZeZ7OwjRvMPDQxge45NKYU6cav9xXqjFj0ZN8b35RJCIaN2eObQt
         mwQRq3UF7X0Cxwia8plHkw/1JmkHMeCVTuq5y7r1qe69Y3xvqlKDUZaVynbqzWH8flWL
         4DbQ4zHx/SoYJRHX3SAtnfymUVS5Uqlldo3pie+Qx6YjBYd8UDxEvl0Cy3ioU3KwWFYj
         isSXvgmwQkVXPElB/ClBhfQyEvlNpdEWlG4s+YkoxeJMtm+qs8AXOqPeypqiPLDRiIk2
         EruhnzFMbFwnkXYetQ4pylRoW9T8Sm0Rp2rsotY+6Uf+T/uLx3NCU1FoO1vR395xU3Qt
         UiHw==
X-Gm-Message-State: APt69E20NGENj9GHWGHWQruhuFrS9e8yXhjjxD9c7LgzFgLYsG+fO8Fd
        7McUNunPqEiOqSc+I0sZdBVrdyHPzPWIRpDWUvsc5nVa2cU=
X-Google-Smtp-Source: ADUXVKK/9ObvKImiqrYHth/qA+LN7wjflLHe6ngKmXc5J+yO+URYVPuEiou2ckRVjetfLngQe6GcVKzn3GTivXz61KE=
X-Received: by 2002:a24:ac0f:: with SMTP id s15-v6mr106253ite.142.1528332387326;
 Wed, 06 Jun 2018 17:46:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e444:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 17:46:26 -0700 (PDT)
In-Reply-To: <20180507210135.1823-7-hannes@cmpxchg.org>
References: <20180507210135.1823-7-hannes@cmpxchg.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Jun 2018 17:46:26 -0700
Message-ID: <CAJuCfpHAqYZN++CSEMa3fd00ZBB-2Lxu5QW2b_kccrWrRzD+7w@mail.gmail.com>
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and IO
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,


On Mon, May 7, 2018 at 2:01 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> +static void psi_clock(struct work_struct *work)
> +{
> +       u64 some[NR_PSI_RESOURCES] = { 0, };
> +       u64 full[NR_PSI_RESOURCES] = { 0, };
> +       unsigned long nonidle_total = 0;
> +       unsigned long missed_periods;
> +       struct delayed_work *dwork;
> +       struct psi_group *group;
> +       unsigned long expires;
> +       int cpu;
> +       int r;
> +
> +       dwork = to_delayed_work(work);
> +       group = container_of(dwork, struct psi_group, clock_work);
> +
> +       /*
> +        * Calculate the sampling period. The clock might have been
> +        * stopped for a while.
> +        */
> +       expires = group->period_expires;
> +       missed_periods = (jiffies - expires) / MY_LOAD_FREQ;
> +       group->period_expires = expires + ((1 + missed_periods) * MY_LOAD_FREQ);
> +
> +       /*
> +        * Aggregate the per-cpu state into a global state. Each CPU
> +        * is weighted by its non-idle time in the sampling period.
> +        */

Would it be possible to move this aggregation code (excluding
calc_avgs()) into a separate function which is called from here as
well as from psi_show() before group->some[] and group->full[] are
reported? This would not affect the performance if the information is
not requested and at the same time would keep at least the "total"
field up-to-date when the data is requested. For calc_avgs() I think
we would have to calculate the change in nonidle_total, group->some[]
and group->full[] fields differently because a call to psi_show() in
the middle of two psi_clock() calls would refresh these fields before
2secs expire, however calculating that change is trivial if we store
previous group->some[], group->full[] and nonidle_total values inside
psi_clock(). This would require new fields in psi_group struct to
store these previous values but the upside is that we would eliminate
the problem with reporting potentially stale data (up to 2sec update
delay) and provide a function one can use to refresh group->some[] and
group->full[] and implement custom averaging.

> +       for_each_online_cpu(cpu) {
> +               struct psi_group_cpu *groupc = per_cpu_ptr(group->cpus, cpu);
> +               unsigned long nonidle;
> +
> +               nonidle = nsecs_to_jiffies(groupc->nonidle_time);
> +               groupc->nonidle_time = 0;
> +               nonidle_total += nonidle;
> +
> +               for (r = 0; r < NR_PSI_RESOURCES; r++) {
> +                       struct psi_resource *res = &groupc->res[r];
> +
> +                       some[r] += (res->times[0] + res->times[1]) * nonidle;
> +                       full[r] += res->times[1] * nonidle;
> +
> +                       /* It's racy, but we can tolerate some error */
> +                       res->times[0] = 0;
> +                       res->times[1] = 0;
> +               }
> +       }
> +
> +       for (r = 0; r < NR_PSI_RESOURCES; r++) {
> +               /* Finish the weighted aggregation */
> +               some[r] /= max(nonidle_total, 1UL);
> +               full[r] /= max(nonidle_total, 1UL);
> +
> +               /* Accumulate stall time */
> +               group->some[r] += some[r];
> +               group->full[r] += full[r];
> +
> +               /* Calculate recent pressure averages */
> +               calc_avgs(group->avg_some[r], some[r], missed_periods);
> +               calc_avgs(group->avg_full[r], full[r], missed_periods);
> +       }
> +
> +       /* Keep the clock ticking only when there is action */
> +       if (nonidle_total)
> +               schedule_delayed_work(dwork, MY_LOAD_FREQ);
> +}
> +

Thanks,
Suren.
