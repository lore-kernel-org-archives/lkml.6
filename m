Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237F820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237F820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406163AbeHATIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405929AbeHATIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:42 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DD5F7134A;
        Wed,  1 Aug 2018 17:12:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/246] 4.14.60-stable review
Date:   Wed,  1 Aug 2018 18:48:30 +0200
Message-Id: <20180801165011.700991984@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.60-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.60-rc1
X-KernelTest-Deadline: 2018-08-03T16:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.60 release.
There are 246 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Aug  3 16:49:18 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.60-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.60-rc1

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

Xiao Liang <xiliang@redhat.com>
    xen-netfront: wait xenbus state change when load module manually

Neal Cardwell <ncardwell@google.com>
    tcp_bbr: fix bw probing to raise in-flight data for very small BDPs

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

Leon Romanovsky <leonro@mellanox.com>
    RDMA/uverbs: Protect from attempts to create flows on unsupported QP

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: gadget: udc: renesas_usb3: should remove debugfs

Chengguang Xu <cgxu@mykernel.net>
    ovl: Sync upper dirty data when syncing overlayfs

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    PCI: xgene: Remove leftover pci_scan_child_bus() call

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Assume NoCompl+ for Thunderbolt ports

Theodore Ts'o <tytso@mit.edu>
    ext4: fix check to prevent initializing reserved inodes

Theodore Ts'o <tytso@mit.edu>
    ext4: check for allocation block validity with block group locked

Theodore Ts'o <tytso@mit.edu>
    ext4: fix inline data updates with checksums enabled

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: be more careful about metadata corruption

Theodore Ts'o <tytso@mit.edu>
    random: mix rdrand with entropy sent in from userspace

Greg Edwards <gedwards@ddn.com>
    block: reset bi_iter.bi_done after splitting bio

Martin Wilck <mwilck@suse.com>
    blkdev: __blkdev_direct_IO_simple: fix leak in error case

Martin Wilck <mwilck@suse.com>
    block: bio_iov_iter_get_pages: fix size of last iovec

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    drm/dp/mst: Fix off-by-one typo when dump payload table

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/atomic-helper: Drop plane->fb references only for drm_atomic_helper_shutdown()

José Roberto de Souza <jose.souza@intel.com>
    drm: Add DP PSR2 sink enable bit

Kirill Marinushkin <k.marinushkin@gmail.com>
    ASoC: topology: Add missing clock gating parameter when parsing hw_configs

Kirill Marinushkin <k.marinushkin@gmail.com>
    ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: si470x: fix __be16 annotations

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: atomisp: compat32: fix __user annotations

Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
    scsi: cxlflash: Avoid clobbering context control register value

Uma Krishnan <ukrishn@linux.vnet.ibm.com>
    scsi: cxlflash: Synchronize reset and remove ops

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Increase timeout by 1 sec for non-RAID fastpath IOs

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: scsi_dh: replace too broad "TP9" string with the exact models

Douglas Anderson <dianders@chromium.org>
    regulator: Don't return or expect -errno from of_map_mode()

Suman Anna <s-anna@ti.com>
    media: omap3isp: fix unbalanced dma_iommu_mapping

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

NeilBrown <neilb@suse.com>
    staging: lustre: ldlm: free resource when ldlm_lock_create() fails.

James Simmons <jsimmons@infradead.org>
    staging: lustre: llite: correct removexattr detection

Stefan Wahren <stefan.wahren@i2se.com>
    staging: vchiq_core: Fix missing semaphore release in error case

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

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igb: Fix queue selection on MAC filters on i210

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    arm64: defconfig: Enable Rockchip io-domain driver

Wei Xu <wxu@cnexlabs.com>
    nvme: lightnvm: add granby support

Dmitry Osipenko <digetx@gmail.com>
    memory: tegra: Apply interrupts mask per SoC

Dmitry Osipenko <digetx@gmail.com>
    memory: tegra: Do not handle spurious interrupts

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    delayacct: Use raw_spinlocks

Thomas Gleixner <tglx@linutronix.de>
    stop_machine: Use raw spinlocks

Wolfram Sang <wsa+renesas@sang-engineering.com>
    backlight: pwm_bl: Don't use GPIOF_* with gpiod_get_direction

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

Satendra Singh Thakur <satendra.t@samsung.com>
    drm/atomic: Handling the case when setting old crtc for plane

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: siano: get rid of __le32/__le16 cast warnings

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: avoid fsync() failure caused by EAGAIN in writepage()

