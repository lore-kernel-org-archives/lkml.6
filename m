Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40863C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D859E2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USDoGPy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D859E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJKOFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:05:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43767 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:05:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id k9so7830515otl.10;
        Wed, 10 Oct 2018 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQa+rA6dMWSpNJRaZdwLCMR/V+PHl95AXkzv+Uxi2BQ=;
        b=USDoGPy2KH8HK/MbEfif4Fi63BTO2ieu4Yd3M+49UMB2UVVWJ8il8nueG+RDoc5eJ6
         +9tQX5izUyPLZhaY3JOMHRvLyYS6NmGK6b0LTv7KLY5tmtWwpxydPwn2s8WZ4I3uVbXF
         YZyBHmJoBE6otXKDdIF7fQJEKp56f02k4mC5nyDpWutUe2Wi9LDS/i7SIh2xPYYcWy1c
         TefXF4OZF0pj4kbV8mZCj0Sc6seWa/BN/O+AqVG+qzhYPZ9/MCdR/yKvZACxA0N197Ig
         XXdLy/u6bm9kQyIypKDYb6jYf9Jwh+Ob6pRCNBBwuQVjUHT5BsZx4H6NSiyVgrXS6+FC
         CoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQa+rA6dMWSpNJRaZdwLCMR/V+PHl95AXkzv+Uxi2BQ=;
        b=a97eKRB1XnXU6wV0MkVf32pMt1PiWuXQNVXHnXp3KDmhfY7vHtJW82pnphzCcZXwpQ
         pZOZWDgOvoMwTzn3pXQ3F4ymrqw/Nx9Tfp7bn/kJFRGZpDAHtu2BfR62yXpIIjGvJnx9
         QO95fYRzE7GNDiGJR6t4GcTjsFasrFG550ISiEq71UFwV6QKIwIvTsgL6qc5NHcHy/2D
         ZOrBjxWu+VlkxSsbqHU4TmeTaNOxPlqknyTyxguer+YeQ5LhtSb5U9o9mAQ8YN5fnTuX
         fsFizh/JIchVpZQK1lwm0k1GOftDSXV5/ZnQMcOpkBBaUfgpPCL1/1lRvM0H8SgQ6Nac
         IStQ==
X-Gm-Message-State: ABuFfojARHqcYWAEIQeW4PA37xeReS7hArcRVyfF0bgp+CediGpIm3U8
        C0/x/4+Mjwxywa00nhANZnEnKQFCvWp6SFOgTeI=
X-Google-Smtp-Source: ACcGV63QlockVhW4iaWFyhtDsZKOwTmLPsiKRG8y5OxEopDdtt1ByyBFfT2Dsr3nl2V/W62d4rn7kSIdpmxAgv74dVU=
X-Received: by 2002:a9d:614a:: with SMTP id c10mr218622otk.278.1539239971433;
 Wed, 10 Oct 2018 23:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com> <c77e9601-71ca-ff09-f21d-b2493ca7c40b@arm.com>
