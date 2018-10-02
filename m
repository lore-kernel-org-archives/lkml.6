Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC50C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA912064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA912064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeJBUKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeJBUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:33 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A202BF0;
        Tue,  2 Oct 2018 13:27:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 000/228] 4.18.12-stable review
Date:   Tue,  2 Oct 2018 06:21:37 -0700
Message-Id: <20181002132459.032960735@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.12-rc1
X-KernelTest-Deadline: 2018-10-04T13:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.12 release.
There are 228 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Oct  4 13:24:08 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.12-rc1

Michael Bringmann <mwb@linux.vnet.ibm.com>
    powerpc/pseries: Fix unitialized timer reset on migration

Thiago Jung Bauermann <bauerman@linux.ibm.com>
    powerpc/pkeys: Fix reading of ibm, processor-storage-keys property

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc: fix csum_ipv6_magic() on little endian platforms

Michael Neuling <mikey@neuling.org>
    KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM workarounds

Randy Dunlap <rdunlap@infradead.org>
    x86/pti: Fix section mismatch warning/error

Akshu Agrawal <akshu.agrawal@amd.com>
    clk: x86: Set default parent to 48Mhz

Mika Westerberg <mika.westerberg@linux.intel.com>
    i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc-1.1: Handle function result as parameters

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc-1.1: Make return values unsigned long

Emily Deng <Emily.Deng@amd.com>
    drm/amdgpu: Need to set moved to true when evict bo

Tony Lindgren <tony@atomide.com>
    ARM: dts: omap4-droid4: Fix emmc errors seen on some devices

James Smart <jsmart2021@gmail.com>
    nvme-fcloop: Fix dropped LS's to removed target port

Linus Walleij <linus.walleij@linaro.org>
    ata: ftide010: Add a quirk for SQ201

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Update power state at the end of smu hw_init.

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Enable/disable gfx PG feature in rlc safe mode

Leonard Crestez <leonard.crestez@nxp.com>
    Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"

Dan Carpenter <dan.carpenter@oracle.com>
    hwmon: (adt7475) Make adt7475_read_word() return errors

Lothar Felten <lothar.felten@gmail.com>
    hwmon: (ina2xx) fix sysfs shunt resistor read access

Srikanth Jampala <Jampala.Srikanth@cavium.com>
    crypto: cavium/nitrox - fix for command corruption in queue full case with backlog submissions.

Ganesh Goudar <ganeshgr@chelsio.com>
    crypto: chtls - fix null dereference chtls_free_uld()

Jacob Keller <jacob.e.keller@intel.com>
    i40e: fix condition of WARN_ONCE for stat strings

Martyna Szapar <martyna.szapar@intel.com>
    i40e: Fix for Tx timeouts when interface is brought up if DCB is enabled

Sebastian Basierski <sebastianx.basierski@intel.com>
    ixgbe: fix driver behaviour after issuing VFLR

Bo Chen <chenbo@pdx.edu>
    e1000: ensure to free old tx/rx rings in set_ringparam()

Bo Chen <chenbo@pdx.edu>
    e1000: check on netif_running() before calling e1000_up()

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: Fix potential return of uninitialized value

Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
    ice: Fix a few null pointer dereference issues

Quentin Monnet <quentin.monnet@netronome.com>
    tools: bpftool: return from do_event_pipe() on bad arguments

Brett Creeley <brett.creeley@intel.com>
    ice: Set VLAN flags correctly

Jacob Keller <jacob.e.keller@intel.com>
    ice: Use order_base_2 to calculate higher power of 2

Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
    ice: Fix bugs in control queue processing

Preethi Banala <preethi.banala@intel.com>
    ice: Clean control queues only when they are initialized

Jacob Keller <jacob.e.keller@intel.com>
    ice: Report stats for allocated queues via ethtool stats

Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
    ice: Fix multiple static analyser warnings

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: fix page_offset overflow when CONFIG_ARM64_64K_PAGES

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns: fix skb->truesize underestimation

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_PAGES

Kevin Yang <yyd@google.com>
    tcp_bbr: in restart from idle, see if we should exit PROBE_RTT

Kevin Yang <yyd@google.com>
    tcp_bbr: add bbr_check_probe_rtt_done() helper

Samuel Mendoza-Jonas <sam@mendozajonas.com>
    net/ncsi: Fixup .dumpit message flags and ID check in Netlink handler

