Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E527DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6EC205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6EC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407766AbeHATUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:20:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407979AbeHATSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF566EFC;
        Wed,  1 Aug 2018 16:55:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 000/336] 4.17.12-stable review
Date:   Wed,  1 Aug 2018 18:45:35 +0200
Message-Id: <20180801165028.930831994@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.12-rc1
X-KernelTest-Deadline: 2018-08-03T16:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.12 release.
There are 336 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Aug  3 16:49:21 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.12-rc1

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: AML Parser: ignore control method status in module-level code

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation

Lawrence Brakmo <brakmo@fb.com>
    tcp: ack immediately when a cwr packet arrives

Eric Dumazet <edumazet@google.com>
    tcp: add one more quick ack after after ECN events

Yousuk Seung <ysseung@google.com>
    tcp: refactor tcp_ecn_check_ce to remove sk type cast

Eric Dumazet <edumazet@google.com>
    tcp: do not aggressively quick ack after ECN events

Eric Dumazet <edumazet@google.com>
    tcp: add max_quickacks param to tcp_incr_quickack and tcp_enter_quickack_mode

Eric Dumazet <edumazet@google.com>
    tcp: do not force quickack when receiving out-of-order packets

Dmitry Safonov <dima@arista.com>
    netlink: Don't shift with UB on nlk->ngroups

Dmitry Safonov <dima@arista.com>
    netlink: Do not subscribe to non-existent groups

Tariq Toukan <tariqt@mellanox.com>
    net: rollback orig value on failure of dev_qdisc_change_tx_queue_len

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: Added missing break in ndo_udp_tunnel_{add/del}

Xiao Liang <xiliang@redhat.com>
    xen-netfront: wait xenbus state change when load module manually

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Fix incosistent received bytes counter

Neal Cardwell <ncardwell@google.com>
    tcp_bbr: fix bw probing to raise in-flight data for very small BDPs

Avinash Repaka <avinash.repaka@oracle.com>
    RDS: RDMA: Fix the NULL-ptr deref in rds_ib_get_mr

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    NET: stmmac: align DMA stuff to largest cache line length

Anton Vasilyev <vasilyev@ispras.ru>
    net: mdio-mux: bcm-iproc: fix wrong getter and setter pair

Stefan Wahren <stefan.wahren@i2se.com>
    net: lan78xx: fix rx handling before first packet is send

tangpengpeng <tangpengpeng@higon.com>
    net: fix amd-xgbe flow-control issue

Gal Pressman <pressmangal@gmail.com>
    net: ena: Fix use of uninitialized DMA address bits field

Jakub Kicinski <jakub.kicinski@netronome.com>
    netdevsim: don't leak devlink resources

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv4: remove BUG_ON() from fib_compute_spec_dst

Michal Vokáč <vokac.m@gmail.com>
    net: dsa: qca8k: Allow overwriting CPU port setting

Michal Vokáč <vokac.m@gmail.com>
    net: dsa: qca8k: Add QCA8334 binding documentation

Michal Vokáč <vokac.m@gmail.com>
    net: dsa: qca8k: Enable RXMAC when bringing up a port

Michal Vokáč <vokac.m@gmail.com>
    net: dsa: qca8k: Force CPU port to its highest bandwidth

Leon Romanovsky <leon@kernel.org>
    RDMA/uverbs: Protect from attempts to create flows on unsupported QP

Masahiro Yamada <yamada.masahiro@socionext.com>
    gpio: uniphier: set legitimate irq trigger type in .to_irq hook

Linus Walleij <linus.walleij@linaro.org>
    gpio: of: Handle fixed regulator flags properly

Theodore Ts'o <tytso@mit.edu>
    ext4: fix check to prevent initializing reserved inodes

Theodore Ts'o <tytso@mit.edu>
    ext4: check for allocation block validity with block group locked

Theodore Ts'o <tytso@mit.edu>
    ext4: fix inline data updates with checksums enabled

Theodore Ts'o <tytso@mit.edu>
    ext4: fix false negatives *and* false positives in ext4_check_descriptors()

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: be more careful about metadata corruption

Theodore Ts'o <tytso@mit.edu>
    random: mix rdrand with entropy sent in from userspace

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: handle RXDMA HW behaviour on Gen3

James Smart <jsmart2021@gmail.com>
    nvmet-fc: fix target sgl list on large transfers

Greg Edwards <gedwards@ddn.com>
    block: reset bi_iter.bi_done after splitting bio

Martin Wilck <mwilck@suse.com>
    blkdev: __blkdev_direct_IO_simple: fix leak in error case

Martin Wilck <mwilck@suse.com>
    block: bio_iov_iter_get_pages: fix size of last iovec

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Avoid reclaim while holding locks taken in MMU notifier

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    drm/dp/mst: Fix off-by-one typo when dump payload table

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/atomic-helper: Drop plane->fb references only for drm_atomic_helper_shutdown()

José Roberto de Souza <jose.souza@intel.com>
    drm: Add DP PSR2 sink enable bit

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: dts: imx6qdl-wandboard: Let the codec control MCLK pinctrl

Kirill Marinushkin <k.marinushkin@gmail.com>
    ASoC: topology: Add missing clock gating parameter when parsing hw_configs

Kirill Marinushkin <k.marinushkin@gmail.com>
    ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()

Masahisa KOJIMA <masahisa.kojima@linaro.org>
    net: socionext: reset hardware in ndo_stop

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: si470x: fix __be16 annotations

Hans Verkuil <hverkuil@xs4all.nl>
    media: cec: fix smatch error

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: atomisp: compat32: fix __user annotations

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR

Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
    scsi: cxlflash: Avoid clobbering context control register value

Uma Krishnan <ukrishn@linux.vnet.ibm.com>
    scsi: cxlflash: Synchronize reset and remove ops

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Increase timeout by 1 sec for non-RAID fastpath IOs

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: scsi_dh: replace too broad "TP9" string with the exact models

Philippe CORNU <philippe.cornu@st.com>
    drm/stm: ltdc: fix warning in ltdc_crtc_update_clut()

Thomas Hebb <tommyhebb@gmail.com>
    ath10k: search all IEs for variant before falling back

Douglas Anderson <dianders@chromium.org>
    regulator: Don't return or expect -errno from of_map_mode()

Suman Anna <s-anna@ti.com>
    media: omap3isp: fix unbalanced dma_iommu_mapping

Sean Young <sean@mess.org>
    media: rc: mce_kbd decoder: low timeout values cause double keydowns

Arnd Bergmann <arnd@arndb.de>
    y2038: ipc: Use ktime_get_real_seconds consistently

