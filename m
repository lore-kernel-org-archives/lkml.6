Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F23ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805BC2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805BC2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeIREiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:38:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIREiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:38:19 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8F4E707;
        Mon, 17 Sep 2018 23:08:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 000/158] 4.18.9-stable review
Date:   Tue, 18 Sep 2018 00:40:30 +0200
Message-Id: <20180917211710.383360696@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.9-rc1
X-KernelTest-Deadline: 2018-09-19T21:17+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.9 release.
There are 158 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep 19 21:16:14 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.9-rc1

Linus Torvalds <torvalds@linux-foundation.org>
    mm: get rid of vmacache_flush_all() entirely

Ian Kent <raven@themaw.net>
    autofs: fix autofs_sbi() does not check super block type

Peter Zijlstra <peterz@infradead.org>
    clocksource: Revert "Remove kthread"

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Do not ignore net namespace for unbound cm_id

Quentin Schulz <quentin.schulz@bootlin.com>
    MIPS: mscc: ocelot: fix length of memory address space for MIIM

Paul Burton <paul.burton@mips.com>
    MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON

Lijun Ou <oulijun@huawei.com>
    RDMA/hns: Update the data type of immediate data

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Fix a potential layoutget/layoutrecall deadlock

Lijun Ou <oulijun@huawei.com>
    RDMA/hns: Add illegal hop_num judgement

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with extra_attr feature

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to propagate return value of scan_nat_page()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize

Zumeng Chen <zumeng.chen@gmail.com>
    mfd: ti_am335x_tscadc: Fix struct clk memory leak

Geert Uytterhoeven <geert+renesas@glider.be>
    iommu/ipmmu-vmsa: Fix allocation in atomic context

Andrey Smirnov <andrew.smirnov@gmail.com>
    mfd: rave-sp: Initialize flow control and parity of the port

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with secs_per_zone

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: avoid potential deadlock in f2fs_sbi_store

Brad Love <brad@nextdimension.cc>
    media: em28xx: Fix DualHD disconnect oops

Dan Carpenter <dan.carpenter@oracle.com>
    f2fs: Fix uninitialized return in f2fs_ioc_shutdown()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to wait on page writeback before updating page

Will Deacon <will.deacon@arm.com>
    iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel

Brad Love <brad@nextdimension.cc>
    media: em28xx: Fix dual transport stream operation

Anthony Koo <Anthony.Koo@amd.com>
    drm/amd/display: Prevent PSR from being enabled if initialization fails

Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
    media: helene: fix xtal frequency setting at power on

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    media: rcar-csi2: update stream start for V3M

Mauricio Faria de Oliveira <mfo@canonical.com>
    partitions/aix: fix usage of uninitialized lv_info and lvname structures

Mauricio Faria de Oliveira <mfo@canonical.com>
    partitions/aix: append null character to print data from disk

Sylwester Nawrocki <s.nawrocki@samsung.com>
    media: s5p-mfc: Fix buffer look up in s5p_mfc_handle_frame_{new, copy_time} functions

Nick Dyer <nick.dyer@itdev.co.uk>
    Input: atmel_mxt_ts - only use first T9 instance

John Pittman <jpittman@redhat.com>
    dm cache: only allow a single io_mode cache feature to be requested

Petr Machata <petrm@mellanox.com>
    net: dcb: For wild-card lookups, use priority -1, not 0

Marc Zyngier <marc.zyngier@arm.com>
    thermal_hwmon: Sanitize attribute name passed to hwmon

Simon Horman <horms+renesas@verge.net.au>
    thermal: rcar_thermal: avoid NULL dereference in absence of IRQ resources

Nicholas Mc Guire <hofrat@osadl.org>
    MIPS: generic: fix missing of_node_put()

Nicholas Mc Guire <hofrat@osadl.org>
    MIPS: Octeon: add missing of_node_put()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with reserved blkaddr of inline inode

Peter Rosin <peda@axentia.se>
    tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Linus Walleij <linus.walleij@linaro.org>
    tpm_tis_spi: Pass the SPI IRQ down to the driver

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to skip GC if type in SSA and SIT is inconsistent

Jinbum Park <jinb.park7@gmail.com>
    pktcdvd: Fix possible Spectre-v1 for pkt_devs

Chao Yu <yuchao0@huawei.com>
    f2fs: try grabbing node page lock aggressively in sync scenario