Emily Deng <Emily.Deng@amd.com>
    amdgpu: fix multi-process hang issue

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix preamble handling

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix VM clearing for the root PD

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap: write_space events need to be passed to TCP handler

John Fastabend <john.fastabend@gmail.com>
    tls: possible hang when do_tcp_sendpages hits sndbuf is full case

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: fix sock hash count in alloc_sock_hash_elem

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: fix sock_hash_alloc and reject zero-sized keys

Pavel Machek <pavel@ucw.cz>
    ARM: dts: omap4-droid4: fix vibrations on Droid 4

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix no_console_suspend handling

Ludovic Desroches <ludovic.desroches@microchip.com>
    mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer conversion

Ludovic Desroches <ludovic.desroches@microchip.com>
    mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion

Eric Sandeen <sandeen@redhat.com>
    isofs: reject hardware sector size > 2048 bytes

Anson Huang <Anson.Huang@nxp.com>
    thermal: of-thermal: disable passive polling when thermal zone is disabled

Tomer Tayar <Tomer.Tayar@cavium.com>
    qed: Avoid sending mailbox commands when MFW is not responsive

Tomer Tayar <Tomer.Tayar@cavium.com>
    qed: Prevent a possible deadlock during driver load and unload

Tomer Tayar <Tomer.Tayar@cavium.com>
    qed: Wait for MCP halt and resume commands to take place

Tomer Tayar <Tomer.Tayar@cavium.com>
    qed: Wait for ready indication before rereading the shmem

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix module register ioremap for larger offsets

Tony Lindgren <tony@atomide.com>
    ARM: OMAP2+: Fix module address for modules using mpu_rt_idx

Tony Lindgren <tony@atomide.com>
    ARM: OMAP2+: Fix null hwmod for ti-sysc debug

Dave Martin <Dave.Martin@arm.com>
    arm64: KVM: Tighten guest core register access from userspace

Steve Wise <swise@opengridcomputing.com>
    RDMA/uverbs: Atomically flush and mark closed the comp event queue

Mika Westerberg <mika.westerberg@linux.intel.com>
    ACPI / hotplug / PCI: Don't scan for non-hotplug bridges if slot is not bridge

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Fix destroy_qp hang after a link down

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Fix context recovery when PBC has an UnsupportedVL

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Invalid user input can result in crash

Ira Weiny <ira.weiny@intel.com>
    IB/hfi1: Fix SL array bounds check

Bart Van Assche <bvanassche@acm.org>
    IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop

Aaron Ma <aaron.ma@canonical.com>
    Input: elantech - enable middle button of touchpad on ThinkPad P72

Matthew Wilcox <willy@infradead.org>
    filesystem-dax: Fix use of zero page

Toshi Kani <toshi.kani@hpe.com>
    ext2, dax: set ext2_dax_aops for dax files

Dave Jiang <dave.jiang@intel.com>
    uaccess: Fix is_source param for check_copy_size() in copy_to_iter_mcsafe()

Alan Stern <stern@rowland.harvard.edu>
    USB: remove LPM management from usb_driver_claim_interface()

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()"

Oliver Neukum <oneukum@suse.com>
    USB: usbdevfs: restore warning for nonsensical flags

Oliver Neukum <oneukum@suse.com>
    USB: usbdevfs: sanitize flags more

Bin Liu <b-liu@ti.com>
    usb: musb: dsps: do not disable CPPI41 irq in driver teardown

Harry Pan <harry.pan@intel.com>
    usb: core: safely deal with the dynamic quirk lists

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: roles: Take care of driver module reference counting

Alan Stern <stern@rowland.harvard.edu>
    USB: handle NULL config in usb_find_alt_setting()

Alan Stern <stern@rowland.harvard.edu>
    USB: fix error handling in usb_driver_claim_interface()

Marek Szyprowski <m.szyprowski@samsung.com>
    regulator: Fix 'do-nothing' value for regulators without suspend state

Yu Zhao <yuzhao@google.com>
    regulator: fix crash caused by null driver data

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: rspi: Fix interrupted DMA transfers

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: rspi: Fix invalid SPI use during system suspend

Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
    spi: sh-msiof: Fix handling of write value for SISTR register

Gaku Inami <gaku.inami.xw@bp.renesas.com>
    spi: sh-msiof: Fix invalid SPI use during system suspend

Marcel Ziswiler <marcel.ziswiler@toradex.com>
    spi: tegra20-slink: explicitly enable/disable clock

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: Fix resource handling for ACPI glue layer

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: Fix device removal logic

