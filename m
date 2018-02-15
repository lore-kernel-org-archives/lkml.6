Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518655117; cv=none;
        d=google.com; s=arc-20160816;
        b=PapD3CcMsgg7GX3LQBdjAh3rPUbMHQzujT11YMpycW+jGh3JDod1wWVmPtOJmJtz/E
         PNyBkJEhKMpZWbvY306WnjMuE2oOMigrDSasQE+owOELQ9z2a4fG/bnBBaHRYWDe5Lxt
         1RPnDSzgQ4QVfVy4hgiIm9xyNl3i5i8MTEFJ6PXYN49Z5FXh/83J5CBo9pAiUFxfFs28
         6eYpYNuPpv5QRFLyc/fEGG7cd4sdfAt0JAw6JSk+T/B56/ZxzbISlrc0F1sQF5l5yaAJ
         jGts/hfSP6O+qemdGh8ScT5bP67dWWvAAxAJoqDcvhOjgd+yFsDX8JsFMWXN9P/QEzvw
         b5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=MwKk41AnPv/dPMlq9dHbxnmq8FjAuSjI5JXma7wbLw4=;
        b=M0sY2JY+0obneCDPCag0vbOzkmsSbNZ/oKLtmY9SamcaLNkRfnxxFVV+Ipe7IVPLJ7
         gcFl/shrveb5dPlOqRXe3RQC4xs3je79B1ZU/SvwP4B7BwQuGHz4imkWNo6FK3GCPAGX
         XpmCTF5iuGtF7mobUbvzGXLBkQ/lj6Vu+uon/Qir/lQVeu1b3r7s17VpXPvX8dS/uLt3
         JVFqYRONKK94H+eeO4qgpdsJgTaFZbOs0TvJyE17hd6Lce1sWKTc5zPy9hbSSZkQl737
         7lbSyax6uA7jddhCNDbsCcW6c5Urk1YfbOb7F+WnK8rKdsjjKL132Sa1yP3e9e2h5TSp
         M9Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a7jXHl8Y;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a7jXHl8Y;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x226TORQlfbYtA7z0gr9A8EApuqQmUltpQBrOhXNEn3tz5rwWMeTmlCERhC3PuPcJSi3ftjovLg==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 15 Feb 2018 01:38:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: [GIT PULL] x86 PTI and Spectre related fixes and updates
Message-ID: <20180215003832.pzi7zbze5vlovp6l@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592425307928838978?=
X-GMAIL-MSGID: =?utf-8?q?1592425307928838978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus,

Please consider pulling the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

   # HEAD: 48753793350974b7afe9598fd1dc46b2f1f47c2d x86/entry/64: Fix CR3 restore in paranoid_exit()