Yelena Krivosheev <yelena@marvell.com>
    net: mvneta: fix mtu change on port without link

Daniel Kurtz <djkurtz@chromium.org>
    pinctrl/amd: only handle irq if it is pending and unmasked

Anton Vasilyev <vasilyev@ispras.ru>
    gpio: ml-ioh: Fix buffer underwrite on probe error path

Daniel Mack <daniel@zonque.org>
    gpio: pxa: disable pinctrl calls for PXA3xx

Dan Carpenter <dan.carpenter@oracle.com>
    pinctrl: imx: off by one in imx_pinconf_group_dbg_show()

Anton Vasilyev <vasilyev@ispras.ru>
    regulator: tps65217: Fix NULL pointer dereference on probe

Joerg Roedel <jroedel@suse.de>
    x86/mm: Remove in_nmi() warning from vmalloc_fault()

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: hidp: Fix handling of strncpy for hid->name information

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Don't report PUDs as memory leaks when using kmemleak

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base address type

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    PCI: mobiveil: Add missing ../pci.h include

Robert Schlabbach <Robert.Schlabbach@gmx.net>
    media: em28xx: explicitly disable TS packet filter

Surabhi Vishnoi <svishnoi@codeaurora.org>
    ath10k: disable bundle mgmt tx completion event support

Huaisheng Ye <yehs1@lenovo.com>
    tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()

Anton Vasilyev <vasilyev@ispras.ru>
    scsi: 3ware: fix return 0 on the error path of probe

Calum Mackay <calum.mackay@oracle.com>
    nfs: Referrals not inheriting proto setting from parent

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    ata: libahci: Correct setting of DEVSLP register

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    ata: libahci: Allow reconfigure of DEVSLP register

Paul Burton <paul.burton@mips.com>
    MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET

Mike Christie <mchristi@redhat.com>
    scsi: tcmu: do not set max_blocks if data_bitmap has been setup

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: make subop helpers return unsigned values

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    rpmsg: core: add support to power domains for devices

Loic Poulain <loic.poulain@linaro.org>
    wlcore: Set rx_status boottime_ns field on rx

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath10k: prevent active scans on potential unusable channels

Felix Fietkau <nbd@nbd.name>
    ath9k_hw: fix channel maximum power level test

Felix Fietkau <nbd@nbd.name>
    ath9k: report tx status on EOSP

Thomas Richter <tmricht@linux.ibm.com>
    perf build: Fix installation directory for eBPF

Finn Thain <fthain@telegraphics.com.au>
    macintosh/via-pmu: Add missing mmio accessors

Sam Bobroff <sbobroff@linux.ibm.com>
    powerpc/pseries: fix EEH recovery of some IOV devices

Kan Liang <kan.liang@linux.intel.com>
    perf evlist: Fix error out while applying initial delay and LBR

Jiri Olsa <jolsa@kernel.org>
    perf c2c report: Fix crash for empty browser

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.0 fix client reference leak in callback

Stefan Hajnoczi <stefanha@redhat.com>
    device-dax: avoid hang on error before devm_memremap_pages()

Christophe Leroy <christophe.leroy@c-s.fr>
    perf tools: Allow overriding MAX_NR_CPUS at compile time

Akshu Agrawal <akshu.agrawal@amd.com>
    ASoC: soc-pcm: Use delay set in component pointer function

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to detect looped node chain correctly

Randy Dunlap <rdunlap@infradead.org>
    f2fs: fix defined but not used build warnings

Yunlong Song <yunlong.song@huawei.com>
    f2fs: issue discard align to section in LFS mode

Daniel Rosenberg <drosen@google.com>
    f2fs: Keep alloc_valid_block_count in sync

Yunlong Song <yunlong.song@huawei.com>
    f2fs: do not set free of current section

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to active page in lru list for read path

Denis Drozdov <denisd@mellanox.com>
    IB/IPoIB: Set ah valid flag in multicast send flow

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: pcie: don't access periphery registers when not available

Xiubo Li <xiubli@redhat.com>
    uio: fix possible circular locking dependency

Anton Vasilyev <vasilyev@ispras.ru>
    tty: rocket: Fix possible buffer overwrite on register_PCI

Michael Kelley <mikelley@microsoft.com>
    Drivers: hv: vmbus: Cleanup synic memory free path

