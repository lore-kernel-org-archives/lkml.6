Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F62C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE1C214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE1C214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeHWLqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:46:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHWLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:46:46 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC90AC7B;
        Thu, 23 Aug 2018 08:18:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/217] 4.14.67-stable review
Date:   Thu, 23 Aug 2018 09:51:53 +0200
Message-Id: <20180823075505.090246914@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.67-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.67-rc1
X-KernelTest-Deadline: 2018-08-25T07:55+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.67 release.
There are 217 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Aug 25 07:54:25 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.67-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.67-rc1

Jann Horn <jannh@google.com>
    reiserfs: fix broken xattr handling (heap corruption, bad retval)

Esben Haabendal <eha@deif.com>
    i2c: imx: Fix race condition in dma read

Hans de Goede <hdegoede@redhat.com>
    i2c: core: ACPI: Properly set status byte to 0 for multi-byte writes

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Fix unprotected list iteration in IRQ handler

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Fix use-after-free on unplug

Myron Stowe <myron.stowe@redhat.com>
    PCI: Skip MPS logic for Virtual Functions (VFs)

Lukas Wunner <lukas@wunner.de>
    PCI: hotplug: Don't leak pci_slot on registration failure

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    PCI: OF: Fix I/O space page leak

John David Anglin <dave.anglin@bell.net>
    parisc: Remove unnecessary barriers from spinlock.h

Ursula Braun <ubraun@linux.ibm.com>
    net/smc: no shutdown in state SMC_LISTEN

Willem de Bruijn <willemb@google.com>
    packet: refine ring v3 block size test to hold one frame

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior state

Eric Dumazet <edumazet@google.com>
    xfrm_user: prevent leaking 2 bytes of kernel memory

John David Anglin <dave.anglin@bell.net>
    parisc: Remove ordered stores from syscall.S

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: sanity check for total valid node blocks

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: return error during fill_super

Paolo Bonzini <pbonzini@redhat.com>
    KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consumer

Roland Dreier <roland@purestorage.com>
    nvme: fix handling of metadata_len for NVME_IOCTL_IO_CMD

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch

Robin H. Johnson <robbat2@gentoo.org>
    ACPI / EC: Use ec_no_wakeup on more Thinkpad X1 Carbon 6th systems

Anson Huang <Anson.Huang@nxp.com>
    soc: imx: gpc: restrict register range for regmap access

Randy Dunlap <rdunlap@infradead.org>
    tcp: identify cryptic messages as TCP seq # bugs

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Fix log level if probe fails

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Make sure the QCA7000 reset is triggered

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Avoid packet drop during initial sync

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    PCI: versatile: Fix I/O space page leak

Peng Hao <peng.hao2@zte.com.cn>
    kvmclock: fix TSC calibration for nested guests

David Lechner <david@lechnology.com>
    net: usb: rtl8150: demote allmulti message to dev_dbg()

Alexander Sverdlin <alexander.sverdlin@nsn.com>
    octeon_mgmt: Fix MIX registers configuration on MTU setup

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: Don't use inode page cache in scrub_handle_errored_block()

John Allen <jallen@linux.ibm.com>
    ibmvnic: Fix error recovery on login failure

Randy Dunlap <rdunlap@infradead.org>
    net/ethernet/freescale/fman: fix cross-build error

Stephen Hemminger <stephen@networkplumber.org>
    hv/netvsc: fix handling of fallback to single queue mode

Dan Carpenter <dan.carpenter@oracle.com>
    drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()

Wei Yongjun <weiyongjun1@huawei.com>
    pinctrl: nsp: Fix potential NULL dereference

Dan Carpenter <dan.carpenter@oracle.com>
    pinctrl: nsp: off by ones in nsp_pinmux_enable()

Paul Cercueil <paul@crapouillou.net>
    pinctrl: ingenic: Fix inverted direction for < JZ4770

Yuchung Cheng <ycheng@google.com>
    tcp: remove DELAYED ACK events in DCTCP

Dan Carpenter <dan.carpenter@oracle.com>
    qlogic: check kstrtoul() for errors

Willem de Bruijn <willemb@google.com>
    packet: reset network header if packet shorter than ll reserved space

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: suppress warnings from 'getconf LFS_*'

Laura Abbott <labbott@redhat.com>
    tools: build: Use HOSTLDFLAGS with fixdep

