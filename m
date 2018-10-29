Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DA4C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFF620824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFF620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeJ3BZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:25:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:32963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbeJ3BZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:25:15 -0400
Received: from homer.simpson.net ([185.191.216.94]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhfN3-1fmBLw25NR-00modx; Mon, 29
 Oct 2018 17:35:41 +0100
Received: from homer.simpson.net ([185.191.216.94]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhfN3-1fmBLw25NR-00modx; Mon, 29
 Oct 2018 17:35:41 +0100
Message-ID: <1540830938.10478.4.camel@gmx.de>
Subject: Re: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
From:   Mike Galbraith <efault@gmx.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>
Date:   Mon, 29 Oct 2018 17:35:38 +0100
In-Reply-To: <20181029132035.GI32673@dhcp22.suse.cz>
References: <1540792855.22373.34.camel@gmx.de>
         <20181029132035.GI32673@dhcp22.suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jMIZLahaLMf/Uy4/LHdHXLCHRqscKhNxj05g5SUY7JVhR7dvHxZ
 RVEy/p/BhFKHFOBP0o9oVQtIx+5fI6iVFLhJLriAhP8hkl7DGoW121lW954i29eanfUQEkG
 o/I17rFAT85gKF4kYtLGV8+wkLTcICWLS97TM3myojfCGEmhIZFg1ZJPRXUdVZaEiPfXakX
 hnBg63t1IL+OqpWYIeb2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hel/YVdJwic=:ZIlTJNLhJ6XXlHod8bTc3r
 JDYXVTlFz21yuarjO1VBtfB8+0voti02jYj6eyDI95f5EtqM+u0LlxKsxRZY4BL+xgxrPgFBB
 Gl6lkyufMCFr/79AOrwghtObnM8nQSyACOR/thAgfoH72OmuMhQN5IpdKn8vYFasgh9CaGpUg
 td1CtXc1buk6DTtrnkoHt5/gXQLmWTI0AYJAqDRUUARJ3InCagoGSq7Y0PXlZM8Sov2Gjyx95
 tG+ComU/tVzTCmBVBsJmI35rDligBUqhC8DcwuYgO1xRVcCAGPJMVc5e2auyMF5RrciXjg49a
 e3vk83qn92Nfsj1YGwJkIBnXPK5pQysYIJ6/8A29MTmxDm59gTC6seS1tM8JJStpf98RU8DMz
 cWlkA5rmk7v8b/2AQ5HD1tvb77E51fz0ldDzmu/6oRtABiaN73IjoHiTLuRsqD8BCyKTv1IT1
 1t07YwDKgeTHkxYKqRrwdWF6SB5ukITqlXFSXFoaglddGkvXRYwmLQ76S7XKgDqBw51WCqRr7
 FGcEdyANfUU2QYlRHtAuaiYKc2nMcOzfUTfMGUDN2qc115Ilr1uzJWKJ13fUkTvpQeAL/SfyG
 mg3lhpl4KjOyQBhGiEAkbzOT/2OG+FkBl6ue7IndaTDOiecChglE1qszE0J8UmkAy9BvhMTFB
 AJ8W6qZ10Xn2YiNX0ROZpH4lB7xFFGx+204sVA0SIlpB+1T4wjavEZ6CpQ48eLrJeUSA/Gy+I
 KzSlzHUQxImzBDeMvE86k1+8BJI0f33DNw/KCqgJ5pWPN42yLqngM4vdqNFIFCKX6syHBnqVb
 Oa8o3WFKfa1g+UjqwshmdUYDksHRkRuVSRiaYkRvEFr3l8OznI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 14:20 +0100, Michal Hocko wrote:
> 
> > [    4.420976] Code: f3 c3 0f 1f 00 0f 1f 44 00 00 48 85 ff 0f 84 a8 00 00 00 41 56 48 89 f8 41 55 49 89 fe 41 54 49 89 d5 55 49 89 f4 53 48 89 f3 <f0> 48 0f c1 1f 48 01 f3 48 39 5f 18 48 89 fd 73 17 eb 41 48 89 e8
> > [    4.424162] RSP: 0018:ffffb27840c57cb0 EFLAGS: 00010202
> > [    4.425236] RAX: 00000000000000f8 RBX: 0000000000000020 RCX: 0000000000000200
> > [    4.426467] RDX: ffffb27840c57d08 RSI: 0000000000000020 RDI: 00000000000000f8
> > [    4.427652] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffb278410bc000
> > [    4.428883] R10: ffffb27840c57ed0 R11: 0000000000000040 R12: 0000000000000020
> > [    4.430168] R13: ffffb27840c57d08 R14: 00000000000000f8 R15: 00000000006000c0
> > [    4.431411] FS:  00007f79081a3940(0000) GS:ffff92a4b7bc0000(0000) knlGS:0000000000000000
> > [    4.432748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    4.433836] CR2: 00000000000000f8 CR3: 00000002310ac002 CR4: 00000000001606e0
> > [    4.435500] Call Trace:
> > [    4.436319]  try_charge+0x92/0x7b0
> > [    4.437284]  ? unlazy_walk+0x4c/0xb0
> > [    4.438676]  ? terminate_walk+0x91/0x100
> > [    4.439984]  memcg_kmem_charge_memcg+0x28/0x80
> > [    4.441059]  memcg_kmem_charge+0x88/0x1d0
> > [    4.442105]  copy_process.part.37+0x23a/0x2070
> 
> Could you faddr2line this please?

homer:/usr/local/src/kernel/linux-master # ./scripts/faddr2line vmlinux copy_process.part.37+0x23a
copy_process.part.37+0x23a/0x2070:
memcg_charge_kernel_stack at kernel/fork.c:401
(inlined by) dup_task_struct at kernel/fork.c:850
(inlined by) copy_process at kernel/fork.c:1750

I bisected it this afternoon, and confirmed the result via revert.

9b6f7e163cd0f468d1b9696b785659d3c27c8667 is the first bad commit
commit 9b6f7e163cd0f468d1b9696b785659d3c27c8667
Author: Roman Gushchin <guro@fb.com>
Date:   Fri Oct 26 15:03:19 2018 -0700

    mm: rework memcg kernel stack accounting
    
    If CONFIG_VMAP_STACK is set, kernel stacks are allocated using
    __vmalloc_node_range() with __GFP_ACCOUNT.  So kernel stack pages are
    charged against corresponding memory cgroups on allocation and uncharged
    on releasing them.
    
    The problem is that we do cache kernel stacks in small per-cpu caches and
    do reuse them for new tasks, which can belong to different memory cgroups.
    
    Each stack page still holds a reference to the original cgroup, so the
    cgroup can't be released until the vmap area is released.
    
    To make this happen we need more than two subsequent exits without forks
    in between on the current cpu, which makes it very unlikely to happen.  As
    a result, I saw a significant number of dying cgroups (in theory, up to 2
    * number_of_cpu + number_of_tasks), which can't be released even by
    significant memory pressure.
    
    As a cgroup structure can take a significant amount of memory (first of
    all, per-cpu data like memcg statistics), it leads to a noticeable waste
    of memory.
    
    Link: http://lkml.kernel.org/r/20180827162621.30187-1-guro@fb.com
    Fixes: ac496bf48d97 ("fork: Optimize task creation by caching two thread stacks per CPU if CONFIG_VMAP_STACK=y")
    Signed-off-by: Roman Gushchin <guro@fb.com>
    Reviewed-by: Shakeel Butt <shakeelb@google.com>
    Acked-by: Michal Hocko <mhocko@kernel.org>
    Cc: Johannes Weiner <hannes@cmpxchg.org>
    Cc: Andy Lutomirski <luto@kernel.org>
    Cc: Konstantin Khlebnikov <koct9i@gmail.com>
    Cc: Tejun Heo <tj@kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 19a916f067fb987c6b15ce04f0e656c590db39dd edde98ce70d28e03f623f86f54887720516fcd91 M      include
:040000 040000 04213da714a8a10580baccd0b0977a6744fa2374 9204198e8eb4043b059f2a4eeaa4e19679fd3ddb M      kernel

git bisect start
# good: [e5f6d9afa3415104e402cd69288bb03f7165eeba] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc
git bisect good e5f6d9afa3415104e402cd69288bb03f7165eeba
# bad: [345671ea0f9258f410eb057b9ced9cefbbe5dc78] Merge branch 'akpm' (patches from Andrew)
git bisect bad 345671ea0f9258f410eb057b9ced9cefbbe5dc78
# bad: [ae2b01f37044c10e975d22116755df56252b09d8] mm: remove vm_insert_pfn()
git bisect bad ae2b01f37044c10e975d22116755df56252b09d8
# good: [9703fc8caf36ac65dca1538b23dd137de0b53233] Merge tag 'usb-4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good 9703fc8caf36ac65dca1538b23dd137de0b53233
# good: [bf58e8820c48805394ec9e76339f0c4646050432] nvmem: change the signature of nvmem_unregister()
git bisect good bf58e8820c48805394ec9e76339f0c4646050432
# good: [cccb3b19e762edc8ef0481be506967555cb9e317] nvmem: fix nvmem_cell_get_from_lookup()
git bisect good cccb3b19e762edc8ef0481be506967555cb9e317
# good: [18d0eae30e6a4f8644d589243d7ac1d70d29203d] Merge tag 'char-misc-4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 18d0eae30e6a4f8644d589243d7ac1d70d29203d
# bad: [9b6f7e163cd0f468d1b9696b785659d3c27c8667] mm: rework memcg kernel stack accounting
git bisect bad 9b6f7e163cd0f468d1b9696b785659d3c27c8667
# good: [2de24cb742d4f0c41358aa078bed7f089c827ac7] ocfs2: remove unused pointer 'eb'
git bisect good 2de24cb742d4f0c41358aa078bed7f089c827ac7
# good: [5780a02fd1e87641ad6a8dd6891a1e890cf45c5d] fs/iomap.c: change return type to vm_fault_t
git bisect good 5780a02fd1e87641ad6a8dd6891a1e890cf45c5d
# good: [0684e6526edfb4debf0a0a884834bb1a104085dc] mm/slub.c: switch to bitmap_zalloc()
git bisect good 0684e6526edfb4debf0a0a884834bb1a104085dc
# good: [c5fd3ca06b4699e251b4a1fb808c2d5124494101] slub: extend slub debug to handle multiple slabs
git bisect good c5fd3ca06b4699e251b4a1fb808c2d5124494101
# first bad commit: [9b6f7e163cd0f468d1b9696b785659d3c27c8667] mm: rework memcg kernel stack accounting

	-Mike