Anton Vasilyev <vasilyev@ispras.ru>
    firmware: vpd: Fix section enabled flag on vpd_section_destroy

Dan Carpenter <dan.carpenter@oracle.com>
    uio: potential double frees if __uio_register_device() fails

Anton Vasilyev <vasilyev@ispras.ru>
    misc: ti-st: Fix memory leak in the error path of probe()

Philipp Zabel <p.zabel@pengutronix.de>
    gpu: ipu-v3: default to id 0 on missing OF alias

Todor Tomov <todor.tomov@linaro.org>
    media: camss: csid: Configure data type and decode format properly

Gaurav Kohli <gkohli@codeaurora.org>
    timers: Clear timer_base::must_forward_clk with timer_base::lock held

BingJing Chang <bingjingc@synology.com>
    md/raid5: fix data corruption of replacements after originals dropped

Mike Christie <mchristi@redhat.com>
    scsi: target: fix __transport_register_session locking

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix driver crash when re-registering NVME rports.

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix updating tags depth

Amit Daniel Kachhap <amit.kachhap@arm.com>
    clk: scmi: Fix the rounding of clock rate

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Silent erroneous message

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix session state stuck in Get Port DB

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix unintended Logout

Arun Parameswaran <arun.parameswaran@broadcom.com>
    net: phy: Fix the register offsets in Broadcom iProc mdio mux driver

Anton Vasilyev <vasilyev@ispras.ru>
    media: dw2102: Fix memleak on sequence of probes

Anton Vasilyev <vasilyev@ispras.ru>
    media: davinci: vpif_display: Mix memory leak on probe error path

Roman Gushchin <guro@fb.com>
    selftests/bpf: fix a typo in map in map test

Guenter Roeck <linux@roeck-us.net>
    powerpc/4xx: Fix error return path in ppc4xx_msi_probe()

Reza Arbab <arbab@linux.ibm.com>
    powerpc/powernv: Fix concurrency issue with npu->mmio_atsd_usage

Dmitry Osipenko <digetx@gmail.com>
    gpio: tegra: Move driver registration to subsys_init level

YueHaibing <yuehaibing@huawei.com>
    pinctrl: berlin: fix 'pctrl->functions' allocation in berlin_pinctrl_build_state

Johan Hedberg <johan.hedberg@intel.com>
    Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV

Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
    i2c: aspeed: Add an explicit type casting for *get_clk_reg_val

Florian Fainelli <f.fainelli@gmail.com>
    ethtool: Remove trailing semicolon for static inline

Alexandru Gagniuc <mr.nuke.me@gmail.com>
    ALSA: hda/realtek - Add mute LED quirk for HP Spectre x360

Dan Carpenter <dan.carpenter@oracle.com>
    misc: mic: SCIF Fix scif_get_new_port() error handling

Vlad Buslov <vladbu@mellanox.com>
    tc-testing: remove duplicate spaces in connmark match patterns

Vlad Buslov <vladbu@mellanox.com>
    tc-testing: flush gact actions on test teardown

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: [plat-axs*]: Enable SWAP

Gustavo A. R. Silva <gustavo@embeddedor.com>
    switchtec: Fix Spectre v1 vulnerability

Thomas Gleixner <tglx@linutronix.de>
    x86/apic/vector: Make error return value negative

Jann Horn <jannh@google.com>
    x86/process: Don't mix user/kernel regs in 64bit __show_regs()

Filippo Sironi <sironi@amazon.de>
    x86/microcode: Update the new microcode revision unconditionally

Prarit Bhargava <prarit@redhat.com>
    x86/microcode: Make sure boot_cpu_data.microcode is up-to-date

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Prevent state corruption on error rollback

Neeraj Upadhyay <neeraju@codeaurora.org>
    cpu/hotplug: Adjust misplaced smb() in cpuhp_thread_fun()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix cancel_work_sync() stall from jackpoll work

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    memory: ti-aemif: fix a potential NULL-pointer dereference

Zhang Rui <rui.zhang@intel.com>
    ACPI / LPSS: Force LPSS quirks on boot

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: [plat-axs*/plat-hsdk]: Allow U-Boot to pass MAC-address to the kernel

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Do not re-{try,execute} after failed emulation in L2

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Default to not allowing emulation retry in kvm_mmu_page_fault

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Merge EMULTYPE_RETRY and EMULTYPE_ALLOW_REEXECUTE

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Invert emulation re-execute behavior to make it opt-in

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: VMX: Do not allow reexecute_instruction() when skipping MMIO instr

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: SVM: Set EMULTYPE_NO_REEXECUTE for RSM emulation