Christophe Leroy <christophe.leroy@c-s.fr>
    serial: cpm_uart: return immediately from console poll

Jan Kiszka <jan.kiszka@siemens.com>
    serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: imx: restore handshaking irq for imx1

Stefan Agner <stefan@agner.ch>
    tty: serial: lpuart: avoid leaking struct tty_struct

Feng Tang <feng.tang@intel.com>
    x86/mm: Expand static page table for fixmap space

Damien Le Moal <damien.lemoal@wdc.com>
    block: fix deadline elevator drain for zoned block devices

Andy Whitcroft <apw@canonical.com>
    floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Dmitry Osipenko <digetx@gmail.com>
    gpio: tegra: Fix tegra_gpio_irq_set_type()

Sandipan Das <sandipan@linux.ibm.com>
    perf tests: Fix indexing when invoking subtests

Maxime Ripard <maxime.ripard@bootlin.com>
    drm/vc4: plane: Expand the lower bits by repeating the higher bits

Kevin Hilman <khilman@baylibre.com>
    ARM: dts: dra7: fix DCAN node addresses

Eric Anholt <eric@anholt.net>
    drm/vc4: Add missing formats to vc4_format_mod_supported().

William Breathitt Gray <vilhelm.gray@gmail.com>
    iio: 104-quad-8: Fix off-by-one error in register selection

Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
    Input: xen-kbdfront - fix multi-touch XenStore node's locations

Colin Ian King <colin.king@canonical.com>
    ath10k: fix memory leak of tpc_stats

Konstantin Khorenko <khorenko@virtuozzo.com>
    fs/lock: skip lock owner pid translation in case we are in init_pid_ns

Brian Norris <briannorris@chromium.org>
    ath10k: snoc: use correct bus-specific pointer in RX retry

YueHaibing <yuehaibing@huawei.com>
    ath10k: fix incorrect size of dma_free_coherent in ath10k_ce_alloc_src_ring_64

Hugo Lefeuvre <hle@owl.eu.com>
    staging: pi433: fix race condition in pi433_ioctl

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    EDAC, altera: Fix an error handling path in altr_s10_sdram_probe()

Johan Hovold <johan@kernel.org>
    EDAC: Fix memleak in module init error path

J. Bruce Fields <bfields@redhat.com>
    nfsd: fix corrupted reply to badly ordered compound

Nadav Amit <namit@vmware.com>
    gpio: Fix wrong rounding in gpio-menz127

Jessica Yu <jeyu@kernel.org>
    module: exclude SHN_UNDEF symbols from kallsyms api

Liam Girdwood <liam.r.girdwood@linux.intel.com>
    ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs

Johan Hovold <johan@kernel.org>
    EDAC, i7core: Fix memleaks and use-after-free on probe and remove

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: SSI parent cares SWSP bit

Geert Uytterhoeven <geert@linux-m68k.org>
    ASoC: rt1305: Use ULL suffixes for 64-bit constants

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Fix Acer Iconia 8 over-current detect threshold

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Update controller info during resume

Jan Kundrát <jan.kundrat@cesnet.cz>
    spi: orion: fix CS GPIO handling again

Xiaofei Tan <tanxiaofei@huawei.com>
    scsi: hisi_sas: Fix the conflict between dev gone and host reset

Andreas Gruenbacher <agruenba@redhat.com>
    iomap: complete partial direct I/O writes synchronously

Zhouyang Jia <jiazhouyang09@gmail.com>
    scsi: bnx2i: add error handling for ioremap_nocache

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/lbr: Fix incomplete LBR call stack

Eric Anholt <eric@anholt.net>
    drm/v3d: Take a lock across GPU scheduler job creation and queuing.

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    arm64: dts: renesas: Fix VSPD registers range

Masahiro Yamada <yamada.masahiro@socionext.com>
    MIPS: boot: fix build rule of vmlinux.its.S

Stephen Boyd <swboyd@chromium.org>
    HID: i2c-hid: Use devm to allocate i2c_hid struct

Zhouyang Jia <jiazhouyang09@gmail.com>
    HID: hid-ntrig: add error handling for sysfs_create_group

Viresh Kumar <viresh.kumar@linaro.org>
    arm: dts: mediatek: Add missing cooling device properties for CPUs

Frederic Weisbecker <frederic@kernel.org>
    perf/hw_breakpoint: Split attribute parse and commit

Randy Dunlap <rdunlap@infradead.org>
    Documentation/process: fix reST table border error

