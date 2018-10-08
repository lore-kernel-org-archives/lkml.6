Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA0C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFFB20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIv8qB69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFFB20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJIBqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbeJIBqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:46:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 183992087D;
        Mon,  8 Oct 2018 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023628;
        bh=BfhdWr4YvYO32yZYZ+7IRIkqAiZiuz2tPtHOta2VTjc=;
        h=From:To:Cc:Subject:Date:From;
        b=JIv8qB698p1oQzP7MhpholZxKs8bSHcS8rpzt4oj/V+iMQKDeIaUlA5A3oFYTO4vf
         LXYHfQFvM1Sg3UfajNwuOfwtF5izZfxhekKVclxnqbrZgLzPNoiNPGeKKqvSMJzYPm
         esv0hFvLuDt0PQI6naqh/iKtRZeN2QRos9SzAqxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/113] 4.4.160-stable review
Date:   Mon,  8 Oct 2018 20:30:01 +0200
Message-Id: <20181008175530.864641368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.160-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.160-rc1
X-KernelTest-Deadline: 2018-10-10T17:55+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.160 release.
There are 113 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Oct 10 17:55:13 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.160-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.160-rc1

Ashish Samant <ashish.samant@oracle.com>
    ocfs2: fix locking for res->tracking and dlm->tracking_list

Jann Horn <jannh@google.com>
    proc: restrict kernel stack dumps to root

Leonard Crestez <leonard.crestez@nxp.com>
    crypto: mxs-dcp - Fix wait logic on chan threads

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda/realtek - Cannot adjust speaker's volume on Dell XPS 27 7760

Aurelien Aptel <aaptel@suse.com>
    smb2: fix missing files in root share directory listing

Josh Abraham <j.abraham1776@gmail.com>
    xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Olaf Hering <olaf@aepfle.de>
    xen: avoid crash in disable_hotplug_cpu

Vitaly Kuznetsov <vkuznets@redhat.com>
    xen/manage: don't complain about an empty value in control/sysrq node

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: read overflow in is_valid_oplock_break()

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: don't dump past end of unknown HW header

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

Randy Dunlap <rdunlap@infradead.org>
    hexagon: modify ffs() and fls() to return int

Randy Dunlap <rdunlap@infradead.org>
    arch/hexagon: fix kernel/dma.c build warning

Joe Thornber <ejt@redhat.com>
    dm thin metadata: try to avoid ever aborting transactions

Stephen Rothwell <sfr@canb.auug.org.au>
    fs/cifs: suppress a string overflow warning

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VBIOS

Ben Hutchings <ben.hutchings@codethink.co.uk>
    USB: yurex: Check for truncation in yurex_read()

Jann Horn <jannh@google.com>
    RDMA/ucma: check fd type in ucma_migrate_id()

Sandipan Das <sandipan@linux.ibm.com>
    perf probe powerpc: Ignore SyS symbols irrespective of endianness

Stephen Boyd <swboyd@chromium.org>
    pinctrl: msm: Really mask level interrupts to prevent latching

Anton Vasilyev <vasilyev@ispras.ru>
    usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Daniel Black <daniel@linux.ibm.com>
    mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    tools/vm/page-types.c: fix "defined but not used" warning

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    tools/vm/slabinfo.c: fix sign-compare warning

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: shorten the IBSS debug messages

Ilan Peer <ilan.peer@intel.com>
    mac80211: Fix station bandwidth setting after channel switch

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: fix a race between restart and CSA flows

Dan Carpenter <dan.carpenter@oracle.com>
    cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()

Jon Kuhn <jkuhn@barracuda.com>
    fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Jia-Ju Bai <baijiaju1990@gmail.com>
    net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Masahiro Yamada <yamada.masahiro@socionext.com>
    i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP

Masahiro Yamada <yamada.masahiro@socionext.com>
    i2c: uniphier: issue STOP only for last message or I2C_M_STOP

Xiao Ni <xni@redhat.com>
    RAID10 BUG_ON in raise_barrier when force is true and conf->barrier is 0

Arunk Khandavalli <akhandav@codeaurora.org>
    cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Yuan-Chi Pang <fu3mo6goo@gmail.com>
    mac80211: mesh: fix HWMP sequence numbering to follow standard

Michael Hennerich <michael.hennerich@analog.com>
    gpio: adp5588: Fix sleep-in-atomic-context bug

Danek Duvall <duvall@comfychair.org>
    mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Danek Duvall <duvall@comfychair.org>
    mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: event: Prevent freeing event subscriptions while accessed

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Sanitize PSTATE.M when being set from userspace

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: cpufeature: Track 32bit EL0 support

Mika Westerberg <mika.westerberg@linux.intel.com>
    i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Dan Carpenter <dan.carpenter@oracle.com>
    hwmon: (adt7475) Make adt7475_read_word() return errors

Lothar Felten <lothar.felten@gmail.com>
    hwmon: (ina2xx) fix sysfs shunt resistor read access