Pierre Morel <pmorel@linux.ibm.com>
    KVM: s390: vsie: copy wrapping keys to right place

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Use correct pagesize in kvm_unmap_radix()

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: Clean dcache to PoC when changing PTE due to CoW

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Only force FPEXC32_EL2.EN if trapping FPSIMD

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix data corruption when deduplicating between different files

Lu Fengqi <lufq.fnst@cn.fujitsu.com>
    btrfs: fix qgroup_free wrong num_bytes in btrfs_subvolume_reserve_metadata

Thomas Werschlein <thomas.werschlein@geo.uzh.ch>
    cifs: connect to servername instead of IP for IPC$ share

Steve French <stfrench@microsoft.com>
    smb3: check for and properly advertise directory lease support

Steve French <stfrench@microsoft.com>
    SMB3: Backup intent flag missing for directory opens with backupuid mounts

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Match data page cache colouring when D$ aliases

Minchan Kim <minchan@kernel.org>
    android: binder: fix the race mmap and alloc_new_buf_locked

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    block: bfq: swap puts in bfqg_and_blkg_put

Mikulas Patocka <mpatocka@redhat.com>
    block: don't warn when doing fsync on read-only devices

Jens Axboe <axboe@kernel.dk>
    nbd: don't allow invalid blocksize settings

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Correct MDS diag and nvmet configuration

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: don't update the PM state of a peer upon a multicast frame

Mikhail Zaslonko <zaslonko@linux.ibm.com>
    memory_hotplug: fix kernel_panic on offline page processing

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.

Stefan Agner <stefan@agner.ch>
    HID: input: fix leaking custom input node name

AceLan Kao <acelan.kao@canonical.com>
    HID: i2c-hid: Fix flooded incomplete report after S3 on Rayd touchscreen

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    HID: core: fix grouping by application

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    HID: multitouch: fix Elan panels with 2 input modes declaration

