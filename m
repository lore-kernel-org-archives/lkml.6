Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218406-2-16561579726375408309
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218404; b=ZF08wkHFDYx2ioeR4aKyXgNKtSdIQn6xm3+4SRO5mc3HWsC
    xXCZhJNt7PeUIwCOWchiLuOZWtoprTKFeqn06Xg8vk52slkUwXAuedOlQjkHQC25
    tl/WrJCMm69aW+wEhktg2WmciAow1ANkeEaC+QegpcF/8PSTkvHF+HtBWqLbRIP7
    Oh3dFQ4h5KaTBUVWV4AxkPAIQ53kEV/MEC6TkzPl0ZcBxc2mBXj2kEX97qnYX5WI
    6lk971BOtzFSMnqWfdBI+whBNcXQKypXumgRWfX/FjLd/bVNyhSeJgqCr4ybkQWz
    e6fk9TGihlHyNqVBAmBdUdWkeUzFgsMpYHUPerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519218404; bh=DSrQMINrPZoo9ARuTXfiQBrrs/
    d55Fs+FzAkvtiVhOA=; b=h+sQiE5KOsdX7kAe2jx0I8bA2ACGe44IS85AdA2Dy2
    QLjUpRob/+KjrkO1VndbTlhz29/uvuXol2nmhnChCmlx55eh6hzNUOQ9p+Cxlmmi
    AGw1YHX9p8sh9ajvQlsYIgVJwHVI13r5EKaEW3zqB0Qw5sQNGG7zUQXsmdPjr6Ea
    jdArcGLZ8cTaUwaVqlJRztz6g9yc1RRJeWHtkB/CQViJiq+1nOVJ9Ez4j6vpm1nu
    VCUzkqmHKwS7S7ijmjDUvbyHWO4TUizTgMaf7qSgNYUGvxt2UYj/4o+nS5lsWaty
    CjaN9RVdJx2Vt4JNehEFtOSvJ3jQ1OAV5PMZ+Wx0Yx0w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936057AbeBUNGl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:06:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964996AbeBUNGi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:06:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.15 000/163] 4.15.5-stable review
Date: Wed, 21 Feb 2018 13:47:09 +0100
Message-Id: <20180221124529.931834518@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.5-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.5-rc1
X-KernelTest-Deadline: 2018-02-23T12:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.5 release.
There are 163 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Feb 23 12:44:46 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.5-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.5-rc1

yinbo.zhu <yinbo.zhu@nxp.com>
    mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb

yinbo.zhu <yinbo.zhu@nxp.com>
    mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec

Arnd Bergmann <arnd@arndb.de>
    media: r820t: fix r820t_write_reg for KASAN

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Delete bogus reference to the charlcd

Matthias Brugger <matthias.bgg@gmail.com>
    arm: dts: mt2701: Add reset-cells

Matthias Brugger <matthias.bgg@gmail.com>
    arm: dts: mt7623: Update ethsys binding

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: s5pv210: add interrupt-parent for ohci

Bjorn Andersson <bjorn.andersson@linaro.org>
    arm64: dts: msm8916: Add missing #phy-cells

Arnd Bergmann <arnd@arndb.de>
    ARM: pxa/tosa-bt: add MODULE_LICENSE tag

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: exynos: fix RTC interrupt for exynos5410

Tony Luck <tony.luck@intel.com>
    x86/mm, mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages

James Hogan <jhogan@kernel.org>
    usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT

Mikulas Patocka <mpatocka@redhat.com>
    mvpp2: fix multicast address filter

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix racy pool initializations

Daniel Mack <daniel@zonque.org>
    ALSA: usb: add more device quirks for USB DSD devices

Lassi Ylikojola <lassi.ylikojola@gmail.com>
    ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204

Jan-Marek Glogowski <glogow@fbihome.de>
    ALSA: hda/realtek: PCI quirk for Fujitsu U7x7

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add headset mode support for Dell laptop

Kirill Marinushkin <k.marinushkin@gmail.com>
    ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Fix headset mic detection problem for two Dell machines

Stefan Agner <stefan@agner.ch>
    mtd: nand: vf610: set correct ooblayout

