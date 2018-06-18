Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CC0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B3A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B3A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966919AbeFRIaJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:30:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966891AbeFRIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:30:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74B10C7A;
        Mon, 18 Jun 2018 08:30:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/189] 4.14.51-stable review
Date:   Mon, 18 Jun 2018 10:11:36 +0200
Message-Id: <20180618081209.254234434@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.51-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.51-rc1
X-KernelTest-Deadline: 2018-06-20T08:12+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.51 release.
There are 189 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jun 20 08:11:38 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.51-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.51-rc1

Eric Dumazet <edumazet@google.com>
    tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: make raid6 rebuild retry more

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix scrub to repair raid6 corruption

Sasha Levin <Alexander.Levin@microsoft.com>
    Revert "Btrfs: fix scrub to repair raid6 corruption"

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: kexec: fix kdump register saving on panic()

Łukasz Stelmach <l.stelmach@samsung.com>
    ARM: 8758/1: decompressor: restore r1 and r2 just before jumping to the kernel

Łukasz Stelmach <l.stelmach@samsung.com>
    ARM: 8753/1: decompressor: add a missing parameter to the addruart macro

Mark Rutland <mark.rutland@arm.com>
    efi/libstub/arm64: Handle randomized TEXT_OFFSET

Helge Deller <deller@gmx.de>
    parisc: Move setup_profiling_timer() out of init section

Mathieu Malaterre <malat@debian.org>
    sched/deadline: Make the grub_reclaim() function static

Mathieu Malaterre <malat@debian.org>
    sched/debug: Move the print_rt_rq() and print_dl_rq() declarations to kernel/sched/sched.h

Dan Carpenter <dan.carpenter@oracle.com>
    drm/dumb-buffers: Integer overflow in drm_mode_create_ioctl()

Waiman Long <longman@redhat.com>
    locking/percpu-rwsem: Annotate rwsem ownership transfer by setting RWSEM_OWNER_UNKNOWN

Waiman Long <longman@redhat.com>
    locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag

Stefan Agner <stefan@agner.ch>
    clk: imx6ull: use OSC clock during AXI rate change

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: board-dm646x-evm: set VPIF capture card name

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: board-dm646x-evm: pass correct I2C adapter id for VPIF

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: dm646x: fix timer interrupt generation

Peter Rosin <peda@axentia.se>
    i2c: viperboard: return message count on master_xfer success

Peter Rosin <peda@axentia.se>
    i2c: pmcmsp: fix error return from master_xfer

Peter Rosin <peda@axentia.se>
    i2c: pmcmsp: return message count on master_xfer success

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: keystone: fix platform_domain_notifier array overrun

Daniel Glöckner <dg@emlix.com>
    usb: musb: fix remote wakeup racing with suspend

David Howells <dhowells@redhat.com>
    afs: Fix the non-encryption of calls

Ben Hutchings <ben@decadent.org.uk>
    mtd: Fix comparison in map_word_andequal()

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Add a test for pkey 0

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Save off 'prot' for allocations

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Fix pointer math

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Fix pkey exhaustion test off-by-one

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Add PROT_EXEC test

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Factor out "instruction page"

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Allow faults on unknown keys

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Remove dead debugging code, fix dprint_in_signal

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Stop using assert()

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Give better unexpected fault error messages

Andy Lutomirski <luto@kernel.org>
    x86/selftests: Add mov_to_ss test

Ingo Molnar <mingo@kernel.org>
    x86/mpx/selftests: Adjust the self-test to fresh distros that export the MPX ABI

Ingo Molnar <mingo@kernel.org>
    x86/pkeys/selftests: Adjust the self-test to fresh distros that export the pkeys ABI

Ingo Molnar <mingo@kernel.org>
    objtool, kprobes/x86: Sync the latest <asm/insn.h> header with tools/objtool/arch/x86/include/asm/insn.h

