Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA5AC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E5221476
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbQSSeTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E5221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeHJWzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:55:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40849 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeHJWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:55:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so3087889wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkCvBPbmxSZLgENZUPap29UpRfquc4dn+aYYJem97LU=;
        b=ZbQSSeTI+J2lpddToQ0ABkW2JSN9vJQRE5nss/lxnarR9M3Q4Jyw3xPZ4KXY3G8JOQ
         yNGt9XycxqBcvEFsQK6gwPKi0QEYUo6Gnz/6oaHVJ5toJkX8NtOjJ4bdd2bZhftft1h4
         SglPHlosdwNZ3TVdi8g4W7SfsVPQSmqQBovTpQmZ8H9oy+MHz7PzuT5WBjZlMCNCSenR
         r8DzV3AVH83KeUj2JhtcIPBQFHOcaP8IWibcnU9o6mXuQbJtTVyZbzo/Ij7eH/jf1+Kh
         tVn0QPulR0MuoJnp5C/BoIQdXtP/eGZjELPqjnF9fJ9WRbb4kJbfDjb6KFthRwQrktIN
         gTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkCvBPbmxSZLgENZUPap29UpRfquc4dn+aYYJem97LU=;
        b=gfDyNAwfKgKAWTUgEJkEior5lCXLFRBHPK76xBA2EDNo5LYwbpW3iw1yACXmJZjQXe
         WywlhhGvop+xXSXq7RXSjQYQ0UW9FiLYz/y1awLLj6h0aoZQ1eYkpHYr4k0w6MVwGNJQ
         tfLiEmp/+juUzdIP9UAfX52DybRdHmAQOl/bawuBN8BdKKfj1iFmY9hyZxRM4aeleMqz
         uXTbCyZN4X6PJXLFa6I8oIkLGgVu18vvN5/K2B9xwTpPlHhMGcROjk5x0luPuRQQc4xV
         CqlItQRlYoiMQGw6L9gpjKzHEy8y2juz2JYnNhbgbvPXMWgSNv1cpKhVls2lVw6BgZRn
         YrRA==
X-Gm-Message-State: AOUpUlFNzMXyAze3I3qyVnYsAGiK1ofNCvqJR+kz9R7ax3q3GLLyoP7w
        xx3WYv0+2HPDX711XUCgAtC9aLOyiNTO0Vf+i0I3Fw==
X-Google-Smtp-Source: AA+uWPxbBFLFlwHx3O3fNkK2RigPNEhWevvyv2PzCE87mctiyfx85v1ASUTvOOroHN2v+xsKn/dmtpaC+4xXo6CNHqk=
X-Received: by 2002:a1c:9f86:: with SMTP id i128-v6mr2207428wme.156.1533932663782;
 Fri, 10 Aug 2018 13:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 10 Aug 2018 13:24:12 -0700
Message-ID: <CABPqkBQhSywqYTxh0fmf0wsDd3fY8GLe1xp=Xb+-OJD-de81_Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/7] perf/core, x86: Add PERF_SAMPLE_PAGE_SIZE
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 6:37 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Current perf can report both virtual address and physical address, but
> it doesn't report page size. Users have no idea how large the utilized
> page is. They cannot promote/demote large pages to optimize memory use.
>
> Add a new sample type for page size.
>
> Current perf already has a facility to collect data virtual address.
> A function, to retrieve page size by full page-table walk of a given
> virtual address, is introduced for x86. Other architectures can
> implement their own functions later separately.
> The function must be IRQ-safe. For x86, disabling IRQs over the walk is
> sufficient to prevent any tear down of the page tables.
>
> The new sample type requires collecting the virtual address. The
> virtual address will not be output unless SAMPLE_ADDR is applied.
>
I welcome this feature, been wanting it for some time now. There is
simply not enough support in /proc/PID/maps or smaps to get this
information. This is important to improve code and data layouts.

I would like to see the following changes to your proposal:
   - call it PERF_SAMPLE_DATA_PAGE_SIZE

That would allow two things:
   1 - not tied to PERF_SAMPLE_ADDR
   2 - Allow PERF_SAMPLE_CODE_PAGE_SIZE to be added

In some measurements, you may just care about the distribution of accesses
across page sizes. No need to use double the buffer space to save the address
you will not use.

Layout is important for code as well, in fact, that's what most people
want first.
Having a CODE_PAGE_SIZE is therefore useful. I am happy adding it on top on your
proposal. Note that PERF_SAMPLE_CODE_PAGE_SIZE would not have to be tied
to PEBS unlike DATA_PAGE_SIZE.

Thanks.

