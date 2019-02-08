Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2274BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCB320869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qARRQG7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBHX3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:29:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39302 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHX3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:29:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so2233874pgp.6;
        Fri, 08 Feb 2019 15:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=euC6RE000PyoWL8mLHmu4rDRlmY4Pbemh3wb2aBa7Os=;
        b=qARRQG7gOjvnC6lYusstiHQ81AGk8QE87FIEIB7K8srKyWLNakzisXg3y3iN8ldmYV
         6Ubgt51lVVmmOSgP13C2uvONf830D9YNR4uHMA6NnBJ3PJvLw2kNlSyILPMlYPOC80Df
         mZESM2MBpWclaUY2StmmjLWQZ+YTNW4Bj3TLipKbqsRXSPglevBY/XfZwMBbcqNl3mwS
         GlKAve7leIrkf1+sVh/ciwvP/9JNp94xGi6aDQUI0ckh3rdWRSmgwHjjVSNRVhVAvYDq
         m3HTXoKzrHRlTVoQpWeN4Pl6rv+ljiYWpTBUTinBPhib3Ivjo+4/VJEjK5lC8q4tolj5
         vM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=euC6RE000PyoWL8mLHmu4rDRlmY4Pbemh3wb2aBa7Os=;
        b=MVksnaOLJ11KuGGB5+vq6+fORjiUT63yYNit/L3HEOZI9pKGZ9bxWaMx+s5+SCvU8L
         qZB51iwSlCNBa0EsMPayqF5appLQ/vE66HdyIPPb37d2F3fqgBtGeQy+WVu8Hfs54R0T
         /4ludUGKGQoMVbNoV6wBl4vi1sFHaRpIbYc5wl4JD0l5mU/8A27Eu3QcuKIcSobb61Rn
         KvQ7yDZ65gRMjeJk5hhHUwY8zHPg4KnBsougvUOOMrf6iaH3IBUI/1OE18ynyTaOgx21
         0TYxVpnNywmBXdAwKLhodorEHuRuSmxwl4+E+od8RMbBU+KTQt9oslm565V6iHQ5m6BE
         oJfQ==
X-Gm-Message-State: AHQUAubWl2dHPFs81clhA8UmEBmW/kTyDQh2ZPizxAIWBroW++fTgV1a
        A+xZCWeKh8VxvR43sLmG/VI=
X-Google-Smtp-Source: AHgI3Iaza+zd1ihtXOR5RXDeG4Z59WXfV801UIyKICbQo7Zgrs8KrO9A5YoyvfMxgoS5+/JXgqJ5qA==
X-Received: by 2002:a62:2fc3:: with SMTP id v186mr24835414pfv.82.1549668569009;
        Fri, 08 Feb 2019 15:29:29 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:180::1:4d67])
        by smtp.gmail.com with ESMTPSA id y72sm5513469pfa.98.2019.02.08.15.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 15:29:28 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:29:26 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] perf, bpf: Retain kernel executable code in memory
 to aid Intel PT tracing