Greg Kurz <groug@kaod.org>
    9p/trans_virtio: discard zero-length reply

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix unexpected -EEXIST when creating new inode

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix use-after-free on root->orphan_block_rsv

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix extent state leak from tree log

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix crash due to not cleaning up tree log block's dirty bits

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix deadlock in run_delalloc_nocow

NeilBrown <neilb@suse.com>
    dm: correctly handle chained bios in dec_pending()

Florian Westphal <fw@strlen.de>
    iscsi-target: make sure to wake up sleeping login worker

David Disseldorp <ddiss@suse.de>
    target/iscsi: avoid NULL dereference in CHAP auth error path

Jens Axboe <axboe@kernel.dk>
    blk-wbt: account flush requests correctly

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Fix BUG after a device removal

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Fix calculation of ri_max_send_sges

Will Deacon <will.deacon@arm.com>
    arm64: proc: Set PTE_NG for table entries to avoid traversing them twice

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: rtl8821ae: Fix connection lost problem correctly

Dan Williams <dan.j.williams@intel.com>
    mpls, nospec: Sanitize array index in mpls_label_ok()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix parsing of globs with a wildcard at the beginning

Miklos Szeredi <mszeredi@redhat.com>
    seq_file: fix incomplete reset on read from zero offset

Joao Martins <joao.m.martins@oracle.com>
    xenbus: track caller request id

Simon Gaiser <simon@invisiblethingslab.com>
    xen: Fix {set,clear}_foreign_p2m_mapping on autotranslating guests

Ilya Dryomov <idryomov@gmail.com>
    rbd: whitelist RBD_FEATURE_OPERATIONS feature bit

Nicolas Pitre <nicolas.pitre@linaro.org>
    console/dummy: leave .con_font_get set to NULL

Johan Hovold <johan@kernel.org>
    video: fbdev: atmel_lcdfb: fix display-timings lookup

Johan Hovold <johan@kernel.org>
    PCI: keystone: Fix interrupt-controller-node lookup

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Assume NoCompl+ for Thunderbolt ports

Ray Jui <ray.jui@broadcom.com>
    PCI: iproc: Fix NULL pointer dereference for BCMA

Dongdong Liu <liudongdong3@huawei.com>
    PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode

Marcin Nowakowski <marcin.nowakowski@mips.com>
    MIPS: Fix incorrect mem=X@Y handling

James Hogan <jhogan@kernel.org>
    MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout

Corentin Labbe <clabbe.montjoie@gmail.com>
    MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN

Jan H. Schönherr <jschoenh@amazon.de>
    mm: Fix memory size alignment in devm_memremap_pages_release()

Arnd Bergmann <arnd@arndb.de>
    mm: hide a #warning for COMPILE_TEST

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    ext4: correct documentation for grpid mount option

Zhouyi Zhou <zhouzhouyi@gmail.com>
    ext4: save error to disk in __ext4_grp_locked_error()

Harshad Shirwadkar <harshads@google.com>
    ext4: fix a race in the ext4 shutdown path

Tobin C. Harding <me@tobin.cc>
    jbd2: fix sphinx kernel-doc build warnings

Lukas Wunner <lukas@wunner.de>
    Revert "apple-gmux: lock iGP IO to protect from vgaarb changes"

Sagi Grimberg <sagi@grimberg.me>
    mlx5: fix mlx5_get_vector_affinity to start from completion vector 0

Jerome Brunet <jbrunet@baylibre.com>
    Revert "mmc: meson-gx: include tx phase in the tuning process"

Phil Elwell <phil@raspberrypi.org>
    mmc: bcm2835: Don't overwrite max frequency unconditionally

Linus Walleij <linus.walleij@linaro.org>
    mmc: sdhci: Implement an SDHCI-specific bounce buffer

Alexander Potapenko <glider@google.com>
    mbcache: initialize entry->e_referenced in mb_cache_entry_create()

Stewart Smith <stewart@linux.vnet.ibm.com>
    rtc-opal: Fix handling of firmware error codes, prevent busy loops

Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
    x86/smpboot: Fix uncore_pci_remove() indexing bug when hot-removing a physical CPU

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/radeon: adjust tested variable

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: Add dpm quirk for Jet PRO (v2)

Shanker Donthineni <shankerd@codeaurora.org>
    arm64: Add missing Falkor part number for branch predictor hardening