> Although only a few bits are needed to indicate the page size, a u64
> type is still claimed for page_size. Because struct perf_sample_data
> requires cacheline_aligned.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/core.c          | 25 +++++++++++++++++++++++++
>  arch/x86/events/intel/ds.c      |  2 +-
>  arch/x86/events/perf_event.h    |  2 +-
>  include/linux/perf_event.h      |  1 +
>  include/uapi/linux/perf_event.h | 13 ++++++++++++-
>  kernel/events/core.c            | 15 +++++++++++++++
>  6 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5f4829f..719e527 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2573,3 +2573,28 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>         cap->events_mask_len    = x86_pmu.events_mask_len;
>  }
>  EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
> +
> +u64 perf_get_page_size(u64 virt)
> +{
> +       unsigned long flags;
> +       unsigned int level;
> +       pte_t *pte;
> +
> +       if (!virt)
> +               return 0;
> +
> +       /*
> +        * Interrupts are disabled, so it prevents any tear down
> +        * of the page tables.
> +        * See the comment near struct mmu_table_batch.
> +        */
> +       local_irq_save(flags);
> +       if (virt >= TASK_SIZE)
> +               pte = lookup_address(virt, &level);
> +       else
> +               pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
> +                                           virt, &level);
> +       local_irq_restore(flags);
> +
> +       return (u64)level;
> +}
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index b7b01d7..a3e56c7 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1274,7 +1274,7 @@ static void setup_pebs_sample_data(struct perf_event *event,
>         }
>
>
> -       if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
> +       if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_PAGE_SIZE)) &&
>             x86_pmu.intel_cap.pebs_format >= 1)
>                 data->addr = pebs->dla;
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 1562863..affcd26 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -94,7 +94,7 @@ struct amd_nb {
>         PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
>         PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
>         PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
> -       PERF_SAMPLE_PERIOD)
> +       PERF_SAMPLE_PERIOD | PERF_SAMPLE_PAGE_SIZE)
>
>  #define PEBS_REGS \
>         (PERF_REG_X86_AX | \
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f..9d13745 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -937,6 +937,7 @@ struct perf_sample_data {
>         u64                             stack_user_size;
>
>         u64                             phys_addr;
> +       u64                             page_size;
>  } ____cacheline_aligned;
>
>  /* default value for data source */
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index eeb787b..5473443 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -141,8 +141,9 @@ enum perf_event_sample_format {
>         PERF_SAMPLE_TRANSACTION                 = 1U << 17,
>         PERF_SAMPLE_REGS_INTR                   = 1U << 18,
>         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
> +       PERF_SAMPLE_PAGE_SIZE                   = 1U << 20,
>
> -       PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
> +       PERF_SAMPLE_MAX = 1U << 21,             /* non-ABI */
>
>         __PERF_SAMPLE_CALLCHAIN_EARLY           = 1ULL << 63,
>  };
> @@ -861,6 +862,7 @@ enum perf_event_type {
>          *      { u64                   abi; # enum perf_sample_regs_abi
>          *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_ADDR
> +        *      { u64                   page_size;} && PERF_SAMPLE_PAGE_SIZE
>          * };
>          */
>         PERF_RECORD_SAMPLE                      = 9,
> @@ -1099,6 +1101,15 @@ union perf_mem_data_src {
>  #define PERF_MEM_S(a, s) \
>         (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>
> +
> +enum perf_mem_page_size {
> +       PERF_MEM_PAGE_SIZE_NONE,
> +       PERF_MEM_PAGE_SIZE_4K,
> +       PERF_MEM_PAGE_SIZE_2M,
> +       PERF_MEM_PAGE_SIZE_1G,
> +       PERF_MEM_PAGE_SIZE_512G,
> +};
> +
>  /*
>   * single taken branch record layout:
>   *
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f6ea33a..e848e9b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1751,6 +1751,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
>         if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>                 size += sizeof(data->phys_addr);
>
> +       if (sample_type & PERF_SAMPLE_PAGE_SIZE)
> +               size += sizeof(data->page_size);
> +
>         event->header_size = size;
>  }
>
> @@ -6294,6 +6297,9 @@ void perf_output_sample(struct perf_output_handle *handle,
>         if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>                 perf_output_put(handle, data->phys_addr);
>
> +       if (sample_type & PERF_SAMPLE_PAGE_SIZE)
> +               perf_output_put(handle, data->page_size);
> +
>         if (!event->attr.watermark) {
>                 int wakeup_events = event->attr.wakeup_events;
>
> @@ -6341,6 +6347,12 @@ static u64 perf_virt_to_phys(u64 virt)
>         return phys_addr;
>  }
>
> +/* Return page size of given virtual address. IRQ-safe required. */
> +u64 __weak perf_get_page_size(u64 virt)
> +{
> +       return PERF_MEM_PAGE_SIZE_NONE;
> +}
> +
>  static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
>
>  struct perf_callchain_entry *
> @@ -6482,6 +6494,9 @@ void perf_prepare_sample(struct perf_event_header *header,
>
>         if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>                 data->phys_addr = perf_virt_to_phys(data->addr);
> +
> +       if (sample_type & PERF_SAMPLE_PAGE_SIZE)
> +               data->page_size = perf_get_page_size(data->addr);
>  }
>
>  static __always_inline void
> --
> 2.7.4
>