Leon Romanovsky <leon@kernel.org>
    RDMA/uverbs: Don't overwrite NULL pointer with ZERO_SIZE_PTR

Ethan Tuttle <ethan@ethantuttle.com>
    ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/omap: gem: Fix mm_list locking

Tony Lindgren <tony@atomide.com>
    wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()

Johannes Berg <johannes@sipsolutions.net>
    bitfield: fix *_encode_bits()

Stefan Agner <stefan@agner.ch>
    brcmsmac: fix wrap around in conversion from constant to s16

Dan Carpenter <dan.carpenter@oracle.com>
    rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x2: fix mrr idx/count estimation in mt76x2_mac_fill_tx_status()

Niklas Cassel <niklas.cassel@linaro.org>
    ath10k: transmit queued frames after processing rx packets

Jernej Skrabec <jernej.skrabec@siol.net>
    drm/sun4i: Fix releasing node when enumerating enpoints

Brandon Maier <brandon.maier@rockwellcollins.com>
    net: phy: xgmiitorgmii: Check phy_driver ready before accessing

Jernej Skrabec <jernej.skrabec@siol.net>
    drm/sun4i: Enable DW HDMI PHY clock

Ben Greear <greearb@candelatech.com>
    ath10k: protect ath10k_htt_rx_ring_free with rx_ring.lock

Brandon Maier <brandon.maier@rockwellcollins.com>
    net: phy: xgmiitorgmii: Check read_status results

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD Raven Ridge

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: qdsp6: qdafe: fix some off by one bugs

Zhouyang Jia <jiazhouyang09@gmail.com>
    media: tm6000: add error handling for dvb_register_adapter

Rosen Penev <rosenp@gmail.com>
    staging: mt7621-dts: Fix remaining pcie warnings

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    serial: pxa: Fix an error handling path in 'serial_pxa_probe()'

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: salvator-common: Fix adv7482 decimal unit addresses

Zhouyang Jia <jiazhouyang09@gmail.com>
    drivers/tty: add error handling for pcmcia_loop_config

Kamal Heib <kamalheib1@gmail.com>
    staging: mt7621-eth: Fix memory leak in mtk_add_mac() error path

Akinobu Mita <akinobu.mita@gmail.com>
    media: ov772x: allow i2c controllers without I2C_FUNC_PROTOCOL_MANGLING

Alistair Strachan <astrachan@google.com>
    staging: android: ashmem: Fix mmap size validation

Akinobu Mita <akinobu.mita@gmail.com>
    media: ov772x: add checks for register read errors

Javier Martinez Canillas <javierm@redhat.com>
    media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data

Akinobu Mita <akinobu.mita@gmail.com>
    media: soc_camera: ov772x: correct setting of banding filter

Akinobu Mita <akinobu.mita@gmail.com>
    media: s3c-camif: ignore -ENOIOCTLCMD from v4l2_subdev_call for s_power

Bob Copeland <me@bobcopeland.com>
    ath10k: use locked skb_dequeue for rx completions

Petr Machata <petrm@mellanox.com>
    selftests: forwarding: Tweak tc filters for mirror-to-gretap tests

Nicholas Mc Guire <hofrat@osadl.org>
    ALSA: snd-aoa: add of_node_put() in error path

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Sanitize overrun handling

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Make forward callback return s64

Akinobu Mita <akinobu.mita@gmail.com>
    iio: accel: adxl345: convert address field usage in iio_chan_spec

Peter Rosin <peda@axentia.se>
    mtd: rawnand: atmel: add module param to avoid using dma

Vasily Gorbik <gor@linux.ibm.com>
    s390/extmem: fix gcc 8 stringop-overflow warning

Vasily Gorbik <gor@linux.ibm.com>
    s390/scm_blk: correct numa_node in scm_blk_dev_setup

Vasily Gorbik <gor@linux.ibm.com>
    s390/dasd: correct numa_node in dasd_alloc_queue

Thomas Gleixner <tglx@linutronix.de>
    alarmtimer: Prevent overflow for relative nanosleep

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390/sysinfo: add missing #ifdef CONFIG_PROC_FS

Ravi Chandra Sadineni <ravisadineni@chromium.org>
    ACPI / button: increment wakeup count only when notified

João Paulo Rechi Vita <jprvita@endlessm.com>
    platform/x86: asus-wireless: Fix uninitialized symbol usage

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/powernv/ioda2: Reduce upper limit for DMA window size

