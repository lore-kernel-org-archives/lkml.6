Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09405C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B844A218AE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRRpSglB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfAGSSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:18:38 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39304 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfAGSSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:18:38 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so2386122itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxw6QECnCvTAvs5kU3NNTPi9ZNF4vcF7NHfnLqC0pLA=;
        b=jRRpSglBOQfSA+wNIspyJGkrnUOXkURlyu/papImoKBigH1S5kz57IiaatkcPUhEZr
         h5tIL5AsHbF/5B0RAmvi9kn44hOfESG9XJe60nNO5vvPltSH3Fvmhj4i9RykFxum9zTi
         pxRxwZsqAQsmNAuym172FSCJadI8o1sYhjvE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxw6QECnCvTAvs5kU3NNTPi9ZNF4vcF7NHfnLqC0pLA=;
        b=M//3EqUn6DP8D0OEZsgJfTovrP1EalzLb1+BvdaVhhK2kDMZOM3AhKAvlYmFaK3THw
         mtT3TyH4y70KehW8UjnJgkkh6n/RxmKVGNMca8TTRrBWYPsiaIrDiK9JMrGByctmytyC
         gi+eGcO2gcDd3TtcIZJLpTJxGOlntSyRc80gBZfVjJh7rpogaDZy+FbC7WJsKHwoR6zD
         Qu8Aja0jIzByZoRM6UYYUtFXOGkH2ApzkkwRXpWAxGT9Ca/PB1DajGVvxE/MnWw3atRa
         OSKfBGYCWEFgFFij4puiNiyCrZvW52z17oWQbhEP6Y1ER74YBtPFN5r32Wqye4yBR99d
         qXDQ==
X-Gm-Message-State: AJcUukeHnsAkrWOymHcjnHeykAhOmpsO0Ks7CT4S3KwfY1tKag7vDQkA
        qBDV7MQvHNJpHapXjsWTItsvYUPMDffn5dGvbGO1NQ==
X-Google-Smtp-Source: ALg8bN6K9k3G4AJO/6n+xDifm5UZz65OFBtP4U/DAiT0j4/uxLesueqnPNeykrFBfAXhyYY3tgVBmDqCgWalzYd11Ac=
X-Received: by 2002:a24:db02:: with SMTP id c2mr8326085itg.137.1546885116707;
 Mon, 07 Jan 2019 10:18:36 -0800 (PST)
MIME-Version: 1.0
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com> <CANLsYkyvq-K1M7jZ=rOEcGBySTktV_c7D4S2jBV_nS3cj8a8wg@mail.gmail.com>
 <bb313a2d-b5fc-9329-5db6-4bf661d278bb@arm.com>
