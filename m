Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB3AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9DA2183D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9ytcO0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9DA2183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeHVBdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:33:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33362 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeHVBdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:33:32 -0400
Received: by mail-yw1-f68.google.com with SMTP id x67-v6so3656573ywg.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ce8+Xe5BLJB9PmZwGNkfYx3fFgqN5my2B99jGroCbk=;
        b=i9ytcO0wz17uCHTfBUoaPaspF9mo27yCwSYlAUOjDRtYpckZ5PBaw6qCw0L5dUStA6
         Zg7VpMDaRw/dW9ViU+l4xbh38zFYQx21J6EhoTvOhLxzixlT5dGb7ygtttnHi1WZjr+z
         rCyAPyzhj0poIMw4qCp7GdY0IDlqtdIWofhkk0CtrRjT5ekp1itu/T/7Rc0sUgS0I8TM
         0v4gk8DG37Gc8P/VqjUgJ+S4lskcs+FeWTVvySnl3wW719v4KF2cXBBdRShJg+W7tebs
         FQe71m/VsOBZifI864FaOVIJaHQjoV2f+2APuId6bKnuUYFgcfYuRV5RWvsVRnHkT3A5
         BiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ce8+Xe5BLJB9PmZwGNkfYx3fFgqN5my2B99jGroCbk=;
        b=Z7BbqVhStsSBHcn6v/4/WRQq7PLjdFk2u8kJTljvnJ0amriQE+ZMuwJKlpReUbkjqI
         GZoSq6T/2WiyJFrLWrIQ2K/XcESUD1hqf9T/esmCc01RejqIcfH8Xrh/9qI7c6MHeXLn
         2PXvJ7dh9uWiGWgjw4WZx3o9gRHf0PbHjC58J7ex6e9Yua7FF4tibXKBvyVcxi3EJKKd
         6GjjUlDBeKf+lCVtgwB0TGi3O6id+/MwoFq6TV2vWSd7rd+4kfmOlMNuQKY8Xj2T9Ei1
         LJoxspw/in6JAVK5yN3u1JI7dJQNYFwk5LGCwHwaAhIly8h9IzRNri4KL+LikzMM9apF
         xONQ==
X-Gm-Message-State: AOUpUlHfPVe14/onEGtnmVGTDgOqo7ifKL06YPYy5kUgEVSvrC+GlUeX
        WQ99abxRVhl6MMUjFprqH9cvJ4b0cP4uJ6tceVURWA==
X-Google-Smtp-Source: AA+uWPye3f5Avy0smfg9nc8StoYv/gVZfZnfUUmxjHk3+yAmwvvwptB3rjim4rFmu17QcE/i6mafBpU+qr3dggMpavE=
X-Received: by 2002:a81:ae62:: with SMTP id g34-v6mr10590900ywk.345.1534889492422;
 Tue, 21 Aug 2018 15:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180821213559.14694-1-guro@fb.com>
In-Reply-To: <20180821213559.14694-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Aug 2018 15:10:52 -0700
Message-ID: <CALvZod4HAf+iPXQx1v+dwJkTph3ySAiYo4kn4d2jRFNQS59Tgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, luto@kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 2:36 PM Roman Gushchin <guro@fb.com> wrote:
>
> If CONFIG_VMAP_STACK is set, kernel stacks are allocated
> using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
> stack pages are charged against corresponding memory cgroups
> on allocation and uncharged on releasing them.
>
> The problem is that we do cache kernel stacks in small
> per-cpu caches and do reuse them for new tasks, which can
> belong to different memory cgroups.
>
> Each stack page still holds a reference to the original cgroup,
> so the cgroup can't be released until the vmap area is released.
>
> To make this happen we need more than two subsequent exits
> without forks in between on the current cpu, which makes it
> very unlikely to happen. As a result, I saw a significant number
> of dying cgroups (in theory, up to 2 * number_of_cpu +
> number_of_tasks), which can't be released even by significant
> memory pressure.
>
> As a cgroup structure can take a significant amount of memory
> (first of all, per-cpu data like memcg statistics), it leads
> to a noticeable waste of memory.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