Tudor-Dan Ambarus <tudor.ambarus@microchip.com>
    crypto: authenc - don't leak pointers to authenc keys

Tudor-Dan Ambarus <tudor.ambarus@microchip.com>
    crypto: authencesn - don't leak pointers to authenc keys

Dominik Bozek <dominikx.bozek@intel.com>
    usb: hub: Don't wait for connect state at resume for powered-off ports

Michal Simek <michal.simek@xilinx.com>
    microblaze: Fix simpleImage format generation

Andrey Smirnov <andrew.smirnov@gmail.com>
    soc: imx: gpcv2: Do not pass static memory as platform data

Douglas Anderson <dianders@chromium.org>
    serial: core: Make sure compiler barfs for 16-byte earlycon names

Sergio Paracuellos <sergio.paracuellos@gmail.com>
    staging: ks7010: fix error handling in ks7010_upload_firmware

NeilBrown <neilb@suse.com>
    staging: lustre: ldlm: free resource when ldlm_lock_create() fails.

James Simmons <jsimmons@infradead.org>
    staging: lustre: llite: correct removexattr detection

Stefan Wahren <stefan.wahren@i2se.com>
    staging: vchiq_core: Fix missing semaphore release in error case

Mario Limonciello <mario.limonciello@dell.com>
    platform/x86: dell-smbios: Match on www.dell.com in OEM strings too

Tomasz Figa <tfiga@chromium.org>
    drm/rockchip: analogix_dp: Do not call Analogix code before bind

Ondrej Mosnáček <omosnace@redhat.com>
    audit: allow not equal op for audit by executable

Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
    rsi: fix nommu_map_sg overflow kernel panic

Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
    rsi: Fix 'invalid vdd' warning in mmc

Chris Novakovic <chris@chrisn.me.uk>
    ipconfig: Correctly initialise ic_nameservers

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    drm/gma500: fix psb_intel_lvds_mode_valid()'s return type

Gustavo A. R. Silva <gustavo@embeddedor.com>
    qtnfmac: pearl: pcie: fix memory leak in qtnf_fw_work_handler

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igb: Fix queue selection on MAC filters on i210

Charles Keepax <ckeepax@opensource.cirrus.com>
    ASoC: compress: Only call free for components which have been opened

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    arm64: defconfig: Enable Rockchip io-domain driver

Fabio Estevam <fabio.estevam@nxp.com>
    ASoC: fsl_ssi: Use u32 variable type when using regmap_read()

Wei Xu <wxu@cnexlabs.com>
    nvme: lightnvm: add granby support

Dmitry Osipenko <digetx@gmail.com>
    memory: tegra: Apply interrupts mask per SoC

Dmitry Osipenko <digetx@gmail.com>
    memory: tegra: Do not handle spurious interrupts

Tamizh Chelvam <tamizhr@codeaurora.org>
    ath10k: fix kernel panic while reading tpc_stats

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    delayacct: Use raw_spinlocks

Thomas Gleixner <tglx@linutronix.de>
    stop_machine: Use raw spinlocks

Wolfram Sang <wsa+renesas@sang-engineering.com>
    backlight: pwm_bl: Don't use GPIOF_* with gpiod_get_direction

Felix Fietkau <nbd@nbd.name>
    mt76: add rcu locking around tx scheduling

Jacob Keller <jacob.e.keller@intel.com>
    i40e: avoid overflow in i40e_ptp_adjfreq()

Jakub Pawlak <jakub.pawlak@intel.com>
    i40e: Add advertising 10G LR mode

Kirill Tkhai <ktkhai@virtuozzo.com>
    fasync: Fix deadlock between task-context and interrupt-context kill_fasync()

Yixun Lan <yixun.lan@amlogic.com>
    dt-bindings: net: meson-dwmac: new compatible name for AXG SoC

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: Fixes the out of bounds access in hclge_map_tqp

Alexey Khoroshilov <khoroshilov@ispras.ru>
    spi: meson-spicc: Fix error handling in meson_spicc_probe()

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    dt-bindings: pinctrl: meson: add support for the Meson8m2 SoC

Tobin C. Harding <me@tobin.cc>
    mmc: pwrseq: Use kmalloc_array instead of stack VLA

Shawn Lin <shawn.lin@rock-chips.com>
    mmc: dw_mmc: update actual clock for mmc debugfs

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: hda/ca0132: fix build failure when a local macro is defined

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_router: Return an error for non-default FIB rules

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: check cap_resource only for data blocks

Kishon Vijay Abraham I <kishon@ti.com>
    mmc: sdhci-omap: Fix when capabilities are obtained from SDHCI_CAPABILITIES reg

Satendra Singh Thakur <satendra.t@samsung.com>
    drm/atomic: Handling the case when setting old crtc for plane

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x2: fix avg_rssi estimation

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: siano: get rid of __le32/__le16 cast warnings

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: em28xx: fix a regression with HVR-950

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: avoid fsync() failure caused by EAGAIN in writepage()

Jakub Kicinski <jakub.kicinski@netronome.com>
    bpf: fix references to free_bpf_prog_info() in comments

Changbin Du <changbin.du@intel.com>
    regulator: add dummy function of_find_regulator_by_node

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    thermal: exynos: fix setting rising_threshold for Exynos5433

Doug Oucharek <dougso@me.com>
    staging: lustre: o2iblnd: Fix FastReg map/unmap for MLX5

Doug Oucahrek <dougso@me.com>
    staging: lustre: o2iblnd: fix race at kiblnd_connect_peer

Takashi Iwai <tiwai@suse.de>
    dma-direct: try reallocation with GFP_DMA32 if possible

Chad Dupuis <chad.dupuis@cavium.com>
    scsi: qedf: Set the UNLOADING flag when removing a vport

Viresh Kumar <viresh.kumar@linaro.org>
    soc/tegra: pmc: Don't allocate struct tegra_powergate on stack

Xiang Chen <chenxiang66@hisilicon.com>
    scsi: hisi_sas: config ATA de-reset as an constrained command for v3 hw

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: megaraid: silence a static checker bug

Wenwen Wang <wang6495@umn.edu>
    scsi: 3w-xxxx: fix a missing-check bug

Wenwen Wang <wang6495@umn.edu>
    scsi: 3w-9xxx: fix a missing-check bug

Christian Gromm <christian.gromm@microchip.com>
    staging: most: cdev: fix chrdev_region leak

