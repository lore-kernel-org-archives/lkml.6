Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1421790-1521814987-2-13020396781562951983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521814986; b=QTa2Py1OhXIJAxMQAKr5nLyyY30PLSned7qgs+pHmvMl9+r
    z5rZ9zSKjMOAL5tww+/pU0jt3uQ1HkxqyK/znNIRGYAkwbEli7lihgnrpHW7DVP8
    3x5iYjHK7/y3h4HrpYUXb4WyK2LB/C1VdslQrFADNZx8jgxq0vEncuKpx390MUEO
    g+ec9SQVWrubqr4m6OjqnZqlrETqwe4+ipr+mJ8J7SRgIHNuMsl1QcSM2+5xdoWz
    yGs+cu+8p8iMm3UfNP96NoAW0qlhenzCR8uUXdFD5NZCp+V5wq6ahyAROP/3TUPo
    YT9408zJwBY2gptmrY4QDB08B487D4y6JF+ACCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521814986; bh=TBxIw/eQcatuqeDi7kBFtfn9vDgayimhRa9LKQGpAf8=; b=V
    IG8sse+g6b7LoZdQxEhAul24B52O2Hw46wFOGWfEH23swFXaGr8Esvki2Q6fQc2R
    GXwnPvcZi+IfTi0U0nTTH5Wca2o2anmOE3sjciIPCFQgYPDwHzrduKp+DVirFiJM
    AJcpAepMaVzBa7NqtK6bCgZ1m46QVz4m6Zoxc+FcNqSXTI3CFBX2cRBWXFK3uHOS
    jaFUvEEBgcBm5haOSZeXsN2O8GDeEpdAEGK0g+ZLDX/BsNGn4GkY1I+bKpzuEgL8
    j/cMHUtM8w74lLlh42sXPnEONgoEtbVwpoFJ5ov5zSm3a3rV5hnityt5Tne/POCf
    RXd6kU3Dcm5ljSCC8z9DQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Kl7MzoEN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U87sAw/e;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Kl7MzoEN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U87sAw/e;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCWOWv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 10:22:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38888 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeCWOWs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 10:22:48 -0400
