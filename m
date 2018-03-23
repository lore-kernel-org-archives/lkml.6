Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807348-5-18260930029044501237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807347; b=naXWaprvmF5Vm4eK8RQFkDAsihpZ1GSRpF/nAH7gQK22o9M
    HyGyepLzwR77oXhGC6QaAFhlZYELt0JxYgI7ChHHVycU5Kr504WUSu0PT0123Soi
    /9YDvfYXtLgBb/RYw8LoAc5eqoQbg4c+5QiIa+5otLpt6ttiEyFuUl+h+IuTYD6S
    iXpbqYhyi60PL4FSJHRQacIPYI48eJXAqknxB3HY0CKLXXqfGgC2B53hOudAPo6B
    kqxCWgMd12zW9wPOt57QZDbNKZd0lsK00a73DisXpoDm1lKhrMLjCz69DLWnhnb4
    J7YcibVEUaIr9ayjE4MlBy8uX3UDQo1QNHjG86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521807347; bh=Otas5DsKnQnEb9UG044cjFGzT2
    ibVLcvbbYHXbtQfLM=; b=vbmwQFNUs0pUiOk2q10YkqpBNXhCi+eNvlFnTB266t
    +S2Bxh+gOUAibQ5+f/QlmhAmP5Cy284UNPq91AF2Z45+sXL9Oxib8W2LnSSdcjtv
    WZYLpgeqat5ACtDQ9bpV3hzbrh0OcoZG7kGx7WUuxIaZXOLOZu/J6Y6RaSenJWZH
    cFwFbo7Gu+kNEurkQOWXa8zh+SXBeSGZvhesXNe7hvjNDij4QCK92u4bAY6RSLTB
    l6YHqBT40fwVaYQPYfbkHMEEUSmuU5mzlUSo1LsE4bgWdBFzji1yWNpCBtpJzbLk
    sCvqyBCd6whtJSQfr9CX821Ps4ogCjMmuGWuTBH058HA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1752709AbeCWJ4u (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:56:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeCWJ4o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.15 00/84] 4.15.13-stable review
Date: Fri, 23 Mar 2018 10:53:14 +0100
Message-Id: <20180323095411.913234798@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.13-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.13-rc1
X-KernelTest-Deadline: 2018-03-25T09:54+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.13 release.
There are 84 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 25 09:53:34 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.13-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.13-rc1

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Don't allow join attempts for unsupported AF family

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Fix access to non-initialized CM_ID object

Jerome Brunet <jbrunet@baylibre.com>
    clk: migrate the count of orphaned clocks at init

Tatyana Nikolova <tatyana.e.nikolova@intel.com>
    RDMA/core: Do not use invalid destination in determining port reuse

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_pci: Don't fail on multiport card class

Adit Ranadive <aditr@vmware.com>
    RDMA/vmw_pvrdma: Fix usage of user response structures in ABI file

Boris Pismenny <borisp@mellanox.com>
    IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq

Boris Pismenny <borisp@mellanox.com>
    IB/mlx5: Fix integer overflows in mlx5_ib_create_srq

Vignesh R <vigneshr@ti.com>
    dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63

Gary R Hook <gary.hook@amd.com>
    hwrng: core - Clean up RNG list when last hwrng is unregistered

Lars Persson <lars.persson@axis.com>
    crypto: artpec6 - set correct iv size for gcm(aes)

Sergej Sawazki <sergej@taudac.com>
    clk: si5351: Rename internal plls to avoid name collisions

Lars-Peter Clausen <lars@metafoo.de>
    clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()

Stephen Boyd <sboyd@codeaurora.org>
    clk: Don't touch hardware when reparenting during registration

Romain Izard <romain.izard.pro@gmail.com>
    clk: at91: pmc: Wait for clocks when resuming

Benjamin Coddington <bcodding@redhat.com>
    nfsd4: permit layoutget of executable-only files

Joel Stanley <joel@jms.id.au>
    ARM: dts: aspeed-evb: Add unit name to memory node