Ram Pai <linuxram@us.ibm.com>
    mm, powerpc, x86: define VM_PKEY_BITx bits if CONFIG_ARCH_HAS_PKEYS is enabled

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Always forward VF MAC address to the PF.

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Check unsupported speeds in bnxt_update_link() on PF only.

Antoine Tenart <antoine.tenart@bootlin.com>
    net: phy: sfp: handle cases where neither BR, min nor BR, max is given

Thomas Richter <tmricht@linux.ibm.com>
    perf: fix invalid bit in diagnostic entry

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpum_sf: Add data entry sizes to sampling trailer entry

Sean Lanigan <sean@lano.id.au>
    brcmfmac: Add support for bcm43364 wireless chipset

Jane Wan <Jane.Wan@nokia.com>
    mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter pages

Brad Love <brad@nextdimension.cc>
    media: em28xx: Fix DualHD broken second tuner

Jacopo Mondi <jacopo+renesas@jmondi.org>
    media: renesas-ceu: Set mbus_fmt on subdev operations

Brad Love <brad@nextdimension.cc>
    media: saa7164: Fix driver name in debug output

Sami Tolvanen <samitolvanen@google.com>
    media: media-device: fix ioctl function types

Hans de Goede <hdegoede@redhat.com>
    ACPI / LPSS: Only call pwm_add_table() for Bay Trail PWM if PMIC HRV is 2

Damien Le Moal <damien.lemoal@wdc.com>
    libata: Fix command retry decision

Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    media: rcar_jpu: Add missing clk_disable_unprepare() on error in jpu_open()

Florian Fainelli <f.fainelli@gmail.com>
    net: phy: phylink: Release link GPIO

Marc Zyngier <marc.zyngier@arm.com>
    dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA

DaeRyong Jeong <threeearcat@gmail.com>
    tty: Fix data race in tty_insert_flip_string_fixed_flag

Jacob Keller <jacob.e.keller@intel.com>
    i40e: free the skb after clearing the bitlock

Rob Herring <robh@kernel.org>
    ARM: dts: imx53: Fix LDB OF graph warning

Mathieu Malaterre <malat@debian.org>
    nvmem: properly handle returned value nvmem_reg_read

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: sh73a0: Add missing interrupt-affinity to PMU node

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: emev2: Add missing interrupt-affinity to PMU node

Patrice Chotard <patrice.chotard@st.com>
    ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage

Patrice Chotard <patrice.chotard@st.com>
    ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage

Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>
    rsi: Add null check for virtual interfaces in wowlan config

Thor Thayer <thor.thayer@linux.intel.com>
    EDAC, altera: Fix ARM64 build warning

Dmitry Torokhov <dtor@chromium.org>
    HID: i2c-hid: check if device is there before really probing

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled by Starlet

Ben Hutchings <ben@decadent.org.uk>
    IB: Fix RDMA_RXE and INFINIBAND_RDMAVT dependencies for DMA_VIRT_OPS

Leo (Sunpeng) Li <sunpeng.li@amd.com>
    drm/amd/display: Fix dim display on DCE11

Samuel Li <Samuel.Li@amd.com>
    drm/amdgpu: Remove VRAM from shared bo domains.

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    drm/radeon: fix mode_valid's return type

Shirish S <shirish.s@amd.com>
    drm/amd/display: remove need of modeset flag for overlay planes (V2)

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    arm64: dts: renesas: salvator-common: use audio-graph-card for Sound

Terry Junge <terry.junge@plantronics.com>
    HID: hid-plantronics: Re-resend Update to map button for PTT products

Will Deacon <will.deacon@arm.com>
    arm64: cmpwait: Clear event register before arming exclusive monitor

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: staging: atomisp: Comment out several unused sensor resolutions

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: atomisp: ov2680: don't declare unused vars

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix for fiber link up problem

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Apply rate limit to warning messages in URB complete callback

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw-phy-sel: check bus_find_device() ret value

Mathieu Malaterre <malat@debian.org>
    clocksource: Move inline keyword to the beginning of function declarations

Oza Pawandeep <poza@codeaurora.org>
    PCI/DPC: Clear interrupt status in interrupt handler top half

Colin Ian King <colin.king@canonical.com>
    media: smiapp: fix timeout checking in smiapp_read_nvm

Thierry Reding <treding@nvidia.com>
    gpu: host1x: Acquire a reference to the IOVA cache

Emil Tantilov <emil.s.tantilov@intel.com>
    ixgbevf: fix MAC address changes through ixgbevf_set_mac()

Yufen Yu <yuyufen@huawei.com>
    md: fix NULL dereference of mddev->pers in remove_and_add_spares()

Gioh Kim <gi-oh.kim@profitbricks.com>
    md/raid1: add error handling of read error from FailFast device

Anson Huang <Anson.Huang@nxp.com>
    regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

Takashi Iwai <tiwai@suse.de>
    ALSA: emu10k1: Rate-limit error messages about page errors

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: tps65910: fix possible race condition

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: vr41xx: fix possible race condition

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: tps6586x: fix possible race condition

Vic Wei <vwei@codeaurora.org>
    Bluetooth: btusb: add ID for LiteOn 04ca:301a

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/fifo/gk104-: poll for runlist update completion

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/gem: lookup VMAs for buffers referenced by pushbuf ioctl

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau: remove fence wait code from deferred client work handler

Jens Remus <jremus@linux.ibm.com>
    scsi: zfcp: assert that the ERP lock is held when tracing a recovery trigger

Maya Erez <merez@codeaurora.org>
    scsi: ufs: fix exception event handling

Subhash Jadavani <subhashj@codeaurora.org>
    scsi: ufs: ufshcd: fix possible unclocked register access

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: mvpp2: Add missing VLAN tag detection

Eric Biggers <ebiggers@google.com>
    fscrypt: use unbound workqueue for decryption

Xi Wang <wangxi11@huawei.com>
    net: hns3: Fix for hns3 module is loaded multiple times problem

Xi Wang <wangxi11@huawei.com>
    net: hns3: Fix the missing client list node initialization

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix for CMDQ and Misc. interrupt init order problem

Tony Lindgren <tony@atomide.com>
    spi: Add missing pm_runtime_put_noidle() after failed get

Mark Rutland <mark.rutland@arm.com>
    drivers/perf: arm-ccn: don't log to dmesg in event_init

Wolfram Sang <wsa+renesas@sang-engineering.com>
    watchdog: renesas-wdt: Add support for the R8A77965 WDT

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: based on policy verify firmware signatures (pre-allocated buffer)

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x2: apply coverage class on slot time too

Xinming Hu <huxm@marvell.com>
    mwifiex: correct histogram data with appropriate index