Message-ID: <20190208232924.bpdjuaqufndigtd4@ast-mbp>
References: <20190207111901.2399-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207111901.2399-1-adrian.hunter@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 01:19:01PM +0200, Adrian Hunter wrote:
> Subject to memory pressure and other limits, retain executable code, such
> as JIT-compiled bpf, in memory instead of freeing it immediately it is no
> longer needed for execution.
> 
> While perf is primarily aimed at statistical analysis, tools like Intel
> PT can aim to provide a trace of exactly what happened. As such, corner
> cases that can be overlooked statistically need to be addressed. For
> example, there is a gap where JIT-compiled bpf can be freed from memory
> before a tracer has a chance to read it out through the bpf syscall.
> While that can be ignored statistically, it contributes to a death by
> 1000 cuts for tracers attempting to assemble exactly what happened. This is
> a bit gratuitous given that retaining the executable code is relatively
> simple, and the amount of memory involved relatively small. The retained
> executable code is then available in memory images such as /proc/kcore.
> 
> This facility could perhaps be extended also to init sections.
> 
> Note that this patch is compile tested only and, at present, is missing
> the ability to retain symbols.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/Kconfig.cpu       |   1 +
>  include/linux/filter.h     |   4 +
>  include/linux/xc_retain.h  |  49 ++++++++++
>  init/Kconfig               |   6 ++
>  kernel/Makefile            |   1 +
>  kernel/bpf/core.c          |  44 ++++++++-
>  kernel/xc_retain.c         | 183 +++++++++++++++++++++++++++++++++++++
>  net/core/sysctl_net_core.c |  62 +++++++++++++
>  8 files changed, 349 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/xc_retain.h
>  create mode 100644 kernel/xc_retain.c
> 
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 6adce15268bd..21dcd064c272 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -389,6 +389,7 @@ menuconfig PROCESSOR_SELECT
>  config CPU_SUP_INTEL
>  	default y
>  	bool "Support Intel processors" if PROCESSOR_SELECT
> +	select XC_RETAIN if PERF_EVENTS && BPF_JIT
>  	---help---
>  	  This enables detection, tunings and quirks for Intel processors
>  
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index d531d4250bff..40b9f601e18f 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -851,6 +851,10 @@ extern int bpf_jit_enable;
>  extern int bpf_jit_harden;
>  extern int bpf_jit_kallsyms;
>  extern long bpf_jit_limit;
> +extern unsigned int bpf_jit_retain_min;
> +extern unsigned int bpf_jit_retain_max;
> +
> +void bpf_jit_retain_update_sz(void);
>  
>  typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
>  
> diff --git a/include/linux/xc_retain.h b/include/linux/xc_retain.h
> new file mode 100644
> index 000000000000..e79dc138bab8
> --- /dev/null
> +++ b/include/linux/xc_retain.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + */
> +#ifndef _LINUX_XC_RETAIN_H
> +#define _LINUX_XC_RETAIN_H
> +
> +#include <linux/list.h>
> +#include <linux/shrinker.h>
> +#include <linux/spinlock.h>
> +
> +struct xc_retain_ops {
> +	void (*free)(void *addr);
> +};
> +
> +struct xc_retain {
> +	struct list_head list;
> +	struct list_head items;
> +	const struct xc_retain_ops ops;
> +	unsigned int min_pages;
> +	unsigned int max_pages;
> +	unsigned int current_pages;
> +	unsigned int item_cnt;
> +	spinlock_t lock;
> +	struct shrinker shrinker;
> +};
> +
> +#ifdef CONFIG_XC_RETAIN
> +int xc_retain_register(struct xc_retain *xr);
> +void xc_retain_binary(struct xc_retain *xr, void *addr, unsigned int pages);
> +void xc_retain_set_min_pages(struct xc_retain *xr, unsigned int min_pages);
> +void xc_retain_set_max_pages(struct xc_retain *xr, unsigned int max_pages);
> +#else
> +static inline int xc_retain_register(struct xc_retain *xr)
> +{
> +	return 0;
> +}
> +static inline void xc_retain_binary(struct xc_retain *xr, void *addr,
> +				    unsigned int pages)
> +{
> +	xr->ops.free(addr);
> +}
> +static inline void xc_retain_set_max_pages(struct xc_retain *xr,
> +					   unsigned int max_pages)
> +{
> +}
> +#endif
> +
> +#endif
> diff --git a/init/Kconfig b/init/Kconfig
> index c9386a365eea..954c288cabdc 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1550,6 +1550,12 @@ config EMBEDDED
>  	  an embedded system so certain expert options are available
>  	  for configuration.
>  
> +config XC_RETAIN
> +	bool
> +	help
> +	  Retain kernel executable code (e.g. jitted BPF) in memory after it
> +	  would normally be freed.
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 6aa7543bcdb2..5df40e2a934e 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
>  obj-$(CONFIG_IRQ_WORK) += irq_work.o
>  obj-$(CONFIG_CPU_PM) += cpu_pm.o
>  obj-$(CONFIG_BPF) += bpf/
> +obj-$(CONFIG_XC_RETAIN) += xc_retain.o
>  
>  obj-$(CONFIG_PERF_EVENTS) += events/
>  
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 19c49313c709..7fd235d235c2 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -34,6 +34,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/rcupdate.h>
>  #include <linux/perf_event.h>
> +#include <linux/xc_retain.h>
>  
>  #include <asm/unaligned.h>
>  
> @@ -480,6 +481,10 @@ int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
>  int bpf_jit_harden   __read_mostly;
>  int bpf_jit_kallsyms __read_mostly;
>  long bpf_jit_limit   __read_mostly;
> +#define BPF_JIT_RETAIN_MIN 0
> +#define BPF_JIT_RETAIN_MAX 16
> +unsigned int bpf_jit_retain_min __read_mostly = BPF_JIT_RETAIN_MIN;
> +unsigned int bpf_jit_retain_max __read_mostly = BPF_JIT_RETAIN_MAX;
>  
>  static __always_inline void
>  bpf_get_prog_addr_region(const struct bpf_prog *prog,
> @@ -795,6 +800,43 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  	bpf_jit_uncharge_modmem(pages);
>  }
>  
> +#ifdef CONFIG_XC_RETAIN
> +static struct xc_retain bpf_jit_retain = {
> +	.min_pages = BPF_JIT_RETAIN_MIN,
> +	.max_pages = BPF_JIT_RETAIN_MAX,
> +	.ops = {
> +		.free = module_memfree,
> +	},
> +};
> +
> +void bpf_jit_retain_update_sz(void)
> +{
> +	xc_retain_set_min_pages(&bpf_jit_retain, bpf_jit_retain_min);
> +	xc_retain_set_max_pages(&bpf_jit_retain, bpf_jit_retain_max);
> +}
> +
> +static int __init bpf_jit_retain_init(void)
> +{
> +	return xc_retain_register(&bpf_jit_retain);
> +}
> +subsys_initcall(bpf_jit_retain_init);
> +
> +static void bpf_jit_binary_retain(struct bpf_prog *fp,
> +				  struct bpf_binary_header *hdr)
> +{
> +	u32 pages = hdr->pages;
> +
> +	xc_retain_binary(&bpf_jit_retain, hdr, pages);
> +	bpf_jit_uncharge_modmem(pages);
> +}
> +#else
> +static void bpf_jit_binary_retain(struct bpf_prog *fp,
> +				  struct bpf_binary_header *hdr)
> +{
> +	return bpf_jit_binary_free(hdr);
> +}
> +#endif

I'm strongly against this approach.

I understand that it's under CONFIG, but changing kernel
into garbage collection nightmare even under config
or sysctl is not an option.
In many cases bpf progs are loaded/unloaded a lot.
Consider CI test system that runs tests 24/7.
bpf progs are loaded/unloaded in huge numbers.
Such system will suffer non deterministic test and
performance results due to shrinkers.
perf analysis with PT becomes inaccurate and main goal
of retaining accurate instruction info is not achieved.
bpf_jit_retain_min/max tunables is not an option either.
Please see how perf record is handling bpf prog/unload.
What stops you from doing the same for PT?

