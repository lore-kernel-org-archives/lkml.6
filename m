Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7B8C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37A12082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAV4IuMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37A12082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeJ3JmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:42:03 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39177 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJ3JmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:42:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id v1-v6so4194523ywv.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 17:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pazZ2jjuF1lMpsQcaolvlkXlmVx6uVBz1h/g98W1bdY=;
        b=gAV4IuMNmyNca9+RgIMzQJzzI9J4QwPM3pZiaPIRlpt5ZvL0Fqy0TzzAlzzQ0lDoIW
         SZSaMssDS2lTnqeunfVn6yvT8hfVLgAhmrdxjevSLztb0UI2NENi2TVqk1yfnXlM+irz
         j9SWM7fDj0onYUhR6PKwa6JW5q49n+UTli6avT7X95qpvE6kFJArkvt+nwMmgALvevgI
         1Axw0OCTXJaCo0lkR4QY+CjV803RfdnBo0vj+1uw/IZMvDz03jhWbeJMKgxsmI3pKg0O
         T6+JTevvZjh71u3P1iPuWAtNOsex+sxVY074SM5Q0YiB6RSci2L208mtXA6XTUTQ9rkW
         hgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pazZ2jjuF1lMpsQcaolvlkXlmVx6uVBz1h/g98W1bdY=;
        b=Wccfq5rMGbQ/77eEVR68wiRjKoGDmhjOyGDZIlsLO8qrG3gEp7QbD3nOcEpSEBqcIM
         vupPLcdbsCyqNVFS9+wg2A+T1dI6l059FoVSeiv1VUmZUoDBMiO6n2LTWng++JBPWTpS
         YONR2vJRit01KqXRvNh8aDmhtx7vMLTqNQpaxu0tCJiJgGaS0YN1fUWL2FhqAdLGdTNS
         YIrqnml+783uRuNDuw1stdHDLK6o11AsYZa4Vu28HJih8qO5om0P0Lve5B804/HnoVBu
         eIq/1ip8fHF6Vb/b02HDlcusV/eJBDJnuCvxHWE9IDFIj2NCZaNUKryqcJIIPRiAc9sm
         P+xQ==
X-Gm-Message-State: AGRZ1gI5ZCiPg8CqJ7rPx4uP3Vz3TqR/u1L71co64BCRP7r6qEVDOjHx
        FNz1ynaguGxOtI2Rx5XOpjY1ogToQfYiL61DcjSFmg==
X-Google-Smtp-Source: AJdET5fhk+2nYsWF1J/Fw7o/BOjVxvafKE4fSCX+GKUC1ezzb8JdHvW/P+NSh5VzAJPyEMLHtHYbCFqDkK9O5O5/400=
X-Received: by 2002:a81:68c6:: with SMTP id d189-v6mr594757ywc.489.1540860648384;
 Mon, 29 Oct 2018 17:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181029215123.17830-1-guro@fb.com>
In-Reply-To: <20181029215123.17830-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 29 Oct 2018 17:50:36 -0700
Message-ID: <CALvZod7tZd6t7d9o8Mj88211McpUH0oANFqESStt7G94-PBbaQ@mail.gmail.com>
Subject: Re: [PATCH] mm: handle no memcg case in memcg_kmem_charge() properly
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>, efault@gmx.de,
        LKML <linux-kernel@vger.kernel.org>, Kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 2:52 PM Roman Gushchin <guro@fb.com> wrote:
>
> Mike Galbraith reported a regression caused by the commit 9b6f7e163cd0
> ("mm: rework memcg kernel stack accounting") on a system with
> "cgroup_disable=memory" boot option: the system panics with the
> following stack trace:
>
>   [0.928542] BUG: unable to handle kernel NULL pointer dereference at 00000000000000f8
>   [0.929317] PGD 0 P4D 0
>   [0.929573] Oops: 0002 [#1] PREEMPT SMP PTI
>   [0.929984] CPU: 0 PID: 1 Comm: systemd Not tainted 4.19.0-preempt+ #410
>   [0.930637] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fed4
>   [0.931862] RIP: 0010:page_counter_try_charge+0x22/0xc0
>   [0.932376] Code: 41 5d c3 c3 0f 1f 40 00 0f 1f 44 00 00 48 85 ff 0f 84 a7 00 00 00 41 56 48 89 f8 49 89 fe 49
>   [0.934283] RSP: 0018:ffffacf68031fcb8 EFLAGS: 00010202
>   [0.934826] RAX: 00000000000000f8 RBX: 0000000000000000 RCX: 0000000000000000
>   [0.935558] RDX: ffffacf68031fd08 RSI: 0000000000000020 RDI: 00000000000000f8
>   [0.936288] RBP: 0000000000000001 R08: 8000000000000063 R09: ffff99ff7cd37a40
>   [0.937021] R10: ffffacf68031fed0 R11: 0000000000200000 R12: 0000000000000020
>   [0.937749] R13: ffffacf68031fd08 R14: 00000000000000f8 R15: ffff99ff7da1ec60
>   [0.938486] FS:  00007fc2140bb280(0000) GS:ffff99ff7da00000(0000) knlGS:0000000000000000
>   [0.939311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [0.939905] CR2: 00000000000000f8 CR3: 0000000012dc8002 CR4: 0000000000760ef0
>   [0.940638] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [0.941366] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [0.942110] PKRU: 55555554
>   [0.942412] Call Trace:
>   [0.942673]  try_charge+0xcb/0x780
>   [0.943031]  memcg_kmem_charge_memcg+0x28/0x80
>   [0.943486]  ? __vmalloc_node_range+0x1e4/0x280
>   [0.943971]  memcg_kmem_charge+0x8b/0x1d0
>   [0.944396]  copy_process.part.41+0x1ca/0x2070
>   [0.944853]  ? get_acl+0x1a/0x120
>   [0.945200]  ? shmem_tmpfile+0x90/0x90
>   [0.945596]  _do_fork+0xd7/0x3d0
>   [0.945934]  ? trace_hardirqs_off_thunk+0x1a/0x1c
>   [0.946421]  do_syscall_64+0x5a/0x180
>   [0.946798]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The problem occurs because get_mem_cgroup_from_current() returns
> the NULL pointer if memory controller is disabled. Let's check
> if this is a case at the beginning of memcg_kmem_charge() and
> just return 0 if mem_cgroup_disabled() returns true. This is how
> we handle this case in many other places in the memory controller
> code.
>
> Fixes: 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 54920cbc46bf..6e1469b80cb7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2593,7 +2593,7 @@ int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
>         struct mem_cgroup *memcg;
>         int ret = 0;
>
> -       if (memcg_kmem_bypass())
> +       if (mem_cgroup_disabled() || memcg_kmem_bypass())
>                 return 0;
>

Why not check memcg_kmem_enabled() before calling memcg_kmem_charge()
in memcg_charge_kernel_stack()?

>         memcg = get_mem_cgroup_from_current();
> --
> 2.17.2
>
