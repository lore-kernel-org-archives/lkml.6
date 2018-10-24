Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B4CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E372064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kn0l5u+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E372064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeJYEAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:00:25 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38524 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeJYEAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:00:25 -0400
Received: by mail-vk1-f196.google.com with SMTP id j20so1558061vke.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuL8CGpFwsnazJUuWRI8sA6By+ZuS8XUG+87qvwunJ4=;
        b=kn0l5u+5cMwyi4hCEbEIYzS+uBRdpVydyCiPQK7KfFqWufro+Anoj2qTN6uvcuP9Eu
         6paDkwKDV9lVQPrpKqcFfpTNkuhZ5962WGGQKGBEHFm7jefl4t6lVToHyDtFZWjZ06TH
         kreK3+K4RvbTryyr2F8/TmC9uGm4v0Ow2o+BRH//Hhcqd5WB5lsy8Y0Vk3xTiSdV4P81
         kxYLKbB+gOKE42f8To7OaS3M2+Z7hHNt4TtedQ84B2daGuwbDsJ/LmqGWP4ZlpziYBRK
         lv+wZh06GBOT+4yGxP9eTH85bIJCoJpI5jfVOdKs/VBTj4XJk1ZdmqmlwVJUTMLR5XuO
         IVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuL8CGpFwsnazJUuWRI8sA6By+ZuS8XUG+87qvwunJ4=;
        b=Yu/Hjh7XD3llNjDhk7600NfJOsnoiITS8P5L1Sib09VVlnOIlQCuV/IK37pejGciRw
         UcMAm/C6otIuabKfoc03EWn7tNfFLnl9J5n943+3IIsGuDC93XkrXpj+ogweFlUVJjSV
         hKdwA4lPWrZ/+IlsX3Q8iz7j+o1wXdUN5NdQ9odAPV2TyeXr7NGFF80sbOQT6hcaispR
         Dv56vwQl97gZ4NItUZS3SCnV3NUutFNukzgqzD32jrMQDKBCwaVjSmyc2p6hYyjGb6K/
         cFYkEFEM4ZuGW3wTGRSUbH4tI6rt8qCVoRWFo/sLfUJKYtTBIG5mZpEuRDi8H2VzU9wU
         PtEg==
X-Gm-Message-State: AGRZ1gILaq7BUbeQeGt75mJ8PCKCk/ttlw9nyF6jM4r2IMLp5CJa4VSp
        pxcaE4doTxseqPrLTTgc6uIqnNjtYLZT9CbJsmEjkA==
X-Google-Smtp-Source: AJdET5c+fVoXGmKpIf2Y8bLx5I3eaA5GeCQr7DCZG8u+wtSNUr5EmuYPONI+Cz+EtL+vRRYfyu/nK6KexJQk3YC4bmI=
X-Received: by 2002:a1f:ad0e:: with SMTP id w14mr1704480vke.36.1540409464073;
 Wed, 24 Oct 2018 12:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
In-Reply-To: <20181024151116.30935-1-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 24 Oct 2018 12:30:52 -0700
Message-ID: <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Add munmap callback
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 24, 2018 at 8:12 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> To calculate the physical address, perf needs to walk the pages tables.
> The related mapping may has already been removed from pages table in
> some cases (e.g. large PEBS). The virtual address recorded in the first
> PEBS records may already be unmapped before draining PEBS buffers.
>
> Add a munmap callback to notify the PMU of any unmapping, which only be
> invoked when the munmap is implemented.
>
The need for this new record type extends beyond physical address conversions
and PEBS. A long while ago, someone reported issues with symbolization related
to perf lacking munmap tracking. It had to do with vma merging. I think the
sequence of mmaps was as follows in the problematic case:
1.   addr1 = mmap(8192);
2.   munmap(addr1 + 4096, 4096)
3.   addr2 = mmap(addr1+4096, 4096)

If successful, that yields addr2 = addr1 + 4096 (could also get the
same without forcing the address).

In that case, if I recall correctly, the vma for 1st mapping (now at
4k) and that of the 2nd mapping (4k)
get merged into a single 8k vma and this is what perf_events will
record for PERF_RECORD_MMAP.
On the perf tool side, it is assumed that if two timestamped mappings
overlap then, the latter overrides
the former. In this case, perf would loose the mapping of the first
4kb and assume all symbols comes from
2nd mapping. Hopefully I got the scenario right. If so, then you'd
need PERF_RECORD_UNMAP to
disambiguate assuming the perf tool is modified accordingly.


>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h |  3 +++
>  kernel/events/core.c       | 25 +++++++++++++++++++++++++
>  mm/mmap.c                  |  1 +
>  3 files changed, 29 insertions(+)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f0ca79..7f0a9258ce1f 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -400,6 +400,7 @@ struct pmu {
>          */
>         void (*sched_task)              (struct perf_event_context *ctx,
>                                         bool sched_in);
> +       void (*munmap)                  (void);
>         /*
>          * PMU specific data size
>          */
> @@ -1113,6 +1114,7 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
>  }
>
>  extern void perf_event_mmap(struct vm_area_struct *vma);
> +extern void perf_event_munmap(void);
>  extern struct perf_guest_info_callbacks *perf_guest_cbs;
>  extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
>  extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
> @@ -1333,6 +1335,7 @@ static inline int perf_unregister_guest_info_callbacks
>  (struct perf_guest_info_callbacks *callbacks)                          { return 0; }
>
>  static inline void perf_event_mmap(struct vm_area_struct *vma)         { }
> +static inline void perf_event_munmap(void)                             { }
>  static inline void perf_event_exec(void)                               { }
>  static inline void perf_event_comm(struct task_struct *tsk, bool exec) { }
>  static inline void perf_event_namespaces(struct task_struct *tsk)      { }
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5a97f34bc14c..00338d6fbed7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3184,6 +3184,31 @@ static void perf_pmu_sched_task(struct task_struct *prev,
>         }
>  }
>
> +void perf_event_munmap(void)
> +{
> +       struct perf_cpu_context *cpuctx;
> +       unsigned long flags;
> +       struct pmu *pmu;
> +
> +       local_irq_save(flags);
> +       list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
> +               pmu = cpuctx->ctx.pmu;
> +
> +               if (!pmu->munmap)
> +                       continue;
> +
> +               perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +               perf_pmu_disable(pmu);
> +
> +               pmu->munmap();
> +
> +               perf_pmu_enable(pmu);
> +
> +               perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> +       }
> +       local_irq_restore(flags);
> +}
> +
>  static void perf_event_switch(struct task_struct *task,
>                               struct task_struct *next_prev, bool sched_in);
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5f2b2b184c60..61978ad8c480 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2777,6 +2777,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>         /*
>          * Remove the vma's, and unmap the actual pages
>          */
> +       perf_event_munmap();
>         detach_vmas_to_be_unmapped(mm, vma, prev, end);
>         unmap_region(mm, vma, prev, start, end);
>
> --
> 2.17.1
>
