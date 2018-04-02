Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754266AbeDBJx4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:53:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37212 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbeDBJxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:53:55 -0400
X-Google-Smtp-Source: AIpwx4+cTWFvkjn7vvtpCbLO//Ztf0SJQBtS9ApvZNNyoYEVH7bETiqaPZuLMjuP6WkHP+c560hCzw==
Date: Mon, 2 Apr 2018 11:53:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/msr changes and x86/cleanups for v4.17
Message-ID: <20180402095351.m37vl2o3chizxhye@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: 9b9a51354cae933f5640b5bb73bbcd32f989122f x86/msr: Make rdmsrl_safe_on_cpu() scheduling safe as well

The main change is a performance/latency improvement to /dev/msr access.
The rest are misc cleanups.

 Thanks,

	Ingo

------------------>
Benjamin Gaignard (1):
      x86/rtc: Stop using deprecated functions

Borislav Petkov (3):
      x86/MSR: Move native_* variants to msr.h
      x86/fault: Do not print IP in show_fault_oops()
      x86/dumpstack: Unify show_regs()

Eric Dumazet (3):
      x86/msr: Allow rdmsr_safe_on_cpu() to schedule
      x86/cpuid: Allow cpuid_read() to schedule
      x86/msr: Make rdmsrl_safe_on_cpu() scheduling safe as well


 arch/x86/include/asm/microcode.h  | 14 -----------
 arch/x86/include/asm/msr.h        | 14 +++++++++++
 arch/x86/include/asm/stacktrace.h |  2 --
 arch/x86/kernel/cpuid.c           | 34 ++++++++++++++++++++-------
 arch/x86/kernel/dumpstack.c       | 49 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/dumpstack_32.c    | 42 ---------------------------------
 arch/x86/kernel/dumpstack_64.c    | 42 ---------------------------------
 arch/x86/kernel/rtc.c             |  6 ++---
 arch/x86/kvm/svm.c                |  1 -
 arch/x86/kvm/vmx.c                |  1 -
 arch/x86/lib/msr-smp.c            | 43 ++++++++++++++++++++++------------
 arch/x86/mm/fault.c               |  1 -
 12 files changed, 119 insertions(+), 130 deletions(-)