Alagu Sankar <alagusankar@silex-india.com>
    ath10k: sdio: set skb len for all rx packets

Alagu Sankar <alagusankar@silex-india.com>
    ath10k: sdio: use same endpoint id for all packets in a bundle

Julia Lawall <Julia.Lawall@lip6.fr>
    usb: wusbcore: security: cast sizeof to int for comparison

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: target: Avoid that EXTENDED COPY commands trigger lock inversion

Breno Leitao <leitao@debian.org>
    scsi: ibmvscsi: Improve strings handling

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: klist: Make it safe to use klists in atomic context

Jean-Christophe Dubois <jcd@tribudubois.net>
    thermal: i.MX: Allow thermal probe to fail gracefully in case of bad calibration.

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: target/iscsi: Make iscsit_ta_authentication() respect the output buffer size

Viresh Kumar <viresh.kumar@linaro.org>
    ARM: dts: ls1021a: Add missing cooling device properties for CPUs

Jan Beulich <JBeulich@suse.com>
    x86/entry/64: Add two more instruction suffixes

Dave Gerlach <d-gerlach@ti.com>
    ARM: hwmod: RTC: Don't assume lock/unlock will be called with irq enabled

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    x86/tsc: Add missing header to tsc_msr.c

Bart Van Assche <bart.vanassche@wdc.com>
    include/rdma/opa_addr.h: Fix an endianness issue

Maor Gottlieb <maorg@mellanox.com>
    IB/mlx5: Fix GRE flow specification

Peter Seiderer <ps.report@gmx.net>
    media: staging/imx: fill vb2_v4l2_buffer field entry

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    vhost_net: Avoid tx vring kicks during busyloop

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: fsl-viu: fix error handling in viu_of_probe()

Hari Bathini <hbathini@linux.ibm.com>
    powerpc/kdump: Handle crashkernel memory reservation failure

Tarick Bedeir <tarick@google.com>
    IB/mlx4: Test port number before querying type.

Sylwester Nawrocki <s.nawrocki@samsung.com>
    media: exynos4-is: Prevent NULL pointer dereference in __isp_video_try_fmt()

Dan Carpenter <dan.carpenter@oracle.com>
    IB/core: type promotion bug in rdma_rw_init_one_mr()

Dan Carpenter <dan.carpenter@oracle.com>
    RDMA/bnxt_re: Fix a bunch of off by one bugs in qplib_fp.c

Leon Romanovsky <leon@kernel.org>
    RDMA/i40w: Hold read semaphore while looking after VMA

Dan Carpenter <dan.carpenter@oracle.com>
    RDMA/bnxt_re: Fix a couple off by one bugs

Ganesh Goudar <ganeshgr@chelsio.com>
    cxgb4: Fix the condition to check if the card is T5

Guoqing Jiang <gqjiang@suse.com>
    md-cluster: clear another node's suspend_area after the copy is finished

Wesley Chalmers <Wesley.Chalmers@amd.com>
    drm/amd/display: fix use of uninitialized memory

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/amd/display/dc/dce: Fix multiple potential integer overflows

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    power: remove possible deadlock when unregistering power_supply

Vasily Gorbik <gor@linux.ibm.com>
    s390/mm: correct allocate_pgste proc_handler callback

Niklas Cassel <niklas.cassel@linaro.org>
    iommu/msm: Don't call iommu_device_{,un}link from atomic context

Michael Scott <michael@opensourcefoundries.com>
    6lowpan: iphc: reset mac_header after decompress to fix panic

Johan Hovold <johan@kernel.org>
    USB: serial: kobil_sct: fix modem-status error handling

Jian-Hong Pan <jian-hong@endlessm.com>
    Bluetooth: Add a new Realtek 8723DE ID 0bda:b009

Zhen Lei <thunder.leizhen@huawei.com>
    iommu/amd: make sure TLB to be flushed before IOVA freed

Sudeep Holla <sudeep.holla@arm.com>
    power: vexpress: fix corruption in notifier registration

Anton Vasilyev <vasilyev@ispras.ru>
    uwb: hwa-rc: fix memory leak at probe

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Stop RX FIFO timer during port shutdown

Johan Hovold <johan@kernel.org>
    misc: sram: enable clock before registering regions

Hans de Goede <hdegoede@redhat.com>
    power: supply: axp288_charger: Fix initial constant_charge_current value

Colin Ian King <colin.king@canonical.com>
    staging: rts5208: fix missing error check on call to rtsx_write_register