Here's the latest set of Spectre and PTI related fixes and updates:

 - spectre: Add entry code register clearing to reduce the Spectre attack surface
 - spectre: Update the Spectre microcode blacklist
 - spectre: Inline the KVM Spectre helpers to get close to v4.14 performance again.
 - spectre: Fix indirect_branch_prediction_barrier()
 - spectre: Fix/improve Spectre related kernel messages
 - spectre: Fix array_index_nospec_mask() asm constraint
 - spectre: KVM: fix two MSR handling bugs

 -     PTI: Fix a paranoid entry PTI CR3 handling bug
 -     PTI: Fix comments

 - objtool: Fix paranoid_entry() frame pointer warning
 - objtool: Annotate WARN()-related UD2 as reachable
 - objtool: Various fixes
 - objtool: Add Add Peter Zijlstra as objtool co-maintainer

 - generic: Various x86 entry code self-test fixes
 - generic: Improve/simplify entry code stack frame generation and handling after
            recent heavy-handed PTI and Spectre changes.
            (There's two more WIP improvements expected here.)
 - generic: Type fix for cache entries

There's also some low risk non-fix changes I've included in this branch to reduce 
backporting conflicts:

 - generic: rename a confusing x86_cpu field name
 -  x86/mm: de-obfuscate the naming of single-TLB flushing primitives

(Let me know if these are not acceptable and I'll re-do the branch.)

NOTE #1:

   The last ~10 commits were freshly rebased today, because there was an
   authorship misattribution problem in two commits which I noticed only 
   when preparing the pull request, so I did an exact-same-content NOP rebase.

NOTE #2:

   This tree generates two relatively simple conflicts with your tree:

          Conflicts:
              arch/x86/kvm/vmx.c
              tools/testing/selftests/x86/Makefile

   If you want to double check it then both tip:master and linux-next have 
   the same resolutions for these conflicts.

Thanks,

	Ingo

------------------>

Andy Lutomirski (1):
      x86/mm: Rename flush_tlb_single() and flush_tlb_one() to __flush_tlb_one_[user|kernel]()

Borislav Petkov (1):
      x86/entry/64: Remove the unused 'icebp' macro

Dan Carpenter (1):
      x86/spectre: Fix an error message

Dan Williams (4):
      x86/entry/64: Clear extra registers beyond syscall arguments, to reduce speculation attack surface
      x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface
      x86/entry/64/compat: Clear registers for compat syscalls, to reduce speculation attack surface
      x86/speculation: Fix up array_index_nospec_mask() asm constraint

David Woodhouse (4):
      x86/speculation: Update Speculation Control microcode blacklist
      x86/speculation: Correct Speculation Control microcode blacklist again
      Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"
      KVM/x86: Reduce retpoline performance impact in slot_handle_level_range(), by always inlining iterator helper methods

Dominik Brodowski (13):
      x86/entry/64: Merge SAVE_C_REGS and SAVE_EXTRA_REGS, remove unused extensions
      x86/entry/64: Merge the POP_C_REGS and POP_EXTRA_REGS macros into a single POP_REGS macro
      x86/entry/64: Interleave XOR register clearing with PUSH instructions
      x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
      x86/entry/64: Use PUSH_AND_CLEAN_REGS in more cases
      x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros
      x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly
      selftests/x86: Fix vDSO selftest segfault for vsyscall=none
      selftests/x86: Clean up and document sscanf() usage
      selftests/x86: Fix build bug caused by the 5lvl test which has been moved to the VM directory
      selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c
      selftests/x86: Do not rely on "int $0x80" in single_step_syscall.c
      selftests/x86: Disable tests requiring 32-bit support on pure 64-bit systems

Gustavo A. R. Silva (1):
      x86/cpu: Change type of x86_cache_size variable to unsigned int

Ingo Molnar (3):
      x86/speculation: Clean up various Spectre related details
      selftests/x86/pkeys: Remove unused functions
      x86/entry/64: Fix CR3 restore in paranoid_exit()

Jia Zhang (1):
      x86/cpu: Rename cpu_data.x86_mask to cpu_data.x86_stepping

Josh Poimboeuf (3):
      x86/entry/64: Fix paranoid_entry() frame pointer warning
      objtool: Fix segfault in ignore_unreachable_insn()
      x86/debug, objtool: Annotate WARN()-related UD2 as reachable

KarimAllah Ahmed (2):
      X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
      KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR bitmap

Nadav Amit (1):
      x86/mm/pti: Fix PTI comment in entry_SYSCALL_64()

Peter Zijlstra (4):
      objtool: Fix switch-table detection
      MAINTAINERS: Add Peter Zijlstra as objtool co-maintainer
      x86/debug: Use UD2 for WARN()
      x86/speculation: Add <asm/msr-index.h> dependency

Rui Wang (1):
      selftests/x86/mpx: Fix incorrect bounds with old _sigfault

Will Deacon (1):
      nospec: Move array_index_nospec() parameter checking into separate macro


 MAINTAINERS                                       |   1 +
 arch/x86/entry/calling.h                          | 107 ++++++++++------------
 arch/x86/entry/entry_64.S                         |  92 ++++---------------
 arch/x86/entry/entry_64_compat.S                  |  30 ++++++
 arch/x86/events/intel/core.c                      |   2 +-
 arch/x86/events/intel/lbr.c                       |   2 +-
 arch/x86/events/intel/p6.c                        |   2 +-
 arch/x86/include/asm/acpi.h                       |   2 +-
 arch/x86/include/asm/barrier.h                    |   2 +-
 arch/x86/include/asm/bug.h                        |  19 ++--
 arch/x86/include/asm/nospec-branch.h              |  14 ++-
 arch/x86/include/asm/paravirt.h                   |   4 +-
 arch/x86/include/asm/paravirt_types.h             |   2 +-
 arch/x86/include/asm/pgtable_32.h                 |   2 +-
 arch/x86/include/asm/processor.h                  |   7 +-
 arch/x86/include/asm/tlbflush.h                   |  27 ++++--
 arch/x86/kernel/amd_nb.c                          |   2 +-
 arch/x86/kernel/apic/apic.c                       |   6 +-
 arch/x86/kernel/asm-offsets_32.c                  |   2 +-
 arch/x86/kernel/cpu/amd.c                         |  28 +++---
 arch/x86/kernel/cpu/bugs.c                        |  34 +++----
 arch/x86/kernel/cpu/centaur.c                     |   4 +-
 arch/x86/kernel/cpu/common.c                      |  10 +-
 arch/x86/kernel/cpu/cyrix.c                       |   2 +-
 arch/x86/kernel/cpu/intel.c                       |  31 +++----
 arch/x86/kernel/cpu/intel_rdt.c                   |   2 +-
 arch/x86/kernel/cpu/microcode/intel.c             |   6 +-
 arch/x86/kernel/cpu/mtrr/generic.c                |   2 +-
 arch/x86/kernel/cpu/mtrr/main.c                   |   4 +-
 arch/x86/kernel/cpu/proc.c                        |   8 +-
 arch/x86/kernel/head_32.S                         |   4 +-
 arch/x86/kernel/mpparse.c                         |   2 +-
 arch/x86/kernel/paravirt.c                        |   6 +-
 arch/x86/kernel/traps.c                           |   2 +-
 arch/x86/kvm/mmu.c                                |  10 +-
 arch/x86/kvm/vmx.c                                |   7 +-
 arch/x86/lib/cpu.c                                |   2 +-
 arch/x86/mm/init_64.c                             |   2 +-
 arch/x86/mm/ioremap.c                             |   2 +-
 arch/x86/mm/kmmio.c                               |   2 +-
 arch/x86/mm/pgtable_32.c                          |   2 +-
 arch/x86/mm/tlb.c                                 |   6 +-
 arch/x86/platform/uv/tlb_uv.c                     |   2 +-
 arch/x86/xen/mmu_pv.c                             |   6 +-
 drivers/char/hw_random/via-rng.c                  |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                    |   2 +-
 drivers/cpufreq/longhaul.c                        |   6 +-
 drivers/cpufreq/p4-clockmod.c                     |   2 +-
 drivers/cpufreq/powernow-k7.c                     |   2 +-
 drivers/cpufreq/speedstep-centrino.c              |   4 +-
 drivers/cpufreq/speedstep-lib.c                   |   6 +-
 drivers/crypto/padlock-aes.c                      |   2 +-
 drivers/edac/amd64_edac.c                         |   2 +-
 drivers/hwmon/coretemp.c                          |   6 +-
 drivers/hwmon/hwmon-vid.c                         |   2 +-
 drivers/hwmon/k10temp.c                           |   2 +-
 drivers/hwmon/k8temp.c                            |   2 +-
 drivers/video/fbdev/geode/video_gx.c              |   2 +-
 include/linux/nospec.h                            |  36 +++++---
 include/trace/events/xen.h                        |   2 +-
 tools/objtool/check.c                             |  53 ++++++++++-
 tools/objtool/check.h                             |   1 +
 tools/testing/selftests/x86/Makefile              |  24 +++--
 tools/testing/selftests/x86/mpx-mini-test.c       |  32 ++++++-
 tools/testing/selftests/x86/protection_keys.c     |  28 ------
 tools/testing/selftests/x86/single_step_syscall.c |   5 +-
 tools/testing/selftests/x86/test_mremap_vdso.c    |   4 +
 tools/testing/selftests/x86/test_vdso.c           |  55 +++++++++--
 tools/testing/selftests/x86/test_vsyscall.c       |  11 ++-
 69 files changed, 442 insertions(+), 362 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 845fc25812f1..98a22cb60773 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9813,6 +9813,7 @@ F:	drivers/nfc/nxp-nci
 
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	tools/objtool/
 
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 3f48f695d5e6..dce7092ab24a 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,80 +97,69 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
-	.macro ALLOC_PT_GPREGS_ON_STACK
-	addq	$-(15*8), %rsp
-	.endm
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+	/*
+	 * Push registers and sanitize registers of values that a
+	 * speculation attack might otherwise want to exploit. The
+	 * lower registers are likely clobbered well before they
+	 * could be put to use in a speculative execution gadget.
+	 * Interleave XOR with PUSH for better uop scheduling:
+	 */
+	pushq   %rdi		/* pt_regs->di */
+	pushq   %rsi		/* pt_regs->si */
+	pushq	\rdx		/* pt_regs->dx */
+	pushq   %rcx		/* pt_regs->cx */
+	pushq   \rax		/* pt_regs->ax */
+	pushq   %r8		/* pt_regs->r8 */
+	xorq    %r8, %r8	/* nospec   r8 */
+	pushq   %r9		/* pt_regs->r9 */
+	xorq    %r9, %r9	/* nospec   r9 */
+	pushq   %r10		/* pt_regs->r10 */
+	xorq    %r10, %r10	/* nospec   r10 */
+	pushq   %r11		/* pt_regs->r11 */
+	xorq    %r11, %r11	/* nospec   r11*/
+	pushq	%rbx		/* pt_regs->rbx */
+	xorl    %ebx, %ebx	/* nospec   rbx*/
+	pushq	%rbp		/* pt_regs->rbp */
+	xorl    %ebp, %ebp	/* nospec   rbp*/
+	pushq	%r12		/* pt_regs->r12 */
+	xorq    %r12, %r12	/* nospec   r12*/
+	pushq	%r13		/* pt_regs->r13 */
+	xorq    %r13, %r13	/* nospec   r13*/
+	pushq	%r14		/* pt_regs->r14 */
+	xorq    %r14, %r14	/* nospec   r14*/
+	pushq	%r15		/* pt_regs->r15 */
+	xorq    %r15, %r15	/* nospec   r15*/
+	UNWIND_HINT_REGS
+.endm
 
-	.macro SAVE_C_REGS_HELPER offset=0 rax=1 rcx=1 r8910=1 r11=1
-	.if \r11
-	movq %r11, 6*8+\offset(%rsp)
-	.endif
-	.if \r8910
-	movq %r10, 7*8+\offset(%rsp)
-	movq %r9,  8*8+\offset(%rsp)
-	movq %r8,  9*8+\offset(%rsp)
-	.endif
-	.if \rax
-	movq %rax, 10*8+\offset(%rsp)
-	.endif
-	.if \rcx
-	movq %rcx, 11*8+\offset(%rsp)
-	.endif
-	movq %rdx, 12*8+\offset(%rsp)
-	movq %rsi, 13*8+\offset(%rsp)
-	movq %rdi, 14*8+\offset(%rsp)
-	UNWIND_HINT_REGS offset=\offset extra=0
-	.endm
-	.macro SAVE_C_REGS offset=0
-	SAVE_C_REGS_HELPER \offset, 1, 1, 1, 1
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RAX_RCX offset=0
-	SAVE_C_REGS_HELPER \offset, 0, 0, 1, 1
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_R891011
-	SAVE_C_REGS_HELPER 0, 1, 1, 0, 0
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RCX_R891011
-	SAVE_C_REGS_HELPER 0, 1, 0, 0, 0
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RAX_RCX_R11
-	SAVE_C_REGS_HELPER 0, 0, 0, 1, 0
-	.endm
-
-	.macro SAVE_EXTRA_REGS offset=0
-	movq %r15, 0*8+\offset(%rsp)
-	movq %r14, 1*8+\offset(%rsp)
-	movq %r13, 2*8+\offset(%rsp)
-	movq %r12, 3*8+\offset(%rsp)
-	movq %rbp, 4*8+\offset(%rsp)
-	movq %rbx, 5*8+\offset(%rsp)
-	UNWIND_HINT_REGS offset=\offset
-	.endm
-
-	.macro POP_EXTRA_REGS
+.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
-	.endm
-
-	.macro POP_C_REGS
+	.if \skip_r11rcx
+	popq %rsi
+	.else
 	popq %r11
+	.endif
 	popq %r10
 	popq %r9
 	popq %r8
 	popq %rax
+	.if \skip_r11rcx
+	popq %rsi
+	.else
 	popq %rcx
+	.endif
 	popq %rdx
 	popq %rsi
+	.if \pop_rdi
 	popq %rdi
-	.endm
-
-	.macro icebp
-	.byte 0xf1
-	.endm
+	.endif
+.endm
 
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
@@ -178,7 +167,7 @@ For 32-bit we have the following conventions - kernel is built with
  * is just setting the LSB, which makes it an invalid stack address and is also
  * a signal to the unwinder that it's a pt_regs pointer in disguise.
  *
- * NOTE: This macro must be used *after* SAVE_EXTRA_REGS because it corrupts
+ * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
  * the original rbp.
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c752abe89d80..4fd9044e72e7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -213,7 +213,7 @@ ENTRY(entry_SYSCALL_64)
 
 	swapgs
 	/*
-	 * This path is not taken when PAGE_TABLE_ISOLATION is disabled so it
+	 * This path is only taken when PAGE_TABLE_ISOLATION is disabled so it
 	 * is not required to switch CR3.
 	 */
 	movq	%rsp, PER_CPU_VAR(rsp_scratch)
@@ -227,22 +227,8 @@ ENTRY(entry_SYSCALL_64)
 	pushq	%rcx				/* pt_regs->ip */
 GLOBAL(entry_SYSCALL_64_after_hwframe)
 	pushq	%rax				/* pt_regs->orig_ax */
-	pushq	%rdi				/* pt_regs->di */
-	pushq	%rsi				/* pt_regs->si */
-	pushq	%rdx				/* pt_regs->dx */
-	pushq	%rcx				/* pt_regs->cx */
-	pushq	$-ENOSYS			/* pt_regs->ax */
-	pushq	%r8				/* pt_regs->r8 */
-	pushq	%r9				/* pt_regs->r9 */
-	pushq	%r10				/* pt_regs->r10 */
-	pushq	%r11				/* pt_regs->r11 */
-	pushq	%rbx				/* pt_regs->rbx */
-	pushq	%rbp				/* pt_regs->rbp */
-	pushq	%r12				/* pt_regs->r12 */
-	pushq	%r13				/* pt_regs->r13 */
-	pushq	%r14				/* pt_regs->r14 */
-	pushq	%r15				/* pt_regs->r15 */
-	UNWIND_HINT_REGS
+
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
 	TRACE_IRQS_OFF
 
@@ -321,15 +307,7 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
 	UNWIND_HINT_EMPTY
-	POP_EXTRA_REGS
-	popq	%rsi	/* skip r11 */
-	popq	%r10
-	popq	%r9
-	popq	%r8
-	popq	%rax
-	popq	%rsi	/* skip rcx */
-	popq	%rdx
-	popq	%rsi
+	POP_REGS pop_rdi=0 skip_r11rcx=1
 
 	/*
 	 * Now all regs are restored except RSP and RDI.
@@ -559,9 +537,7 @@ END(irq_entries_start)
 	call	switch_to_thread_stack
 1:
 
-	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_C_REGS
-	SAVE_EXTRA_REGS
+	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -622,15 +598,7 @@ GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 	ud2
 1:
 #endif
-	POP_EXTRA_REGS
-	popq	%r11
-	popq	%r10
-	popq	%r9
-	popq	%r8
-	popq	%rax
-	popq	%rcx
-	popq	%rdx
-	popq	%rsi
+	POP_REGS pop_rdi=0
 
 	/*
 	 * The stack is now user RDI, orig_ax, RIP, CS, EFLAGS, RSP, SS.
@@ -688,8 +656,7 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	ud2
 1:
 #endif
-	POP_EXTRA_REGS
-	POP_C_REGS
+	POP_REGS
 	addq	$8, %rsp	/* skip regs->orig_ax */
 	INTERRUPT_RETURN
 
@@ -904,7 +871,9 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	ALLOC_PT_GPREGS_ON_STACK
+	/* Save all registers in pt_regs */
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 
 	.if \paranoid < 2
 	testb	$3, CS(%rsp)			/* If coming from userspace, switch stacks */
@@ -1117,9 +1086,7 @@ ENTRY(xen_failsafe_callback)
 	addq	$0x30, %rsp
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
-	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_C_REGS
-	SAVE_EXTRA_REGS
+	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
@@ -1156,16 +1123,13 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
+ * Switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_C_REGS 8
-	SAVE_EXTRA_REGS 8
-	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
@@ -1204,21 +1168,18 @@ ENTRY(paranoid_exit)
 	jmp	.Lparanoid_exit_restore
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
+	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
 END(paranoid_exit)
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
+ * Switch gs if needed.
  * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
-	UNWIND_HINT_FUNC
+	UNWIND_HINT_REGS offset=8
 	cld
-	SAVE_C_REGS 8
-	SAVE_EXTRA_REGS 8
-	ENCODE_FRAME_POINTER 8
-	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1399,22 +1360,7 @@ ENTRY(nmi)
 	pushq	1*8(%rdx)	/* pt_regs->rip */
 	UNWIND_HINT_IRET_REGS
 	pushq   $-1		/* pt_regs->orig_ax */
-	pushq   %rdi		/* pt_regs->di */
-	pushq   %rsi		/* pt_regs->si */
-	pushq   (%rdx)		/* pt_regs->dx */
-	pushq   %rcx		/* pt_regs->cx */
-	pushq   %rax		/* pt_regs->ax */
-	pushq   %r8		/* pt_regs->r8 */
-	pushq   %r9		/* pt_regs->r9 */
-	pushq   %r10		/* pt_regs->r10 */
-	pushq   %r11		/* pt_regs->r11 */
-	pushq	%rbx		/* pt_regs->rbx */
-	pushq	%rbp		/* pt_regs->rbp */
-	pushq	%r12		/* pt_regs->r12 */
-	pushq	%r13		/* pt_regs->r13 */
-	pushq	%r14		/* pt_regs->r14 */
-	pushq	%r15		/* pt_regs->r15 */
-	UNWIND_HINT_REGS
+	PUSH_AND_CLEAR_REGS rdx=(%rdx)
 	ENCODE_FRAME_POINTER
 
 	/*
@@ -1624,7 +1570,8 @@ ENTRY(nmi)
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	ALLOC_PT_GPREGS_ON_STACK
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
@@ -1648,8 +1595,7 @@ ENTRY(nmi)
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
 nmi_restore:
-	POP_EXTRA_REGS
-	POP_C_REGS
+	POP_REGS
 
 	/*
 	 * Skip orig_ax and the "outermost" frame to point RSP at the "iret"
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 98d5358e4041..fd65e016e413 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -85,15 +85,25 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	xorq	%r15, %r15		/* nospec   r15 */
 	cld
 
 	/*
@@ -214,15 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	xorq	%r15, %r15		/* nospec   r15 */
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -338,15 +358,25 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   %r12                    /* pt_regs->r12 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   %r13                    /* pt_regs->r13 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   %r14                    /* pt_regs->r14 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   %r15                    /* pt_regs->r15 */
+	xorq	%r15, %r15		/* nospec   r15 */
 	cld
 
 	/*
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 731153a4681e..56457cb73448 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3559,7 +3559,7 @@ static int intel_snb_pebs_broken(int cpu)
 		break;
 
 	case INTEL_FAM6_SANDYBRIDGE_X:
-		switch (cpu_data(cpu).x86_mask) {
+		switch (cpu_data(cpu).x86_stepping) {
 		case 6: rev = 0x618; break;
 		case 7: rev = 0x70c; break;
 		}
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ae64d0b69729..cf372b90557e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1186,7 +1186,7 @@ void __init intel_pmu_lbr_init_atom(void)
 	 * on PMU interrupt
 	 */
 	if (boot_cpu_data.x86_model == 28
-	    && boot_cpu_data.x86_mask < 10) {
+	    && boot_cpu_data.x86_stepping < 10) {
 		pr_cont("LBR disabled due to erratum");
 		return;
 	}
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index a5604c352930..408879b0c0d4 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -234,7 +234,7 @@ static __initconst const struct x86_pmu p6_pmu = {
 
 static __init void p6_pmu_rdpmc_quirk(void)
 {
-	if (boot_cpu_data.x86_mask < 9) {
+	if (boot_cpu_data.x86_stepping < 9) {
 		/*
 		 * PPro erratum 26; fixed in stepping 9 and above.
 		 */
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8d0ec9df1cbe..f077401869ee 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -94,7 +94,7 @@ static inline unsigned int acpi_processor_cstate_check(unsigned int max_cstate)
 	if (boot_cpu_data.x86 == 0x0F &&
 	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 	    boot_cpu_data.x86_model <= 0x05 &&
-	    boot_cpu_data.x86_mask < 0x0A)
+	    boot_cpu_data.x86_stepping < 0x0A)
 		return 1;
 	else if (boot_cpu_has(X86_BUG_AMD_APIC_C1E))
 		return 1;
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 30d406146016..e1259f043ae9 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -40,7 +40,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 
 	asm ("cmp %1,%2; sbb %0,%0;"
 			:"=r" (mask)
-			:"r"(size),"r" (index)
+			:"g"(size),"r" (index)
 			:"cc");
 	return mask;
 }
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 34d99af43994..6804d6642767 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -5,23 +5,20 @@
 #include <linux/stringify.h>
 
 /*
- * Since some emulators terminate on UD2, we cannot use it for WARN.
- * Since various instruction decoders disagree on the length of UD1,
- * we cannot use it either. So use UD0 for WARN.
+ * Despite that some emulators terminate on UD2, we use it for WARN().
  *
- * (binutils knows about "ud1" but {en,de}codes it as 2 bytes, whereas
- *  our kernel decoder thinks it takes a ModRM byte, which seems consistent
- *  with various things like the Intel SDM instruction encoding rules)
+ * Since various instruction decoders/specs disagree on the encoding of
+ * UD0/UD1.
  */
 
-#define ASM_UD0		".byte 0x0f, 0xff"
+#define ASM_UD0		".byte 0x0f, 0xff" /* + ModRM (for Intel) */
 #define ASM_UD1		".byte 0x0f, 0xb9" /* + ModRM */
 #define ASM_UD2		".byte 0x0f, 0x0b"
 
 #define INSN_UD0	0xff0f
 #define INSN_UD2	0x0b0f
 
-#define LEN_UD0		2
+#define LEN_UD2		2
 
 #ifdef CONFIG_GENERIC_BUG
 
@@ -77,7 +74,11 @@ do {								\
 	unreachable();						\
 } while (0)
 
-#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(flags)					\
+do {								\
+	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
+	annotate_reachable();					\
+} while (0)
 
 #include <asm-generic/bug.h>
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4d57894635f2..76b058533e47 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 
 #ifdef __ASSEMBLY__
 
@@ -164,10 +165,15 @@ static inline void vmexit_fill_RSB(void)
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_input("",
-			  "call __ibp_barrier",
-			  X86_FEATURE_USE_IBPB,
-			  ASM_NO_INPUT_CLOBBER("eax", "ecx", "edx", "memory"));
+	asm volatile(ALTERNATIVE("",
+				 "movl %[msr], %%ecx\n\t"
+				 "movl %[val], %%eax\n\t"
+				 "movl $0, %%edx\n\t"
+				 "wrmsr",
+				 X86_FEATURE_USE_IBPB)
+		     : : [msr] "i" (MSR_IA32_PRED_CMD),
+			 [val] "i" (PRED_CMD_IBPB)
+		     : "eax", "ecx", "edx", "memory");
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 892df375b615..554841fab717 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -297,9 +297,9 @@ static inline void __flush_tlb_global(void)
 {
 	PVOP_VCALL0(pv_mmu_ops.flush_tlb_kernel);
 }
-static inline void __flush_tlb_single(unsigned long addr)
+static inline void __flush_tlb_one_user(unsigned long addr)
 {
-	PVOP_VCALL1(pv_mmu_ops.flush_tlb_single, addr);
+	PVOP_VCALL1(pv_mmu_ops.flush_tlb_one_user, addr);
 }
 
 static inline void flush_tlb_others(const struct cpumask *cpumask,
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 6ec54d01972d..f624f1f10316 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -217,7 +217,7 @@ struct pv_mmu_ops {
 	/* TLB operations */
 	void (*flush_tlb_user)(void);
 	void (*flush_tlb_kernel)(void);
-	void (*flush_tlb_single)(unsigned long addr);
+	void (*flush_tlb_one_user)(unsigned long addr);
 	void (*flush_tlb_others)(const struct cpumask *cpus,
 				 const struct flush_tlb_info *info);
 
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index e67c0620aec2..e55466760ff8 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -61,7 +61,7 @@ void paging_init(void);
 #define kpte_clear_flush(ptep, vaddr)		\
 do {						\
 	pte_clear(&init_mm, (vaddr), (ptep));	\
-	__flush_tlb_one((vaddr));		\
+	__flush_tlb_one_kernel((vaddr));		\
 } while (0)
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 513f9604c192..44c2c4ec6d60 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -91,7 +91,7 @@ struct cpuinfo_x86 {
 	__u8			x86;		/* CPU family */
 	__u8			x86_vendor;	/* CPU vendor */
 	__u8			x86_model;
-	__u8			x86_mask;
+	__u8			x86_stepping;
 #ifdef CONFIG_X86_64
 	/* Number of 4K pages in DTLB/ITLB combined(in pages): */
 	int			x86_tlbsize;
@@ -109,7 +109,7 @@ struct cpuinfo_x86 {
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
-	int			x86_cache_size;
+	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
 	/* Cache QoS architectural values: */
 	int			x86_cache_max_rmid;	/* max index */
@@ -969,7 +969,4 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
-
-void __ibp_barrier(void);
-
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 2b8f18ca5874..84137c22fdfa 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -140,7 +140,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 #else
 #define __flush_tlb() __native_flush_tlb()
 #define __flush_tlb_global() __native_flush_tlb_global()
-#define __flush_tlb_single(addr) __native_flush_tlb_single(addr)
+#define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
 #endif
 
 static inline bool tlb_defer_switch_to_init_mm(void)
@@ -400,7 +400,7 @@ static inline void __native_flush_tlb_global(void)
 /*
  * flush one page in the user mapping
  */
-static inline void __native_flush_tlb_single(unsigned long addr)
+static inline void __native_flush_tlb_one_user(unsigned long addr)
 {
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 
@@ -437,18 +437,31 @@ static inline void __flush_tlb_all(void)
 /*
  * flush one page in the kernel mapping
  */
-static inline void __flush_tlb_one(unsigned long addr)
+static inline void __flush_tlb_one_kernel(unsigned long addr)
 {
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
-	__flush_tlb_single(addr);
+
+	/*
+	 * If PTI is off, then __flush_tlb_one_user() is just INVLPG or its
+	 * paravirt equivalent.  Even with PCID, this is sufficient: we only
+	 * use PCID if we also use global PTEs for the kernel mapping, and
+	 * INVLPG flushes global translations across all address spaces.
+	 *
+	 * If PTI is on, then the kernel is mapped with non-global PTEs, and
+	 * __flush_tlb_one_user() will flush the given address for the current
+	 * kernel address space and for its usermode counterpart, but it does
+	 * not flush it for other address spaces.
+	 */
+	__flush_tlb_one_user(addr);
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	/*
-	 * __flush_tlb_single() will have cleared the TLB entry for this ASID,
-	 * but since kernel space is replicated across all, we must also
-	 * invalidate all others.
+	 * See above.  We need to propagate the flush to all other address
+	 * spaces.  In principle, we only need to propagate it to kernelmode
+	 * address spaces, but the extra bookkeeping we would need is not
+	 * worth it.
 	 */
 	invalidate_other_asid();
 }
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6db28f17ff28..c88e0b127810 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -235,7 +235,7 @@ int amd_cache_northbridges(void)
 	if (boot_cpu_data.x86 == 0x10 &&
 	    boot_cpu_data.x86_model >= 0x8 &&
 	    (boot_cpu_data.x86_model > 0x9 ||
-	     boot_cpu_data.x86_mask >= 0x1))
+	     boot_cpu_data.x86_stepping >= 0x1))
 		amd_northbridges.flags |= AMD_NB_L3_INDEX_DISABLE;
 
 	if (boot_cpu_data.x86 == 0x15)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 25ddf02598d2..b203af0855b5 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -546,7 +546,7 @@ static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
 static u32 hsx_deadline_rev(void)
 {
-	switch (boot_cpu_data.x86_mask) {
+	switch (boot_cpu_data.x86_stepping) {
 	case 0x02: return 0x3a; /* EP */
 	case 0x04: return 0x0f; /* EX */
 	}
@@ -556,7 +556,7 @@ static u32 hsx_deadline_rev(void)
 
 static u32 bdx_deadline_rev(void)
 {
-	switch (boot_cpu_data.x86_mask) {
+	switch (boot_cpu_data.x86_stepping) {
 	case 0x02: return 0x00000011;
 	case 0x03: return 0x0700000e;
 	case 0x04: return 0x0f00000c;
@@ -568,7 +568,7 @@ static u32 bdx_deadline_rev(void)
 
 static u32 skx_deadline_rev(void)
 {
-	switch (boot_cpu_data.x86_mask) {
+	switch (boot_cpu_data.x86_stepping) {
 	case 0x03: return 0x01000136;
 	case 0x04: return 0x02000014;
 	}
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index fa1261eefa16..f91ba53e06c8 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -18,7 +18,7 @@ void foo(void)
 	OFFSET(CPUINFO_x86, cpuinfo_x86, x86);
 	OFFSET(CPUINFO_x86_vendor, cpuinfo_x86, x86_vendor);
 	OFFSET(CPUINFO_x86_model, cpuinfo_x86, x86_model);
-	OFFSET(CPUINFO_x86_mask, cpuinfo_x86, x86_mask);
+	OFFSET(CPUINFO_x86_stepping, cpuinfo_x86, x86_stepping);
 	OFFSET(CPUINFO_cpuid_level, cpuinfo_x86, cpuid_level);
 	OFFSET(CPUINFO_x86_capability, cpuinfo_x86, x86_capability);
 	OFFSET(CPUINFO_x86_vendor_id, cpuinfo_x86, x86_vendor_id);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index ea831c858195..e7d5a7883632 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -119,7 +119,7 @@ static void init_amd_k6(struct cpuinfo_x86 *c)
 		return;
 	}
 
-	if (c->x86_model == 6 && c->x86_mask == 1) {
+	if (c->x86_model == 6 && c->x86_stepping == 1) {
 		const int K6_BUG_LOOP = 1000000;
 		int n;
 		void (*f_vide)(void);
@@ -149,7 +149,7 @@ static void init_amd_k6(struct cpuinfo_x86 *c)
 
 	/* K6 with old style WHCR */
 	if (c->x86_model < 8 ||
-	   (c->x86_model == 8 && c->x86_mask < 8)) {
+	   (c->x86_model == 8 && c->x86_stepping < 8)) {
 		/* We can only write allocate on the low 508Mb */
 		if (mbytes > 508)
 			mbytes = 508;
@@ -168,7 +168,7 @@ static void init_amd_k6(struct cpuinfo_x86 *c)
 		return;
 	}
 
-	if ((c->x86_model == 8 && c->x86_mask > 7) ||
+	if ((c->x86_model == 8 && c->x86_stepping > 7) ||
 	     c->x86_model == 9 || c->x86_model == 13) {
 		/* The more serious chips .. */
 
@@ -221,7 +221,7 @@ static void init_amd_k7(struct cpuinfo_x86 *c)
 	 * are more robust with CLK_CTL set to 200xxxxx instead of 600xxxxx
 	 * As per AMD technical note 27212 0.2
 	 */
-	if ((c->x86_model == 8 && c->x86_mask >= 1) || (c->x86_model > 8)) {
+	if ((c->x86_model == 8 && c->x86_stepping >= 1) || (c->x86_model > 8)) {
 		rdmsr(MSR_K7_CLK_CTL, l, h);
 		if ((l & 0xfff00000) != 0x20000000) {
 			pr_info("CPU: CLK_CTL MSR was %x. Reprogramming to %x\n",
@@ -241,12 +241,12 @@ static void init_amd_k7(struct cpuinfo_x86 *c)
 	 * but they are not certified as MP capable.
 	 */
 	/* Athlon 660/661 is valid. */
-	if ((c->x86_model == 6) && ((c->x86_mask == 0) ||
-	    (c->x86_mask == 1)))
+	if ((c->x86_model == 6) && ((c->x86_stepping == 0) ||
+	    (c->x86_stepping == 1)))
 		return;
 
 	/* Duron 670 is valid */
-	if ((c->x86_model == 7) && (c->x86_mask == 0))
+	if ((c->x86_model == 7) && (c->x86_stepping == 0))
 		return;
 
 	/*
@@ -256,8 +256,8 @@ static void init_amd_k7(struct cpuinfo_x86 *c)
 	 * See http://www.heise.de/newsticker/data/jow-18.10.01-000 for
 	 * more.
 	 */
-	if (((c->x86_model == 6) && (c->x86_mask >= 2)) ||
-	    ((c->x86_model == 7) && (c->x86_mask >= 1)) ||
+	if (((c->x86_model == 6) && (c->x86_stepping >= 2)) ||
+	    ((c->x86_model == 7) && (c->x86_stepping >= 1)) ||
 	     (c->x86_model > 7))
 		if (cpu_has(c, X86_FEATURE_MP))
 			return;
@@ -583,7 +583,7 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	/*  Set MTRR capability flag if appropriate */
 	if (c->x86 == 5)
 		if (c->x86_model == 13 || c->x86_model == 9 ||
-		    (c->x86_model == 8 && c->x86_mask >= 8))
+		    (c->x86_model == 8 && c->x86_stepping >= 8))
 			set_cpu_cap(c, X86_FEATURE_K6_MTRR);
 #endif
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PCI)
@@ -769,7 +769,7 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
 	 * all up to and including B1.
 	 */
-	if (c->x86_model <= 1 && c->x86_mask <= 1)
+	if (c->x86_model <= 1 && c->x86_stepping <= 1)
 		set_cpu_cap(c, X86_FEATURE_CPB);
 }
 
@@ -880,11 +880,11 @@ static unsigned int amd_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	/* AMD errata T13 (order #21922) */
 	if ((c->x86 == 6)) {
 		/* Duron Rev A0 */
-		if (c->x86_model == 3 && c->x86_mask == 0)
+		if (c->x86_model == 3 && c->x86_stepping == 0)
 			size = 64;
 		/* Tbird rev A1/A2 */
 		if (c->x86_model == 4 &&
-			(c->x86_mask == 0 || c->x86_mask == 1))
+			(c->x86_stepping == 0 || c->x86_stepping == 1))
 			size = 256;
 	}
 	return size;
@@ -1021,7 +1021,7 @@ static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 	}
 
 	/* OSVW unavailable or ID unknown, match family-model-stepping range */
-	ms = (cpu->x86_model << 4) | cpu->x86_mask;
+	ms = (cpu->x86_model << 4) | cpu->x86_stepping;
 	while ((range = *erratum++))
 		if ((cpu->x86 == AMD_MODEL_RANGE_FAMILY(range)) &&
 		    (ms >= AMD_MODEL_RANGE_START(range)) &&
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 71949bf2de5a..d71c8b54b696 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -162,8 +162,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 	else {
-		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
-					  sizeof(arg));
+		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 		if (ret < 0)
 			return SPECTRE_V2_CMD_AUTO;
 
@@ -175,8 +174,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n",
-			       mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
@@ -185,8 +183,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -256,14 +253,14 @@ static void __init spectre_v2_select_mitigation(void)
 			goto retpoline_auto;
 		break;
 	}
-	pr_err("kernel not compiled with retpoline; no mitigation available!");
+	pr_err("Spectre mitigation: kernel not compiled with retpoline; no mitigation available!");
 	return;
 
 retpoline_auto:
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-			pr_err("LFENCE not serializing. Switching to generic retpoline\n");
+			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
 		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
@@ -281,7 +278,7 @@ static void __init spectre_v2_select_mitigation(void)
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
 	/*
-	 * If neither SMEP or KPTI are available, there is a risk of
+	 * If neither SMEP nor PTI are available, there is a risk of
 	 * hitting userspace addresses in the RSB after a context switch
 	 * from a shallow call stack to a deeper one. To prevent this fill
 	 * the entire RSB, even when using IBRS.
@@ -295,21 +292,20 @@ static void __init spectre_v2_select_mitigation(void)
 	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
 	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-		pr_info("Filling RSB on context switch\n");
+		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier if supported */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
 	}
 }
 
 #undef pr_fmt
 
 #ifdef CONFIG_SYSFS
-ssize_t cpu_show_meltdown(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return sprintf(buf, "Not affected\n");
@@ -318,16 +314,14 @@ ssize_t cpu_show_meltdown(struct device *dev,
 	return sprintf(buf, "Vulnerable\n");
 }
 
-ssize_t cpu_show_spectre_v1(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
-ssize_t cpu_show_spectre_v2(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
@@ -337,9 +331,3 @@ ssize_t cpu_show_spectre_v2(struct device *dev,
 		       spectre_v2_module_string());
 }
 #endif
-
-void __ibp_barrier(void)
-{
-	__wrmsr(MSR_IA32_PRED_CMD, PRED_CMD_IBPB, 0);
-}
-EXPORT_SYMBOL_GPL(__ibp_barrier);
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 68bc6d9b3132..595be776727d 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -136,7 +136,7 @@ static void init_centaur(struct cpuinfo_x86 *c)
 			clear_cpu_cap(c, X86_FEATURE_TSC);
 			break;
 		case 8:
-			switch (c->x86_mask) {
+			switch (c->x86_stepping) {
 			default:
 			name = "2";
 				break;
@@ -211,7 +211,7 @@ centaur_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	 *  - Note, it seems this may only be in engineering samples.
 	 */
 	if ((c->x86 == 6) && (c->x86_model == 9) &&
-				(c->x86_mask == 1) && (size == 65))
+				(c->x86_stepping == 1) && (size == 65))
 		size -= 1;
 	return size;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d63f4b5706e4..824aee0117bb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -731,7 +731,7 @@ void cpu_detect(struct cpuinfo_x86 *c)
 		cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
 		c->x86		= x86_family(tfms);
 		c->x86_model	= x86_model(tfms);
-		c->x86_mask	= x86_stepping(tfms);
+		c->x86_stepping	= x86_stepping(tfms);
 
 		if (cap0 & (1<<19)) {
 			c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
@@ -1184,9 +1184,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = -1;
+	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
-	c->x86_model = c->x86_mask = 0;	/* So far unknown... */
+	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
@@ -1378,8 +1378,8 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 
 	pr_cont(" (family: 0x%x, model: 0x%x", c->x86, c->x86_model);
 
-	if (c->x86_mask || c->cpuid_level >= 0)
-		pr_cont(", stepping: 0x%x)\n", c->x86_mask);
+	if (c->x86_stepping || c->cpuid_level >= 0)
+		pr_cont(", stepping: 0x%x)\n", c->x86_stepping);
 	else
 		pr_cont(")\n");
 }
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 6b4bb335641f..8949b7ae6d92 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -215,7 +215,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 
 	/* common case step number/rev -- exceptions handled below */
 	c->x86_model = (dir1 >> 4) + 1;
-	c->x86_mask = dir1 & 0xf;
+	c->x86_stepping = dir1 & 0xf;
 
 	/* Now cook; the original recipe is by Channing Corn, from Cyrix.
 	 * We do the same thing for each generation: we work out
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 319bf989fad1..d19e903214b4 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -116,14 +116,13 @@ struct sku_microcode {
 	u32 microcode;
 };
 static const struct sku_microcode spectre_bad_microcodes[] = {
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
 	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
@@ -136,8 +135,6 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
 	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
-	/* Updated in the 20180108 release; blacklist until we know otherwise */
-	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
 	/* Observed in the wild */
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
@@ -149,7 +146,7 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
-		    c->x86_mask == spectre_bad_microcodes[i].stepping)
+		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
 			return (c->microcode <= spectre_bad_microcodes[i].microcode);
 	}
 	return false;
@@ -196,7 +193,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 * need the microcode to have already been loaded... so if it is
 	 * not, recommend a BIOS update and disable large pages.
 	 */
-	if (c->x86 == 6 && c->x86_model == 0x1c && c->x86_mask <= 2 &&
+	if (c->x86 == 6 && c->x86_model == 0x1c && c->x86_stepping <= 2 &&
 	    c->microcode < 0x20e) {
 		pr_warn("Atom PSE erratum detected, BIOS microcode update recommended\n");
 		clear_cpu_cap(c, X86_FEATURE_PSE);
@@ -212,7 +209,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 
 	/* CPUID workaround for 0F33/0F34 CPU */
 	if (c->x86 == 0xF && c->x86_model == 0x3
-	    && (c->x86_mask == 0x3 || c->x86_mask == 0x4))
+	    && (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
 		c->x86_phys_bits = 36;
 
 	/*
@@ -310,7 +307,7 @@ int ppro_with_ram_bug(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
 	    boot_cpu_data.x86 == 6 &&
 	    boot_cpu_data.x86_model == 1 &&
-	    boot_cpu_data.x86_mask < 8) {
+	    boot_cpu_data.x86_stepping < 8) {
 		pr_info("Pentium Pro with Errata#50 detected. Taking evasive action.\n");
 		return 1;
 	}
@@ -327,7 +324,7 @@ static void intel_smp_check(struct cpuinfo_x86 *c)
 	 * Mask B, Pentium, but not Pentium MMX
 	 */
 	if (c->x86 == 5 &&
-	    c->x86_mask >= 1 && c->x86_mask <= 4 &&
+	    c->x86_stepping >= 1 && c->x86_stepping <= 4 &&
 	    c->x86_model <= 3) {
 		/*
 		 * Remember we have B step Pentia with bugs
@@ -370,7 +367,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * SEP CPUID bug: Pentium Pro reports SEP but doesn't have it until
 	 * model 3 mask 3
 	 */
-	if ((c->x86<<8 | c->x86_model<<4 | c->x86_mask) < 0x633)
+	if ((c->x86<<8 | c->x86_model<<4 | c->x86_stepping) < 0x633)
 		clear_cpu_cap(c, X86_FEATURE_SEP);
 
 	/*
@@ -388,7 +385,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * P4 Xeon erratum 037 workaround.
 	 * Hardware prefetcher may cause stale data to be loaded into the cache.
 	 */
-	if ((c->x86 == 15) && (c->x86_model == 1) && (c->x86_mask == 1)) {
+	if ((c->x86 == 15) && (c->x86_model == 1) && (c->x86_stepping == 1)) {
 		if (msr_set_bit(MSR_IA32_MISC_ENABLE,
 				MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT) > 0) {
 			pr_info("CPU: C0 stepping P4 Xeon detected.\n");
@@ -403,7 +400,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * Specification Update").
 	 */
 	if (boot_cpu_has(X86_FEATURE_APIC) && (c->x86<<8 | c->x86_model<<4) == 0x520 &&
-	    (c->x86_mask < 0x6 || c->x86_mask == 0xb))
+	    (c->x86_stepping < 0x6 || c->x86_stepping == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
 
@@ -650,7 +647,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		case 6:
 			if (l2 == 128)
 				p = "Celeron (Mendocino)";
-			else if (c->x86_mask == 0 || c->x86_mask == 5)
+			else if (c->x86_stepping == 0 || c->x86_stepping == 5)
 				p = "Celeron-A";
 			break;
 
diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 99442370de40..18dd8f22e353 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -771,7 +771,7 @@ static __init void rdt_quirks(void)
 			cache_alloc_hsw_probe();
 		break;
 	case INTEL_FAM6_SKYLAKE_X:
-		if (boot_cpu_data.x86_mask <= 4)
+		if (boot_cpu_data.x86_stepping <= 4)
 			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
 	}
 }
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f7c55b0e753a..a15db2b4e0d6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -921,7 +921,7 @@ static bool is_blacklisted(unsigned int cpu)
 	 */
 	if (c->x86 == 6 &&
 	    c->x86_model == INTEL_FAM6_BROADWELL_X &&
-	    c->x86_mask == 0x01 &&
+	    c->x86_stepping == 0x01 &&
 	    llc_size_per_core > 2621440 &&
 	    c->microcode < 0x0b000021) {
 		pr_err_once("Erratum BDF90: late loading with revision < 0x0b000021 (0x%x) disabled.\n", c->microcode);
@@ -944,7 +944,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 		return UCODE_NFOUND;
 
 	sprintf(name, "intel-ucode/%02x-%02x-%02x",
-		c->x86, c->x86_model, c->x86_mask);
+		c->x86, c->x86_model, c->x86_stepping);
 
 	if (request_firmware_direct(&firmware, name, device)) {
 		pr_debug("data file %s load failed\n", name);
@@ -982,7 +982,7 @@ static struct microcode_ops microcode_intel_ops = {
 
 static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
-	u64 llc_size = c->x86_cache_size * 1024;
+	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index fdc55215d44d..e12ee86906c6 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -859,7 +859,7 @@ int generic_validate_add_page(unsigned long base, unsigned long size,
 	 */
 	if (is_cpu(INTEL) && boot_cpu_data.x86 == 6 &&
 	    boot_cpu_data.x86_model == 1 &&
-	    boot_cpu_data.x86_mask <= 7) {
+	    boot_cpu_data.x86_stepping <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {
 			pr_warn("mtrr: base(0x%lx000) is not 4 MiB aligned\n", base);
 			return -EINVAL;
diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 40d5a8a75212..7468de429087 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -711,8 +711,8 @@ void __init mtrr_bp_init(void)
 			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
 			    boot_cpu_data.x86 == 0xF &&
 			    boot_cpu_data.x86_model == 0x3 &&
-			    (boot_cpu_data.x86_mask == 0x3 ||
-			     boot_cpu_data.x86_mask == 0x4))
+			    (boot_cpu_data.x86_stepping == 0x3 ||
+			     boot_cpu_data.x86_stepping == 0x4))
 				phys_addr = 36;
 
 			size_or_mask = SIZE_OR_MASK_BITS(phys_addr);
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index e7ecedafa1c8..2c8522a39ed5 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -72,8 +72,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   c->x86_model,
 		   c->x86_model_id[0] ? c->x86_model_id : "unknown");
 
-	if (c->x86_mask || c->cpuid_level >= 0)
-		seq_printf(m, "stepping\t: %d\n", c->x86_mask);
+	if (c->x86_stepping || c->cpuid_level >= 0)
+		seq_printf(m, "stepping\t: %d\n", c->x86_stepping);
 	else
 		seq_puts(m, "stepping\t: unknown\n");
 	if (c->microcode)
@@ -91,8 +91,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	}
 
 	/* Cache size */
-	if (c->x86_cache_size >= 0)
-		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
+	if (c->x86_cache_size)
+		seq_printf(m, "cache size\t: %u KB\n", c->x86_cache_size);
 
 	show_cpuinfo_core(m, c, cpu);
 	show_cpuinfo_misc(m, c);
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index c29020907886..b59e4fb40fd9 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -37,7 +37,7 @@
 #define X86		new_cpu_data+CPUINFO_x86
 #define X86_VENDOR	new_cpu_data+CPUINFO_x86_vendor
 #define X86_MODEL	new_cpu_data+CPUINFO_x86_model
-#define X86_MASK	new_cpu_data+CPUINFO_x86_mask
+#define X86_STEPPING	new_cpu_data+CPUINFO_x86_stepping
 #define X86_HARD_MATH	new_cpu_data+CPUINFO_hard_math
 #define X86_CPUID	new_cpu_data+CPUINFO_cpuid_level
 #define X86_CAPABILITY	new_cpu_data+CPUINFO_x86_capability
@@ -332,7 +332,7 @@ ENTRY(startup_32_smp)
 	shrb $4,%al
 	movb %al,X86_MODEL
 	andb $0x0f,%cl		# mask mask revision
-	movb %cl,X86_MASK
+	movb %cl,X86_STEPPING
 	movl %edx,X86_CAPABILITY
 
 .Lis486:
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 3a4b12809ab5..bc6bc6689e68 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -407,7 +407,7 @@ static inline void __init construct_default_ISA_mptable(int mpc_default_type)
 	processor.apicver = mpc_default_type > 4 ? 0x10 : 0x01;
 	processor.cpuflag = CPU_ENABLED;
 	processor.cpufeature = (boot_cpu_data.x86 << 8) |
-	    (boot_cpu_data.x86_model << 4) | boot_cpu_data.x86_mask;
+	    (boot_cpu_data.x86_model << 4) | boot_cpu_data.x86_stepping;
 	processor.featureflag = boot_cpu_data.x86_capability[CPUID_1_EDX];
 	processor.reserved[0] = 0;
 	processor.reserved[1] = 0;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 041096bdef86..99dc79e76bdc 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -200,9 +200,9 @@ static void native_flush_tlb_global(void)
 	__native_flush_tlb_global();
 }
 
-static void native_flush_tlb_single(unsigned long addr)
+static void native_flush_tlb_one_user(unsigned long addr)
 {
-	__native_flush_tlb_single(addr);
+	__native_flush_tlb_one_user(addr);
 }
 
 struct static_key paravirt_steal_enabled;
@@ -401,7 +401,7 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
 
 	.flush_tlb_user = native_flush_tlb,
 	.flush_tlb_kernel = native_flush_tlb_global,
-	.flush_tlb_single = native_flush_tlb_single,
+	.flush_tlb_one_user = native_flush_tlb_one_user,
 	.flush_tlb_others = native_flush_tlb_others,
 
 	.pgd_alloc = __paravirt_pgd_alloc,
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 446c9ef8cfc3..3d9b2308e7fa 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -181,7 +181,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
-		regs->ip += LEN_UD0;
+		regs->ip += LEN_UD2;
 		return 1;
 	}
 
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 2b8eb4da4d08..cc83bdcb65d1 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5058,7 +5058,7 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
 
 /* The caller should hold mmu-lock before calling this function. */
-static bool
+static __always_inline bool
 slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, int start_level, int end_level,
 			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
@@ -5088,7 +5088,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	return flush;
 }
 
-static bool
+static __always_inline bool
 slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		  slot_level_handler fn, int start_level, int end_level,
 		  bool lock_flush_tlb)
@@ -5099,7 +5099,7 @@ slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		      slot_level_handler fn, bool lock_flush_tlb)
 {
@@ -5107,7 +5107,7 @@ slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, bool lock_flush_tlb)
 {
@@ -5115,7 +5115,7 @@ slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		 slot_level_handler fn, bool lock_flush_tlb)
 {
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bee4c49f6dd0..91e3539cba02 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10130,7 +10130,8 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 	if (cpu_has_vmx_msr_bitmap() &&
 	    nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS) &&
 	    nested_vmx_merge_msr_bitmap(vcpu, vmcs12))
-		;
+		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
+			      CPU_BASED_USE_MSR_BITMAPS);
 	else
 		vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
 				CPU_BASED_USE_MSR_BITMAPS);
@@ -10219,8 +10220,8 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 	 *    updated to reflect this when L1 (or its L2s) actually write to
 	 *    the MSR.
 	 */
-	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
-	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
+	bool pred_cmd = !msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
+	bool spec_ctrl = !msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
 	    !pred_cmd && !spec_ctrl)
diff --git a/arch/x86/lib/cpu.c b/arch/x86/lib/cpu.c
index d6f848d1211d..2dd1fe13a37b 100644
--- a/arch/x86/lib/cpu.c
+++ b/arch/x86/lib/cpu.c
@@ -18,7 +18,7 @@ unsigned int x86_model(unsigned int sig)
 {
 	unsigned int fam, model;
 
-	 fam = x86_family(sig);
+	fam = x86_family(sig);
 
 	model = (sig >> 4) & 0xf;
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 4a837289f2ad..60ae1fe3609f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -256,7 +256,7 @@ static void __set_pte_vaddr(pud_t *pud, unsigned long vaddr, pte_t new_pte)
 	 * It's enough to flush this one mapping.
 	 * (PGE mappings get flushed as well)
 	 */
-	__flush_tlb_one(vaddr);
+	__flush_tlb_one_kernel(vaddr);
 }
 
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte)
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index c45b6ec5357b..e2db83bebc3b 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -820,5 +820,5 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
 	else
 		pte_clear(&init_mm, addr, pte);
-	__flush_tlb_one(addr);
+	__flush_tlb_one_kernel(addr);
 }
diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index 58477ec3d66d..7c8686709636 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -168,7 +168,7 @@ static int clear_page_presence(struct kmmio_fault_page *f, bool clear)
 		return -1;
 	}
 
-	__flush_tlb_one(f->addr);
+	__flush_tlb_one_kernel(f->addr);
 	return 0;
 }
 
diff --git a/arch/x86/mm/pgtable_32.c b/arch/x86/mm/pgtable_32.c
index c3c5274410a9..9bb7f0ab9fe6 100644
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -63,7 +63,7 @@ void set_pte_vaddr(unsigned long vaddr, pte_t pteval)
 	 * It's enough to flush this one mapping.
 	 * (PGE mappings get flushed as well)
 	 */
-	__flush_tlb_one(vaddr);
+	__flush_tlb_one_kernel(vaddr);
 }
 
 unsigned long __FIXADDR_TOP = 0xfffff000;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 012d02624848..0c936435ea93 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -492,7 +492,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	 *    flush that changes context.tlb_gen from 2 to 3.  If they get
 	 *    processed on this CPU in reverse order, we'll see
 	 *     local_tlb_gen == 1, mm_tlb_gen == 3, and end != TLB_FLUSH_ALL.
-	 *    If we were to use __flush_tlb_single() and set local_tlb_gen to
+	 *    If we were to use __flush_tlb_one_user() and set local_tlb_gen to
 	 *    3, we'd be break the invariant: we'd update local_tlb_gen above
 	 *    1 without the full flush that's needed for tlb_gen 2.
 	 *
@@ -513,7 +513,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 
 		addr = f->start;
 		while (addr < f->end) {
-			__flush_tlb_single(addr);
+			__flush_tlb_one_user(addr);
 			addr += PAGE_SIZE;
 		}
 		if (local)
@@ -660,7 +660,7 @@ static void do_kernel_range_flush(void *info)
 
 	/* flush range by one by one 'invlpg' */
 	for (addr = f->start; addr < f->end; addr += PAGE_SIZE)
-		__flush_tlb_one(addr);
+		__flush_tlb_one_kernel(addr);
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 8538a6723171..7d5d53f36a7a 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -299,7 +299,7 @@ static void bau_process_message(struct msg_desc *mdp, struct bau_control *bcp,
 		local_flush_tlb();
 		stat->d_alltlb++;
 	} else {
-		__flush_tlb_single(msg->address);
+		__flush_tlb_one_user(msg->address);
 		stat->d_onetlb++;
 	}
 	stat->d_requestee++;
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index d85076223a69..aae88fec9941 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1300,12 +1300,12 @@ static void xen_flush_tlb(void)
 	preempt_enable();
 }
 
-static void xen_flush_tlb_single(unsigned long addr)
+static void xen_flush_tlb_one_user(unsigned long addr)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb_single(addr);
+	trace_xen_mmu_flush_tlb_one_user(addr);
 
 	preempt_disable();
 
@@ -2370,7 +2370,7 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 
 	.flush_tlb_user = xen_flush_tlb,
 	.flush_tlb_kernel = xen_flush_tlb,
-	.flush_tlb_single = xen_flush_tlb_single,
+	.flush_tlb_one_user = xen_flush_tlb_one_user,
 	.flush_tlb_others = xen_flush_tlb_others,
 
 	.pgd_alloc = xen_pgd_alloc,
diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
index d1f5bb534e0e..6e9df558325b 100644
--- a/drivers/char/hw_random/via-rng.c
+++ b/drivers/char/hw_random/via-rng.c
@@ -162,7 +162,7 @@ static int via_rng_init(struct hwrng *rng)
 	/* Enable secondary noise source on CPUs where it is present. */
 
 	/* Nehemiah stepping 8 and higher */
-	if ((c->x86_model == 9) && (c->x86_mask > 7))
+	if ((c->x86_model == 9) && (c->x86_stepping > 7))
 		lo |= VIA_NOISESRC2;
 
 	/* Esther */
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 3a2ca0f79daf..d0c34df0529c 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -629,7 +629,7 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 	if (c->x86_vendor == X86_VENDOR_INTEL) {
 		if ((c->x86 == 15) &&
 		    (c->x86_model == 6) &&
-		    (c->x86_mask == 8)) {
+		    (c->x86_stepping == 8)) {
 			pr_info("Intel(R) Xeon(R) 7100 Errata AL30, processors may lock up on frequency changes: disabling acpi-cpufreq\n");
 			return -ENODEV;
 		    }
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index c46a12df40dd..d5e27bc7585a 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -775,7 +775,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 		break;
 
 	case 7:
-		switch (c->x86_mask) {
+		switch (c->x86_stepping) {
 		case 0:
 			longhaul_version = TYPE_LONGHAUL_V1;
 			cpu_model = CPU_SAMUEL2;
@@ -787,7 +787,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 			break;
 		case 1 ... 15:
 			longhaul_version = TYPE_LONGHAUL_V2;
-			if (c->x86_mask < 8) {
+			if (c->x86_stepping < 8) {
 				cpu_model = CPU_SAMUEL2;
 				cpuname = "C3 'Samuel 2' [C5B]";
 			} else {
@@ -814,7 +814,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 		numscales = 32;
 		memcpy(mults, nehemiah_mults, sizeof(nehemiah_mults));
 		memcpy(eblcr, nehemiah_eblcr, sizeof(nehemiah_eblcr));
-		switch (c->x86_mask) {
+		switch (c->x86_stepping) {
 		case 0 ... 1:
 			cpu_model = CPU_NEHEMIAH;
 			cpuname = "C3 'Nehemiah A' [C5XLOE]";
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index fd77812313f3..a25741b1281b 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -168,7 +168,7 @@ static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
 #endif
 
 	/* Errata workaround */
-	cpuid = (c->x86 << 8) | (c->x86_model << 4) | c->x86_mask;
+	cpuid = (c->x86 << 8) | (c->x86_model << 4) | c->x86_stepping;
 	switch (cpuid) {
 	case 0x0f07:
 	case 0x0f0a:
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 80ac313e6c59..302e9ce793a0 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -131,7 +131,7 @@ static int check_powernow(void)
 		return 0;
 	}
 
-	if ((c->x86_model == 6) && (c->x86_mask == 0)) {
+	if ((c->x86_model == 6) && (c->x86_stepping == 0)) {
 		pr_info("K7 660[A0] core detected, enabling errata workarounds\n");
 		have_a0 = 1;
 	}
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 41bc5397f4bb..4fa5adf16c70 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -37,7 +37,7 @@ struct cpu_id
 {
 	__u8	x86;            /* CPU family */
 	__u8	x86_model;	/* model */
-	__u8	x86_mask;	/* stepping */
+	__u8	x86_stepping;	/* stepping */
 };
 
 enum {
@@ -277,7 +277,7 @@ static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c,
 {
 	if ((c->x86 == x->x86) &&
 	    (c->x86_model == x->x86_model) &&
-	    (c->x86_mask == x->x86_mask))
+	    (c->x86_stepping == x->x86_stepping))
 		return 1;
 	return 0;
 }
diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 8085ec9000d1..e3a9962ee410 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -272,9 +272,9 @@ unsigned int speedstep_detect_processor(void)
 		ebx = cpuid_ebx(0x00000001);
 		ebx &= 0x000000FF;
 
-		pr_debug("ebx value is %x, x86_mask is %x\n", ebx, c->x86_mask);
+		pr_debug("ebx value is %x, x86_stepping is %x\n", ebx, c->x86_stepping);
 
-		switch (c->x86_mask) {
+		switch (c->x86_stepping) {
 		case 4:
 			/*
 			 * B-stepping [M-P4-M]
@@ -361,7 +361,7 @@ unsigned int speedstep_detect_processor(void)
 				msr_lo, msr_hi);
 		if ((msr_hi & (1<<18)) &&
 		    (relaxed_check ? 1 : (msr_hi & (3<<24)))) {
-			if (c->x86_mask == 0x01) {
+			if (c->x86_stepping == 0x01) {
 				pr_debug("early PIII version\n");
 				return SPEEDSTEP_CPU_PIII_C_EARLY;
 			} else
diff --git a/drivers/crypto/padlock-aes.c b/drivers/crypto/padlock-aes.c
index 4b6642a25df5..1c6cbda56afe 100644
--- a/drivers/crypto/padlock-aes.c
+++ b/drivers/crypto/padlock-aes.c
@@ -512,7 +512,7 @@ static int __init padlock_init(void)
 
 	printk(KERN_NOTICE PFX "Using VIA PadLock ACE for AES algorithm.\n");
 
-	if (c->x86 == 6 && c->x86_model == 15 && c->x86_mask == 2) {
+	if (c->x86 == 6 && c->x86_model == 15 && c->x86_stepping == 2) {
 		ecb_fetch_blocks = MAX_ECB_FETCH_BLOCKS;
 		cbc_fetch_blocks = MAX_CBC_FETCH_BLOCKS;
 		printk(KERN_NOTICE PFX "VIA Nano stepping 2 detected: enabling workaround.\n");
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 8b16ec595fa7..329cb96f886f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3147,7 +3147,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 	struct amd64_family_type *fam_type = NULL;
 
 	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
-	pvt->stepping	= boot_cpu_data.x86_mask;
+	pvt->stepping	= boot_cpu_data.x86_stepping;
 	pvt->model	= boot_cpu_data.x86_model;
 	pvt->fam	= boot_cpu_data.x86;
 
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index c13a4fd86b3c..a42744c7665b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -268,13 +268,13 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(tjmax_model_table); i++) {
 		const struct tjmax_model *tm = &tjmax_model_table[i];
 		if (c->x86_model == tm->model &&
-		    (tm->mask == ANY || c->x86_mask == tm->mask))
+		    (tm->mask == ANY || c->x86_stepping == tm->mask))
 			return tm->tjmax;
 	}
 
 	/* Early chips have no MSR for TjMax */
 
-	if (c->x86_model == 0xf && c->x86_mask < 4)
+	if (c->x86_model == 0xf && c->x86_stepping < 4)
 		usemsr_ee = 0;
 
 	if (c->x86_model > 0xe && usemsr_ee) {
@@ -425,7 +425,7 @@ static int chk_ucode_version(unsigned int cpu)
 	 * Readings might stop update when processor visited too deep sleep,
 	 * fixed for stepping D0 (6EC).
 	 */
-	if (c->x86_model == 0xe && c->x86_mask < 0xc && c->microcode < 0x39) {
+	if (c->x86_model == 0xe && c->x86_stepping < 0xc && c->microcode < 0x39) {
 		pr_err("Errata AE18 not fixed, update BIOS or microcode of the CPU!\n");
 		return -ENODEV;
 	}
diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index ef91b8a67549..84e91286fc4f 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -293,7 +293,7 @@ u8 vid_which_vrm(void)
 	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
 		return 0;	/* doesn't have VID */
 
-	vrm_ret = find_vrm(c->x86, c->x86_model, c->x86_mask, c->x86_vendor);
+	vrm_ret = find_vrm(c->x86, c->x86_model, c->x86_stepping, c->x86_vendor);
 	if (vrm_ret == 134)
 		vrm_ret = get_via_model_d_vrm();
 	if (vrm_ret == 0)
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 0721e175664a..b960015cb073 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -226,7 +226,7 @@ static bool has_erratum_319(struct pci_dev *pdev)
 	 * and AM3 formats, but that's the best we can do.
 	 */
 	return boot_cpu_data.x86_model < 4 ||
-	       (boot_cpu_data.x86_model == 4 && boot_cpu_data.x86_mask <= 2);
+	       (boot_cpu_data.x86_model == 4 && boot_cpu_data.x86_stepping <= 2);
 }
 
 static int k10temp_probe(struct pci_dev *pdev,
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 5a632bcf869b..e59f9113fb93 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -187,7 +187,7 @@ static int k8temp_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	model = boot_cpu_data.x86_model;
-	stepping = boot_cpu_data.x86_mask;
+	stepping = boot_cpu_data.x86_stepping;
 
 	/* feature available since SH-C0, exclude older revisions */
 	if ((model == 4 && stepping == 0) ||
diff --git a/drivers/video/fbdev/geode/video_gx.c b/drivers/video/fbdev/geode/video_gx.c
index 6082f653c68a..67773e8bbb95 100644
--- a/drivers/video/fbdev/geode/video_gx.c
+++ b/drivers/video/fbdev/geode/video_gx.c
@@ -127,7 +127,7 @@ void gx_set_dclk_frequency(struct fb_info *info)
 	int timeout = 1000;
 
 	/* Rev. 1 Geode GXs use a 14 MHz reference clock instead of 48 MHz. */
-	if (cpu_data(0).x86_mask == 1) {
+	if (cpu_data(0).x86_stepping == 1) {
 		pll_table = gx_pll_table_14MHz;
 		pll_table_len = ARRAY_SIZE(gx_pll_table_14MHz);
 	} else {
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index b99bced39ac2..fbc98e2c8228 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -19,20 +19,6 @@
 static inline unsigned long array_index_mask_nospec(unsigned long index,
 						    unsigned long size)
 {
-	/*
-	 * Warn developers about inappropriate array_index_nospec() usage.
-	 *
-	 * Even if the CPU speculates past the WARN_ONCE branch, the
-	 * sign bit of @index is taken into account when generating the
-	 * mask.
-	 *
-	 * This warning is compiled out when the compiler can infer that
-	 * @index and @size are less than LONG_MAX.
-	 */
-	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,
-			"array_index_nospec() limited to range of [0, LONG_MAX]\n"))
-		return 0;
-
 	/*
 	 * Always calculate and emit the mask even if the compiler
 	 * thinks the mask is not needed. The compiler does not take
@@ -43,6 +29,26 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 }
 #endif
 
+/*
+ * Warn developers about inappropriate array_index_nospec() usage.
+ *
+ * Even if the CPU speculates past the WARN_ONCE branch, the
+ * sign bit of @index is taken into account when generating the
+ * mask.
+ *
+ * This warning is compiled out when the compiler can infer that
+ * @index and @size are less than LONG_MAX.
+ */
+#define array_index_mask_nospec_check(index, size)				\
+({										\
+	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,			\
+	    "array_index_nospec() limited to range of [0, LONG_MAX]\n"))	\
+		_mask = 0;							\
+	else									\
+		_mask = array_index_mask_nospec(index, size);			\
+	_mask;									\
+})
+
 /*
  * array_index_nospec - sanitize an array index after a bounds check
  *
@@ -61,7 +67,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
+	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index b8adf05c534e..7dd8f34c37df 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -368,7 +368,7 @@ TRACE_EVENT(xen_mmu_flush_tlb,
 	    TP_printk("%s", "")
 	);
 
-TRACE_EVENT(xen_mmu_flush_tlb_single,
+TRACE_EVENT(xen_mmu_flush_tlb_one_user,
 	    TP_PROTO(unsigned long addr),
 	    TP_ARGS(addr),
 	    TP_STRUCT__entry(
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9cd028aa1509..c7fb5c2392ee 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -851,8 +851,14 @@ static int add_switch_table(struct objtool_file *file, struct symbol *func,
  *    This is a fairly uncommon pattern which is new for GCC 6.  As of this
  *    writing, there are 11 occurrences of it in the allmodconfig kernel.
  *
+ *    As of GCC 7 there are quite a few more of these and the 'in between' code
+ *    is significant. Esp. with KASAN enabled some of the code between the mov
+ *    and jmpq uses .rodata itself, which can confuse things.
+ *
  *    TODO: Once we have DWARF CFI and smarter instruction decoding logic,
  *    ensure the same register is used in the mov and jump instructions.
+ *
+ *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
 static struct rela *find_switch_table(struct objtool_file *file,
 				      struct symbol *func,
@@ -874,12 +880,25 @@ static struct rela *find_switch_table(struct objtool_file *file,
 						text_rela->addend + 4);
 		if (!rodata_rela)
 			return NULL;
+
 		file->ignore_unreachables = true;
 		return rodata_rela;
 	}
 
 	/* case 3 */
-	func_for_each_insn_continue_reverse(file, func, insn) {
+	/*
+	 * Backward search using the @first_jump_src links, these help avoid
+	 * much of the 'in between' code. Which avoids us getting confused by
+	 * it.
+	 */
+	for (insn = list_prev_entry(insn, list);
+
+	     &insn->list != &file->insn_list &&
+	     insn->sec == func->sec &&
+	     insn->offset >= func->offset;
+
+	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
+
 		if (insn->type == INSN_JUMP_DYNAMIC)
 			break;
 
@@ -909,14 +928,32 @@ static struct rela *find_switch_table(struct objtool_file *file,
 	return NULL;
 }
 
+
 static int add_func_switch_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
-	struct instruction *insn, *prev_jump = NULL;
+	struct instruction *insn, *last = NULL, *prev_jump = NULL;
 	struct rela *rela, *prev_rela = NULL;
 	int ret;
 
 	func_for_each_insn(file, func, insn) {
+		if (!last)
+			last = insn;
+
+		/*
+		 * Store back-pointers for unconditional forward jumps such
+		 * that find_switch_table() can back-track using those and
+		 * avoid some potentially confusing code.
+		 */
+		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
+		    insn->offset > last->offset &&
+		    insn->jump_dest->offset > insn->offset &&
+		    !insn->jump_dest->first_jump_src) {
+
+			insn->jump_dest->first_jump_src = insn;
+			last = insn->jump_dest;
+		}
+
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
@@ -1898,13 +1935,19 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 		if (is_kasan_insn(insn) || is_ubsan_insn(insn))
 			return true;
 
-		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest) {
-			insn = insn->jump_dest;
-			continue;
+		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
+			if (insn->jump_dest &&
+			    insn->jump_dest->func == insn->func) {
+				insn = insn->jump_dest;
+				continue;
+			}
+
+			break;
 		}
 
 		if (insn->offset + insn->len >= insn->func->offset + insn->func->len)
 			break;
+
 		insn = list_next_entry(insn, list);
 	}
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index dbadb304a410..23a1d065cae1 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -47,6 +47,7 @@ struct instruction {
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
+	struct instruction *first_jump_src;
 	struct list_head alts;
 	struct symbol *func;
 	struct stack_op stack_op;
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5d4f10ac2af2..aa6e2d7f6a1f 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -5,16 +5,26 @@ include ../lib.mk
 
 .PHONY: all all_32 all_64 warn_32bit_failure clean
 
-TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt ptrace_syscall test_mremap_vdso \
-			check_initial_reg_state sigreturn ldt_gdt iopl mpx-mini-test ioperm \
+UNAME_M := $(shell uname -m)
+CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
+CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
+
+TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
+			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
 			protection_keys test_vdso test_vsyscall
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip 5lvl
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
+# Some selftests require 32bit support enabled also on 64bit systems
+TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
-TARGETS_C_32BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_32BIT_ONLY)
+TARGETS_C_32BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_32BIT_ONLY) $(TARGETS_C_32BIT_NEEDED)
 TARGETS_C_64BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_64BIT_ONLY)
+ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),11)
+TARGETS_C_64BIT_ALL += $(TARGETS_C_32BIT_NEEDED)
+endif
+
 BINARIES_32 := $(TARGETS_C_32BIT_ALL:%=%_32)
 BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 
@@ -23,18 +33,16 @@ BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall -no-pie
 
-UNAME_M := $(shell uname -m)
-CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
-CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
-
 ifeq ($(CAN_BUILD_I386),1)
 all: all_32
 TEST_PROGS += $(BINARIES_32)
+EXTRA_CFLAGS += -DCAN_BUILD_32
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
 all: all_64
 TEST_PROGS += $(BINARIES_64)
+EXTRA_CFLAGS += -DCAN_BUILD_64
 endif
 
 all_32: $(BINARIES_32)
diff --git a/tools/testing/selftests/x86/mpx-mini-test.c b/tools/testing/selftests/x86/mpx-mini-test.c
index ec0f6b45ce8b..9c0325e1ea68 100644
--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -315,11 +315,39 @@ static inline void *__si_bounds_upper(siginfo_t *si)
 	return si->si_upper;
 }
 #else
+
+/*
+ * This deals with old version of _sigfault in some distros:
+ *
+
+old _sigfault:
+        struct {
+            void *si_addr;
+	} _sigfault;
+
+new _sigfault:
+	struct {
+		void __user *_addr;
+		int _trapno;
+		short _addr_lsb;
+		union {
+			struct {
+				void __user *_lower;
+				void __user *_upper;
+			} _addr_bnd;
+			__u32 _pkey;
+		};
+	} _sigfault;
+ *
+ */
+
 static inline void **__si_bounds_hack(siginfo_t *si)
 {
 	void *sigfault = &si->_sifields._sigfault;
 	void *end_sigfault = sigfault + sizeof(si->_sifields._sigfault);
-	void **__si_lower = end_sigfault;
+	int *trapno = (int*)end_sigfault;
+	/* skip _trapno and _addr_lsb */
+	void **__si_lower = (void**)(trapno + 2);
 
 	return __si_lower;
 }
@@ -331,7 +359,7 @@ static inline void *__si_bounds_lower(siginfo_t *si)
 
 static inline void *__si_bounds_upper(siginfo_t *si)
 {
-	return (*__si_bounds_hack(si)) + sizeof(void *);
+	return *(__si_bounds_hack(si) + 1);
 }
 #endif
 
diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index bc1b0735bb50..f15aa5a76fe3 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -393,34 +393,6 @@ pid_t fork_lazy_child(void)
 	return forkret;
 }
 
-void davecmp(void *_a, void *_b, int len)
-{
-	int i;
-	unsigned long *a = _a;
-	unsigned long *b = _b;
-
-	for (i = 0; i < len / sizeof(*a); i++) {
-		if (a[i] == b[i])
-			continue;
-
-		dprintf3("[%3d]: a: %016lx b: %016lx\n", i, a[i], b[i]);
-	}
-}
-
-void dumpit(char *f)
-{
-	int fd = open(f, O_RDONLY);
-	char buf[100];
-	int nr_read;
-
-	dprintf2("maps fd: %d\n", fd);
-	do {
-		nr_read = read(fd, &buf[0], sizeof(buf));
-		write(1, buf, nr_read);
-	} while (nr_read > 0);
-	close(fd);
-}
-
 #define PKEY_DISABLE_ACCESS    0x1
 #define PKEY_DISABLE_WRITE     0x2
 
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index a48da95c18fd..ddfdd635de16 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -119,7 +119,9 @@ static void check_result(void)
 
 int main()
 {
+#ifdef CAN_BUILD_32
 	int tmp;
+#endif
 
 	sethandler(SIGTRAP, sigtrap, 0);
 
@@ -139,12 +141,13 @@ int main()
 		      : : "c" (post_nop) : "r11");
 	check_result();
 #endif
-
+#ifdef CAN_BUILD_32
 	printf("[RUN]\tSet TF and check int80\n");
 	set_eflags(get_eflags() | X86_EFLAGS_TF);
 	asm volatile ("int $0x80" : "=a" (tmp) : "a" (SYS_getpid)
 			: INT80_CLOBBERS);
 	check_result();
+#endif
 
 	/*
 	 * This test is particularly interesting if fast syscalls use
diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index bf0d687c7db7..64f11c8d9b76 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -90,8 +90,12 @@ int main(int argc, char **argv, char **envp)
 			vdso_size += PAGE_SIZE;
 		}
 
+#ifdef __i386__
 		/* Glibc is likely to explode now - exit with raw syscall */
 		asm volatile ("int $0x80" : : "a" (__NR_exit), "b" (!!ret));
+#else /* __x86_64__ */
+		syscall(SYS_exit, ret);
+#endif
 	} else {
 		int status;
 
diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 29973cde06d3..235259011704 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -26,20 +26,59 @@
 # endif
 #endif
 
+/* max length of lines in /proc/self/maps - anything longer is skipped here */
+#define MAPS_LINE_LEN 128
+
 int nerrs = 0;
 
+typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
+
+getcpu_t vgetcpu;
+getcpu_t vdso_getcpu;
+
+static void *vsyscall_getcpu(void)
+{
 #ifdef __x86_64__
-# define VSYS(x) (x)
+	FILE *maps;
+	char line[MAPS_LINE_LEN];
+	bool found = false;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) /* might still be present, but ignore it here, as we test vDSO not vsyscall */
+		return NULL;
+
+	while (fgets(line, MAPS_LINE_LEN, maps)) {
+		char r, x;
+		void *start, *end;
+		char name[MAPS_LINE_LEN];
+
+		/* sscanf() is safe here as strlen(name) >= strlen(line) */
+		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
+			   &start, &end, &r, &x, name) != 5)
+			continue;
+
+		if (strcmp(name, "[vsyscall]"))
+			continue;
+
+		/* assume entries are OK, as we test vDSO here not vsyscall */
+		found = true;
+		break;
+	}
+
+	fclose(maps);
+
+	if (!found) {
+		printf("Warning: failed to find vsyscall getcpu\n");
+		return NULL;
+	}
+	return (void *) (0xffffffffff600800);
 #else
-# define VSYS(x) 0
+	return NULL;
 #endif
+}
 
-typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
-
-const getcpu_t vgetcpu = (getcpu_t)VSYS(0xffffffffff600800);
-getcpu_t vdso_getcpu;
 
-void fill_function_pointers()
+static void fill_function_pointers()
 {
 	void *vdso = dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
@@ -54,6 +93,8 @@ void fill_function_pointers()
 	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
 	if (!vdso_getcpu)
 		printf("Warning: failed to find getcpu in vDSO\n");
+
+	vgetcpu = (getcpu_t) vsyscall_getcpu();
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 7a744fa7b786..be81621446f0 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -33,6 +33,9 @@
 # endif
 #endif
 
+/* max length of lines in /proc/self/maps - anything longer is skipped here */
+#define MAPS_LINE_LEN 128
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -98,7 +101,7 @@ static int init_vsys(void)
 #ifdef __x86_64__
 	int nerrs = 0;
 	FILE *maps;
-	char line[128];
+	char line[MAPS_LINE_LEN];
 	bool found = false;
 
 	maps = fopen("/proc/self/maps", "r");
@@ -108,10 +111,12 @@ static int init_vsys(void)
 		return 0;
 	}
 
-	while (fgets(line, sizeof(line), maps)) {
+	while (fgets(line, MAPS_LINE_LEN, maps)) {
 		char r, x;
 		void *start, *end;
-		char name[128];
+		char name[MAPS_LINE_LEN];
+
+		/* sscanf() is safe here as strlen(name) >= strlen(line) */
 		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
 			   &start, &end, &r, &x, name) != 5)
 			continue;
