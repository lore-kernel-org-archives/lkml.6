Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C94ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08238204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08238204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbeGWNor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:44:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388283AbeGWNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:44:46 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AAADD40B;
        Mon, 23 Jul 2018 12:43:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/107] 4.4.144-stable review
Date:   Mon, 23 Jul 2018 14:40:54 +0200
Message-Id: <20180723122413.003644357@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.144-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.144-rc1
X-KernelTest-Deadline: 2018-07-25T12:24+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.144 release.
There are 107 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jul 25 12:23:53 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.144-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.144-rc1

Sascha Hauer <s.hauer@pengutronix.de>
    ubi: fastmap: Erase outdated anchor PEBs during attach

Richard Weinberger <richard@nod.at>
    ubi: Fix Fastmap's update_vol()

Richard Weinberger <richard@nod.at>
    ubi: Fix races around ubi_refill_pools()

Richard Weinberger <richard@nod.at>
    ubi: Be more paranoid while seaching for the most recent Fastmap

Richard Weinberger <richard@nod.at>
    ubi: Rework Fastmap attach base code

Richard Weinberger <richard@nod.at>
    ubi: Introduce vol_ignored()

Lucas Stach <dev@lynxeye.de>
    clk: tegra: Fix PLL_U post divider and initial rate on Tegra30

Alan Jenkins <alan.christopher.jenkins@gmail.com>
    block: do not use interruptible wait anywhere

Andy Lutomirski <luto@kernel.org>
    x86/cpu: Re-apply forced caps every time CPU caps are re-read

Juergen Gross <jgross@suse.com>
    x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Rename SSBD_NO to SSB_NO

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs: Rework spec_ctrl base and mask logic

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs: Remove x86_spec_ctrl_set()

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs: Expose x86_spec_ctrl_base directly

Borislav Petkov <bp@suse.de>
    x86/bugs: Unify x86_spec_ctrl_{set_guest, restore_host}

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Rework speculative_store_bypass_update()

Tom Lendacky <thomas.lendacky@amd.com>
    x86/speculation: Add virtualized speculative store bypass disable support

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Handle HT correctly on AMD

Thomas Gleixner <tglx@linutronix.de>
    x86/cpufeatures: Add FEATURE_ZEN

Borislav Petkov <bp@suse.de>
    x86/cpu/AMD: Fix erratum 1076 (CPB bit)

Thomas Gleixner <tglx@linutronix.de>
    x86/cpufeatures: Disentangle SSBD enumeration

Thomas Gleixner <tglx@linutronix.de>
    x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS

Borislav Petkov <bp@suse.de>
    x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP

Jim Mattson <jmattson@google.com>
    x86/cpu: Make alternative_msr_write work for 32-bit code

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Fix the parameters alignment and missing void

Jiri Kosina <jkosina@suse.cz>
    x86/bugs: Make cpu_show_common() static

Jiri Kosina <jkosina@suse.cz>
    x86/bugs: Fix __ssb_select_mitigation() return type

Borislav Petkov <bp@suse.de>
    Documentation/spec_ctrl: Do some minor cleanups

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    proc: Use underscores for SSBD in 'status'

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Rename _RDS to _SSBD

Kees Cook <keescook@chromium.org>
    x86/speculation: Make "seccomp" the default mode for Speculative Store Bypass

Thomas Gleixner <tglx@linutronix.de>
    seccomp: Move speculation migitation control to arch code

Kees Cook <keescook@chromium.org>
    seccomp: Add filter flag to opt-out of SSB mitigation

Thomas Gleixner <tglx@linutronix.de>
    seccomp: Use PR_SPEC_FORCE_DISABLE

Thomas Gleixner <tglx@linutronix.de>
    prctl: Add force disable speculation

Kees Cook <keescook@chromium.org>
    seccomp: Enable speculation flaw mitigations

Kees Cook <keescook@chromium.org>
    proc: Provide details on speculation flaw mitigations

Kees Cook <keescook@chromium.org>
    nospec: Allow getting/setting on non-current task

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Add prctl for Speculative Store Bypass mitigation

Thomas Gleixner <tglx@linutronix.de>
    x86/process: Allow runtime control of Speculative Store Bypass

Thomas Gleixner <tglx@linutronix.de>
    x86/process: Optimize TIF_NOTSC switch

Kyle Huey <me@kylehuey.com>
    x86/process: Correct and optimize TIF_BLOCKSTEP switch

Kyle Huey <me@kylehuey.com>
    x86/process: Optimize TIF checks in __switch_to_xtra()

Thomas Gleixner <tglx@linutronix.de>
    prctl: Add speculation control prctls

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Create spec-ctrl.h to avoid include hell