Dan Williams <dan.j.williams@intel.com>
    x86/numa_emulation: Fix emulated-to-physical node mapping

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix get_vector ops in hclgevf_main module

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix warning bug when doing lp selftest

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix for mac pause not disable in pfc mode

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: Fix for mailbox message truncated problem

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    siox: don't create a thread without starting it

Dan Carpenter <dan.carpenter@oracle.com>
    vmci: type promotion bug in qp_host_get_user_memory()

Wei Yongjun <weiyongjun1@huawei.com>
    misc: ibmvmc: Use GFP_ATOMIC under spin lock

Matt Ranostay <matt.ranostay@konsulko.com>
    tsl2550: fix lux1_input error in low light

Akinobu Mita <akinobu.mita@gmail.com>
    iio: adc: ina2xx: avoid kthread_stop() with stale task_struct

Stafford Horne <shorne@gmail.com>
    crypto: skcipher - Fix -Wstringop-truncation warnings


-------------

Diffstat:

 Documentation/hwmon/ina2xx                         |   2 +-
 Documentation/process/2.Process.rst                |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/dra7.dtsi                        |   4 +-
 arch/arm/boot/dts/imx7d.dtsi                       |  12 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |   1 +
 arch/arm/boot/dts/mt7623.dtsi                      |   3 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  20 +--
 arch/arm/mach-mvebu/pmsu.c                         |   6 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  39 ++++-
 arch/arm/mach-omap2/omap_hwmod_reset.c             |  12 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |   2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   6 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   6 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |   4 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |   2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |   4 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   4 +-
 arch/arm64/kvm/guest.c                             |  45 +++++
 arch/mips/boot/Makefile                            |   6 +-
 arch/powerpc/kernel/exceptions-64s.S               |   4 +-
 arch/powerpc/kernel/machine_kexec.c                |   7 +-
 arch/powerpc/lib/checksum_64.S                     |   3 +
 arch/powerpc/mm/numa.c                             |   3 +-
 arch/powerpc/mm/pkeys.c                            |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   2 +-
 arch/s390/kernel/sysinfo.c                         |   4 +
 arch/s390/mm/extmem.c                              |   4 +-
 arch/s390/mm/pgalloc.c                             |   2 +-
 arch/x86/entry/entry_64.S                          |   4 +-
 arch/x86/events/intel/lbr.c                        |  32 +++-
 arch/x86/events/perf_event.h                       |   1 +
 arch/x86/include/asm/fixmap.h                      |  10 ++
 arch/x86/include/asm/pgtable_64.h                  |   3 +-
 arch/x86/kernel/head64.c                           |   4 +-
 arch/x86/kernel/head_64.S                          |  16 +-
 arch/x86/kernel/tsc_msr.c                          |   1 +
 arch/x86/mm/numa_emulation.c                       |   2 +-
 arch/x86/mm/pgtable.c                              |   9 +
 arch/x86/mm/pti.c                                  |   2 +-
 arch/x86/xen/mmu_pv.c                              |   8 +-
 block/elevator.c                                   |   2 +-
 crypto/ablkcipher.c                                |   2 +
 crypto/blkcipher.c                                 |   1 +
 drivers/acpi/button.c                              |  13 +-
 drivers/ata/pata_ftide010.c                        |  27 +--
 drivers/block/floppy.c                             |   3 +
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/bus/ti-sysc.c                              |  37 ++--
 drivers/clk/x86/clk-st.c                           |   2 +-
 drivers/crypto/cavium/nitrox/nitrox_dev.h          |   3 +-
 drivers/crypto/cavium/nitrox/nitrox_lib.c          |   1 +
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c       |  57 ++++---
 drivers/crypto/chelsio/chtls/chtls.h               |   5 +
 drivers/crypto/chelsio/chtls/chtls_main.c          |   7 +-
 drivers/edac/altera_edac.c                         |   3 +-
 drivers/edac/edac_mc_sysfs.c                       |   6 +-
 drivers/edac/i7core_edac.c                         |  22 ++-
 drivers/gpio/gpio-menz127.c                        |   4 +-
 drivers/gpio/gpio-tegra.c                          |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  11 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |   4 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |   3 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  10 +-
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |   2 +
 drivers/gpu/drm/omapdrm/omap_debugfs.c             |   2 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   2 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |   2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |  15 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   3 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |   7 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |   5 +
 drivers/gpu/drm/v3d/v3d_gem.c                      |   4 +
 drivers/gpu/drm/vc4/vc4_plane.c                    |   3 +
 drivers/hid/hid-ntrig.c                            |   2 +
 drivers/hid/i2c-hid/i2c-hid.c                      |   9 +-
 drivers/hwmon/adt7475.c                            |  14 +-
 drivers/hwmon/ina2xx.c                             |  13 +-
 drivers/hwtracing/intel_th/core.c                  |  16 +-
 drivers/i2c/busses/i2c-i801.c                      |   9 +-
 drivers/iio/accel/adxl345_core.c                   |  21 ++-
 drivers/iio/adc/ina2xx-adc.c                       |  17 +-
 drivers/iio/counter/104-quad-8.c                   |   2 +-
 drivers/infiniband/core/rw.c                       |   2 +-
 drivers/infiniband/core/uverbs_cmd.c               |   5 +-
 drivers/infiniband/core/uverbs_main.c              |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   4 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   6 +-
 drivers/infiniband/hw/hfi1/pio.c                   |  51 ++++--
 drivers/infiniband/hw/hfi1/pio.h                   |   2 +
 drivers/infiniband/hw/hfi1/user_sdma.c             |   2 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |   8 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |   2 +
 drivers/infiniband/hw/mlx4/qp.c                    |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   6 +-
 drivers/input/misc/xen-kbdfront.c                  |   8 +-
 drivers/input/mouse/elantech.c                     |   2 +
 drivers/iommu/amd_iommu.c                          |   2 +-
 drivers/iommu/msm_iommu.c                          |  16 +-
 drivers/md/md-cluster.c                            |  19 ++-
 drivers/media/i2c/ov772x.c                         |  40 +++--
 drivers/media/i2c/soc_camera/ov772x.c              |   2 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c |  11 +-
 drivers/media/platform/fsl-viu.c                   |  38 +++--
 drivers/media/platform/omap3isp/isp.c              |   2 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |   2 +
 drivers/media/usb/tm6000/tm6000-dvb.c              |   5 +
 drivers/misc/ibmvmc.c                              |   2 +-
 drivers/misc/sram.c                                |  13 +-
 drivers/misc/tsl2550.c                             |   2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |   4 +-
 drivers/mmc/host/android-goldfish.c                |   4 +-
 drivers/mmc/host/atmel-mci.c                       |  12 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c       |   7 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   2 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h          |   6 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   6 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   2 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   9 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  11 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   3 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  15 +-
 drivers/net/ethernet/intel/ice/ice.h               |   7 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |  25 +--
 drivers/net/ethernet/intel/ice/ice_common.c        |  27 +--
 drivers/net/ethernet/intel/ice/ice_controlq.c      |  29 +++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  52 ++++--
 drivers/net/ethernet/intel/ice/ice_main.c          |  98 ++++++-----
 drivers/net/ethernet/intel/ice/ice_switch.c        |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  26 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |   1 +
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          | 187 +++++++++++++++++----
 drivers/net/ethernet/qlogic/qed/qed_mcp.h          |  27 ++-
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h     |   2 +
 drivers/net/phy/xilinx_gmii2rgmii.c                |  10 +-
 drivers/net/wireless/ath/ath10k/ce.c               |   2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |  13 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   1 +
 drivers/net/wireless/ath/ath10k/sdio.c             |   9 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |   2 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   8 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_qmath.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c    |   6 +-
 drivers/net/wireless/rndis_wlan.c                  |   2 +
 drivers/net/wireless/ti/wlcore/cmd.c               |   6 +
 drivers/nvme/target/fcloop.c                       |   3 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  11 +-
 drivers/platform/x86/asus-wireless.c               |  23 +--
 drivers/power/reset/vexpress-poweroff.c            |  12 +-
 drivers/power/supply/axp288_charger.c              |   2 +-
 drivers/power/supply/power_supply_core.c           |  11 +-
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/of_regulator.c                   |   2 -
 drivers/s390/block/dasd.c                          |   1 +
 drivers/s390/block/scm_blk.c                       |   1 +
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |   2 +
 drivers/scsi/hisi_sas/hisi_sas.h                   |   1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c              |   6 +
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |   4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   3 +
 drivers/siox/siox-core.c                           |  10 +-
 drivers/spi/spi-orion.c                            |  77 +++++----
 drivers/spi/spi-rspi.c                             |  34 +++-
 drivers/spi/spi-sh-msiof.c                         |  28 ++-
 drivers/spi/spi-tegra20-slink.c                    |  31 +++-
 drivers/staging/android/ashmem.c                   |   6 +
 drivers/staging/media/imx/imx-ic-prpencvf.c        |   1 +
 drivers/staging/media/imx/imx-media-csi.c          |   1 +
 drivers/staging/mt7621-dts/gbpc1.dts               |   2 +
 drivers/staging/mt7621-dts/mt7621.dtsi             |  21 +--
 drivers/staging/mt7621-eth/mtk_eth_soc.c           |  13 +-
 drivers/staging/pi433/pi433_if.c                   |   7 +-
 drivers/staging/rts5208/sd.c                       |   2 +-
 drivers/target/iscsi/iscsi_target_tpg.c            |   3 +-
 drivers/target/target_core_device.c                |  22 ++-
 drivers/thermal/imx_thermal.c                      |   5 +-
 drivers/thermal/of-thermal.c                       |   7 +-
 drivers/tty/serial/8250/serial_cs.c                |   6 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  10 +-
 drivers/tty/serial/fsl_lpuart.c                    |   3 +-
 drivers/tty/serial/imx.c                           |   8 +
 drivers/tty/serial/mvebu-uart.c                    |   1 +
 drivers/tty/serial/pxa.c                           |   3 +-
 drivers/tty/serial/sh-sci.c                        |   2 +
 drivers/usb/class/cdc-wdm.c                        |   2 +-
 drivers/usb/common/roles.c                         |  15 +-
 drivers/usb/core/devio.c                           |  24 ++-
 drivers/usb/core/driver.c                          |  28 +--
 drivers/usb/core/quirks.c                          |   3 +-
 drivers/usb/core/usb.c                             |   2 +
 drivers/usb/musb/musb_dsps.c                       |  12 +-
 drivers/usb/serial/kobil_sct.c                     |  12 +-
 drivers/usb/wusbcore/security.c                    |   2 +-
 drivers/uwb/hwa-rc.c                               |   1 +
 drivers/vhost/net.c                                |  35 ++--
 fs/dax.c                                           |  13 +-
 fs/ext2/inode.c                                    |   2 +-
 fs/iomap.c                                         |  21 +--
 fs/isofs/inode.c                                   |   7 +
 fs/locks.c                                         |   7 +
 fs/nfsd/nfs4proc.c                                 |   1 +
 include/linux/arm-smccc.h                          |  38 +++--
 include/linux/bitfield.h                           |   6 +-
 include/linux/platform_data/ina2xx.h               |   2 +-
 include/linux/posix-timers.h                       |   4 +-
 include/linux/power_supply.h                       |   1 +
 include/linux/regulator/machine.h                  |   6 +-
 include/linux/uio.h                                |   2 +-
 include/rdma/opa_addr.h                            |   2 +-
 kernel/bpf/sockmap.c                               |  11 +-
 kernel/events/hw_breakpoint.c                      |  57 +++++--
 kernel/module.c                                    |   6 +-
 kernel/time/alarmtimer.c                           |   7 +-
 kernel/time/posix-cpu-timers.c                     |   2 +-
 kernel/time/posix-timers.c                         |  33 ++--
 kernel/time/posix-timers.h                         |   2 +-
 lib/klist.c                                        |  10 +-
 net/6lowpan/iphc.c                                 |   1 +
 net/ipv4/tcp_bbr.c                                 |  38 +++--
 net/ncsi/ncsi-netlink.c                            |   4 +-
 net/tls/tls_main.c                                 |   9 +-
 sound/aoa/core/gpio-feature.c                      |   4 +-
 sound/pci/hda/hda_intel.c                          |   3 +-
 sound/soc/codecs/rt1305.c                          |   4 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   2 +-
 sound/soc/qcom/qdsp6/q6afe.c                       |   6 +-
 sound/soc/sh/rcar/ssi.c                            |  32 ++--
 sound/soc/soc-dapm.c                               |   7 +
 tools/bpf/bpftool/map_perf_ring.c                  |   5 +-
 tools/perf/tests/builtin-test.c                    |   2 +-
 .../net/forwarding/mirror_gre_bridge_1d_vlan.sh    |   6 +-
 .../selftests/net/forwarding/mirror_gre_lib.sh     |   2 +-
 .../net/forwarding/mirror_gre_vlan_bridge_1q.sh    |   6 +-
 241 files changed, 1730 insertions(+), 789 deletions(-)