Anton Vasilyev <vasilyev@ispras.ru>
    RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix issues connecting with nvme initiator

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix SCSI LUN discovery when SCSI and NVME enabled

Johan Hovold <johan@kernel.org>
    soc: qcom: smsm: fix child-node lookup

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip_gre: fix potential memory leak in erspan_rcv

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip_gre: fix error path when erspan_rcv failed

Alexey Kodanev <alexey.kodanev@oracle.com>
    ip6_vti: adjust vti mtu according to mtu of lower device

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/vt-d: clean up pr_irq if request_threaded_irq fails

Brian Norris <briannorris@chromium.org>
    pinctrl: rockchip: enable clock when reading pin direction register

Florian Fainelli <f.fainelli@gmail.com>
    pinctrl: Really force states during suspend/resume

Jerome Brunet <jbrunet@baylibre.com>
    clk: use round rate to bail out early in set_rate

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    dt-bindings: display: panel: Fix compatible string for Toshiba LT089AC29000

Jerome Brunet <jbrunet@baylibre.com>
    clk: check ops pointer on clock register

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: davinci: fix a debug printk

Geert Uytterhoeven <geert+renesas@glider.be>
    PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures

Niklas Cassel <niklas.cassel@axis.com>
    PCI: endpoint: Fix find_first_zero_bit() usage

Kishon Vijay Abraham I <kishon@ti.com>
    PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit

Robert Walker <robert.walker@arm.com>
    coresight: Fix disabling of CoreSight TPIU

Sahara <keun-o.park@darkmatter.ae>
    pty: cancel pty slave port buf's work in tty_release

Peter Ujfalusi <peter.ujfalusi@ti.com>
    drm/omap: DMM: Check for DMM readiness after successful transaction commit

Zhoujie Wu <zjwu@marvell.com>
    mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable

H. Nikolaus Schaller <hns@goldelico.com>
    omapdrm: panel: fix compatible vendor string for td028ttec1

Bjorn Helgaas <bhelgaas@google.com>
    vgacon: Set VGA struct resource types

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics

Yonghong Song <yhs@fb.com>
    bpf/cgroup: fix a verification error for a CGROUP_DEVICE type prog

Bharat Potnuri <bharat@chelsio.com>
    iser-target: avoid reinitializing rdma contexts for isert commands

Artemy Kovalyov <artemyko@mellanox.com>
    IB/umem: Fix use of npages/nmap fields

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Use correct size when writing netlink stats

Erez Shitrit <erezsh@mellanox.com>
    IB/ipoib: Avoid memory leak if the SA returns a different DGID

Alexandre Belloni <alexandre.belloni@free-electrons.com>
    rtc: ac100: Fix multiple race conditions

Shuah Khan <shuah@kernel.org>
    media: s5p-mfc: Fix lock contention - request_firmware() once

Russell King <rmk+kernel@armlinux.org.uk>
    sfp: fix non-detection of PHY

Russell King <rmk+kernel@armlinux.org.uk>
    sfp: fix EEPROM reading in the case of non-SFF8472 SFPs

Jerome Brunet <jbrunet@baylibre.com>
    net: phy: meson-gxl: check phy_write return value

Kees Cook <keescook@chromium.org>
    /dev/mem: Add bounce buffer for copy-out

Liu, Changcheng <changcheng.liu@intel.com>
    mmc: block: fix logical error to avoid memory leak

Daniel Drake <drake@endlessm.com>
    mmc: avoid removing non-removable hosts during suspend

Logan Gunthorpe <logang@deltatee.com>
    drm/tilcdc: ensure nonatomic iowrite64 is not used

Kedareswara rao Appana <appana.durga.rao@xilinx.com>
    dmaengine: zynqmp_dma: Fix race condition in the probe

Shawn Nematbakhsh <shawnn@chromium.org>
    platform/chrome: Use proper protocol transfer function

Guenter Roeck <linux@roeck-us.net>
    watchdog: Fix kref imbalance seen if handle_boot_enabled=0

