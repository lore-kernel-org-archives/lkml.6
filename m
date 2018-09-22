Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FE9ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970CC21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tWUbYnUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970CC21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeIVO62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 10:58:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46660 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIVO61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 10:58:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so14080474ljj.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrM0hT2yWKFlUyTcy3ySsu3SnIYLLqIEfo+EHJPiSYU=;
        b=tWUbYnUZrdL9RNHa5+AuhgpDwAdTK1fHtDYCz3CQc5541HQeiqkN5kE30XPb8p425L
         GCol7xJmQaP8ELbEqE88Y+QHmSnLJar7tuDlG88FP6dQnv7GWKNFZ4ZztnpNYkVEDHTg
         SMWtYCqg8UHsNf+QxrG8HgyfSAgHigh3B44Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrM0hT2yWKFlUyTcy3ySsu3SnIYLLqIEfo+EHJPiSYU=;
        b=tZfMpSwEJ5bbLlx3ncbYax8yrV+OjDCwvSq2J7qOdJSw53QXnRFVV2xgVx6+Lxer/M
         u1GOczTEgwcaOl5r1zolGj00sMVsBPLqHrUqvl7W2NqZrh+GPbc6Pms62R40bTBiTJH+
         wW3wcp0pxpdfYmC6NCqFmzVMIQ5pXLrOR2hXDaYsGoogreueAxJRWjHWehngdUMyzATT
         J20WP/XzQMCIaESN1+72qigOeIsQslpajvE1o2yPq3Xzqlt+BtNdgcgKo1zd3m49SG8j
         THmGRirYva1qkQylHy0Oq1D9ylPRnkDKB1tyXJ852/3ttomA/VNB5zfxpmypS+ruIN5K
         vNxA==
X-Gm-Message-State: ABuFfogI3Okro+ZgqUXpQweoetA1VmkOgQQhsVhVroAuv18W1cJsoBfU
        hAUC0fJXi2Yj+UvuT70/Op7fEaYcEsSGdHqqxIJyIg==
X-Google-Smtp-Source: ACcGV60WnjT8RkR/Y2brtdpZRNCkWQtZfoWfYGWV5jULNQrJaxxSv0IGtrY3VUGl7kkAcwwPkwYgHETzDGjxV7WSy7A=
X-Received: by 2002:a2e:7a08:: with SMTP id v8-v6mr4819599ljc.121.1537607134877;
 Sat, 22 Sep 2018 02:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org> <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 22 Sep 2018 05:05:23 -0400
