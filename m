Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ulCEiKrPHYJfZ2jrnuLUjDUrzYedLbqnbchw2ZV2RXjybctJY2O1NoG2NASsR7XWy4q+u
ARC-Seal: i=1; a=rsa-sha256; t=1518708609; cv=none;
        d=google.com; s=arc-20160816;
        b=J3QYcAl/KyN9ybnnzgewW7XBAoVkQG/jzVIqU8n6tIHDxcjdIxDeB/8QMk9lvpT80C
         qtmbAqfK9vIMxCjDT/LKr3dl3C1S84GovXu5KWdhefwwaNY24xpGic6cY+B0s4/a18NU
         tgq41w3T1JdcLpkeec2Qr2yNUMJ8/FqbC9J9k7rmnf8CPAWpYD1LBxdqO6wW8sdcdZ1W
         ir4Qr4bX4YILrUVRJbXhNq9Jc7uJQGkXp6+k3cN16JNNXr4BHX/+9D2fLEh55JqfZm/a
         un5uXCcrk2oKRyeJbVP2OCsfbYvX+zXy8DLeF+6A5dwKYEtsDYnjB3eRvqqA65FLxPvH
         Z9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=afokk1k99bXHMn7DiJPSyuOL9s1DI2oe0T8kEM+IlYc=;
        b=k3dFbJvCPYkEKwAPsk1Qm9xit8NWVP2nRTkgrShAk6yN9uT/7oAPPVf5jiWogKcjCq
         SGPlg0LvA+dbsB4FM0bX2mogxrYL+gqUnF/gxczVAjEHzjjayQbSXNw50K8ip67bUEqq
         VqyRKeElfSmi4EwO9hrdy6f+eBEkTDfDbDegKSFEprurpUGZ0ZGOPk1J+JS9pSig3uDV
         8Mgyzd4hzr/utg7ANpTSQsiM5chmle2r6fdArpg/Xp3NJkHdK/WqO5uiaZaRodXKIhJ8
         scgzLzgnKKM0bo4Et0A08RlOuJbm5YbaHLv31ctWxTLfgpA92Kb6/melWZTDWkV3ChvG
         450A==
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
Subject: [PATCH 4.14 000/195] 4.14.20-stable review
Date: Thu, 15 Feb 2018 16:14:51 +0100
Message-Id: <20180215151705.738773577@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.20-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.20-rc1
X-KernelTest-Deadline: 2018-02-17T15:17+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481398700822795?=
X-GMAIL-MSGID: =?utf-8?q?1592481398700822795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.20 release.
There are 195 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb 17 15:16:22 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.20-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.20-rc1

Uma Krishnan <ukrishn@linux.vnet.ibm.com>
    scsi: cxlflash: Reset command ioasc

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix crash after bad bar setup on driver attachment

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: core: Ensure that the SCSI error handler gets woken up

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ftrace: Remove incorrect setting of glob search field

Eric Biggers <ebiggers@google.com>
    devpts: fix error handling in devpts_mntget()

Eric W. Biederman <ebiederm@xmission.com>
    mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy

Amir Goldstein <amir73il@gmail.com>
    ovl: take mnt_want_write() for removing impure xattr

Amir Goldstein <amir73il@gmail.com>
    ovl: fix failure to fsync lower dir

Toshi Kani <toshi.kani@hpe.com>
    acpi, nfit: fix register dimm error handling

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    ACPI: sbshc: remove raw pointer from printk() message

Imre Deak <imre.deak@intel.com>
    drm/i915: Avoid PPS HW/SW state mismatch due to rounding

Yan Markman <ymarkman@marvell.com>
    arm64: dts: marvell: add Ethernet aliases

Peter Zijlstra <peterz@infradead.org>
    objtool: Fix switch-table detection

Nikolay Borisov <nborisov@suse.com>
    btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker

Andrey Ryabinin <aryabinin@virtuozzo.com>
    lib/ubsan: add type mismatch handler for new GCC/Clang

Andrew Morton <akpm@linux-foundation.org>
    lib/ubsan.c: s/missaligned/misaligned/

