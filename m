Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802431-2-6762808829332574554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802429; b=JqNMVz/K5AJT6NJvTU6R6tdORiTv9Ea9SOmvx7y7eaum6Qu
    u69yUDfaF3Jn0V2bHD9/ZRHPM1IIfyHODuB19j6kljaVuEwuu1VvZtAAYMr/esai
    YwfoNrfZr3jdlgsU7+zTU7e6C2+lou8Elaal/bkfoX4Hl5PN2zPhk8umiXkMd9wa
    sadgP9Jo0MjQnIy0kkUIJLdSL7FVXnNTSXzt7/tEmH1VhU+19Ddq6OWUuJHZ0gUE
    rRDWuWGtNq35Yr+5f5SUaUrxNBqWI7WmQxq/7JXlE3cmXagfyYOaPUYwolCx8GcE
    Lmc9XNCTjQe1zpLX8ggHy2TleS+hU2a/gmRreig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521802429; bh=un5EKP6sDoXbx0sokLRAeQqMvD
    J5FHFPZLoE70iJyZA=; b=u0yMsNh43WJODQ4kGz2c7mr7R8BhaRCetxTcSUfZVm
    c5sjUJUuevmATAlm/J3Ed2WbQYosA3ilKNy2w5IhZRZHaODtzcchIvZ/4IWY+ySr
    jzC3VfWJqQNL/XovuaHCr6wgkLQzOdgKtI5RJgnjHG4W1hKUQ7kAFqmx7S9GnWUQ
    eGA8V1Oqk92FLn5uZt0il3kYYWD7EiJBEJ+gWlnLP9V5r0jaZMLXc6/vkjFjevdI
    pKEITq2xuYBte02IhS6ZCF2CJBmi7f64da96cPYJwyqZN+tJwaewTkls3QfUTp79
    zAY3Wvkp2j4mbi4JSZsALBm/K7DG6jmDw2uiPFyT6zCA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755921AbeCWKNp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:13:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755901AbeCWKNm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/97] 4.4.124-stable review
Date: Fri, 23 Mar 2018 10:53:47 +0100
Message-Id: <20180323094157.535925724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.124-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.124-rc1
X-KernelTest-Deadline: 2018-03-25T09:42+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.124 release.
There are 97 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 25 09:41:34 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.124-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.124-rc1

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Fix access to non-initialized CM_ID object

Vignesh R <vigneshr@ti.com>
    dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63

Sergej Sawazki <sergej@taudac.com>
    clk: si5351: Rename internal plls to avoid name collisions

Benjamin Coddington <bcodding@redhat.com>
    nfsd4: permit layoutget of executable-only files

Anton Vasilyev <vasilyev@ispras.ru>
    RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS

Alexey Kodanev <alexey.kodanev@oracle.com>
    ip6_vti: adjust vti mtu according to mtu of lower device

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/vt-d: clean up pr_irq if request_threaded_irq fails

Florian Fainelli <f.fainelli@gmail.com>
    pinctrl: Really force states during suspend/resume

Robert Walker <robert.walker@arm.com>
    coresight: Fix disabling of CoreSight TPIU

Sahara <keun-o.park@darkmatter.ae>
    pty: cancel pty slave port buf's work in tty_release

Peter Ujfalusi <peter.ujfalusi@ti.com>
    drm/omap: DMM: Check for DMM readiness after successful transaction commit

Bjorn Helgaas <bhelgaas@google.com>
    vgacon: Set VGA struct resource types

Artemy Kovalyov <artemyko@mellanox.com>
    IB/umem: Fix use of npages/nmap fields

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Use correct size when writing netlink stats

Erez Shitrit <erezsh@mellanox.com>
    IB/ipoib: Avoid memory leak if the SA returns a different DGID

Daniel Drake <drake@endlessm.com>
    mmc: avoid removing non-removable hosts during suspend

Shawn Nematbakhsh <shawnn@chromium.org>
    platform/chrome: Use proper protocol transfer function

Arnd Bergmann <arnd@arndb.de>
    cros_ec: fix nul-termination for firmware build info

Ron Economos <w6rz@comcast.net>
    media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: bt8xx: Fix err 'bt878_probe()'

Tsang-Shian Lin <thlin@realtek.com>
    rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.

Geert Uytterhoeven <geert@linux-m68k.org>
    RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()

Prakash Kamliya <pkamliya@codeaurora.org>
    drm/msm: fix leak in failed get_pages

Gustavo A. R. Silva <garsilva@embeddedor.com>
    media: c8sectpfe: fix potential NULL pointer dereference in c8sectpfe_timer_interrupt