Alexander Duyck <alexander.h.duyck@intel.com>
    ixgbe: Be more careful when modifying MAC filters

Adam Ford <aford173@gmail.com>
    ARM: dts: am3517.dtsi: Disable reference to OMAP3 OTG controller

Nishanth Menon <nm@ti.com>
    ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for secondary cores

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ARM: 8780/1: ftrace: Only set kernel memory back to read-only after boot

Kamal Heib <kamalheib1@gmail.com>
    RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path

Dave Jiang <dave.jiang@intel.com>
    nfit: fix unchecked dereference in acpi_nfit_ctl

Janne Huttunen <janne.huttunen@nokia.com>
    perf script python: Fix dict reference counting

Jiri Olsa <jolsa@kernel.org>
    perf tools: Fix compilation errors on gcc8

Kim Phillips <kim.phillips@arm.com>
    perf llvm-utils: Remove bashism from kernel include fetch script

Manish Rangankar <manish.rangankar@cavium.com>
    scsi: qedi: Send driver state to MFW

Saurav Kashyap <saurav.kashyap@cavium.com>
    scsi: qedf: Send the driver state to MFW

Vikas Gupta <vikas.gupta@broadcom.com>
    bnxt_en: Fix for system hang if request_irq fails

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Always set output parameters in bnxt_get_max_rings().

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix inconsistent BNXT_FLAG_AGG_RINGS logic.

Peter Zijlstra <peterz@infradead.org>
    ARC: Improve cmpxchg syscall implementation

Andrey Ryabinin <aryabinin@virtuozzo.com>
    netfilter: nf_conntrack: Fix possible possible crash on module loading.

Florian Westphal <fw@strlen.de>
    netfilter: nft_compat: explicitly reject ERROR and standard target

Russell King <rmk+kernel@armlinux.org.uk>
    drm/armada: fix irq handling

Russell King <rmk+kernel@armlinux.org.uk>
    drm/armada: fix colorkey mode property

Mikko Perttunen <mperttunen@nvidia.com>
    drm/tegra: Fix comparison operator for buffer size

Dmitry Osipenko <digetx@gmail.com>
    gpu: host1x: Check whether size of unpin isn't 0

Stefan Schmidt <stefan@datenfreihafen.org>
    ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

Stefan Schmidt <stefan@datenfreihafen.org>
    ieee802154: at86rf230: use __func__ macro for debug messages

Stefan Schmidt <stefan@datenfreihafen.org>
    ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem

Douglas Anderson <dianders@chromium.org>
    nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_tunnel_key: fix NULL dereference when 'goto chain' is used

Daniel Mack <daniel@zonque.org>
    ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    ravb: fix invalid context bug while changing link options by ethtool

Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    ravb: fix invalid context bug while calling auto-negotiation by ethtool

Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    sh_eth: fix invalid context bug while changing link options by ethtool

Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    sh_eth: fix invalid context bug while calling auto-negotiation by ethtool

Arun Kumar Neelakantam <aneela@codeaurora.org>
    net: qrtr: Broadcast messages only from control port

Paul Moore <paul@paul-moore.com>
    ipv6: make ipv6_renew_options() interrupt/kernel safe

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: set module owner for icmp(6) matches

Lubomir Rintel <lkundrak@v3.sk>
    ieee802154: 6lowpan: set IFLA_LINK

Taeung Song <treeze.taeung@gmail.com>
    samples/bpf: Check the error of write() and read()

Taeung Song <treeze.taeung@gmail.com>
    samples/bpf: Check the result of system()

Taeung Song <treeze.taeung@gmail.com>
    samples/bpf: add missing <linux/if_vlan.h>

Maciej Purski <m.purski@samsung.com>
    drm/bridge/sii8620: Fix display of packed pixel modes

Yuiko Oshino <yuiko.oshino@microchip.com>
    smsc75xx: Add workaround for gigabit link up hardware errata.

Zhen Lei <thunder.leizhen@huawei.com>
    kasan: fix shadow_size calculation error in kasan_module_alloc

Mathieu Malaterre <malat@debian.org>
    tracing: Use __printf markup to silence compiler

Mauricio Vasquez B <mauricio.vasquez@polito.it>
    bpf: hash map: decrement counter on error

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: imx_v4_v5_defconfig: Select ULPI support

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: imx_v6_v7_defconfig: Select ULPI support

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Correct touch maximum XY of 2nd-gen Intuos