In-Reply-To: <bb313a2d-b5fc-9329-5db6-4bf661d278bb@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 7 Jan 2019 11:18:25 -0700
Message-ID: <CANLsYkx_-QHs=3syOXrazU_nA2x-QT9VjvzWubGjVGtz_01dAQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 02:40, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 18/12/2018 17:34, Mathieu Poirier wrote:
> > Good day Suzuki,
> >
> > On Tue, 18 Dec 2018 at 07:14, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> Hi Mathieu,
> >>
> >> On 17/12/2018 17:21, Mathieu Poirier wrote:
> >>> This patch uses the PMU driver configuration held in event::hw::drv_config
> >>> to select a sink for each event that is created (the old sysFS way of
> >>> working is kept around for backward compatibility).
> >>>
> >>> By proceeding in this way a sink can be used by multiple sessions
> >>> without having to play games with entries in sysFS.
> >>>
> >>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> ---
> >>>    drivers/hwtracing/coresight/coresight-etm-perf.c | 74 ++++++++++++++++++++----
> >>>    1 file changed, 62 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >>> index f21eb28b6782..a7e1fdef07f2 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >>> @@ -4,6 +4,7 @@
> >>>     * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>>     */
> >>>
> >>> +#include <linux/amba/bus.h>
> >>>    #include <linux/coresight.h>
> >>>    #include <linux/coresight-pmu.h>
> >>>    #include <linux/cpumask.h>
> >>> @@ -11,6 +12,7 @@
> >>>    #include <linux/list.h>
> >>>    #include <linux/mm.h>
> >>>    #include <linux/init.h>
> >>> +#include <linux/ioport.h>
> >>>    #include <linux/perf_event.h>
> >>>    #include <linux/percpu-defs.h>
> >>>    #include <linux/slab.h>
> >>> @@ -177,6 +179,26 @@ static void etm_free_aux(void *data)
> >>>        schedule_work(&event_data->work);
> >>>    }
> >>>
> >>> +static struct coresight_device *etm_drv_config_sync(struct perf_event *event)
> >>
> >> minor nit: The name doesn't quite imply what we do here. Did you mean
> >> s/sync/sink ?
> >>
> >
> > I chose "sync" with "synchronisation" in mind.  I tried to keep things
> > generic since we could potentially use the same interface to convey
> > complex PMU configuration.  Arguably we could go with "sink" for now
> > and change it to "sync" in the future - I'm not strongly opinionated
> > on that part.
>
> Ok. I thought we were trying to grab the sink information from the event
> drv_config, hence something that implies that would be slightly more
> reader friendly. Again, I am not too keen on it.
>
> >
> >>> +{
> >>> +     struct coresight_device *sink = NULL;
> >>> +     struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
> >>> +
> >>> +     /*
> >>> +      * Make sure we don't race with perf_drv_config_replace() in
> >>> +      * kernel/events/core.c.
> >>> +      */
> >>> +     raw_spin_lock(&drv_config->lock);
> >>> +
> >>> +     /* Copy what we got from user space if applicable. */
> >>> +     if (drv_config->config)
> >>> +             sink = drv_config->config;
> >>> +
> >>> +     raw_spin_unlock(&drv_config->lock);
> >>> +
> >>> +     return sink;
> >>> +}
> >>> +
> >>>    static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>>                           int nr_pages, bool overwrite)
> >>>    {
> >>> @@ -190,18 +212,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>>                return NULL;
> >>>        INIT_WORK(&event_data->work, free_event_data);
> >>>
> >>> -     /*
> >>> -      * In theory nothing prevent tracers in a trace session from being
> >>> -      * associated with different sinks, nor having a sink per tracer.  But
> >>> -      * until we have HW with this kind of topology we need to assume tracers
> >>> -      * in a trace session are using the same sink.  Therefore go through
> >>> -      * the coresight bus and pick the first enabled sink.
> >>> -      *
> >>> -      * When operated from sysFS users are responsible to enable the sink
> >>> -      * while from perf, the perf tools will do it based on the choice made
> >>> -      * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
> >>> -      */
> >>> -     sink = coresight_get_enabled_sink(true);
> >>> +     /* First get the sink config from user space. */
> >>> +     sink = etm_drv_config_sync(event);
> >>> +     if (!sink)
> >>> +             sink = coresight_get_enabled_sink(true);
> >>> +
> >>>        if (!sink || !sink_ops(sink)->alloc_buffer)
> >>>                goto err;
> >>>
> >>> @@ -454,6 +469,40 @@ static void etm_addr_filters_sync(struct perf_event *event)
> >>>        filters->nr_filters = i;
> >>>    }
> >>>
> >>> +static int etm_drv_config_find_sink(struct device *dev, void *data)
> >>> +{
> >>> +     struct amba_device *adev = to_amba_device(dev->parent);
> >>> +     struct resource *res = &adev->res;
> >>> +     u64 value = *((u64 *)data);
> >>> +
> >>> +     /*
> >>> +      * The HW mapping of a component is unique.  If the value we've been
> >>> +      * given matches the component's start address, then we must have found
> >>> +      * the device we are looking for.
> >>> +      */
> >>
> >> To be frank, I don't quite like the idea of passing the base address of the
> >> component as the key to locate a device, (even though that is unique and readily
> >> available). I would rather prefer a programmable way to map the keys to the
> >> "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
> >> address is not obvious from the name). Also if we decide to use a platform
> >> agnostic naming scheme, it becomes even more complex.
> >
> > This mechanism doesn't rely on the naming scheme - it exploits the
> > "resource" interface exported for each amba device [1].  As such
> > whether the component is discovered using ACPI or DT, we end up on the
> > same amba bus and using the same interface.
> >
> > [1]. https://elixir.bootlin.com/linux/latest/source/drivers/amba/bus.c#L128
>
> Ok. The only problem with this approach would be if the devices doesn't appear
> on the AMBA bus (btw, which is not true for the existing IPs).

This is news to me and definitely requires further attention.  I'd
rather come up with a design that account for those right away than
overhaul the whole thing in a year from now.

>
> >
> >>
> >> We could assign a static "id/key" exported either via the device sysfs dir or
> >> the "pmu" dir. I prefer the latter.
> >
> > Not sure what you mean by "pmu" directory - would you mind expanding
> > on that?  Using sysfs would be quite easy but I am reluctant to create
> > a new id/key mechanism and introduce another entry when we have the
> > component address that is unique and already available in the amba
> > directory structure.
>
> We could add another directory under :
>
> /sys/bus/event_source/devices/<PMU>/
>                                 \_ events/
>                                 \_ format/
> say :
>                 \_ drv_config/
>                 Or
>                 \_ sinks/
>
> and list the sinks, eg:
> # cd $sysfs_pmu_dir/sinks
> # cat <name_of_the_sink>
> ID_of_the_sink

There is merit to this idea.  Thinking along those lines simply using
"sinks" is probably a better approach since we don't yet know how PMU
configuration will unfold.  I'm also wondering if we have to
explicitly list the ID of the sink.  The ID itself should be fetch
from the device specific entries in sysfs like the "resource" property
of sinks that show up on the AMBA bus.  Sinks that don't show up on
the AMBA bus will likely have a "reg" property of something similar
and that is where the ID should be taken from.

Lastly it may be tricky to add a new directory structure to the PMU
entry as it is generic for all PMUs in the system.  But that is up for
investigation and I will look into doing something like that.

>
> Btw, I am always inclined to using some bits off one of the "config" fields
> ("config1" or "config2") for the sink configuration. But I understand that
> you have explored that avenue and chose this approach as we have further
> configurations required for complex ETM settings.

I've had a good conversation with myself over the holidays on that
topic (hence the late-ish reply).  My original approach was to use the
same ioctl() mechanism to do sink selection and complex PMU
configuration.  But as Greg confirmed with his comment on the previous
patch doing so requires to iron out how the latter will be done on ARM
(and probably on Intel too), something that is a different deal
altogether.

Taking a step back and forgetting about complex PMU configuration for
a minute, the ID of a sink can easily be stuffed in one of the
"config" fields of the perf_event_attr structure, something I alluded
to in the patchset's cover letter.  That way we can move along with
this feature and leave the discussion on complex PMU configuration for
another day.

I'll do a respin with the above in mind.

A happy new year to you,
Mathieu

>
> Cheers
> Suzuki