Bo Chen <chenbo@pdx.edu>
    e1000: ensure to free old tx/rx rings in set_ringparam()

Bo Chen <chenbo@pdx.edu>
    e1000: check on netif_running() before calling e1000_up()

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_PAGES

Anson Huang <Anson.Huang@nxp.com>
    thermal: of-thermal: disable passive polling when thermal zone is disabled

Theodore Ts'o <tytso@mit.edu>
    ext4: never move the system.data xattr out of the inode body

Dave Martin <Dave.Martin@arm.com>
    arm64: KVM: Tighten guest core register access from userspace

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: imx: restore handshaking irq for imx1

Vincent Pelletier <plr.vincent@gmail.com>
    scsi: target: iscsi: Use bin2hex instead of a re-implementation

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

Andy Whitcroft <apw@canonical.com>
    floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Kevin Hilman <khilman@baylibre.com>
    ARM: dts: dra7: fix DCAN node addresses

J. Bruce Fields <bfields@redhat.com>
    nfsd: fix corrupted reply to badly ordered compound

Jessica Yu <jeyu@kernel.org>
    module: exclude SHN_UNDEF symbols from kallsyms api

Liam Girdwood <liam.r.girdwood@linux.intel.com>
    ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs

Johan Hovold <johan@kernel.org>
    EDAC, i7core: Fix memleaks and use-after-free on probe and remove

Zhouyang Jia <jiazhouyang09@gmail.com>
    scsi: bnx2i: add error handling for ioremap_nocache

Zhouyang Jia <jiazhouyang09@gmail.com>
    HID: hid-ntrig: add error handling for sysfs_create_group

Ethan Tuttle <ethan@ethantuttle.com>
    ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Tony Lindgren <tony@atomide.com>
    wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()

Dan Carpenter <dan.carpenter@oracle.com>
    rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()

Ben Greear <greearb@candelatech.com>
    ath10k: protect ath10k_htt_rx_ring_free with rx_ring.lock

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

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    x86/tsc: Add missing header to tsc_msr.c

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: fsl-viu: fix error handling in viu_of_probe()

Hari Bathini <hbathini@linux.ibm.com>
    powerpc/kdump: Handle crashkernel memory reservation failure

Sylwester Nawrocki <s.nawrocki@samsung.com>
    media: exynos4-is: Prevent NULL pointer dereference in __isp_video_try_fmt()

Guoqing Jiang <gqjiang@suse.com>
    md-cluster: clear another node's suspend_area after the copy is finished

Michael Scott <michael@opensourcefoundries.com>
    6lowpan: iphc: reset mac_header after decompress to fix panic

Johan Hovold <johan@kernel.org>
    USB: serial: kobil_sct: fix modem-status error handling