Keith Packard <keithp@keithp.com>
    drm: Check for lessee in DROP_MASTER ioctl

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/ast: Load lut in crtc_commit

Andrey Grodzovsky <andrey.grodzovsky@amd.com>
    drm/amd/powerplay: Fix smu_table_entry.handle type

Ray Strode <rstrode@redhat.com>
    drm/qxl: reapply cursor after resetting primary

Ray Strode <rstrode@redhat.com>
    drm/qxl: unref cursor bo when finished with it

Tom St Denis <tom.stdenis@amd.com>
    drm/ttm: Fix 'buf' pointer update in ttm_bo_vm_access_kmap() (v2)

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/ttm: Don't add swapped BOs to swap-LRU list

Ingo Molnar <mingo@kernel.org>
    x86/entry/64: Fix CR3 restore in paranoid_exit()

Gustavo A. R. Silva <garsilva@embeddedor.com>
    x86/cpu: Change type of x86_cache_size variable to unsigned int

Dan Carpenter <dan.carpenter@oracle.com>
    x86/spectre: Fix an error message

Jia Zhang <qianyue.zj@alibaba-inc.com>
    x86/cpu: Rename cpu_data.x86_mask to cpu_data.x86_stepping

Rui Wang <rui.y.wang@intel.com>
    selftests/x86/mpx: Fix incorrect bounds with old _sigfault

Andy Lutomirski <luto@kernel.org>
    x86/mm: Rename flush_tlb_single() and flush_tlb_one() to __flush_tlb_one_[user|kernel]()

Peter Zijlstra <peterz@infradead.org>
    x86/speculation: Add <asm/msr-index.h> dependency

Will Deacon <will.deacon@arm.com>
    nospec: Move array_index_nospec() parameter checking into separate macro

Dan Williams <dan.j.williams@intel.com>
    x86/speculation: Fix up array_index_nospec_mask() asm constraint

Peter Zijlstra <peterz@infradead.org>
    x86/debug: Use UD2 for WARN()

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/debug, objtool: Annotate WARN()-related UD2 as reachable

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Fix segfault in ignore_unreachable_insn()

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Disable tests requiring 32-bit support on pure 64-bit systems

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Do not rely on "int $0x80" in single_step_syscall.c

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fixes to "Implement iomap for block_map"

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Fix build bug caused by the 5lvl test which has been moved to the VM directory

Ingo Molnar <mingo@kernel.org>
    selftests/x86/pkeys: Remove unused functions

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Clean up and document sscanf() usage

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Fix vDSO selftest segfault for vsyscall=none

Borislav Petkov <bp@suse.de>
    x86/entry/64: Remove the unused 'icebp' macro

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/entry/64: Fix paranoid_entry() frame pointer warning

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Use PUSH_AND_CLEAN_REGS in more cases

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Interleave XOR register clearing with PUSH instructions

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Merge the POP_C_REGS and POP_EXTRA_REGS macros into a single POP_REGS macro

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Merge SAVE_C_REGS and SAVE_EXTRA_REGS, remove unused extensions

Dan Williams <dan.j.williams@intel.com>
    x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface

Andrey Ryabinin <aryabinin@virtuozzo.com>
    platform/x86: wmi: fix off-by-one write in wmi_dev_probe()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: cpuidle: Fix cpuidle_poll_state_init() prototype

Lukas Wunner <lukas@wunner.de>
    PM / runtime: Update links_count also if !CONFIG_SRCU

Ingo Molnar <mingo@kernel.org>
    x86/speculation: Clean up various Spectre related details

KarimAllah Ahmed <karahmed@amazon.de>
    KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR bitmap

KarimAllah Ahmed <karahmed@amazon.de>
    X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs

David Woodhouse <dwmw@amazon.co.uk>
    KVM/x86: Reduce retpoline performance impact in slot_handle_level_range(), by always inlining iterator helper methods

David Woodhouse <dwmw@amazon.co.uk>
    Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Correct Speculation Control microcode blacklist again

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Update Speculation Control microcode blacklist

Nadav Amit <namit@vmware.com>
    x86/mm/pti: Fix PTI comment in entry_SYSCALL_64()