Zhenzhong Duan <zhenzhong.duan@oracle.com>
    x86/mm/32: Initialize the CR4 shadow before __flush_tlb_all()

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: fix swapped emit_ib_size in vce3

Hangbin Liu <liuhangbin@gmail.com>
    ipvlan: call dev_change_flags when ipvlan mode is reset

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Support GCC 8 '-fnoreorder-functions'

Greg Ungerer <gerg@linux-m68k.org>
    m68k: fix "bad page state" oops on ColdFire boot

Stafford Horne <shorne@gmail.com>
    openrisc: entry: Fix delay slot exception detection

Dave Jiang <dave.jiang@intel.com>
    acpi/nfit: fix cmd_rc for acpi_nfit_ctl to always return a value

Madalin Bucur <madalin.bucur@nxp.com>
    dpaa_eth: DPAA SGT needs to be 256B

Madalin Bucur <madalin.bucur@nxp.com>
    fsl/fman: fix parser reporting bad checksum on short frames

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Fix receiving tx-timeout in error or recovery state.

Nicholas Mc Guire <hofrat@osadl.org>
    PCI: faraday: Add missing of_node_put()

Nicholas Mc Guire <hofrat@osadl.org>
    PCI: xilinx-nwl: Add missing of_node_put()

Nicholas Mc Guire <hofrat@osadl.org>
    PCI: xilinx: Add missing of_node_put()

Daniel Borkmann <daniel@iogearbox.net>
    bpf, s390: fix potential memleak when later bpf_jit_prog fails

Bart Van Assche <bart.vanassche@wdc.com>
    drbd: Fix drbd_request_prepare() discard handling

Marek Szyprowski <m.szyprowski@samsung.com>
    drm/exynos: decon5433: Fix WINCONx reset value

Marek Szyprowski <m.szyprowski@samsung.com>
    drm/exynos: decon5433: Fix per-plane global alpha for XRGB modes

Marek Szyprowski <m.szyprowski@samsung.com>
    drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 modes

Johannes Berg <johannes.berg@intel.com>
    nl80211: check nla_parse_nested() return values

Bob Copeland <me@bobcopeland.com>
    nl80211: relax ht operation checks for mesh

Jeff Moyer <jmoyer@redhat.com>
    dev-dax: check_vma: ratelimit dev_info-s

BingJing Chang <bingjingc@synology.com>
    md/raid10: fix that replacement cannot complete recovery after reassemble

Ryan Hsu <ryanhsu@codeaurora.org>
    ath10k: update the phymode along with bandwidth change request

Dan Carpenter <dan.carpenter@oracle.com>
    dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()

Marek Szyprowski <m.szyprowski@samsung.com>
    dmaengine: pl330: report BURST residue granularity

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    ARM64: dts: meson-gxl: fix Mali GPU compatible string

Keerthy <j-keerthy@ti.com>
    ARM: dts: da850: Fix interrups property for gpio

Andy Lutomirski <luto@kernel.org>
    selftests/x86/sigreturn: Do minor cleanups

Andy Lutomirski <luto@kernel.org>
    selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs

Chengguang Xu <cgxu519@gmx.com>
    nfp: cast sizeof() to int when comparing with error code

Eli Cohen <eli@mellanox.com>
    net/mlx5: E-Switch, Disallow vlan/spoofcheck setup if not being esw manager

Yan, Zheng <zyan@redhat.com>
    ceph: fix dentry leak in splice_dentry()

Jann Horn <jannh@google.com>
    netfilter: nf_log: fix uninit read in nf_log_proc_dostring

Adam Ford <aford173@gmail.com>
    ARM: davinci: board-da850-evm: fix WP pin polarity for MMC/SD

Jiri Olsa <jolsa@kernel.org>
    perf bench: Fix numa report output code

Yonghong Song <yhs@fb.com>
    perf tools: Fix a clang 7.0 compilation error

Sandipan Das <sandipan@linux.ibm.com>
    perf report powerpc: Fix crash if callchain is empty

Thomas Richter <tmricht@linux.ibm.com>
    perf test session topology: Fix test on s390

Thomas Richter <tmricht@linux.ibm.com>
    perf record: Support s390 random socket_id assignment

Dirk Gouders <dirk@gouders.net>
    kconfig: fix line numbers for if-entries in menu tree