Felipe Balbi <felipe.balbi@linux.intel.com>
    i2c: i801: fix DNV's SMBCTRL register offset

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    i2c: xiic: Make the start and the byte count write atomic


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/boot/dts/axs10x_mb.dtsi                   |  7 ++-
 arch/arc/boot/dts/hsdk.dts                         |  7 ++-
 arch/arc/configs/axs101_defconfig                  |  1 -
 arch/arc/configs/axs103_defconfig                  |  1 -
 arch/arc/configs/axs103_smp_defconfig              |  1 -
 arch/arm64/kvm/hyp/switch.c                        |  9 ++-
 arch/mips/boot/dts/mscc/ocelot.dtsi                |  2 +-
 arch/mips/cavium-octeon/octeon-platform.c          |  2 +
 arch/mips/generic/init.c                           |  1 +
 arch/mips/include/asm/io.h                         |  8 +--
 arch/mips/kernel/vdso.c                            | 20 ++++++
 arch/mips/mm/c-r4k.c                               |  6 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       | 23 ++++++-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |  6 +-
 arch/powerpc/platforms/4xx/msi.c                   | 51 ++++++++-------
 arch/powerpc/platforms/powernv/npu-dma.c           |  5 +-
 arch/powerpc/platforms/pseries/setup.c             | 25 +++++---
 arch/s390/kvm/vsie.c                               |  3 +-
 arch/x86/include/asm/kdebug.h                      | 12 +++-
 arch/x86/include/asm/kvm_host.h                    | 16 +++--
 arch/x86/kernel/apic/vector.c                      |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c                | 24 ++++---
 arch/x86/kernel/cpu/microcode/intel.c              | 17 +++--
 arch/x86/kernel/dumpstack.c                        | 11 +---
 arch/x86/kernel/process_32.c                       |  4 +-
 arch/x86/kernel/process_64.c                       | 12 +++-
 arch/x86/kvm/mmu.c                                 | 21 +++++--
 arch/x86/kvm/svm.c                                 |  4 +-
 arch/x86/kvm/vmx.c                                 |  4 +-
 arch/x86/kvm/x86.c                                 | 10 ++-
 arch/x86/mm/fault.c                                |  2 -
 block/bfq-cgroup.c                                 |  4 +-
 block/blk-core.c                                   |  5 +-
 block/blk-mq-tag.c                                 |  8 +--
 block/partitions/aix.c                             | 13 ++--
 drivers/acpi/acpi_lpss.c                           |  2 +-
 drivers/android/binder_alloc.c                     | 43 ++++++++++---
 drivers/ata/libahci.c                              | 20 +++---
 drivers/base/memory.c                              | 20 +++---
 drivers/block/nbd.c                                |  3 +
 drivers/block/pktcdvd.c                            |  4 +-
 drivers/bluetooth/Kconfig                          |  1 +
 drivers/char/tpm/tpm_i2c_infineon.c                |  8 +--
 drivers/char/tpm/tpm_tis_spi.c                     |  9 ++-
 drivers/clk/clk-scmi.c                             |  5 +-
 drivers/dax/pmem.c                                 | 12 ++--
 drivers/firmware/google/vpd.c                      |  5 +-
 drivers/gpio/gpio-ml-ioh.c                         |  3 +-
 drivers/gpio/gpio-pxa.c                            | 35 ++++++++---
 drivers/gpio/gpio-tegra.c                          |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      | 38 ++++++-----
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |  2 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |  2 +
 drivers/hid/hid-ids.h                              |  1 +
 drivers/hid/hid-input.c                            |  5 +-
 drivers/hid/hid-multitouch.c                       | 19 +++++-
 drivers/hid/i2c-hid/i2c-hid.c                      |  2 +
 drivers/hv/hv.c                                    | 14 +++--
 drivers/i2c/busses/i2c-aspeed.c                    |  2 +-
 drivers/i2c/busses/i2c-i801.c                      |  7 ++-
 drivers/i2c/busses/i2c-xiic.c                      |  4 ++
 drivers/infiniband/core/cma.c                      | 13 +++-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  3 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 12 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  6 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |  1 +
 drivers/input/touchscreen/atmel_mxt_ts.c           |  7 ++-
 drivers/iommu/arm-smmu-v3.c                        | 22 +++++--
 drivers/iommu/ipmmu-vmsa.c                         |  9 ++-
 drivers/macintosh/via-pmu.c                        |  9 +--
 drivers/md/dm-cache-target.c                       | 19 ++++--
 drivers/md/raid5.c                                 |  6 ++
 drivers/media/dvb-frontends/helene.c               |  5 +-
 drivers/media/platform/davinci/vpif_display.c      | 24 ++++---
 .../media/platform/qcom/camss-8x16/camss-csid.c    | 16 +++--
 drivers/media/platform/rcar-vin/rcar-csi2.c        | 20 ++++--
 drivers/media/platform/s5p-mfc/s5p_mfc.c           | 23 +++----
 drivers/media/usb/dvb-usb/dw2102.c                 | 19 ++++--
 drivers/media/usb/em28xx/em28xx-cards.c            |  4 +-
 drivers/media/usb/em28xx/em28xx-core.c             |  4 +-
 drivers/media/usb/em28xx/em28xx-dvb.c              |  4 +-
 drivers/memory/ti-aemif.c                          |  2 +-
 drivers/mfd/rave-sp.c                              |  7 +++
 drivers/mfd/ti_am335x_tscadc.c                     |  3 +-
 drivers/misc/mic/scif/scif_api.c                   | 20 +++---
 drivers/misc/ti-st/st_kim.c                        |  4 +-
 drivers/mtd/nand/raw/nand_base.c                   | 44 ++++++-------
 drivers/net/ethernet/marvell/mvneta.c              |  1 -
 drivers/net/phy/mdio-mux-bcm-iproc.c               | 20 ++++--
 drivers/net/wireless/ath/ath10k/mac.c              |  7 +++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |  5 ++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |  5 ++
 drivers/net/wireless/ath/ath9k/hw.c                |  7 ++-
 drivers/net/wireless/ath/ath9k/xmit.c              |  3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  4 ++
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 24 +++----
 drivers/net/wireless/ti/wlcore/rx.c                |  8 ++-
 drivers/pci/controller/pcie-mobiveil.c             |  4 +-
 drivers/pci/switch/switchtec.c                     |  4 ++
 drivers/pinctrl/berlin/berlin.c                    | 14 +++--
 drivers/pinctrl/freescale/pinctrl-imx.c            |  2 +-
 drivers/pinctrl/pinctrl-amd.c                      |  3 +-
 drivers/regulator/tps65217-regulator.c             |  2 +
 drivers/rpmsg/rpmsg_core.c                         |  7 +++
 drivers/scsi/3w-9xxx.c                             |  6 +-
 drivers/scsi/3w-sas.c                              |  3 +
 drivers/scsi/3w-xxxx.c                             |  2 +
 drivers/scsi/lpfc/lpfc.h                           |  2 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      | 22 ++++---
 drivers/scsi/qla2xxx/qla_init.c                    |  9 ++-
 drivers/scsi/qla2xxx/qla_target.c                  |  3 +-
 drivers/scsi/qla2xxx/qla_tmpl.c                    |  9 +++
 drivers/target/target_core_transport.c             |  5 +-
 drivers/target/target_core_user.c                  | 73 ++++++++++++----------
 drivers/thermal/rcar_thermal.c                     |  2 +-
 drivers/thermal/thermal_hwmon.c                    |  1 +
 drivers/tty/rocket.c                               |  2 +-
 drivers/uio/uio.c                                  | 19 +++---
 fs/autofs/autofs_i.h                               |  4 +-
 fs/autofs/inode.c                                  |  1 -
 fs/btrfs/extent-tree.c                             | 17 +++--
 fs/btrfs/ioctl.c                                   | 19 ++++++
 fs/cifs/connect.c                                  |  2 +-
 fs/cifs/inode.c                                    |  2 +
 fs/cifs/smb2ops.c                                  | 35 ++++++++---
 fs/cifs/smb2pdu.c                                  |  3 +
 fs/f2fs/f2fs.h                                     | 15 +++--
 fs/f2fs/file.c                                     |  2 +-
 fs/f2fs/gc.c                                       |  8 ++-
 fs/f2fs/inline.c                                   | 22 +++++++
 fs/f2fs/inode.c                                    | 19 ++++--
 fs/f2fs/node.c                                     | 46 ++++++++++----
 fs/f2fs/recovery.c                                 |  4 +-
 fs/f2fs/segment.c                                  | 20 +++++-
 fs/f2fs/segment.h                                  |  3 +
 fs/f2fs/super.c                                    | 25 ++++++--
 fs/f2fs/sysfs.c                                    | 16 +++--
 fs/nfs/callback_proc.c                             |  4 +-
 fs/nfs/callback_xdr.c                              | 11 +++-
 fs/nfs/nfs4client.c                                |  6 +-
 include/linux/hid.h                                |  1 +
 include/linux/mm_types.h                           |  2 +-
 include/linux/mm_types_task.h                      |  2 +-
 include/linux/mtd/rawnand.h                        | 16 ++---
 include/linux/vm_event_item.h                      |  1 -
 include/linux/vmacache.h                           |  5 --
 include/uapi/linux/ethtool.h                       |  4 +-
 kernel/cpu.c                                       | 11 ++--
 kernel/time/clocksource.c                          | 40 +++++++++---
 kernel/time/timer.c                                | 29 +++++----
 mm/debug.c                                         |  4 +-
 mm/memory_hotplug.c                                |  3 +-
 mm/page_alloc.c                                    |  4 ++
 mm/vmacache.c                                      | 38 -----------
 net/bluetooth/hidp/core.c                          |  2 +-
 net/dcb/dcbnl.c                                    | 11 ++--
 net/mac80211/rx.c                                  |  1 +
 sound/pci/hda/hda_codec.c                          |  3 +-
 sound/pci/hda/patch_realtek.c                      |  1 +
 sound/soc/soc-pcm.c                                |  5 ++
 tools/perf/Makefile.config                         |  4 +-
 tools/perf/builtin-c2c.c                           |  3 +
 tools/perf/perf.h                                  |  2 +
 tools/perf/util/evsel.c                            | 14 +++++
 tools/testing/nvdimm/pmem-dax.c                    | 12 ++--
 tools/testing/selftests/bpf/test_verifier.c        |  6 +-
 .../tc-testing/tc-tests/actions/connmark.json      | 24 +++----
 .../tc-testing/tc-tests/actions/mirred.json        |  3 +-
 virt/kvm/arm/mmu.c                                 |  9 ++-
 170 files changed, 1167 insertions(+), 580 deletions(-)