Daniel Lezcano <daniel.lezcano@linaro.org>
    clocksource/drivers/stm32: Fix kernel panic with multiple timers

Ming Lei <ming.lei@redhat.com>
    blk-mq: quiesce queue before freeing queue

Bart Van Assche <bart.vanassche@wdc.com>
    pktcdvd: Fix a recently introduced NULL pointer dereference

Bart Van Assche <bart.vanassche@wdc.com>
    pktcdvd: Fix pkt_setup_dev() error path

Peter Rosin <peda@axentia.se>
    pinctrl: sx150x: Add a static gpio/pinctrl pin range mapping

Peter Rosin <peda@axentia.se>
    pinctrl: sx150x: Register pinctrl before adding the gpiochip

Peter Rosin <peda@axentia.se>
    pinctrl: sx150x: Unregister the pinctrl on release

Dmitry Mastykin <mastichi@gmail.com>
    pinctrl: mcp23s08: fix irq setup order

Mika Westerberg <mika.westerberg@linux.intel.com>
    pinctrl: intel: Initialize GPIO properly when used through irqchip

James Hogan <jhogan@kernel.org>
    EDAC, octeon: Fix an uninitialized variable warning

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix futex_atomic_cmpxchg_inatomic

Mikulas Patocka <mpatocka@redhat.com>
    alpha: fix formating of stack content

Mikulas Patocka <mpatocka@redhat.com>
    alpha: fix reboot on Avanti platform

Michael Cree <mcree@orcon.net.nz>
    alpha: Fix mixed up args in EXC macro in futex operations

Arnd Bergmann <arnd@arndb.de>
    alpha: osf_sys.c: fix put_tv32 regression

Mikulas Patocka <mpatocka@redhat.com>
    alpha: fix crash if pthread_create races with signal delivery

Eric W. Biederman <ebiederm@xmission.com>
    signal/sh: Ensure si_signo is initialized in do_divide_error

Eric W. Biederman <ebiederm@xmission.com>
    signal/openrisc: Fix do_unaligned_access to send the proper signal

John Garry <john.garry@huawei.com>
    ipmi: use dynamic memory for DMI driver override

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritten" version

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btsdio: Do not bind to non-removable BCM43341

Hans de Goede <hdegoede@redhat.com>
    HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working

Eric Biggers <ebiggers@google.com>
    pipe: fix off-by-one error when checking buffer limits

Eric Biggers <ebiggers@google.com>
    pipe: actually allow root to exceed the pipe buffer limits

Eric Biggers <ebiggers@google.com>
    kernel/relay.c: revert "kernel/relay.c: fix potential memory leak"

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    kernel/async.c: revert "async: simplify lowest_in_progress()"

Heiko Carstens <heiko.carstens@de.ibm.com>
    fs/proc/kcore.c: use probe_kernel_read() instead of memcpy()

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: ts2020: avoid integer overflows on 32 bit machines

Arnd Bergmann <arnd@arndb.de>
    media: dvb-frontends: fix i2c access helpers for KASAN

Arnd Bergmann <arnd@arndb.de>
    kasan: rework Kconfig settings

Andrey Konovalov <andreyknvl@google.com>
    kasan: don't emit builtin calls when sanitization is off

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: raid56: iterate raid56 internal bio with bio_for_each_segment_all

Martin Kaiser <martin@kaiser.cx>
    watchdog: imx2_wdt: restore previous timeout after suspend+resume

Takashi Iwai <tiwai@suse.de>
    ASoC: skl: Fix kernel warning due to zero NHTL entry

John Keeping <john@metanate.com>
    ASoC: rockchip: i2s: fix playback after runtime resume

Ulf Magnusson <ulfalizer@gmail.com>
    KVM: PPC: Book3S PR: Fix broken select due to misspelling

James Morse <james.morse@arm.com>
    KVM: arm/arm64: Handle CPU_PM_ENTER_FAILED

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Drop locks before reading guest memory

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Make sure we don't re-enter guest without XIVE loaded

Liran Alon <liran.alon@oracle.com>
    KVM: nVMX: Fix bug of injecting L2 exception into L1