Dan Carpenter <dan.carpenter@oracle.com>
    typec: tcpm: Fix a msecs vs jiffies bug

Hans de Goede <hdegoede@redhat.com>
    NFC: pn533: Fix wrong GFP flag usage

Ajay Gupta <ajaykuee@gmail.com>
    usb: xhci: increase CRS timeout value

Dongjiu Geng <gengdongjiu@huawei.com>
    usb: xhci: remove the code build warning

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix UBSAN warning at SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT ioctl

Daniel Mack <daniel@zonque.org>
    ARM: dts: am437x: make edt-ft5x06 a wakeup source

Michael Trimarchi <michael@amarulasolutions.com>
    brcmfmac: stop watchdog before detach and free everything

Tomasz Duszynski <tduszyns@gmail.com>
    iio: pressure: bmp280: fix relative humidity unit

Ganesh Goudar <ganeshgr@chelsio.com>
    cxgb4: when disabling dcb set txq dcb priority to 0

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: Fix multicast TT issues with bogus ROAM flags

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: Avoid storing non-TT-sync flags on singular entries too

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix bat_v best gw refcnt after netlink dump

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix bat_ogm_iv best gw refcnt after netlink dump

Rob Herring <robh@kernel.org>
    arm64: dts: msm8916: fix Coresight ETF graph connections

Casey Schaufler <casey@schaufler-ca.com>
    Smack: Mark inode instant in smack_task_to_inode

Hangbin Liu <liuhangbin@gmail.com>
    ipv6: mcast: fix unsolicited report interval after receiving querys

Zhenzhong Duan <zhenzhong.duan@oracle.com>
    x86/microcode/intel: Fix memleak in save_microcode_patch()

Geert Uytterhoeven <geert@linux-m68k.org>
    mtd: dataflash: Use ULL suffix for 64-bit constants

Jeffrin Jose T <ahiliation@gmail.com>
    selftests: bpf: notification about privilege required to run test_kmod.sh testing script

Steven Rostedt (VMware) <rostedt@goodmis.org>
    locking/lockdep: Do not record IRQ state within lockdep code

Maciej Purski <m.purski@samsung.com>
    drm/bridge/sii8620: fix display of packed pixel modes in MHL2

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    KVM: arm/arm64: Drop resource size check for GICV window

Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
    sctp: fix erroneous inc of snmp SctpFragUsrMsgs

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    net: davinci_emac: match the mdio device against its compatible if possible

Doron Roberts-Kedes <doronrk@fb.com>
    nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.

Alexey Brodkin <Alexey.Brodkin@synopsys.com>
    ARC: Enable machine_desc->init_per_cpu for !CONFIG_SMP

Dan Carpenter <dan.carpenter@oracle.com>
    block: sed-opal: Fix a couple off by one bugs

Max Gurtuvoy <maxg@mellanox.com>
    nvmet: reset keep alive timer in controller enable

Dinh Nguyen <dinguyen@kernel.org>
    net: stmmac: socfpga: add additional ocp reset line for Stratix10

Li RongQing <lirongqing@baidu.com>
    net: propagate dev_get_valid_name return code

Stefan Agner <stefan@agner.ch>
    net: hamradio: use eth_broadcast_addr

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: initialize enic->rfs_h.lock in enic_probe

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Do not advertise DCBX_LLD_MANAGED capability.

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Add sanity check for SIMD fastpath handler.

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Fix possible memory leak in Rx error path handling.

Zhizhou Zhang <zhizhouzhang@asrmicro.com>
    arm64: make secondary_start_kernel() notrace

Marek Szyprowski <m.szyprowski@samsung.com>
    arm64: dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag

Zhouyang Jia <jiazhouyang09@gmail.com>
    xen/scsiback: add error handling for xenbus_printf

Zhouyang Jia <jiazhouyang09@gmail.com>
    scsi: xen-scsifront: add error handling for xenbus_printf

Trond Myklebust <trond.myklebust@hammerspace.com>
    pNFS: Always free the session slot on error in nfs4_layoutget_handle_exception

Zhouyang Jia <jiazhouyang09@gmail.com>
    xen: add error handling for xenbus_printf

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    dwc2: gadget: Fix ISOC IN DDMA PID bitfield value calculation

Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>
    usb: gadget: dwc2: fix memory leak in gadget_init()

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: gadget: composite: fix delayed_status race condition when set_interface

