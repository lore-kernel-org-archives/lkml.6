Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226WjlLzG5FUO+ZhY4NdE8GXbsq0gdbMtTfw7oyAxqgvkBjMWeUeypybaD9asvBUGoAOuyFn
ARC-Seal: i=1; a=rsa-sha256; t=1519217959; cv=none;
        d=google.com; s=arc-20160816;
        b=ASjkzE2VejDg0lyaKkWDsUidJPr3ZHGkAWK2AO4Q6MrtwfJCms6Kkgv3hah0pBIdea
         N1XMFXcFuzwcj/dgzKqi7HZS+werux9rEdmC4AeUOuRIldsEavtL/VAl/Nh/fEtDZHLT
         8MZPCpBoZzeULI63P0XxxMzbAWNq7pEW1/Zgv1Kx6ASVhhoYTYWMsqF3f03vpihrlUYZ
         Hy/xjHiULuPXeSiEenGBAlvWkbPwj6n9LvJ7i7BsxvyPMFm0pFmx8Ydrzh1ak8otNdX3
         OQ3xhxX3fHuKrCoYQhszIC8geXY+0ilH9eJV1xJAaLyqaTsdEupJWzWA6Xx8oB6XZxg+
         WwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8bFX9sQSQ99KRJkyWT9NsnxHSx/lJCkbb67Py+vSL2Y=;
        b=i/MMH5bEhJN/sIQ90TboEHupZTQWxAAk/5zjOEtmFCD0tAIpDwqQZ3LuLO6AE+U7/J
         KchRc6O9JeCWpgloWlXVpANJgjyNA5t+F3/vHkq1mGuWpuIYJCee541riArHZyAHvmgX
         2Sr1O60kbJdGvCvh/7cOxKDyhkx1vdnaD3UShR6V/IGCNEzg62Igw/PcDIyHVXjUzeVO
         63zYS9NUJ6P3sf/gIv105tAaBRwFDAl85IpQDjKenaGcWVXW+jrfFlf6qRPMQJGyOAmF
         w6hD2wnx+GZ+r2HLBQ8sxo/+x+DXkJANU5FO9FrpvLdughD6gu86QmyzudN5wikz2UFf
         9XUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.14 000/167] 4.14.21-stable review
Date: Wed, 21 Feb 2018 13:46:51 +0100
Message-Id: <20180221124524.639039577@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.21-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.21-rc1
X-KernelTest-Deadline: 2018-02-23T12:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015490826174383?=
X-GMAIL-MSGID: =?utf-8?q?1593015490826174383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.21 release.
There are 167 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Feb 23 12:44:42 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.21-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.21-rc1

Amir Goldstein <amir73il@gmail.com>
    ovl: hash directory inodes for fsnotify

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: acpi: fix machine driver selection based on quirk

yinbo.zhu <yinbo.zhu@nxp.com>
    mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb

yinbo.zhu <yinbo.zhu@nxp.com>
    mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec

yangbo lu <yangbo.lu@nxp.com>
    mmc: sdhci-of-esdhc: disable SD clock for clock value 0

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

Arnd Bergmann <arnd@arndb.de>
    Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS

Hannes Reinecke <hare@suse.de>
    scsi: core: check for device state in __scsi_remove_target()

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

Ray Strode <rstrode@redhat.com>
    drm/qxl: reapply cursor after resetting primary

Gerd Hoffmann <kraxel@redhat.com>
    qxl: alloc & use shadow for dumb buffers

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

Ray Jui <ray.jui@broadcom.com>
    PCI: iproc: Fix NULL pointer dereference for BCMA

Dongdong Liu <liudongdong3@huawei.com>
    PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode

Marcin Nowakowski <marcin.nowakowski@mips.com>
    MIPS: Fix incorrect mem=X@Y handling

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

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/radeon: adjust tested variable

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: Add dpm quirk for Jet PRO (v2)