Liran Alon <liran.alon@oracle.com>
    KVM: nVMX: Fix races when sending nested PI while dest enters/leaves L2

Marc Zyngier <marc.zyngier@arm.com>
    arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls

LEROY Christophe <christophe.leroy@c-s.fr>
    crypto: talitos - fix Kernel Oops on hashing an empty file

Eric Biggers <ebiggers@google.com>
    crypto: sha512-mb - initialize pending lengths correctly

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix endless loop when DECO acquire fails

Hans Verkuil <hansverk@cisco.com>
    media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs

Daniel Mentz <danielmentz@google.com>
    media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: don't copy back the result for certain errors

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: avoid sizeof(type)

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: move 'helper' functions to __get/put_v4l2_format32

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: fix the indentation

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-ioctl.c: don't copy back the result for -ENOTTY

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-ioctl.c: use check_fmt for enum/g/s/try_fmt

Eric Biggers <ebiggers@google.com>
    crypto: hash - prevent using keyed hashes without setting key

Eric Biggers <ebiggers@google.com>
    crypto: hash - annotate algorithms taking optional key

Eric Biggers <ebiggers@google.com>
    crypto: poly1305 - remove ->setkey() method

Eric Biggers <ebiggers@google.com>
    crypto: mcryptd - pass through absence of ->setkey()

Eric Biggers <ebiggers@google.com>
    crypto: cryptd - pass through absence of ->setkey()

Eric Biggers <ebiggers@google.com>
    crypto: hash - introduce crypto_hash_alg_has_setkey()

Mika Westerberg <mika.westerberg@linux.intel.com>
    ahci: Add Intel Cannon Lake PCH-H PCI ID

Hans de Goede <hdegoede@redhat.com>
    ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI

Hans de Goede <hdegoede@redhat.com>
    ahci: Annotate PCI ids for mobile Intel chipsets as such

Ivan Vecera <ivecera@redhat.com>
    kernfs: fix regression in kernfs_fop_write caused by wrong type

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix a race between mmap() and O_DIRECT

Eric Biggers <ebiggers@google.com>
    NFS: reject request for id_legacy key without auxdata

J. Bruce Fields <bfields@redhat.com>
    NFS: commit direct writes even if they fail partially

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix nfsstat breakage due to LOOKUPP

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Add a cond_resched() to nfs_commit_release_pages()

Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
    nfs41: do not return ENOMEM on LAYOUTUNAVAILABLE

Scott Mayhew <smayhew@redhat.com>
    nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds

Eric Biggers <ebiggers@google.com>
    ubifs: free the encrypted symlink target

Bradley Bolen <bradleybolen@gmail.com>
    ubi: block: Fix locking for idr_alloc/idr_remove

Sascha Hauer <s.hauer@pengutronix.de>
    ubi: fastmap: Erase outdated anchor PEBs during attach

Clay McClure <clay@daemons.net>
    ubi: Fix race condition between ubi volume creation and udev

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: sunxi: Fix ECC strength choice

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: Fix nand_do_read_oob() return value

Kamal Dasu <kdasu.kdev@gmail.com>
    mtd: nand: brcmnand: Disable prefetch by default

Arnd Bergmann <arnd@arndb.de>
    mtd: cfi: convert inline functions to macros

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Kill PSCI_GET_VERSION as a variant-2 workaround

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc: Implement SMCCC v1.1 inline primitive

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc: Make function identifiers an unsigned quantity

Marc Zyngier <marc.zyngier@arm.com>
    firmware/psci: Expose SMCCC version through psci_ops

Marc Zyngier <marc.zyngier@arm.com>
    firmware/psci: Expose PSCI conduit

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Turn kvm_psci_version into a static inline

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Make PSCI_VERSION a fast path

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Advertise SMCCC v1.1

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Implement PSCI 1.0 support

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Add smccc accessors to PSCI code

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Add PSCI_VERSION helper

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Consolidate the PSCI include files

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Increment PC after handling an SMC trap

Jayachandran C <jnair@caviumnetworks.com>
    arm64: Branch predictor hardening for Cavium ThunderX2

