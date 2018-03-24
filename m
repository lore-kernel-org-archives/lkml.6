Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3414317-1521877965-2-2148604469337778231
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
    t=1521877964; b=fABV7RnuvIL0KQSIAOC0NjdgZL5Rr1s7J4Z3+LnaCf7osaR
    scOeLIEEIrAPo1Vas6MvvNOf2e8sG+D4RhzReLMmblZudnaTlDZjuLL6xxJSBtSl
    jfyci5l0L3deZT1gHZ8Ulfx80sl7pOP+CeeLcxZA+j4HiT1/ZJw+tFkDzSxk/ZEY
    evGENdaLPFVv+64mpTk865lHlDqjZqH/e059PuU3A4EMTEClTaA0ZvCTHz+p/gb9
    b8fY1lYWhpM0jyI/MpWzDch/v6d6FIc2vKg1bo65iFSLlC2vVpkG5IImCMUoh9/4
    g0esyU+hyoO3KsCDTv0RqVCcdS0s2TEbgjFjKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521877964; bh=35mCUnlzwYGLBsgdKNjJz6zqInxNtSvs2qsy2e19c6U=; b=I
    Vp0M/Zh4cWdJbH9NxFiCfhkhQYOlIBhiOgaHMnseCXtcOu/cUP078pZMJDVWSAnv
    /BwV7iwCuu5CSxzisKNHpCcJjYCxpquycJv6fcqC4+ccJ5Kiv8RaO33ROiMdkKA2
    0vOVUL3SVrjKbF/0TzMBs3bVpKvQIGD7gsTknYLvvtE2StzMZb1MVq+jfT7sxB2Q
    Utl9UY8ENbsTuzkOXvpZUEBhyy8nZS5QSniPeDH3SRqaYLNoAQIY7fofD4ZYJrf2
    Wm1aIiEte1FroLC15qzJwPphkVtVwbj5fIoHByJkPEiDDQVEutL29HvsCLHqkfCq
    pybkyqLJWRdA5ciFTd5Eg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GJaYG+2G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=M+eL95/P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GJaYG+2G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=M+eL95/P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeCXHwl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 03:52:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45553 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeCXHwj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Mar 2018 03:52:39 -0400
X-Google-Smtp-Source: AIpwx49u432LOl9EM4H/csK1sp7FtAlbvK3gQ4iNJGS4rH2aDRYLGXFneg+j53IXL2TCmZsopKkGXAuSk/O5vje+BCI=
MIME-Version: 1.0
In-Reply-To: <20180323164026.GB5063@kroah.com>
References: <20180323095411.913234798@linuxfoundation.org> <CA+G9fYtYBMr84wUTshzryQRLuH5o1u8q71SnKVp_cq0ohofFsg@mail.gmail.com>
 <20180323164026.GB5063@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 24 Mar 2018 13:22:36 +0530
Message-ID: <CA+G9fYvdedeRG8+omRFGWUOd34rYps0-Lgptu1ToOLFEY-Zipg@mail.gmail.com>
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

