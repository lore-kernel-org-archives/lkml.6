Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966DEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AED204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AED204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbeJBUPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:15:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbeJBUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:15:12 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33A0DC2B;
        Tue,  2 Oct 2018 13:31:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/137] 4.14.74-stable review
Date:   Tue,  2 Oct 2018 06:23:21 -0700
Message-Id: <20181002132458.446916963@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.74-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.74-rc1
X-KernelTest-Deadline: 2018-10-04T13:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.74 release.
There are 137 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Oct  4 13:24:18 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.74-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.74-rc1

Randy Dunlap <rdunlap@infradead.org>
    x86/pti: Fix section mismatch warning/error

Mika Westerberg <mika.westerberg@linux.intel.com>
    i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc-1.1: Handle function result as parameters

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc-1.1: Make return values unsigned long

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

Bo Chen <chenbo@pdx.edu>
    e1000: ensure to free old tx/rx rings in set_ringparam()

Bo Chen <chenbo@pdx.edu>
    e1000: check on netif_running() before calling e1000_up()

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns: fix skb->truesize underestimation

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_PAGES

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap: write_space events need to be passed to TCP handler

John Fastabend <john.fastabend@gmail.com>
    tls: possible hang when do_tcp_sendpages hits sndbuf is full case

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

Dave Martin <Dave.Martin@arm.com>
    arm64: KVM: Tighten guest core register access from userspace

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: imx: restore handshaking irq for imx1

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915: Remove vma from object on destroy, not close

Amir Goldstein <amir73il@gmail.com>
    ovl: hash non-dir by lower inode for fsnotify

Steve Wise <swise@opengridcomputing.com>
    RDMA/uverbs: Atomically flush and mark closed the comp event queue

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

Alan Stern <stern@rowland.harvard.edu>
    USB: remove LPM management from usb_driver_claim_interface()

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()"

Oliver Neukum <oneukum@suse.com>
    USB: usbdevfs: restore warning for nonsensical flags

Oliver Neukum <oneukum@suse.com>
    USB: usbdevfs: sanitize flags more

ming_qian <ming_qian@realsil.com.cn>
    media: uvcvideo: Support realtek's UVC 1.5 device

Alexey Dobriyan <adobriyan@gmail.com>
    slub: make ->cpu_partial unsigned int

Bin Liu <b-liu@ti.com>
    usb: musb: dsps: do not disable CPPI41 irq in driver teardown

Alan Stern <stern@rowland.harvard.edu>
    USB: handle NULL config in usb_find_alt_setting()

Alan Stern <stern@rowland.harvard.edu>
    USB: fix error handling in usb_driver_claim_interface()

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
    intel_th: Fix device removal logic

Christophe Leroy <christophe.leroy@c-s.fr>
    serial: cpm_uart: return immediately from console poll

Stefan Agner <stefan@agner.ch>
    tty: serial: lpuart: avoid leaking struct tty_struct

Feng Tang <feng.tang@intel.com>
    x86/mm: Expand static page table for fixmap space

Andy Whitcroft <apw@canonical.com>
    floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Kevin Hilman <khilman@baylibre.com>
    ARM: dts: dra7: fix DCAN node addresses

William Breathitt Gray <vilhelm.gray@gmail.com>
    iio: 104-quad-8: Fix off-by-one error in register selection

Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
    Input: xen-kbdfront - fix multi-touch XenStore node's locations

Konstantin Khorenko <khorenko@virtuozzo.com>
    fs/lock: skip lock owner pid translation in case we are in init_pid_ns

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

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Update controller info during resume

Andreas Gruenbacher <agruenba@redhat.com>
    iomap: complete partial direct I/O writes synchronously

Zhouyang Jia <jiazhouyang09@gmail.com>
    scsi: bnx2i: add error handling for ioremap_nocache

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/lbr: Fix incomplete LBR call stack

Masahiro Yamada <yamada.masahiro@socionext.com>
    MIPS: boot: fix build rule of vmlinux.its.S

Zhouyang Jia <jiazhouyang09@gmail.com>
    HID: hid-ntrig: add error handling for sysfs_create_group

Viresh Kumar <viresh.kumar@linaro.org>
    arm: dts: mediatek: Add missing cooling device properties for CPUs

Ethan Tuttle <ethan@ethantuttle.com>
    ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Tony Lindgren <tony@atomide.com>
    wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()

Stefan Agner <stefan@agner.ch>
    brcmsmac: fix wrap around in conversion from constant to s16

Dan Carpenter <dan.carpenter@oracle.com>
    rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()

Niklas Cassel <niklas.cassel@linaro.org>
    ath10k: transmit queued frames after processing rx packets

