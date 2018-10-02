Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1705CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11DB2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11DB2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbeJBUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:19:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731766AbeJBUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:10 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7D899C4D;
        Tue,  2 Oct 2018 13:35:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/94] 4.9.131-stable review
Date:   Tue,  2 Oct 2018 06:24:14 -0700
Message-Id: <20181002132500.494838053@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.131-rc1
X-KernelTest-Deadline: 2018-10-04T13:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.131 release.
There are 94 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Oct  4 13:24:37 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.131-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.131-rc1

Mika Westerberg <mika.westerberg@linux.intel.com>
    i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc-1.1: Handle function result as parameters

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc-1.1: Make return values unsigned long

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Update power state at the end of smu hw_init.

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Enable/disable gfx PG feature in rlc safe mode

Dan Carpenter <dan.carpenter@oracle.com>
    hwmon: (adt7475) Make adt7475_read_word() return errors

Lothar Felten <lothar.felten@gmail.com>
    hwmon: (ina2xx) fix sysfs shunt resistor read access

Bo Chen <chenbo@pdx.edu>
    e1000: ensure to free old tx/rx rings in set_ringparam()

Bo Chen <chenbo@pdx.edu>
    e1000: check on netif_running() before calling e1000_up()

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns: fix skb->truesize underestimation

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_PAGES

Anson Huang <Anson.Huang@nxp.com>
    thermal: of-thermal: disable passive polling when thermal zone is disabled

Tomer Tayar <Tomer.Tayar@cavium.com>
    qed: Wait for MCP halt and resume commands to take place

Tomer Tayar <Tomer.Tayar@cavium.com>
    qed: Wait for ready indication before rereading the shmem

Theodore Ts'o <tytso@mit.edu>
    ext4: never move the system.data xattr out of the inode body

Dave Martin <Dave.Martin@arm.com>
    arm64: KVM: Tighten guest core register access from userspace

Ira Weiny <ira.weiny@intel.com>
    IB/hfi1: Fix SL array bounds check

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: imx: restore handshaking irq for imx1

Vincent Pelletier <plr.vincent@gmail.com>
    scsi: target: iscsi: Use bin2hex instead of a re-implementation

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Fix context recovery when PBC has an UnsupportedVL

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Invalid user input can result in crash

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

Christophe Leroy <christophe.leroy@c-s.fr>
    serial: cpm_uart: return immediately from console poll

Stefan Agner <stefan@agner.ch>
    tty: serial: lpuart: avoid leaking struct tty_struct

Andy Whitcroft <apw@canonical.com>
    floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Kevin Hilman <khilman@baylibre.com>
    ARM: dts: dra7: fix DCAN node addresses

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

Zhouyang Jia <jiazhouyang09@gmail.com>
    scsi: bnx2i: add error handling for ioremap_nocache

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/lbr: Fix incomplete LBR call stack

Zhouyang Jia <jiazhouyang09@gmail.com>
    HID: hid-ntrig: add error handling for sysfs_create_group

Ethan Tuttle <ethan@ethantuttle.com>
    ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Tony Lindgren <tony@atomide.com>
    wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()

Dan Carpenter <dan.carpenter@oracle.com>
    rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()

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

Vasily Gorbik <gor@linux.ibm.com>
    s390/extmem: fix gcc 8 stringop-overflow warning

Thomas Gleixner <tglx@linutronix.de>
    alarmtimer: Prevent overflow for relative nanosleep

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/powernv/ioda2: Reduce upper limit for DMA window size

Julia Lawall <Julia.Lawall@lip6.fr>
    usb: wusbcore: security: cast sizeof to int for comparison

Breno Leitao <leitao@debian.org>
    scsi: ibmvscsi: Improve strings handling

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: klist: Make it safe to use klists in atomic context

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: target/iscsi: Make iscsit_ta_authentication() respect the output buffer size

Jan Beulich <JBeulich@suse.com>
    x86/entry/64: Add two more instruction suffixes

Dave Gerlach <d-gerlach@ti.com>
    ARM: hwmod: RTC: Don't assume lock/unlock will be called with irq enabled

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    x86/tsc: Add missing header to tsc_msr.c

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: fsl-viu: fix error handling in viu_of_probe()

Hari Bathini <hbathini@linux.ibm.com>
    powerpc/kdump: Handle crashkernel memory reservation failure

Sylwester Nawrocki <s.nawrocki@samsung.com>
    media: exynos4-is: Prevent NULL pointer dereference in __isp_video_try_fmt()

Dan Carpenter <dan.carpenter@oracle.com>
    IB/core: type promotion bug in rdma_rw_init_one_mr()

Guoqing Jiang <gqjiang@suse.com>
    md-cluster: clear another node's suspend_area after the copy is finished

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    power: remove possible deadlock when unregistering power_supply

Vasily Gorbik <gor@linux.ibm.com>
    s390/mm: correct allocate_pgste proc_handler callback

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

Colin Ian King <colin.king@canonical.com>
    staging: rts5208: fix missing error check on call to rtsx_write_register

Dan Williams <dan.j.williams@intel.com>
    x86/numa_emulation: Fix emulated-to-physical node mapping

Dan Carpenter <dan.carpenter@oracle.com>
    vmci: type promotion bug in qp_host_get_user_memory()

Matt Ranostay <matt.ranostay@konsulko.com>
    tsl2550: fix lux1_input error in low light