Shanker Donthineni <shankerd@codeaurora.org>
    arm64: Implement branch predictor hardening for Falkor

Will Deacon <will.deacon@arm.com>
    arm64: Implement branch predictor hardening for affected Cortex-A CPUs

Will Deacon <will.deacon@arm.com>
    arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75

Will Deacon <will.deacon@arm.com>
    arm64: entry: Apply BP hardening for suspicious interrupts from EL0

Will Deacon <will.deacon@arm.com>
    arm64: entry: Apply BP hardening for high-priority synchronous exceptions

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Use per-CPU vector when BP hardening is enabled

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Move BP hardening to check_and_switch_context

Will Deacon <will.deacon@arm.com>
    arm64: Add skeleton to harden the branch predictor against aliasing attacks

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Move post_ttbr_update_workaround to C code

Will Deacon <will.deacon@arm.com>
    drivers/firmware: Expose psci_get_version through psci_ops structure

Will Deacon <will.deacon@arm.com>
    arm64: cpufeature: Pass capability structure to ->enable callback

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Run enable method for errata work arounds on late CPUs

James Morse <james.morse@arm.com>
    arm64: cpufeature: __this_cpu_has_cap() shouldn't stop early

Will Deacon <will.deacon@arm.com>
    arm64: futex: Mask __user pointers prior to dereference

Will Deacon <will.deacon@arm.com>
    arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user

Will Deacon <will.deacon@arm.com>
    arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user

Will Deacon <will.deacon@arm.com>
    arm64: uaccess: Prevent speculative use of the current addr_limit

Will Deacon <will.deacon@arm.com>
    arm64: entry: Ensure branch through syscall table is bounded under speculation

Robin Murphy <robin.murphy@arm.com>
    arm64: Use pointer masking to limit uaccess speculation

Robin Murphy <robin.murphy@arm.com>
    arm64: Make USER_DS an inclusive limit

Robin Murphy <robin.murphy@arm.com>
    arm64: Implement array_index_mask_nospec()

Will Deacon <will.deacon@arm.com>
    arm64: barrier: Add CSDB macros to control data-value prediction

Will Deacon <will.deacon@arm.com>
    arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives

Will Deacon <will.deacon@arm.com>
    arm64: entry: Reword comment about post_ttbr_update_workaround

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Force KPTI to be disabled on Cavium ThunderX

Will Deacon <will.deacon@arm.com>
    arm64: kpti: Add ->enable callback to remap swapper using nG mappings

Will Deacon <will.deacon@arm.com>
    arm64: mm: Permit transitioning from Global to Non-Global without BBM

Will Deacon <will.deacon@arm.com>
    arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()

Jayachandran C <jnair@caviumnetworks.com>
    arm64: Turn on KPTI only on CPUs that need it

Jayachandran C <jnair@caviumnetworks.com>
    arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs

Catalin Marinas <catalin.marinas@arm.com>
    arm64: kpti: Fix the interaction between ASID switching and software PAN

Will Deacon <will.deacon@arm.com>
    arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the TTBR

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: capabilities: Handle duplicate entries for a capability

Will Deacon <will.deacon@arm.com>
    arm64: Take into account ID_AA64PFR0_EL1.CSV3

Will Deacon <will.deacon@arm.com>
    arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry

Will Deacon <will.deacon@arm.com>
    arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0

Will Deacon <will.deacon@arm.com>
    arm64: use RET instruction for exiting the trampoline

Will Deacon <will.deacon@arm.com>
    arm64: kaslr: Put kernel vectors address in separate data page

Will Deacon <will.deacon@arm.com>
    arm64: entry: Add fake CPU feature for unmapping the kernel at EL0

Will Deacon <will.deacon@arm.com>
    arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks

Stephen Boyd <sboyd@codeaurora.org>
    arm64: cpu_errata: Add Kryo to Falkor 1003 errata

Will Deacon <will.deacon@arm.com>
    arm64: erratum: Work around Falkor erratum #E1003 in trampoline code

Will Deacon <will.deacon@arm.com>
    arm64: entry: Hook up entry trampoline to exception vectors

