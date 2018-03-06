Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2968864-1520295966-2-7898275826347624879
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520295965; b=V4Hn2qgoSSDEcwq4GWNwNeOr8uDdgXqym2TqB68m49oG9mB
    ndXzO446m3aqbzUe2JIU9bjiNkjI+Cv3YF/9RFw/Qhi70teJUaWBdSFtFwtFa0zs
    svtgIXQMOcrY5oLvsXq3k2MCOMjQkosiJDaJX6VbM3WBgWcaeSdDWbDkPLMVMW/n
    rwGVaP/vnIUsSS9Pr7Gf0SIrG3gelT6WFe4Em1PR5xc3qNqp3gSn0TBVYV35F9xA
    A4tbnXG/LGSXbdNWERCugOADJfhcauLEHqdaF3+AP+yTq4U353iMlXMKkiHY87b/
    rYv+xNBA6CQIR+di6taOLCka4It4VjiNaFh3sKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520295965; bh=T2q81Qfo3k2RzZKxxZuqijHOWh
    4dsaozZ2Wxa1XNryI=; b=OZgdgSyWJ3NXzb3xZCwDqlixwTm5apUBvz3st42Xrj
    WZujTpLBiE3ZSrhr9GTv0rgYTGTupINumvle+QW57KQOtswT4MmKjz7YpkphV+b2
    SwjVVdlH8CmeDp06OJtElI0KCo1IDD5H7mb8TgxYydnQwFYcbq8HbzJnwu0McK/j
    CpePFcHK0KimrvOTSuYGR+761OVbS0HpUnZ9wrfW35AtNubu8/cJYi0lpgVjYhV2
    Q35MoSov2H/2T40c08isAQLOOczTllv49PX/yXTVzVTFkQm1KCiJ5we+H7t/dKwR
    OqK5yDZuLgYpvDNWuo9lH+9YM0tqScncbVY/6voMAV4g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ozy9Hm3C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ozy9Hm3C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeCFA0E (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:26:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34670 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeCFA0D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:03 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 00/65] page table isolation for stable 4.1
Date: Mon,  5 Mar 2018 19:24:33 -0500
Message-Id: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The git of this backport can be found here:
git clone --branch pti_v4.1.49 https://github.com/soleen/linux

The patches were backported from stable 4.4 to Oracle UEK4.1, and from
UEK4.1 to Stable 4.1

Aaron Lu (1):
  x86/irq: Do not substract irq_tlb_count from irq_call_count

Andy Lutomirski (16):
  x86/mm: Add INVPCID helpers
  x86/mm: Add a 'noinvpcid' boot option to turn off INVPCID
  x86/mm: If INVPCID is available, use it to flush global mappings
  sched/core: Add switch_mm_irqs_off() and use it in the scheduler
  x86/mm: Build arch/x86/mm/tlb.c even on !SMP
  x86/mm, sched/core: Turn off IRQs in switch_mm()
  sched/core: Idle_task_exit() shouldn't use switch_mm_irqs_off()
  x86/vm86/32: Switch to flush_tlb_mm_range() in mark_screen_rdonly()
  x86/mm: Remove flush_tlb() and flush_tlb_current_task()
  x86/mm: Make flush_tlb_mm_range() more predictable
  x86/mm: Reimplement flush_tlb_page() using flush_tlb_mm_range()
  x86/mm: Remove the UP asm/tlbflush.h code, always use the (formerly)
    SMP code
  x86/mm: Disable PCID on 32-bit kernels
  x86/mm: Add the 'nopcid' boot option to turn off PCID
  x86/mm: Enable CR4.PCIDE on supported systems
  x86/mm/64: Fix reboot interaction with CR4.PCIDE

Borislav Petkov (5):
  x86/mm: Fix INVPCID asm constraint
  x86/kaiser: Rename and simplify X86_FEATURE_KAISER handling
  x86/kaiser: Check boottime cmdline params
  x86/kaiser: Reenable PARAVIRT
  x86/kaiser: Move feature detection up

Dave Hansen (2):
  kaiser: merged update
  kaiser: enhanced by kernel and user PCIDs

Denys Vlasenko (3):
  x86/entry: Stop using PER_CPU_VAR(kernel_stack)
  x86/entry: Remove unused 'kernel_stack' per-cpu variable
  x86/entry: Define 'cpu_current_top_of_stack' for 64-bit code

Hugh Dickins (26):
  kaiser: do not set _PAGE_NX on pgd_none
  kaiser: stack map PAGE_SIZE at THREAD_SIZE-PAGE_SIZE
  kaiser: fix build and FIXME in alloc_ldt_struct()
  kaiser: KAISER depends on SMP
  kaiser: fix regs to do_nmi() ifndef CONFIG_KAISER
  kaiser: fix perf crashes
  kaiser: ENOMEM if kaiser_pagetable_walk() NULL
  kaiser: tidied up asm/kaiser.h somewhat
  kaiser: tidied up kaiser_add/remove_mapping slightly
  kaiser: kaiser_remove_mapping() move along the pgd
  kaiser: cleanups while trying for gold link
  kaiser: name that 0x1000 KAISER_SHADOW_PGD_OFFSET
  kaiser: delete KAISER_REAL_SWITCH option
  kaiser: vmstat show NR_KAISERTABLE as nr_overhead
  kaiser: load_new_mm_cr3() let SWITCH_USER_CR3 flush user
  kaiser: PCID 0 for kernel and 128 for user
  kaiser: x86_cr3_pcid_noflush and x86_cr3_pcid_user
  kaiser: paranoid_entry pass cr3 need to paranoid_exit
  kaiser: _pgd_alloc() without __GFP_REPEAT to avoid stalls
  kaiser: fix unlikely error in alloc_ldt_struct()
  kaiser: add "nokaiser" boot option, using ALTERNATIVE
  kaiser: add "nokaiser" boot option, using ALTERNATIVE
  kaiser: use ALTERNATIVE instead of x86_cr3_pcid_noflush
  kaiser: drop is_atomic arg to kaiser_pagetable_walk()
  kaiser: asm/tlbflush.h handle noPGE at lower level
  kaiser: kaiser_flush_tlb_on_return_to_user() check PCID

