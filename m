Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1673992-1521823234-2-5721364186069875743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521823231; b=HU9E0dOV8T1ys5y+Mqnu9l+d5Mv9OJWZInwSX6MX7dsdF7W
    g55G8/PY8/7eXNpSpuM15VDqWRMiEf6bZUzrflrN+hI/NeCYuq3oSxouWLxZtkRM
    tmCq3dIxQOje/RrxdRuM9V5VW5cbZ1O2O/e4Anjt5KNKZeiql1enwPWQL16wbj9I
    1ASPOJIOcxa93Pz7g+aohyvF9UAYYB0ysnX3aIeEK7f4GCGmgvHh6P+TOHu71yXn
    LkdGCjQV1LdFJgKsqILTYgpBY1NVgEW79af74PJ3FwjHCh5BRWKrYjnNhKhkBCJY
    MlcjRhGGV6PwFO9arSYwQ32593sv1ySyzIVON0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521823231; bh=zzfdPBi
    Y5uSHDXD6FnhLROSaj8Gom1DopF6qJB22jRM=; b=nd7S0n1XfwW/+LLdpnZF6V6
    cFBmxA1fxkmgAPxtWBUa/9Wzn9k2YySVhMv4MvIJENORYcbwXCZbaqLAgBAaY+LO
    ky6HLRt8VMm3A/Dsndh/ctE57hVbG4HlvnYqpbbR8fVZg8wIA/tY1AuaLB+miP9l
    faHaj5/OtuqU7DTAj3z2qMe2cijQAI/fZazSfxxhI4sjSvGMCNDhf1qcttw1sVhV
    /QL/TlsVW5ZXeZHs5yPTZydjXdaSe8FsXHDve2shGl5SpbzbntPuUT96GgFV0jkK
    YX582lCy1OH6sEPfZLjtAoiyXl45Vfp7vIIufzjL4tgmECqs4Y3uHSfuq8S95yg=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeCWQka (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 12:40:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeCWQk3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 12:40:29 -0400
Date: Fri, 23 Mar 2018 17:40:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.15 00/84] 4.15.13-stable review
Message-ID: <20180323164026.GB5063@kroah.com>
References: <20180323095411.913234798@linuxfoundation.org>
 <CA+G9fYtYBMr84wUTshzryQRLuH5o1u8q71SnKVp_cq0ohofFsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtYBMr84wUTshzryQRLuH5o1u8q71SnKVp_cq0ohofFsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 07:52:45PM +0530, Naresh Kamboju wrote:
