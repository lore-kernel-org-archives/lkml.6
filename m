Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0637ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC0520883
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdPfewB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC0520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbeGMNNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:13:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36510 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeGMNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:13:17 -0400
Received: by mail-oi0-f67.google.com with SMTP id r16-v6so62064024oie.3;
        Fri, 13 Jul 2018 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=olW1fZ0AqQ1mLIrIK1f17UNyGFvFkUoAe2nYF4g4bkE=;
        b=tdPfewB/RscO7uhCGANoWKcsVT5TPjWggG2Dik5cAYMntRS1Mh1NPa8ek5LiaGnA/k
         GR97i3PNKNK04lvKixHkGefQvJLZNsDF4JsSVW+pEvaoP9W9faTjs8W0TNGWkP4LVgPP
         tulHrT3lppIISvr4Y/cJFruYpYQGdFqWKg1ewwbXfWAwb5OsGDAue0SiGoe6cwlLqBgM
         mqRzU+eapUjjcLgfyWYBmnlXsfIfRWsl0imPC7KnB5OvMW/YHblA0SZoTiGArKOutjLg
         BiGnBjbIR+3sK2t2p3OJLyWW1Er5YmKYZn616+zYpLfvInAV5oER5qgIOI/+epOVdKv2
         Hw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=olW1fZ0AqQ1mLIrIK1f17UNyGFvFkUoAe2nYF4g4bkE=;
        b=mAIUPakll1YzVwDBygQag8/i7cnhKqHlt5jXVaEi+FJUmvpDg1dDK6b50YCHDYVCCa
         7cXYexcDoWFU+bNrKU9PIVstU3Yiof3odCT8v+zuF11yu8hnLsDuNmwCXSo3Vu4oAcTd
         eY5+wWCqQmWZ7h8o9chinTIp3jBcvHDLAKdI1qawUSjoOEX02dTFrMhqlujLhyqBkFPR
         OpgqXBJL3Kbk/oynxJX8vTCIny6gw9YnMY0khSlWw48zlnSm2CqZz3EcaAdYGxIqlZib
         osz883krf2IN6GjSptZ8lBGmhmrVu7L7rCrVQLp0NMbg6b+k3WtgsYB4+3gTQYSDhlf4
         H6Jw==
X-Gm-Message-State: AOUpUlH/6a+WnWiNhwnOilTjUP/lYUZg2TpHFb1H98iu0OWvMWDMgt5o
        9yJRTWrF5QhXsWuRDH4jgi9m/Te5rDqRE93eg9o=
X-Google-Smtp-Source: AAOMgpcy7Yzc91FUPgxKSfXRwY0emphKrmnaf8u1IIp++CCu1IhOOVc2PBdWnJBjiBr8iBvP24VvHRpAWY408ML7sao=
X-Received: by 2002:aca:d00d:: with SMTP id h13-v6mr7120794oig.50.1531486722738;
 Fri, 13 Jul 2018 05:58:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:d37:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 05:58:42 -0700 (PDT)
In-Reply-To: <20180712165606.3vqx4ysnvdlfzmtp@lakrids.cambridge.arm.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com> <20180712165606.3vqx4ysnvdlfzmtp@lakrids.cambridge.arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 13 Jul 2018 18:28:42 +0530
Message-ID: <CAKTKpr5d0f6Hjj5_j4OFh609SrMOEYg+Zgm3O7UiJx7bw5A_XA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks Mark for the comments.

On Thu, Jul 12, 2018 at 10:26 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ganapat,
>
> On Thu, Jun 21, 2018 at 12:03:38PM +0530, Ganapatrao Kulkarni wrote:
>> This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
>> Controller(DMC) and Level 3 Cache(L3C).
>>
>> ThunderX2 has 8 independent DMC PMUs to capture performance events
>> corresponding to 8 channels of DDR4 Memory Controller and 16 independent
>> L3C PMUs to capture events corresponding to 16 tiles of L3 cache.
>> Each PMU supports up to 4 counters. All counters lack overflow interrupt
>> and are sampled periodically.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  drivers/perf/Kconfig         |   8 +
>>  drivers/perf/Makefile        |   1 +
>>  drivers/perf/thunderx2_pmu.c | 949 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/cpuhotplug.h   |   1 +
>>  4 files changed, 959 insertions(+)
>>  create mode 100644 drivers/perf/thunderx2_pmu.c
>>
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 08ebaf7..ecedb9e 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -87,6 +87,14 @@ config QCOM_L3_PMU
>>          Adds the L3 cache PMU into the perf events subsystem for
>>          monitoring L3 cache events.
>>
>> +config THUNDERX2_PMU
>> +        bool "Cavium ThunderX2 SoC PMU UNCORE"
>> +     depends on ARCH_THUNDER2 && ARM64 && ACPI
>
> Surely this depends on NUMA for the node id?
 it is, i will update.