Loic Poulain <loic.poulain@linaro.org>
    Bluetooth: hci_qca: Avoid setup failure on missing rampatch

Kim Phillips <kim.phillips@arm.com>
    perf tests kmod-path: Don't fail if compressed modules aren't supported

Moritz Fischer <mdf@kernel.org>
    rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL

Moritz Fischer <mdf@kernel.org>
    rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt ticks

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: small underflow in cnvrtDosUnixTm()

Timmy Li <lixiaoping3@huawei.com>
    net: hns: fix ethtool_get_strings overflow in hns driver

Alexey Khoroshilov <khoroshilov@ispras.ru>
    sm501fb: don't return zero on failure path in sm501fb_start()

Maksim Salau <maksim.salau@gmail.com>
    video: fbdev: udlfb: Fix buffer on stack

Dmitry Monakhov <dmonakhov@openvz.org>
    tcm_fileio: Prevent information leak for short reads

Sergei Trofimovich <slyfox@gentoo.org>
    ia64: fix module loading for gcc-5.4

Shaohua Li <shli@fb.com>
    md/raid10: skip spare disk as 'first' disk

Sebastian Reichel <sebastian.reichel@collabora.co.uk>
    Input: twl4030-pwrbutton - use correct device for irq request

Michael Trimarchi <michael@amarulasolutions.com>
    power: supply: pda_power: move from timer to delayed_work

Scott Wood <swood@redhat.com>
    bnx2x: Align RX buffers

Mario Kleiner <mario.kleiner.de@gmail.com>
    drm/nouveau/kms: Increase max retries in scanout position queries.

Hans de Goede <hdegoede@redhat.com>
    ACPI / PMIC: xpower: Fix power_table addresses

Robert Lippert <roblip@gmail.com>
    ipmi/watchdog: fix wdog hang on panic waiting for ipmi response

Kishon Vijay Abraham I <kishon@ti.com>
    ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP

yangbo lu <yangbo.lu@nxp.com>
    mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a

Pan Bian <bianpan2016@163.com>
    staging: wilc1000: fix unchecked return value

Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>
    staging: unisys: visorhba: fix s-Par to boot with option CONFIG_VMAP_STACK set to y

Ming Lei <ming.lei@redhat.com>
    mtip32xx: use runtime tag to initialize command header

Keerthy <j-keerthy@ti.com>
    mfd: palmas: Reset the POWERHOLD mux during power off

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: don't parse encrypted management frames in ieee80211_frame_acked

Filipe Manana <fdmanana@suse.com>
    Btrfs: send, fix file hole not being preserved due to inline extent

Pan Bian <bianpan2016@163.com>
    rndis_wlan: add return value validation

Pan Bian <bianpan2016@163.com>
    mt7601u: check return value of alloc_skb

Shrirang Bagul <shrirang.bagul@canonical.com>
    iio: st_pressure: st_accel: Initialise sensor platform data properly

NeilBrown <neilb@suse.com>
    NFS: don't try to cross a mountpount when there isn't one there.

Vlad Tsyrklevich <vlad@tsyrklevich.net>
    infiniband/uverbs: Fix integer overflows

Finn Thain <fthain@telegraphics.com.au>
    scsi: mac_esp: Replace bogus memory barrier with spinlock

Pan Bian <bianpan2016@163.com>
    qlcnic: fix unchecked return value

Pan Bian <bianpan2016@163.com>
    wan: pc300too: abort path on failure

Dan Carpenter <dan.carpenter@oracle.com>
    mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()

Jarno Rajahalme <jarno@ovn.org>
    openvswitch: Delete conntrack entry clashing with an expectation.

Gao Feng <fgao@ikuai8.com>
    netfilter: xt_CT: fix refcnt leak on error path

James Smart <jsmart2021@gmail.com>
    Fix driver usage of 128B WQEs when WQ_CREATE is V1.

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: Intel: Skylake: Uninitialized variable in probe_codec()

Maor Gottlieb <maorg@mellanox.com>
    IB/mlx4: Change vma from shared to private

Maor Gottlieb <maorg@mellanox.com>
    IB/mlx4: Take write semaphore when changing the vma struct

Dan Carpenter <dan.carpenter@oracle.com>
    HSI: ssi_protocol: double free in ssip_pn_xmit()

Feras Daoud <ferasda@mellanox.com>
    IB/ipoib: Update broadcast object if PKey value was changed in index 0

Feras Daoud <ferasda@mellanox.com>
    IB/ipoib: Fix deadlock between ipoib_stop and mcast join flow

Mikhail Paulyshka <me@mixaill.tk>
    ALSA: hda - Fix headset microphone detection for ASUS N551 and N751