William Wu <william.wu@rock-chips.com>
    usb: dwc2: fix isoc split in transfer with no data

William Wu <william.wu@rock-chips.com>
    usb: dwc2: alloc dma aligned buffer for isoc split in

John Garry <john.garry@huawei.com>
    libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()

Vijay Immanuel <vijayi@attalasystems.com>
    IB/rxe: Fix missing completion for mem_reg work requests

Ayan Kumar Halder <ayan.halder@arm.com>
    drm/arm/malidp: Preserve LAYER_FORMAT contents when setting format

Alison Wang <alison.wang@nxp.com>
    drm: mali-dp: Enable Global SE interrupts mask for DP500

Hoan Tran <hoan.tran@amperecomputing.com>
    drivers/perf: xgene_pmu: Fix IOB SLOW PMU parser error

Ray Jui <ray.jui@broadcom.com>
    arm64: dts: Stingray: Fix I2C controller interrupt type

Ray Jui <ray.jui@broadcom.com>
    arm64: dts: ns2: Fix PCIe controller interrupt type

Ray Jui <ray.jui@broadcom.com>
    arm64: dts: ns2: Fix I2C controller interrupt type

Scott Branden <scott.branden@broadcom.com>
    arm64: dts: specify 1.8V EMMC capabilities for bcm958742t

Scott Branden <scott.branden@broadcom.com>
    arm64: dts: specify 1.8V EMMC capabilities for bcm958742k

Ray Jui <ray.jui@broadcom.com>
    ARM: dts: Cygnus: Fix PCIe controller interrupt type

Ray Jui <ray.jui@broadcom.com>
    ARM: dts: Cygnus: Fix I2C controller interrupt type

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: BCM5301x: Fix i2c controller interrupt type

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: NSP: Fix PCIe controllers interrupt types

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: NSP: Fix i2c controller interrupt type

Fathi Boudra <fathi.boudra@linaro.org>
    selftests: sync: add config fragment for testing sync framework

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: vm: return Kselftest Skip code for skipped tests

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: zram: return Kselftest Skip code for skipped tests

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: user: return Kselftest Skip code for skipped tests

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: sysctl: return Kselftest Skip code for skipped tests

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: static_keys: return Kselftest Skip code for skipped tests

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: pstore: return Kselftest Skip code for skipped tests

Gao Feng <gfree.wind@vip.163.com>
    netfilter: nf_ct_helper: Fix possible panic after nf_conntrack_helper_unregister

Eric Dumazet <edumazet@google.com>
    netfilter: ipv6: nf_defrag: reduce struct net memory waste

Mika Westerberg <mika.westerberg@linux.intel.com>
    ACPI / EC: Use ec_no_wakeup on Thinkpad X1 Carbon 6th

Johan Hovold <johan@kernel.org>
    usb: dwc3: of-simple: fix use-after-free on remove

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: gadget: Fix issue in dwc2_gadget_start_isoc()

Vincent Pelletier <plr.vincent@gmail.com>
    usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: dwc3: pci: add support for Intel IceLake

Anson Huang <Anson.Huang@nxp.com>
    soc: imx: gpcv2: correct PGC offset

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix loop limit

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: Explicitly add -mmedium-calls to CFLAGS

Maciej Purski <m.purski@samsung.com>
    drm/bridge/sii8620: fix potential buffer overflow

Andrzej Hajda <a.hajda@samsung.com>
    drm/bridge/sii8620: fix loops in EDID fetch logic

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    IB/mlx4: Fix an error handling path in 'mlx4_ib_rereg_user_mr()'

Lucas Stach <l.stach@pengutronix.de>
    Input: synaptics-rmi4 - fix axis-swap behavior

Jiri Olsa <jolsa@kernel.org>
    perf tools: Fix error index for pmu event parser

Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
    vfio: ccw: fix error return in vfio_ccw_sch_event

Viresh Kumar <viresh.kumar@linaro.org>
    arm: dts: armada: Fix "#cooling-cells" property's name

Matthijs van Duin <matthijsvanduin@gmail.com>
    pty: fix O_CLOEXEC for TIOCGPTPEER

Takashi Iwai <tiwai@suse.de>
    EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[]

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/i915/kvmgt: Fix potential Spectre v1

Jeremy Cline <jcline@redhat.com>
    ext4: fix spectre gadget in ext4_mb_regular_allocator()


-------------