X-Google-Smtp-Source: AG47ELtt0riplglm2XeeOqIWOwwmepq6F3LhReiYynFgb+qqXlp9We6ijxLHnmphOjtpayQ9M2HYcSnlil/OD8BEpok=
MIME-Version: 1.0
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 23 Mar 2018 19:52:45 +0530
Message-ID: <CA+G9fYtYBMr84wUTshzryQRLuH5o1u8q71SnKVp_cq0ohofFsg@mail.gmail.com>
Subject: Re: [PATCH 4.15 00/84] 4.15.13-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23 March 2018 at 15:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.15.13 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 25 09:53:34 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.15.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.15.13-rc1
>
> Leon Romanovsky <leonro@mellanox.com>
>     RDMA/ucma: Don't allow join attempts for unsupported AF family
>
> Leon Romanovsky <leonro@mellanox.com>
>     RDMA/ucma: Fix access to non-initialized CM_ID object
>
> Jerome Brunet <jbrunet@baylibre.com>
>     clk: migrate the count of orphaned clocks at init
>
> Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>     RDMA/core: Do not use invalid destination in determining port reuse
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     serial: 8250_pci: Don't fail on multiport card class
>
> Adit Ranadive <aditr@vmware.com>
>     RDMA/vmw_pvrdma: Fix usage of user response structures in ABI file
>
> Boris Pismenny <borisp@mellanox.com>
>     IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq
>
> Boris Pismenny <borisp@mellanox.com>
>     IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
>
> Vignesh R <vigneshr@ti.com>
>     dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63
>
> Gary R Hook <gary.hook@amd.com>
>     hwrng: core - Clean up RNG list when last hwrng is unregistered
>
> Lars Persson <lars.persson@axis.com>
>     crypto: artpec6 - set correct iv size for gcm(aes)
>
> Sergej Sawazki <sergej@taudac.com>
>     clk: si5351: Rename internal plls to avoid name collisions
>
> Lars-Peter Clausen <lars@metafoo.de>
>     clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()
>
> Stephen Boyd <sboyd@codeaurora.org>
>     clk: Don't touch hardware when reparenting during registration
>
> Romain Izard <romain.izard.pro@gmail.com>
>     clk: at91: pmc: Wait for clocks when resuming
>
> Benjamin Coddington <bcodding@redhat.com>
>     nfsd4: permit layoutget of executable-only files
>
> Joel Stanley <joel@jms.id.au>
>     ARM: dts: aspeed-evb: Add unit name to memory node
>
> Anton Vasilyev <vasilyev@ispras.ru>
>     RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS
>
> James Smart <jsmart2021@gmail.com>
>     scsi: lpfc: Fix issues connecting with nvme initiator
>
> James Smart <jsmart2021@gmail.com>
>     scsi: lpfc: Fix SCSI LUN discovery when SCSI and NVME enabled
>
> Johan Hovold <johan@kernel.org>
>     soc: qcom: smsm: fix child-node lookup
>
> Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
>     ip_gre: fix potential memory leak in erspan_rcv
>
> Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
>     ip_gre: fix error path when erspan_rcv failed
>
> Alexey Kodanev <alexey.kodanev@oracle.com>
>     ip6_vti: adjust vti mtu according to mtu of lower device
>
> Jerry Snitselaar <jsnitsel@redhat.com>
>     iommu/vt-d: clean up pr_irq if request_threaded_irq fails
>
> Brian Norris <briannorris@chromium.org>
>     pinctrl: rockchip: enable clock when reading pin direction register
>
> Florian Fainelli <f.fainelli@gmail.com>
>     pinctrl: Really force states during suspend/resume
>
> Jerome Brunet <jbrunet@baylibre.com>
>     clk: use round rate to bail out early in set_rate
>
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>     dt-bindings: display: panel: Fix compatible string for Toshiba LT089A=
C29000
>
> Jerome Brunet <jbrunet@baylibre.com>
>     clk: check ops pointer on clock register
>
> Mauro Carvalho Chehab <mchehab@kernel.org>
>     media: davinci: fix a debug printk
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures
>
> Niklas Cassel <niklas.cassel@axis.com>
>     PCI: endpoint: Fix find_first_zero_bit() usage
>
> Kishon Vijay Abraham I <kishon@ti.com>
>     PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit
>
> Robert Walker <robert.walker@arm.com>
>     coresight: Fix disabling of CoreSight TPIU
>
> Sahara <keun-o.park@darkmatter.ae>
>     pty: cancel pty slave port buf's work in tty_release
>
> Peter Ujfalusi <peter.ujfalusi@ti.com>
>     drm/omap: DMM: Check for DMM readiness after successful transaction c=
ommit
>
> Zhoujie Wu <zjwu@marvell.com>
>     mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable
>
> H. Nikolaus Schaller <hns@goldelico.com>
>     omapdrm: panel: fix compatible vendor string for td028ttec1
>
> Bjorn Helgaas <bhelgaas@google.com>
>     vgacon: Set VGA struct resource types
>
> Bjorn Helgaas <bhelgaas@google.com>
>     PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
>
> Yonghong Song <yhs@fb.com>
>     bpf/cgroup: fix a verification error for a CGROUP_DEVICE type prog
>
> Bharat Potnuri <bharat@chelsio.com>
>     iser-target: avoid reinitializing rdma contexts for isert commands
>
> Artemy Kovalyov <artemyko@mellanox.com>
>     IB/umem: Fix use of npages/nmap fields
>
> Parav Pandit <parav@mellanox.com>
>     RDMA/cma: Use correct size when writing netlink stats
>
> Erez Shitrit <erezsh@mellanox.com>
>     IB/ipoib: Avoid memory leak if the SA returns a different DGID
>
> Alexandre Belloni <alexandre.belloni@free-electrons.com>
>     rtc: ac100: Fix multiple race conditions
>
> Shuah Khan <shuah@kernel.org>
>     media: s5p-mfc: Fix lock contention - request_firmware() once
>
> Russell King <rmk+kernel@armlinux.org.uk>
>     sfp: fix non-detection of PHY
>
> Russell King <rmk+kernel@armlinux.org.uk>
>     sfp: fix EEPROM reading in the case of non-SFF8472 SFPs
>
> Jerome Brunet <jbrunet@baylibre.com>
>     net: phy: meson-gxl: check phy_write return value
>
> Kees Cook <keescook@chromium.org>
>     /dev/mem: Add bounce buffer for copy-out
>
> Liu, Changcheng <changcheng.liu@intel.com>
>     mmc: block: fix logical error to avoid memory leak
>
> Daniel Drake <drake@endlessm.com>
>     mmc: avoid removing non-removable hosts during suspend
>
> Logan Gunthorpe <logang@deltatee.com>
>     drm/tilcdc: ensure nonatomic iowrite64 is not used
>
> Kedareswara rao Appana <appana.durga.rao@xilinx.com>
>     dmaengine: zynqmp_dma: Fix race condition in the probe
>
> Shawn Nematbakhsh <shawnn@chromium.org>
>     platform/chrome: Use proper protocol transfer function
>
> Guenter Roeck <linux@roeck-us.net>
>     watchdog: Fix kref imbalance seen if handle_boot_enabled=3D0
>
> Guenter Roeck <linux@roeck-us.net>
>     watchdog: Fix potential kref imbalance when opening watchdog
>
> Arnd Bergmann <arnd@arndb.de>
>     cros_ec: fix nul-termination for firmware build info
>
> Stefan Potyra <Stefan.Potyra@elektrobit.com>
>     serial: 8250_dw: Disable clock on error
>
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     tty: goldfish: Enable 'earlycon' only if built-in
>
> Bj=C3=B8rn Mork <bjorn@mork.no>
>     qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect
>
> Ron Economos <w6rz@comcast.net>
>     media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart
>
> Balaji Pothunoori <bpothuno@qti.qualcomm.com>
>     ath10k: handling qos at STA side based on AP WMM enable/disable
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     media: bt8xx: Fix err 'bt878_probe()'
>
> Nicolas Iooss <nicolas.iooss_linux@m4x.org>
>     rtlwifi: always initialize variables given to RT_TRACE()
>
> Tsang-Shian Lin <thlin@realtek.com>
>     rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.
>
> Roman Gushchin <guro@fb.com>
>     libbpf: prefer global symbols as bpf program name source
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     spi: sh-msiof: Avoid writing to registers from spi_master.setup()
>
> Neal Cardwell <ncardwell@google.com>
>     tcp: allow TLP in ECN CWR
>
> Haiyang Zhang <haiyangz@microsoft.com>
>     hv_netvsc: Fix the TX/RX buffer default sizes
>
> Haiyang Zhang <haiyangz@microsoft.com>
>     hv_netvsc: Fix the receive buffer size limit
>
> Geert Uytterhoeven <geert@linux-m68k.org>
>     RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
>
> Yuval Shaia <yuval.shaia@oracle.com>
>     IB/ipoib: Warn when one port fails to initialize
>
> Richard Leitner <richard.leitner@skidata.com>
>     net: fec: add phy_reset_after_clk_enable() support

This fails to build for arm32 with default config on both 4.14 and 4.15

GCCVERSION ?=3D "linaro-6.2"

drivers/net/ethernet/freescale/fec_main.c: In function 'fec_enet_clk_enable=
':
drivers/net/ethernet/freescale/fec_main.c:1876:3: error: implicit declarati=
on
of function phy_reset_after_clk_enable [-Werror=3Dimplicit-function-declara=
tion]
    phy_reset_after_clk_enable(ndev->phydev);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