In-Reply-To: <c77e9601-71ca-ff09-f21d-b2493ca7c40b@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 11 Oct 2018 12:09:19 +0530
Message-ID: <CAKTKpr41udk9dGyLVZjO5pj_J7sf_sU_Td3t2R60UMxJatDDXA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
To:     suzuki.poulose@arm.com
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Oct 10, 2018 at 3:22 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Ganapatrao,
>
> On 21/06/18 07:33, Ganapatrao Kulkarni wrote:
> > This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
> > Controller(DMC) and Level 3 Cache(L3C).
> >
> > ThunderX2 has 8 independent DMC PMUs to capture performance events
> > corresponding to 8 channels of DDR4 Memory Controller and 16 independent
> > L3C PMUs to capture events corresponding to 16 tiles of L3 cache.
> > Each PMU supports up to 4 counters. All counters lack overflow interrupt
> > and are sampled periodically.
> >
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> >   drivers/perf/Kconfig         |   8 +
> >   drivers/perf/Makefile        |   1 +
> >   drivers/perf/thunderx2_pmu.c | 949 +++++++++++++++++++++++++++++++++++++++++++
> >   include/linux/cpuhotplug.h   |   1 +
> >   4 files changed, 959 insertions(+)
> >   create mode 100644 drivers/perf/thunderx2_pmu.c
> >
>
>
> > +
> > +/*
> > + * DMC and L3 counter interface is muxed across all channels.
> > + * hence we need to select the channel before accessing counter
> > + * data/control registers.
> > + *
> > + *  L3 Tile and DMC channel selection is through SMC call
> > + *  SMC call arguments,
> > + *   x0 = THUNDERX2_SMC_CALL_ID      (Vendor SMC call Id)
> > + *   x1 = THUNDERX2_SMC_SET_CHANNEL  (Id to set DMC/L3C channel)
> > + *   x2 = Node id
> > + *   x3 = DMC(1)/L3C(0)
> > + *   x4 = channel Id
> > + */
> > +static void uncore_select_channel(struct perf_event *event)
> > +{
> > +     struct arm_smccc_res res;
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
> > +             pmu_to_thunderx2_pmu_uncore(event->pmu);
> > +     struct thunderx2_pmu_uncore_dev *uncore_dev =
> > +             pmu_uncore->uncore_dev;
> > +
> > +     arm_smccc_smc(THUNDERX2_SMC_CALL_ID, THUNDERX2_SMC_SET_CHANNEL,
> > +                     uncore_dev->node, uncore_dev->type,
> > +                     pmu_uncore->channel, 0, 0, 0, &res);
> > +     if (res.a0) {
> > +             dev_err(uncore_dev->dev,
> > +                     "SMC to Select channel failed for PMU UNCORE[%s]\n",
> > +                             pmu_uncore->uncore_dev->name);
> > +     }
> > +}
> > +
>
> > +static void uncore_start_event_l3c(struct perf_event *event, int flags)
> > +{
> > +     u32 val;
> > +     struct hw_perf_event *hwc = &event->hw;
> > +
> > +     /* event id encoded in bits [07:03] */
> > +     val = GET_EVENTID(event) << 3;
> > +     reg_writel(val, hwc->config_base);
> > +     local64_set(&hwc->prev_count, 0);
> > +     reg_writel(0, hwc->event_base);
> > +}
> > +
> > +static void uncore_stop_event_l3c(struct perf_event *event)
> > +{
> > +     reg_writel(0, event->hw.config_base);
> > +}
> > +
> > +static void uncore_start_event_dmc(struct perf_event *event, int flags)
> > +{
> > +     u32 val;
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     int idx = GET_COUNTERID(event);
> > +     int event_type = GET_EVENTID(event);
> > +
> > +     /* enable and start counters.
> > +      * 8 bits for each counter, bits[05:01] of a counter to set event type.
> > +      */
> > +     val = reg_readl(hwc->config_base);
> > +     val &= ~DMC_EVENT_CFG(idx, 0x1f);
> > +     val |= DMC_EVENT_CFG(idx, event_type);
> > +     reg_writel(val, hwc->config_base);
> > +     local64_set(&hwc->prev_count, 0);
> > +     reg_writel(0, hwc->event_base);
> > +}
> > +
> > +static void uncore_stop_event_dmc(struct perf_event *event)
> > +{
> > +     u32 val;
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     int idx = GET_COUNTERID(event);
> > +
> > +     /* clear event type(bits[05:01]) to stop counter */
> > +     val = reg_readl(hwc->config_base);
> > +     val &= ~DMC_EVENT_CFG(idx, 0x1f);
> > +     reg_writel(val, hwc->config_base);
> > +}
> > +
> > +static void init_cntr_base_l3c(struct perf_event *event,
> > +             struct thunderx2_pmu_uncore_dev *uncore_dev)
> > +{
> > +     struct hw_perf_event *hwc = &event->hw;
> > +
> > +     /* counter ctrl/data reg offset at 8 */
> > +     hwc->config_base = (unsigned long)uncore_dev->base
> > +             + L3C_COUNTER_CTL + (8 * GET_COUNTERID(event));
> > +     hwc->event_base =  (unsigned long)uncore_dev->base
> > +             + L3C_COUNTER_DATA + (8 * GET_COUNTERID(event));
> > +}
> > +
> > +static void init_cntr_base_dmc(struct perf_event *event,
> > +             struct thunderx2_pmu_uncore_dev *uncore_dev)
> > +{
> > +     struct hw_perf_event *hwc = &event->hw;
> > +
> > +     hwc->config_base = (unsigned long)uncore_dev->base
> > +             + DMC_COUNTER_CTL;
> > +     /* counter data reg offset at 0xc */
> > +     hwc->event_base = (unsigned long)uncore_dev->base
> > +             + DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event));
> > +}
> > +
> > +static void thunderx2_uncore_update(struct perf_event *event)
> > +{
> > +     s64 prev, new = 0;
> > +     u64 delta;
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> > +     enum thunderx2_uncore_type type;
> > +
> > +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> > +     type = pmu_uncore->uncore_dev->type;
> > +
> > +     pmu_uncore->uncore_dev->select_channel(event);
> > +
> > +     new = reg_readl(hwc->event_base);
> > +     prev = local64_xchg(&hwc->prev_count, new);
> > +
> > +     /* handles rollover of 32 bit counter */
> > +     delta = (u32)(((1UL << 32) - prev) + new);
> > +     local64_add(delta, &event->count);
> > +}
> > +
>
>
> > +
> > +/*
> > + * We must NOT create groups containing events from multiple hardware PMUs,
> > + * although mixing different software and hardware PMUs is allowed.
> > + */
> > +static bool thunderx2_uncore_validate_event_group(struct perf_event *event)
> > +{
> > +     struct pmu *pmu = event->pmu;
> > +     struct perf_event *leader = event->group_leader;
> > +     struct perf_event *sibling;
> > +     int counters = 0;
> > +
> > +     if (leader->pmu != event->pmu && !is_software_event(leader))
> > +             return false;
> > +
> > +     for_each_sibling_event(sibling, event->group_leader) {
> > +             if (is_software_event(sibling))
> > +                     continue;
> > +             if (sibling->pmu != pmu)
> > +                     return false;
> > +             counters++;
> > +     }
>
> The above loop will not account for :
> 1) The leader event
> 2) The event that we are about to add.
>
> So you need to allocate counters for both the above to make sure we can
> accommodate the events.