Stafford Horne <shorne@gmail.com>
    crypto: skcipher - Fix -Wstringop-truncation warnings


-------------

Diffstat:

 Documentation/hwmon/ina2xx                         |  2 +-
 Makefile                                           |  4 +-
 arch/arm/boot/dts/dra7.dtsi                        |  4 +-
 arch/arm/mach-mvebu/pmsu.c                         |  6 +-
 arch/arm/mach-omap2/omap_hwmod_reset.c             | 12 ++-
 arch/arm64/kvm/guest.c                             | 45 ++++++++++
 arch/powerpc/kernel/machine_kexec.c                |  7 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  2 +-
 arch/s390/mm/extmem.c                              |  4 +-
 arch/s390/mm/pgalloc.c                             |  2 +-
 arch/x86/entry/entry_64.S                          |  4 +-
 arch/x86/events/intel/lbr.c                        | 32 ++++++--
 arch/x86/events/perf_event.h                       |  1 +
 arch/x86/kernel/tsc_msr.c                          |  1 +
 arch/x86/mm/numa_emulation.c                       |  2 +-
 crypto/ablkcipher.c                                |  2 +
 crypto/blkcipher.c                                 |  1 +
 drivers/block/floppy.c                             |  3 +
 drivers/bluetooth/btusb.c                          |  1 +
 drivers/edac/edac_mc_sysfs.c                       |  6 +-
 drivers/edac/i7core_edac.c                         | 22 +++--
 drivers/gpio/gpio-menz127.c                        |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 11 ++-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |  4 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |  3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  3 +-
 drivers/hid/hid-ntrig.c                            |  2 +
 drivers/hwmon/adt7475.c                            | 14 ++--
 drivers/hwmon/ina2xx.c                             | 13 ++-
 drivers/i2c/busses/i2c-i801.c                      |  9 +-
 drivers/infiniband/core/rw.c                       |  2 +-
 drivers/infiniband/hw/hfi1/pio.c                   |  9 +-
 drivers/infiniband/hw/hfi1/user_sdma.c             |  2 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |  8 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  6 +-
 drivers/input/mouse/elantech.c                     |  2 +
 drivers/iommu/amd_iommu.c                          |  2 +-
 drivers/md/md-cluster.c                            | 19 +++--
 drivers/media/i2c/soc_camera/ov772x.c              |  2 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c | 11 ++-
 drivers/media/platform/fsl-viu.c                   | 38 +++++----
 drivers/media/platform/omap3isp/isp.c              |  2 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |  2 +
 drivers/media/usb/tm6000/tm6000-dvb.c              |  5 ++
 drivers/media/usb/uvc/uvc_video.c                  | 24 ++++--
 drivers/misc/tsl2550.c                             |  2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |  4 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h          |  6 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |  7 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          | 96 ++++++++++++++++++----
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h     |  1 +
 drivers/net/phy/xilinx_gmii2rgmii.c                | 10 ++-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |  5 +-
 drivers/net/wireless/rndis_wlan.c                  |  2 +
 drivers/net/wireless/ti/wlcore/cmd.c               |  6 ++
 drivers/power/reset/vexpress-poweroff.c            | 12 ++-
 drivers/power/supply/power_supply_core.c           | 11 ++-
 drivers/regulator/core.c                           |  2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |  2 +
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |  4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  3 +
 drivers/spi/spi-rspi.c                             | 34 +++++++-
 drivers/spi/spi-sh-msiof.c                         | 28 ++++++-
 drivers/spi/spi-tegra20-slink.c                    | 31 +++++--
 drivers/staging/android/ashmem.c                   |  6 ++
 drivers/staging/rts5208/sd.c                       |  2 +-
 drivers/target/iscsi/iscsi_target_auth.c           | 15 +---
 drivers/target/iscsi/iscsi_target_tpg.c            |  3 +-
 drivers/thermal/of-thermal.c                       |  7 +-
 drivers/tty/serial/8250/serial_cs.c                |  6 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        | 10 ++-
 drivers/tty/serial/fsl_lpuart.c                    |  3 +-
 drivers/tty/serial/imx.c                           |  8 ++
 drivers/usb/class/cdc-wdm.c                        |  2 +-
 drivers/usb/core/devio.c                           | 24 +++++-
 drivers/usb/core/driver.c                          | 28 +++----
 drivers/usb/core/usb.c                             |  2 +
 drivers/usb/serial/kobil_sct.c                     | 12 ++-
 drivers/usb/wusbcore/security.c                    |  2 +-
 drivers/uwb/hwa-rc.c                               |  1 +
 fs/ext4/xattr.c                                    |  5 ++
 fs/nfsd/nfs4proc.c                                 |  1 +
 include/linux/arm-smccc.h                          | 38 +++++----
 include/linux/platform_data/ina2xx.h               |  2 +-
 include/linux/power_supply.h                       |  1 +
 include/linux/slub_def.h                           |  3 +-
 kernel/module.c                                    |  6 +-
 kernel/time/alarmtimer.c                           |  3 +-
 lib/klist.c                                        | 10 ++-
 mm/slub.c                                          |  6 +-
 net/6lowpan/iphc.c                                 |  1 +
 sound/aoa/core/gpio-feature.c                      |  4 +-
 sound/pci/hda/hda_intel.c                          |  3 +-
 sound/soc/soc-dapm.c                               |  7 ++
 95 files changed, 630 insertions(+), 219 deletions(-)


