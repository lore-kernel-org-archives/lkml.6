Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDABC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DE72147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfAGTxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfAGTxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 825CA218A1;
        Mon,  7 Jan 2019 19:53:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1ggaxn-0000GD-Gz; Mon, 07 Jan 2019 14:53:31 -0500
Message-Id: <20190107195252.599921907@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Jan 2019 14:52:52 -0500
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
Subject: [PATCH RT 00/13] Linux 4.14.87-rt50-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.14.87-rt50-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 01/09/2019.

Enjoy,

-- Steve


To build 4.14.87-rt50-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.87.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.87-rt50-rc1.patch.xz

You can also build from 4.14.87-rt49 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.87-rt49-rt50-rc1.patch.xz


Changes from 4.14.87-rt49:

---


Clark Williams (1):
      mm/kasan: make quarantine_lock a raw_spinlock_t

He Zhe (1):
      kmemleak: Turn kmemleak_lock to raw spinlock on RT

Julia Cartwright (1):
      kthread: convert worker lock to raw spinlock

Kurt Kanzenbach (1):
      tty: serial: pl011: explicitly initialize the flags variable

Lukas Wunner (1):
      pinctrl: bcm2835: Use raw spinlock for RT compatibility

Sebastian Andrzej Siewior (7):
      work-simple: drop a shit statement in SWORK_EVENT_PENDING
      sched/migrate_disable: Add export_symbol_gpl for __migrate_disabled
      rcu: make RCU_BOOST default on RT without EXPERT
      x86/fpu: Disable preemption around local_bh_disable()
      hrtimer: move state change before hrtimer_cancel in do_nanosleep()
      drm/i915: disable tracing on -RT
      x86/mm/pat: disable preemption __split_large_page() after spin_lock()

Steven Rostedt (VMware) (1):
      Linux 4.14.87-rt50-rc1

----
 arch/x86/kernel/fpu/signal.c          |  2 ++
 arch/x86/mm/pageattr.c                |  8 +++++++
 drivers/gpu/drm/i915/i915_trace.h     |  4 ++++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 16 ++++++-------
 drivers/tty/serial/amba-pl011.c       |  2 +-
 include/linux/kthread.h               |  2 +-
 kernel/kthread.c                      | 42 +++++++++++++++++------------------
 kernel/rcu/Kconfig                    |  4 ++--
 kernel/sched/core.c                   |  1 +
 kernel/sched/swork.c                  |  2 +-
 kernel/time/hrtimer.c                 |  2 +-
 localversion-rt                       |  2 +-
 mm/kasan/quarantine.c                 | 18 +++++++--------
 mm/kmemleak.c                         | 20 ++++++++---------
 14 files changed, 70 insertions(+), 55 deletions(-)