Shanker Donthineni <shankerd@codeaurora.org>
    arm64: Add missing Falkor part number for branch predictor hardening

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/ast: Load lut in crtc_commit

Andrey Grodzovsky <andrey.grodzovsky@amd.com>
    drm/amd/powerplay: Fix smu_table_entry.handle type

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

Michal Hocko <mhocko@suse.com>
    kmemcheck: rip it out for real

Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
    kmemcheck: rip it out

Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
    kmemcheck: remove whats left of NOTRACK flags

Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
    kmemcheck: stop using GFP_NOTRACK and SLAB_NOTRACK

Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
    kmemcheck: remove annotations

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

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c

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

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    x86: PM: Make APM idle driver initialize polling state

Juergen Gross <jgross@suse.com>
    x86/xen: init %gs very early to avoid page faults with stack protector

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/kexec: Make kexec (mostly) work in 5-level paging mode

Lucas De Marchi <lucas.demarchi@intel.com>
    x86/gpu: add CFL to early quirks

Anuj Phogat <anuj.phogat@gmail.com>
    drm/i915/kbl: Change a KBL pci id to GT2 from GT1.5

Lionel Landwerlin <lionel.g.landwerlin@intel.com>
    drm/i915: add GT number to intel_device_info

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

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc: Fix DABR match on hash based systems

Cédric Le Goater <clg@kaod.org>
    powerpc/xive: Use hw CPU ids when configuring the CPU queues

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/mm: Flush radix process translations when setting MMU type

Nathan Fontenot <nfont@linux.vnet.ibm.com>
    powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/radix: Remove trace_tlbie call from radix__flush_tlb_all

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

