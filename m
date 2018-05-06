Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeEFTUK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 15:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeEFTUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 15:20:09 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/9] breakpoint: Rework arch validation
Date: Sun,  6 May 2018 21:19:46 +0200
Message-Id: <1525634395-23380-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first round of breakpoint code rework and cleanup. Here we
split up architecture validation and commit so that we don't mess up
with architecture internals in case attributes are rejected or slot
can't be reserved. It also unconfuse the code in general.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	perf/breakpoint

HEAD: 0a788eff09988e58708c4a3ce7b8441ce3e7df95

Thanks,
	Frederic
---

Frederic Weisbecker (9):
      x86/breakpoint: Split validation into "check" and "commit"
      sh: Remove "struct arch_hw_breakpoint::name" unused field
      sh: Split breakpoint validation into "check" and "commit"
      arm: Split breakpoint validation into "check" and "commit"
      xtensa: Split breakpoint validation into "check" and "commit"
      arm64: Split breakpoint validation into "check" and "commit"
      powerpc: Split breakpoint validation into "check" and "commit"
      perf/breakpoint: Split breakpoint "check" and "commit"
      perf/breakpoint: Only commit breakpoint to arch upon slot reservation success


 arch/arm/include/asm/hw_breakpoint.h     |   5 +-
 arch/arm/kernel/hw_breakpoint.c          | 160 +++++++++++++++-------------
 arch/arm64/include/asm/hw_breakpoint.h   |   5 +-
 arch/arm64/kernel/hw_breakpoint.c        | 173 +++++++++++++++++++------------
 arch/powerpc/include/asm/hw_breakpoint.h |   5 +-
 arch/powerpc/kernel/hw_breakpoint.c      |  66 ++++++------
 arch/sh/include/asm/hw_breakpoint.h      |   6 +-
 arch/sh/kernel/hw_breakpoint.c           | 102 ++++++++----------
 arch/x86/include/asm/hw_breakpoint.h     |   5 +-
 arch/x86/kernel/hw_breakpoint.c          | 140 ++++++++++++-------------
 arch/xtensa/include/asm/hw_breakpoint.h  |   5 +-
 arch/xtensa/kernel/hw_breakpoint.c       |  54 ++++++----
 kernel/events/hw_breakpoint.c            |  78 ++++++++------
 13 files changed, 443 insertions(+), 361 deletions(-)