Will Deacon <will.deacon@arm.com>
    arm64: entry: Explicitly pass exception level to kernel_ventry macro

Will Deacon <will.deacon@arm.com>
    arm64: mm: Map entry trampoline into trampoline and kernel page tables

Will Deacon <will.deacon@arm.com>
    arm64: entry: Add exception trampoline page for exceptions from EL0

Will Deacon <will.deacon@arm.com>
    arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI

Will Deacon <will.deacon@arm.com>
    arm64: mm: Add arm64_kernel_unmapped_at_el0 helper

Will Deacon <will.deacon@arm.com>
    arm64: mm: Allocate ASIDs in pairs

Will Deacon <will.deacon@arm.com>
    arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN

Will Deacon <will.deacon@arm.com>
    arm64: mm: Rename post_ttbr0_update_workaround

Will Deacon <will.deacon@arm.com>
    arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum #E1003

Will Deacon <will.deacon@arm.com>
    arm64: mm: Move ASID from TTBR0 to TTBR1

Will Deacon <will.deacon@arm.com>
    arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN

Will Deacon <will.deacon@arm.com>
    arm64: mm: Use non-global mappings for kernel space

Yury Norov <ynorov@caviumnetworks.com>
    arm64: move TASK_* definitions to <asm/processor.h>

Arvind Yadav <arvind.yadav.cs@gmail.com>
    media: hdpvr: Fix an error handling path in hdpvr_probe()

Malcolm Priestley <tvboxspy@gmail.com>
    media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner

Malcolm Priestley <tvboxspy@gmail.com>
    media: dvb-usb-v2: lmedm04: Improve logic checking of warm start

Mohamed Ghannam <simo.ghannam@gmail.com>
    dccp: CVE-2017-8824: use-after-free in DCCP code

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix deadlock in i830_disable_pipe()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Redo plane sanitation during readout

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Add .get_hw_state() method for planes

Steven Rostedt (VMware) <rostedt@goodmis.org>
    sched/rt: Up the root domain ref count when passing it around via IPIs

Steven Rostedt (VMware) <rostedt@goodmis.org>
    sched/rt: Use container_of() to get root domain in rto_push_irq_work_func()

Haozhong Zhang <haozhong.zhang@intel.com>
    KVM MMU: check pending exception before injecting APF

Shanker Donthineni <shankerd@codeaurora.org>
    arm64: Add software workaround for Falkor erratum 1041

Shanker Donthineni <shankerd@codeaurora.org>
    arm64: Define cputype macros for Falkor CPU

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    watchdog: gpio_wdt: set WDOG_HW_RUNNING in gpio_wdt_stop

Omar Sandoval <osandov@fb.com>
    sched/wait: Fix add_wait_queue() behavioral change

Yang Shunyong <shunyong.yang@hxt-semitech.com>
    dmaengine: dmatest: fix container_of member in dmatest_callback

Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
    cpufreq: mediatek: add mediatek related projects into blacklist

Aurelien Aptel <aaptel@suse.com>
    CIFS: zero sensitive data when freeing

Daniel N Pettersson <danielnp@axis.com>
    cifs: Fix autonegotiate security settings mismatch

Matthew Wilcox <mawilcox@microsoft.com>
    cifs: Fix missing put_xid in cifs_file_strict_mmap

Michal Suchanek <msuchanek@suse.de>
    powerpc/pseries: include linux/types.h in asm/hvcall.h

Matt Redfearn <matt.redfearn@mips.com>
    watchdog: indydog: Add dependency on SGI_HAS_INDYDOG


-------------

