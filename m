Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E29C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5F6208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF3L+EpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5F6208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeHWI57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:57:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40775 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeHWI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:57:58 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so1876670plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wj1XemUUKt+sWMbK18LPpypuXw9Fx3dO0U4YjwknLiA=;
        b=GF3L+EpCbLexbgCl5ekMx0YcmbU3N76EnUKqwqyUwkJ+GhtHClWJqBAUio7TctRPU8
         cJblgVgshPqohp/mKoZ37wyUKNf+YFTORKHAvqmVv/X6mwoD2UgExE5Z7kPmsl2b1GBY
         +TBO2/pUihK0B+5kv5FjwcWiI07Ew3bKZMWfItn7tfOO+nu12SNvIyJ9k7KtwUWUMglO
         MUfoo6OQGJTqvMWNYd5813UET4puFKfUq36ecpI8aNNHKqQzbtEP4TJMGPtiOFVXR7lC
         JQAXkENwxBlW7gpsd+kMEOFNKM88sMCsG3bOFAhYTLPNbW6dXI994GRYQZmsDcj3sj+I
         kJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wj1XemUUKt+sWMbK18LPpypuXw9Fx3dO0U4YjwknLiA=;
        b=p/5PqHYwU8Rju8XvfmUHCR3eTZ3qyOAw+EtKSzTIH4YYXwyPRxneua+YFSYYF7xcTz
         qC5v9GZrOgvmCVxmNhxSmMTZFrCnS4dHAFaSjIwRzTXgf9aMrLBYQNquqA9NGGYPO+Ma
         r/1Znx/9Igk1gDZbOUjRP/xvMbinhgoi/z2putV51A8PeGdHn6RPZvLTlIcusugzaStN
         KqHd9QiIBoGTXTkE2HXBiBD3g6zx/IVeGb9Aii9M4PH9hgPx7NuRDuDkkNpRkbdovG0P
         ecN8TB6QMf32kD8rFt2OI7fUdgUGz+Ig4O3Zkw34Xe7+rPo/3+gnyVPF7pGyHiMVn4RH
         kJ0g==
X-Gm-Message-State: AOUpUlEt2ZIadtoi8G7hCwVFaguz8BMzJwRw8ETijZHMeWpSrNgagePN
        8NB8BJYWLJXaf6fJFOhb9vo=
X-Google-Smtp-Source: AA+uWPyhY7dGazaIDoXLwSPvjB8jipt0zZn9UUIuXiYc1mQPMZbfFoJQ2bkosHMURzvJFsdP0Nuo8g==
X-Received: by 2002:a17:902:bf09:: with SMTP id bi9-v6mr17666422plb.76.1535002202866;
        Wed, 22 Aug 2018 22:30:02 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id g15-v6sm7849561pfg.98.2018.08.22.22.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 22:30:00 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:29:56 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: null-ptr-deref Write in binder_update_page_range