BTW this makes a very good use-case for optimizing kmem uncharging
similar to what you did for skmem uncharging.

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/memcontrol.h | 13 +++++++++-
>  kernel/fork.c              | 51 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 57 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0e6c515fb698..b12a553048e2 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1250,10 +1250,11 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
>  void memcg_kmem_put_cache(struct kmem_cache *cachep);
>  int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
>                             struct mem_cgroup *memcg);
> +
> +#ifdef CONFIG_MEMCG_KMEM
>  int memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
>  void memcg_kmem_uncharge(struct page *page, int order);
>
> -#ifdef CONFIG_MEMCG_KMEM
>  extern struct static_key_false memcg_kmem_enabled_key;
>  extern struct workqueue_struct *memcg_kmem_cache_wq;
>
> @@ -1289,6 +1290,16 @@ extern int memcg_expand_shrinker_maps(int new_id);
>  extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>                                    int nid, int shrinker_id);
>  #else
> +
> +static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
> +{
> +       return 0;
> +}
> +
> +static inline void memcg_kmem_uncharge(struct page *page, int order)
> +{
> +}
> +
>  #define for_each_memcg_cache_index(_idx)       \
>         for (; NULL; )
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5ee74c113381..09b5b9a40166 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -223,9 +223,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>                 return s->addr;
>         }
>
> +       /*
> +        * Allocated stacks are cached and later reused by new threads,
> +        * so memcg accounting is performed manually on assigning/releasing
> +        * stacks to tasks. Drop __GFP_ACCOUNT.
> +        */
>         stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
>                                      VMALLOC_START, VMALLOC_END,
> -                                    THREADINFO_GFP,
> +                                    THREADINFO_GFP & ~__GFP_ACCOUNT,
>                                      PAGE_KERNEL,
>                                      0, node, __builtin_return_address(0));
>
> @@ -248,9 +253,20 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  static inline void free_thread_stack(struct task_struct *tsk)
>  {
>  #ifdef CONFIG_VMAP_STACK
> -       if (task_stack_vm_area(tsk)) {
> +       struct vm_struct *vm = task_stack_vm_area(tsk);
> +
> +       if (vm) {
>                 int i;
>
> +               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> +                       mod_memcg_page_state(vm->pages[i],
> +                                            MEMCG_KERNEL_STACK_KB,
> +                                            -(int)(PAGE_SIZE / 1024));
> +
> +                       memcg_kmem_uncharge(vm->pages[i],
> +                                           compound_order(vm->pages[i]));
> +               }
> +
>                 for (i = 0; i < NR_CACHED_STACKS; i++) {
>                         if (this_cpu_cmpxchg(cached_stacks[i],
>                                         NULL, tsk->stack_vm_area) != NULL)
> @@ -350,10 +366,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>                                             NR_KERNEL_STACK_KB,
>                                             PAGE_SIZE / 1024 * account);
>                 }
> -
> -               /* All stack pages belong to the same memcg. */
> -               mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> -                                    account * (THREAD_SIZE / 1024));
>         } else {
>                 /*
>                  * All stack pages are in the same zone and belong to the
> @@ -369,6 +381,30 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>         }
>  }
>
> +static int memcg_charge_kernel_stack(struct task_struct *tsk)
> +{
> +#ifdef CONFIG_VMAP_STACK
> +       struct vm_struct *vm = task_stack_vm_area(tsk);
> +       int ret;
> +
> +       if (vm) {
> +               int i;
> +
> +               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> +                       ret = memcg_kmem_charge(vm->pages[i], GFP_KERNEL,
> +                                               compound_order(vm->pages[i]));
> +                       if (ret)
> +                               return ret;
> +
> +                       mod_memcg_page_state(vm->pages[i],
> +                                            MEMCG_KERNEL_STACK_KB,
> +                                            PAGE_SIZE / 1024);
> +               }
> +       }
> +#endif
> +       return 0;
> +}
> +
>  static void release_task_stack(struct task_struct *tsk)
>  {
>         if (WARN_ON(tsk->state != TASK_DEAD))
> @@ -807,6 +843,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>         if (!stack)
>                 goto free_tsk;
>
> +       if (memcg_charge_kernel_stack(tsk))
> +               goto free_stack;
> +
>         stack_vm_area = task_stack_vm_area(tsk);
>
>         err = arch_dup_task_struct(tsk, orig);
> --
> 2.17.1
>