Balbir Singh <bsingharora@gmail.com>
    powerpc/mm/radix: Split linear mapping on hot-unplug

Artem Savkov <artem.savkov@gmail.com>
    crypto: sun4i_ss_prng - convert lock to _bh in sun4i_ss_prng_generate

Artem Savkov <artem.savkov@gmail.com>
    crypto: sun4i_ss_prng - fix return value of sun4i_ss_prng_generate

Geert Uytterhoeven <geert@linux-m68k.org>
    compiler-gcc.h: __nostackprotector needs gcc-4.4 and up

Geert Uytterhoeven <geert@linux-m68k.org>
    compiler-gcc.h: Introduce __optimize function attribute

Dan Williams <dan.j.williams@intel.com>
    x86/entry/64/compat: Clear registers for compat syscalls, to reduce speculation attack surface

Dan Williams <dan.j.williams@intel.com>
    x86/entry/64: Clear extra registers beyond syscall arguments, to reduce speculation attack surface

Michal Hocko <mhocko@suse.com>
    mm, memory_hotplug: fix memmap initialization

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    x86: PM: Make APM idle driver initialize polling state

Juergen Gross <jgross@suse.com>
    x86/xen: init %gs very early to avoid page faults with stack protector

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/kexec: Make kexec (mostly) work in 5-level paging mode

Lucas De Marchi <lucas.demarchi@intel.com>
    x86/gpu: add CFL to early quirks

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear13xx: Fix spics gpio controller's warning

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear13xx: Fix dmas cells

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear600: Add missing interrupt-parent of rtc

Sean Wang <sean.wang@mediatek.com>
    arm: dts: mt7623: fix card detection issue on bananapi-r2

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: nomadik: add interrupt-parent for clcd

Patrice Chotard <patrice.chotard@st.com>
    ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property

Arnd Bergmann <arnd@arndb.de>
    ARM: lpc3250: fix uda1380 gpio numbers

Bjorn Andersson <bjorn.andersson@linaro.org>
    arm64: dts: msm8916: Correct ipc references for smsm

Eugene Syromiatnikov <esyr@redhat.com>
    s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Christian König <ckoenig.leichtzumerken@gmail.com>
    dma-buf: fix reservation_object_wait_timeout_rcu once more v2

Cédric Le Goater <clg@kaod.org>
    powerpc/xive: Use hw CPU ids when configuring the CPU queues

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/mm: Flush radix process translations when setting MMU type

Nathan Fontenot <nfont@linux.vnet.ibm.com>
    powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove

Nicholas Piggin <npiggin@gmail.com>
    powerpc/vas: Don't set uses_vas for kernel windows

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
    powerpc/kernel: Block interrupts when updating TIDR

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/radix: Remove trace_tlbie call from radix__flush_tlb_all

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    trace_uprobe: Display correct offset in uprobe_events

Gang He <ghe@suse.com>
    ocfs2: try a blocking lock before return AOP_TRUNCATED_PAGE

Brian Norris <briannorris@chromium.org>
    mwifiex: resolve reset vs. remove()/shutdown() deadlocks

Bjorn Andersson <bjorn.andersson@linaro.org>
    PM / devfreq: Propagate error from devfreq_add_device()

Christian König <ckoenig.leichtzumerken@gmail.com>
    swiotlb: suppress warning when __GFP_NOWARN is set

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
    cpufreq: powernv: Dont assume distinct pstate values for nominal and pmin

Bart Van Assche <bart.vanassche@wdc.com>
    RDMA/rxe: Fix rxe_qp_cleanup()

Bart Van Assche <bart.vanassche@wdc.com>
    RDMA/rxe: Fix a race condition in rxe_requester()

Bart Van Assche <bart.vanassche@wdc.com>
    RDMA/rxe: Fix a race condition related to the QP error state

Arnd Bergmann <arnd@arndb.de>
    kselftest: fix OOM in memory compaction test

Anders Roxell <anders.roxell@linaro.org>
    selftests: seccomp: fix compile error seccomp_bpf

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/core: Avoid a potential OOPs for an unused optional parameter

Bodong Wang <bodong@mellanox.com>
    IB/core: Fix ib_wc structure size to remain in 64 bytes boundary