Message-ID: <20180823052956.GA28628@rodete-desktop-imager.corp.google.com>
References: <20180822060704.GA12007@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822060704.GA12007@dragonet>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 22, 2018 at 03:07:04PM +0900, Dae R. Jeong wrote:
> Reporting the crash: KASAN: null-ptr-deref Write in binder_update_page_range
> 
> This crash has been found in v4.18-rc3 using RaceFuzzer (a modified
> version of Syzkaller), which we describe more at the end of this
> report.
> 
> Our analysis shows that the race occurs when invoking two syscalls
> concurrently, mmap$binder() and ioctl$BINDER_WRITE_READ. More
> specifically, since two code lines `alloc->vma = vma;` and
> `alloc->vma_vm_mm = vma->vm_mm;` in binder_alloc_mmap_handler() is not
> an atomic operation during mmap$binder() syscall, there is a time
> window that `alloc->vma` is assigned but `alloc->vma_vm_mm` isn't
> assigned. It causes the null pointer dereference in
> binder_alloc_new_buf_locked() since it checks whether `alloc->vma` is
> NULL, but it doesn't check that `alloc->vma_vm_mm` is NULL. More
> details on the thread interleaving and the crash log are follows.
> 
> 
> Thread interleaving:
> CPU0 (binder_alloc_mmap_handler)              CPU1 (binder_alloc_new_buf_locked)
> =====                                         =====
> // drivers/android/binder_alloc.c
> // #L718 (v4.18-rc3)
> alloc->vma = vma;
>                                               // drivers/android/binder_alloc.c
>                                               // #L346 (v4.18-rc3)
>                                               if (alloc->vma == NULL) {
>                                                   ...
>                                                   // alloc->vma is not NULL at this point
>                                                   return ERR_PTR(-ESRCH);
>                                               }
>                                               ...
>                                               // #L438
>                                               binder_update_page_range(alloc, 0,
>                                                       (void *)PAGE_ALIGN((uintptr_t)buffer->data),
>                                                       end_page_addr);
> 
>                                               // In binder_update_page_range() #L218
>                                               // But still alloc->vma_vm_mm is NULL here
>                                               if (need_mm && mmget_not_zero(alloc->vma_vm_mm))
> alloc->vma_vm_mm = vma->vm_mm;
> 
> 
> Crash Log:
> ==================================================================
> BUG: KASAN: null-ptr-deref in __atomic_add_unless include/asm-generic/atomic-instrumented.h:89 [inline]
> BUG: KASAN: null-ptr-deref in atomic_add_unless include/linux/atomic.h:533 [inline]
> BUG: KASAN: null-ptr-deref in mmget_not_zero include/linux/sched/mm.h:75 [inline]
> BUG: KASAN: null-ptr-deref in binder_update_page_range+0xece/0x18e0 drivers/android/binder_alloc.c:218
> Write of size 4 at addr 0000000000000058 by task syz-executor0/11184
> 
> CPU: 1 PID: 11184 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x16e/0x22c lib/dump_stack.c:113
>  kasan_report_error mm/kasan/report.c:352 [inline]
>  kasan_report+0x163/0x380 mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x140/0x1a0 mm/kasan/kasan.c:267
>  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
>  __atomic_add_unless include/asm-generic/atomic-instrumented.h:89 [inline]
>  atomic_add_unless include/linux/atomic.h:533 [inline]
>  mmget_not_zero include/linux/sched/mm.h:75 [inline]
>  binder_update_page_range+0xece/0x18e0 drivers/android/binder_alloc.c:218
>  binder_alloc_new_buf_locked drivers/android/binder_alloc.c:443 [inline]
>  binder_alloc_new_buf+0x467/0xc30 drivers/android/binder_alloc.c:513
>  binder_transaction+0x125b/0x4fb0 drivers/android/binder.c:2957
>  binder_thread_write+0xc08/0x2770 drivers/android/binder.c:3528
>  binder_ioctl_write_read.isra.39+0x24f/0x8e0 drivers/android/binder.c:4456
>  binder_ioctl+0xa86/0xf34 drivers/android/binder.c:4596
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x154/0xd40 fs/ioctl.c:686
>  ksys_ioctl+0x94/0xb0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:706
>  do_syscall_64+0x167/0x4b0 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x456469
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f575f268b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000072bfa0 RCX: 0000000000456469
> RDX: 00000000200003c0 RSI: 00000000c0306201 RDI: 0000000000000016
> RBP: 00000000000001a2 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f575f2696d4
> R13: 00000000ffffffff R14: 00000000006f77d0 R15: 0000000000000000
> ==================================================================
> 
> = About RaceFuzzer
> 
> RaceFuzzer is a customized version of Syzkaller, specifically tailored
> to find race condition bugs in the Linux kernel. While we leverage
> many different technique, the notable feature of RaceFuzzer is in
> leveraging a custom hypervisor (QEMU/KVM) to interleave the
> scheduling. In particular, we modified the hypervisor to intentionally
> stall a per-core execution, which is similar to supporting per-core
> breakpoint functionality. This allows RaceFuzzer to force the kernel
> to deterministically trigger racy condition (which may rarely happen
> in practice due to randomness in scheduling).
> 
> RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
> repro's scheduling synchronization should be performed at the user
> space, its reproducibility is limited (reproduction may take from 1
> second to 10 minutes (or even more), depending on a bug). This is
> because, while RaceFuzzer precisely interleaves the scheduling at the
> kernel's instruction level when finding this bug, C repro cannot fully
> utilize such a feature. Please disregard all code related to
> "should_hypercall" in the C repro, as this is only for our debugging
> purposes using our own hypervisor.

What a amazing tool!

Could you test this patch? I found that bug a month ago but didn't submit
yet.

From 03fb1de4784a0ae34ddd60ab0706ec43b7dfaf8d Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Thu, 23 Aug 2018 14:14:13 +0900
Subject: [PATCH] android: binder: fix the race mmap and alloc_new_buf_locked

There is RaceFuzzer report like below because we have no lock to close
below the race between binder_mmap and binder_alloc_new_buf_locked.
To close the race, let's use memory barrier so that if someone see
alloc->vma is not NULL, alloc->vma_vm_mm should be never NULL.

(I didn't add stable mark intentionallybecause standard android
userspace libraries that interact with binder (libbinder & libhwbinder)
prevent the mmap/ioctl race. - from Todd)

"
Thread interleaving:
CPU0 (binder_alloc_mmap_handler)              CPU1 (binder_alloc_new_buf_locked)
=====                                         =====
// drivers/android/binder_alloc.c
// #L718 (v4.18-rc3)
alloc->vma = vma;
                                              // drivers/android/binder_alloc.c
                                              // #L346 (v4.18-rc3)
                                              if (alloc->vma == NULL) {
                                                  ...
                                                  // alloc->vma is not NULL at this point
                                                  return ERR_PTR(-ESRCH);
                                              }
                                              ...
                                              // #L438
                                              binder_update_page_range(alloc, 0,
                                                      (void *)PAGE_ALIGN((uintptr_t)buffer->data),
                                                      end_page_addr);

                                              // In binder_update_page_range() #L218
                                              // But still alloc->vma_vm_mm is NULL here
                                              if (need_mm && mmget_not_zero(alloc->vma_vm_mm))