David Woodhouse <dwmw@amazon.co.uk>
    x86/bugs/AMD: Add support to disable RDS on Fam[15, 16, 17]h if requested

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Whitelist allowed SPEC_CTRL MSR values

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs/intel: Set proper CPU features and setup RDS

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/cpufeatures: Add X86_FEATURE_RDS

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Expose /sys/../spec_store_bypass

Piotr Luc <piotr.luc@intel.com>
    x86/cpu/intel: Add Knights Mill to Intel family

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    x86/cpu: Rename Merrifield2 to Moorefield

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs, KVM: Support the combination of guest and host IBRS

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Concentrate bug reporting into a separate function

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Concentrate bug detection into a separate function

Linus Torvalds <torvalds@linux-foundation.org>
    x86/nospec: Simplify alternative_msr_write()

David Woodhouse <dwmw@amazon.co.uk>
    x86/amd: don't set X86_BUG_SYSRET_SS_ATTRS when running under Xen

Juergen Gross <jgross@suse.com>
    xen: set cpu capabilities from xen_start_kernel()

Mickaël Salaün <mic@digikod.net>
    selftest/seccomp: Fix the seccomp(2) signature

Mickaël Salaün <mic@digikod.net>
    selftest/seccomp: Fix the flag name SECCOMP_FILTER_FLAG_TSYNC

Alexander Sergeyev <sergeev917@gmail.com>
    x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist

Ingo Molnar <mingo@kernel.org>
    x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Use IBRS if available before calling into firmware

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/spectre_v2: Don't check microcode versions when running under hypervisors

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Use Indirect Branch Prediction Barrier in context switch

Andy Lutomirski <luto@kernel.org>
    x86/mm: Give each mm TLB flush generation a unique ID

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Factor out LDT init from context init

Juergen Gross <jgross@suse.com>
    x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Peter Zijlstra <peterz@infradead.org>
    x86/speculation: Add <asm/msr-index.h> dependency

Dan Williams <dan.j.williams@intel.com>
    x86/speculation: Fix up array_index_nospec_mask() asm constraint

Ingo Molnar <mingo@kernel.org>
    x86/speculation: Clean up various Spectre related details

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Correct Speculation Control microcode blacklist again

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Update Speculation Control microcode blacklist

Dan Williams <dan.j.williams@intel.com>
    x86/entry/64/compat: Clear registers for compat syscalls, to reduce speculation attack surface

Denys Vlasenko <dvlasenk@redhat.com>
    x86/asm/entry/32: Simplify pushes of zeroed pt_regs->REGs

Arnd Bergmann <arnd@arndb.de>
    x86/pti: Mark constant arrays as __initconst

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeatures: Clean up Spectre v2 related CPUID flags

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 microcodes

David Woodhouse <dwmw@amazon.co.uk>
    x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown

David Woodhouse <dwmw@amazon.co.uk>
    x86/msr: Add definitions for new speculation control MSRs

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeatures: Add AMD feature bits for Speculation Control

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeatures: Add Intel feature bits for Speculation Control

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeatures: Add CPUID_7_EDX CPUID leaf

Nick Desaulniers <ndesaulniers@google.com>
    x86/paravirt: Make native_save_fl() extern inline

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix perceived dead host due to runtime suspend race with event handler

Stefano Brivio <sbrivio@redhat.com>
    skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Stefano Brivio <sbrivio@redhat.com>
    net: Don't copy pfmemalloc flag in __copy_skb_header()

Sanjeev Bansal <sanjeevb.bansal@broadcom.com>
    tg3: Add higher cpu clock for 5762.

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ptp: fix missing break in switch

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: fix flag masking in __set_phy_supported

David Ahern <dsahern@gmail.com>
    net/ipv4: Set oif in fib_compute_spec_dst

Davidlohr Bueso <dave@stgolabs.net>
    lib/rhashtable: consider param->min_size when setting initial table size

Colin Ian King <colin.king@canonical.com>
    ipv6: fix useless rol32 call on hash

Tyler Hicks <tyhicks@canonical.com>
    ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user ns

Jing Xia <jing.xia.mail@gmail.com>
    mm: memcg: fix use after free in mem_cgroup_iter()

Vineet Gupta <vgupta@synopsys.com>
    ARC: mm: allow mprotect to make stack mappings executable

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: Fix CONFIG_SWAP

Takashi Iwai <tiwai@suse.de>
    ALSA: rawmidi: Change resized buffers atomically

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    fat: fix memory allocation failure handling of match_strdup()

Dewet Thibaut <thibaut.dewet@nokia.com>
    x86/MCE: Remove min interval polling limitation