Is leader also part of sibling list?
>
> > +
> > +     /*
> > +      * If the group requires more counters than the HW has,
> > +      * it cannot ever be scheduled.
> > +      */
> > +     return counters < UNCORE_MAX_COUNTERS;
> > +}
> > +
>
>
> > +
> > +static void thunderx2_uncore_start(struct perf_event *event, int flags)
> > +{
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> > +     struct thunderx2_pmu_uncore_dev *uncore_dev;
> > +     unsigned long irqflags;
> > +
> > +     hwc->state = 0;
> > +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> > +     uncore_dev = pmu_uncore->uncore_dev;
> > +
> > +     raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
> > +     uncore_dev->select_channel(event);
> > +     uncore_dev->start_event(event, flags);
> > +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
> > +
> > +     perf_event_update_userpage(event);
> > +
> > +     if (!find_last_bit(pmu_uncore->active_counters,
> > +                             pmu_uncore->uncore_dev->max_counters)) {
>
> Are we guaranteed that the counter0 is always allocated ? What if the
> event is deleted and there are other events active ? A better check
> would be :
>         if (find_last_bit(...) != pmu_uncore->uncore_dev->max_counters)
>
IIUC, find_last_bit will return  zero if none of the counters are
active and we want to start timer for first active counter.

> > +             hrtimer_start(&pmu_uncore->hrtimer,
> > +                     ns_to_ktime(uncore_dev->hrtimer_interval),
> > +                     HRTIMER_MODE_REL_PINNED);
> > +     }
> > +}
>
>
> > +
> > +static void thunderx2_uncore_stop(struct perf_event *event, int flags)
> > +{
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> > +     struct thunderx2_pmu_uncore_dev *uncore_dev;
> > +     unsigned long irqflags;
> > +
> > +     if (hwc->state & PERF_HES_UPTODATE)
> > +             return;
> > +
> > +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> > +     uncore_dev = pmu_uncore->uncore_dev;
> > +
> > +     raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
> > +
> > +     uncore_dev->select_channel(event);
> > +     uncore_dev->stop_event(event);
> > +
> > +     WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> > +     hwc->state |= PERF_HES_STOPPED;
> > +     if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
>
> We already check the UPTODATE flag above, we could skip that
> flag check here ?

ok, thanks.
>
> > +             thunderx2_uncore_update(event);
> > +             hwc->state |= PERF_HES_UPTODATE;
> > +     }
> > +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
> > +}
> > +
> > +static int thunderx2_uncore_add(struct perf_event *event, int flags)
> > +{
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> > +     struct thunderx2_pmu_uncore_dev *uncore_dev;
> > +
> > +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> > +     uncore_dev = pmu_uncore->uncore_dev;
> > +
> > +     /* Allocate a free counter */
> > +     hwc->idx  = alloc_counter(pmu_uncore);
> > +     if (hwc->idx < 0)
> > +             return -EAGAIN;
> > +
> > +     pmu_uncore->events[hwc->idx] = event;
> > +     /* set counter control and data registers base address */
> > +     uncore_dev->init_cntr_base(event, uncore_dev);
> > +
> > +     hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> > +     if (flags & PERF_EF_START)
> > +             thunderx2_uncore_start(event, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static void thunderx2_uncore_del(struct perf_event *event, int flags)
> > +{
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
> > +                     pmu_to_thunderx2_pmu_uncore(event->pmu);
> > +     struct hw_perf_event *hwc = &event->hw;
> > +
> > +     thunderx2_uncore_stop(event, PERF_EF_UPDATE);
> > +
> > +     /* clear the assigned counter */
> > +     free_counter(pmu_uncore, GET_COUNTERID(event));
> > +
> > +     perf_event_update_userpage(event);
> > +     pmu_uncore->events[hwc->idx] = NULL;
> > +     hwc->idx = -1;
> > +}
> > +
> > +static void thunderx2_uncore_read(struct perf_event *event)
> > +{
> > +     unsigned long irqflags;
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
> > +                     pmu_to_thunderx2_pmu_uncore(event->pmu);
> > +
> > +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
> > +     thunderx2_uncore_update(event);
> > +     raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
> > +}
> > +
> > +static enum hrtimer_restart thunderx2_uncore_hrtimer_callback(
> > +             struct hrtimer *hrt)
> > +{
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> > +     unsigned long irqflags;
> > +     int idx;
> > +     bool restart_timer = false;
> > +
> > +     pmu_uncore = container_of(hrt, struct thunderx2_pmu_uncore_channel,
> > +                     hrtimer);
> > +
> > +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
> > +     for_each_set_bit(idx, pmu_uncore->active_counters,
> > +                     pmu_uncore->uncore_dev->max_counters) {
> > +             struct perf_event *event = pmu_uncore->events[idx];
>
> Do we need to check if the "event" is not NULL ? Couldn't this race with
> an event_del() operation ?

i dont think so, i have not come across any such race condition during
my testing.

>
> > +
> > +             thunderx2_uncore_update(event);
> > +             restart_timer = true;
> > +     }
> > +     raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
> > +
> > +     if (restart_timer)
> > +             hrtimer_forward_now(hrt,
> > +                     ns_to_ktime(
> > +                             pmu_uncore->uncore_dev->hrtimer_interval));
> > +
> > +     return restart_timer ? HRTIMER_RESTART : HRTIMER_NORESTART;
> > +}
> > +
> > +static int thunderx2_pmu_uncore_register(
> > +             struct thunderx2_pmu_uncore_channel *pmu_uncore)
> > +{
> > +     struct device *dev = pmu_uncore->uncore_dev->dev;
> > +     char *name = pmu_uncore->uncore_dev->name;
> > +     int channel = pmu_uncore->channel;
> > +
> > +     /* Perf event registration */
> > +     pmu_uncore->pmu = (struct pmu) {
> > +             .attr_groups    = pmu_uncore->uncore_dev->attr_groups,
> > +             .task_ctx_nr    = perf_invalid_context,
> > +             .event_init     = thunderx2_uncore_event_init,
> > +             .add            = thunderx2_uncore_add,
> > +             .del            = thunderx2_uncore_del,
> > +             .start          = thunderx2_uncore_start,
> > +             .stop           = thunderx2_uncore_stop,
> > +             .read           = thunderx2_uncore_read,
>
> You must fill in the module field of the PMU to prevent this module from
> being unloaded while it is in use.

thanks, i will add it.
>
> > +     };
> > +
> > +     pmu_uncore->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
> > +                     "%s_%d", name, channel);
> > +
> > +     return perf_pmu_register(&pmu_uncore->pmu, pmu_uncore->pmu.name, -1);
> > +}
> > +
> > +static int thunderx2_pmu_uncore_add(struct thunderx2_pmu_uncore_dev *uncore_dev,
> > +             int channel)
> > +{
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> > +     int ret, cpu;
> > +
> > +     pmu_uncore = devm_kzalloc(uncore_dev->dev, sizeof(*pmu_uncore),
> > +                     GFP_KERNEL);
> > +     if (!pmu_uncore)
> > +             return -ENOMEM;
> > +
> > +     cpu = cpumask_any_and(cpumask_of_node(uncore_dev->node),
> > +                     cpu_online_mask);
> > +     if (cpu >= nr_cpu_ids)
> > +             return -EINVAL;
>
> Do we need to fail this here ? We could always add this back when a CPU
> comes online (e.g, maxcpus=n). We do have cpu-hotplug call backs anyway.

we want to fail, since we dont have any cpu to serve.

>
> > +static acpi_status thunderx2_pmu_uncore_dev_add(acpi_handle handle, u32 level,
> > +                                 void *data, void **return_value)
> > +{
> > +     struct thunderx2_pmu_uncore_dev *uncore_dev;
> > +     struct acpi_device *adev;
> > +     enum thunderx2_uncore_type type;
> > +     int channel;
> > +
> > +     if (acpi_bus_get_device(handle, &adev))
> > +             return AE_OK;
> > +     if (acpi_bus_get_status(adev) || !adev->status.present)
> > +             return AE_OK;
> > +
> > +     type = get_uncore_device_type(adev);
> > +     if (type == PMU_TYPE_INVALID)
> > +             return AE_OK;
> > +
> > +     uncore_dev = init_pmu_uncore_dev((struct device *)data, handle,
> > +                     adev, type);
> > +
> > +     if (!uncore_dev)
> > +             return AE_ERROR;
> > +
> > +     for (channel = 0; channel < uncore_dev->max_channels; channel++) {
> > +             if (thunderx2_pmu_uncore_add(uncore_dev, channel)) {
> > +                     /* Can't add the PMU device, abort */
> > +                     return AE_ERROR;
> > +             }
> > +     }
> > +     return AE_OK;
> > +}
> > +
> > +static int thunderx2_uncore_pmu_offline_cpu(unsigned int cpu,
> > +             struct hlist_node *node)
> > +{
> > +     int new_cpu;
> > +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> > +
> > +     pmu_uncore = hlist_entry_safe(node,
> > +                     struct thunderx2_pmu_uncore_channel, node);
> > +     if (cpu != pmu_uncore->cpu)
> > +             return 0;
> > +
> > +     new_cpu = cpumask_any_and(
> > +                     cpumask_of_node(pmu_uncore->uncore_dev->node),
> > +                     cpu_online_mask);
> > +     if (new_cpu >= nr_cpu_ids)
> > +             return 0;
> > +
> > +     pmu_uncore->cpu = new_cpu;
> > +     perf_pmu_migrate_context(&pmu_uncore->pmu, cpu, new_cpu);
> > +     return 0;
> > +}
> > +
> > +static const struct acpi_device_id thunderx2_uncore_acpi_match[] = {
> > +     {"CAV901C", 0},
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(acpi, thunderx2_uncore_acpi_match);
> > +
> > +static int thunderx2_uncore_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     acpi_handle handle;
> > +     acpi_status status;
> > +
> > +     set_dev_node(dev, acpi_get_node(ACPI_HANDLE(dev)));
> > +
> > +     /* Make sure firmware supports DMC/L3C set channel smc call */
> > +     if (test_uncore_select_channel_early(dev))
> > +             return -ENODEV;
> > +
> > +     if (!has_acpi_companion(dev))
> > +             return -ENODEV;
> > +
> > +     handle = ACPI_HANDLE(dev);
> > +     if (!handle)
> > +             return -EINVAL;
> > +
> > +     /* Walk through the tree for all PMU UNCORE devices */
> > +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> > +                                  thunderx2_pmu_uncore_dev_add,
> > +                                  NULL, dev, NULL);
> > +     if (ACPI_FAILURE(status)) {
> > +             dev_err(dev, "failed to probe PMU devices\n");
> > +             return_ACPI_STATUS(status);
> > +     }
> > +
> > +     dev_info(dev, "node%d: pmu uncore registered\n", dev_to_node(dev));
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver thunderx2_uncore_driver = {
> > +     .probe = thunderx2_uncore_probe,
> > +     .driver = {
> > +             .name           = "thunderx2-uncore-pmu",
> > +             .acpi_match_table = ACPI_PTR(thunderx2_uncore_acpi_match),
> > +     },
> > +};
>
> Don't we need to unregister the pmu's when we remove the module ?

it is built in module at present, no unload is supported.
Anyway i am adding in next version , since i am going for loadable module.

>
> Suzuki

thanks
Ganapat
