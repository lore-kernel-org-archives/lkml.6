Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902AD2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaMDLXX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902AD2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJWStC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:49:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51615 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWStC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:49:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so1180794wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RZPBUiPopZmbs84/9PzGIYGLWp02pyylts5VvBjyjV8=;
        b=iaMDLXX/2/PR0BlWOvlPfPJCyB8mU0EtMYJj6JK6Cy+7ncMfGO+RU7LYBtx0/qVoZN
         t+KF943LppjryK8Zq8HwjWI9bL7agk81BVdZUhZSo5fkL6P9efqxhzqT1mhMTfr7vBbM
         +nErvsdWEHl5FtCMQQ9p7n6CuYpY9veYg5KbYZMqFIu1TnszqMd1ADbFVg7uLmSTPKrr
         wPOEz6qfBndOTxZnGGH/xJbk1Cew4eaC0Iy7ce7GvtYfZ9TAmpLN0NIERDCnCb81YhUC
         riSKMH5GuYOKoPhXr/aJhtxdHGeEmKCNTV97+M2U/QVb26oh46X2u+7rSrE96PU7Z/6w
         3bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=RZPBUiPopZmbs84/9PzGIYGLWp02pyylts5VvBjyjV8=;
        b=QK6crzjzg0di631HPvgoaXkfvinYvm9uU9ElY5+bzTkUy0aQY8aGwyO+iMzYgiGqnO
         jAPZ6agNVUxioHLWIAZ1TQCzzTXUFoSRD6wLnF1szlka+IZIohjmc5mIShHXIE36OEIo
         RjnKD2kUISH5qi8dHfMJrjpTOGb9j8T7VftsJD1UgCJHOK/O1/OLU6KKXKLwdyqyVrEC
         OtkL4jfpiIW0dn+Lj/7IQE69jcRMBYXZmRmuzRt0SYxjshtSb16nVS4Eza5GlSD+KbQn
         KL4FNUQeaBk2eVN9oLAtWFcq5PMtKpnuRC/kKFBePfGQofDrTRJyKyBRUbXW+xMqhpYY
         uyKg==
X-Gm-Message-State: ABuFfohdl21SrXn2V8K/0RgZTkoaN1zhLcR3eAn+atlQ2Il70qOQbHpy
        snQ8PmVYSOE96zBFLhI0Ieo=
X-Google-Smtp-Source: ACcGV62c6bRHet2iWOmcNr56Opi9TvP0K9CEr8n0MlwLeWAfXGU3LHQcMxfYL3SPt3MonMN0AqvOoQ==
X-Received: by 2002:a1c:8a55:: with SMTP id m82-v6mr19011313wmd.70.1540290370804;
        Tue, 23 Oct 2018 03:26:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c24-v6sm1737652wre.44.2018.10.23.03.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:26:10 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:26:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking and misc x86 updates for v4.20
Message-ID: <20181023102607.GA43138@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: 01a14bda11add9dcd4a59200f13834d634559935 locking/lockdep: Make global debug_locks* variables read-mostly

Lots of changes in this cycle - in part because locking/core attracted a 
number of related x86 low level work which was easier to handle in a 
single tree:

 - Linux Kernel Memory Consistency Model updates
   (Alan Stern, Paul E. McKenney, Andrea Parri)

 - lockdep scalability improvements and micro-optimizations (Waiman Long)

 - rwsem improvements (Waiman Long)

 - spinlock micro-optimization (Matthew Wilcox)

 - qspinlocks: Provide a liveness guarantee (more fairness) on x86. 
  (Peter Zijlstra)

 - Add support for relative references in jump tables on arm64, x86 and 
   s390 to optimize jump labels (Ard Biesheuvel, Heiko Carstens)

 - Be a lot less permissive on weird (kernel address) uaccess faults on
   x86: BUG() when uaccess helpers fault on kernel addresses (Jann Horn)

 - macrofy x86 asm statements to un-confuse the GCC inliner. (Nadav Amit)

 - ... and a handful of other smaller changes as well.

 Thanks,

	Ingo

------------------>
Adam Borowski (1):
      x86/defconfig: Enable CONFIG_USB_XHCI_HCD=y

Alan Stern (1):
      tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire

Andrea Parri (1):
      locking/memory-barriers: Replace smp_cond_acquire() with smp_cond_load_acquire()

Andrew Murray (1):
      Documentation/lockstat: Fix trivial typo

Ard Biesheuvel (10):
      jump_label: Abstract jump_entry member accessors
      jump_label: Implement generic support for relative references
      arm64/kernel: jump_label: Switch to relative references
      x86: Add support for 64-bit place relative relocations
      x86/jump_label: Switch to jump_entry accessors
      x86/jump_table: Use relative references
      jump_label: Annotate entries that operate on __init code earlier
      jump_table: Move entries into ro_after_init region
      s390/vmlinux.lds: Move JUMP_TABLE_DATA into output section
      jump_label: Fix NULL dereference bug in __jump_label_mod_update()