Jakub Kicinski <jakub.kicinski@netronome.com>
    bpf: fix references to free_bpf_prog_info() in comments

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    thermal: exynos: fix setting rising_threshold for Exynos5433

Doug Oucharek <dougso@me.com>
    staging: lustre: o2iblnd: Fix FastReg map/unmap for MLX5

Doug Oucahrek <dougso@me.com>
    staging: lustre: o2iblnd: fix race at kiblnd_connect_peer

Chad Dupuis <chad.dupuis@cavium.com>
    scsi: qedf: Set the UNLOADING flag when removing a vport

Xiang Chen <chenxiang66@hisilicon.com>
    scsi: hisi_sas: config ATA de-reset as an constrained command for v3 hw

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: megaraid: silence a static checker bug

Wenwen Wang <wang6495@umn.edu>
    scsi: 3w-xxxx: fix a missing-check bug

Wenwen Wang <wang6495@umn.edu>
    scsi: 3w-9xxx: fix a missing-check bug

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Check unsupported speeds in bnxt_update_link() on PF only.

Thomas Richter <tmricht@linux.ibm.com>
    perf: fix invalid bit in diagnostic entry

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpum_sf: Add data entry sizes to sampling trailer entry

Sean Lanigan <sean@lano.id.au>
    brcmfmac: Add support for bcm43364 wireless chipset

Jane Wan <Jane.Wan@nokia.com>
    mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter pages

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

Mathieu Malaterre <malat@debian.org>
    nvmem: properly handle returned value nvmem_reg_read

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: sh73a0: Add missing interrupt-affinity to PMU node

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: emev2: Add missing interrupt-affinity to PMU node

Patrice Chotard <patrice.chotard@st.com>
    ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage

Thor Thayer <thor.thayer@linux.intel.com>
    EDAC, altera: Fix ARM64 build warning

Dmitry Torokhov <dtor@chromium.org>
    HID: i2c-hid: check if device is there before really probing

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled by Starlet

Samuel Li <Samuel.Li@amd.com>
    drm/amdgpu: Remove VRAM from shared bo domains.

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    drm/radeon: fix mode_valid's return type

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    arm64: dts: renesas: salvator-common: use audio-graph-card for Sound

Terry Junge <terry.junge@plantronics.com>
    HID: hid-plantronics: Re-resend Update to map button for PTT products

Will Deacon <will.deacon@arm.com>
    arm64: cmpwait: Clear event register before arming exclusive monitor

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: atomisp: ov2680: don't declare unused vars

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Apply rate limit to warning messages in URB complete callback

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw-phy-sel: check bus_find_device() ret value

Colin Ian King <colin.king@canonical.com>
    media: smiapp: fix timeout checking in smiapp_read_nvm

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

Jens Remus <jremus@linux.ibm.com>
    scsi: zfcp: assert that the ERP lock is held when tracing a recovery trigger

Maya Erez <merez@codeaurora.org>
    scsi: ufs: fix exception event handling

Subhash Jadavani <subhashj@codeaurora.org>
    scsi: ufs: ufshcd: fix possible unclocked register access

Eric Biggers <ebiggers@google.com>
    fscrypt: use unbound workqueue for decryption

Xi Wang <wangxi11@huawei.com>
    net: hns3: Fix the missing client list node initialization

Tony Lindgren <tony@atomide.com>
    spi: Add missing pm_runtime_put_noidle() after failed get

Mark Rutland <mark.rutland@arm.com>
    drivers/perf: arm-ccn: don't log to dmesg in event_init

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: based on policy verify firmware signatures (pre-allocated buffer)

Xinming Hu <huxm@marvell.com>
    mwifiex: correct histogram data with appropriate index

Michal Vokáč <vokac.m@gmail.com>
    net: dsa: qca8k: Add support for QCA8334 switch

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: pciehp: Request control of native hotplug only if supported

Sandipan Das <sandipan@linux.vnet.ibm.com>
    bpf: powerpc64: pad function address loads with NOPs

Julia Lawall <Julia.Lawall@lip6.fr>
    pinctrl: at91-pio4: add missing of_node_put

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/8xx: fix invalid register expression in head_8xx.S

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: sh-msiof: Fix setting SIRMDR1.SYNCAC to match SITMDR1.SYNCAC

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