Masami Hiramatsu <mhiramat@kernel.org>
    uprobes/x86: Prohibit probing on MOV SS instruction

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Prohibit probing on exception masking instructions

Ashish Samant <ashish.samant@oracle.com>
    ocfs2: take inode cluster lock before moving reflinked inode from orphan dir

Laura Abbott <labbott@redhat.com>
    proc/kcore: don't bounds check against address 0

Jeffrey Hugo <jhugo@codeaurora.org>
    init: fix false positives in W+X checking

Roman Mashak <mrv@mojatatu.com>
    net sched actions: fix invalid pointer dereferencing if skbedit flags missing

Emil Tantilov <emil.s.tantilov@intel.com>
    ixgbe: return error on unsupported SFP module when resetting

Marian Rotariu <mrotariu@bitdefender.com>
    x86: Delay skip of emulated hypercall instruction

Wanpeng Li <wanpengli@tencent.com>
    KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs

David Howells <dhowells@redhat.com>
    rxrpc: Fix the min security level for kernel calls

David Howells <dhowells@redhat.com>
    rxrpc: Fix error reception on AF_INET6 sockets

Michal Kalderon <Michal.Kalderon@cavium.com>
    qede: Fix gfp flags sent to rdma event node allocation

Michal Kalderon <Michal.Kalderon@cavium.com>
    qed: Fix l2 initializations over iWARP personality

Ying Xue <ying.xue@windriver.com>
    tipc: eliminate KMSAN uninit-value in strcmp complaint

Mathieu Malaterre <malat@debian.org>
    agp: uninorth: make two functions static

Paulo Alcantara <palcantara@suse.de>
    cifs: smb2ops: Fix listxattr() when there are no EAs

David Gilhooley <dgilhooley@nvidia.com>
    arm64: Add MIDR encoding for NVIDIA CPUs

Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
    can: dev: increase bus-off message severity

Igor Russkikh <igor.russkikh@aquantia.com>
    net: aquantia: driver should correctly declare vlan_features bits

van der Linden, Frank <fllinden@amazon.com>
    x86/xen: Reset VCPU0 info pointer after shared_info remap

Sara Sharon <sara.sharon@intel.com>
    mac80211: use timeout from the AddBA response instead of the request

Clément Péron <peron.clem@gmail.com>
    ARM: dts: cygnus: fix irq type for arm global timer

Mathieu Malaterre <malat@debian.org>
    driver core: add __printf verification to __ata_ehi_pushv_desc

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/omap: handle alloc failures in omap_connector

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/omap: check return value from soc_device_match

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/omap: fix possible NULL ref issue in tiler_reserve_2d

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/omap: fix uninitialized ret variable

Dan Carpenter <dan.carpenter@oracle.com>
    drm/omap: silence unititialized variable warning

Ilan Peer <ilan.peer@intel.com>
    mac80211: Adjust SAE authentication timeout

Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
    powerpc/trace/syscalls: Update syscall name matching logic to account for ppc_ prefix

Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
    powerpc/trace/syscalls: Update syscall name matching logic

Etienne Carriere <etienne.carriere@linaro.org>
    tee: check shm references are consistent in offset/size

Rich Felker <dalias@libc.org>
    sh: fix build failure for J2 cpu with SMP disabled

Peter Zijlstra <peterz@infradead.org>
    sched/core: Introduce set_special_state()

Rob Herring <robh@kernel.org>
    spi: bcm2835aux: ensure interrupts are enabled for shared handler

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Do not query GID during QP state transition to RTR

Sebastian Sanchez <sebastian.sanchez@intel.com>
    IB/hfi1: Fix memory leak in exception path in get_irq_affinity()

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1 Use correct type for num_user_context

Stefan Raspl <stefan.raspl@linux.ibm.com>
    smc: fix sendpage() call

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    ARM: OMAP1: ams-delta: fix deferred_fiq handler

Keith Busch <keith.busch@intel.com>
    nvme: Set integrity flag for user passthrough commands

