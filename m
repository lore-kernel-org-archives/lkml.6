Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC9AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C4620837
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C4620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbeGPIKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:10:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGPIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:10:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C7639C03;
        Mon, 16 Jul 2018 07:44:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/43] 4.4.141-stable review
Date:   Mon, 16 Jul 2018 09:36:05 +0200
Message-Id: <20180716073511.796555857@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.141-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.141-rc1
X-KernelTest-Deadline: 2018-07-18T07:35+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.141 release.
There are 43 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jul 18 07:34:50 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.141-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.141-rc1

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    loop: remember whether sysfs_create_group() was done

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucm: Mark UCM interface as BROKEN

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    PM / hibernate: Fix oops at snapshot_write()

Theodore Ts'o <tytso@mit.edu>
    loop: add recursion validation to LOOP_CHANGE_FD

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: initialise match/target check parameter struct

Eric Dumazet <edumazet@google.com>
    netfilter: nf_queue: augment nfqa_cfg_policy

Oleg Nesterov <oleg@redhat.com>
    uprobes/x86: Remove incorrect WARN_ON() in uprobe_init_insn()

Dave Hansen <dave.hansen@linux.intel.com>
    x86/cpufeature: Add helper macro for mask check macros

Dave Hansen <dave.hansen@linux.intel.com>
    x86/cpufeature: Make sure DISABLED/REQUIRED macros are updated

Dave Hansen <dave.hansen@linux.intel.com>
    x86/cpufeature: Update cpufeaure macros

Dave Hansen <dave.hansen@linux.intel.com>
    x86/cpufeature, x86/mm/pkeys: Fix broken compile-time disabling of pkeys

Yazen Ghannam <Yazen.Ghannam@amd.com>
    x86/cpu: Add detection of AMD RAS Capabilities

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm/pkeys: Fix mismerge of protection keys CPUID bits

Dave Hansen <dave.hansen@linux.intel.com>
    x86/cpufeature, x86/mm/pkeys: Add protection keys related CPUID definitions

Borislav Petkov <bp@suse.de>
    x86/cpufeature: Speed up cpu_feature_enabled()

Alexander Kuleshov <kuleshovmail@gmail.com>
    x86/boot: Simplify kernel load address alignment check

Borislav Petkov <bp@suse.de>
    x86/vdso: Use static_cpu_has()

Brian Gerst <brgerst@gmail.com>
    x86/alternatives: Discard dynamic check after init

Borislav Petkov <bp@suse.de>
    x86/alternatives: Add an auxilary section

Borislav Petkov <bp@alien8.de>
    x86/cpufeature: Get rid of the non-asm goto variant

Borislav Petkov <bp@suse.de>
    x86/cpufeature: Replace the old static_cpu_has() with safe variant

Borislav Petkov <bp@suse.de>
    x86/cpufeature: Carve out X86_FEATURE_*

Andi Kleen <ak@linux.intel.com>
    x86/headers: Don't include asm/processor.h in asm/atomic.h

Borislav Petkov <bp@suse.de>
    x86/fpu: Get rid of xstate_fault()

Borislav Petkov <bp@suse.de>
    x86/fpu: Add an XSTATE_OP() macro

Borislav Petkov <bp@suse.de>
    x86/cpu: Provide a config option to disable static_cpu_has

Borislav Petkov <bp@suse.de>
    x86/cpufeature: Cleanup get_cpu_cap()

Borislav Petkov <bp@suse.de>
    x86/cpufeature: Move some of the scattered feature bits to x86_capability

Steve Wise <swise@opengridcomputing.com>
    iw_cxgb4: correctly enforce the max reg_mr depth

Paul Menzel <pmenzel@molgen.mpg.de>
    tools build: fix # escaping in .cmd files for future Make

Linus Torvalds <torvalds@linux-foundation.org>
    Fix up non-directory creation in SGID directories

Tomasz Kramkowski <tk@the-tk.com>
    HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter

Dan Carpenter <dan.carpenter@oracle.com>
    xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Nico Sneck <snecknico@gmail.com>
    usb: quirks: add delay quirks for Corsair Strafe

Johan Hovold <johan@kernel.org>
    USB: serial: mos7840: fix status-register error handling

Jann Horn <jannh@google.com>
    USB: yurex: fix out-of-bounds uaccess in read handler

Johan Hovold <johan@kernel.org>
    USB: serial: keyspan_pda: fix modem-status error handling

Olli Salonen <olli.salonen@iki.fi>
    USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick

Dan Carpenter <dan.carpenter@oracle.com>
    USB: serial: ch341: fix type promotion bug in ch341_control_in()

Hans de Goede <hdegoede@redhat.com>
    ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Nadav Amit <namit@vmware.com>
    vmw_balloon: fix inflation with batching

Jann Horn <jannh@google.com>
    ibmasm: don't write out of bounds in read handler

Paul Burton <paul.burton@mips.com>
    MIPS: Fix ioremap() RAM check


-------------