Michal Vokáč <vokac.m@gmail.com>
    net: dsa: qca8k: Add support for QCA8334 switch

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: pciehp: Request control of native hotplug only if supported

Sandipan Das <sandipan@linux.vnet.ibm.com>
    bpf: powerpc64: pad function address loads with NOPs

Sandipan Das <sandipan@linux.vnet.ibm.com>
    bpf: fix multi-function JITed dump obtained via syscall

Christian Lamparter <chunkeey@gmail.com>
    pinctrl: msm: fix gpio-hog related boot issues

Julia Lawall <Julia.Lawall@lip6.fr>
    pinctrl: at91-pio4: add missing of_node_put

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/8xx: fix invalid register expression in head_8xx.S

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: sh-msiof: Fix setting SIRMDR1.SYNCAC to match SITMDR1.SYNCAC

Dan Carpenter <dan.carpenter@oracle.com>
    KVM: x86: prevent integer overflows in KVM_MEMORY_ENCRYPT_REG_REGION

Mathieu Malaterre <malat@debian.org>
    powerpc: Add __printf verification to prom_printf

Mathieu Malaterre <malat@debian.org>
    powerpc/powermac: Mark variable x as unused

Mathieu Malaterre <malat@debian.org>
    powerpc/powermac: Add missing prototype for note_bootable_part()

Mathieu Malaterre <malat@debian.org>
    powerpc/chrp/time: Make some functions static, add missing header include

Mathieu Malaterre <malat@debian.org>
    powerpc/32: Add a missing include header

Patrick Bellasi <patrick.bellasi@arm.com>
    sched/cpufreq: Modify aggregate utilization to always include blocked FAIR utilization

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Bahamas

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Bermuda

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Serbia

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Tanzania

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Uganda

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for APL2_FCCA

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for APL13_WORLD

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for ETSI8_WORLD

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for FCC3_ETSIC

Keith Busch <keith.busch@intel.com>
    nvme-pci: Fix AER reset handling

Jianchao Wang <jianchao.w.wang@oracle.com>
    nvme-rdma: stop admin queue before freeing it

Alex Elder <elder@linaro.org>
    soc: qcom: smem: byte swap values properly

Alex Elder <elder@linaro.org>
    soc: qcom: smem: fix qcom_smem_set_global_partition()

Alex Elder <elder@linaro.org>
    soc: qcom: qmi: fix a buffer sizing bug

Christoph Hellwig <hch@lst.de>
    PCI: Prevent sysfs disable of device while driver is attached

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    PM / wakeup: Make s2idle_lock a RAW_SPINLOCK

Scott Wood <swood@redhat.com>
    x86/microcode: Make the late update update_lock a raw lock for RT

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: Finish rescan when hit the last leaf of extent tree

David Sterba <dsterba@suse.com>
    btrfs: add barriers to btrfs_sync_log before log_commit_wait wakeups

Omar Sandoval <osandov@fb.com>
    Btrfs: don't BUG_ON() in btrfs_truncate_inode_items()

Omar Sandoval <osandov@fb.com>
    Btrfs: don't return ino to ino cache if inode item removal fails

Hans Verkuil <hans.verkuil@cisco.com>
    media: videobuf2-core: don't call memop 'finish' when queueing

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: cec-pin-error-inj: avoid a false-positive Spectre detection

Ezequiel Garcia <ezequiel@collabora.com>
    media: tw686x: Fix incorrect vb2_mem_ops GFP flags

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: Fixes the init of the VALID BD info in the descriptor

Lijun Ou <oulijun@huawei.com>
    net: hns3: Fixes initalization of RoCE handle and makes it conditional

Eyal Reizer <eyalreizer@gmail.com>
    wlcore: sdio: check for valid platform device data before suspend

Ganapathi Bhat <gbhat@marvell.com>
    mwifiex: handle race during mwifiex_usb_disconnect

Vincent Palatin <vpalatin@chromium.org>
    mfd: cros_ec: Fail early if we cannot identify the EC

Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
    ASoC: dpcm: fix BE dai not hw_free and shutdown

Jian-Hong Pan <jian-hong@endlessm.com>
    Bluetooth: btusb: Add a new Realtek 8723DE ID 2ff8:b011

Arnd Bergmann <arnd@arndb.de>
    drivers/bus: arm-cci: fix build warnings

Mikita Lipski <mikita.lipski@amd.com>
    drm/amd/display: Do not program interrupt status on disabled crtc

Thierry Escande <thierry.escande@linaro.org>
    Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning

Gregory Greenman <gregory.greenman@intel.com>
    iwlwifi: mvm: open BA session only when sta is authorized

Shaul Triebitz <shaul.triebitz@intel.com>
    iwlwifi: pcie: fix race in Rx buffer allocator

Ethan Lien <ethanlien@synology.com>
    btrfs: balance dirty metadata pages in btrfs_finish_ordered_io

Jan Kiszka <jan.kiszka@siemens.com>
    PCI: Fix devm_pci_alloc_host_bridge() memory leak

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
    qtnfmac: fix invalid STA state on EAPOL failure

Anders Roxell <anders.roxell@linaro.org>
    selftests/filesystems: devpts_pts included wrong header

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: filesystems: return Kselftest Skip code for skipped tests

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: intel_pstate: return Kselftest Skip code for skipped tests

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: kvm: return Kselftest Skip code for skipped tests

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: memfd: return Kselftest Skip code for skipped tests

Daniel Díaz <daniel.diaz@linaro.org>
    selftests/intel_pstate: Improve test, minor fixes

Kan Liang <kan.liang@intel.com>
    perf/x86/intel/uncore: Correct fixed counter index check for NHM

Kan Liang <kan.liang@intel.com>
    perf/x86/intel/uncore: Correct fixed counter index check in generic code

Michael Grzeschik <m.grzeschik@pengutronix.de>
    usbip: dynamically allocate idev by nports found in sysfs

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_detach: Fix memory, udev context and udev leak

Filippo Muzzini <filippo.muzzini@outlook.it>
    block, bfq: remove wrong lock in bfq_requests_merged

Chao Yu <yuchao0@huawei.com>
    f2fs: fix race in between GC and atomic open

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to detect failure of dquot_initialize

Yunlei He <heyunlei@huawei.com>
    f2fs: fix missing clear FI_NO_PREALLOC in some error case

Sahitya Tummala <stummala@codeaurora.org>
    f2fs: Fix deadlock in shutdown ioctl

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to wait page writeback during revoking atomic write

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to don't trigger writeback during recovery