Chengguang Xu <cgxu519@gmx.com>
    nvme: fix potential memory leak in option parsing

Changbin Du <changbin.du@intel.com>
    iommu/vt-d: fix shift-out-of-bounds in bug checking

Bhadram Varka <vbhadram@nvidia.com>
    arm64: tegra: Make BCM89610 PHY interrupt as active low

Peter Zijlstra <peterz@infradead.org>
    kthread, sched/wait: Fix kthread_parkme() wait-loop

Peter Zijlstra <peterz@infradead.org>
    stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock

Helge Deller <deller@gmx.de>
    parisc: drivers.c: Fix section mismatches

Daniel Borkmann <daniel@iogearbox.net>
    bpf, x64: fix memleak when not converging after image

Jim Gill <jgill@vmware.com>
    scsi: vmw-pvscsi: return DID_BUS_BUSY for adapter-initated aborts

Arnd Bergmann <arnd@arndb.de>
    hexagon: export csum_partial_copy_nocheck

Arnd Bergmann <arnd@arndb.de>
    hexagon: add memset_io() helper

Nick Dyer <nick@shmanahar.org>
    Input: atmel_mxt_ts - fix the firmware update

Adam Ford <aford173@gmail.com>
    ARM: dts: logicpd-som-lv: Fix Audio Mute

Adam Ford <aford173@gmail.com>
    ARM: dts: logicpd-som-lv: Fix WL127x Startup Issues

Tero Kristo <t-kristo@ti.com>
    ARM: OMAP2+: powerdomain: use raw_smp_processor_id() for trace

Geert Uytterhoeven <geert+renesas@glider.be>
    dt-bindings: panel: lvds: Fix path to display timing bindings

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: board-dm355-evm: fix broken networking

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: board-omapl138-hawk: fix GPIO numbers for MMC/SD lookup

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: board-da850-evm: fix GPIO lookup for MMC/SD

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: board-da830-evm: fix GPIO lookup for MMC/SD

Håkon Bugge <haakon.bugge@oracle.com>
    IB/core: Make ib_mad_client_id atomic

Amir Goldstein <amir73il@gmail.com>
    <linux/stringhash.h>: fix end_name_hash() for 64bit long

Zhu Yanjun <yanjun.zhu@oracle.com>
    IB/rxe: avoid double kfree_skb

Jianchao Wang <jianchao.w.wang@oracle.com>
    IB/rxe: add RXE_START_MASK for rxe_opcode IB_OPCODE_RC_SEND_ONLY_INV

Colin Ian King <colin.king@canonical.com>
    RDMA/iwpm: fix memory leak on map_info

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Fix use after destroy access to net namespace for IPoIB

Matan Barak <matanb@mellanox.com>
    IB/uverbs: Fix validating mandatory attributes

Greg Thelen <gthelen@google.com>
    IB: make INFINIBAND_ADDR_TRANS configurable

Greg Thelen <gthelen@google.com>
    ib_srp: depend on INFINIBAND_ADDR_TRANS

Greg Thelen <gthelen@google.com>
    ib_srpt: depend on INFINIBAND_ADDR_TRANS

Greg Thelen <gthelen@google.com>
    nvmet-rdma: depend on INFINIBAND_ADDR_TRANS

Greg Thelen <gthelen@google.com>
    nvme: depend on INFINIBAND_ADDR_TRANS

Jon Maloy <jon.maloy@ericsson.com>
    tipc: fix bug in function tipc_nl_node_dump_monitor

Baolin Wang <baolin.wang@linaro.org>
    i2c: sprd: Fix the i2c count issue

Baolin Wang <baolin.wang@linaro.org>
    i2c: sprd: Prevent i2c accesses after suspend is called

John Fastabend <john.fastabend@gmail.com>
    bpf: fix uninitialized variable in bpf tools