On 23 March 2018 at 22:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Mar 23, 2018 at 07:52:45PM +0530, Naresh Kamboju wrote:
>> On 23 March 2018 at 15:23, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > This is the start of the stable review cycle for the 4.15.13 release.
>> > There are 84 patches in this series, all will be posted as a response
>> > to this one.  If anyone has any issues with these being applied, pleas=
e
>> > let me know.
>> >
>> > Responses should be made by Sun Mar 25 09:53:34 UTC 2018.
>> > Anything received after that time might be too late.
>> >
>> > The whole patch series can be found in one patch at:
>> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/pat=
ch-4.15.13-rc1.gz
>> > or in the git tree and branch at:
>> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-sta=
ble-rc.git linux-4.15.y
>> > and the diffstat can be found below.
>> >
>> > thanks,
>> >
>> > greg k-h
>> >
>> > -------------
>> > Pseudo-Shortlog of commits:
>> >
>> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >     Linux 4.15.13-rc1
>> >
>> > Leon Romanovsky <leonro@mellanox.com>
>> >     RDMA/ucma: Don't allow join attempts for unsupported AF family
>> >
>> > Leon Romanovsky <leonro@mellanox.com>
>> >     RDMA/ucma: Fix access to non-initialized CM_ID object
>> >
>> > Jerome Brunet <jbrunet@baylibre.com>
>> >     clk: migrate the count of orphaned clocks at init
>> >
>> > Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>> >     RDMA/core: Do not use invalid destination in determining port reus=
e
>> >
>> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >     serial: 8250_pci: Don't fail on multiport card class
>> >
>> > Adit Ranadive <aditr@vmware.com>
>> >     RDMA/vmw_pvrdma: Fix usage of user response structures in ABI file
>> >
>> > Boris Pismenny <borisp@mellanox.com>
>> >     IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq
>> >
>> > Boris Pismenny <borisp@mellanox.com>
>> >     IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
>> >
>> > Vignesh R <vigneshr@ti.com>
>> >     dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_=
63
>> >
>> > Gary R Hook <gary.hook@amd.com>
>> >     hwrng: core - Clean up RNG list when last hwrng is unregistered
>> >
>> > Lars Persson <lars.persson@axis.com>
>> >     crypto: artpec6 - set correct iv size for gcm(aes)
>> >
>> > Sergej Sawazki <sergej@taudac.com>
>> >     clk: si5351: Rename internal plls to avoid name collisions
>> >
>> > Lars-Peter Clausen <lars@metafoo.de>
>> >     clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()
>> >
>> > Stephen Boyd <sboyd@codeaurora.org>
>> >     clk: Don't touch hardware when reparenting during registration
>> >
>> > Romain Izard <romain.izard.pro@gmail.com>
>> >     clk: at91: pmc: Wait for clocks when resuming
>> >
>> > Benjamin Coddington <bcodding@redhat.com>
>> >     nfsd4: permit layoutget of executable-only files
>> >
>> > Joel Stanley <joel@jms.id.au>
>> >     ARM: dts: aspeed-evb: Add unit name to memory node
>> >
>> > Anton Vasilyev <vasilyev@ispras.ru>
>> >     RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS
>> >
>> > James Smart <jsmart2021@gmail.com>
>> >     scsi: lpfc: Fix issues connecting with nvme initiator
>> >
>> > James Smart <jsmart2021@gmail.com>
>> >     scsi: lpfc: Fix SCSI LUN discovery when SCSI and NVME enabled
>> >
>> > Johan Hovold <johan@kernel.org>
>> >     soc: qcom: smsm: fix child-node lookup
>> >
>> > Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
>> >     ip_gre: fix potential memory leak in erspan_rcv
>> >
>> > Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
>> >     ip_gre: fix error path when erspan_rcv failed
>> >
>> > Alexey Kodanev <alexey.kodanev@oracle.com>
>> >     ip6_vti: adjust vti mtu according to mtu of lower device
>> >
>> > Jerry Snitselaar <jsnitsel@redhat.com>
>> >     iommu/vt-d: clean up pr_irq if request_threaded_irq fails
>> >
>> > Brian Norris <briannorris@chromium.org>
>> >     pinctrl: rockchip: enable clock when reading pin direction registe=
r
>> >
>> > Florian Fainelli <f.fainelli@gmail.com>
>> >     pinctrl: Really force states during suspend/resume
>> >
>> > Jerome Brunet <jbrunet@baylibre.com>
>> >     clk: use round rate to bail out early in set_rate
>> >
>> > Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>> >     dt-bindings: display: panel: Fix compatible string for Toshiba LT0=
89AC29000
>> >
>> > Jerome Brunet <jbrunet@baylibre.com>
>> >     clk: check ops pointer on clock register
>> >
>> > Mauro Carvalho Chehab <mchehab@kernel.org>
>> >     media: davinci: fix a debug printk
>> >
>> > Geert Uytterhoeven <geert+renesas@glider.be>
>> >     PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures
>> >
>> > Niklas Cassel <niklas.cassel@axis.com>
>> >     PCI: endpoint: Fix find_first_zero_bit() usage
>> >
>> > Kishon Vijay Abraham I <kishon@ti.com>
>> >     PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit
>> >
>> > Robert Walker <robert.walker@arm.com>
>> >     coresight: Fix disabling of CoreSight TPIU
>> >
>> > Sahara <keun-o.park@darkmatter.ae>
>> >     pty: cancel pty slave port buf's work in tty_release
>> >
>> > Peter Ujfalusi <peter.ujfalusi@ti.com>
>> >     drm/omap: DMM: Check for DMM readiness after successful transactio=
n commit
>> >
>> > Zhoujie Wu <zjwu@marvell.com>
>> >     mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable
>> >
>> > H. Nikolaus Schaller <hns@goldelico.com>
>> >     omapdrm: panel: fix compatible vendor string for td028ttec1
>> >
>> > Bjorn Helgaas <bhelgaas@google.com>
>> >     vgacon: Set VGA struct resource types
>> >
>> > Bjorn Helgaas <bhelgaas@google.com>
>> >     PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
>> >
>> > Yonghong Song <yhs@fb.com>
>> >     bpf/cgroup: fix a verification error for a CGROUP_DEVICE type prog
>> >
>> > Bharat Potnuri <bharat@chelsio.com>
>> >     iser-target: avoid reinitializing rdma contexts for isert commands
>> >
>> > Artemy Kovalyov <artemyko@mellanox.com>
>> >     IB/umem: Fix use of npages/nmap fields
>> >
>> > Parav Pandit <parav@mellanox.com>
>> >     RDMA/cma: Use correct size when writing netlink stats
>> >
>> > Erez Shitrit <erezsh@mellanox.com>
>> >     IB/ipoib: Avoid memory leak if the SA returns a different DGID
>> >
>> > Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> >     rtc: ac100: Fix multiple race conditions
>> >
>> > Shuah Khan <shuah@kernel.org>
>> >     media: s5p-mfc: Fix lock contention - request_firmware() once
>> >
>> > Russell King <rmk+kernel@armlinux.org.uk>
>> >     sfp: fix non-detection of PHY
>> >
>> > Russell King <rmk+kernel@armlinux.org.uk>
>> >     sfp: fix EEPROM reading in the case of non-SFF8472 SFPs
>> >
>> > Jerome Brunet <jbrunet@baylibre.com>
>> >     net: phy: meson-gxl: check phy_write return value
>> >
>> > Kees Cook <keescook@chromium.org>
>> >     /dev/mem: Add bounce buffer for copy-out
>> >
>> > Liu, Changcheng <changcheng.liu@intel.com>
>> >     mmc: block: fix logical error to avoid memory leak
>> >
>> > Daniel Drake <drake@endlessm.com>
>> >     mmc: avoid removing non-removable hosts during suspend
>> >
>> > Logan Gunthorpe <logang@deltatee.com>
>> >     drm/tilcdc: ensure nonatomic iowrite64 is not used
>> >
>> > Kedareswara rao Appana <appana.durga.rao@xilinx.com>
>> >     dmaengine: zynqmp_dma: Fix race condition in the probe
>> >
>> > Shawn Nematbakhsh <shawnn@chromium.org>
>> >     platform/chrome: Use proper protocol transfer function
>> >
>> > Guenter Roeck <linux@roeck-us.net>
>> >     watchdog: Fix kref imbalance seen if handle_boot_enabled=3D0
>> >
>> > Guenter Roeck <linux@roeck-us.net>
>> >     watchdog: Fix potential kref imbalance when opening watchdog
>> >
>> > Arnd Bergmann <arnd@arndb.de>
>> >     cros_ec: fix nul-termination for firmware build info
>> >
>> > Stefan Potyra <Stefan.Potyra@elektrobit.com>
>> >     serial: 8250_dw: Disable clock on error
>> >
>> > Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> >     tty: goldfish: Enable 'earlycon' only if built-in
>> >
>> > Bj=C3=B8rn Mork <bjorn@mork.no>
>> >     qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect
>> >
>> > Ron Economos <w6rz@comcast.net>
>> >     media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart
>> >
>> > Balaji Pothunoori <bpothuno@qti.qualcomm.com>
>> >     ath10k: handling qos at STA side based on AP WMM enable/disable
>> >
>> > Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> >     media: bt8xx: Fix err 'bt878_probe()'
>> >
>> > Nicolas Iooss <nicolas.iooss_linux@m4x.org>
>> >     rtlwifi: always initialize variables given to RT_TRACE()
>> >
>> > Tsang-Shian Lin <thlin@realtek.com>
>> >     rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.
>> >
>> > Roman Gushchin <guro@fb.com>
>> >     libbpf: prefer global symbols as bpf program name source
>> >
>> > Geert Uytterhoeven <geert+renesas@glider.be>
>> >     spi: sh-msiof: Avoid writing to registers from spi_master.setup()
>> >
>> > Neal Cardwell <ncardwell@google.com>
>> >     tcp: allow TLP in ECN CWR
>> >
>> > Haiyang Zhang <haiyangz@microsoft.com>
>> >     hv_netvsc: Fix the TX/RX buffer default sizes
>> >
>> > Haiyang Zhang <haiyangz@microsoft.com>
>> >     hv_netvsc: Fix the receive buffer size limit
>> >
>> > Geert Uytterhoeven <geert@linux-m68k.org>
>> >     RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
>> >
>> > Yuval Shaia <yuval.shaia@oracle.com>
>> >     IB/ipoib: Warn when one port fails to initialize
>> >
>> > Richard Leitner <richard.leitner@skidata.com>
>> >     net: fec: add phy_reset_after_clk_enable() support
>>
>> This fails to build for arm32 with default config on both 4.14 and 4.15
>>
>> GCCVERSION ?=3D "linaro-6.2"
>>
>> drivers/net/ethernet/freescale/fec_main.c: In function 'fec_enet_clk_ena=
ble':
>> drivers/net/ethernet/freescale/fec_main.c:1876:3: error: implicit declar=
ation
>> of function phy_reset_after_clk_enable [-Werror=3Dimplicit-function-decl=
aration]
>>     phy_reset_after_clk_enable(ndev->phydev);
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: some warnings being treated as errors
>
> Now dropped from 4.14.y and 4.15.y queues, thanks.


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
Due to Infrastructure issues test did not run on Hikey and dragon board.

Summary
------------------------------------------------------------------------

kernel: 4.15.13-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.15.y
git commit: 85ccdc83def5ebe8cf4e9e3301a80572dcb26f54
git describe: v4.15.12-84-g85ccdc83def5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.15-oe/bu=
ild/v4.15.12-84-g85ccdc83def5


No regressions (compared to build v4.15.12-85-g83e31ede344d)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 17, pass: 48
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

qemu_x86_64
* boot - pass: 22
* kselftest - skip: 23, pass: 57
* kselftest-vsyscall-mode-native - skip: 23, pass: 57
* kselftest-vsyscall-mode-none - skip: 23, pass: 57
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 21, pass: 41
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 18, pass: 63
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 2, pass: 20
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 97, pass: 1053
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 19, pass: 61
* kselftest-vsyscall-mode-native - skip: 19, pass: 61
* kselftest-vsyscall-mode-none - skip: 19, fail: 1, pass: 60
* libhugetlbfs - skip: 1, pass: 89
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 63
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 1, pass: 62
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 5, pass: 9
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 119, pass: 1031
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org

>
> greg k-h