Jernej Skrabec <jernej.skrabec@siol.net>
    drm/sun4i: Fix releasing node when enumerating enpoints

Brandon Maier <brandon.maier@rockwellcollins.com>
    net: phy: xgmiitorgmii: Check phy_driver ready before accessing

Ben Greear <greearb@candelatech.com>
    ath10k: protect ath10k_htt_rx_ring_free with rx_ring.lock

Brandon Maier <brandon.maier@rockwellcollins.com>
    net: phy: xgmiitorgmii: Check read_status results

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD Raven Ridge

Zhouyang Jia <jiazhouyang09@gmail.com>
    media: tm6000: add error handling for dvb_register_adapter

Zhouyang Jia <jiazhouyang09@gmail.com>
    drivers/tty: add error handling for pcmcia_loop_config

Alistair Strachan <astrachan@google.com>
    staging: android: ashmem: Fix mmap size validation

Javier Martinez Canillas <javierm@redhat.com>
    media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data

Akinobu Mita <akinobu.mita@gmail.com>
    media: soc_camera: ov772x: correct setting of banding filter

Akinobu Mita <akinobu.mita@gmail.com>
    media: s3c-camif: ignore -ENOIOCTLCMD from v4l2_subdev_call for s_power

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

Peter Seiderer <ps.report@gmx.net>
    media: staging/imx: fill vb2_v4l2_buffer field entry

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

Leon Romanovsky <leonro@mellanox.com>
    RDMA/i40w: Hold read semaphore while looking after VMA

Dan Carpenter <dan.carpenter@oracle.com>
    RDMA/bnxt_re: Fix a couple off by one bugs

Guoqing Jiang <gqjiang@suse.com>
    md-cluster: clear another node's suspend_area after the copy is finished

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

Dan Carpenter <dan.carpenter@oracle.com>
    vmci: type promotion bug in qp_host_get_user_memory()

Matt Ranostay <matt.ranostay@konsulko.com>
    tsl2550: fix lux1_input error in low light

Akinobu Mita <akinobu.mita@gmail.com>
    iio: adc: ina2xx: avoid kthread_stop() with stale task_struct

Stafford Horne <shorne@gmail.com>
    crypto: skcipher - Fix -Wstringop-truncation warnings


-------------