Ezequiel Garcia <ezequiel@collabora.com>
    media: tw686x: Fix incorrect vb2_mem_ops GFP flags

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: Fixes the init of the VALID BD info in the descriptor

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

Thierry Escande <thierry.escande@linaro.org>
    Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning

Shaul Triebitz <shaul.triebitz@intel.com>
    iwlwifi: pcie: fix race in Rx buffer allocator

Ethan Lien <ethanlien@synology.com>
    btrfs: balance dirty metadata pages in btrfs_finish_ordered_io

Jan Kiszka <jan.kiszka@siemens.com>
    PCI: Fix devm_pci_alloc_host_bridge() memory leak

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: intel_pstate: return Kselftest Skip code for skipped tests

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

Sahitya Tummala <stummala@codeaurora.org>
    f2fs: Fix deadlock in shutdown ioctl

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to wait page writeback during revoking atomic write

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to don't trigger writeback during recovery

Chao Yu <yuchao0@huawei.com>
    f2fs: fix error path of move_data_page

Anatoly Pugachev <matorola@gmail.com>
    disable loading f2fs module on PAGE_SIZE > 4KB

Trond Myklebust <trond.myklebust@hammerspace.com>
    pnfs: Don't release the sequence slot until we've processed layoutget on open

Alexey Kodanev <alexey.kodanev@oracle.com>
    netfilter: nf_tables: check msg_type before nft_trans_set(trans)

Javier González <javier@cnexlabs.com>
    lightnvm: pblk: warn in case of corrupted write buffer

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mad: Convert BUG_ONs to error flows

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

Chengguang Xu <cgxu519@gmx.com>
    ceph: fix alignment of rasize

Wang YanQing <udknight@gmail.com>
    bpf, arm32: fix inconsistent naming about emit_a32_lsr_{r64,i64}

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    printk: drop in_nmi check from printk_safe_flush_on_panic()

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

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: ensure rtc_set_alarm fails when alarms are not supported

Mathieu Malaterre <malat@debian.org>
    mm/slub.c: add __printf verification to slab_err()

Chintan Pandya <cpandya@codeaurora.org>
    mm: vmalloc: avoid racy handling of debugobjects in vunmap

Huang Ying <ying.huang@intel.com>
    mm: /proc/pid/pagemap: hide swap entries from unprivileged users

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

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Fix the client behaviour on NFS4ERR_SEQ_FALSE_RETRY

Zhouyang Jia <jiazhouyang09@gmail.com>
    ALSA: fm801: add error handling for snd_ctl_add

Zhouyang Jia <jiazhouyang09@gmail.com>
    ALSA: emu10k1: add error handling for snd_ctl_add

Olga Kornievskaia <olga.kornievskaia@gmail.com>
    skip LAYOUTRETURN if layout is invalid

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix network namespace issues with VF support

Juergen Gross <jgross@suse.com>
    xen/netfront: raise max number of slots in xennet_get_responses()

Mark Rutland <mark.rutland@arm.com>
    kcov: ensure irq code sees a valid area

Petr Machata <petrm@mellanox.com>
    mlxsw: spectrum_switchdev: Fix port_vlan refcounting

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

KT Liao <kt.liao@emc.com.tw>
    Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Chen-Yu Tsai <wens@csie.org>
    Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Donald Shanty III <dshanty@protonmail.com>
    Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Marek Szyprowski <m.szyprowski@samsung.com>
    spi: spi-s3c64xx: Fix system resume support

Andrew Morton <akpm@linux-foundation.org>
    drivers/infiniband/ulp/srpt/ib_srpt.c: fix build with gcc-4.4.4

Bart Van Assche <bart.vanassche@wdc.com>
    IB/srpt: Fix an out-of-bounds stack access in srpt_zerolength_write()

Andrew Morton <akpm@linux-foundation.org>
    drivers/infiniband/core/verbs.c: fix build with gcc-4.4.4

Bart Van Assche <bart.vanassche@wdc.com>
    RDMA/core: Avoid that ib_drain_qp() triggers an out-of-bounds stack access

Lixin Wang <alan.1.wang@nokia-sbell.com>
    i2c: core: decrease reference count of device node in i2c_unregister_device

Kees Cook <keescook@chromium.org>
    fork: unconditionally clear stack on fork


-------------