alloc->vma_vm_mm = vma->vm_mm;

Crash Log:
==================================================================
BUG: KASAN: null-ptr-deref in __atomic_add_unless include/asm-generic/atomic-instrumented.h:89 [inline]
BUG: KASAN: null-ptr-deref in atomic_add_unless include/linux/atomic.h:533 [inline]
BUG: KASAN: null-ptr-deref in mmget_not_zero include/linux/sched/mm.h:75 [inline]
BUG: KASAN: null-ptr-deref in binder_update_page_range+0xece/0x18e0 drivers/android/binder_alloc.c:218
Write of size 4 at addr 0000000000000058 by task syz-executor0/11184

CPU: 1 PID: 11184 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x16e/0x22c lib/dump_stack.c:113
 kasan_report_error mm/kasan/report.c:352 [inline]
 kasan_report+0x163/0x380 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x140/0x1a0 mm/kasan/kasan.c:267
 kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
 __atomic_add_unless include/asm-generic/atomic-instrumented.h:89 [inline]
 atomic_add_unless include/linux/atomic.h:533 [inline]
 mmget_not_zero include/linux/sched/mm.h:75 [inline]
 binder_update_page_range+0xece/0x18e0 drivers/android/binder_alloc.c:218
 binder_alloc_new_buf_locked drivers/android/binder_alloc.c:443 [inline]
 binder_alloc_new_buf+0x467/0xc30 drivers/android/binder_alloc.c:513
 binder_transaction+0x125b/0x4fb0 drivers/android/binder.c:2957
 binder_thread_write+0xc08/0x2770 drivers/android/binder.c:3528
 binder_ioctl_write_read.isra.39+0x24f/0x8e0 drivers/android/binder.c:4456
 binder_ioctl+0xa86/0xf34 drivers/android/binder.c:4596
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x154/0xd40 fs/ioctl.c:686
 ksys_ioctl+0x94/0xb0 fs/ioctl.c:701
 __do_sys_ioctl fs/ioctl.c:708 [inline]
 __se_sys_ioctl fs/ioctl.c:706 [inline]
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:706
 do_syscall_64+0x167/0x4b0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
"

Signed-off-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/android/binder_alloc.c | 43 +++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 3f3b7b253445..64fd96eada31 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -332,6 +332,35 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	return vma ? -ENOMEM : -ESRCH;
 }
 
+
+static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
+		struct vm_area_struct *vma)
+{
+	if (vma)
+		alloc->vma_vm_mm = vma->vm_mm;
+	/*
+	 * If we see alloc->vma is not NULL, buffer data structures set up
+	 * completely. Look at smp_rmb side binder_alloc_get_vma.
+	 * We also want to guarantee new alloc->vma_vm_mm is always visible
+	 * if alloc->vma is set.
+	 */
+	smp_wmb();
+	alloc->vma = vma;
+}
+
+static inline struct vm_area_struct *binder_alloc_get_vma(
+		struct binder_alloc *alloc)
+{
+	struct vm_area_struct *vma = NULL;
+
+	if (alloc->vma) {
+		/* Look at description in binder_alloc_set_vma */
+		smp_rmb();
+		vma = alloc->vma;
+	}
+	return vma;
+}
+
 static struct binder_buffer *binder_alloc_new_buf_locked(
 				struct binder_alloc *alloc,
 				size_t data_size,
@@ -348,7 +377,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
-	if (alloc->vma == NULL) {
+	if (!binder_alloc_get_vma(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
@@ -723,9 +752,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	barrier();
-	alloc->vma = vma;
-	alloc->vma_vm_mm = vma->vm_mm;
+	binder_alloc_set_vma(alloc, vma);
 	mmgrab(alloc->vma_vm_mm);
 
 	return 0;
@@ -754,10 +781,10 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 	int buffers, page_count;
 	struct binder_buffer *buffer;
 
-	BUG_ON(alloc->vma);
-
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
+	BUG_ON(alloc->vma);
+
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 
@@ -900,7 +927,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	WRITE_ONCE(alloc->vma, NULL);
+	binder_alloc_set_vma(alloc, NULL);
 }
 
 /**
@@ -935,7 +962,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 	index = page - alloc->pages;
 	page_addr = (uintptr_t)alloc->buffer + index * PAGE_SIZE;
-	vma = alloc->vma;
+	vma = binder_alloc_get_vma(alloc);
 	if (vma) {
 		if (!mmget_not_zero(alloc->vma_vm_mm))
 			goto err_mmget;
-- 
2.18.0.1017.ga543ac7ca45-goog