Diffstat:

 Makefile                                           |  10 +-
 arch/arc/Makefile                                  |  15 +--
 arch/arc/include/asm/mach_desc.h                   |   2 -
 arch/arc/kernel/irq.c                              |   2 +-
 arch/arc/kernel/process.c                          |  47 +++++++--
 arch/arm/boot/dts/am3517.dtsi                      |   5 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |   2 +
 arch/arm/boot/dts/armada-385-synology-ds116.dts    |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  24 ++---
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  32 +++---
 arch/arm/boot/dts/bcm5301x.dtsi                    |   2 +-
 arch/arm/boot/dts/da850.dtsi                       |   6 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |   2 +-
 arch/arm/configs/imx_v4_v5_defconfig               |   2 +
 arch/arm/configs/imx_v6_v7_defconfig               |   2 +
 arch/arm/mach-davinci/board-da850-evm.c            |   2 +-
 arch/arm/mach-omap2/omap-smp.c                     |  41 ++++++++
 arch/arm/mach-pxa/irq.c                            |   4 +-
 arch/arm/mm/init.c                                 |   9 ++
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi    |   2 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   8 +-
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |   4 +
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |   4 +
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   4 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   4 +-
 arch/arm64/kernel/smp.c                            |   2 +-
 arch/arm64/mm/dma-mapping.c                        |   9 +-
 arch/m68k/include/asm/mcf_pgalloc.h                |   4 +-
 arch/openrisc/kernel/entry.S                       |   8 +-
 arch/openrisc/kernel/head.S                        |   9 +-
 arch/openrisc/kernel/traps.c                       |   2 +-
 arch/parisc/include/asm/spinlock.h                 |   8 +-
 arch/parisc/kernel/syscall.S                       |  24 ++---
 arch/s390/net/bpf_jit_comp.c                       |   1 +
 arch/x86/kernel/cpu/microcode/intel.c              |   5 +-
 arch/x86/kernel/kvmclock.c                         |   1 +
 arch/x86/kernel/smpboot.c                          |   5 +
 block/sed-opal.c                                   |   4 +-
 drivers/acpi/ec.c                                  |  20 ++++
 drivers/acpi/nfit/core.c                           |   4 +
 drivers/ata/libahci.c                              |   7 +-
 drivers/block/drbd/drbd_req.c                      |   4 +-
 drivers/block/nbd.c                                |  40 ++++++--
 drivers/dax/device.c                               |  12 ++-
 drivers/dma/k3dma.c                                |   2 +-
 drivers/dma/pl330.c                                |   2 +-
 drivers/edac/edac_mc.c                             |   1 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   4 +-
 drivers/gpu/drm/arm/malidp_hw.c                    |   3 +-
 drivers/gpu/drm/arm/malidp_planes.c                |   5 +-
 drivers/gpu/drm/armada/armada_crtc.c               |  12 ++-
 drivers/gpu/drm/armada/armada_hw.h                 |   1 +
 drivers/gpu/drm/armada/armada_overlay.c            |  30 ++++--
 drivers/gpu/drm/bridge/sil-sii8620.c               |  41 +++++---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   6 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |  29 ++++--
 drivers/gpu/drm/exynos/regs-gsc.h                  |   1 +
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |   9 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   4 +-
 drivers/gpu/drm/tegra/drm.c                        |   2 +-
 drivers/gpu/host1x/job.c                           |   3 +-
 drivers/hid/wacom_wac.c                            |  10 +-
 drivers/hwmon/nct6775.c                            |   2 +-
 drivers/i2c/busses/i2c-imx.c                       |   8 +-
 drivers/i2c/i2c-core-acpi.c                        |  11 +-
 drivers/iio/pressure/bmp280-core.c                 |   5 +-
 drivers/infiniband/hw/mlx4/mr.c                    |   7 +-
 drivers/infiniband/hw/mlx5/srq.c                   |  18 ++--
 drivers/infiniband/sw/rxe/rxe_req.c                |   3 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |  34 +++----
 drivers/md/raid10.c                                |   7 ++
 drivers/mtd/devices/mtd_dataflash.c                |   4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   6 ++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   6 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  13 ++-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |  14 ++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   2 +-
 drivers/net/ethernet/cisco/enic/enic_clsf.c        |   3 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |   3 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |  15 +--
 drivers/net/ethernet/freescale/fman/fman_port.c    |   8 ++
 drivers/net/ethernet/ibm/ibmvnic.c                 |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |  12 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  12 +--
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   2 -
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nffw.c  |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c         |  11 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  11 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |  12 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |   2 +
 drivers/net/ethernet/qualcomm/qca_spi.c            |  21 ++--
 drivers/net/ethernet/renesas/ravb_main.c           |  56 +++--------
 drivers/net/ethernet/renesas/sh_eth.c              |  59 +++--------
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  18 +++-
 drivers/net/ethernet/ti/davinci_emac.c             |   4 +
 drivers/net/hamradio/bpqether.c                    |   8 +-
 drivers/net/hyperv/rndis_filter.c                  |   1 +
 drivers/net/ieee802154/at86rf230.c                 |  15 +--
 drivers/net/ieee802154/fakelb.c                    |   2 +-
 drivers/net/ipvlan/ipvlan_main.c                   |  36 +++++--
 drivers/net/usb/rtl8150.c                          |   2 +-
 drivers/net/usb/smsc75xx.c                         |  62 ++++++++++++
 drivers/net/wireless/ath/ath10k/mac.c              |  16 ++-
 drivers/net/wireless/ath/ath10k/wmi.h              |   1 +
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   7 ++
 drivers/nfc/pn533/usb.c                            |   4 +-
 drivers/nvme/host/core.c                           |   2 +-
 drivers/nvme/target/core.c                         |   8 ++
 drivers/nvmem/core.c                               |   4 +
 drivers/pci/host/pci-ftpci100.c                    |   2 +
 drivers/pci/host/pci-versatile.c                   |   2 +-
 drivers/pci/host/pcie-xilinx-nwl.c                 |   2 +-
 drivers/pci/host/pcie-xilinx.c                     |   1 +
 drivers/pci/hotplug/pci_hotplug_core.c             |   9 ++
 drivers/pci/hotplug/pciehp.h                       |   1 +
 drivers/pci/hotplug/pciehp_core.c                  |   7 ++
 drivers/pci/hotplug/pciehp_hpc.c                   |  18 +---
 drivers/pci/pci.c                                  |  38 +++++++
 drivers/pci/probe.c                                |   4 +
 drivers/perf/xgene_pmu.c                           |   2 +-
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c              |   6 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |   2 +-
 drivers/s390/cio/vfio_ccw_drv.c                    |   5 +-
 drivers/scsi/qedf/qedf_main.c                      |  12 +++
 drivers/scsi/qedi/qedi_main.c                      |  11 ++
 drivers/scsi/xen-scsifront.c                       |  33 ++++--
 drivers/soc/imx/gpc.c                              |  21 ++++
 drivers/soc/imx/gpcv2.c                            |  13 ++-
 drivers/staging/typec/tcpm.c                       |   3 +-
 drivers/tty/pty.c                                  |   2 +-
 drivers/usb/dwc2/core.h                            |   3 +
 drivers/usb/dwc2/gadget.c                          |  15 ++-
 drivers/usb/dwc2/hcd.c                             |  89 ++++++++++++++++-
 drivers/usb/dwc2/hcd.h                             |   8 ++
 drivers/usb/dwc2/hcd_intr.c                        |  11 +-
 drivers/usb/dwc2/hcd_queue.c                       |   3 +
 drivers/usb/dwc3/dwc3-of-simple.c                  |   3 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   2 +
 drivers/usb/gadget/composite.c                     |   3 +
 drivers/usb/gadget/function/f_fs.c                 |  26 +++--
 drivers/usb/host/xhci-tegra.c                      |   2 +-
 drivers/usb/host/xhci.c                            |   7 +-
 drivers/xen/manage.c                               |  18 +++-
 drivers/xen/xen-scsiback.c                         |  16 ++-
 fs/btrfs/scrub.c                                   |  17 ++--
 fs/ceph/inode.c                                    |   1 +
 fs/ext4/mballoc.c                                  |   4 +-
 fs/f2fs/segment.c                                  |  32 +++++-
 fs/f2fs/segment.h                                  |  22 +++-
 fs/nfs/nfs4proc.c                                  |  17 ++--
 fs/reiserfs/xattr.c                                |   4 +-
 include/linux/fsl/guts.h                           |   1 +
 include/linux/pci.h                                |   2 +
 include/net/ipv6.h                                 |   9 +-
 include/net/net_namespace.h                        |   1 +
 include/net/netns/ipv6.h                           |   1 -
 include/net/tc_act/tc_tunnel_key.h                 |   1 -
 include/net/tcp.h                                  |   2 -
 include/uapi/linux/nbd.h                           |   3 +
 kernel/bpf/hashtab.c                               |  16 ++-
 kernel/locking/lockdep.c                           |  12 +--
 kernel/trace/trace.c                               |   5 +
 mm/kasan/kasan.c                                   |   5 +-
 net/batman-adv/bat_iv_ogm.c                        |   4 +-
 net/batman-adv/bat_v.c                             |   4 +-
 net/batman-adv/translation-table.c                 |   7 +-
 net/core/dev.c                                     |   4 +-
 net/ieee802154/6lowpan/core.c                      |   6 ++
 net/ipv4/netfilter/ip_tables.c                     |   1 +
 net/ipv4/tcp.c                                     |   4 +-
 net/ipv4/tcp_dctcp.c                               |  25 -----
 net/ipv4/tcp_output.c                              |   4 -
 net/ipv6/calipso.c                                 |   9 +-
 net/ipv6/exthdrs.c                                 | 111 ++++++---------------
 net/ipv6/ipv6_sockglue.c                           |  27 +++--
 net/ipv6/mcast.c                                   |   9 +-
 net/ipv6/netfilter/ip6_tables.c                    |   1 +
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   6 +-
 net/netfilter/nf_conntrack_core.c                  |   2 +-
 net/netfilter/nf_conntrack_helper.c                |   5 +
 net/netfilter/nf_conntrack_proto_dccp.c            |   8 +-
 net/netfilter/nf_log.c                             |   4 +
 net/netfilter/nft_compat.c                         |  13 +++
 net/packet/af_packet.c                             |  12 ++-
 net/qrtr/qrtr.c                                    |   4 +
 net/sched/act_tunnel_key.c                         |   6 +-
 net/sctp/chunk.c                                   |   4 +-
 net/smc/af_smc.c                                   |   3 +-
 net/wireless/nl80211.c                             |  35 +++----
 net/xfrm/xfrm_user.c                               |   8 +-
 samples/bpf/parse_varlen.c                         |   6 +-
 samples/bpf/test_overhead_user.c                   |  19 +++-
 samples/bpf/trace_event_user.c                     |  27 ++++-
 scripts/kconfig/zconf.y                            |   4 +-
 security/smack/smack_lsm.c                         |   1 +
 sound/core/seq/seq_clientmgr.c                     |   3 +-
 tools/build/Makefile                               |   2 +-
 tools/objtool/elf.c                                |  41 +++++---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |   2 +-
 tools/perf/arch/x86/util/perf_regs.c               |   2 +-
 tools/perf/bench/numa.c                            |   5 +-
 tools/perf/jvmti/jvmti_agent.c                     |   3 +-
 tools/perf/tests/topology.c                        |   1 +
 tools/perf/util/c++/clang.cpp                      |  11 +-
 tools/perf/util/header.c                           |  10 +-
 tools/perf/util/llvm-utils.c                       |   6 +-
 tools/perf/util/parse-events.y                     |   5 +
 .../util/scripting-engines/trace-event-python.c    |   8 +-
 tools/testing/selftests/bpf/test_kmod.sh           |   9 ++
 .../selftests/pstore/pstore_post_reboot_tests      |   5 +-
 .../selftests/static_keys/test_static_keys.sh      |  13 +++
 tools/testing/selftests/sync/config                |   4 +
 tools/testing/selftests/sysctl/sysctl.sh           |  20 ++--
 tools/testing/selftests/user/test_user_copy.sh     |   7 ++
 tools/testing/selftests/vm/compaction_test.c       |   4 +-
 tools/testing/selftests/vm/mlock2-tests.c          |  12 ++-
 tools/testing/selftests/vm/run_vmtests             |   5 +-
 tools/testing/selftests/vm/userfaultfd.c           |   4 +-
 tools/testing/selftests/x86/sigreturn.c            |  59 ++++++-----
 tools/testing/selftests/zram/zram.sh               |   5 +-
 tools/testing/selftests/zram/zram_lib.sh           |   5 +-
 virt/kvm/arm/vgic/vgic-v3.c                        |   5 -
 virt/kvm/eventfd.c                                 |  11 +-
 225 files changed, 1564 insertions(+), 778 deletions(-)