Ingo Molnar (1):
  mm/mmu_context, sched/core: Fix mmu_context.h assumption

Jamie Iles (1):
  x86/ldt: fix crash in ldt freeing.

Jiri Kosina (1):
  PTI: unbreak EFI old_memmap

Kees Cook (1):
  KPTI: Rename to PAGE_TABLE_ISOLATION

Konrad Rzeszutek Wilk (1):
  kpti: Disable when running under Xen PV

Pavel Tatashin (3):
  x86/mm, sched/core: Uninline switch_mm()
  pti: Rename X86_FEATURE_KAISER to X86_FEATURE_PTI
  x86/pti/efi: broken conversion from efi to kernel page table

Richard Fellner (1):
  KAISER: Kernel Address Isolation

Steven Rostedt (1):
  ARM: Hide finish_arch_post_lock_switch() from modules

Thomas Gleixner (1):
  x86/paravirt: Dont patch flush_tlb_single

Tom Lendacky (1):
  x86/boot: Add early cmdline parsing for options with arguments

 Documentation/kernel-parameters.txt         |  12 +
 arch/arm/include/asm/mmu_context.h          |   2 +
 arch/x86/boot/compressed/misc.h             |   1 +
 arch/x86/ia32/ia32entry.S                   |  11 +-
 arch/x86/include/asm/cmdline.h              |   2 +
 arch/x86/include/asm/cpufeature.h           |   7 +
 arch/x86/include/asm/desc.h                 |   2 +-
 arch/x86/include/asm/disabled-features.h    |   4 +-
 arch/x86/include/asm/hardirq.h              |   6 +-
 arch/x86/include/asm/hw_irq.h               |   2 +-
 arch/x86/include/asm/kaiser.h               | 151 ++++++++++
 arch/x86/include/asm/mmu.h                  |   6 -
 arch/x86/include/asm/mmu_context.h          | 101 +------
 arch/x86/include/asm/pgtable.h              |  28 +-
 arch/x86/include/asm/pgtable_64.h           |  25 +-
 arch/x86/include/asm/pgtable_types.h        |  29 +-
 arch/x86/include/asm/processor.h            |   2 +-
 arch/x86/include/asm/thread_info.h          |   8 +-
 arch/x86/include/asm/tlbflush.h             | 233 +++++++++------
 arch/x86/include/uapi/asm/processor-flags.h |   3 +-
 arch/x86/kernel/cpu/bugs.c                  |   8 +
 arch/x86/kernel/cpu/common.c                |  86 +++++-
 arch/x86/kernel/cpu/perf_event_intel_ds.c   |  57 +++-
 arch/x86/kernel/entry_64.S                  | 170 +++++++++--
 arch/x86/kernel/espfix_64.c                 |  10 +
 arch/x86/kernel/head_64.S                   |  35 ++-
 arch/x86/kernel/irq.c                       |   3 +-
 arch/x86/kernel/irqinit.c                   |   2 +-
 arch/x86/kernel/ldt.c                       |  25 +-
 arch/x86/kernel/paravirt_patch_64.c         |   2 -
 arch/x86/kernel/process.c                   |   2 +-
 arch/x86/kernel/process_32.c                |   5 +-
 arch/x86/kernel/process_64.c                |   3 -
 arch/x86/kernel/reboot.c                    |   4 +
 arch/x86/kernel/setup.c                     |   7 +
 arch/x86/kernel/smpboot.c                   |   2 -
 arch/x86/kernel/tracepoint.c                |   2 +
 arch/x86/kernel/vm86_32.c                   |   2 +-
 arch/x86/kvm/x86.c                          |   3 +-
 arch/x86/lib/cmdline.c                      | 105 +++++++
 arch/x86/mm/Makefile                        |   4 +-
 arch/x86/mm/init.c                          |   4 +-
 arch/x86/mm/init_64.c                       |  10 +
 arch/x86/mm/kaiser.c                        | 449 ++++++++++++++++++++++++++++
 arch/x86/mm/pageattr.c                      |  63 +++-
 arch/x86/mm/pgtable.c                       |  16 +-
 arch/x86/mm/tlb.c                           | 194 ++++++++----
 arch/x86/platform/efi/efi_64.c              |   6 +
 arch/x86/realmode/init.c                    |   4 +-
 arch/x86/realmode/rm/trampoline_64.S        |   3 +-
 arch/x86/xen/enlighten.c                    |   6 +
 arch/x86/xen/xen-asm_64.S                   |   6 +-
 include/asm-generic/vmlinux.lds.h           |   7 +
 include/linux/kaiser.h                      |  52 ++++
 include/linux/mmu_context.h                 |   7 +
 include/linux/mmzone.h                      |   3 +-
 include/linux/percpu-defs.h                 |  32 +-
 init/main.c                                 |   2 +
 kernel/fork.c                               |   6 +
 kernel/sched/core.c                         |   4 +-
 mm/mmu_context.c                            |   2 +-
 mm/vmstat.c                                 |   1 +
 security/Kconfig                            |  10 +
 63 files changed, 1687 insertions(+), 372 deletions(-)
 create mode 100644 arch/x86/include/asm/kaiser.h
 create mode 100644 arch/x86/mm/kaiser.c
 create mode 100644 include/linux/kaiser.h

-- 
2.16.2