Jian-Hong Pan <jian-hong@endlessm.com>
    Bluetooth: Add a new Realtek 8723DE ID 0bda:b009

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
 arch/arm64/include/asm/cpufeature.h                |  8 ++-
 arch/arm64/include/asm/jump_label.h                |  4 +-
 arch/arm64/include/asm/kvm_emulate.h               |  5 ++
 arch/arm64/include/asm/sysreg.h                    |  1 +
 arch/arm64/kernel/cpufeature.c                     |  8 +++
 arch/arm64/kvm/guest.c                             | 55 +++++++++++++++-
 arch/hexagon/include/asm/bitops.h                  |  4 +-
 arch/hexagon/kernel/dma.c                          |  2 +-
 arch/powerpc/kernel/machine_kexec.c                |  7 ++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  2 +-
 arch/s390/mm/extmem.c                              |  4 +-
 arch/x86/entry/entry_64.S                          |  4 +-
 arch/x86/kernel/tsc_msr.c                          |  1 +
 arch/x86/mm/numa_emulation.c                       |  2 +-
 crypto/ablkcipher.c                                |  2 +
 crypto/blkcipher.c                                 |  1 +
 drivers/block/floppy.c                             |  3 +
 drivers/bluetooth/btusb.c                          |  1 +
 drivers/crypto/mxs-dcp.c                           | 53 +++++++++-------
 drivers/edac/i7core_edac.c                         | 22 ++++---
 drivers/gpio/gpio-adp5588.c                        | 24 +++++--
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gm204.c    |  3 +-
 drivers/hid/hid-ntrig.c                            |  2 +
 drivers/hwmon/adt7475.c                            | 14 +++--
 drivers/hwmon/ina2xx.c                             | 13 +++-
 drivers/i2c/busses/i2c-i801.c                      |  9 ++-
 drivers/i2c/busses/i2c-uniphier-f.c                |  7 +--
 drivers/i2c/busses/i2c-uniphier.c                  |  7 +--
 drivers/infiniband/core/ucma.c                     |  6 ++
 drivers/infiniband/ulp/srp/ib_srp.c                |  6 +-
 drivers/input/mouse/elantech.c                     |  2 +
 drivers/md/dm-thin-metadata.c                      | 36 ++++++++++-
 drivers/md/dm-thin.c                               | 73 +++++++++++++++++++---
 drivers/md/md-cluster.c                            | 19 +++---
 drivers/md/raid10.c                                |  5 +-
 drivers/media/i2c/soc_camera/ov772x.c              |  2 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c | 11 +++-
 drivers/media/platform/fsl-viu.c                   | 38 ++++++-----
 drivers/media/platform/omap3isp/isp.c              |  2 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |  2 +
 drivers/media/usb/tm6000/tm6000-dvb.c              |  5 ++
 drivers/media/usb/uvc/uvc_video.c                  | 24 +++++--
 drivers/media/v4l2-core/v4l2-event.c               | 37 +++++------
 drivers/media/v4l2-core/v4l2-fh.c                  |  2 +
 drivers/misc/tsl2550.c                             |  2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |  4 +-
 drivers/net/ethernet/cadence/macb.c                |  2 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h          |  6 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |  7 ++-
 drivers/net/ethernet/realtek/r8169.c               |  9 ++-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |  5 +-
 drivers/net/wireless/mac80211_hwsim.c              |  3 -
 drivers/net/wireless/rndis_wlan.c                  |  2 +
 drivers/net/wireless/ti/wlcore/cmd.c               |  6 ++
 drivers/pinctrl/qcom/pinctrl-msm.c                 | 24 +++++++
 drivers/power/reset/vexpress-poweroff.c            | 12 ++--
 drivers/s390/net/qeth_l2_main.c                    |  2 +-
 drivers/s390/net/qeth_l3_main.c                    |  2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |  2 +
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |  4 +-
 drivers/spi/spi-rspi.c                             | 34 ++++++++--
 drivers/spi/spi-sh-msiof.c                         | 28 ++++++++-
 drivers/spi/spi-tegra20-slink.c                    | 31 ++++++---
 drivers/staging/android/ashmem.c                   |  6 ++
 drivers/staging/rts5208/sd.c                       |  2 +-
 drivers/target/iscsi/iscsi_target_auth.c           | 15 +----
 drivers/target/iscsi/iscsi_target_tpg.c            |  3 +-
 drivers/thermal/of-thermal.c                       |  7 ++-
 drivers/tty/serial/8250/serial_cs.c                |  6 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        | 10 ++-
 drivers/tty/serial/imx.c                           |  8 +++
 drivers/usb/class/cdc-wdm.c                        |  2 +-
 drivers/usb/core/devio.c                           | 24 ++++++-
 drivers/usb/core/driver.c                          | 28 ++++-----
 drivers/usb/core/usb.c                             |  2 +
 drivers/usb/gadget/udc/fotg210-udc.c               | 15 +++--
 drivers/usb/misc/yurex.c                           |  3 +
 drivers/usb/serial/kobil_sct.c                     | 12 +++-
 drivers/usb/wusbcore/security.c                    |  2 +-
 drivers/uwb/hwa-rc.c                               |  1 +
 drivers/xen/cpu_hotplug.c                          | 15 ++---
 drivers/xen/events/events_base.c                   |  2 +-
 drivers/xen/manage.c                               |  6 +-
 fs/cifs/cifs_unicode.c                             |  3 -
 fs/cifs/cifssmb.c                                  | 11 +++-
 fs/cifs/misc.c                                     |  8 +++
 fs/cifs/smb2ops.c                                  |  2 +-
 fs/ext4/xattr.c                                    |  5 ++
 fs/nfsd/nfs4proc.c                                 |  1 +
 fs/ocfs2/dlm/dlmmaster.c                           |  4 +-
 fs/proc/base.c                                     | 14 +++++
 include/linux/platform_data/ina2xx.h               |  2 +-
 include/linux/slub_def.h                           |  3 +-
 include/media/v4l2-fh.h                            |  1 +
 kernel/module.c                                    |  6 +-
 kernel/time/alarmtimer.c                           |  3 +-
 lib/klist.c                                        | 10 +--
 mm/madvise.c                                       |  2 +-
 mm/slub.c                                          |  6 +-
 net/6lowpan/iphc.c                                 |  1 +
 net/mac80211/ibss.c                                | 22 +++----
 net/mac80211/main.c                                | 26 ++++++--
 net/mac80211/mesh_hwmp.c                           |  4 ++
 net/mac80211/mlme.c                                | 53 ++++++++++++++++
 net/wireless/nl80211.c                             |  1 +
 net/wireless/util.c                                |  2 +-
 sound/aoa/core/gpio-feature.c                      |  4 +-
 sound/pci/hda/hda_intel.c                          |  3 +-
 sound/pci/hda/patch_realtek.c                      |  1 +
 sound/soc/soc-dapm.c                               |  7 +++
 tools/perf/arch/powerpc/util/sym-handling.c        |  4 +-
 tools/vm/page-types.c                              |  6 --
 tools/vm/slabinfo.c                                |  4 +-
 118 files changed, 842 insertions(+), 287 deletions(-)