Bart Van Assche <bart.vanassche@wdc.com>
    IB/core: Fix two kernel warnings triggered by rxe registration

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ETH ports

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/qib: Fix comparison error with qperf compare/swap test

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/umad: Fix use of unprotected device pointer

Steffen Weber <steffen.weber@gmail.com>
    scsi: smartpqi: allow static build ("built-in")


-------------

Diffstat:

 Documentation/devicetree/bindings/dma/snps-dma.txt |   2 +-
 Documentation/filesystems/ext4.txt                 |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi          |   5 -
 arch/arm/boot/dts/exynos5410.dtsi                  |   1 -
 arch/arm/boot/dts/lpc3250-ea3250.dts               |   4 +-
 arch/arm/boot/dts/lpc3250-phy3250.dts              |   4 +-
 arch/arm/boot/dts/mt2701.dtsi                      |   2 +
 arch/arm/boot/dts/mt7623.dtsi                      |   1 +
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      |   2 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |   1 +
 arch/arm/boot/dts/spear1310-evb.dts                |   2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |   4 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |   6 +-
 arch/arm/boot/dts/spear600.dtsi                    |   1 +
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |   1 +
 arch/arm/boot/dts/stih407.dtsi                     |   3 +-
 arch/arm/boot/dts/stih410.dtsi                     |   3 +-
 arch/arm/mach-pxa/tosa-bt.c                        |   4 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   5 +-
 arch/arm64/kernel/cpu_errata.c                     |   9 +
 arch/arm64/kvm/hyp/switch.c                        |   4 +-
 arch/arm64/mm/proc.S                               |  14 +-
 arch/mips/Kconfig                                  |  12 +-
 arch/mips/kernel/cps-vec.S                         |  17 +-
 arch/mips/kernel/setup.c                           |  16 +-
 arch/powerpc/include/asm/topology.h                |   5 +
 arch/powerpc/kernel/process.c                      |  15 +-
 arch/powerpc/mm/numa.c                             |   5 -
 arch/powerpc/mm/pgtable-radix.c                    |  95 ++++-
 arch/powerpc/mm/pgtable_64.c                       |   2 +
 arch/powerpc/mm/tlb-radix.c                        |   2 -
 arch/powerpc/platforms/powernv/vas-window.c        |  16 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   2 +
 arch/powerpc/sysdev/xive/spapr.c                   |  16 +-
 arch/s390/kernel/compat_linux.c                    |   8 +-
 arch/x86/entry/calling.h                           | 107 +++--
 arch/x86/entry/entry_64.S                          |  92 +----
 arch/x86/entry/entry_64_compat.S                   |  30 ++
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/lbr.c                        |   2 +-
 arch/x86/events/intel/p6.c                         |   2 +-
 arch/x86/include/asm/acpi.h                        |   2 +-
 arch/x86/include/asm/barrier.h                     |   2 +-
 arch/x86/include/asm/bug.h                         |  19 +-
 arch/x86/include/asm/nospec-branch.h               |  14 +-
 arch/x86/include/asm/page_64.h                     |   4 -
 arch/x86/include/asm/paravirt.h                    |   4 +-
 arch/x86/include/asm/paravirt_types.h              |   2 +-
 arch/x86/include/asm/pgtable_32.h                  |   2 +-
 arch/x86/include/asm/processor.h                   |   7 +-
 arch/x86/include/asm/tlbflush.h                    |  27 +-
 arch/x86/kernel/amd_nb.c                           |   2 +-
 arch/x86/kernel/apic/apic.c                        |   6 +-
 arch/x86/kernel/apm_32.c                           |   1 +
 arch/x86/kernel/asm-offsets_32.c                   |   2 +-
 arch/x86/kernel/cpu/amd.c                          |  28 +-
 arch/x86/kernel/cpu/bugs.c                         |  34 +-
 arch/x86/kernel/cpu/centaur.c                      |   4 +-
 arch/x86/kernel/cpu/common.c                       |  10 +-
 arch/x86/kernel/cpu/cyrix.c                        |   2 +-
 arch/x86/kernel/cpu/intel.c                        |  31 +-
 arch/x86/kernel/cpu/intel_rdt.c                    |   2 +-
 arch/x86/kernel/cpu/mcheck/mce-internal.h          |  15 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |  17 +-
 arch/x86/kernel/cpu/microcode/intel.c              |   6 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 |   2 +-
 arch/x86/kernel/cpu/mtrr/main.c                    |   4 +-
 arch/x86/kernel/cpu/proc.c                         |   8 +-
 arch/x86/kernel/early-quirks.c                     |   1 +
 arch/x86/kernel/head_32.S                          |   4 +-
 arch/x86/kernel/mpparse.c                          |   2 +-
 arch/x86/kernel/paravirt.c                         |   6 +-
 arch/x86/kernel/relocate_kernel_64.S               |   8 +
 arch/x86/kernel/smpboot.c                          |   1 -
 arch/x86/kernel/traps.c                            |   2 +-
 arch/x86/kvm/mmu.c                                 |  10 +-
 arch/x86/kvm/vmx.c                                 |   7 +-
 arch/x86/lib/cpu.c                                 |   2 +-
 arch/x86/mm/init_64.c                              |   2 +-
 arch/x86/mm/ioremap.c                              |   2 +-
 arch/x86/mm/kmmio.c                                |   2 +-
 arch/x86/mm/pgtable_32.c                           |   2 +-
 arch/x86/mm/tlb.c                                  |   6 +-
 arch/x86/platform/uv/tlb_uv.c                      |   2 +-
 arch/x86/xen/mmu_pv.c                              |   6 +-
 arch/x86/xen/p2m.c                                 |   6 +
 arch/x86/xen/xen-head.S                            |  16 +
 block/blk-wbt.c                                    |  10 +-
 drivers/base/core.c                                |   3 +
 drivers/block/rbd.c                                |   4 +-
 drivers/char/hw_random/via-rng.c                   |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   2 +-
 drivers/cpufreq/longhaul.c                         |   6 +-
 drivers/cpufreq/p4-clockmod.c                      |   2 +-
 drivers/cpufreq/powernow-k7.c                      |   2 +-
 drivers/cpufreq/powernv-cpufreq.c                  |   4 +-
 drivers/cpufreq/speedstep-centrino.c               |   4 +-
 drivers/cpufreq/speedstep-lib.c                    |   6 +-
 drivers/crypto/padlock-aes.c                       |   2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c            |   6 +-
 drivers/devfreq/devfreq.c                          |   2 +-
 drivers/dma-buf/reservation.c                      |   8 +-
 drivers/edac/amd64_edac.c                          |   2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h   |   2 +-
 drivers/gpu/drm/ast/ast_mode.c                     |   1 +
 drivers/gpu/drm/drm_auth.c                         |   6 +
 drivers/gpu/drm/qxl/qxl_display.c                  |  63 ++-
 drivers/gpu/drm/qxl/qxl_drv.h                      |   2 +
 drivers/gpu/drm/radeon/radeon_uvd.c                |   2 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   5 +
 drivers/gpu/drm/ttm/ttm_bo.c                       |   3 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |   3 +-
 drivers/hwmon/coretemp.c                           |   6 +-
 drivers/hwmon/hwmon-vid.c                          |   2 +-
 drivers/hwmon/k10temp.c                            |   2 +-
 drivers/hwmon/k8temp.c                             |   2 +-
 drivers/infiniband/core/device.c                   |  20 +-
 drivers/infiniband/core/sysfs.c                    |   1 -
 drivers/infiniband/core/user_mad.c                 |   2 +-
 drivers/infiniband/core/uverbs_std_types.c         |   2 +-
 drivers/infiniband/hw/mlx4/main.c                  |  13 +-
 drivers/infiniband/hw/qib/qib_rc.c                 |   6 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |   1 -
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  12 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   9 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   2 +
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   3 +
 drivers/md/dm.c                                    |   3 +-
 drivers/media/tuners/r820t.c                       |  13 +-
 drivers/mmc/host/bcm2835.c                         |   3 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  19 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   8 +
 drivers/mmc/host/sdhci.c                           | 164 +++++++-
 drivers/mmc/host/sdhci.h                           |   3 +
 drivers/mtd/nand/vf610_nfc.c                       |   6 +-
 drivers/net/ethernet/marvell/mvpp2.c               |  11 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c            |   3 +
 drivers/net/wireless/marvell/mwifiex/pcie.c        |   5 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   5 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   1 +
 drivers/pci/dwc/pci-keystone.c                     |   5 +-
 drivers/pci/host/pcie-iproc-platform.c             |   7 +
 drivers/pci/host/pcie-iproc.c                      |   8 +-
 drivers/pci/host/pcie-iproc.h                      |   2 +
 drivers/pci/hotplug/pciehp_hpc.c                   |   7 +
 drivers/pci/quirks.c                               |   2 +-
 drivers/platform/x86/apple-gmux.c                  |  48 +--
 drivers/platform/x86/wmi.c                         |   2 +-
 drivers/rtc/rtc-opal.c                             |  12 +-
 drivers/scsi/smartpqi/Makefile                     |   2 +-
 drivers/target/iscsi/iscsi_target_auth.c           |   3 +-
 drivers/target/iscsi/iscsi_target_nego.c           |   3 +
 drivers/usb/Kconfig                                |   8 +
 drivers/usb/host/Kconfig                           |   8 -
 drivers/video/console/dummycon.c                   |   1 -
 drivers/video/fbdev/atmel_lcdfb.c                  |   8 +-
 drivers/video/fbdev/geode/video_gx.c               |   2 +-
 drivers/xen/xenbus/xenbus.h                        |   1 +
 drivers/xen/xenbus/xenbus_comms.c                  |   1 +
 drivers/xen/xenbus/xenbus_xs.c                     |   3 +
 fs/btrfs/inode.c                                   |  41 +-
 fs/btrfs/tree-log.c                                |  32 +-
 fs/ext4/inode.c                                    |  16 +-
 fs/ext4/super.c                                    |   1 +
 fs/gfs2/bmap.c                                     |  43 +-
 fs/jbd2/transaction.c                              |   5 +-
 fs/mbcache.c                                       |   1 +
 fs/ocfs2/dlmglue.c                                 |   9 +
 fs/seq_file.c                                      |   5 +-
 include/drm/i915_pciids.h                          |   6 +
 include/linux/compiler-gcc.h                       |   7 +-
 include/linux/compiler.h                           |   4 +
 include/linux/cpuidle.h                            |   2 +-
 include/linux/jbd2.h                               | 431 +++++++++++++--------
 include/linux/mlx5/driver.h                        |   2 +-
 include/linux/mm_inline.h                          |   6 -
 include/linux/nospec.h                             |  36 +-
 include/rdma/ib_verbs.h                            |   2 +-
 include/trace/events/xen.h                         |   2 +-
 kernel/memremap.c                                  |   3 +-
 kernel/trace/trace_events_filter.c                 |   9 +-
 kernel/trace/trace_uprobe.c                        |   2 +-
 lib/swiotlb.c                                      |  15 +-
 mm/memory-failure.c                                |   2 -
 mm/memory.c                                        |   2 +-
 mm/page_alloc.c                                    |  22 +-
 net/9p/trans_virtio.c                              |   3 +-
 net/mpls/af_mpls.c                                 |  24 +-
 net/sunrpc/xprtrdma/rpc_rdma.c                     |   2 +-
 net/sunrpc/xprtrdma/verbs.c                        |   8 +-
 sound/core/seq/seq_clientmgr.c                     |   8 +-
 sound/pci/hda/patch_realtek.c                      |  72 ++++
 sound/usb/mixer.c                                  |  18 +-
 sound/usb/pcm.c                                    |   9 +
 sound/usb/quirks.c                                 |   7 +-
 tools/objtool/check.c                              |  12 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |   4 +-
 tools/testing/selftests/vm/compaction_test.c       |   2 +
 tools/testing/selftests/x86/Makefile               |  24 +-
 tools/testing/selftests/x86/mpx-mini-test.c        |  32 +-
 tools/testing/selftests/x86/protection_keys.c      |  28 --
 tools/testing/selftests/x86/single_step_syscall.c  |   5 +-
 tools/testing/selftests/x86/test_mremap_vdso.c     |   4 +
 tools/testing/selftests/x86/test_vdso.c            |  55 ++-
 tools/testing/selftests/x86/test_vsyscall.c        |  11 +-
 207 files changed, 1625 insertions(+), 897 deletions(-)