Lan Tianyu <tianyu.lan@intel.com>
    KVM/Eventfd: Avoid crash when assign and deassign specific eventfd in parallel.


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/kernel-parameters.txt                |  45 +++
 Documentation/spec_ctrl.txt                        |  94 +++++
 Makefile                                           |   4 +-
 arch/arc/include/asm/page.h                        |   2 +-
 arch/arc/include/asm/pgtable.h                     |   2 +-
 arch/x86/entry/entry_64_compat.S                   |  75 ++--
 arch/x86/include/asm/apm.h                         |   6 +
 arch/x86/include/asm/barrier.h                     |   2 +-
 arch/x86/include/asm/cpufeature.h                  |   7 +-
 arch/x86/include/asm/cpufeatures.h                 |  37 +-
 arch/x86/include/asm/disabled-features.h           |   3 +-
 arch/x86/include/asm/efi.h                         |   7 +
 arch/x86/include/asm/intel-family.h                |  10 +-
 arch/x86/include/asm/irqflags.h                    |   2 +-
 arch/x86/include/asm/mmu.h                         |  15 +-
 arch/x86/include/asm/mmu_context.h                 |  25 +-
 arch/x86/include/asm/msr-index.h                   |  22 ++
 arch/x86/include/asm/nospec-branch.h               |  54 +++
 arch/x86/include/asm/required-features.h           |   3 +-
 arch/x86/include/asm/spec-ctrl.h                   |  80 ++++
 arch/x86/include/asm/thread_info.h                 |   6 +-
 arch/x86/include/asm/tlbflush.h                    |  12 +
 arch/x86/kernel/Makefile                           |   1 +
 arch/x86/kernel/cpu/amd.c                          |  38 +-
 arch/x86/kernel/cpu/bugs.c                         | 427 +++++++++++++++++++--
 arch/x86/kernel/cpu/common.c                       | 121 +++++-
 arch/x86/kernel/cpu/cpu.h                          |   3 +
 arch/x86/kernel/cpu/intel.c                        |  73 ++++
 arch/x86/kernel/cpu/mcheck/mce.c                   |   3 -
 arch/x86/kernel/irqflags.S                         |  26 ++
 arch/x86/kernel/ldt.c                              |   4 +-
 arch/x86/kernel/process.c                          | 224 +++++++++--
 arch/x86/kernel/smpboot.c                          |   5 +
 arch/x86/kvm/svm.c                                 |   2 +-
 arch/x86/kvm/vmx.c                                 |   2 +-
 arch/x86/mm/tlb.c                                  |  33 ++
 arch/x86/platform/efi/efi_64.c                     |   3 +
 arch/x86/xen/enlighten.c                           |  16 +-
 arch/x86/xen/smp.c                                 |   5 +
 arch/x86/xen/suspend.c                             |  16 +
 block/blk-core.c                                   |  10 +-
 drivers/base/cpu.c                                 |   8 +
 drivers/clk/tegra/clk-tegra30.c                    |  11 +-
 drivers/mtd/ubi/attach.c                           | 139 +++++--
 drivers/mtd/ubi/eba.c                              |   4 +-
 drivers/mtd/ubi/fastmap-wl.c                       |   6 +-
 drivers/mtd/ubi/fastmap.c                          |  51 ++-
 drivers/mtd/ubi/ubi.h                              |  46 ++-
 drivers/mtd/ubi/wl.c                               | 114 ++++--
 drivers/net/ethernet/broadcom/tg3.c                |   9 +
 drivers/net/phy/phy_device.c                       |   7 +-
 drivers/ptp/ptp_chardev.c                          |   1 +
 drivers/usb/host/xhci.c                            |  40 +-
 drivers/usb/host/xhci.h                            |   4 +
 fs/fat/inode.c                                     |  20 +-
 fs/proc/array.c                                    |  26 ++
 include/linux/cpu.h                                |   2 +
 include/linux/nospec.h                             |  10 +
 include/linux/sched.h                              |   9 +
 include/linux/seccomp.h                            |   3 +-
 include/linux/skbuff.h                             |  12 +-
 include/net/ipv6.h                                 |   2 +-
 include/uapi/linux/prctl.h                         |  12 +
 include/uapi/linux/seccomp.h                       |   4 +-
 kernel/seccomp.c                                   |  21 +-
 kernel/sys.c                                       |  21 +
 lib/rhashtable.c                                   |  17 +-
 mm/memcontrol.c                                    |   2 +-
 net/core/skbuff.c                                  |   1 +
 net/ipv4/fib_frontend.c                            |   1 +
 net/ipv4/sysctl_net_ipv4.c                         |   5 +-
 sound/core/rawmidi.c                               |  20 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  98 ++++-
 virt/kvm/eventfd.c                                 |   6 +-
 75 files changed, 1982 insertions(+), 276 deletions(-)