jacek.tomaka@poczta.fm <jacek.tomaka@poczta.fm>
    x86/cpu/intel: Add missing TLB cpuid values

Evan Wang <xswang@marvell.com>
    ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI

Evan Wang <xswang@marvell.com>
    libahci: Allow drivers to override stop_engine

Mark Rutland <mark.rutland@arm.com>
    KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_mmio_read_apr()

Mark Rutland <mark.rutland@arm.com>
    arm64: fix possible spectre-v1 in ptrace_hbp_get_event()

Omar Sandoval <osandov@fb.com>
    blk-mq: fix sysfs inflight counter

Arvind Yadav <arvind.yadav.cs@gmail.com>
    HID: intel-ish-hid: use put_device() instead of kfree()

Ramon Fried <rfried@codeaurora.org>
    rpmsg: added MODULE_ALIAS for rpmsg_char

Tobias Jordan <Tobias.Jordan@elektrobit.com>
    remoteproc: qcom: Fix potential device node leaks

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Don't enable freeze-on-smi for PerfMon V1

Dag Moxnes <dag.moxnes@oracle.com>
    rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add a testcase for multiple actions on trigger

Arvind Yadav <arvind.yadav.cs@gmail.com>
    HID: wacom: Release device resource data obtained by devres_alloc()

pgzh <peter.ganzhorn@gmail.com>
    HID: lenovo: Add support for IBM/Lenovo Scrollpoint mice

Mark Rutland <mark.rutland@arm.com>
    arm64: ptrace: remove addr_limit manipulation

Florian Fainelli <f.fainelli@gmail.com>
    net: ethtool: Add missing kernel doc for FEC parameters

Hans de Goede <hdegoede@redhat.com>
    thermal: int3403_thermal: Fix NULL pointer deref on module load / probe

Andres Rodriguez <andres.rodriguez@amd.com>
    drm/amdkfd: fix clock counter retrieval for node without GPU

Mika Westerberg <mika.westerberg@linux.intel.com>
    ACPI / watchdog: Prefer iTCO_wdt on Lenovo Z50-70

Sekhar Nori <nsekhar@ti.com>
    ARM: dts: da850: fix W=1 warnings with pinmux node

Jingju Hou <Jingju.Hou@synaptics.com>
    net: phy: marvell: clear wol event before setting it

Balbir Singh <bsingharora@gmail.com>
    powerpc/powernv/memtrace: Let the arch hotunplug code flush cache

Geert Uytterhoeven <geert+renesas@glider.be>
    dt-bindings: meson-uart: DT fix s/clocks-names/clock-names/

Chen Yu <yu.c.chen@intel.com>
    ACPI / PM: Blacklist Low Power S0 Idle _DSM for ThinkPad X1 Tablet(2016)

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: use Read device to query hypervisor for MAC

Tobias Regnery <tobias.regnery@gmail.com>
    usb: typec: ucsi: fix tracepoint related build error

Minchan Kim <minchan@kernel.org>
    mm: memcg: add __GFP_NOWARN in __memcg_schedule_kmem_cache_create()

Dave Young <dyoung@redhat.com>
    kexec_file: do not add extra alignment to efi memmap

Alexey Dobriyan <adobriyan@gmail.com>
    proc: revalidate kernel thread inodes to root:root

Huang Ying <ying.huang@intel.com>
    mm, pagemap: fix swap offset value for PMD migration entry

Colin Ian King <colin.king@canonical.com>
    scsi: isci: Fix infinite loop in while loop

Long Li <longli@microsoft.com>
    scsi: storvsc: Set up correct queue depth values for IDE devices

Baolin Wang <baolin.wang@linaro.org>
    parisc: time: Convert read_persistent_clock() to read_persistent_clock64()

David Howells <dhowells@redhat.com>
    vfs: Undo an overly zealous MS_RDONLY -> SB_RDONLY conversion

dann frazier <dann.frazier@canonical.com>
    net: hns: Avoid action name truncation