Message-ID: <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Currently pstore has function trace support which can be
> used to get the function call chain with limited data.
> Event tracing has extra data which is useful to debug wide
> variety of issues and is heavily used across the kernel.
>
[...]
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  fs/pstore/Kconfig          |  2 +-
>  fs/pstore/ftrace.c         | 55 ++++++++++++++++++++++++++++++++++++++
>  fs/pstore/inode.c          |  4 +++
>  fs/pstore/ram.c            | 44 +++++++++++++++++++++++++++---
>  include/linux/pstore.h     |  2 ++
>  include/linux/pstore_ram.h |  1 +
>  6 files changed, 104 insertions(+), 4 deletions(-)
>
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 503086f7f7c1..6fe087b13a51 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -126,7 +126,7 @@ config PSTORE_PMSG
>
>  config PSTORE_FTRACE
>         bool "Persistent function tracer"
> -       depends on PSTORE
> +       depends on PSTORE && PSTORE!=m
>         depends on FUNCTION_TRACER
>         depends on DEBUG_FS
>         help
> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> index 06aab07b6bb7..d47dc93ac098 100644
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -24,6 +24,8 @@
>  #include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/cache.h>
> +#include <linux/slab.h>
> +#include <linux/trace_events.h>
>  #include <asm/barrier.h>
>  #include "internal.h"
>
> @@ -62,6 +64,59 @@ static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
>         .func   = pstore_ftrace_call,
>  };
>
> +void notrace pstore_event_call(struct trace_event_buffer *fbuffer)
> +{
> +       struct trace_iterator *iter;
> +       struct trace_seq *s;
> +       struct trace_event_call *event_call;
> +       struct pstore_record record;
> +       struct trace_event *event;
> +       struct seq_buf *seq;
> +       unsigned long flags;
> +
> +       if (!psinfo)
> +               return;
> +
> +       if (unlikely(oops_in_progress))
> +               return;
> +
> +       pstore_record_init(&record, psinfo);
> +       record.type = PSTORE_TYPE_EVENT;
> +
> +       iter = kmalloc(sizeof(*iter), GFP_KERNEL);
> +       if (!iter)
> +               return;
> +
> +       event_call = fbuffer->trace_file->event_call;
> +       if (!event_call || !event_call->event.funcs ||
> +           !event_call->event.funcs->trace)
> +               goto fail_event;
> +
> +       event = &fbuffer->trace_file->event_call->event;
> +
> +       spin_lock_irqsave(&psinfo->buf_lock, flags);

Could you just split the pstore space into a per-cpu event buffer like
we are doing for ftrace-on-pstore? Then you don't need to lock. I fear
the lock contention will be apparent. The pstore code already has
plumbing to split the store buffer per CPU.

Also I think this spinlock can be moved further down.

> +
> +       trace_seq_init(&iter->seq);
> +       iter->ent = fbuffer->entry;
> +       event_call->event.funcs->trace(iter, 0, event);
> +       trace_seq_putc(&iter->seq, 0);

Would it be possible to store the binary trace record in the pstore
buffer instead of outputting text? I suspect that will both be faster
and less space.

> +
> +       if (seq->size > psinfo->bufsize)
> +               seq->size = psinfo->bufsize;
> +
> +       s = &iter->seq;
> +       seq = &s->seq;
> +
> +       record.buf = (char *)(seq->buffer);
> +       record.size = seq->len;
> +       psinfo->write(&record);

thanks,

 - Joel

> +
> +       spin_unlock_irqrestore(&psinfo->buf_lock, flags);
> +
> +fail_event:
> +       kfree(iter);
> +}
> +
>  static DEFINE_MUTEX(pstore_ftrace_lock);
>  static bool pstore_ftrace_enabled;
>
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 5fcb845b9fec..f099152abbbd 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -345,6 +345,10 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>                 scnprintf(name, sizeof(name), "console-%s-%llu",
>                           record->psi->name, record->id);
>                 break;
> +       case PSTORE_TYPE_EVENT:
> +               scnprintf(name, sizeof(name), "event-%s-%llu",
> +                         record->psi->name, record->id);
> +               break;
>         case PSTORE_TYPE_FTRACE:
>                 scnprintf(name, sizeof(name), "ftrace-%s-%llu",
>                           record->psi->name, record->id);
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index bbd1e357c23d..f60d41c0309e 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -48,6 +48,10 @@ static ulong ramoops_console_size = MIN_MEM_SIZE;
>  module_param_named(console_size, ramoops_console_size, ulong, 0400);
>  MODULE_PARM_DESC(console_size, "size of kernel console log");
>
> +static ulong ramoops_event_size = MIN_MEM_SIZE;
> +module_param_named(event_size, ramoops_event_size, ulong, 0400);
> +MODULE_PARM_DESC(event_size, "size of event log");
> +
>  static ulong ramoops_ftrace_size = MIN_MEM_SIZE;
>  module_param_named(ftrace_size, ramoops_ftrace_size, ulong, 0400);
>  MODULE_PARM_DESC(ftrace_size, "size of ftrace log");
> @@ -86,6 +90,7 @@ MODULE_PARM_DESC(ramoops_ecc,
>  struct ramoops_context {
>         struct persistent_ram_zone **dprzs;     /* Oops dump zones */
>         struct persistent_ram_zone *cprz;       /* Console zone */
> +       struct persistent_ram_zone *eprz;       /* Event zone */
>         struct persistent_ram_zone **fprzs;     /* Ftrace zones */
>         struct persistent_ram_zone *mprz;       /* PMSG zone */
>         phys_addr_t phys_addr;
> @@ -93,6 +98,7 @@ struct ramoops_context {
>         unsigned int memtype;
>         size_t record_size;
>         size_t console_size;
> +       size_t event_size;
>         size_t ftrace_size;
>         size_t pmsg_size;
>         int dump_oops;
> @@ -103,6 +109,7 @@ struct ramoops_context {
>         /* _read_cnt need clear on ramoops_pstore_open */
>         unsigned int dump_read_cnt;
>         unsigned int console_read_cnt;
> +       unsigned int event_read_cnt;
>         unsigned int max_ftrace_cnt;
>         unsigned int ftrace_read_cnt;
>         unsigned int pmsg_read_cnt;
> @@ -118,6 +125,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
>
>         cxt->dump_read_cnt = 0;
>         cxt->console_read_cnt = 0;
> +       cxt->event_read_cnt = 0;
>         cxt->ftrace_read_cnt = 0;
>         cxt->pmsg_read_cnt = 0;
>         return 0;
> @@ -277,6 +285,11 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>                                            1, &record->id, &record->type,
>                                            PSTORE_TYPE_CONSOLE, 0);
>
> +       if (!prz_ok(prz))
> +               prz = ramoops_get_next_prz(&cxt->eprz, &cxt->event_read_cnt,
> +                                          1, &record->id, &record->type,
> +                                          PSTORE_TYPE_EVENT, 0);
> +
>         if (!prz_ok(prz))
>                 prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
>                                            1, &record->id, &record->type,
> @@ -385,6 +398,11 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
>                         return -ENOMEM;
>                 persistent_ram_write(cxt->cprz, record->buf, record->size);
>                 return 0;
> +       } else if (record->type == PSTORE_TYPE_EVENT) {
> +               if (!cxt->eprz)
> +                       return -ENOMEM;
> +               persistent_ram_write(cxt->eprz, record->buf, record->size);
> +               return 0;
>         } else if (record->type == PSTORE_TYPE_FTRACE) {
>                 int zonenum;
>
> @@ -475,6 +493,9 @@ static int ramoops_pstore_erase(struct pstore_record *record)
>         case PSTORE_TYPE_CONSOLE:
>                 prz = cxt->cprz;
>                 break;
> +       case PSTORE_TYPE_EVENT:
> +               prz = cxt->eprz;
> +               break;
>         case PSTORE_TYPE_FTRACE:
>                 if (record->id >= cxt->max_ftrace_cnt)
>                         return -EINVAL;
> @@ -699,6 +720,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>
>         parse_size("record-size", pdata->record_size);
>         parse_size("console-size", pdata->console_size);
> +       parse_size("event-size", pdata->event_size);
>         parse_size("ftrace-size", pdata->ftrace_size);
>         parse_size("pmsg-size", pdata->pmsg_size);
>         parse_size("ecc-size", pdata->ecc_info.ecc_size);
> @@ -747,7 +769,8 @@ static int ramoops_probe(struct platform_device *pdev)
>         }
>
>         if (!pdata->mem_size || (!pdata->record_size && !pdata->console_size &&
> -                       !pdata->ftrace_size && !pdata->pmsg_size)) {
> +                       !pdata->event_size && !pdata->ftrace_size &&
> +                       !pdata->pmsg_size)) {
>                 pr_err("The memory size and the record/console size must be "
>                         "non-zero\n");
>                 goto fail_out;
> @@ -757,6 +780,8 @@ static int ramoops_probe(struct platform_device *pdev)
>                 pdata->record_size = rounddown_pow_of_two(pdata->record_size);
>         if (pdata->console_size && !is_power_of_2(pdata->console_size))
>                 pdata->console_size = rounddown_pow_of_two(pdata->console_size);
> +       if (pdata->event_size && !is_power_of_2(pdata->event_size))
> +               pdata->event_size = rounddown_pow_of_two(pdata->event_size);
>         if (pdata->ftrace_size && !is_power_of_2(pdata->ftrace_size))
>                 pdata->ftrace_size = rounddown_pow_of_two(pdata->ftrace_size);
>         if (pdata->pmsg_size && !is_power_of_2(pdata->pmsg_size))
> @@ -767,6 +792,7 @@ static int ramoops_probe(struct platform_device *pdev)
>         cxt->memtype = pdata->mem_type;
>         cxt->record_size = pdata->record_size;
>         cxt->console_size = pdata->console_size;
> +       cxt->event_size = pdata->event_size;
>         cxt->ftrace_size = pdata->ftrace_size;
>         cxt->pmsg_size = pdata->pmsg_size;
>         cxt->dump_oops = pdata->dump_oops;
> @@ -775,8 +801,8 @@ static int ramoops_probe(struct platform_device *pdev)
>
>         paddr = cxt->phys_addr;
>
> -       dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
> -                       - cxt->pmsg_size;
> +       dump_mem_sz = cxt->size - cxt->console_size - cxt->event_size
> +                       - cxt->ftrace_size - cxt->pmsg_size;
>         err = ramoops_init_przs("dump", dev, cxt, &cxt->dprzs, &paddr,
>                                 dump_mem_sz, cxt->record_size,
>                                 &cxt->max_dump_cnt, 0, 0);
> @@ -788,6 +814,11 @@ static int ramoops_probe(struct platform_device *pdev)
>         if (err)
>                 goto fail_init_cprz;
>
> +       err = ramoops_init_prz("event", dev, cxt, &cxt->eprz, &paddr,
> +                              cxt->event_size, 0);
> +       if (err)
> +               goto fail_init_eprz;
> +
>         cxt->max_ftrace_cnt = (cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)
>                                 ? nr_cpu_ids
>                                 : 1;
> @@ -825,6 +856,8 @@ static int ramoops_probe(struct platform_device *pdev)
>         cxt->pstore.flags = PSTORE_FLAGS_DMESG;
>         if (cxt->console_size)
>                 cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
> +       if (cxt->event_size)
> +               cxt->pstore.flags |= PSTORE_FLAGS_EVENT;
>         if (cxt->ftrace_size)
>                 cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
>         if (cxt->pmsg_size)
> @@ -845,6 +878,7 @@ static int ramoops_probe(struct platform_device *pdev)
>         record_size = pdata->record_size;
>         dump_oops = pdata->dump_oops;
>         ramoops_console_size = pdata->console_size;
> +       ramoops_event_size = pdata->event_size;
>         ramoops_pmsg_size = pdata->pmsg_size;
>         ramoops_ftrace_size = pdata->ftrace_size;
>
> @@ -858,6 +892,8 @@ static int ramoops_probe(struct platform_device *pdev)
>         kfree(cxt->pstore.buf);
>  fail_clear:
>         cxt->pstore.bufsize = 0;
> +       persistent_ram_free(cxt->eprz);
> +fail_init_eprz:
>         persistent_ram_free(cxt->mprz);
>  fail_init_mprz:
>  fail_init_fprz:
> @@ -877,6 +913,7 @@ static int ramoops_remove(struct platform_device *pdev)
>         kfree(cxt->pstore.buf);
>         cxt->pstore.bufsize = 0;
>
> +       persistent_ram_free(cxt->eprz);
>         persistent_ram_free(cxt->mprz);
>         persistent_ram_free(cxt->cprz);
>         ramoops_free_przs(cxt);
> @@ -916,6 +953,7 @@ static void ramoops_register_dummy(void)
>         dummy_data->mem_type = mem_type;
>         dummy_data->record_size = record_size;
>         dummy_data->console_size = ramoops_console_size;
> +       dummy_data->event_size = ramoops_event_size;
>         dummy_data->ftrace_size = ramoops_ftrace_size;
>         dummy_data->pmsg_size = ramoops_pmsg_size;
>         dummy_data->dump_oops = dump_oops;
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index a15bc4d48752..c31bb9567b4a 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -44,6 +44,7 @@ enum pstore_type_id {
>         PSTORE_TYPE_PPC_COMMON  = 6,
>         PSTORE_TYPE_PMSG        = 7,
>         PSTORE_TYPE_PPC_OPAL    = 8,
> +       PSTORE_TYPE_EVENT       = 9,
>         PSTORE_TYPE_UNKNOWN     = 255
>  };
>
> @@ -193,6 +194,7 @@ struct pstore_info {
>  #define PSTORE_FLAGS_CONSOLE   (1 << 1)
>  #define PSTORE_FLAGS_FTRACE    (1 << 2)
>  #define PSTORE_FLAGS_PMSG      (1 << 3)
> +#define PSTORE_FLAGS_EVENT     (1 << 4)
>
>  extern int pstore_register(struct pstore_info *);
>  extern void pstore_unregister(struct pstore_info *);
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index e6d226464838..f01055c6cc40 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -95,6 +95,7 @@ struct ramoops_platform_data {
>         unsigned int    mem_type;
>         unsigned long   record_size;
>         unsigned long   console_size;
> +       unsigned long   event_size;
>         unsigned long   ftrace_size;
>         unsigned long   pmsg_size;
>         int             dump_oops;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