>
> [...]
>
>> +/*
>> + * pmu on each socket has 2 uncore devices(dmc and l3),
>> + * each uncore device has up to 16 channels, each channel can sample
>> + * events independently with counters up to 4.
>> + */
>> +struct thunderx2_pmu_uncore_channel {
>> +     struct pmu pmu;
>> +     struct hlist_node       node;
>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>> +     int channel;
>> +     int cpu;
>> +     DECLARE_BITMAP(active_counters, UNCORE_MAX_COUNTERS);
>> +     struct perf_event *events[UNCORE_MAX_COUNTERS];
>> +     struct hrtimer hrtimer;
>> +     /* to sync counter alloc/release */
>> +     raw_spinlock_t lock;
>> +};
>
> This lock should not be necessary. The pmu::{add,del} callbacks are
> strictly serialised w.r.t. one another per CPU because the core perf
> code holds ctx->lock whenever it calls either.
>
> Previously, you mentioned you'd seen scheduling while atomic when this
> lock was removed. Could you please provide a backtrace?

yes, i have seen,  if i try to kick in simulatneously more events than
h/w counters available(4 here).
i will try with v6 and send the trace asap.

>
> [...]
>
> It would be worth a comment here explaining which resources the channel
> PMUs share, and why we need this thunderx2_pmu_uncore_dev. IIUC, it's
> just that they share a register windows switched by FW?
>
>> +struct thunderx2_pmu_uncore_dev {
>> +     char *name;
>> +     struct device *dev;
>> +     enum thunderx2_uncore_type type;
>> +     void __iomem *base;
>> +     int node;
>> +     u32    max_counters;
>> +     u32    max_channels;
>> +     u32    max_events;
>> +     u64 hrtimer_interval;
>> +     /* this lock synchronizes across channels */
>> +     raw_spinlock_t lock;
>> +     const struct attribute_group **attr_groups;
>> +     void    (*init_cntr_base)(struct perf_event *event,
>> +                     struct thunderx2_pmu_uncore_dev *uncore_dev);
>> +     void    (*select_channel)(struct perf_event *event);
>> +     void    (*stop_event)(struct perf_event *event);
>> +     void    (*start_event)(struct perf_event *event, int flags);
>> +};
>
> As a general thing, the really long structure/enum/macro names make
> things really hard to read.
>
> Could we s/THUNDERX2/TX2/ and s/thunderx2/tx2/ for identifiers please?

thanks, will do.
>
> Similarly:
>
> * s/thunderx2_pmu_uncore_channel/tx2_pmu/
>
> * s/thunderx2_pmu_uncore_dev/tx2_pmu_group/
>
> ... and consistently name those "pmu" and "pmu_group" respectively --
> that mekas the relationship between the two much clearer for someone who
> is not intimately familiar with the hardware.

These PMUs(UNCORE) counters makes only sense to someone who is
familiar with the hardware.
IMHO,  the current names aligned to hardware design like channels ,
tiles, counter etc,
which is explained in PATCH1/2.

I will try to simplify long names.

>
> That makes things far more legible, e.g.
>
>> +static inline struct thunderx2_pmu_uncore_channel *
>> +pmu_to_thunderx2_pmu_uncore(struct pmu *pmu)
>> +{
>> +     return container_of(pmu, struct thunderx2_pmu_uncore_channel, pmu);
>> +}
>
> ... becomes:
>
> static struct tx2_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
> {
>         return container_of(pmu, struct tx2_pmu, pmu);
> }
>
> [...]
>
>> +/*
>> + * sysfs cpumask attributes
>> + */
>> +static ssize_t cpumask_show(struct device *dev,
>> +                             struct device_attribute *attr, char *buf)
>> +{
>> +     struct cpumask cpu_mask;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
>> +             pmu_to_thunderx2_pmu_uncore(dev_get_drvdata(dev));
>> +
>> +     cpumask_clear(&cpu_mask);
>> +     cpumask_set_cpu(pmu_uncore->cpu, &cpu_mask);
>> +     return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
>> +}
>> +static DEVICE_ATTR_RO(cpumask);
>
> This can be simplified to:
>
> static ssize_t cpumask_show(struct device *dev, struct device_attribute
>                             *attr, char *buf)
> {
>         struct thunderx2_pmu_uncore_channel *pmu_uncore;
>         pmu_uncore = pmu_to_thunderx2_pmu_uncore(dev_get_drvdata(dev));
>
>         return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu_uncore->cpu));
> }