Borislav Petkov (1):
      jump_label: Use static_key_linked() accessor

Heiko Carstens (1):
      s390/jump_label: Switch to relative references

Jann Horn (7):
      x86/kprobes: Refactor kprobes_fault() like kprobe_exceptions_notify()
      x86/kprobes: Inline kprobe_exceptions_notify() into do_general_protection()
      x86/kprobes: Stop calling fixup_exception() from kprobe_fault_handler()
      x86/extable: Introduce _ASM_EXTABLE_UA for uaccess fixups
      x86/fault: Plumb error code and fault address through to fault handlers
      x86/fault: BUG() when uaccess helpers fault on kernel addresses
      lkdtm: Test copy_to_user() on bad kernel pointer under KERNEL_DS

Lance Roy (1):
      futex: Replace spin_is_locked() with lockdep

Masahiro Yamada (1):
      x86/build: Remove unused CONFIG_AS_CRC32

Matthew Wilcox (1):
      locking/spinlocks: Remove an instruction from spin and write locks

Nadav Amit (10):
      kbuild/arch/xtensa: Define LINKER_SCRIPT for the linker script
      kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs
      x86/objtool: Use asm macros to work around GCC inlining bugs
      x86/refcount: Work around GCC inlining bug
      x86/alternatives: Macrofy lock prefixes to work around GCC inlining bugs
      x86/bug: Macrofy the BUG table section handling, to work around GCC inlining bugs
      x86/paravirt: Work around GCC inlining bugs when compiling paravirt ops
      x86/extable: Macrofy inline assembly code to work around GCC inlining bugs
      x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs
      x86/jump-labels: Macrofy inline assembly code to work around GCC inlining bugs

Paul E. McKenney (2):
      tools/memory-model: Add litmus-test naming scheme
      tools/memory-model: Add more LKMM limitations

Peter Zijlstra (6):
      jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations
      locking/lockdep, cpu/hotplug: Annotate AP thread
      locking/qspinlock: Re-order code
      locking/qspinlock: Rework some comments
      x86/asm: 'Simplify' GEN_*_RMWcc() macros
      locking/qspinlock, x86: Provide liveness guarantee

SeongJae Park (1):
      tools/memory-model: Fix a README typo

Steven Rostedt (VMware) (1):
      locking/rtmutex: Fix the preprocessor logic with normal #ifdef #else #endif

