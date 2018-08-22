Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D23C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D299F214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1DusyXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D299F214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeHVJac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:30:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45132 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeHVJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:30:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so404260pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f1tIdAa0SDuBRsOGDX6A+25oJ+sdBO+NMzXF9RKSto4=;
        b=m1DusyXzN+rEc7EdgRK/kzHGyxIiTgs4qQ1BIMPsEtyJOI9wK0X+PMGyzFI9wFSW8W
         mugKYcaUZ3QaNUzKWCYIntAEQQLOawaHH5UMY7gA1eR5eyw64GHDLO/YEacODNNUDCS+
         +OhE7NV35eeZO11yhVumeNI7gFocdx8ym1+ZKNMRwPomMN9/uHIkAlxC8+dFbjQqLUJe
         2Y5i+HgyYmioaUYGnKq+6cXPaQQUqQscddUMvrWvm+PGTUP0UdbJjXQCysVP06bd5jP6
         uBhFXF19zXKnDrefZOsw5xlGCkCaMTHIA6bu3tDN7Xu9U1MrnzRehMJinsGanrZiDos6
         DkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f1tIdAa0SDuBRsOGDX6A+25oJ+sdBO+NMzXF9RKSto4=;
        b=ERe/Lwnlyb3hM2Um04W9MrukE9O5Egtth3/b0DOqQoK+4D9dDZJ5Ic57DHzICdpW6n
         uPzrM/oBAMbGbaqmbApgQtH2VLPgGfcLMOBQtLCnaGcwy9SM8O9matzFp9i1HwxnJEZp
         ljjXydL+X9nWhetuf2MS+VemgNfffbZA4AZaXoKfxlujPEIQ0IXjVWCh0/JeuZWdTkqY
         Rn66fI0ddEUTuYcFfI4xne3T78eI7aOV9aFt5t/uuLBlukhuF4NpS6ZuFjH6bU2gOsIc
         eNGVaducEob8xsyoPxwrp12XTgxdmIR/JYjJE1zzU1zIzm1nxr2Vby5gbJ8V0egaxDtr
         5K6Q==
X-Gm-Message-State: AOUpUlHWKDAIH2vdvDYyjlWHQ0d9vTQkcl/sqic0Z/BTIs0bMY+tjNig
        Ku9//fsPl/Ja10SXNtb0b3c=
X-Google-Smtp-Source: AA+uWPyu5Rf2uiwsreB6YjViqefnMeT9fbgCIJRLmdRG5ntgC6nhvQh56JCd8FQxROJqQKXShuP9EA==
X-Received: by 2002:a17:902:28a4:: with SMTP id f33-v6mr52693007plb.297.1534918028900;
        Tue, 21 Aug 2018 23:07:08 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id p12-v6sm721747pgr.6.2018.08.21.23.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 23:07:08 -0700 (PDT)
Date:   Wed, 22 Aug 2018 15:07:04 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: KASAN: null-ptr-deref Write in binder_update_page_range
Message-ID: <20180822060704.GA12007@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting the crash: KASAN: null-ptr-deref Write in binder_update_page_range

This crash has been found in v4.18-rc3 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report.

Our analysis shows that the race occurs when invoking two syscalls
concurrently, mmap$binder() and ioctl$BINDER_WRITE_READ. More
specifically, since two code lines `alloc->vma = vma;` and
`alloc->vma_vm_mm = vma->vm_mm;` in binder_alloc_mmap_handler() is not
an atomic operation during mmap$binder() syscall, there is a time
window that `alloc->vma` is assigned but `alloc->vma_vm_mm` isn't
assigned. It causes the null pointer dereference in
binder_alloc_new_buf_locked() since it checks whether `alloc->vma` is
NULL, but it doesn't check that `alloc->vma_vm_mm` is NULL. More
details on the thread interleaving and the crash log are follows.


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
RIP: 0033:0x456469
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f575f268b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000072bfa0 RCX: 0000000000456469
RDX: 00000000200003c0 RSI: 00000000c0306201 RDI: 0000000000000016
RBP: 00000000000001a2 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f575f2696d4
R13: 00000000ffffffff R14: 00000000006f77d0 R15: 0000000000000000
==================================================================

= About RaceFuzzer

RaceFuzzer is a customized version of Syzkaller, specifically tailored
to find race condition bugs in the Linux kernel. While we leverage
many different technique, the notable feature of RaceFuzzer is in
leveraging a custom hypervisor (QEMU/KVM) to interleave the
scheduling. In particular, we modified the hypervisor to intentionally
stall a per-core execution, which is similar to supporting per-core
breakpoint functionality. This allows RaceFuzzer to force the kernel
to deterministically trigger racy condition (which may rarely happen
in practice due to randomness in scheduling).

RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
repro's scheduling synchronization should be performed at the user
space, its reproducibility is limited (reproduction may take from 1
second to 10 minutes (or even more), depending on a bug). This is
because, while RaceFuzzer precisely interleaves the scheduling at the
kernel's instruction level when finding this bug, C repro cannot fully
utilize such a feature. Please disregard all code related to
"should_hypercall" in the C repro, as this is only for our debugging
purposes using our own hypervisor.