thanks, will do
>
> [...]
>
>> +static int alloc_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore)
>> +{
>> +     int counter;
>> +
>> +     raw_spin_lock(&pmu_uncore->lock);
>> +     counter = find_first_zero_bit(pmu_uncore->active_counters,
>> +                             pmu_uncore->uncore_dev->max_counters);
>> +     if (counter == pmu_uncore->uncore_dev->max_counters) {
>> +             raw_spin_unlock(&pmu_uncore->lock);
>> +             return -ENOSPC;
>> +     }
>> +     set_bit(counter, pmu_uncore->active_counters);
>> +     raw_spin_unlock(&pmu_uncore->lock);
>> +     return counter;
>> +}
>> +
>> +static void free_counter(
>> +             struct thunderx2_pmu_uncore_channel *pmu_uncore, int counter)
>> +{
>> +     raw_spin_lock(&pmu_uncore->lock);
>> +     clear_bit(counter, pmu_uncore->active_counters);
>> +     raw_spin_unlock(&pmu_uncore->lock);
>> +}
>
> As above, I still don't believe that these locks are necessary, unless
> we have a bug elsewhere.

i will try to debug and provide you more info.

>
> [...]
>
>> +/*
>> + * DMC and L3 counter interface is muxed across all channels.
>> + * hence we need to select the channel before accessing counter
>> + * data/control registers.
>> + *
>> + *  L3 Tile and DMC channel selection is through SMC call
>> + *  SMC call arguments,
>> + *   x0 = THUNDERX2_SMC_CALL_ID      (Vendor SMC call Id)
>> + *   x1 = THUNDERX2_SMC_SET_CHANNEL  (Id to set DMC/L3C channel)
>> + *   x2 = Node id
>> + *   x3 = DMC(1)/L3C(0)
>> + *   x4 = channel Id
>> + */
>
> Please document which ID space the node id is in, e.g.
>
>         x2 = FW Node ID (matching SRAT/SLIT IDs)
>
> ... so that it's clear that this isn't a Linux logical node id, even if
> those happen to be the same today.

sure.
>
> [...]
>
>> +static void thunderx2_uncore_start(struct perf_event *event, int flags)
>> +{
>> +     struct hw_perf_event *hwc = &event->hw;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>> +     unsigned long irqflags;
>> +
>> +     hwc->state = 0;
>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
>> +     uncore_dev = pmu_uncore->uncore_dev;
>> +
>> +     raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
>> +     uncore_dev->select_channel(event);
>> +     uncore_dev->start_event(event, flags);
>> +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
>> +     perf_event_update_userpage(event);
>> +
>> +     if (!find_last_bit(pmu_uncore->active_counters,
>> +                             pmu_uncore->uncore_dev->max_counters)) {
>
> This would be clearer using !bitmap_empty().

thanks.
>
>> +             hrtimer_start(&pmu_uncore->hrtimer,
>> +                     ns_to_ktime(uncore_dev->hrtimer_interval),
>> +                     HRTIMER_MODE_REL_PINNED);
>> +     }
>> +}
>
> [...]
>
>> +static enum hrtimer_restart thunderx2_uncore_hrtimer_callback(
>> +             struct hrtimer *hrt)
>
> s/hrt/timer/ please

