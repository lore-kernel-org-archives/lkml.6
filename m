Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF4DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75D42075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75D42075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeIHBmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbeIHBmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:13 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A092075B;
        Fri,  7 Sep 2018 20:59:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNqj-0001h2-Mm; Fri, 07 Sep 2018 16:59:29 -0400
Message-Id: <20180907205857.262840394@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:58:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 00/24] Linux 4.14.63-rt41-rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.14.63-rt41-rc2.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 9/10/2018.

Enjoy,

-- Steve


To build 4.14.63-rt41-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.63.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.63-rt41-rc2.patch.xz

You can also build from 4.14.63-rt40 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.63-rt40-rt41-rc2.patch.xz


Changes from 4.14.63-rt40:

---


Anna-Maria Gleixner (1):
      Revert "timer: delay waking softirqs from the jiffy tick"

Daniel Bristot de Oliveira (1):
      sched/core: Avoid __schedule() being called twice in a row

Julia Cartwright (3):
      locallock: provide {get,put}_locked_ptr() variants
      squashfs: make use of local lock in multi_cpu decompressor
      seqlock: provide the same ordering semantics as mainline

Marc Zyngier (1):
      irqchip/gic-v3-its: Move pending table allocation to init time

Mike Galbraith (3):
      sched/fair: Fix CFS bandwidth control lockdep DEADLOCK report
      crypto: scompress - serialize RT percpu scratch buffer access with a local lock
      sched: Allow pinned user tasks to be awakened to the CPU they pinned

Sebastian Andrzej Siewior (12):
      PM / suspend: Prevent might sleep splats (updated)
      PM / wakeup: Make events_lock a RAW_SPINLOCK
      PM / s2idle: Make s2idle_wait_head swait based
      Revert "x86: UV: raw_spinlock conversion"
      irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
      sched/migrate_disable: fallback to preempt_disable() instead barrier()
      irqchip/gic-v3-its: Move ITS' ->pend_page allocation into an early CPU up hook
      efi: Allow efi=runtime
      efi: Disable runtime services on RT
      crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
      Revert "arm64/xen: Make XEN depend on !RT"
      Drivers: hv: vmbus: include header for get_irq_regs()

Steven Rostedt (VMware) (2):
      Revert "softirq: keep the 'softirq pending' check RT-only"
      Linux 4.14.63-rt41-rc2

Thomas Gleixner (1):
      x86/ioapic: Don't let setaffinity unmask threaded EOI interrupt too early

----
 arch/arm64/Kconfig                      |  2 +-
 arch/x86/include/asm/uv/uv_bau.h        | 14 +++----
 arch/x86/kernel/apic/io_apic.c          | 26 +++++++------
 arch/x86/platform/uv/tlb_uv.c           | 26 ++++++-------
 arch/x86/platform/uv/uv_time.c          | 20 ++++------
 crypto/cryptd.c                         | 19 +++++-----
 crypto/scompress.c                      |  6 ++-
 drivers/base/power/wakeup.c             | 18 ++++-----
 drivers/firmware/efi/efi.c              |  5 ++-
 drivers/hv/hyperv_vmbus.h               |  1 +
 drivers/irqchip/irq-gic-v3-its.c        | 67 ++++++++++++++++++++++-----------
 fs/squashfs/decompressor_multi_percpu.c | 16 ++++++--
 include/linux/irqchip/arm-gic-v3.h      |  1 +
 include/linux/locallock.h               | 10 +++++
 include/linux/preempt.h                 |  6 +--
 include/linux/sched.h                   |  4 +-
 include/linux/seqlock.h                 |  1 +
 kernel/power/suspend.c                  |  9 +++--
 kernel/sched/core.c                     | 34 +++++++++--------
 kernel/sched/debug.c                    |  2 +-
 kernel/sched/fair.c                     |  4 +-
 kernel/softirq.c                        |  7 +---
 kernel/time/tick-common.c               |  2 +
 kernel/time/timer.c                     |  2 +-
 localversion-rt                         |  2 +-
 25 files changed, 176 insertions(+), 128 deletions(-)