Randy Dunlap <rdunlap@infradead.org>
    tracing: Prevent PROFILE_ALL_BRANCHES when FORTIFY_SOURCE=y


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |   7 -
 Documentation/dev-tools/index.rst                  |   1 -
 Documentation/dev-tools/kmemcheck.rst              | 733 ---------------------
 Documentation/devicetree/bindings/dma/snps-dma.txt |   2 +-
 Documentation/filesystems/ext4.txt                 |   2 +-
 MAINTAINERS                                        |  10 -
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
 arch/arm/include/asm/dma-iommu.h                   |   1 -
 arch/arm/include/asm/pgalloc.h                     |   2 +-
 arch/arm/mach-pxa/tosa-bt.c                        |   4 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   5 +-
 arch/arm64/include/asm/pgalloc.h                   |   2 +-
 arch/arm64/kernel/cpu_errata.c                     |   9 +
 arch/arm64/kvm/hyp/switch.c                        |   4 +-
 arch/arm64/mm/proc.S                               |  14 +-
 arch/mips/Kconfig                                  |  12 +-
 arch/mips/kernel/setup.c                           |  16 +-
 arch/openrisc/include/asm/dma-mapping.h            |   1 -
 arch/powerpc/include/asm/pgalloc.h                 |   2 +-
 arch/powerpc/include/asm/topology.h                |   5 +
 arch/powerpc/kernel/exceptions-64s.S               |   2 +-
 arch/powerpc/kernel/head_32.S                      |   2 +-
 arch/powerpc/mm/numa.c                             |   5 -
 arch/powerpc/mm/pgtable-radix.c                    |  95 ++-
 arch/powerpc/mm/pgtable_64.c                       |   2 +
 arch/powerpc/mm/tlb-radix.c                        |   2 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   2 +
 arch/powerpc/sysdev/xive/spapr.c                   |  16 +-
 arch/s390/kernel/compat_linux.c                    |   8 +-
 arch/sh/kernel/dwarf.c                             |   4 +-
 arch/sh/kernel/process.c                           |   2 +-
 arch/sparc/mm/init_64.c                            |   4 +-
 arch/unicore32/include/asm/pgalloc.h               |   2 +-
 arch/x86/Kconfig                                   |   3 +-
 arch/x86/Makefile                                  |   5 -
 arch/x86/entry/calling.h                           | 107 ++-
 arch/x86/entry/entry_64.S                          |  92 +--
 arch/x86/entry/entry_64_compat.S                   |  30 +
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/lbr.c                        |   2 +-
 arch/x86/events/intel/p6.c                         |   2 +-
 arch/x86/include/asm/acpi.h                        |   2 +-
 arch/x86/include/asm/barrier.h                     |   2 +-
 arch/x86/include/asm/bug.h                         |  19 +-
 arch/x86/include/asm/dma-mapping.h                 |   1 -
 arch/x86/include/asm/kmemcheck.h                   |  43 --
 arch/x86/include/asm/nospec-branch.h               |  14 +-
 arch/x86/include/asm/page_64.h                     |   4 -
 arch/x86/include/asm/paravirt.h                    |   4 +-
 arch/x86/include/asm/paravirt_types.h              |   2 +-
 arch/x86/include/asm/pgtable.h                     |   5 -
 arch/x86/include/asm/pgtable_32.h                  |   2 +-
 arch/x86/include/asm/pgtable_types.h               |  13 -
 arch/x86/include/asm/processor.h                   |   7 +-
 arch/x86/include/asm/string_32.h                   |   9 -
 arch/x86/include/asm/string_64.h                   |   8 -
 arch/x86/include/asm/tlbflush.h                    |  27 +-
 arch/x86/include/asm/xor.h                         |   5 +-
 arch/x86/kernel/acpi/apei.c                        |   2 +-
 arch/x86/kernel/amd_nb.c                           |   2 +-
 arch/x86/kernel/apic/apic.c                        |   6 +-
 arch/x86/kernel/apm_32.c                           |   1 +
 arch/x86/kernel/asm-offsets_32.c                   |   2 +-
 arch/x86/kernel/cpu/amd.c                          |  28 +-
 arch/x86/kernel/cpu/bugs.c                         |  34 +-
 arch/x86/kernel/cpu/centaur.c                      |   4 +-
 arch/x86/kernel/cpu/common.c                       |  10 +-
 arch/x86/kernel/cpu/cyrix.c                        |   2 +-
 arch/x86/kernel/cpu/intel.c                        |  46 +-
 arch/x86/kernel/cpu/intel_rdt.c                    |   2 +-
 arch/x86/kernel/cpu/mcheck/mce-internal.h          |  15 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |  17 +-
 arch/x86/kernel/cpu/microcode/intel.c              |   6 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 |   2 +-
 arch/x86/kernel/cpu/mtrr/main.c                    |   4 +-
 arch/x86/kernel/cpu/proc.c                         |   8 +-
 arch/x86/kernel/early-quirks.c                     |   1 +
 arch/x86/kernel/espfix_64.c                        |   2 +-
 arch/x86/kernel/head_32.S                          |   4 +-
 arch/x86/kernel/mpparse.c                          |   2 +-
 arch/x86/kernel/paravirt.c                         |   6 +-
 arch/x86/kernel/relocate_kernel_64.S               |   8 +
 arch/x86/kernel/traps.c                            |   7 +-
 arch/x86/kvm/mmu.c                                 |  10 +-
 arch/x86/kvm/vmx.c                                 |   7 +-
 arch/x86/lib/cpu.c                                 |   2 +-
 arch/x86/mm/Makefile                               |   2 -
 arch/x86/mm/fault.c                                |   6 -
 arch/x86/mm/init.c                                 |   8 +-
 arch/x86/mm/init_64.c                              |   4 +-
 arch/x86/mm/ioremap.c                              |   2 +-
 arch/x86/mm/kmemcheck/Makefile                     |   1 -
 arch/x86/mm/kmemcheck/error.c                      | 228 -------
 arch/x86/mm/kmemcheck/error.h                      |  16 -
 arch/x86/mm/kmemcheck/kmemcheck.c                  | 658 ------------------
 arch/x86/mm/kmemcheck/opcode.c                     | 107 ---
 arch/x86/mm/kmemcheck/opcode.h                     |  10 -
 arch/x86/mm/kmemcheck/pte.c                        |  23 -
 arch/x86/mm/kmemcheck/pte.h                        |  11 -
 arch/x86/mm/kmemcheck/selftest.c                   |  71 --
 arch/x86/mm/kmemcheck/selftest.h                   |   7 -
 arch/x86/mm/kmemcheck/shadow.c                     | 173 -----
 arch/x86/mm/kmemcheck/shadow.h                     |  19 -
 arch/x86/mm/kmmio.c                                |   2 +-
 arch/x86/mm/pageattr.c                             |  10 +-
 arch/x86/mm/pgtable.c                              |   2 +-
 arch/x86/mm/pgtable_32.c                           |   2 +-
 arch/x86/mm/tlb.c                                  |   6 +-
 arch/x86/platform/efi/efi_64.c                     |   2 +-
 arch/x86/platform/uv/tlb_uv.c                      |   2 +-
 arch/x86/xen/mmu_pv.c                              |   6 +-
 arch/x86/xen/p2m.c                                 |   6 +
 arch/x86/xen/xen-head.S                            |  16 +
 block/blk-wbt.c                                    |  10 +-
 crypto/xor.c                                       |   7 +-
 drivers/base/core.c                                |   3 +
 drivers/block/rbd.c                                |   4 +-
 drivers/bluetooth/Kconfig                          |   2 +-
 drivers/char/hw_random/via-rng.c                   |   2 +-
 drivers/char/random.c                              |   1 -
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
 drivers/gpu/drm/i915/i915_drv.h                    |   1 +
 drivers/gpu/drm/i915/i915_pci.c                    | 193 ++++--
 drivers/gpu/drm/qxl/qxl_cmd.c                      |   6 +-
 drivers/gpu/drm/qxl/qxl_display.c                  | 112 +++-
 drivers/gpu/drm/qxl/qxl_drv.h                      |   4 +
 drivers/gpu/drm/qxl/qxl_dumb.c                     |   1 +
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
 drivers/misc/c2port/core.c                         |   2 -
 drivers/mmc/host/bcm2835.c                         |   3 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  19 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  64 +-
 drivers/mmc/host/sdhci.c                           | 164 ++++-
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
 drivers/pci/quirks.c                               |   2 +-
 drivers/platform/x86/apple-gmux.c                  |  48 +-
 drivers/rtc/rtc-opal.c                             |  12 +-
 drivers/scsi/scsi_sysfs.c                          |   5 +-
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
 fs/dcache.c                                        |   2 -
 fs/ext4/inode.c                                    |  16 +-
 fs/ext4/super.c                                    |   1 +
 fs/jbd2/transaction.c                              |   5 +-
 fs/mbcache.c                                       |   1 +
 fs/ocfs2/dlmglue.c                                 |   9 +
 fs/overlayfs/inode.c                               |  37 +-
 fs/overlayfs/super.c                               |   1 +
 fs/overlayfs/util.c                                |   4 +-
 fs/seq_file.c                                      |   5 +-
 include/drm/i915_pciids.h                          | 160 +++--
 include/linux/c2port.h                             |   4 -
 include/linux/compiler-gcc.h                       |   7 +-
 include/linux/compiler.h                           |   4 +
 include/linux/cpuidle.h                            |   2 +-
 include/linux/dma-mapping.h                        |   8 +-
 include/linux/filter.h                             |   2 -
 include/linux/gfp.h                                |   9 -
 include/linux/interrupt.h                          |  15 -
 include/linux/jbd2.h                               | 431 +++++++-----
 include/linux/kmemcheck.h                          | 172 -----
 include/linux/mlx5/driver.h                        |   2 +-
 include/linux/mm_inline.h                          |   6 -
 include/linux/mm_types.h                           |   8 -
 include/linux/net.h                                |   3 -
 include/linux/nospec.h                             |  36 +-
 include/linux/ring_buffer.h                        |   3 -
 include/linux/skbuff.h                             |   3 -
 include/linux/slab.h                               |   6 -
 include/linux/thread_info.h                        |   5 +-
 include/net/inet_sock.h                            |   3 -
 include/net/inet_timewait_sock.h                   |   4 -
 include/net/sock.h                                 |   3 -
 include/rdma/ib_verbs.h                            |   2 +-
 include/trace/events/mmflags.h                     |   1 -
 include/trace/events/xen.h                         |   2 +-
 init/do_mounts.c                                   |   3 +-
 init/main.c                                        |   1 -
 kernel/bpf/core.c                                  |   6 -
 kernel/fork.c                                      |  12 +-
 kernel/locking/lockdep.c                           |   3 -
 kernel/memremap.c                                  |   3 +-
 kernel/signal.c                                    |   3 +-
 kernel/softirq.c                                   |  10 -
 kernel/sysctl.c                                    |  10 -
 kernel/trace/Kconfig                               |   2 +-
 kernel/trace/ring_buffer.c                         |   3 -
 kernel/trace/trace_events_filter.c                 |   9 +-
 lib/Kconfig.debug                                  |   6 +-
 lib/Kconfig.kmemcheck                              |  94 ---
 lib/swiotlb.c                                      |  15 +-
 mm/Kconfig.debug                                   |   1 -
 mm/Makefile                                        |   2 -
 mm/kmemcheck.c                                     | 126 ----
 mm/kmemleak.c                                      |   9 -
 mm/memory-failure.c                                |   2 -
 mm/memory.c                                        |   2 +-
 mm/page_alloc.c                                    |  14 -
 mm/slab.c                                          |  16 +-
 mm/slab.h                                          |   7 +-
 mm/slab_common.c                                   |   2 +-
 mm/slub.c                                          |  31 +-
 net/9p/trans_virtio.c                              |   3 +-
 net/core/skbuff.c                                  |   5 -
 net/core/sock.c                                    |   2 -
 net/ipv4/inet_timewait_sock.c                      |   3 -
 net/ipv4/tcp_input.c                               |   1 -
 net/mpls/af_mpls.c                                 |  24 +-
 net/socket.c                                       |   1 -
 net/sunrpc/xprtrdma/rpc_rdma.c                     |   2 +-
 net/sunrpc/xprtrdma/verbs.c                        |   8 +-
 scripts/kernel-doc                                 |   2 -
 sound/core/seq/seq_clientmgr.c                     |   8 +-
 sound/pci/hda/patch_realtek.c                      |  72 ++
 sound/soc/intel/common/sst-match-acpi.c            |   8 +-
 sound/usb/mixer.c                                  |  18 +-
 sound/usb/pcm.c                                    |   9 +
 sound/usb/quirks.c                                 |   7 +-
 tools/include/linux/kmemcheck.h                    |   9 -
 tools/objtool/check.c                              |  12 +-
 tools/perf/builtin-kmem.c                          |   1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c      |   4 +-
 tools/testing/selftests/vm/compaction_test.c       |   2 +
 tools/testing/selftests/x86/Makefile               |  22 +-
 tools/testing/selftests/x86/mpx-mini-test.c        |  32 +-
 tools/testing/selftests/x86/protection_keys.c      |  28 -
 tools/testing/selftests/x86/single_step_syscall.c  |   5 +-
 tools/testing/selftests/x86/test_mremap_vdso.c     |   4 +
 tools/testing/selftests/x86/test_vdso.c            |  55 +-
 tools/testing/selftests/x86/test_vsyscall.c        |  11 +-
 300 files changed, 1959 insertions(+), 3842 deletions(-)