sure, thanks.
>
>> +{
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>> +     unsigned long irqflags;
>> +     int idx;
>> +     bool restart_timer = false;
>> +
>> +     pmu_uncore = container_of(hrt, struct thunderx2_pmu_uncore_channel,
>> +                     hrtimer);
>> +
>> +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
>> +     for_each_set_bit(idx, pmu_uncore->active_counters,
>> +                     pmu_uncore->uncore_dev->max_counters) {
>> +             struct perf_event *event = pmu_uncore->events[idx];
>> +
>> +             thunderx2_uncore_update(event);
>> +             restart_timer = true;
>> +     }
>> +     raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
>> +
>> +     if (restart_timer)
>> +             hrtimer_forward_now(hrt,
>> +                     ns_to_ktime(
>> +                             pmu_uncore->uncore_dev->hrtimer_interval));
>> +
>> +     return restart_timer ? HRTIMER_RESTART : HRTIMER_NORESTART;
>> +}
>
> You don't need to take the lock at all if there are no active events,
> and we can avoid all the conditional logic that way. e.g. assuming the
> renames I requested above:
>
> static enum hrtimer_restart tx2_hrtimer_callback(struct hrtimer *timer)
>
> {
>         struct tx2_pmu *pmu;
>         struct tx2_pmu_group *pmu_group;
>         unsigned long irqflags;
>         int max_counters;
>         int idx;
>
>         pmu = container_of(timer, struct tx2_pmu, hrtimer);
>         pmu_group = pmu->pmu_group;
>         max_counters = pmu_group->max_counters;
>
>         if (cpumask_empty(pmu->active_counters, max_counters))
>                 return HRTIMER_NORESTART;
>
>         raw_spin_lock_irqsave(&pmu_group->lock, irqflags);
>         for_each_set_bit(idx, pmu->active_counters, max_counters) {
>                 struct perf_event *event = pmu->events[idx];
>
>                 tx2_uncore_update(event);
>                 restart_timer = true;
>         }
>         raw_spin_unlock_irqrestore(&pmu_group->lock, irqflags);
>
>         hrtimer_forward_now(hrt, ns_to_ktime(pmu_group->hrtimer_interval));
>
>         return HRTIMER_RESTART;
> }

thanks, i will adopt this function.
>
> [...]
>
>> +     switch (uncore_dev->type) {
>> +     case PMU_TYPE_L3C:
>> +             uncore_dev->max_counters = UNCORE_MAX_COUNTERS;
>> +             uncore_dev->max_channels = UNCORE_L3_MAX_TILES;
>> +             uncore_dev->max_events = L3_EVENT_MAX;
>> +             uncore_dev->hrtimer_interval = UNCORE_HRTIMER_INTERVAL;
>> +             uncore_dev->attr_groups = l3c_pmu_attr_groups;
>> +             uncore_dev->name = devm_kasprintf(dev, GFP_KERNEL,
>> +                             "uncore_l3c_%d", uncore_dev->node);
>> +             uncore_dev->init_cntr_base = init_cntr_base_l3c;
>> +             uncore_dev->start_event = uncore_start_event_l3c;
>> +             uncore_dev->stop_event = uncore_stop_event_l3c;
>> +             uncore_dev->select_channel = uncore_select_channel;
>> +             break;
>> +     case PMU_TYPE_DMC:
>> +             uncore_dev->max_counters = UNCORE_MAX_COUNTERS;
>> +             uncore_dev->max_channels = UNCORE_DMC_MAX_CHANNELS;
>> +             uncore_dev->max_events = DMC_EVENT_MAX;
>> +             uncore_dev->hrtimer_interval = UNCORE_HRTIMER_INTERVAL;
>> +             uncore_dev->attr_groups = dmc_pmu_attr_groups;
>> +             uncore_dev->name = devm_kasprintf(dev, GFP_KERNEL,
>> +                             "uncore_dmc_%d", uncore_dev->node);
>> +             uncore_dev->init_cntr_base = init_cntr_base_dmc;
>> +             uncore_dev->start_event = uncore_start_event_dmc;
>> +             uncore_dev->stop_event = uncore_stop_event_dmc;
>> +             uncore_dev->select_channel = uncore_select_channel;
>> +             break;
>
> We should probably s/uncore/tx2/, or s/uncore/thunderx2/ to namespace
> this.

ok, i would preffer tx2.
>
>> +static int thunderx2_uncore_pmu_offline_cpu(unsigned int cpu,
>> +             struct hlist_node *node)
>> +{
>> +     int new_cpu;
>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>> +
>> +     pmu_uncore = hlist_entry_safe(node,
>> +                     struct thunderx2_pmu_uncore_channel, node);
>> +     if (cpu != pmu_uncore->cpu)
>> +             return 0;
>> +
>> +     new_cpu = cpumask_any_and(
>> +                     cpumask_of_node(pmu_uncore->uncore_dev->node),
>> +                     cpu_online_mask);
>> +     if (new_cpu >= nr_cpu_ids)
>> +             return 0;
>> +
>> +     pmu_uncore->cpu = new_cpu;
>> +     perf_pmu_migrate_context(&pmu_uncore->pmu, cpu, new_cpu);
>> +     return 0;
>> +}
>
> We'll also need a onlining callback. Consider if all CPUs in a NUMA node
> were offlined, then we tried to online an arbitrary CPU from that node.

sure, will add.
>
> Thanks,
> Mark.

thanks
Ganapat
