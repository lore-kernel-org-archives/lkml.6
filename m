Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28EAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ECC21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="oZ7FGgpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ECC21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbeIUUqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:46:48 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44931 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390179AbeIUUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:46:47 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so11619413oih.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXa+tTWgvrIt+UaxBmVbUv0K3O1uHDXpe5bgsYkFyqs=;
        b=oZ7FGgpQyljRAmQ/S1NT6EL5q7zB77URy/gYIrNHJhf9CJXIsdfbSAfGQXCRcUYAQX
         EjmHMMR3c+GuoX9bzFP+Ov4qEvY4Qtqcfp4gU7enQmYBsBePnwSFwEqIt8h/9D9Y29Up
         sakhkyuJgzkcNyLQ89zadh0mAK3jlakXRI3Djv4lENra+0dLs94gcu2Pqvw1rTFMgXG6
         WbIppIdsx4ui+vGhLS2FmulJBFiI7aCX6S1Eq8mpEYFECBrWZy7ndXIRFy72gWztsaxN
         dMiAMMPjd6/173ZqoJl7nfy2YBJUgNyWYtLH44mmQ5CG+r1ZTR7p9C3ndwxJ9OqGNBZ3
         PXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXa+tTWgvrIt+UaxBmVbUv0K3O1uHDXpe5bgsYkFyqs=;
        b=pXTS1t/1N97LzEqly/ZGCe73TClH603YoGP6ze6PkfqlU9F5/2RE8dOXeQRmW/+gmC
         VUjy6zI8rx8ClJgOy6R8KV0OjTsid7PoylYKR/i9p5iZY1ktmdJHpKUPKcCSlsHZEQe8
         f72RnqIxuboQBQtvR2fvPpnyAWPTh7xXRFN1JY6Vs20Vj41jia/s4ak9JBok6gN69prj
         D0OQKWl9mPvCCkk5ai6Og00SZvzclWM0OBuvSOtaVfsB8ImelbEobtZbKS9SdJKhZMoH
         d+HHPCHHrzerQ547JmejdAy5bAUojW0Z5XUZIe64s+c3N/B2z/4eLMwWihuszMRxM+eC
         5oYA==
X-Gm-Message-State: APzg51CqnMtYvCWIcR9FixFQyatjbBEc15jK8yY1cPOQULmAXCoxrRg7
        rsgr3+TuGhCVEAx1DZdmZ2VseD2EydcHGQlzAnOQJQ==
X-Google-Smtp-Source: ANB0VdaTokJ4vAVVFEyNBPQCAhvSCnt+LIUuNXpimyipAekt6MdZDDLy2qRERkb2bB8NMkuKmzX3uz4HADo5Pwa6D5w=
X-Received: by 2002:aca:a8c1:: with SMTP id r184-v6mr1499457oie.215.1537541852376;
 Fri, 21 Sep 2018 07:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180920215824.19464.8884.stgit@localhost.localdomain> <20180920222938.19464.34102.stgit@localhost.localdomain>
In-Reply-To: <20180920222938.19464.34102.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 07:57:21 -0700
Message-ID: <CAPcyv4iFs5WXMYgbC6mBSxcHggv5y1kPW5BoZ4JMy5o-bv6cOg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] async: Add support for queueing on specific node
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 3:31 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This patch introduces two new variants of the async_schedule_ functions
> that allow scheduling on a specific node. These functions are
> async_schedule_on and async_schedule_on_domain which end up mapping to
> async_schedule and async_schedule_domain but provide NUMA node specific
> functionality. The original functions were moved to inline function
> definitions that call the new functions while passing NUMA_NO_NODE.
>
> The main motivation behind this is to address the need to be able to
> schedule NVDIMM init work on specific NUMA nodes in order to improve
> performance of memory initialization.
>
> One additional change I made is I dropped the "extern" from the function
> prototypes in the async.h kernel header since they aren't needed.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  include/linux/async.h |   20 +++++++++++++++++---
>  kernel/async.c        |   36 +++++++++++++++++++++++++-----------
>  2 files changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/async.h b/include/linux/async.h
> index 6b0226bdaadc..9878b99cbb01 100644
> --- a/include/linux/async.h
> +++ b/include/linux/async.h
> @@ -14,6 +14,7 @@
>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/numa.h>
>
>  typedef u64 async_cookie_t;
>  typedef void (*async_func_t) (void *data, async_cookie_t cookie);
> @@ -37,9 +38,22 @@ struct async_domain {
>         struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
>                                       .registered = 0 }
>
> -extern async_cookie_t async_schedule(async_func_t func, void *data);
> -extern async_cookie_t async_schedule_domain(async_func_t func, void *data,
> -                                           struct async_domain *domain);
> +async_cookie_t async_schedule_on(async_func_t func, void *data, int node);
> +async_cookie_t async_schedule_on_domain(async_func_t func, void *data, int node,
> +                                       struct async_domain *domain);

I would expect this to take a cpu instead of a node to not surprise
users coming from queue_work_on() / schedule_work_on()...

> +
> +static inline async_cookie_t async_schedule(async_func_t func, void *data)
> +{
> +       return async_schedule_on(func, data, NUMA_NO_NODE);
> +}
> +
> +static inline async_cookie_t
> +async_schedule_domain(async_func_t func, void *data,
> +                     struct async_domain *domain)
> +{
> +       return async_schedule_on_domain(func, data, NUMA_NO_NODE, domain);
> +}
> +
>  void async_unregister_domain(struct async_domain *domain);
>  extern void async_synchronize_full(void);
>  extern void async_synchronize_full_domain(struct async_domain *domain);
> diff --git a/kernel/async.c b/kernel/async.c
> index a893d6170944..1d7ce81c1949 100644
> --- a/kernel/async.c
> +++ b/kernel/async.c
> @@ -56,6 +56,7 @@ synchronization with the async_synchronize_full() function, before returning
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> +#include <linux/cpu.h>
>
>  #include "workqueue_internal.h"
>
> @@ -149,8 +150,11 @@ static void async_run_entry_fn(struct work_struct *work)
>         wake_up(&async_done);
>  }
>
> -static async_cookie_t __async_schedule(async_func_t func, void *data, struct async_domain *domain)
> +static async_cookie_t __async_schedule(async_func_t func, void *data,
> +                                      struct async_domain *domain,
> +                                      int node)
>  {
> +       int cpu = WORK_CPU_UNBOUND;
>         struct async_entry *entry;
>         unsigned long flags;
>         async_cookie_t newcookie;
> @@ -194,30 +198,40 @@ static async_cookie_t __async_schedule(async_func_t func, void *data, struct asy
>         /* mark that this task has queued an async job, used by module init */
>         current->flags |= PF_USED_ASYNC;
>
> +       /* guarantee cpu_online_mask doesn't change during scheduling */
> +       get_online_cpus();
> +
> +       if (node >= 0 && node < MAX_NUMNODES && node_online(node))
> +               cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);

...I think this node to cpu helper should be up-leveled for callers. I
suspect using get_online_cpus() may cause lockdep problems to take the
cpu_hotplug_lock() within a "do_something_on()" routine. For example,
I found this when auditing queue_work_on() users:

/*
 * Doesn't need any cpu hotplug locking because we do rely on per-cpu
 * kworkers being shut down before our page_alloc_cpu_dead callback is
 * executed on the offlined cpu.
 * Calling this function with cpu hotplug locks held can actually lead
 * to obscure indirect dependencies via WQ context.
 */
void lru_add_drain_all(void)

I think it's a gotcha waiting to happen if async_schedule_on() has
more restrictive calling contexts than queue_work_on().