Diffstat:

 .../devicetree/bindings/net/dsa/qca8k.txt          |  23 ++++-
 .../devicetree/bindings/net/meson-dwmac.txt        |   1 +
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   2 +
 Documentation/vfio-mediated-device.txt             |   5 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/emev2.dtsi                       |   5 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |   5 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |  10 +-
 arch/arm/net/bpf_jit_32.c                          |  10 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  38 ++++---
 arch/arm64/configs/defconfig                       |   2 +
 arch/arm64/include/asm/cmpxchg.h                   |   4 +-
 arch/arm64/mm/init.c                               |   4 +-
 arch/microblaze/boot/Makefile                      |  10 +-
 arch/powerpc/include/asm/barrier.h                 |  15 +++
 arch/powerpc/include/asm/cache.h                   |   3 +
 arch/powerpc/kernel/eeh_driver.c                   |  28 ++---
 arch/powerpc/kernel/head_8xx.S                     |   2 +-
 arch/powerpc/kernel/pci_32.c                       |   1 +
 arch/powerpc/kernel/prom_init.c                    | 114 +++++++++++----------
 arch/powerpc/lib/string.S                          |   7 +-
 arch/powerpc/mm/slb.c                              |   8 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |  34 ++++--
 arch/powerpc/platforms/chrp/time.c                 |   6 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   5 +
 arch/powerpc/platforms/powermac/bootx_init.c       |   4 +-
 arch/powerpc/platforms/powermac/setup.c            |   1 +
 arch/s390/include/asm/cpu_mf.h                     |   6 +-
 arch/x86/events/intel/uncore.c                     |   2 +-
 arch/x86/events/intel/uncore_nhmex.c               |   2 +-
 arch/x86/kernel/cpu/microcode/core.c               |   6 +-
 arch/x86/kvm/mmu.c                                 |   2 +-
 block/bfq-iosched.c                                |   2 -
 block/bio.c                                        |  19 ++--
 crypto/authenc.c                                   |   1 +
 crypto/authencesn.c                                |   1 +
 drivers/acpi/acpi_lpss.c                           |   6 +-
 drivers/acpi/pci_root.c                            |   4 +-
 drivers/ata/libata-eh.c                            |  12 ++-
 drivers/bluetooth/btusb.c                          |   4 +
 drivers/bluetooth/hci_qca.c                        |   2 +-
 drivers/bus/arm-ccn.c                              |  20 ++--
 drivers/char/random.c                              |  10 +-
 drivers/edac/altera_edac.c                         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   8 +-
 drivers/gpu/drm/drm_atomic.c                       |   4 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  78 +++++++-------
 drivers/gpu/drm/drm_dp_mst_topology.c              |   9 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h             |   2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c   |   8 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |  10 +-
 drivers/hid/hid-plantronics.c                      |   6 +-
 drivers/hid/i2c-hid/i2c-hid.c                      |   8 ++
 drivers/i2c/i2c-core-base.c                        |   5 +-
 drivers/infiniband/core/mad.c                      |  11 +-
 drivers/infiniband/core/ucma.c                     |   6 +-
 drivers/infiniband/core/uverbs_cmd.c               |   5 +
 drivers/infiniband/core/verbs.c                    |  12 ++-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  16 +--
 drivers/input/mouse/elan_i2c_core.c                |   2 +
 drivers/input/serio/i8042-x86ia64io.h              |   7 ++
 drivers/irqchip/irq-ls-scfg-msi.c                  |   3 +
 drivers/lightnvm/pblk-rb.c                         |   5 +-
 drivers/md/md.c                                    |   3 +
 drivers/md/raid1.c                                 |   2 +
 drivers/media/common/siano/smsendian.c             |  14 +--
 drivers/media/i2c/smiapp/smiapp-core.c             |  11 +-
 drivers/media/media-device.c                       |  21 ++--
 drivers/media/pci/saa7164/saa7164-fw.c             |   3 +-
 drivers/media/pci/tw686x/tw686x-video.c            |   3 +-
 drivers/media/platform/omap3isp/isp.c              |   7 +-
 drivers/media/platform/rcar_jpu.c                  |   4 +-
 drivers/media/radio/si470x/radio-si470x-i2c.c      |   6 +-
 drivers/media/v4l2-core/videobuf2-core.c           |   9 +-
 drivers/memory/tegra/mc.c                          |  22 +---
 drivers/memory/tegra/mc.h                          |   9 ++
 drivers/memory/tegra/tegra114.c                    |   2 +
 drivers/memory/tegra/tegra124.c                    |   6 ++
 drivers/memory/tegra/tegra210.c                    |   3 +
 drivers/memory/tegra/tegra30.c                     |   2 +
 drivers/mfd/cros_ec.c                              |   6 +-
 drivers/mmc/core/pwrseq_simple.c                   |  14 ++-
 drivers/mmc/host/dw_mmc.c                          |   4 +
 drivers/mtd/nand/fsl_ifc_nand.c                    |  17 +--
 drivers/net/dsa/qca8k.c                            |  52 +++++++++-
 drivers/net/dsa/qca8k.h                            |   7 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   1 +
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   3 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   7 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c |   4 +
 drivers/net/ethernet/intel/e1000e/netdev.c         |  15 ++-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   7 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   9 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   1 +
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ethernet/ti/cpsw-phy-sel.c             |   8 +-
 drivers/net/hyperv/hyperv_net.h                    |   2 +
 drivers/net/hyperv/netvsc_drv.c                    |  43 ++++----
 drivers/net/phy/mdio-mux-bcm-iproc.c               |   2 +-
 drivers/net/phy/phylink.c                          |   2 +
 drivers/net/usb/lan78xx.c                          |   2 +
 drivers/net/wireless/ath/regd.h                    |   5 +
 drivers/net/wireless/ath/regd_common.h             |  13 +++
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   1 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   2 +
 drivers/net/wireless/marvell/mwifiex/usb.c         |   3 +
 drivers/net/wireless/marvell/mwifiex/util.c        |   8 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c             |  35 ++++---
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |  23 +++--
 drivers/net/wireless/rsi/rsi_sdio.h                |   2 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |   5 +
 drivers/net/xen-netfront.c                         |  10 +-
 drivers/nvme/host/pci.c                            |   5 +
 drivers/nvme/host/rdma.c                           |  10 +-
 drivers/nvmem/core.c                               |   7 ++
 drivers/pci/host/pci-xgene.c                       |   1 -
 drivers/pci/hotplug/pciehp_hpc.c                   |   7 ++
 drivers/pci/pci-sysfs.c                            |  15 +--
 drivers/pci/probe.c                                |   4 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |   4 +-
 drivers/regulator/cpcap-regulator.c                |   2 +-
 drivers/regulator/of_regulator.c                   |  13 +--
 drivers/regulator/pfuze100-regulator.c             |   1 +
 drivers/regulator/twl-regulator.c                  |   2 +-
 drivers/rtc/interface.c                            |   5 +
 drivers/rtc/rtc-tps6586x.c                         |  14 ++-
 drivers/rtc/rtc-tps65910.c                         |  12 ++-
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
 drivers/scsi/ufs/ufshcd.c                          |  28 +++--
 drivers/soc/imx/gpcv2.c                            |  22 ++--
 drivers/spi/spi-meson-spicc.c                      |  11 +-
 drivers/spi/spi-s3c64xx.c                          |   4 +-
 drivers/spi/spi-sh-msiof.c                         |   6 +-
 drivers/spi/spi.c                                  |   1 +
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |   2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |  30 +++---
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c     |   6 +-
 drivers/staging/lustre/lustre/llite/xattr.c        |   6 +-
 drivers/staging/media/atomisp/i2c/ov2680.c         |   6 +-
 .../atomisp/pci/atomisp2/atomisp_compat_ioctl32.c  |  49 ++++-----
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |   1 +
 drivers/thermal/samsung/exynos_tmu.c               |   1 +
 drivers/tty/hvc/hvc_opal.c                         |   1 -
 drivers/tty/pty.c                                  |   3 +
 drivers/usb/core/hub.c                             |   4 +
 drivers/usb/gadget/udc/renesas_usb3.c              |   8 +-
 drivers/vfio/mdev/mdev_core.c                      | 102 +++++++-----------
 drivers/vfio/mdev/mdev_private.h                   |   2 +-
 drivers/vfio/platform/vfio_platform_common.c       |  15 ++-
 drivers/vfio/vfio_iommu_type1.c                    |  73 ++++++++-----
 drivers/video/backlight/pwm_bl.c                   |   6 +-
 drivers/watchdog/da9063_wdt.c                      |  17 ++-
 fs/block_dev.c                                     |   9 +-
 fs/btrfs/inode.c                                   |  33 +++---
 fs/btrfs/qgroup.c                                  |  19 ++++
 fs/btrfs/tree-log.c                                |  10 +-
 fs/ceph/super.c                                    |   2 +-
 fs/crypto/crypto.c                                 |  11 +-
 fs/ext4/balloc.c                                   |   3 +
 fs/ext4/ialloc.c                                   |   8 +-
 fs/ext4/inline.c                                   |  19 ++--
 fs/ext4/inode.c                                    |  16 ++-
 fs/ext4/super.c                                    |   8 +-
 fs/f2fs/data.c                                     |   8 +-
 fs/f2fs/file.c                                     |  18 +++-
 fs/f2fs/gc.c                                       |  11 +-
 fs/f2fs/segment.c                                  |   5 +
 fs/f2fs/super.c                                    |   6 ++
 fs/fcntl.c                                         |  15 ++-
 fs/nfs/nfs4proc.c                                  |  14 ++-
 fs/nfs/pnfs.c                                      |   6 +-
 fs/nfsd/nfs4xdr.c                                  |   2 +
 fs/overlayfs/super.c                               |  19 +++-
 fs/proc/task_mmu.c                                 |  26 +++--
 fs/squashfs/cache.c                                |   3 +
 fs/squashfs/file.c                                 |   8 +-
 fs/squashfs/fragment.c                             |   4 +-
 fs/squashfs/squashfs_fs.h                          |   6 ++
 include/drm/drm_dp_helper.h                        |   1 +
 include/linux/delayacct.h                          |   4 +-
 include/linux/dma-iommu.h                          |   1 +
 include/linux/fs.h                                 |   2 +-
 include/linux/mmc/sdio_ids.h                       |   1 +
 include/linux/netfilter/ipset/ip_set_timeout.h     |  10 +-
 include/linux/regulator/consumer.h                 |   1 +
 include/linux/serial_core.h                        |   3 +-
 include/linux/thread_info.h                        |   6 +-
 include/net/tcp.h                                  |   2 +-
 include/soc/tegra/mc.h                             |   2 +
 include/uapi/sound/asoc.h                          |  23 ++++-
 kernel/auditfilter.c                               |   2 +-
 kernel/auditsc.c                                   |   2 +
 kernel/bpf/verifier.c                              |   4 +-
 kernel/delayacct.c                                 |  17 +--
 kernel/fork.c                                      |   3 +-
 kernel/hung_task.c                                 |  11 +-
 kernel/kcov.c                                      |   3 +-
 kernel/kthread.c                                   |   8 +-
 kernel/power/suspend.c                             |  14 +--
 kernel/printk/printk_safe.c                        |   2 +-
 kernel/stop_machine.c                              |  24 ++---
 kernel/trace/trace_events_trigger.c                |  18 +++-
 kernel/trace/trace_kprobe.c                        |  15 ++-
 mm/slub.c                                          |   2 +-
 mm/vmalloc.c                                       |   3 +-
 net/ipv4/fib_frontend.c                            |   4 +-
 net/ipv4/ipconfig.c                                |  13 +++
 net/ipv4/tcp_bbr.c                                 |   4 +
 net/ipv4/tcp_dctcp.c                               |   4 +-
 net/ipv4/tcp_input.c                               |  48 ++++-----
 net/netfilter/ipset/ip_set_hash_gen.h              |   5 +-
 net/netfilter/nf_tables_api.c                      |  11 +-
 net/netlink/af_netlink.c                           |   5 +
 security/integrity/ima/ima_main.c                  |   1 +
 sound/pci/emu10k1/emupcm.c                         |   4 +-
 sound/pci/emu10k1/memory.c                         |   6 +-
 sound/pci/fm801.c                                  |  16 ++-
 sound/pci/hda/patch_ca0132.c                       |   8 +-
 sound/soc/soc-pcm.c                                |   6 +-
 sound/soc/soc-topology.c                           |  19 +++-
 sound/usb/pcm.c                                    |   2 +-
 tools/perf/util/parse-events.y                     |  14 ++-
 tools/testing/selftests/intel_pstate/run.sh        |  29 +++---
 tools/testing/selftests/memfd/run_tests.sh         |  14 ++-
 tools/usb/usbip/libsrc/vhci_driver.c               |  32 +++---
 tools/usb/usbip/libsrc/vhci_driver.h               |   3 +-
 tools/usb/usbip/src/usbip_detach.c                 |   9 +-
 240 files changed, 1573 insertions(+), 835 deletions(-)