Guenter Roeck <linux@roeck-us.net>
    watchdog: Fix potential kref imbalance when opening watchdog

Arnd Bergmann <arnd@arndb.de>
    cros_ec: fix nul-termination for firmware build info

Stefan Potyra <Stefan.Potyra@elektrobit.com>
    serial: 8250_dw: Disable clock on error

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tty: goldfish: Enable 'earlycon' only if built-in

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect

Ron Economos <w6rz@comcast.net>
    media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart

Balaji Pothunoori <bpothuno@qti.qualcomm.com>
    ath10k: handling qos at STA side based on AP WMM enable/disable

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: bt8xx: Fix err 'bt878_probe()'

Nicolas Iooss <nicolas.iooss_linux@m4x.org>
    rtlwifi: always initialize variables given to RT_TRACE()

Tsang-Shian Lin <thlin@realtek.com>
    rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.

Roman Gushchin <guro@fb.com>
    libbpf: prefer global symbols as bpf program name source

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: sh-msiof: Avoid writing to registers from spi_master.setup()

Neal Cardwell <ncardwell@google.com>
    tcp: allow TLP in ECN CWR

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix the TX/RX buffer default sizes

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix the receive buffer size limit

Geert Uytterhoeven <geert@linux-m68k.org>
    RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()

Yuval Shaia <yuval.shaia@oracle.com>
    IB/ipoib: Warn when one port fails to initialize

Richard Leitner <richard.leitner@skidata.com>
    net: fec: add phy_reset_after_clk_enable() support

Prakash Kamliya <pkamliya@codeaurora.org>
    drm/msm: fix leak in failed get_pages

Gustavo A. R. Silva <garsilva@embeddedor.com>
    media: c8sectpfe: fix potential NULL pointer dereference in c8sectpfe_timer_interrupt

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: longhaul: Revert transition_delay_us to 200 ms

Loic Poulain <loic.poulain@linaro.org>
    Bluetooth: btqcomsmd: Fix skb double free corruption

Loic Poulain <loic.poulain@linaro.org>
    Bluetooth: hci_qca: Avoid setup failure on missing rampatch

Pixel Ding <Pixel.Ding@amd.com>
    drm/amdgpu: use polling mem to set SDMA3 wptr for VF

Yisheng Xie <xieyisheng1@huawei.com>
    staging: android: ashmem: Fix possible deadlock in ashmem_ioctl

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Do not use 32-bit atomic request descriptor for Ventura controllers


-------------

