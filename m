Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3240C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1342098B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXmG/yC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1342098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbeHOEID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:08:03 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43250 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeHOEID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:08:03 -0400
Received: by mail-ua1-f67.google.com with SMTP id f4-v6so15320461uao.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3e1kVnJ8jDYpUaQegebiyDo9+ltxR6W39l+IdShOJo=;
        b=cXmG/yC43BDNPZsEQsofCpLAb/KgYdziHk4zmBjVqo2M6UmRTtjfTk0YUPk6g7odrv
         AZ1n4PNnNZz8FLVJth9gvKe00C6qeJHL8WOFnv0P3aIFi2EReHC2Y9X1bCseyOmGYQKV
         Jc4sC+sHLMdoz71YmXBCL6maco2y7fh2gcb6H9GKRSMHRBr+Cl4D8V8tz2v7iuiKkt3k
         W2GVCiza5nQZYHoat17dlMCWuYIl8KyAPOwVkNZ2+s5dlboLsXj3MArLPs7Rtqavszdb
         WE8KpoKlvKivcS8H6LYYpIVYSQotsi+X1rSOb+S4xzgAGfTNkZv6PHE3ZqxIDyZZQSwa
         vomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3e1kVnJ8jDYpUaQegebiyDo9+ltxR6W39l+IdShOJo=;
        b=V8CpNgq0WTsaVkwdWDcgLIucDGeGCON7Xx5NAMPdeINgpk8R/dmMvcPoHm7GcjxeOc
         Gcc+Ywob1E1rYtHwOtO/9ugEsPanm9yZayAK9/+H4jLUGM37BEpUK0trLSM9A4d3ZE6L
         z+Z6tfaybsjFW0x+WdO71SQboO56lYvwg21BRUs9X9j6cy013q3e8qjsn0ax3iTvkqxQ
         CG0nMZa1CVsL3/8W6aqJIRvgIHpqNRH0VmsfB6mOq+hVQkQ9zjrjKvG0N5CFMcVFPpKg
         /tmn1JlkBTPAD6dHSwTDmTt3+Q8jJAb+ABinJ2AXppFFzf673Qp8mBoAulL+LgS9SAWb
         dMaQ==
X-Gm-Message-State: AOUpUlEraW35oL3lQ0d4RMTGgiq5To/5h9X4oXNKU6fora4e7n0JbmWL
        ZcrYqK0qz3TMWDfLdPQ5tcceDciybq9nPQjgGFZHEw==
X-Google-Smtp-Source: AA+uWPwvhmy09ACHq+S+8oSNU8riSv2zAHR5QCcDV+z1sz9vK5xSZ8yLE/GMDX3eADz7blsQRpawxxZIOOkvW5Qfx5o=
X-Received: by 2002:a9f:2c87:: with SMTP id w7-v6mr15378043uaj.21.1534295892682;
 Tue, 14 Aug 2018 18:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180815003620.15678-1-guro@fb.com>
In-Reply-To: <20180815003620.15678-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 14 Aug 2018 18:18:01 -0700
Message-ID: <CALvZod5LW_vCNbb6=PartjujnWcOiYbaAiANR_g+Dzwpp23BmA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, luto@kernel.org,
        koct9i@gmail.com, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 5:37 PM Roman Gushchin <guro@fb.com> wrote:
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

I was also looking into this issue. I was thinking of having a
per-memcg per-cpu stack cache. However this solution seems much
simpler. Can you also add the performance number for a similar simple
benchmark done in ac496bf48d97 ("fork: Optimize task creation by
caching two thread stacks per CPU if CONFIG_VMAP_STACK=y").

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> ---
>  kernel/fork.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 69b6fea5a181..91872b2b37bd 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
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
> @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  #endif
>  }
>
> +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> +{
> +#ifdef CONFIG_VMAP_STACK
> +       struct vm_struct *vm = task_stack_vm_area(tsk);
> +
> +       if (vm) {
> +               int i;
> +
> +               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +                       memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> +                                         compound_order(vm->pages[i]));
> +
> +               /* All stack pages belong to the same memcg. */
> +               mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> +                                    THREAD_SIZE / 1024);
> +       }
> +#endif
> +}
> +
>  static inline void free_thread_stack(struct task_struct *tsk)
>  {
>  #ifdef CONFIG_VMAP_STACK
> -       if (task_stack_vm_area(tsk)) {
> +       struct vm_struct *vm = task_stack_vm_area(tsk);
> +
> +       if (vm) {
>                 int i;
>
> +               /* All stack pages belong to the same memcg. */
> +               mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> +                                    -(int)(THREAD_SIZE / 1024));
> +
> +               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +                       memcg_kmem_uncharge(vm->pages[i],
> +                                         compound_order(vm->pages[i]));
> +
>                 for (i = 0; i < NR_CACHED_STACKS; i++) {
>                         if (this_cpu_cmpxchg(cached_stacks[i],
>                                         NULL, tsk->stack_vm_area) != NULL)
> @@ -352,10 +386,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
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
> @@ -809,6 +839,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>         if (!stack)
>                 goto free_tsk;
>
> +       memcg_charge_kernel_stack(tsk);
> +
>         stack_vm_area = task_stack_vm_area(tsk);
>
>         err = arch_dup_task_struct(tsk, orig);
> --
> 2.14.4
>
