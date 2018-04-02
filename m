Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeDBJK4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:10:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38091 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeDBJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:10:54 -0400
X-Google-Smtp-Source: AIpwx49HGNAXLl/naw4ms3mpA5Bnmj26hjiBayC4DMjt5lxNln//RB3vDE1eERNnb+Q0DFUnQybspA==
Date: Mon, 2 Apr 2018 11:10:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/apic changes for v4.17
Message-ID: <20180402091048.fzyog2ypghquwn7m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-apic-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

   # HEAD: e25283bf83bd97a61007ab383695f4872e2eb43f x86/apic: Finish removing unused callbacks

The main x86 APIC/IOAPIC changes in this cycle were:

 - Robustify kexec support to more carefully restore
   IRQ hardware state before  calling into
   kexec/kdump kernels.                                (Baoquan He)

 - Clean up the local APIC code a bit                  (Dou Liyang)

 - Remove unused callbacks                             (David Rientjes)

 Thanks,

	Ingo

------------------>
Baoquan He (6):
      x86/apic: Split out restore_boot_irq_mode() from disable_IO_APIC()
      x86/apic: Split disable_IO_APIC() into two functions to fix CONFIG_KEXEC_JUMP=y
      x86/apic: Fix restoring boot IRQ mode in reboot and kexec/kdump
      x86/apic: Remove the (now) unused disable_IO_APIC() function
      x86/apic: Rename variables and functions related to x86_io_apic_ops
      x86/apic: Set up through-local-APIC mode on the boot CPU if 'noapic' specified

David Rientjes (1):
      x86/apic: Finish removing unused callbacks

Dou Liyang (6):
      x86/x2apic: Mark set_x2apic_phys_mode() as __init
      x86/apic: Simplify init_bsp_APIC() usage
      x86/apic: Make setup_local_APIC() static
      x86/apic: Move pending interrupt check code into it's own function
      x86/apic: Modernize the pending interrupt code
      x86/apic: Drop logical_smp_processor_id() inline


 arch/x86/include/asm/apic.h        |  18 +-----
 arch/x86/include/asm/io_apic.h     |  10 ++--
 arch/x86/include/asm/smp.h         |  10 ----
 arch/x86/include/asm/x86_init.h    |   8 +--
 arch/x86/kernel/apic/apic.c        | 111 ++++++++++++++++++++-----------------
 arch/x86/kernel/apic/io_apic.c     |  16 ++----
 arch/x86/kernel/apic/x2apic_phys.c |   2 +-
 arch/x86/kernel/crash.c            |   3 +-
 arch/x86/kernel/irqinit.c          |   9 ++-
 arch/x86/kernel/machine_kexec_32.c |   8 +--
 arch/x86/kernel/machine_kexec_64.c |   8 +--
 arch/x86/kernel/reboot.c           |   3 +-
 arch/x86/kernel/x86_init.c         |   6 +-
 arch/x86/xen/apic.c                |   2 +-
 drivers/iommu/irq_remapping.c      |   4 +-
 15 files changed, 101 insertions(+), 117 deletions(-)