Jiang Biao <jiang.biao2@zte.com.cn>
    blkcg: init root blkcg_gq under lock

Emil Velikov <emil.velikov@collabora.com>
    drm/msm: don't deref error pointer in the msm_fbdev_create error path

Stefan Agner <stefan@agner.ch>
    drm/msm/dsi: use correct enum in dsi_get_cmd_fmt

Ben Hutchings <ben.hutchings@codethink.co.uk>
    drm/msm: Fix possible null dereference on failure of get_pages()

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: msm8916-wcd-analog: use threaded context for mbhc events

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: fix out-of-bounds in nft_chain_commit_update

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: NAT chain and extensions require NF_TABLES

Ming Lei <ming.lei@redhat.com>
    scsi: target: fix crash with iscsi target and dvd

Vinson Lee <vlee@freedesktop.org>
    scsi: megaraid_sas: Do not log an error if FW successfully initializes.

Chris Leech <cleech@redhat.com>
    scsi: iscsi: respond to netlink with unicast when appropriate

Tung Nguyen <tung.q.nguyen@dektech.com.au>
    tipc: fix infinite loop when dumping link monitor summary

Jiang Biao <jiang.biao2@zte.com.cn>
    blkcg: don't hold blkcg lock when deactivating policy

sxauwsk <sxauwsk@163.com>
    spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()

Liam Girdwood <liam.r.girdwood@linux.intel.com>
    ASoC: topology: Check widget kcontrols before deref.

Simon Gaiser <simon@invisiblethingslab.com>
    xen: xenbus_dev_frontend: Really return response string

Yan Wang <yan.wang@linux.intel.com>
    ASoC: topology: Fix bugs of freeing soc topology

Loic Poulain <loic.poulain@linaro.org>
    PCI: kirin: Fix reset gpio name

Geert Uytterhoeven <geert@linux-m68k.org>
    soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure

Florian Fainelli <f.fainelli@gmail.com>
    soc: bcm: raspberrypi-power: Fix use of __packed

Tyler Hicks <tyhicks@canonical.com>
    eCryptfs: don't pass up plaintext names when using filename encryption

oder_chiou@realtek.com <oder_chiou@realtek.com>
    ASoC: rt5514: Add the missing register in the readable table

Jerome Brunet <jbrunet@baylibre.com>
    clk: honor CLK_MUX_ROUND_CLOSEST in generic clk mux

Jacopo Mondi <jacopo+renesas@jmondi.org>
    dt-bindings: dmaengine: rcar-dmac: document R8A77965 support

Jacopo Mondi <jacopo+renesas@jmondi.org>
    dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF

Matheus Castello <matheus@castello.eng.br>
    dt-bindings: pinctrl: sunxi: Fix reference to driver

Lukasz Majewski <lukma@denx.de>
    doc: Add vendor prefix for Kieback & Peter GmbH

Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    spi: sh-msiof: Fix bit field overflow writes to TSCR/RSCR

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: dts: Boston: Fix PCI bus dtc warnings:

Chengguang Xu <cgxu519@gmx.com>
    isofs: fix potential memory leak in mount option parsing

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/smsgiucv: disable SMSG on module unload

Sinan Kaya <okaya@codeaurora.org>
    MIPS: io: Add barrier after register read in readX()

Amir Goldstein <amir73il@gmail.com>
    fsnotify: fix ignore mask logic in send_to_group()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf report: Fix switching to another perf.data file

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: ignore signals when communicating with management FW

Sinan Kaya <okaya@codeaurora.org>
    MIPS: io: Prevent compiler reordering writeX()

Krish Sadhukhan <krish.sadhukhan@oracle.com>
    x86: Add check for APIC access address for vmentry of L2 guests

hu huajun <huhuajun@linux.alibaba.com>
    KVM: X86: fix incorrect reference of trace_kvm_pi_irte_update

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    Input: synaptics-rmi4 - fix an unchecked out of memory error path

