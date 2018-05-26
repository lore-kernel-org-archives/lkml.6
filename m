Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeEZNKi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 09:10:38 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35924 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeEZNKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 09:10:36 -0400
X-Google-Smtp-Source: ADUXVKJ/VlGlcFdZ2XqxSPIy4irCb5Uhdo4b2IiaxclnvyjDP77K3OZJxz8p98MS6YxpI9RNoyLQ5Nyv9BdQ0AtiwJQ=
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Sat, 26 May 2018 15:10:15 +0200
X-Google-Sender-Auth: FiEbkXsFrQPCD9NH1c51jNRoBmE
Message-ID: <CA+7wUsxMuG=aDbqpJ+VpddoQv0eL4ca7jbVe=zFC2bCWztgY1Q@mail.gmail.com>
Subject: WARNING: CPU: 0 PID: 1 at ../kernel/kthread.c:486 kthread_park+0xac/0xe0
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I am seeing a new warning in dmesg on my Mac Mini G4 (ppc32), which
seems to refer to commit 85f1abe0019fc (*). Does this means there is
an issue on my setup ?

Thanks,

(*)
[    0.006350] MPC7450 family performance monitor hardware support registered
[    0.007544] WARNING: CPU: 0 PID: 1 at ../kernel/kthread.c:486
kthread_park+0xac/0xe0
[    0.007562] Modules linked in:
[    0.007577] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc6+ #19
[    0.007587] NIP:  c008db50 LR: c0095044 CTR: c008dab0
[    0.007597] REGS: df4ebdd0 TRAP: 0700   Not tainted  (4.17.0-rc6+)
[    0.007606] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 42000248  XER: 00000000
[    0.007627]
               GPR00: c0095044 df4ebe80 df4f0000 df4f3d40 c0ce21f8
c0a32d84 00000000 df4f0000
               GPR08: 00000000 00000000 00000000 00001032 42000242
00000000 c00049d4 00000000
               GPR16: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
               GPR24: 00000000 00000000 c0a869e0 00000000 c0cf0000
df4f3d40 00000001 df4d4240
[    0.007718] NIP [c008db50] kthread_park+0xac/0xe0
[    0.007734] LR [c0095044] smpboot_update_cpumask_percpu_thread+0x68/0xcc
[    0.007743] Call Trace:
[    0.007759] [df4ebe80] [c0ce21f8] 0xc0ce21f8 (unreliable)
[    0.007776] [df4ebea0] [c0095044]
smpboot_update_cpumask_percpu_thread+0x68/0xcc
[    0.007797] [df4ebec0] [c013dd9c] lockup_detector_reconfigure+0x34/0xd0
[    0.007817] [df4ebed0] [c0999b28] lockup_detector_init+0xb4/0xcc
[    0.007832] [df4ebee0] [c09818c4] kernel_init_freeable+0x130/0x444
[    0.007850] [df4ebf30] [c00049f8] kernel_init+0x24/0x118
[    0.007865] [df4ebf40] [c001b2e4] ret_from_kernel_thread+0x5c/0x64
[    0.007877] Instruction dump:
[    0.007888] 7f9d1000 419e0014 7fa3eb78 480108f1 387f000c 487592f5
7fc3f378 80010024
[    0.007914] bba10014 38210020 7c0803a6 4e800020 <0fe00000> 3bc0fff0
4bffffe0 3c60c0b5
[    0.007947] random: get_random_bytes called from
print_oops_end_marker+0x6c/0x90 with crng_init=0
[    0.007968] ---[ end trace 3519922d51100051 ]---
[    0.008497] devtmpfs: initialized