Waiman Long (11):
      locking/rwsem: Exit read lock slowpath if queue empty & no writer
      locking/rwsem: Make owner store task pointer of last owning reader
      locking/lockdep: Remove add_chain_cache_classes()
      locking/lockdep: Eliminate redundant IRQs check in __lock_acquire()
      locking/lockdep: Add a faster path in __lock_release()
      locking/lockdep: Make class->ops a percpu counter and move it under CONFIG_DEBUG_LOCKDEP=y
      locking/lockdep: Remove duplicated 'lock_class_ops' percpu array
      locking/qspinlock_stat: Count instances of nested lock slowpaths
      locking/pvqspinlock: Extend node size when pvqspinlock is configured
      locking/lockdep: Fix debug_locks off performance problem
      locking/lockdep: Make global debug_locks* variables read-mostly


 Documentation/locking/lockstat.txt                 |   2 +-
 Documentation/memory-barriers.txt                  |   3 +-
 Makefile                                           |   9 +-
 arch/Kconfig                                       |   3 +
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/jump_label.h                |  38 ++---
 arch/arm64/kernel/jump_label.c                     |   6 +-
 arch/s390/Kconfig                                  |   1 +
 arch/s390/include/asm/jump_label.h                 |  40 ++---
 arch/s390/kernel/jump_label.c                      |  11 +-
 arch/s390/kernel/vmlinux.lds.S                     |   1 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/Makefile                                  |   8 +-
 arch/x86/configs/i386_defconfig                    |   1 +
 arch/x86/configs/x86_64_defconfig                  |   1 +
 arch/x86/entry/calling.h                           |   2 +-
 arch/x86/include/asm/alternative-asm.h             |  20 ++-
 arch/x86/include/asm/alternative.h                 |  11 +-
 arch/x86/include/asm/asm.h                         |  57 +++----
 arch/x86/include/asm/atomic.h                      |   8 +-
 arch/x86/include/asm/atomic64_64.h                 |   8 +-
 arch/x86/include/asm/bitops.h                      |   9 +-
 arch/x86/include/asm/bug.h                         |  98 ++++++-----
 arch/x86/include/asm/cpufeature.h                  |  82 +++++----
 arch/x86/include/asm/elf.h                         |   3 +-
 arch/x86/include/asm/extable.h                     |   3 +-
 arch/x86/include/asm/fpu/internal.h                |   2 +-
 arch/x86/include/asm/futex.h                       |   6 +-
 arch/x86/include/asm/jump_label.h                  |  80 ++-------
 arch/x86/include/asm/local.h                       |   8 +-
 arch/x86/include/asm/paravirt_types.h              |  56 +++----
 arch/x86/include/asm/preempt.h                     |   2 +-
 arch/x86/include/asm/ptrace.h                      |   2 +
 arch/x86/include/asm/qspinlock.h                   |  15 ++
 arch/x86/include/asm/refcount.h                    |  79 +++++----
 arch/x86/include/asm/rmwcc.h                       |  69 ++++----
 arch/x86/include/asm/uaccess.h                     |  22 +--
 arch/x86/kernel/cpu/mcheck/mce.c                   |   2 +-
 arch/x86/kernel/jump_label.c                       |  62 +++----
 arch/x86/kernel/kprobes/core.c                     |  38 -----
 arch/x86/kernel/macros.S                           |  16 ++
 arch/x86/kernel/module.c                           |   6 +
 arch/x86/kernel/traps.c                            |  16 +-
 arch/x86/lib/checksum_32.S                         |   4 +-
 arch/x86/lib/copy_user_64.S                        |  90 +++++-----
 arch/x86/lib/csum-copy_64.S                        |   8 +-
 arch/x86/lib/getuser.S                             |  12 +-
 arch/x86/lib/putuser.S                             |  10 +-
 arch/x86/lib/usercopy_32.c                         | 126 +++++++-------
 arch/x86/lib/usercopy_64.c                         |   4 +-
 arch/x86/mm/extable.c                              | 114 +++++++++++--
 arch/x86/mm/fault.c                                |  26 +--
 arch/x86/tools/relocs.c                            |  10 ++
 arch/x86/um/asm/elf.h                              |   3 +-
 arch/xtensa/kernel/Makefile                        |   4 +-
 drivers/misc/lkdtm/core.c                          |   1 +
 drivers/misc/lkdtm/lkdtm.h                         |   1 +
 drivers/misc/lkdtm/usercopy.c                      |  13 ++
 fs/namespace.c                                     |   2 +
 include/asm-generic/bug.h                          |   8 +-
 include/asm-generic/qrwlock.h                      |   7 +-
 include/asm-generic/qspinlock.h                    |  16 +-
 include/asm-generic/vmlinux.lds.h                  |  11 +-
 include/linux/compiler.h                           |  56 +++++--
 include/linux/debug_locks.h                        |   4 +-
 include/linux/jump_label.h                         |  65 ++++++-
 include/linux/lockdep.h                            |   7 +-
 include/linux/rwsem.h                              |   4 +-
 include/linux/sched.h                              |   6 +
 init/main.c                                        |   1 -
 kernel/cpu.c                                       |  28 ++++
 kernel/futex.c                                     |   4 +-
 kernel/jump_label.c                                | 107 ++++++------
 kernel/locking/lockdep.c                           | 116 ++++---------
 kernel/locking/lockdep_internals.h                 |  27 +++
 kernel/locking/lockdep_proc.c                      |   2 +-
 kernel/locking/qspinlock.c                         | 143 +++++++++++-----
 kernel/locking/qspinlock_paravirt.h                |   4 +-
 kernel/locking/qspinlock_stat.h                    |   6 +
 kernel/locking/rtmutex.c                           |   4 +-
 kernel/locking/rwsem-xadd.c                        |  15 +-
 kernel/locking/rwsem.c                             |   7 +-
 kernel/locking/rwsem.h                             |  95 ++++++++---
 kernel/module.c                                    |   9 +
 lib/debug_locks.c                                  |   6 +-
 mm/maccess.c                                       |   6 +
 scripts/Kbuild.include                             |   4 +-
 scripts/mod/Makefile                               |   2 +
 tools/memory-model/Documentation/explanation.txt   | 186 ++++++++++++++++-----
 tools/memory-model/Documentation/recipes.txt       |   2 +-
 tools/memory-model/README                          |  39 +++++
 tools/memory-model/linux-kernel.cat                |   8 +-
 .../ISA2+pooncelock+pooncelock+pombonce.litmus     |   7 +-
 tools/memory-model/litmus-tests/README             | 104 +++++++++++-
 tools/objtool/special.c                            |   4 +-
 95 files changed, 1522 insertions(+), 934 deletions(-)
 create mode 100644 arch/x86/kernel/macros.S