Bernd Faust <berndfaust@gmail.com>
    e1000e: fix timing for 82579 Gigabit Ethernet controller

Eric Dumazet <edumazet@google.com>
    tcp: remove poll() flakes with FastOpen

Benjamin Coddington <bcodding@redhat.com>
    NFS: Fix missing pg_cleanup after nfs_pageio_cond_complete()

Guoqing Jiang <gqjiang@suse.com>
    md/raid10: wait up frozen array in handle_write_completed

Suman Anna <s-anna@ti.com>
    iommu/omap: Register driver before setting IOMMU ops

Abel Vesa <abelvesa@linux.com>
    ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA and !FRAME_POINTER

Alexey Kardashevskiy <aik@ozlabs.ru>
    KVM: PPC: Book3S PR: Exit KVM on failed mapping

David Gibson <david@gibson.dropbear.id.au>
    scsi: virtio_scsi: Always try to read VPD pages

Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
    clk: ns2: Correct SDIO bits

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath: Fix updating radar flags for coutry code India

Marek Vasut <marex@denx.de>
    spi: dw: Disable clock after unregistering the host

Jasmin J <jasmin@anw.at>
    media/dvb-core: Race condition when writing to CAM

David Ahern <dsa@cumulusnetworks.com>
    net: ipv6: send unsolicited NA on admin up

Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
    i2c: i2c-scmi: add a MS HID

Hans de Goede <hdegoede@redhat.com>
    genirq: Use irqd_get_trigger_type to compare the trigger type for shared IRQs

Thomas Gleixner <tglx@linutronix.de>
    cpufreq/sh: Replace racy task affinity logic

Thomas Gleixner <tglx@linutronix.de>
    ACPI/processor: Replace racy task affinity logic

Thomas Gleixner <tglx@linutronix.de>
    ACPI/processor: Fix error handling in __acpi_processor_start()

Deepa Dinamani <deepa.kernel@gmail.com>
    time: Change posix clocks ops interfaces to use timespec64

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: ar1021_i2c - fix too long name in driver's device table

Hans de Goede <hdegoede@redhat.com>
    rtc: cmos: Do not assume irq 8 for rtc when there are no legacy irqs

Hans de Goede <hdegoede@redhat.com>
    x86: i8259: export legacy_pic symbol

Dong Aisheng <aisheng.dong@nxp.com>
    regulator: anatop: set default voltage selector for pcie

Santeri Toivonen <santeri.toivonen@vatsul.com>
    platform/x86: asus-nb-wmi: Add wapf4 quirk for the X302UA

Yisheng Xie <xieyisheng1@huawei.com>
    staging: android: ashmem: Fix possible deadlock in ashmem_ioctl

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Enable encryption during session setup phase