Diffstat:

 .../display/panel/toshiba,lt089ac29000.txt         |  2 +-
 .../{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} |  4 +-
 Makefile                                           |  4 +-
 arch/alpha/kernel/console.c                        |  1 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |  2 +-
 drivers/bluetooth/btqcomsmd.c                      |  3 +-
 drivers/bluetooth/hci_qca.c                        |  3 +
 drivers/char/hw_random/core.c                      |  4 ++
 drivers/char/mem.c                                 | 27 ++++++--
 drivers/clk/at91/pmc.c                             | 24 +++++---
 drivers/clk/clk-axi-clkgen.c                       | 29 +++++++--
 drivers/clk/clk-si5351.c                           |  2 +-
 drivers/clk/clk.c                                  | 64 ++++++++++++++-----
 drivers/cpufreq/longhaul.c                         |  2 +-
 drivers/crypto/axis/artpec6_crypto.c               |  5 +-
 drivers/dma/ti-dma-crossbar.c                      | 10 ++-
 drivers/dma/xilinx/zynqmp_dma.c                    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             | 27 +++++---
 drivers/gpu/drm/msm/msm_gem.c                      | 14 +++--
 .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |  3 +
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |  5 ++
 drivers/gpu/drm/tilcdc/tilcdc_regs.h               |  2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       | 13 +++-
 drivers/infiniband/core/cma.c                      | 17 ++++--
 drivers/infiniband/core/iwpm_util.c                |  1 +
 drivers/infiniband/core/ucma.c                     |  8 ++-
 drivers/infiniband/core/umem.c                     |  2 +-
 drivers/infiniband/hw/mlx5/qp.c                    | 23 ++++---
 drivers/infiniband/hw/mlx5/srq.c                   | 15 +++--
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |  4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |  4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |  4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          | 23 ++++++-
 drivers/infiniband/ulp/isert/ib_isert.c            |  7 +++
 drivers/infiniband/ulp/isert/ib_isert.h            |  1 +
 drivers/iommu/intel-svm.c                          |  9 ++-
 drivers/media/dvb-frontends/si2168.c               |  3 +
 drivers/media/pci/bt8xx/bt878.c                    |  3 +-
 drivers/media/platform/davinci/vpif_capture.c      |  4 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c           |  6 ++
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h    |  3 +
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c      |  5 ++
 .../media/platform/sti/c8sectpfe/c8sectpfe-core.c  |  4 +-
 drivers/mmc/core/block.c                           |  1 +
 drivers/mmc/core/core.c                            |  8 +++
 drivers/mmc/host/sdhci-xenon.c                     |  7 +++
 drivers/net/ethernet/freescale/fec_main.c          | 20 ++++++
 drivers/net/hyperv/hyperv_net.h                    | 19 +++++-
 drivers/net/hyperv/netvsc.c                        |  5 ++
 drivers/net/hyperv/netvsc_drv.c                    |  4 --
 drivers/net/phy/meson-gxl.c                        | 50 +++++++++++----
 drivers/net/phy/sfp.c                              | 15 +++--
 drivers/net/usb/qmi_wwan.c                         |  4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  2 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |  2 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  7 +++
 drivers/pci/dwc/pcie-designware-ep.c               | 12 +---
 drivers/pci/dwc/pcie-designware.h                  |  1 +
 drivers/pci/endpoint/pci-ep-cfs.c                  |  5 +-
 drivers/pci/host/pcie-rcar.c                       |  5 +-
 drivers/pci/pcie/aspm.c                            | 71 ++++++++++++++--------
 drivers/pinctrl/core.c                             | 24 +++++---
 drivers/pinctrl/pinctrl-rockchip.c                 |  8 +++
 drivers/platform/chrome/cros_ec_proto.c            |  8 ++-
 drivers/platform/chrome/cros_ec_sysfs.c            |  2 +-
 drivers/rtc/rtc-ac100.c                            | 19 +++---
 drivers/scsi/lpfc/lpfc_ct.c                        |  1 +
 drivers/scsi/lpfc/lpfc_els.c                       | 30 ++++++---
 drivers/scsi/lpfc/lpfc_nportdisc.c                 | 34 +++++------
 drivers/scsi/megaraid/megaraid_sas_fusion.c        | 42 +++++--------
 drivers/soc/qcom/smsm.c                            |  6 +-
 drivers/spi/spi-sh-msiof.c                         | 35 +++++++----
 drivers/staging/android/ashmem.c                   |  8 +--
 drivers/tty/Kconfig                                |  6 +-
 drivers/tty/goldfish.c                             |  2 +
 drivers/tty/serial/8250/8250_dw.c                  |  3 +-
 drivers/tty/serial/8250/8250_pci.c                 | 10 ++-
 drivers/tty/tty_io.c                               |  2 +
 drivers/video/console/vgacon.c                     | 34 ++++++++---
 .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |  3 +
 drivers/watchdog/watchdog_dev.c                    | 17 +++---
 fs/nfsd/nfs4proc.c                                 |  6 +-
 include/linux/mlx5/driver.h                        |  4 +-
 include/uapi/linux/bpf.h                           |  3 +-
 kernel/bpf/cgroup.c                                | 15 ++++-
 net/ipv4/ip_gre.c                                  |  6 +-
 net/ipv4/tcp_output.c                              |  9 +--
 net/ipv6/ip6_vti.c                                 | 20 ++++++
 security/Kconfig                                   |  1 +
 tools/lib/bpf/libbpf.c                             |  2 +
 92 files changed, 708 insertions(+), 292 deletions(-)