Diffstat:

 Documentation/hwmon/ina2xx                         |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/dra7.dtsi                        |   4 +-
 arch/arm/boot/dts/imx7d.dtsi                       |  12 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |   1 +
 arch/arm/boot/dts/mt7623.dtsi                      |   3 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   2 +-
 arch/arm/mach-mvebu/pmsu.c                         |   6 +-
 arch/arm/mach-omap2/omap_hwmod_reset.c             |  12 +-
 arch/arm64/kvm/guest.c                             |  45 +++++
 arch/mips/boot/Makefile                            |   6 +-
 arch/powerpc/kernel/machine_kexec.c                |   7 +-
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
 crypto/ablkcipher.c                                |   2 +
 crypto/blkcipher.c                                 |   1 +
 drivers/ata/pata_ftide010.c                        |  27 +--
 drivers/block/floppy.c                             |   3 +
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/crypto/cavium/nitrox/nitrox_dev.h          |   3 +-
 drivers/crypto/cavium/nitrox/nitrox_lib.c          |   1 +
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c       |  57 ++++---
 drivers/edac/edac_mc_sysfs.c                       |   6 +-
 drivers/edac/i7core_edac.c                         |  22 ++-
 drivers/gpio/gpio-menz127.c                        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  11 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |   4 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |   3 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   3 +-
 drivers/gpu/drm/i915/i915_vma.c                    |   4 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   3 +-
 drivers/hid/hid-ntrig.c                            |   2 +
 drivers/hwmon/adt7475.c                            |  14 +-
 drivers/hwmon/ina2xx.c                             |  13 +-
 drivers/hwtracing/intel_th/core.c                  |   3 +-
 drivers/i2c/busses/i2c-i801.c                      |   9 +-
 drivers/iio/accel/adxl345_core.c                   |  21 ++-
 drivers/iio/adc/ina2xx-adc.c                       |  17 +-
 drivers/iio/counter/104-quad-8.c                   |   2 +-
 drivers/infiniband/core/rw.c                       |   2 +-
 drivers/infiniband/core/uverbs_main.c              |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   4 +-
 drivers/infiniband/hw/hfi1/pio.c                   |   9 +-
 drivers/infiniband/hw/hfi1/user_sdma.c             |   2 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |   8 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |   2 +
 drivers/infiniband/hw/mlx4/qp.c                    |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   6 +-
 drivers/input/misc/xen-kbdfront.c                  |   8 +-
 drivers/input/mouse/elantech.c                     |   2 +
 drivers/iommu/amd_iommu.c                          |   2 +-
 drivers/iommu/msm_iommu.c                          |  16 +-
 drivers/md/md-cluster.c                            |  19 ++-
 drivers/media/i2c/soc_camera/ov772x.c              |   2 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c |  11 +-
 drivers/media/platform/fsl-viu.c                   |  38 +++--
 drivers/media/platform/omap3isp/isp.c              |   2 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |   2 +
 drivers/media/usb/tm6000/tm6000-dvb.c              |   5 +
 drivers/media/usb/uvc/uvc_video.c                  |  24 ++-
 drivers/misc/sram.c                                |  13 +-
 drivers/misc/tsl2550.c                             |   2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |   4 +-
 drivers/mtd/nand/atmel/nand-controller.c           |   7 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h          |   6 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |   7 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          | 187 +++++++++++++++++----
 drivers/net/ethernet/qlogic/qed/qed_mcp.h          |  27 ++-
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h     |   2 +
 drivers/net/phy/xilinx_gmii2rgmii.c                |  10 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |   5 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   1 +
 drivers/net/wireless/ath/ath10k/sdio.c             |   9 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_qmath.c    |   2 +-
 drivers/net/wireless/rndis_wlan.c                  |   2 +
 drivers/net/wireless/ti/wlcore/cmd.c               |   6 +
 drivers/nvme/target/fcloop.c                       |   3 +-
 drivers/power/reset/vexpress-poweroff.c            |  12 +-
 drivers/power/supply/axp288_charger.c              |   2 +-
 drivers/power/supply/power_supply_core.c           |  11 +-
 drivers/regulator/core.c                           |   2 +-
 drivers/s390/block/dasd.c                          |   1 +
 drivers/s390/block/scm_blk.c                       |   1 +
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |   2 +
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |   4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   3 +
 drivers/spi/spi-rspi.c                             |  34 +++-
 drivers/spi/spi-sh-msiof.c                         |  28 ++-
 drivers/spi/spi-tegra20-slink.c                    |  31 +++-
 drivers/staging/android/ashmem.c                   |   6 +
 drivers/staging/media/imx/imx-ic-prpencvf.c        |   1 +
 drivers/staging/media/imx/imx-media-csi.c          |   1 +
 drivers/staging/rts5208/sd.c                       |   2 +-
 drivers/target/iscsi/iscsi_target_tpg.c            |   3 +-
 drivers/target/target_core_device.c                |  22 ++-
 drivers/thermal/of-thermal.c                       |   7 +-
 drivers/tty/serial/8250/serial_cs.c                |   6 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  10 +-
 drivers/tty/serial/fsl_lpuart.c                    |   3 +-
 drivers/tty/serial/imx.c                           |   8 +
 drivers/tty/serial/sh-sci.c                        |   2 +
 drivers/usb/class/cdc-wdm.c                        |   2 +-
 drivers/usb/core/devio.c                           |  24 ++-
 drivers/usb/core/driver.c                          |  28 +--
 drivers/usb/core/usb.c                             |   2 +
 drivers/usb/musb/musb_dsps.c                       |  12 +-
 drivers/usb/serial/kobil_sct.c                     |  12 +-
 drivers/usb/wusbcore/security.c                    |   2 +-
 drivers/uwb/hwa-rc.c                               |   1 +
 fs/iomap.c                                         |  21 +--
 fs/isofs/inode.c                                   |   7 +
 fs/locks.c                                         |   7 +
 fs/nfsd/nfs4proc.c                                 |   1 +
 fs/overlayfs/inode.c                               |  62 +++++--
 include/linux/arm-smccc.h                          |  38 +++--
 include/linux/platform_data/ina2xx.h               |   2 +-
 include/linux/posix-timers.h                       |   4 +-
 include/linux/power_supply.h                       |   1 +
 include/linux/slub_def.h                           |   3 +-
 kernel/bpf/sockmap.c                               |   3 +
 kernel/module.c                                    |   6 +-
 kernel/time/alarmtimer.c                           |   7 +-
 kernel/time/posix-cpu-timers.c                     |   2 +-
 kernel/time/posix-timers.c                         |  33 ++--
 kernel/time/posix-timers.h                         |   2 +-
 lib/klist.c                                        |  10 +-
 mm/slub.c                                          |   6 +-
 net/6lowpan/iphc.c                                 |   1 +
 net/tls/tls_main.c                                 |   9 +-
 sound/aoa/core/gpio-feature.c                      |   4 +-
 sound/pci/hda/hda_intel.c                          |   3 +-
 sound/soc/soc-dapm.c                               |   7 +
 147 files changed, 1040 insertions(+), 390 deletions(-)


