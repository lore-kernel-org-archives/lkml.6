Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDBEECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE9F2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE9F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeGUDOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 23:14:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:12438 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbeGUDOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 23:14:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 19:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,382,1526367600"; 
   d="gz'50?scan'50,208,50";a="74606091"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2018 19:22:45 -0700
Date:   Sat, 21 Jul 2018 10:23:25 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [lkp-robot] [confidence: ] 7757d607c6 [   56.996267] BUG: Bad page
 map in process trinity-c2  pte:0d755065 pmd:0d55b067
Message-ID: <20180721022325.GF12513@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline


Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti

commit 7757d607c6b31867777de42e1fb0210b9c5d8b70
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed Jul 18 11:41:14 2018 +0200
Commit:     Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri Jul 20 01:11:48 2018 +0200

    x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
    
    Allow PTI to be compiled on x86_32.
    
    Signed-off-by: Joerg Roedel <jroedel@suse.de>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Tested-by: Pavel Machek <pavel@ucw.cz>
    Cc: "H . Peter Anvin" <hpa@zytor.com>
    Cc: linux-mm@kvack.org
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Andy Lutomirski <luto@kernel.org>
    Cc: Dave Hansen <dave.hansen@intel.com>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Juergen Gross <jgross@suse.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Jiri Kosina <jkosina@suse.cz>
    Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
    Cc: Brian Gerst <brgerst@gmail.com>
    Cc: David Laight <David.Laight@aculab.com>
    Cc: Denys Vlasenko <dvlasenk@redhat.com>
    Cc: Eduardo Valentin <eduval@amazon.com>
    Cc: Greg KH <gregkh@linuxfoundation.org>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: aliguori@amazon.com
    Cc: daniel.gruss@iaik.tugraz.at
    Cc: hughd@google.com
    Cc: keescook@google.com
    Cc: Andrea Arcangeli <aarcange@redhat.com>
    Cc: Waiman Long <llong@redhat.com>
    Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
    Cc: joro@8bytes.org
    Link: https://lkml.kernel.org/r/1531906876-13451-38-git-send-email-joro@8bytes.org

6df934b92a  x86/ldt: Enable LDT user-mapping for PAE
7757d607c6  x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
8c934e01a7  x86/pti: Check the return value of pti_user_pagetable_walk_pmd()
4edd5aa38c  Merge branch 'linus'
+-----------------------------------------------+------------+------------+------------+------------+
|                                               | 6df934b92a | 7757d607c6 | 8c934e01a7 | 4edd5aa38c |
+-----------------------------------------------+------------+------------+------------+------------+
| boot_successes                                | 1286       | 307        | 282        | 622        |
| boot_failures                                 | 5          | 3          | 4          | 3          |
| Mem-Info                                      | 5          | 1          | 2          | 1          |
| invoked_oom-killer:gfp_mask=0x                | 3          |            |            |            |
| BUG:Bad_page_map_in_process                   | 0          | 2          | 2          | 1          |
| BUG:Bad_page_state_in_process                 | 0          | 2          | 2          | 1          |
| BUG:Bad_rss-counter_state_mm:(ptrval)idx:#val | 0          | 1          | 2          | 1          |
| kernel_BUG_at_mm/filemap.c                    | 0          | 0          | 1          |            |
| invalid_opcode:#[##]                          | 0          | 0          | 1          |            |
| EIP:unaccount_page_cache_page                 | 0          | 0          | 1          |            |
| Kernel_panic-not_syncing:Fatal_exception      | 0          | 0          | 1          | 1          |
| BUG:unable_to_handle_kernel                   | 0          | 0          | 0          | 1          |
| Oops:#[##]                                    | 0          | 0          | 0          | 1          |
| EIP:put_pid                                   | 0          | 0          | 0          | 1          |
+-----------------------------------------------+------------+------------+------------+------------+

