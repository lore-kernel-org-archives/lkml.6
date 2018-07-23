Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2191ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9990820856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnItEYQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9990820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbeGWRw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:52:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35829 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeGWRw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:52:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id e6-v6so1549724edr.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cC5je/F+uSaVL7z1BwmWdg7KB6BjMMJtr7cq9Gw3FM4=;
        b=cnItEYQm4YkT9+zd5KnMCwmLfF9+z/7TZDv12zWhyoiNDUviYA8cV0zXpQANVhpcSx
         c93DYAlCSxdQwP5iRSr9dz/2YG1Tmj7Wr8lE4HJqO9f+DRMchGJn30kMMvthNahnSn4b
         2VJuya1n6x+NJydllMM0wHF7LIgak4SnCDe4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cC5je/F+uSaVL7z1BwmWdg7KB6BjMMJtr7cq9Gw3FM4=;
        b=LW4FTw3xc28VG0UaEoACS0cBrrCABVyKZonoGE5I+zyn3dwDb2zAQPCskzZMiwEb8G
         iF7wyFY74avfqE2IMRSTqssZlsKJW5QjIgB4NuTwC1Z4oKJZRwPNAhoAucEScUW7fLN/
         ukPbbA98Gs8Jfsf0rwF1ufmOLUC4kQGvlbRV8V9osJhhA9QnIBQZok0IStRzYHMgiukX
         DSL8Ck8Zfp6am49HUZFhGNx7y8iHWQyNvKpzzvlQR3M9EakzuGwDeXgOB68BFe7mpVWi
         +g5jSDijwHTicsyE8SBcRwiYKvfYJZIpvb929738ksnK1JDTREqy2Ui0WiRiwM41SLYY
         eXQA==
X-Gm-Message-State: AOUpUlGEd2TDgNKuq/w3uYewNbpaJ8ui/8w5N3SVwoZecHZ6SK6GoLaD
        W9lMfoeLbC+RZeleWBeI3+dtbwujVibiU4YDL94bwA==
X-Google-Smtp-Source: AAOMgpd3mqvHM7/zpQ5mygV7MZ00dD4N21xmA58DumiKtNpjed78XJmvOXQFEGZc8psa75jPf3bTUctPZLrjswILNpM=
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr15362811edk.12.1532364652233;
 Mon, 23 Jul 2018 09:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-9-git-send-email-suzuki.poulose@arm.com>
 <20180719200739.GB9421@xps15> <ed621d62-a1d2-abe1-3763-60ea6e5f615f@arm.com>
In-Reply-To: <ed621d62-a1d2-abe1-3763-60ea6e5f615f@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 23 Jul 2018 10:50:41 -0600
Message-ID: <CANLsYkyX0AtVQHG4sCMS2uVZR83hFQYKzyBK_RHYAtS+OnyqPg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] coresight: perf: Add helper to retrieve sink configuration
To:     "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 02:43, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>
> On 19/07/18 21:07, Mathieu Poirier wrote:
> > On Tue, Jul 17, 2018 at 06:11:39PM +0100, Suzuki K Poulose wrote:
> >> We can always find the sink configuration for a given perf_output_handle.
> >> Add a helper to retrieve the sink configuration for a given
> >> perf_output_handle. This will be used to get rid of the set_buffer()
> >> call back.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-etm-perf.c | 14 -------------
> >>   drivers/hwtracing/coresight/coresight-etm-perf.h | 26 ++++++++++++++++++++++++
> >>   2 files changed, 26 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> index 6a4252b..3cc4a0b 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> @@ -23,20 +23,6 @@
> >>   static struct pmu etm_pmu;
> >>   static bool etm_perf_up;
> >>
> >> -/**
> >> - * struct etm_event_data - Coresight specifics associated to an event
> >> - * @work:           Handle to free allocated memory outside IRQ context.
> >> - * @mask:           Hold the CPU(s) this event was set for.
> >> - * @snk_config:             The sink configuration.
> >> - * @path:           An array of path, each slot for one CPU.
> >> - */
> >> -struct etm_event_data {
> >> -    struct work_struct work;
> >> -    cpumask_t mask;
> >> -    void *snk_config;
> >> -    struct list_head * __percpu *path;
> >> -};
> >> -
> >
> > If this is moved to coresight-etm-perf.h, the #include <linux/percpu-defs.h> can
> > be removed.
>
> Actually, we do have the PER_CPU variables in the file already, which is why I left
> them there.  See the next line.

Of course...

> >
> >>   static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
> >>   static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
> >>
>
>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> >> index 4197df4..da7d933 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> >> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> >> @@ -7,6 +7,7 @@
> >>   #ifndef _CORESIGHT_ETM_PERF_H
> >>   #define _CORESIGHT_ETM_PERF_H
> >>
> >> +#include <linux/percpu-defs.h>
> >>   #include "coresight-priv.h"
> >>
> >>   struct coresight_device;
> >> @@ -42,14 +43,39 @@ struct etm_filters {
> >>      bool                    ssstatus;
> >>   };
> >>
> >> +/**
> >> + * struct etm_event_data - Coresight specifics associated to an event
> >> + * @work:           Handle to free allocated memory outside IRQ context.
> >> + * @mask:           Hold the CPU(s) this event was set for.
> >> + * @snk_config:             The sink configuration.
> >> + * @path:           An array of path, each slot for one CPU.
> >> + */
> >> +struct etm_event_data {
> >> +    struct work_struct work;
> >> +    cpumask_t mask;
> >> +    void *snk_config;
> >> +    struct list_head * __percpu *path;
> >> +};
> >>
> >>   #ifdef CONFIG_CORESIGHT
> >>   int etm_perf_symlink(struct coresight_device *csdev, bool link);
> >> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> >> +{
> >> +    struct etm_event_data *data = perf_get_aux(handle);
> >>
> >> +    if (data)
> >> +            return data->snk_config;
> >> +    return NULL;
> >> +}
> >>   #else
> >>   static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
> >>   { return -EINVAL; }
> >>
> >> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> >> +{
> >> +    return NULL;
> >> +}
> >> +
> >
> > I think we can do without those... See my comment in the next patch.
>
> Sure