> On 23 March 2018 at 15:23, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.15.13 release.
> > There are 84 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar 25 09:53:34 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.13-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> > -------------
> > Pseudo-Shortlog of commits:
> >
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     Linux 4.15.13-rc1
> >
> > Leon Romanovsky <leonro@mellanox.com>
> >     RDMA/ucma: Don't allow join attempts for unsupported AF family
> >
> > Leon Romanovsky <leonro@mellanox.com>
> >     RDMA/ucma: Fix access to non-initialized CM_ID object
> >
> > Jerome Brunet <jbrunet@baylibre.com>
> >     clk: migrate the count of orphaned clocks at init
> >
> > Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> >     RDMA/core: Do not use invalid destination in determining port reuse
> >
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >     serial: 8250_pci: Don't fail on multiport card class
> >
> > Adit Ranadive <aditr@vmware.com>
> >     RDMA/vmw_pvrdma: Fix usage of user response structures in ABI file
> >
> > Boris Pismenny <borisp@mellanox.com>
> >     IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq
> >
> > Boris Pismenny <borisp@mellanox.com>
> >     IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
> >
> > Vignesh R <vigneshr@ti.com>
> >     dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63
> >
> > Gary R Hook <gary.hook@amd.com>
> >     hwrng: core - Clean up RNG list when last hwrng is unregistered
> >
> > Lars Persson <lars.persson@axis.com>
> >     crypto: artpec6 - set correct iv size for gcm(aes)
> >
> > Sergej Sawazki <sergej@taudac.com>
> >     clk: si5351: Rename internal plls to avoid name collisions
> >
> > Lars-Peter Clausen <lars@metafoo.de>
> >     clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()
> >
> > Stephen Boyd <sboyd@codeaurora.org>
> >     clk: Don't touch hardware when reparenting during registration
> >
> > Romain Izard <romain.izard.pro@gmail.com>
> >     clk: at91: pmc: Wait for clocks when resuming
> >
> > Benjamin Coddington <bcodding@redhat.com>
> >     nfsd4: permit layoutget of executable-only files
> >
> > Joel Stanley <joel@jms.id.au>
> >     ARM: dts: aspeed-evb: Add unit name to memory node
> >
> > Anton Vasilyev <vasilyev@ispras.ru>
> >     RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS
> >
> > James Smart <jsmart2021@gmail.com>
> >     scsi: lpfc: Fix issues connecting with nvme initiator
> >
> > James Smart <jsmart2021@gmail.com>
> >     scsi: lpfc: Fix SCSI LUN discovery when SCSI and NVME enabled
> >
> > Johan Hovold <johan@kernel.org>
> >     soc: qcom: smsm: fix child-node lookup
> >
> > Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> >     ip_gre: fix potential memory leak in erspan_rcv
> >
> > Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> >     ip_gre: fix error path when erspan_rcv failed
> >
> > Alexey Kodanev <alexey.kodanev@oracle.com>
> >     ip6_vti: adjust vti mtu according to mtu of lower device
> >
> > Jerry Snitselaar <jsnitsel@redhat.com>
> >     iommu/vt-d: clean up pr_irq if request_threaded_irq fails
> >
> > Brian Norris <briannorris@chromium.org>
> >     pinctrl: rockchip: enable clock when reading pin direction register
> >
> > Florian Fainelli <f.fainelli@gmail.com>
> >     pinctrl: Really force states during suspend/resume
> >
> > Jerome Brunet <jbrunet@baylibre.com>
> >     clk: use round rate to bail out early in set_rate
> >
> > Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> >     dt-bindings: display: panel: Fix compatible string for Toshiba LT089AC29000
> >
> > Jerome Brunet <jbrunet@baylibre.com>
> >     clk: check ops pointer on clock register
> >
> > Mauro Carvalho Chehab <mchehab@kernel.org>
> >     media: davinci: fix a debug printk
> >
> > Geert Uytterhoeven <geert+renesas@glider.be>
> >     PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures
> >
> > Niklas Cassel <niklas.cassel@axis.com>
> >     PCI: endpoint: Fix find_first_zero_bit() usage
> >
> > Kishon Vijay Abraham I <kishon@ti.com>
> >     PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit
> >
> > Robert Walker <robert.walker@arm.com>
> >     coresight: Fix disabling of CoreSight TPIU
> >
> > Sahara <keun-o.park@darkmatter.ae>
> >     pty: cancel pty slave port buf's work in tty_release
> >
> > Peter Ujfalusi <peter.ujfalusi@ti.com>
> >     drm/omap: DMM: Check for DMM readiness after successful transaction commit
> >
> > Zhoujie Wu <zjwu@marvell.com>
> >     mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable
> >
> > H. Nikolaus Schaller <hns@goldelico.com>
> >     omapdrm: panel: fix compatible vendor string for td028ttec1
> >
> > Bjorn Helgaas <bhelgaas@google.com>
> >     vgacon: Set VGA struct resource types
> >
> > Bjorn Helgaas <bhelgaas@google.com>
> >     PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
> >
> > Yonghong Song <yhs@fb.com>
> >     bpf/cgroup: fix a verification error for a CGROUP_DEVICE type prog
> >
> > Bharat Potnuri <bharat@chelsio.com>
> >     iser-target: avoid reinitializing rdma contexts for isert commands
> >
> > Artemy Kovalyov <artemyko@mellanox.com>
> >     IB/umem: Fix use of npages/nmap fields
> >
> > Parav Pandit <parav@mellanox.com>
> >     RDMA/cma: Use correct size when writing netlink stats
> >
> > Erez Shitrit <erezsh@mellanox.com>
> >     IB/ipoib: Avoid memory leak if the SA returns a different DGID
> >
> > Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >     rtc: ac100: Fix multiple race conditions
> >
> > Shuah Khan <shuah@kernel.org>
> >     media: s5p-mfc: Fix lock contention - request_firmware() once
> >
> > Russell King <rmk+kernel@armlinux.org.uk>
> >     sfp: fix non-detection of PHY
> >
> > Russell King <rmk+kernel@armlinux.org.uk>
> >     sfp: fix EEPROM reading in the case of non-SFF8472 SFPs
> >
> > Jerome Brunet <jbrunet@baylibre.com>
> >     net: phy: meson-gxl: check phy_write return value
> >
> > Kees Cook <keescook@chromium.org>
> >     /dev/mem: Add bounce buffer for copy-out
> >
> > Liu, Changcheng <changcheng.liu@intel.com>
> >     mmc: block: fix logical error to avoid memory leak
> >
> > Daniel Drake <drake@endlessm.com>
> >     mmc: avoid removing non-removable hosts during suspend
> >
> > Logan Gunthorpe <logang@deltatee.com>
> >     drm/tilcdc: ensure nonatomic iowrite64 is not used
> >
> > Kedareswara rao Appana <appana.durga.rao@xilinx.com>
> >     dmaengine: zynqmp_dma: Fix race condition in the probe
> >
> > Shawn Nematbakhsh <shawnn@chromium.org>
> >     platform/chrome: Use proper protocol transfer function
> >
> > Guenter Roeck <linux@roeck-us.net>
> >     watchdog: Fix kref imbalance seen if handle_boot_enabled=0
> >
> > Guenter Roeck <linux@roeck-us.net>
> >     watchdog: Fix potential kref imbalance when opening watchdog
> >
> > Arnd Bergmann <arnd@arndb.de>
> >     cros_ec: fix nul-termination for firmware build info
> >
> > Stefan Potyra <Stefan.Potyra@elektrobit.com>
> >     serial: 8250_dw: Disable clock on error
> >
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >     tty: goldfish: Enable 'earlycon' only if built-in
> >
> > Bjørn Mork <bjorn@mork.no>
> >     qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect
> >
> > Ron Economos <w6rz@comcast.net>
> >     media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart
> >
> > Balaji Pothunoori <bpothuno@qti.qualcomm.com>
> >     ath10k: handling qos at STA side based on AP WMM enable/disable
> >
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >     media: bt8xx: Fix err 'bt878_probe()'
> >
> > Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> >     rtlwifi: always initialize variables given to RT_TRACE()
> >
> > Tsang-Shian Lin <thlin@realtek.com>
> >     rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.
> >
> > Roman Gushchin <guro@fb.com>
> >     libbpf: prefer global symbols as bpf program name source
> >
> > Geert Uytterhoeven <geert+renesas@glider.be>
> >     spi: sh-msiof: Avoid writing to registers from spi_master.setup()
> >
> > Neal Cardwell <ncardwell@google.com>
> >     tcp: allow TLP in ECN CWR
> >
> > Haiyang Zhang <haiyangz@microsoft.com>
> >     hv_netvsc: Fix the TX/RX buffer default sizes
> >
> > Haiyang Zhang <haiyangz@microsoft.com>
> >     hv_netvsc: Fix the receive buffer size limit
> >
> > Geert Uytterhoeven <geert@linux-m68k.org>
> >     RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
> >
> > Yuval Shaia <yuval.shaia@oracle.com>
> >     IB/ipoib: Warn when one port fails to initialize
> >
> > Richard Leitner <richard.leitner@skidata.com>
> >     net: fec: add phy_reset_after_clk_enable() support
> 
> This fails to build for arm32 with default config on both 4.14 and 4.15
> 
> GCCVERSION ?= "linaro-6.2"
> 
> drivers/net/ethernet/freescale/fec_main.c: In function 'fec_enet_clk_enable':
> drivers/net/ethernet/freescale/fec_main.c:1876:3: error: implicit declaration
> of function phy_reset_after_clk_enable [-Werror=implicit-function-declaration]
>     phy_reset_after_clk_enable(ndev->phydev);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors

Now dropped from 4.14.y and 4.15.y queues, thanks.

greg k-h