[child3:1823] fdatasync (148) returned ENOSYS, marking as inactive.
[main] 12067 iterations. [F:7570 S:4509 HI:2917]
[   28.550832] warning: process `trinity-c0' used the obsolete bdflush system call
[   28.558277] Fix your initscripts?
[   50.480036] trinity-c0 (1412) used greatest stack depth: 5416 bytes left
[   56.996267] BUG: Bad page map in process trinity-c2  pte:0d755065 pmd:0d55b067
[   56.997421] page:bfa00aa0 count:1 mapcount:-1 mapping:00000000 index:0x0
[   56.998417] flags: 0xc000014(referenced|dirty)
[   56.999087] raw: 0c000014 00000100 00000200 00000000 00000000 00000000 fffffffe 00000001
[   57.000311] page dumped because: bad pte
[   57.000909] addr:21632421 vm_flags:00100873 anon_vma:d90b494d mapping:7c8e0e7b index:3ec
[   57.002102] file:trinity fault:filemap_fault mmap:generic_file_mmap readpage:simple_readpage
[   57.003344] CPU: 0 PID: 1670 Comm: trinity-c2 Not tainted 4.18.0-rc4-00209-g7757d60 #1
[   57.004505] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   57.005724] Call Trace:
[   57.006112]  dump_stack+0x75/0xa9
[   57.006612]  ? dcache_readdir+0x15a/0x15a
[   57.007221]  print_bad_pte+0x166/0x180
[   57.007789]  ? __lock_page_or_retry+0xa1/0xa1
[   57.008436]  ? read_cache_page_gfp+0x1c/0x1c
[   57.009072]  ? dcache_readdir+0x15a/0x15a
[   57.009676]  unmap_page_range+0x3e1/0x596
[   57.010296]  unmap_single_vma+0x8b/0x95
[   57.010882]  unmap_vmas+0x27/0x36
[   57.011380]  exit_mmap+0x93/0x121
[   57.011905]  mmput+0x44/0xbf
[   57.012342]  do_exit+0x31d/0x802
[   57.012836]  ? _raw_spin_unlock_irq+0x22/0x44
[   57.013489]  do_group_exit+0x30/0x86
[   57.014032]  get_signal+0x5e0/0x605
[   57.014560]  do_signal+0x24/0x4c1
[   57.015071]  ? _raw_spin_unlock_irqrestore+0x3a/0x5f
[   57.015809]  ? trace_hardirqs_on_caller+0x14b/0x166
[   57.016549]  ? trace_hardirqs_on_caller+0x14b/0x166
[   57.017276]  exit_to_usermode_loop+0x37/0x69
[   57.017919]  do_fast_syscall_32+0x217/0x249
[   57.018542]  entry_SYSENTER_32+0x70/0xc8
[   57.019127] EIP: 0xa7fc8bf9
[   57.019546] Code: ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 
[   57.022438] EAX: fffffe00 EBX: a6d55000 ECX: 00085000 EDX: 00000002
[   57.023356] ESI: 00000008 EDI: 00400000 EBP: fffffffc ESP: afe06e5c
[   57.024269] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   57.025347] Disabling lock debugging due to kernel taint
[main] trace_fd was -1
[main] kernel became tainted! (32/0) Last seed was 2560220593
trinity: Detected kernel tainting. Last seed was 2560220593
[main] exit_reason=7, but 3 children still running.
[child1:2134] trace_fd was -1
[main] trace_fd was -1
[main] kernel became tainted! (32/0) Last seed was 1446110596
trinity: Detected kernel tainting. Last seed was 1446110596
[   57.096675] BUG: Bad page state in process trinity-c2  pfn:0d755
[   57.097586] page:bfa00aa0 count:0 mapcount:-1 mapping:00000000 index:0x0
[   57.098572] flags: 0xc000014(referenced|dirty)
[   57.099238] raw: 0c000014 bdf45ce4 bdf45ce4 00000000 00000000 00000000 fffffffe 00000000
[   57.104018] page dumped because: nonzero mapcount
[   57.104732] Modules linked in:
[   57.105200] CPU: 0 PID: 1670 Comm: trinity-c2 Tainted: G    B             4.18.0-rc4-00209-g7757d60 #1
[   57.106552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   57.107782] Call Trace:
[   57.108160]  dump_stack+0x75/0xa9
[   57.108658]  bad_page+0xec/0x109
[   57.109146]  free_pages_check_bad+0x40/0x42
[   57.109768]  free_unref_page_prepare+0x4d/0xef
[   57.110421]  free_unref_page_list+0x3e/0x115
[   57.111059]  release_pages+0xd9/0x28f
[   57.111604]  free_pages_and_swap_cache+0x72/0x78
[   57.112292]  tlb_flush_mmu_free+0x20/0x33
[   57.112886]  unmap_page_range+0x56f/0x596
[   57.113486]  unmap_single_vma+0x8b/0x95
[   57.114058]  unmap_vmas+0x27/0x36
[   57.114553]  exit_mmap+0x93/0x121
[   57.115056]  mmput+0x44/0xbf
[   57.115488]  do_exit+0x31d/0x802
[   57.115976]  ? _raw_spin_unlock_irq+0x22/0x44
[   57.116617]  do_group_exit+0x30/0x86
[   57.117154]  get_signal+0x5e0/0x605
[   57.117676]  do_signal+0x24/0x4c1
[   57.118175]  ? _raw_spin_unlock_irqrestore+0x3a/0x5f
[   57.118912]  ? trace_hardirqs_on_caller+0x14b/0x166
[   57.119631]  ? trace_hardirqs_on_caller+0x14b/0x166
[   57.120347]  exit_to_usermode_loop+0x37/0x69
[   57.120981]  do_fast_syscall_32+0x217/0x249
[   57.121596]  entry_SYSENTER_32+0x70/0xc8
[   57.122178] EIP: 0xa7fc8bf9
[   57.122592] Code: Bad RIP value.
[   57.123085] EAX: fffffe00 EBX: a6d55000 ECX: 00085000 EDX: 00000002
[   57.124006] ESI: 00000008 EDI: 00400000 EBP: fffffffc ESP: afe06e5c
[   57.124921] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[main] exit_reason=7, but 2 children still running.
[main] trace_fd was -1
[main] kernel became tainted! (32/0) Last seed was 669750733
trinity: Detected kernel tainting. Last seed was 669750733
Failed to write post mortem log (Permission denied)

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 8c934e01a7ce685d98e970880f5941d79272c654 37b5dca2898d1471729194f45e281c2443eb9d6c --
git bisect good 8372d66865deb45ee3ec21401a9c80f231b728c8  # 23:36  G    304     0    4   4  x86/pgtable: Move pgdp kernel/user conversion functions to pgtable.h
git bisect good b976690f5db26fbc7c2be413bfa0fbd270547a94  # 00:10  G    305     0    5   5  x86/mm/pti: Introduce pti_finalize()
git bisect good 9bae3197e15dd5e03ce8e237db6fe4486b08a775  # 00:49  G    308     0    3   4  x86/ldt: Split out sanity check in map_ldt_struct()
git bisect  bad 5e8105950a8b3e03e805299b4d05020ee4eda31a  # 01:12  B    131     1    4   4  x86/mm/pti: Add Warning when booting on a PCID capable CPU
git bisect good 6df934b92a549cb3badb6d576f71aeb133e2f110  # 01:47  G    310     0    7  10  x86/ldt: Enable LDT user-mapping for PAE
git bisect  bad 7757d607c6b31867777de42e1fb0210b9c5d8b70  # 02:08  B    134     1    2   2  x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
# first bad commit: [7757d607c6b31867777de42e1fb0210b9c5d8b70] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
git bisect good 6df934b92a549cb3badb6d576f71aeb133e2f110  # 03:14  G    900     0    9  19  x86/ldt: Enable LDT user-mapping for PAE
# extra tests on HEAD of tip/x86/pti
git bisect  bad 8c934e01a7ce685d98e970880f5941d79272c654  # 03:15  B    279     2    0   6  x86/pti: Check the return value of pti_user_pagetable_walk_pmd()
# extra tests on tree/branch tip/x86/pti
git bisect  bad 8c934e01a7ce685d98e970880f5941d79272c654  # 03:20  B    279     2    0   6  x86/pti: Check the return value of pti_user_pagetable_walk_pmd()
# extra tests with first bad commit reverted
git bisect good 90d0ce801fac8115d424e40a4a258aeed0e409dd  # 03:58  G    302     0    7   7  Revert "x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32"
# extra tests on tree/branch tip/master
git bisect  bad 4edd5aa38cec47346e0d0a85fa43964828b982d0  # 04:37  B    257     1    5   6  Merge branch 'linus'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--Mjqg7Yu+0hL22rav
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-118:20180721023515:i386-randconfig-s1-201828:4.18.0-rc4-00209-g7757d60:1.gz"
Content-Transfer-Encoding: base64

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
p40g+h8CAA==

--Mjqg7Yu+0hL22rav
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-105:20180721030145:i386-randconfig-s1-201828:4.18.0-rc4-00208-g6df934b:20.gz"
Content-Transfer-Encoding: base64

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

--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-ivb41-118:20180721023515:i386-randconfig-s1-201828:4.18.0-rc4-00209-g7757d60:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 256
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.18.0-rc4-00209-g7757d60"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.18.0-rc4 Kernel Configuration
#

#
# Compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
#
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=60400
CONFIG_CLANG_VERSION=0
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_PROFILING is not set
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
# CONFIG_ACORN_PARTITION_EESOX is not set
# CONFIG_ACORN_PARTITION_ICS is not set
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=m
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
CONFIG_FREEZER=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
CONFIG_M486=y
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=4
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_F00F_BUG=y
CONFIG_X86_INVD_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_3G_OPT=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xB0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZSWAP is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
# CONFIG_ACPI_HED is not set
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_AMD_FREQ_SENSITIVITY=y
CONFIG_X86_GX_SUSPMOD=y
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
CONFIG_PCI_GOMMCONFIG=y
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_EP is not set
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=m

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
CONFIG_OLPC_XO15_SCI=y
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
# CONFIG_RAPIDIO_ENUM_BASIC is not set
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
CONFIG_RAPIDIO_CPS_XX=m
# CONFIG_RAPIDIO_TSI568 is not set
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=m
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
# CONFIG_OF_DYNAMIC is not set
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_UMEM=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=y
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=m

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=m
# CONFIG_IDE_GD_ATA is not set
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_PLATFORM=m
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=m
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=m
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=m
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_CS5520=m
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_BLK_DEV_CS5535=m
# CONFIG_BLK_DEV_CS5536 is not set
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_JMICRON=m
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=m
# CONFIG_BLK_DEV_IT8172 is not set
CONFIG_BLK_DEV_IT8213=m
# CONFIG_BLK_DEV_IT821X is not set
CONFIG_BLK_DEV_NS87415=m
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
# CONFIG_BLK_DEV_SLC90E66 is not set
CONFIG_BLK_DEV_TRM290=m
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_TC86C001=m
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
CONFIG_AHCI_CEVA=m
CONFIG_AHCI_QORIQ=m
CONFIG_SATA_INIC162X=m
CONFIG_SATA_ACARD_AHCI=m
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=m
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=m
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DA9052=m
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=m
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2005 is not set
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_PCAP=y
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_STMPE=y
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=m
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_MAX77693_HAPTIC=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=m
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_CPCAP_PWRBUTTON is not set
CONFIG_INPUT_WISTRON_BTNS=y
CONFIG_INPUT_ATLAS_BTNS=m
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_KXTJ9_POLLED_MODE=y
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=m
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=m
# CONFIG_INPUT_TWL6040_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PALMAS_PWRBUTTON is not set
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_RK805_PWRKEY=m
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
CONFIG_INPUT_DA9052_ONKEY=m
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_PCAP=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
# CONFIG_INPUT_ADXL34X_SPI is not set
CONFIG_INPUT_CMA3000=m
# CONFIG_INPUT_CMA3000_I2C is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=m
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
# CONFIG_SERIAL_8250_PNP is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_ASPEED_VUART=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_MOXA=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_IFX6X60=m
CONFIG_SERIAL_PCH_UART=y
CONFIG_SERIAL_PCH_UART_CONSOLE=y
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_TTY_PRINTK=m
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=m
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
CONFIG_MWAVE=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=m
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=m

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_PCI=m
# CONFIG_SPI_DW_MID_DMA is not set
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_GPIO=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_TOPCLIFF_PCH=m
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=m

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=m
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_CRYSTAL_COVE is not set
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_JANZ_TTL=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TPS68470 is not set
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=m
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=m
# CONFIG_GPIO_XRA1403 is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
CONFIG_BATTERY_CPCAP=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_LEGO_EV3=m
CONFIG_BATTERY_OLPC=m
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9052=m
CONFIG_BATTERY_DA9150=y
# CONFIG_AXP20X_POWER is not set
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=m
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=m
# CONFIG_CHARGER_88PM860X is not set
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_LP8788=m
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LTC3651=m
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MAX8998=m
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_CHARGER_RT9455=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7314=m
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31722=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CPU_THERMAL=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_QORIQ_THERMAL is not set
CONFIG_DA9062_THERMAL=y
CONFIG_INTEL_POWERCLAMP=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_GENERIC_ADC_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_MFD_ATMEL_HLCDC=m
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=m
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
CONFIG_STMPE_SPI=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TPS68470=y
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_RAVE_SP_CORE=m
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_CPCAP=m
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8998=m
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCAP=m
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_VCTRL=m
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=m
CONFIG_CEC_CORE=m
CONFIG_CEC_PIN=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX25821=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_DVB=m
# CONFIG_VIDEO_SAA7164 is not set

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
# CONFIG_DVB_PT1 is not set
CONFIG_DVB_PT3=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
CONFIG_DVB_NETUP_UNIDVB=m
# CONFIG_VIDEO_IPU3_CIO2 is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_CEC_GPIO=m

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
CONFIG_RADIO_SI4713=m
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_SAA7706H=m
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=m

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_VIDEO_TVEEPROM=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24120=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2841ER=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_AGP_ATI=y
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_NVIDIA=y
CONFIG_AGP_SIS=y
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_ASUS=m
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_APU=m
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_BCM6328=m
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
CONFIG_LEDS_CR0014114=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=m
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=m
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=m
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_HWMON is not set
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=m
# CONFIG_RTC_DRV_LP8788 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RK808=m
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS65910=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=m
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=y
CONFIG_RTC_DRV_DS1305=y
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=y
# CONFIG_RTC_DRV_RX4581 is not set
CONFIG_RTC_DRV_RX6110=m
CONFIG_RTC_DRV_RS5C348=y
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DS1685_PROC_REGS=y
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=m
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9063=m
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_ZYNQMP=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_PCAP is not set
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MT6397=m
CONFIG_RTC_DRV_R7301=m
CONFIG_RTC_DRV_CPCAP=m

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=m
CONFIG_FSL_EDMA=m
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=m
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=m
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
CONFIG_COMEDI_PCL724=m
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=m
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=m
# CONFIG_COMEDI_RTI802 is not set
CONFIG_COMEDI_DAC02=y
# CONFIG_COMEDI_DAS16M1 is not set
CONFIG_COMEDI_DAS08_ISA=y
# CONFIG_COMEDI_DAS16 is not set
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=m
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=m
# CONFIG_COMEDI_DT282X is not set
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=m
CONFIG_COMEDI_C6XDIGIO=y
CONFIG_COMEDI_MPC624=m
CONFIG_COMEDI_ADQ12B=m
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
# CONFIG_COMEDI_NI_LABPC_ISA is not set
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=y
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
# CONFIG_COMEDI_CB_DAS16_CS is not set
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
# CONFIG_COMEDI_NI_LABPC_CS is not set
# CONFIG_COMEDI_NI_MIO_CS is not set
# CONFIG_COMEDI_QUATECH_DAQP_CS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=m

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=m

#
# Analog to digital converters
#
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
# CONFIG_AD7780 is not set
# CONFIG_AD7816 is not set
CONFIG_AD7192=m
CONFIG_AD7280=m

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7152=m
CONFIG_AD7746=m

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
# CONFIG_AD9834 is not set

#
# Digital gyroscope sensors
#
CONFIG_ADIS16060=m

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Active energy metering IC
#
CONFIG_ADE7854=m
CONFIG_ADE7854_I2C=m
CONFIG_ADE7854_SPI=m

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1210=m

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y
# CONFIG_I2C_BCM2048 is not set
# CONFIG_VIDEO_ZORAN is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ION is not set
# CONFIG_STAGING_BOARD is not set
CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_DGNC=y
CONFIG_GS_FPGABOOT=y
CONFIG_UNISYSSPAR=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
CONFIG_MOST_VIDEO=m
# CONFIG_MOST_DIM2 is not set
# CONFIG_MOST_I2C is not set
CONFIG_GREYBUS=y
# CONFIG_GREYBUS_AUDIO is not set
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=m
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=m
# CONFIG_GREYBUS_LOOPBACK is not set
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SPI=m
CONFIG_GREYBUS_UART=y

#
# USB Power Delivery and Type-C drivers
#
CONFIG_PI433=y
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CHROMEOS_TBMC=m
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_RK808=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=m
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_CLK_TWL6040=m
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_VC5=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX77843 is not set
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=m
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
CONFIG_BMA180=m
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD06=m
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
# CONFIG_MC3230 is not set
CONFIG_MMA7455=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=m
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD7266 is not set
CONFIG_AD7291=m
# CONFIG_AD7298 is not set
CONFIG_AD7476=m
CONFIG_AD7766=m
# CONFIG_AD7791 is not set
CONFIG_AD7793=m
CONFIG_AD7887=m
# CONFIG_AD7923 is not set
CONFIG_AD799X=m
# CONFIG_AXP20X_ADC is not set
# CONFIG_AXP288_ADC is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_CPCAP_ADC is not set
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HI8435=m
CONFIG_HX711=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=m
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=m
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=m
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
CONFIG_TI_ADS8688=m
CONFIG_TI_TLC4541=m
# CONFIG_VF610_ADC is not set

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set

#
# Amplifiers
#
CONFIG_AD8366=m

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=m
# CONFIG_AD5360 is not set
CONFIG_AD5380=m
CONFIG_AD5421=m
# CONFIG_AD5446 is not set
CONFIG_AD5449=m
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC2632=m
CONFIG_AD5686=m
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=m
# CONFIG_AD5755 is not set
CONFIG_AD5761=m
CONFIG_AD5764=m
CONFIG_AD5791=m
CONFIG_AD7303=m
CONFIG_AD8801=m
CONFIG_DPOT_DAC=m
CONFIG_DS4424=m
# CONFIG_M62332 is not set
CONFIG_MAX517=m
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
CONFIG_MCP4922=m
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_VF610_DAC is not set

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
CONFIG_SI7005=m
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16480=m
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=m
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=m
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set

#
# Multiplexers
#
CONFIG_IIO_MUX=m

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=m
CONFIG_MAX5481=m
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=m
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=m
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
# CONFIG_HID_SENSOR_PRESS is not set
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m

#
# Lightning sensors
#
CONFIG_AS3935=m

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=m

#
# Resolver to digital converters
#
CONFIG_AD2S1200=m

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=m
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=m
# CONFIG_PWM_CRC is not set
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_STMPE is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=m
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# CONFIG_RAS is not set
CONFIG_THUNDERBOLT=m

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
# CONFIG_RAVE_SP_EEPROM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=m
# CONFIG_FPGA_BRIDGE is not set
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=m
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE_OF is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
CONFIG_EFI_TEST=m
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=m
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=m
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=m
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=m
# CONFIG_HFSPLUS_FS_POSIX_ACL is not set
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=m
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
CONFIG_FAIL_FUTEX=y
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_SORT=m
CONFIG_KPROBES_SANITY_TEST=y
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_OVERFLOW is not set
CONFIG_TEST_RHASHTABLE=m
CONFIG_TEST_HASH=m
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_KMOD is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=m
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_AEGIS128L=m
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_MORUS640=y
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_GEODE is not set
CONFIG_CRYPTO_DEV_HIFN_795X=y
# CONFIG_CRYPTO_DEV_HIFN_795X_RNG is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_CCREE is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=m
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--Mjqg7Yu+0hL22rav--