Diffstat:

 Documentation/arm64/silicon-errata.txt             |    3 +-
 Makefile                                           |    7 +-
 arch/alpha/include/asm/futex.h                     |    8 +-
 arch/alpha/kernel/osf_sys.c                        |    4 +-
 arch/alpha/kernel/pci_impl.h                       |    3 +-
 arch/alpha/kernel/process.c                        |    3 +-
 arch/alpha/kernel/traps.c                          |   13 +-
 arch/arm/crypto/crc32-ce-glue.c                    |    2 +
 arch/arm/include/asm/kvm_host.h                    |    6 +
 arch/arm/include/asm/kvm_mmu.h                     |   10 +
 arch/arm/include/asm/kvm_psci.h                    |   27 -
 arch/arm/kvm/handle_exit.c                         |   17 +-
 arch/arm64/Kconfig                                 |   56 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |    6 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |    7 +
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |    6 +
 arch/arm64/crypto/crc32-ce-glue.c                  |    2 +
 arch/arm64/include/asm/asm-uaccess.h               |   36 +-
 arch/arm64/include/asm/assembler.h                 |   54 +-
 arch/arm64/include/asm/barrier.h                   |   23 +
 arch/arm64/include/asm/cpucaps.h                   |    5 +-
 arch/arm64/include/asm/cputype.h                   |   11 +
 arch/arm64/include/asm/efi.h                       |   12 +-
 arch/arm64/include/asm/fixmap.h                    |    5 +
 arch/arm64/include/asm/futex.h                     |    9 +-
 arch/arm64/include/asm/kvm_asm.h                   |    2 +
 arch/arm64/include/asm/kvm_host.h                  |    5 +
 arch/arm64/include/asm/kvm_mmu.h                   |   38 +
 arch/arm64/include/asm/kvm_psci.h                  |   27 -
 arch/arm64/include/asm/memory.h                    |   15 -
 arch/arm64/include/asm/mmu.h                       |   48 +
 arch/arm64/include/asm/mmu_context.h               |   12 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |    1 +
 arch/arm64/include/asm/pgtable-prot.h              |   35 +-
 arch/arm64/include/asm/pgtable.h                   |    1 +
 arch/arm64/include/asm/proc-fns.h                  |    6 -
 arch/arm64/include/asm/processor.h                 |   24 +
 arch/arm64/include/asm/sysreg.h                    |    2 +
 arch/arm64/include/asm/tlbflush.h                  |   16 +-
 arch/arm64/include/asm/uaccess.h                   |  181 +++-
 arch/arm64/kernel/Makefile                         |    4 +
 arch/arm64/kernel/arm64ksyms.c                     |    4 +-
 arch/arm64/kernel/asm-offsets.c                    |    6 +-
 arch/arm64/kernel/bpi.S                            |   83 ++
 arch/arm64/kernel/cpu-reset.S                      |    3 +-
 arch/arm64/kernel/cpu_errata.c                     |  239 ++++-
 arch/arm64/kernel/cpufeature.c                     |  138 ++-
 arch/arm64/kernel/efi-entry.S                      |    2 +
 arch/arm64/kernel/entry.S                          |  230 ++++-
 arch/arm64/kernel/head.S                           |    3 +-
 arch/arm64/kernel/process.c                        |   12 +-
 arch/arm64/kernel/relocate_kernel.S                |    1 +
 arch/arm64/kernel/sleep.S                          |    2 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   22 +-
 arch/arm64/kvm/handle_exit.c                       |   14 +-
 arch/arm64/kvm/hyp-init.S                          |    1 +
 arch/arm64/kvm/hyp/entry.S                         |   12 +
 arch/arm64/kvm/hyp/hyp-entry.S                     |   20 +-
 arch/arm64/kvm/hyp/switch.c                        |   13 +-
 arch/arm64/lib/clear_user.S                        |   10 +-
 arch/arm64/lib/copy_from_user.S                    |    4 +-
 arch/arm64/lib/copy_in_user.S                      |    9 +-
 arch/arm64/lib/copy_to_user.S                      |    4 +-
 arch/arm64/mm/cache.S                              |    4 +-
 arch/arm64/mm/context.c                            |   48 +-
 arch/arm64/mm/fault.c                              |   36 +-
 arch/arm64/mm/mmu.c                                |   35 +
 arch/arm64/mm/proc.S                               |  223 ++++-
 arch/arm64/xen/hypercall.S                         |    4 +-
 arch/mn10300/mm/misalignment.c                     |    2 +-
 arch/openrisc/kernel/traps.c                       |   10 +-
 arch/powerpc/crypto/crc32c-vpmsum_glue.c           |    1 +
 arch/powerpc/include/asm/hvcall.h                  |    1 +
 arch/powerpc/kvm/Kconfig                           |    2 +-
 arch/powerpc/kvm/book3s_hv.c                       |   16 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   40 +-
 arch/s390/crypto/crc32-vx.c                        |    3 +
 arch/sh/kernel/traps_32.c                          |    3 +-
 arch/sparc/crypto/crc32c_glue.c                    |    1 +
 arch/x86/crypto/crc32-pclmul_glue.c                |    1 +
 arch/x86/crypto/crc32c-intel_glue.c                |    1 +
 arch/x86/crypto/poly1305_glue.c                    |    1 -
 .../x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c |   10 +-
 arch/x86/kvm/mmu.c                                 |    3 +-
 arch/x86/kvm/vmx.c                                 |    6 +-
 arch/x86/kvm/x86.h                                 |    1 +
 arch/xtensa/include/asm/futex.h                    |   23 +-
 block/blk-core.c                                   |    9 +
 crypto/ahash.c                                     |   33 +-
 crypto/algif_hash.c                                |   52 +-
 crypto/crc32_generic.c                             |    1 +
 crypto/crc32c_generic.c                            |    1 +
 crypto/cryptd.c                                    |   10 +-
 crypto/mcryptd.c                                   |   10 +-
 crypto/poly1305_generic.c                          |   17 +-
 crypto/shash.c                                     |   25 +-
 drivers/acpi/nfit/core.c                           |    3 +
 drivers/acpi/sbshc.c                               |    4 +-
 drivers/ata/ahci.c                                 |   37 +-
 drivers/block/pktcdvd.c                            |   12 +-
 drivers/bluetooth/btsdio.c                         |    9 +
 drivers/bluetooth/btusb.c                          |   20 +-
 drivers/char/ipmi/ipmi_dmi.c                       |    5 +-
 drivers/clocksource/timer-stm32.c                  |    7 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |    8 +
 drivers/crypto/bfin_crc.c                          |    3 +-
 drivers/crypto/caam/ctrl.c                         |    8 +-
 drivers/crypto/stm32/stm32_crc32.c                 |    2 +
 drivers/crypto/talitos.c                           |    4 +
 drivers/dma/dmatest.c                              |    2 +-
 drivers/edac/octeon_edac-lmc.c                     |    1 +
 drivers/firmware/psci.c                            |   57 +-
 drivers/gpu/drm/i915/intel_display.c               |  303 +++---
 drivers/gpu/drm/i915/intel_dp.c                    |    6 +
 drivers/gpu/drm/i915/intel_drv.h                   |    2 +
 drivers/gpu/drm/i915/intel_sprite.c                |   83 ++
 drivers/hid/hid-core.c                             |   12 +-
 drivers/media/dvb-frontends/ascot2e.c              |    4 +-
 drivers/media/dvb-frontends/cxd2841er.c            |    4 +-
 drivers/media/dvb-frontends/helene.c               |    4 +-
 drivers/media/dvb-frontends/horus3a.c              |    4 +-
 drivers/media/dvb-frontends/itd1000.c              |    5 +-
 drivers/media/dvb-frontends/mt312.c                |    5 +-
 drivers/media/dvb-frontends/stb0899_drv.c          |    3 +-
 drivers/media/dvb-frontends/stb6100.c              |    6 +-
 drivers/media/dvb-frontends/stv0367.c              |    4 +-
 drivers/media/dvb-frontends/stv090x.c              |    4 +-
 drivers/media/dvb-frontends/stv6110x.c             |    4 +-
 drivers/media/dvb-frontends/ts2020.c               |    4 +-
 drivers/media/dvb-frontends/zl10039.c              |    4 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |   39 +-
 drivers/media/usb/dvb-usb/cxusb.c                  |    2 +
 drivers/media/usb/dvb-usb/dib0700_devices.c        |    1 +
 drivers/media/usb/hdpvr/hdpvr-core.c               |   26 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      | 1032 ++++++++++++--------
 drivers/media/v4l2-core/v4l2-ioctl.c               |  145 ++-
 drivers/mtd/nand/brcmnand/brcmnand.c               |   13 +-
 drivers/mtd/nand/nand_base.c                       |    5 +-
 drivers/mtd/nand/sunxi_nand.c                      |    8 +-
 drivers/mtd/ubi/block.c                            |   42 +-
 drivers/mtd/ubi/vmt.c                              |   15 +-
 drivers/mtd/ubi/wl.c                               |   77 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   23 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |    8 +-
 drivers/pinctrl/pinctrl-sx150x.c                   |   40 +-
 drivers/scsi/cxlflash/main.c                       |    1 +
 drivers/scsi/hosts.c                               |    6 +
 drivers/scsi/lpfc/lpfc_init.c                      |   84 +-
 drivers/scsi/scsi_error.c                          |   18 +-
 drivers/scsi/scsi_lib.c                            |   39 +-
 .../lustre/lnet/libcfs/linux/linux-crypto-adler.c  |    1 +
 drivers/watchdog/Kconfig                           |    2 +-
 drivers/watchdog/gpio_wdt.c                        |    3 +-
 drivers/watchdog/imx2_wdt.c                        |   20 +-
 fs/btrfs/inode.c                                   |   11 +-
 fs/btrfs/raid56.c                                  |   11 +-
 fs/cifs/cifsencrypt.c                              |    3 +-
 fs/cifs/connect.c                                  |    6 +-
 fs/cifs/file.c                                     |   26 +-
 fs/cifs/misc.c                                     |   14 +-
 fs/cifs/smb2pdu.c                                  |    3 +-
 fs/devpts/inode.c                                  |    4 +-
 fs/kernfs/file.c                                   |    2 +-
 fs/nfs/direct.c                                    |    4 +-
 fs/nfs/filelayout/filelayout.c                     |    4 +-
 fs/nfs/io.c                                        |    2 +-
 fs/nfs/nfs4idmap.c                                 |    6 +-
 fs/nfs/nfs4xdr.c                                   |   64 +-
 fs/nfs/pnfs.c                                      |    4 +-
 fs/nfs/write.c                                     |    2 +
 fs/overlayfs/readdir.c                             |   17 +-
 fs/pipe.c                                          |   15 +-
 fs/proc/kcore.c                                    |   18 +-
 fs/ubifs/dir.c                                     |   10 +-
 include/crypto/hash.h                              |   34 +-
 include/crypto/internal/hash.h                     |    2 +
 include/crypto/poly1305.h                          |    2 -
 include/kvm/arm_psci.h                             |   51 +
 include/linux/arm-smccc.h                          |  165 +++-
 include/linux/crypto.h                             |    8 +
 include/linux/mtd/map.h                            |  130 ++-
 include/linux/nfs4.h                               |   12 +-
 include/linux/psci.h                               |   14 +
 include/scsi/scsi_host.h                           |    2 +
 include/uapi/linux/psci.h                          |    3 +
 kernel/async.c                                     |   20 +-
 kernel/relay.c                                     |    1 -
 kernel/sched/rt.c                                  |   24 +-
 kernel/sched/sched.h                               |    2 +
 kernel/sched/topology.c                            |   13 +
 kernel/sched/wait.c                                |    2 +-
 kernel/trace/ftrace.c                              |    1 -
 lib/Kconfig.debug                                  |    2 +-
 lib/Kconfig.kasan                                  |   11 +
 lib/ubsan.c                                        |   50 +-
 lib/ubsan.h                                        |   14 +
 net/dccp/proto.c                                   |    5 +
 scripts/Makefile.kasan                             |    5 +
 scripts/Makefile.lib                               |    2 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |    3 +-
 sound/soc/rockchip/rockchip_i2s.c                  |    6 +
 tools/objtool/check.c                              |   41 +-
 tools/objtool/check.h                              |    1 +
 virt/kvm/arm/arm.c                                 |   11 +-
 virt/kvm/arm/psci.c                                |  143 ++-
 205 files changed, 3889 insertions(+), 1627 deletions(-)