Chao Yu <yuchao0@huawei.com>
    f2fs: don't drop dentry pages after fs shutdown

Chao Yu <yuchao0@huawei.com>
    f2fs: fix error path of move_data_page

Anatoly Pugachev <matorola@gmail.com>
    disable loading f2fs module on PAGE_SIZE > 4KB

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix up nfs_post_op_update_inode() to force ctime updates

Trond Myklebust <trond.myklebust@hammerspace.com>
    pnfs: Don't release the sequence slot until we've processed layoutget on open

Alexey Kodanev <alexey.kodanev@oracle.com>
    netfilter: nf_tables: check msg_type before nft_trans_set(trans)

Javier González <javier@cnexlabs.com>
    lightnvm: pblk: warn in case of corrupted write buffer

Igor Konopko <igor.j.konopko@intel.com>
    lightnvm: proper error handling for pblk_bio_add_pages

Igor Konopko <igor.j.konopko@intel.com>
    lightnvm: fix partial read error path

Leon Romanovsky <leon@kernel.org>
    RDMA/mad: Convert BUG_ONs to error flows

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix for service_task not running problem after resetting

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix for phy not link up problem after resetting

Paul Cercueil <paul@crapouillou.net>
    clk: ingenic: jz4770: Modify C1CLK clock to disable CPU clock stop on idle

Mike Looijmans <mike.looijmans@topic.nl>
    clk-si544: Properly round requested frequency to nearest match

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix compiler store ordering to SLB shadow area

Stewart Smith <stewart@linux.ibm.com>
    hvc_opal: don't set tb_ticks_per_usec in udbg_init_opal_common()

Sam Bobroff <sbobroff@linux.ibm.com>
    powerpc/eeh: Fix use-after-release of EEH driver

Michal Suchanek <msuchanek@suse.de>
    powerpc/64s: Add barrier_nospec

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/lib: Adjust .balign inside string functions for PPC32

Cong Wang <xiyou.wangcong@gmail.com>
    infiniband: fix a possible use-after-free bug

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Ignore TSYNCRXCTL when getting I219 clock attributes

Luis Henriques <lhenriques@suse.com>
    ceph: fix use-after-free in ceph_statfs()

Chengguang Xu <cgxu519@gmx.com>
    ceph: fix alignment of rasize

Wang YanQing <udknight@gmail.com>
    bpf, arm32: fix inconsistent naming about emit_a32_lsr_{r64,i64}

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    printk: drop in_nmi check from printk_safe_flush_on_panic()

Jacopo Mondi <jacopo+renesas@jmondi.org>
    media: arch: sh: migor: Fix TW9910 PDN gpio

Marco Felsch <m.felsch@pengutronix.de>
    watchdog: da9063: Fix updating timeout value

Laurentiu Tudor <laurentiu.tudor@nxp.com>
    irqchip/ls-scfg-msi: Map MSIs in the iommu

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: ipset: List timing out entries with "timeout 1" instead of zero

Florent Fourcot <florent.fourcot@wifirst.fr>
    netfilter: ipset: forbid family for hash:mac sets

Jiri Olsa <jolsa@kernel.org>
    perf tools: Fix pmu events parsing rule

Xi Wang <wangxi11@huawei.com>
    net: hns3: Fix for VF mailbox cannot receiving PF response

David Howells <dhowells@redhat.com>
    rxrpc: Fix terminal retransmission connection ID to include the channel

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: ensure rtc_set_alarm fails when alarms are not supported

Mathieu Malaterre <malat@debian.org>
    mm/slub.c: add __printf verification to slab_err()

Chintan Pandya <cpandya@codeaurora.org>
    mm: vmalloc: avoid racy handling of debugobjects in vunmap

Huang Ying <ying.huang@intel.com>
    mm: /proc/pid/pagemap: hide swap entries from unprivileged users

Aaron Lu <aaron.lu@intel.com>
    mem_cgroup: make sure moving_account, move_lock_task and stat_cpu in the same cacheline

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    kernel/hung_task.c: show all hung tasks before panic

Alex Williamson <alex.williamson@redhat.com>
    vfio/type1: Fix task tracking for QEMU vCPU hotplug

Alex Williamson <alex.williamson@redhat.com>
    vfio/mdev: Check globally for duplicate devices

Geert Uytterhoeven <geert+renesas@glider.be>
    vfio: platform: Fix reset module leak in error path

Scott Mayhew <smayhew@redhat.com>
    nfsd: fix potential use-after-free in nfsd4_decode_getdeviceinfo

Andrew Elble <aweits@rit.edu>
    nfsd: fix error handling in nfs4_set_delegation()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Fix the client behaviour on NFS4ERR_SEQ_FALSE_RETRY

Zhouyang Jia <jiazhouyang09@gmail.com>
    ALSA: fm801: add error handling for snd_ctl_add

Zhouyang Jia <jiazhouyang09@gmail.com>
    ALSA: emu10k1: add error handling for snd_ctl_add

Alexander Duyck <alexander.h.duyck@intel.com>
    ixgbe: Fix setting of TC configuration for macvlan case

Olga Kornievskaia <olga.kornievskaia@gmail.com>
    skip LAYOUTRETURN if layout is invalid

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix network namespace issues with VF support

Juergen Gross <jgross@suse.com>
    xen/netfront: raise max number of slots in xennet_get_responses()

Kenneth Feng <kenneth.feng@amd.com>
    drm/amd/powerplay: Set higher SCLK&MCLK frequency than dpm7 in OD (v2)

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm: check for SIGKILL inside dup_mmap() loop

Mark Rutland <mark.rutland@arm.com>
    kcov: ensure irq code sees a valid area

Petr Machata <petrm@mellanox.com>
    mlxsw: spectrum_switchdev: Fix port_vlan refcounting

Clint Taylor <clinton.a.taylor@intel.com>
    drm/i915/glk: Add Quirk for GLK NUC HDMI port issues.

Johannes Weiner <hannes@cmpxchg.org>
    arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap setups

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Quiet gcc warning about maybe unused link variable

Artem Savkov <asavkov@redhat.com>
    tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure

Snild Dolkow <snild@sony.com>
    kthread, tracing: Don't expose half-written comm when creating kthreads

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix possible double free in event_enable_trigger_func()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix double free of event_trigger_data

Tejun Heo <tj@kernel.org>
    delayacct: fix crash in delayacct_blkio_end() after delayacct init failure

Shakeel Butt <shakeelb@google.com>
    kvm, mm: account shadow page tables to kmemcg

Dave Jiang <dave.jiang@intel.com>
    mm: disallow mappings that conflict for devm_memremap_pages()