Diffstat:

 Documentation/kernel-parameters.txt      |   2 +-
 Makefile                                 |   4 +-
 arch/mips/mm/ioremap.c                   |  37 ++-
 arch/x86/Kconfig                         |  11 +
 arch/x86/Kconfig.debug                   |  10 -
 arch/x86/boot/cpuflags.h                 |   2 +-
 arch/x86/boot/mkcpustr.c                 |   2 +-
 arch/x86/crypto/crc32-pclmul_glue.c      |   2 +-
 arch/x86/crypto/crc32c-intel_glue.c      |   2 +-
 arch/x86/crypto/crct10dif-pclmul_glue.c  |   2 +-
 arch/x86/entry/common.c                  |   1 +
 arch/x86/entry/entry_32.S                |   2 +-
 arch/x86/entry/vdso/vdso32-setup.c       |   1 -
 arch/x86/entry/vdso/vdso32/system_call.S |   2 +-
 arch/x86/entry/vdso/vma.c                |   3 +-
 arch/x86/include/asm/alternative.h       |   6 -
 arch/x86/include/asm/apic.h              |   1 -
 arch/x86/include/asm/arch_hweight.h      |   2 +
 arch/x86/include/asm/atomic.h            |   1 -
 arch/x86/include/asm/atomic64_32.h       |   1 -
 arch/x86/include/asm/cmpxchg.h           |   1 +
 arch/x86/include/asm/cpufeature.h        | 546 ++++++-------------------------
 arch/x86/include/asm/cpufeatures.h       | 306 +++++++++++++++++
 arch/x86/include/asm/disabled-features.h |  17 +
 arch/x86/include/asm/fpu/internal.h      | 182 +++++------
 arch/x86/include/asm/irq_work.h          |   2 +-
 arch/x86/include/asm/mwait.h             |   2 +
 arch/x86/include/asm/nospec-branch.h     |   2 +-
 arch/x86/include/asm/processor.h         |   3 +-
 arch/x86/include/asm/required-features.h |   9 +
 arch/x86/include/asm/smap.h              |   2 +-
 arch/x86/include/asm/smp.h               |   1 -
 arch/x86/include/asm/thread_info.h       |   2 +-
 arch/x86/include/asm/tlbflush.h          |   1 +
 arch/x86/include/asm/uaccess_64.h        |   2 +-
 arch/x86/kernel/apic/apic_numachip.c     |   4 +-
 arch/x86/kernel/cpu/Makefile             |   2 +-
 arch/x86/kernel/cpu/centaur.c            |   4 +-
 arch/x86/kernel/cpu/common.c             |  71 ++--
 arch/x86/kernel/cpu/cyrix.c              |   1 +
 arch/x86/kernel/cpu/intel.c              |   2 +-
 arch/x86/kernel/cpu/intel_cacheinfo.c    |   2 +-
 arch/x86/kernel/cpu/match.c              |   2 +-
 arch/x86/kernel/cpu/mkcapflags.sh        |   6 +-
 arch/x86/kernel/cpu/mtrr/main.c          |   2 +-
 arch/x86/kernel/cpu/scattered.c          |  20 --
 arch/x86/kernel/cpu/transmeta.c          |   6 +-
 arch/x86/kernel/e820.c                   |   1 +
 arch/x86/kernel/head_32.S                |   2 +-
 arch/x86/kernel/head_64.S                |   4 +-
 arch/x86/kernel/hpet.c                   |   1 +
 arch/x86/kernel/msr.c                    |   2 +-
 arch/x86/kernel/uprobes.c                |   2 +-
 arch/x86/kernel/verify_cpu.S             |   2 +-
 arch/x86/kernel/vm86_32.c                |   2 +-
 arch/x86/kernel/vmlinux.lds.S            |  11 +
 arch/x86/lib/clear_page_64.S             |   2 +-
 arch/x86/lib/copy_page_64.S              |   2 +-
 arch/x86/lib/copy_user_64.S              |   2 +-
 arch/x86/lib/memcpy_64.S                 |   2 +-
 arch/x86/lib/memmove_64.S                |   2 +-
 arch/x86/lib/memset_64.S                 |   2 +-
 arch/x86/lib/retpoline.S                 |   2 +-
 arch/x86/mm/setup_nx.c                   |   1 +
 arch/x86/oprofile/op_model_amd.c         |   1 -
 arch/x86/um/asm/barrier.h                |   2 +-
 drivers/ata/ahci.c                       |  59 ++++
 drivers/ata/libata-core.c                |   3 +
 drivers/block/loop.c                     |  79 +++--
 drivers/block/loop.h                     |   1 +
 drivers/hid/hid-ids.h                    |   3 +
 drivers/hid/usbhid/hid-quirks.c          |   1 +
 drivers/infiniband/Kconfig               |  12 +
 drivers/infiniband/core/Makefile         |   4 +-
 drivers/infiniband/hw/cxgb4/mem.c        |   2 +-
 drivers/misc/ibmasm/ibmasmfs.c           |  27 +-
 drivers/misc/vmw_balloon.c               |   4 +-
 drivers/usb/core/quirks.c                |   4 +
 drivers/usb/host/xhci-mem.c              |   2 +-
 drivers/usb/misc/yurex.c                 |  23 +-
 drivers/usb/serial/ch341.c               |   2 +-
 drivers/usb/serial/cp210x.c              |   1 +
 drivers/usb/serial/keyspan_pda.c         |   4 +-
 drivers/usb/serial/mos7840.c             |   3 +
 fs/btrfs/disk-io.c                       |   2 +-
 fs/inode.c                               |   6 +
 include/linux/libata.h                   |   1 +
 kernel/power/user.c                      |   5 +
 lib/atomic64_test.c                      |   4 +
 net/bridge/netfilter/ebtables.c          |   2 +
 net/ipv4/netfilter/ip_tables.c           |   1 +
 net/ipv6/netfilter/ip6_tables.c          |   1 +
 net/netfilter/nfnetlink_queue.c          |   3 +
 tools/build/Build.include                |   4 +-
 94 files changed, 831 insertions(+), 771 deletions(-)


