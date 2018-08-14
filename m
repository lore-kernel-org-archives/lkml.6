Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC530C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D5021738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D5021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbeHNUgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:36:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390875AbeHNUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:36:06 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14C78C8D;
        Tue, 14 Aug 2018 17:47:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/43] 4.4.148-stable review
Date:   Tue, 14 Aug 2018 19:17:36 +0200
Message-Id: <20180814171517.014285600@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.148-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.148-rc1
X-KernelTest-Deadline: 2018-08-16T17:15+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.148 release.
There are 43 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Aug 16 17:14:59 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.148-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.148-rc1

Guenter Roeck <linux@roeck-us.net>
    x86/speculation/l1tf: Fix up CPU feature flags

Andi Kleen <ak@linux.intel.com>
    x86/mm/kmmio: Make the tracer robust against L1TF

Andi Kleen <ak@linux.intel.com>
    x86/mm/pat: Make set_memory_np() L1TF safe

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Make pmd/pud_mknotpresent() invert

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Invert all not present mappings

Michal Hocko <mhocko@suse.cz>
    x86/speculation/l1tf: Fix up pte->pfn conversion for PAE

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Protect PAE swap entries against L1TF

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/cpufeatures: Add detection of L1D cache flush support.

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Extend 64bit swap file size limit

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Move the l1tf function and define pr_fmt properly

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Limit swap file size to MAX_PA/2

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings

Dan Williams <dan.j.williams@intel.com>
    mm: fix cache mode tracking in vm_insert_mixed()

Andy Lutomirski <luto@kernel.org>
    mm: Add vm_insert_pfn_prot()

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Add sysfs reporting for l1tf

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Make sure the first page is always reserved

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation

Linus Torvalds <torvalds@linux-foundation.org>
    x86/speculation/l1tf: Protect swap entries against L1TF

Linus Torvalds <torvalds@linux-foundation.org>
    x86/speculation/l1tf: Change order of offset/type in swap entry

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    mm: x86: move _PAGE_SWP_SOFT_DIRTY from bit 7 to bit 1

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Fix swap entry comment and macro

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Move swap offset/type up in PTE to work around erratum

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Increase 32bit PAE __PHYSICAL_PAGE_SHIFT

Nick Desaulniers <ndesaulniers@google.com>
    x86/irqflags: Provide a declaration for native_save_fl

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix %p uses in error messages

Jiri Kosina <jkosina@suse.cz>
    x86/speculation: Protect against userspace-userspace spectreRSB

Peter Zijlstra <peterz@infradead.org>
    x86/paravirt: Fix spectre-v2 mitigations for paravirt guests

Oleksij Rempel <o.rempel@pengutronix.de>
    ARM: dts: imx6sx: fix irq for pcie bridge

Michael Mera <dev@michaelmera.com>
    IB/ocrdma: fix out of bounds access to local buffer

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Mark user MR as writable if actual virtual memory is writable

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/core: Make testing MR flags for writability a static inline function

Al Viro <viro@zeniv.linux.org.uk>
    fix __legitimize_mnt()/mntput() race

Al Viro <viro@zeniv.linux.org.uk>
    fix mntput/mntput race

Al Viro <viro@zeniv.linux.org.uk>
    root dentries need RCU-delayed freeing

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: sr: Avoid that opening a CD-ROM hangs with runtime power management enabled

Hans de Goede <hdegoede@redhat.com>
    ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices

Juergen Gross <jgross@suse.com>
    xen/netfront: don't cache skb_shinfo()

John David Anglin <dave.anglin@bell.net>
    parisc: Define mb() and add memory barriers to assembler unlock sequences

Helge Deller <deller@gmx.de>
    parisc: Enable CONFIG_MLONGCALLS by default

Kees Cook <keescook@chromium.org>
    fork: unconditionally clear stack on fork

Thomas Egerer <hakke_007@gmx.de>
    ipv4+ipv6: Make INET*_ESP select CRYPTO_ECHAINIV

Tadeusz Struk <tadeusz.struk@intel.com>
    tpm: fix race condition in tpm_common_write()

Theodore Ts'o <tytso@mit.edu>
    ext4: fix check to prevent initializing reserved inodes


-------------

Diffstat:

 Makefile                                    |  4 +-
 arch/arm/boot/dts/imx6sx.dtsi               |  2 +-
 arch/parisc/Kconfig                         |  2 +-
 arch/parisc/include/asm/barrier.h           | 32 +++++++++++
 arch/parisc/kernel/entry.S                  |  2 +
 arch/parisc/kernel/pacache.S                |  1 +
 arch/parisc/kernel/syscall.S                |  4 ++
 arch/x86/include/asm/cpufeatures.h          | 10 ++--
 arch/x86/include/asm/irqflags.h             |  2 +
 arch/x86/include/asm/page_32_types.h        |  9 +++-
 arch/x86/include/asm/pgtable-2level.h       | 17 ++++++
 arch/x86/include/asm/pgtable-3level.h       | 37 ++++++++++++-
 arch/x86/include/asm/pgtable-invert.h       | 32 +++++++++++
 arch/x86/include/asm/pgtable.h              | 84 +++++++++++++++++++++++------
 arch/x86/include/asm/pgtable_64.h           | 54 +++++++++++++++----
 arch/x86/include/asm/pgtable_types.h        | 10 ++--
 arch/x86/include/asm/processor.h            |  5 ++
 arch/x86/kernel/cpu/bugs.c                  | 81 +++++++++++++++++-----------
 arch/x86/kernel/cpu/common.c                | 20 +++++++
 arch/x86/kernel/kprobes/core.c              |  4 +-
 arch/x86/kernel/paravirt.c                  | 14 +++--
 arch/x86/kernel/setup.c                     |  6 +++
 arch/x86/mm/init.c                          | 23 ++++++++
 arch/x86/mm/kmmio.c                         | 25 +++++----
 arch/x86/mm/mmap.c                          | 21 ++++++++
 arch/x86/mm/pageattr.c                      |  8 +--
 drivers/acpi/acpi_lpss.c                    |  2 +
 drivers/base/cpu.c                          |  8 +++
 drivers/char/tpm/tpm-dev.c                  | 43 +++++++--------
 drivers/infiniband/core/umem.c              | 11 +---
 drivers/infiniband/hw/mlx4/mr.c             | 50 ++++++++++++++---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c |  2 +-
 drivers/net/xen-netfront.c                  |  8 +--
 drivers/scsi/sr.c                           | 29 +++++++---
 fs/dcache.c                                 |  6 ++-
 fs/ext4/ialloc.c                            |  5 +-
 fs/ext4/super.c                             |  8 +--
 fs/namespace.c                              | 28 +++++++++-
 include/asm-generic/pgtable.h               | 12 +++++
 include/linux/cpu.h                         |  2 +
 include/linux/mm.h                          |  2 +
 include/linux/swapfile.h                    |  2 +
 include/linux/thread_info.h                 |  6 +--
 include/rdma/ib_verbs.h                     | 14 +++++
 mm/memory.c                                 | 62 +++++++++++++++++----
 mm/mprotect.c                               | 49 +++++++++++++++++
 mm/swapfile.c                               | 46 ++++++++++------
 net/ipv4/Kconfig                            |  1 +
 net/ipv6/Kconfig                            |  1 +
 49 files changed, 714 insertions(+), 192 deletions(-)