Steve French <smfrench@gmail.com>
    SMB3: Validate negotiate request must always be signed

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_tis: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm: fix potential buffer overruns caused by bit glitches on the bus


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/alpha/kernel/console.c                        |  1 +
 arch/arm/kernel/ftrace.c                           | 11 ++--
 arch/arm/mach-omap2/clockdomains7xx_data.c         |  2 +-
 arch/ia64/kernel/module.c                          |  4 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c              |  5 +-
 arch/powerpc/kvm/book3s_pr.c                       |  6 ++-
 arch/x86/kernel/i8259.c                            |  1 +
 drivers/acpi/pmic/intel_pmic_xpower.c              | 50 ++++++++---------
 drivers/acpi/processor_driver.c                    | 10 +++-
 drivers/acpi/processor_throttling.c                | 62 +++++++++++++---------
 drivers/block/mtip32xx/mtip32xx.c                  | 36 ++++++++-----
 drivers/bluetooth/hci_qca.c                        |  3 ++
 drivers/char/ipmi/ipmi_watchdog.c                  |  8 +--
 drivers/char/tpm/tpm-interface.c                   |  5 ++
 drivers/char/tpm/tpm2-cmd.c                        |  6 +++
 drivers/char/tpm/tpm_tis.c                         |  5 +-
 drivers/clk/bcm/clk-ns2.c                          |  2 +-
 drivers/clk/clk-si5351.c                           |  2 +-
 drivers/cpufreq/sh-cpufreq.c                       | 45 +++++++++-------
 drivers/dma/ti-dma-crossbar.c                      | 10 +++-
 drivers/gpu/drm/msm/msm_gem.c                      | 14 +++--
 drivers/gpu/drm/nouveau/nouveau_display.c          |  2 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |  5 ++
 drivers/hsi/clients/ssi_protocol.c                 |  5 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       | 13 +++--
 drivers/i2c/busses/i2c-scmi.c                      |  4 ++
 drivers/iio/accel/st_accel_core.c                  |  7 +--
 drivers/iio/pressure/st_pressure_core.c            |  8 +--
 drivers/infiniband/core/cma.c                      |  5 +-
 drivers/infiniband/core/iwpm_util.c                |  1 +
 drivers/infiniband/core/umem.c                     |  2 +-
 drivers/infiniband/core/uverbs_cmd.c               | 13 ++++-
 drivers/infiniband/hw/mlx4/main.c                  |  6 ++-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            | 13 +++++
 drivers/infiniband/ulp/ipoib/ipoib_main.c          | 16 ++++++
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     | 11 ++--
 drivers/input/misc/twl4030-pwrbutton.c             |  2 +-
 drivers/input/touchscreen/ar1021_i2c.c             |  2 +-
 drivers/iommu/intel-svm.c                          |  9 ++--
 drivers/iommu/omap-iommu.c                         | 21 ++++++--
 drivers/md/raid10.c                                |  6 +++
 drivers/media/dvb-core/dvb_ca_en50221.c            | 23 ++++++++
 drivers/media/dvb-frontends/si2168.c               |  3 ++
 drivers/media/pci/bt8xx/bt878.c                    |  3 +-
 .../media/platform/sti/c8sectpfe/c8sectpfe-core.c  |  4 +-
 drivers/mfd/palmas.c                               | 14 +++++
 drivers/mmc/core/core.c                            |  8 +++
 drivers/mmc/host/omap_hsmmc.c                      |  4 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  | 14 +++++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  6 +++
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |  2 +
 drivers/net/wan/pc300too.c                         |  1 +
 drivers/net/wireless/ath/regd.c                    | 19 ++++---
 drivers/net/wireless/mediatek/mt7601u/mcu.c        | 10 +++-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  7 +++
 drivers/net/wireless/rndis_wlan.c                  |  4 ++
 drivers/pinctrl/core.c                             | 24 ++++++---
 drivers/platform/chrome/cros_ec_proto.c            |  8 +--
 drivers/platform/chrome/cros_ec_sysfs.c            |  2 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  9 ++++
 drivers/power/pda_power.c                          | 49 +++++++++--------
 drivers/ptp/ptp_clock.c                            | 18 +++----
 drivers/regulator/anatop-regulator.c               |  5 ++
 drivers/rtc/rtc-cmos.c                             | 17 ++++--
 drivers/rtc/rtc-ds1374.c                           | 10 +++-
 drivers/scsi/lpfc/lpfc_sli.c                       |  3 ++
 drivers/scsi/mac_esp.c                             | 33 ++++++++----
 drivers/scsi/virtio_scsi.c                         | 24 +++++++++
 drivers/spi/spi-dw-mmio.c                          |  2 +-
 drivers/staging/android/ashmem.c                   |  8 ++-
 drivers/staging/unisys/visorhba/visorhba_main.c    |  8 ++-
 drivers/staging/wilc1000/linux_mon.c               |  2 +
 drivers/target/target_core_file.c                  | 23 +++++---
 drivers/tty/tty_io.c                               |  2 +
 drivers/video/console/vgacon.c                     | 34 +++++++++---
 drivers/video/fbdev/sm501fb.c                      |  1 +
 drivers/video/fbdev/udlfb.c                        | 14 ++++-
 fs/btrfs/send.c                                    | 23 +++++++-
 fs/cifs/netmisc.c                                  |  6 +--
 fs/cifs/sess.c                                     | 22 ++++----
 fs/cifs/smb2pdu.c                                  | 11 ++--
 fs/nfs/pagelist.c                                  |  6 ++-
 fs/nfsd/nfs4proc.c                                 |  6 +--
 fs/nfsd/vfs.c                                      | 24 +++++++--
 include/linux/posix-clock.h                        | 10 ++--
 kernel/irq/manage.c                                |  4 +-
 kernel/time/posix-clock.c                          | 34 ++++++++----
 net/ipv4/tcp_input.c                               | 16 +++---
 net/ipv6/ip6_vti.c                                 | 20 +++++++
 net/ipv6/ndisc.c                                   |  2 +
 net/mac80211/status.c                              |  1 +
 net/netfilter/xt_CT.c                              | 11 +++-
 net/openvswitch/conntrack.c                        | 30 ++++++++++-
 sound/pci/hda/patch_realtek.c                      | 12 ++++-
 sound/soc/intel/skylake/skl.c                      |  2 +-
 tools/perf/tests/kmod-path.c                       |  2 +
 103 files changed, 811 insertions(+), 303 deletions(-)