KT Liao <kt.liao@emc.com.tw>
    Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Chen-Yu Tsai <wens@csie.org>
    Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Donald Shanty III <dshanty@protonmail.com>
    Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Marek Szyprowski <m.szyprowski@samsung.com>
    spi: spi-s3c64xx: Fix system resume support


-------------

Diffstat:

 .../devicetree/bindings/net/dsa/qca8k.txt          |  23 +++-
 .../devicetree/bindings/net/meson-dwmac.txt        |   1 +
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   2 +
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |   1 +
 Documentation/vfio-mediated-device.txt             |   5 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/emev2.dtsi                       |   5 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |   2 -
 arch/arm/boot/dts/imx53.dtsi                       |   8 ++
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi     |   1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi     |   1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi     |   1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   8 ++
 arch/arm/boot/dts/sh73a0.dtsi                      |   5 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |  10 +-
 arch/arm/boot/dts/stih410.dtsi                     |  18 +--
 arch/arm/net/bpf_jit_32.c                          |  10 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  38 +++---
 arch/arm64/configs/defconfig                       |   2 +
 arch/arm64/include/asm/cmpxchg.h                   |   4 +-
 arch/arm64/mm/init.c                               |   4 +-
 arch/microblaze/boot/Makefile                      |  10 +-
 arch/powerpc/include/asm/barrier.h                 |  15 +++
 arch/powerpc/include/asm/cache.h                   |   3 +
 arch/powerpc/include/asm/pkeys.h                   |   2 +
 arch/powerpc/kernel/eeh_driver.c                   |  28 +++--
 arch/powerpc/kernel/head_8xx.S                     |   2 +-
 arch/powerpc/kernel/pci_32.c                       |   1 +
 arch/powerpc/kernel/prom_init.c                    | 114 +++++++++---------
 arch/powerpc/lib/string.S                          |   7 +-
 arch/powerpc/mm/slb.c                              |   8 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |  34 ++++--
 arch/powerpc/platforms/chrp/time.c                 |   6 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   5 +
 arch/powerpc/platforms/powermac/bootx_init.c       |   4 +-
 arch/powerpc/platforms/powermac/setup.c            |   1 +
 arch/s390/include/asm/cpu_mf.h                     |   6 +-
 arch/sh/boards/mach-migor/setup.c                  |   2 +-
 arch/x86/events/intel/uncore.c                     |   2 +-
 arch/x86/events/intel/uncore_nhmex.c               |   2 +-
 arch/x86/kernel/cpu/microcode/core.c               |   6 +-
 arch/x86/kvm/mmu.c                                 |   2 +-
 arch/x86/kvm/svm.c                                 |   8 +-
 block/bfq-iosched.c                                |   2 -
 block/bio.c                                        |  19 ++-
 crypto/authenc.c                                   |   1 +
 crypto/authencesn.c                                |   1 +
 drivers/acpi/acpi_lpss.c                           |  32 +++--
 drivers/acpi/acpica/psloop.c                       |  19 +--
 drivers/acpi/pci_root.c                            |   4 +-
 drivers/ata/libata-eh.c                            |  12 +-
 drivers/bluetooth/btusb.c                          |   4 +
 drivers/bluetooth/hci_qca.c                        |   2 +-
 drivers/char/random.c                              |  10 +-
 drivers/clk/clk-si544.c                            |   1 +
 drivers/clk/ingenic/jz4770-cgu.c                   |   3 +-
 drivers/edac/altera_edac.c                         |   2 +-
 drivers/gpio/gpio-uniphier.c                       |   6 +-
 drivers/gpio/gpiolib-of.c                          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c             |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   3 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   7 +-
 drivers/gpu/drm/drm_atomic.c                       |   4 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  78 ++++++------
 drivers/gpu/drm/drm_dp_mst_topology.c              |   9 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h             |   2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |   2 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   1 +
 drivers/gpu/drm/i915/intel_ddi.c                   |  13 +-
 drivers/gpu/drm/i915/intel_display.c               |  21 +++-
 drivers/gpu/drm/i915/intel_drv.h                   |   3 +-
 drivers/gpu/drm/nouveau/nouveau_dma.c              |  10 +-
 drivers/gpu/drm/nouveau/nouveau_dma.h              |   5 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  30 +++--
 drivers/gpu/drm/nouveau/nouveau_gem.c              |  19 ++-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c   |   8 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |  10 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   9 ++
 drivers/gpu/drm/stm/ltdc.c                         |   3 -
 drivers/gpu/host1x/dev.c                           |  11 +-
 drivers/hid/hid-plantronics.c                      |   6 +-
 drivers/hid/i2c-hid/i2c-hid.c                      |   8 ++
 drivers/i2c/busses/i2c-rcar.c                      |  54 ++++++++-
 drivers/infiniband/core/mad.c                      |  11 +-
 drivers/infiniband/core/ucma.c                     |   6 +-
 drivers/infiniband/core/uverbs_cmd.c               |   5 +
 drivers/infiniband/sw/rdmavt/Kconfig               |   2 +-
 drivers/infiniband/sw/rxe/Kconfig                  |   1 +
 drivers/input/mouse/elan_i2c_core.c                |   2 +
 drivers/input/serio/i8042-x86ia64io.h              |   7 ++
 drivers/irqchip/irq-ls-scfg-msi.c                  |   3 +
 drivers/lightnvm/pblk-core.c                       |   6 +-
 drivers/lightnvm/pblk-rb.c                         |   5 +-
 drivers/lightnvm/pblk-read.c                       |   8 +-
 drivers/md/md.c                                    |   3 +
 drivers/md/raid1.c                                 |   2 +
 drivers/media/cec/cec-pin-error-inj.c              |  33 ++---
 drivers/media/common/siano/smsendian.c             |  14 +--
 drivers/media/common/videobuf2/videobuf2-core.c    |   9 +-
 drivers/media/i2c/smiapp/smiapp-core.c             |  11 +-
 drivers/media/media-device.c                       |  21 ++--
 drivers/media/pci/saa7164/saa7164-fw.c             |   3 +-
 drivers/media/pci/tw686x/tw686x-video.c            |   3 +-
 drivers/media/platform/omap3isp/isp.c              |   7 +-
 drivers/media/platform/rcar_jpu.c                  |   4 +-
 drivers/media/platform/renesas-ceu.c               |  20 ++-
 drivers/media/radio/si470x/radio-si470x-i2c.c      |   6 +-
 drivers/media/rc/ir-mce_kbd-decoder.c              |  12 +-
 drivers/media/usb/em28xx/em28xx-dvb.c              |   4 +-
 drivers/memory/tegra/mc.c                          |  22 +---
 drivers/memory/tegra/mc.h                          |   9 ++
 drivers/memory/tegra/tegra114.c                    |   2 +
 drivers/memory/tegra/tegra124.c                    |   6 +
 drivers/memory/tegra/tegra210.c                    |   3 +
 drivers/memory/tegra/tegra30.c                     |   2 +
 drivers/mfd/cros_ec.c                              |   6 +-
 drivers/mmc/core/pwrseq_simple.c                   |  14 ++-
 drivers/mmc/host/dw_mmc.c                          |   4 +
 drivers/mmc/host/sdhci-omap.c                      |  17 ++-
 drivers/mtd/nand/raw/fsl_ifc_nand.c                |  17 +--
 drivers/net/dsa/qca8k.c                            |  52 +++++++-
 drivers/net/dsa/qca8k.h                            |   7 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   1 +
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |   3 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   2 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |   1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   5 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  17 +--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  28 +++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  15 +--
 drivers/net/ethernet/intel/i40e/i40e.h             |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  48 +++++---
 drivers/net/ethernet/intel/igb/igb_main.c          |   9 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |   8 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   8 --
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   1 +
 drivers/net/ethernet/marvell/mvpp2.c               |   3 +
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  14 +--
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   4 +-
 drivers/net/ethernet/socionext/netsec.c            |  23 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ethernet/ti/cpsw-phy-sel.c             |   8 +-
 drivers/net/hyperv/hyperv_net.h                    |   2 +
 drivers/net/hyperv/netvsc_drv.c                    |  43 +++----
 drivers/net/netdevsim/devlink.c                    |   1 +
 drivers/net/phy/mdio-mux-bcm-iproc.c               |   2 +-
 drivers/net/phy/phylink.c                          |   2 +
 drivers/net/phy/sfp-bus.c                          |   7 ++
 drivers/net/usb/lan78xx.c                          |   2 +
 drivers/net/virtio_net.c                           |  41 ++++---
 drivers/net/wireless/ath/ath10k/core.c             | 134 +++++++++++----------
 drivers/net/wireless/ath/ath10k/debug.c            |   8 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   6 +
 drivers/net/wireless/ath/ath10k/wmi.h              |   2 +-
 drivers/net/wireless/ath/regd.h                    |   5 +
 drivers/net/wireless/ath/regd_common.h             |  13 ++
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  38 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |  10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   2 +
 drivers/net/wireless/marvell/mwifiex/usb.c         |   3 +
 drivers/net/wireless/marvell/mwifiex/util.c        |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_init.c   |   3 +
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_phy.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |   2 +
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |  21 ++--
 drivers/net/wireless/quantenna/qtnfmac/event.c     |   8 +-
 .../net/wireless/quantenna/qtnfmac/pearl/pcie.c    |   4 +
 drivers/net/wireless/rsi/rsi_91x_hal.c             |  35 +++---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   7 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |  23 ++--
 drivers/net/wireless/rsi/rsi_sdio.h                |   2 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |   5 +
 drivers/net/xen-netfront.c                         |  10 +-
 drivers/nvme/host/pci.c                            |  16 ++-
 drivers/nvme/host/rdma.c                           |  10 +-
 drivers/nvme/target/fc.c                           |  44 +++++--
 drivers/nvmem/core.c                               |   7 ++
 drivers/pci/pci-sysfs.c                            |  15 ++-
 drivers/pci/pcie/aspm.c                            |   9 ++
 drivers/pci/pcie/dpc.c                             |   5 +-
 drivers/pci/probe.c                                |   4 +-
 drivers/perf/arm-cci.c                             |   6 +-
 drivers/perf/arm-ccn.c                             |  20 +--
 drivers/pinctrl/pinctrl-at91-pio4.c                |   4 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  23 +++-
 drivers/platform/x86/dell-smbios-base.c            |   5 +-
 drivers/regulator/cpcap-regulator.c                |   2 +-
 drivers/regulator/internal.h                       |   9 +-
 drivers/regulator/of_regulator.c                   |  13 +-
 drivers/regulator/pfuze100-regulator.c             |   1 +
 drivers/regulator/twl-regulator.c                  |   2 +-
 drivers/rtc/interface.c                            |   5 +
 drivers/rtc/rtc-tps6586x.c                         |  14 ++-
 drivers/rtc/rtc-tps65910.c                         |  12 +-
 drivers/rtc/rtc-vr41xx.c                           |   9 +-
 drivers/s390/scsi/zfcp_dbf.c                       |   2 +
 drivers/scsi/3w-9xxx.c                             |   5 +
 drivers/scsi/3w-xxxx.c                             |   3 +
 drivers/scsi/cxlflash/main.c                       |  11 +-
 drivers/scsi/cxlflash/sislite.h                    |   1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  11 +-
 drivers/scsi/megaraid.c                            |   3 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   3 +
 drivers/scsi/qedf/qedf_main.c                      |  10 ++
 drivers/scsi/scsi_dh.c                             |   5 +-
 drivers/scsi/ufs/ufshcd.c                          |  28 ++++-
 drivers/soc/imx/gpcv2.c                            |  22 ++--
 drivers/soc/qcom/qmi_interface.c                   |   5 +-
 drivers/soc/qcom/smem.c                            |  27 +++--
 drivers/soc/tegra/pmc.c                            |  20 +--
 drivers/spi/spi-meson-spicc.c                      |  11 +-
 drivers/spi/spi-s3c64xx.c                          |   4 +-
 drivers/spi/spi-sh-msiof.c                         |   6 +-
 drivers/spi/spi.c                                  |   1 +
 drivers/staging/ks7010/ks7010_sdio.c               |   3 +
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |   2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |  30 ++---
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c     |   6 +-
 drivers/staging/lustre/lustre/llite/xattr.c        |   6 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |   6 +-
 drivers/staging/media/atomisp/i2c/gc2235.h         |   9 +-
 drivers/staging/media/atomisp/i2c/ov2680.h         |   5 +-
 drivers/staging/media/atomisp/i2c/ov2722.h         |   6 +
 drivers/staging/media/atomisp/i2c/ov5693/ov5693.h  |  18 ++-
 .../atomisp/pci/atomisp2/atomisp_compat_ioctl32.c  |  49 ++++----
 drivers/staging/most/cdev/cdev.c                   |   6 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |   1 +
 drivers/thermal/samsung/exynos_tmu.c               |   1 +
 drivers/tty/hvc/hvc_opal.c                         |   1 -
 drivers/tty/pty.c                                  |   3 +
 drivers/usb/core/hub.c                             |   4 +
 drivers/vfio/mdev/mdev_core.c                      | 102 ++++++----------
 drivers/vfio/mdev/mdev_private.h                   |   2 +-
 drivers/vfio/platform/vfio_platform_common.c       |  15 ++-
 drivers/vfio/vfio_iommu_type1.c                    |  73 +++++++----
 drivers/video/backlight/pwm_bl.c                   |   6 +-
 drivers/watchdog/da9063_wdt.c                      |  17 ++-
 fs/block_dev.c                                     |   9 +-
 fs/btrfs/inode.c                                   |  33 +++--
 fs/btrfs/qgroup.c                                  |  19 +++
 fs/btrfs/tree-log.c                                |  10 +-
 fs/ceph/super.c                                    |  13 +-
 fs/crypto/crypto.c                                 |  11 +-
 fs/ext4/balloc.c                                   |   3 +
 fs/ext4/ialloc.c                                   |   8 +-
 fs/ext4/inline.c                                   |  19 +--
 fs/ext4/inode.c                                    |  16 ++-
 fs/ext4/super.c                                    |  13 +-
 fs/f2fs/data.c                                     |  14 ++-
 fs/f2fs/f2fs.h                                     |   8 +-
 fs/f2fs/file.c                                     |  20 ++-
 fs/f2fs/gc.c                                       |  11 +-
 fs/f2fs/segment.c                                  |   5 +
 fs/f2fs/super.c                                    |   6 +
 fs/fcntl.c                                         |  15 ++-
 fs/nfs/inode.c                                     |   3 +-
 fs/nfs/nfs4proc.c                                  |  14 ++-
 fs/nfs/pnfs.c                                      |   6 +-
 fs/nfsd/nfs4state.c                                |   5 +-
 fs/nfsd/nfs4xdr.c                                  |   2 +
 fs/proc/task_mmu.c                                 |  30 +++--
 fs/squashfs/cache.c                                |   3 +
 fs/squashfs/file.c                                 |   8 +-
 fs/squashfs/fragment.c                             |   4 +-
 fs/squashfs/squashfs_fs.h                          |   6 +
 include/drm/drm_dp_helper.h                        |   1 +
 include/linux/delayacct.h                          |   4 +-
 include/linux/dma-iommu.h                          |   1 +
 include/linux/fs.h                                 |   2 +-
 include/linux/memcontrol.h                         |  23 +++-
 include/linux/mm.h                                 |   9 +-
 include/linux/mmc/sdio_ids.h                       |   1 +
 include/linux/netfilter/ipset/ip_set_timeout.h     |  10 +-
 include/linux/regulator/consumer.h                 |   1 +
 include/linux/serial_core.h                        |   3 +-
 include/net/tcp.h                                  |   2 +-
 include/soc/tegra/mc.h                             |   2 +
 include/uapi/sound/asoc.h                          |  23 +++-
 ipc/msg.c                                          |   6 +-
 ipc/sem.c                                          |   6 +-
 kernel/auditfilter.c                               |   2 +-
 kernel/auditsc.c                                   |   2 +
 kernel/bpf/syscall.c                               |  37 +++++-
 kernel/bpf/verifier.c                              |   4 +-
 kernel/delayacct.c                                 |  17 +--
 kernel/fork.c                                      |   8 ++
 kernel/hung_task.c                                 |  11 +-
 kernel/kcov.c                                      |   3 +-
 kernel/kthread.c                                   |   8 +-
 kernel/memremap.c                                  |  18 ++-
 kernel/power/suspend.c                             |  14 +--
 kernel/printk/printk_safe.c                        |   2 +-
 kernel/sched/cpufreq_schedutil.c                   |  17 ++-
 kernel/stop_machine.c                              |  24 ++--
 kernel/time/clocksource.c                          |   4 +-
 kernel/trace/trace_events_trigger.c                |  18 ++-
 kernel/trace/trace_kprobe.c                        |  15 ++-
 lib/dma-direct.c                                   |   7 ++
 mm/slub.c                                          |   2 +-
 mm/vmalloc.c                                       |   3 +-
 net/core/dev.c                                     |  17 +--
 net/ipv4/fib_frontend.c                            |   4 +-
 net/ipv4/ipconfig.c                                |  13 ++
 net/ipv4/tcp_bbr.c                                 |   4 +
 net/ipv4/tcp_dctcp.c                               |   4 +-
 net/ipv4/tcp_input.c                               |  57 +++++----
 net/netfilter/ipset/ip_set_hash_gen.h              |   5 +-
 net/netfilter/nf_tables_api.c                      |  11 +-
 net/netlink/af_netlink.c                           |   5 +
 net/rds/ib_frmr.c                                  |   5 +
 net/rds/ib_mr.h                                    |   3 +-
 net/rds/ib_rdma.c                                  |  21 ++--
 net/rds/rdma.c                                     |  13 +-
 net/rds/rds.h                                      |   5 +-
 net/rds/send.c                                     |  12 +-
 net/rxrpc/conn_event.c                             |   2 +-
 security/integrity/ima/ima_main.c                  |   1 +
 sound/pci/emu10k1/emupcm.c                         |   4 +-
 sound/pci/emu10k1/memory.c                         |   6 +-
 sound/pci/fm801.c                                  |  16 ++-
 sound/pci/hda/patch_ca0132.c                       |   8 +-
 sound/soc/fsl/fsl_ssi.c                            |   3 +-
 sound/soc/soc-compress.c                           |  52 ++++----
 sound/soc/soc-pcm.c                                |   6 +-
 sound/soc/soc-topology.c                           |  19 ++-
 sound/usb/pcm.c                                    |   2 +-
 tools/perf/util/parse-events.y                     |  14 ++-
 tools/testing/selftests/filesystems/Makefile       |   1 +
 tools/testing/selftests/filesystems/devpts_pts.c   |  13 +-
 tools/testing/selftests/intel_pstate/run.sh        |  29 +++--
 tools/testing/selftests/kvm/lib/assert.c           |   9 +-
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c  |   2 +
 tools/testing/selftests/memfd/run_tests.sh         |  14 ++-
 tools/usb/usbip/libsrc/vhci_driver.c               |  32 +++--
 tools/usb/usbip/libsrc/vhci_driver.h               |   3 +-
 tools/usb/usbip/src/usbip_detach.c                 |   9 +-
 351 files changed, 2495 insertions(+), 1300 deletions(-)