Anson Huang <Anson.Huang@nxp.com>
    clocksource/drivers/imx-tpm: Correct some registers operation flow


-------------

Diffstat:

 .../bindings/display/panel/panel-common.txt        |   2 +-
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   6 +-
 .../bindings/serial/amlogic,meson-uart.txt         |   2 +-
 .../bindings/serial/renesas,sci-serial.txt         |   2 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Makefile                                           |   4 +-
 arch/arm/boot/compressed/head.S                    |  20 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
 arch/arm/boot/dts/da850.dtsi                       |   2 -
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  11 +-
 arch/arm/kernel/machine_kexec.c                    |  34 ++-
 arch/arm/mach-davinci/board-da830-evm.c            |   9 +-
 arch/arm/mach-davinci/board-da850-evm.c            |   9 +-
 arch/arm/mach-davinci/board-dm355-evm.c            |   6 +
 arch/arm/mach-davinci/board-dm646x-evm.c           |   5 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |  10 +-
 arch/arm/mach-davinci/dm646x.c                     |   3 +-
 arch/arm/mach-keystone/pm_domain.c                 |   1 +
 arch/arm/mach-omap1/ams-delta-fiq.c                |  28 +-
 arch/arm/mach-omap2/powerdomain.c                  |   4 +-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |   2 +-
 arch/arm64/include/asm/cputype.h                   |   6 +
 arch/arm64/kernel/ptrace.c                         |  20 +-
 arch/hexagon/include/asm/io.h                      |   6 +
 arch/hexagon/lib/checksum.c                        |   1 +
 arch/mips/boot/dts/img/boston.dts                  |   6 +
 arch/mips/include/asm/io.h                         |   4 +-
 arch/parisc/kernel/drivers.c                       |   7 +-
 arch/parisc/kernel/smp.c                           |   3 +-
 arch/parisc/kernel/time.c                          |   2 +-
 arch/powerpc/include/asm/ftrace.h                  |  29 ++-
 arch/powerpc/platforms/powernv/memtrace.c          |  17 --
 arch/sh/kernel/cpu/sh2/probe.c                     |   4 +
 arch/x86/events/intel/core.c                       |   9 +-
 arch/x86/include/asm/insn.h                        |  18 ++
 arch/x86/kernel/cpu/intel.c                        |   3 +
 arch/x86/kernel/kexec-bzimage64.c                  |   5 +-
 arch/x86/kernel/kprobes/core.c                     |   4 +
 arch/x86/kernel/uprobes.c                          |   4 +
 arch/x86/kvm/hyperv.c                              |   2 +-
 arch/x86/kvm/svm.c                                 |   5 +-
 arch/x86/kvm/vmx.c                                 |  15 +-
 arch/x86/kvm/x86.c                                 |  19 +-
 arch/x86/net/bpf_jit_comp.c                        |   4 +-
 arch/x86/xen/enlighten_hvm.c                       |  13 +
 block/blk-cgroup.c                                 |  22 +-
 block/blk-mq.c                                     |  19 ++
 block/blk-mq.h                                     |   4 +-
 block/genhd.c                                      |  12 +
 block/partition-generic.c                          |  10 +-
 drivers/acpi/acpi_watchdog.c                       |  59 ++++-
 drivers/acpi/sleep.c                               |  13 +
 drivers/ata/ahci.c                                 |   6 +-
 drivers/ata/ahci.h                                 |   7 +
 drivers/ata/ahci_mvebu.c                           |  56 ++++
 drivers/ata/ahci_qoriq.c                           |   2 +-
 drivers/ata/ahci_xgene.c                           |   4 +-
 drivers/ata/libahci.c                              |  20 +-
 drivers/ata/libata-eh.c                            |   4 +-
 drivers/ata/sata_highbank.c                        |   2 +-
 drivers/char/agp/uninorth-agp.c                    |   4 +-
 drivers/clk/clk-mux.c                              |  10 +-
 drivers/clk/clk.c                                  |   7 +-
 drivers/clk/imx/clk-imx6ul.c                       |   2 +-
 drivers/clocksource/timer-imx-tpm.c                |   8 +-
 drivers/firmware/efi/libstub/arm64-stub.c          |  10 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  13 +-
 drivers/gpu/drm/drm_dumb_buffers.c                 |   7 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   2 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |  11 +-
 drivers/gpu/drm/msm/msm_gem.c                      |  20 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c           |   7 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   2 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |  10 +
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |   6 +-
 drivers/gpu/drm/omapdrm/tcm-sita.c                 |   2 +-
 drivers/hid/Kconfig                                |   7 +-
 drivers/hid/hid-ids.h                              |   8 +
 drivers/hid/hid-lenovo.c                           |  36 +++
 drivers/hid/intel-ish-hid/ishtp/bus.c              |   2 +-
 drivers/hid/wacom_sys.c                            |   4 +-
 drivers/i2c/busses/i2c-pmcmsp.c                    |   4 +-
 drivers/i2c/busses/i2c-sprd.c                      |  22 +-
 drivers/i2c/busses/i2c-viperboard.c                |   2 +-
 drivers/infiniband/Kconfig                         |   5 +-
 drivers/infiniband/core/cma.c                      |  60 +++--
 drivers/infiniband/core/iwpm_util.c                |   5 +-
 drivers/infiniband/core/mad.c                      |   4 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   9 +
 drivers/infiniband/hw/hfi1/affinity.c              |  11 +-
 drivers/infiniband/hw/hfi1/init.c                  |   4 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c             |   2 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   1 -
 drivers/infiniband/sw/rxe/rxe_resp.c               |   6 +-
 drivers/infiniband/ulp/srp/Kconfig                 |   2 +-
 drivers/infiniband/ulp/srpt/Kconfig                |   2 +-
 drivers/input/rmi4/rmi_spi.c                       |   7 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           | 186 ++++++++------
 drivers/iommu/dmar.c                               |   2 +-
 drivers/net/can/dev.c                              |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   2 +
 drivers/net/ethernet/hisilicon/hns/hnae.h          |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   3 +
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c   |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |   6 +-
 drivers/net/ethernet/qlogic/qede/qede_rdma.c       |   2 +-
 drivers/net/phy/marvell.c                          |   9 +
 drivers/nvme/host/Kconfig                          |   2 +-
 drivers/nvme/host/core.c                           |   1 +
 drivers/nvme/host/fabrics.c                        |   6 +
 drivers/nvme/target/Kconfig                        |   2 +-
 drivers/pci/dwc/pcie-kirin.c                       |   2 +-
 drivers/remoteproc/qcom_q6v5_pil.c                 |   2 +
 drivers/rpmsg/rpmsg_char.c                         |   2 +
 drivers/s390/net/qeth_core_main.c                  |   2 +-
 drivers/s390/net/smsgiucv.c                        |   2 +-
 drivers/scsi/isci/port_config.c                    |   3 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   6 +-
 drivers/scsi/scsi_transport_iscsi.c                |  29 ++-
 drivers/scsi/storvsc_drv.c                         |   7 +-
 drivers/scsi/vmw_pvscsi.c                          |   2 +-
 drivers/soc/bcm/raspberrypi-power.c                |   2 +-
 drivers/spi/spi-bcm2835aux.c                       |   5 +
 drivers/spi/spi-cadence.c                          |   8 +
 drivers/spi/spi-sh-msiof.c                         |   1 +
 drivers/target/target_core_pscsi.c                 |   2 +
 drivers/tee/tee_core.c                             |  11 +
 drivers/thermal/int340x_thermal/int3403_thermal.c  |   3 +-
 drivers/usb/musb/musb_host.c                       |   5 +-
 drivers/usb/musb/musb_host.h                       |   7 +-
 drivers/usb/musb/musb_virthub.c                    |  25 +-
 drivers/usb/typec/ucsi/Makefile                    |   2 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c           |   3 +-
 fs/afs/rxrpc.c                                     |   7 +
 fs/btrfs/scrub.c                                   |  44 +++-
 fs/cifs/smb2ops.c                                  |   6 +
 fs/ecryptfs/crypto.c                               |  41 ++-
 fs/ecryptfs/file.c                                 |  21 +-
 fs/isofs/inode.c                                   |   3 +
 fs/namespace.c                                     |   2 +-
 fs/notify/fsnotify.c                               |  25 +-
 fs/ocfs2/refcounttree.c                            |  14 +-
 fs/proc/base.c                                     |   6 +
 fs/proc/kcore.c                                    |  23 +-
 fs/proc/task_mmu.c                                 |   6 +-
 include/linux/clk-provider.h                       |   3 +
 include/linux/ethtool.h                            |   2 +
 include/linux/genhd.h                              |   4 +-
 include/linux/kvm_host.h                           |   8 +-
 include/linux/mtd/map.h                            |   2 +-
 include/linux/percpu-rwsem.h                       |   6 +-
 include/linux/rwsem.h                              |   6 +
 include/linux/sched.h                              |  50 +++-
 include/linux/sched/signal.h                       |   2 +-
 include/linux/stringhash.h                         |   4 +-
 include/soc/bcm2835/raspberrypi-firmware.h         |   4 +-
 init/main.c                                        |   7 +
 kernel/kthread.c                                   |   7 +-
 kernel/locking/rwsem-xadd.c                        |  19 +-
 kernel/locking/rwsem.c                             |   2 -
 kernel/locking/rwsem.h                             |  30 ++-
 kernel/module.c                                    |   5 +
 kernel/sched/core.c                                |  17 +-
 kernel/sched/deadline.c                            |   4 +-
 kernel/sched/rt.c                                  |   2 -
 kernel/sched/sched.h                               |   5 +-
 kernel/signal.c                                    |  17 +-
 kernel/stop_machine.c                              |  19 +-
 mm/memcontrol.c                                    |   2 +-
 net/ipv4/tcp_input.c                               |   2 +-
 net/ipv6/netfilter/Kconfig                         |  55 ++--
 net/mac80211/agg-tx.c                              |   4 +
 net/mac80211/mlme.c                                |  25 +-
 net/mac80211/tx.c                                  |   3 +-
 net/netfilter/nf_tables_api.c                      |   2 +-
 net/rds/ib_cm.c                                    |   3 +-
 net/rxrpc/af_rxrpc.c                               |   2 +-
 net/rxrpc/local_object.c                           |  57 +++--
 net/sched/act_skbedit.c                            |   3 +-
 net/smc/af_smc.c                                   |   6 +-
 net/tipc/monitor.c                                 |   2 +-
 net/tipc/node.c                                    |  28 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |   9 +-
 sound/soc/codecs/rt5514.c                          |   3 +
 sound/soc/soc-topology.c                           |   6 +-
 tools/net/bpf_dbg.c                                |   7 +-
 tools/objtool/arch/x86/include/asm/insn.h          |  18 ++
 tools/perf/util/symbol.c                           |   8 +-
 .../inter-event/trigger-multi-actions-accept.tc    |  44 ++++
 tools/testing/selftests/x86/Makefile               |   2 +-
 tools/testing/selftests/x86/mov_ss_trap.c          | 285 +++++++++++++++++++++
 tools/testing/selftests/x86/mpx-mini-test.c        |   7 +-
 tools/testing/selftests/x86/protection_keys.c      | 254 ++++++++++++------
 virt/kvm/arm/vgic/vgic-mmio-v2.c                   |   5 +
 196 files changed, 1886 insertions(+), 674 deletions(-)


