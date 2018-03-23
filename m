Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805154-2-16101010549514612566
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
    t=1521805152; b=MNRbUpayBMfOJgZL3XhR+oMrZbUc1N066GhAhC/mLnFiE98
    voY5ZaptAUsdjpKT3++yofb05g/8+XEN3pcRT6GRrxOkD2X76lFRQX9LWREPaLlh
    8EiGVd66RyG0KrUMWFZlQZF93sAavdFaUgX6cAkEGqYqvF3VGGPk5oXIud5yv9OD
    m11IgQQGK5lDKqQ9CST6faXwZLr/MmI3bhVepaGvPHmb/6iuCRsoqDSZRWfrBthp
    2HQ0gvcb/lxULt3Jv24mFRUWXhFJ2Zqx00iBI5XB67drIon8nhO1HpdxyGwIcBF6
    Nrm2SDy3BTiCbJA5Nxxg7DvNNDbY/XiXL7HpA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521805152; bh=51qRddga3d8+1tnV/SzaFXTybP
    5in/v9YHjUFfzBF/U=; b=XqwNJ/JyqObxf22PK3fQbnre22cEWgsdHfuyqVEPm5
    58M2WOT8g5IwZVq9tXuUZOVN5pTlKJ67tvG8REcxxlwYl5eKvRH+VtZIjM2gaOV2
    ycfbzvApCrY9FKx33Shix9RkzUFLU4L+/8w2WpQzsrujtkTKxsrsm4gGhpEXk77i
    VcTsR7BfAGHsURsEKeRIU4QnmB5jX8alg4b1In+dt268pcr1iRvixLtnGCseSea6
    ppflGyprCeSwGnzRcfqhBPIlfbvI4qWEciqYMzfe7IJJ+/Kpob9JPFmbM8OseAjT
    TFgZSdAC1SE0rD2KpPO/JDF13VGzRfJOjPOyU8a/glUw==
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
        id S1752602AbeCWLiy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:38:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754751AbeCWKEe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/177] 4.9.90-stable review
Date: Fri, 23 Mar 2018 10:52:08 +0100
Message-Id: <20180323094205.090519271@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.90-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.90-rc1
X-KernelTest-Deadline: 2018-03-25T09:42+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.90 release.
There are 177 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 25 09:41:28 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.90-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.90-rc1

Krzysztof Opasiak <kopasiak90@gmail.com>
    usb: gadget: f_hid: fix: Move IN request allocation to set_alt()

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Don't allow join attempts for unsupported AF family

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Fix access to non-initialized CM_ID object

Jerome Brunet <jbrunet@baylibre.com>
    clk: migrate the count of orphaned clocks at init

Boris Pismenny <borisp@mellanox.com>
    IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq

Boris Pismenny <borisp@mellanox.com>
    IB/mlx5: Fix integer overflows in mlx5_ib_create_srq

Vignesh R <vigneshr@ti.com>
    dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63

Sergej Sawazki <sergej@taudac.com>
    clk: si5351: Rename internal plls to avoid name collisions

Lars-Peter Clausen <lars@metafoo.de>
    clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()

Stephen Boyd <sboyd@codeaurora.org>
    clk: Don't touch hardware when reparenting during registration

Benjamin Coddington <bcodding@redhat.com>
    nfsd4: permit layoutget of executable-only files

Joel Stanley <joel@jms.id.au>
    ARM: dts: aspeed-evb: Add unit name to memory node

Anton Vasilyev <vasilyev@ispras.ru>
    RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS

Alexey Kodanev <alexey.kodanev@oracle.com>
    ip6_vti: adjust vti mtu according to mtu of lower device

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/vt-d: clean up pr_irq if request_threaded_irq fails

Brian Norris <briannorris@chromium.org>
    pinctrl: rockchip: enable clock when reading pin direction register

Florian Fainelli <f.fainelli@gmail.com>
    pinctrl: Really force states during suspend/resume

Robert Walker <robert.walker@arm.com>
    coresight: Fix disabling of CoreSight TPIU

Sahara <keun-o.park@darkmatter.ae>
    pty: cancel pty slave port buf's work in tty_release

Peter Ujfalusi <peter.ujfalusi@ti.com>
    drm/omap: DMM: Check for DMM readiness after successful transaction commit

H. Nikolaus Schaller <hns@goldelico.com>
    omapdrm: panel: fix compatible vendor string for td028ttec1

Bjorn Helgaas <bhelgaas@google.com>
    vgacon: Set VGA struct resource types

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

Daniel Drake <drake@endlessm.com>
    mmc: avoid removing non-removable hosts during suspend

Logan Gunthorpe <logang@deltatee.com>
    drm/tilcdc: ensure nonatomic iowrite64 is not used

Kedareswara rao Appana <appana.durga.rao@xilinx.com>
    dmaengine: zynqmp_dma: Fix race condition in the probe

Shawn Nematbakhsh <shawnn@chromium.org>
    platform/chrome: Use proper protocol transfer function

Guenter Roeck <linux@roeck-us.net>
    watchdog: Fix potential kref imbalance when opening watchdog

Arnd Bergmann <arnd@arndb.de>
    cros_ec: fix nul-termination for firmware build info

Stefan Potyra <Stefan.Potyra@elektrobit.com>
    serial: 8250_dw: Disable clock on error

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect

Ron Economos <w6rz@comcast.net>
    media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart

Balaji Pothunoori <bpothuno@qti.qualcomm.com>
    ath10k: handling qos at STA side based on AP WMM enable/disable

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
    Bluetooth: btqcomsmd: Fix skb double free corruption

Loic Poulain <loic.poulain@linaro.org>
    Bluetooth: hci_qca: Avoid setup failure on missing rampatch

Peter Zijlstra <peterz@infradead.org>
    block/mq: Cure cpu hotplug lock inversion

Kim Phillips <kim.phillips@arm.com>
    perf tests kmod-path: Don't fail if compressed modules aren't supported

Michael Mera <dev@michaelmera.com>
    ath10k: fix out of bounds access to local buffer

Moritz Fischer <mdf@kernel.org>
    rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL

Moritz Fischer <mdf@kernel.org>
    rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt ticks

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    mm: hwpoison: call shake_page() after try_to_unmap() for mlocked page

David Rientjes <rientjes@google.com>
    mm, vmstat: suppress pcp stats for unpopulated zones in zoneinfo

Johannes Weiner <hannes@cmpxchg.org>
    mm: fix check for reclaimable pages in PF_MEMALLOC reclaim throttling

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: small underflow in cnvrtDosUnixTm()

Timmy Li <lixiaoping3@huawei.com>
    net: hns: fix ethtool_get_strings overflow in hns driver

Trond Myklebust <trond.myklebust@primarydata.com>
    pNFS: Fix a deadlock when coalescing writes and returning the layout

Alexey Khoroshilov <khoroshilov@ispras.ru>
    sm501fb: don't return zero on failure path in sm501fb_start()

Maksim Salau <maksim.salau@gmail.com>
    video: fbdev: udlfb: Fix buffer on stack

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/xen: split xen_smp_prepare_boot_cpu()

Dmitry Monakhov <dmonakhov@openvz.org>
    tcm_fileio: Prevent information leak for short reads

Sergei Trofimovich <slyfox@gentoo.org>
    ia64: fix module loading for gcc-5.4

Hans de Goede <hdegoede@redhat.com>
    ACPI / power: Delay turning off unused power resources after suspend

Shaohua Li <shli@fb.com>
    md/raid10: skip spare disk as 'first' disk

Johannes Thumshirn <jthumshirn@suse.de>
    IB/rxe: Don't clamp residual length to mtu

Sebastian Reichel <sebastian.reichel@collabora.co.uk>
    Input: twl4030-pwrbutton - use correct device for irq request

Michael Trimarchi <michael@amarulasolutions.com>
    power: supply: pda_power: move from timer to delayed_work

Pan Bian <bianpan2016@163.com>
    power: supply: isp1704: Fix unchecked return value of devm_kzalloc

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq24190_charger: Add disable-reset device-property

Scott Wood <swood@redhat.com>
    bnx2x: Align RX buffers

Dan Carpenter <dan.carpenter@oracle.com>
    qed: Unlock on error in qed_vf_pf_acquire()

Jiri Benc <jbenc@redhat.com>
    vxlan: correctly handle ipv6.disable module parameter

Dean Jenkins <Dean_Jenkins@mentor.com>
    Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()

Dean Jenkins <Dean_Jenkins@mentor.com>
    Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()

Valentin Longchamp <valentin.longchamp@keymile.com>
    soc/fsl/qe: round brg_freq to 1kHz granularity

Christophe Leroy <christophe.leroy@c-s.fr>
    net: ethernet: ucc_geth: fix MEM_PART_MURAM mode

Emil Tantilov <emil.s.tantilov@intel.com>
    ixgbevf: fix size of queue stats length

Jan Kara <jack@suse.cz>
    jbd2: Fix lockdep splat with generic/270 test

Mario Kleiner <mario.kleiner.de@gmail.com>
    drm/nouveau/kms: Increase max retries in scanout position queries.

Chunming Zhou <David1.Zhou@amd.com>
    drm/amdgpu: fix gpu reset crash

Hans de Goede <hdegoede@redhat.com>
    ACPI / PMIC: xpower: Fix power_table addresses

Robert Lippert <roblip@gmail.com>
    ipmi/watchdog: fix wdog hang on panic waiting for ipmi response

Oleksij Rempel <linux@rempel-privat.de>
    platform/x86: asus-wmi: try to set als by default

Tadeusz Struk <tadeusz.struk@intel.com>
    IB/hfi1: Fix softlockup issue

Dan Carpenter <dan.carpenter@oracle.com>
    IB/rdmavt: restore IRQs on error path in rvt_create_ah()

Kishon Vijay Abraham I <kishon@ti.com>
    ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP

Dan Carpenter <dan.carpenter@oracle.com>
    netfilter: x_tables: unlock on error in xt_find_table_lock()

yangbo lu <yangbo.lu@nxp.com>
    mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    mac80211: Fix possible sband related NULL pointer de-reference

Paolo Abeni <pabeni@redhat.com>
    ipvs: explicitly forbid ipv6 service/dest creation if ipv6 mod is disabled

Pan Bian <bianpan2016@163.com>
    staging: wilc1000: fix unchecked return value

Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>
    staging: unisys: visorhba: fix s-Par to boot with option CONFIG_VMAP_STACK set to y

Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
    gpio: gpio-wcove: fix GPIO IRQ status mask

Baoquan He <bhe@redhat.com>
    x86/KASLR: Fix kexec kernel boot crash when KASLR randomization fails

Ming Lei <ming.lei@redhat.com>
    mtip32xx: use runtime tag to initialize command header

Keerthy <j-keerthy@ti.com>
    mfd: palmas: Reset the POWERHOLD mux during power off

Rask Ingemann Lambertsen <rask@formelder.dk>
    dt-bindings: mfd: axp20x: Add "xpowers,master-mode" property for AXP806 PMICs

Colin Ian King <colin.king@canonical.com>
    iio: hid-sensor: fix return of -EINVAL on invalid values in ret or value

Lv Zheng <lv.zheng@intel.com>
    ACPICA: iasl: Fix IORT SMMU GSI disassembling

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: don't parse encrypted management frames in ieee80211_frame_acked

Martin Brandenburg <martin@omnibond.com>
    orangefs: do not wait for timeout if umounting

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix extent map leak during fallocate error path

Filipe Manana <fdmanana@suse.com>
    Btrfs: send, fix file hole not being preserved due to inline extent

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix incorrect space accounting after failure to insert inline extent

Pan Bian <bianpan2016@163.com>
    rndis_wlan: add return value validation

Pan Bian <bianpan2016@163.com>
    libertas: check return value of alloc_workqueue

Pan Bian <bianpan2016@163.com>
    mt7601u: check return value of alloc_skb

Shrirang Bagul <shrirang.bagul@canonical.com>
    iio: st_pressure: st_accel: Initialise sensor platform data properly

NeilBrown <neilb@suse.com>
    NFS: don't try to cross a mountpount when there isn't one there.

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Cancel refresh worker during buffer shutdown

Trond Myklebust <trond.myklebust@primarydata.com>
    pNFS: Fix use after free issues in pnfs_do_read()

Vlad Tsyrklevich <vlad@tsyrklevich.net>
    infiniband/uverbs: Fix integer overflows

Finn Thain <fthain@telegraphics.com.au>
    scsi: mac_esp: Replace bogus memory barrier with spinlock

Maarten Maathuis <madman2003@gmail.com>
    platform/x86: intel-vbtn: add volume up and down

Liping Zhang <zlpnobody@gmail.com>
    netfilter: nft_dynset: continue to next expr if _OP_ADD succeeded

Pan Bian <bianpan2016@163.com>
    qlcnic: fix unchecked return value

Pan Bian <bianpan2016@163.com>
    wan: pc300too: abort path on failure

Pan Bian <bianpan2016@163.com>
    tipc: check return value of nlmsg_new

Dan Carpenter <dan.carpenter@oracle.com>
    mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()

Liping Zhang <zlpnobody@gmail.com>
    netfilter: nf_ct_helper: permit cthelpers with different names via nfnetlink

Jarno Rajahalme <jarno@ovn.org>
    openvswitch: Delete conntrack entry clashing with an expectation.

Gao Feng <fgao@ikuai8.com>
    netfilter: xt_CT: fix refcnt leak on error path

Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
    gpio: gpio-wcove: fix irq pending status bit width

James Smart <jsmart2021@gmail.com>
    Fix Express lane queue creation.

James Smart <jsmart2021@gmail.com>
    Fix driver usage of 128B WQEs when WQ_CREATE is V1.

K. Y. Srinivasan <kys@microsoft.com>
    netvsc: Deal with rescinded channels correctly

Brian King <brking@linux.vnet.ibm.com>
    ibmvnic: Disable irq prior to close

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: Intel: Skylake: Uninitialized variable in probe_codec()

Moni Shoua <monis@mellanox.com>
    IB/mlx5: Set correct SL in completion for RoCE

Maor Gottlieb <maorg@mellanox.com>
    IB/mlx5: Change vma from shared to private

Maor Gottlieb <maorg@mellanox.com>
    IB/mlx5: Take write semaphore when changing the vma struct

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

Paul Burton <paul.burton@imgtec.com>
    irqchip/mips-gic: Separate IPI reservation & usage tracking

Abel Vesa <abelvesa@linux.com>
    ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA and !FRAME_POINTER

Tiantian Feng <fengtiantian@huawei.com>
    x86/reboot: Turn off KVM when halting a CPU

Brian Norris <briannorris@chromium.org>
    mwifiex: don't leak 'chan_stats' on reset

Alexey Kardashevskiy <aik@ozlabs.ru>
    KVM: PPC: Book3S PR: Exit KVM on failed mapping

David Gibson <david@gibson.dropbear.id.au>
    scsi: virtio_scsi: Always try to read VPD pages

Liad Kaufman <liad.kaufman@intel.com>
    iwlwifi: a000: fix memory offsets and lengths

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: split the handler and the wake parts of the notification infra

Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
    clk: ns2: Correct SDIO bits

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath: Fix updating radar flags for coutry code India

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Remove SAO feature from Power9 DD1

Marek Vasut <marex@denx.de>
    spi: dw: Disable clock after unregistering the host

Dan Williams <dan.j.williams@intel.com>
    tools/testing/nvdimm: fix nfit_test shutdown crash

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: Atom: update Thinkpad 10 quirk

Adam Borowski <kilobyte@angband.pl>
    btrfs: fix a bogus warning when converting only data or metadata

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

Liam Breck <kernel@networkimprov.net>
    power: supply: bq24190_charger: Limit over/under voltage fault logging

Dong Aisheng <aisheng.dong@nxp.com>
    regulator: anatop: set default voltage selector for pcie

Mahesh Bandewar <maheshb@google.com>
    bonding: handle link transition from FAIL to UP correctly

Santeri Toivonen <santeri.toivonen@vatsul.com>
    platform/x86: asus-nb-wmi: Add wapf4 quirk for the X302UA

Jacek Anaszewski <jacek.anaszewski@gmail.com>
    led: core: Clear LED_BLINK_SW flag in led_blink_set()

Jacek Anaszewski <jacek.anaszewski@gmail.com>
    Revert "led: core: Fix brightness setting when setting delay_off=0"

Yisheng Xie <xieyisheng1@huawei.com>
    staging: android: ashmem: Fix possible deadlock in ashmem_ioctl

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Enable encryption during session setup phase

Steve French <smfrench@gmail.com>
    SMB3: Validate negotiate request must always be signed

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: check src mod pointer for rsnd_mod_id()

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm: fix potential buffer overruns caused by bit glitches on the bus


-------------

Diffstat:

 .../{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} |  4 +-
 Documentation/devicetree/bindings/mfd/axp20x.txt   |  3 +
 Makefile                                           |  4 +-
 arch/alpha/kernel/console.c                        |  1 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |  2 +-
 arch/arm/kernel/ftrace.c                           | 11 +--
 arch/arm/mach-omap2/clockdomains7xx_data.c         |  2 +-
 arch/ia64/kernel/module.c                          |  4 +-
 arch/powerpc/include/asm/cputable.h                |  3 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c              |  5 +-
 arch/powerpc/kvm/book3s_pr.c                       |  6 +-
 arch/x86/boot/compressed/kaslr.c                   | 11 ++-
 arch/x86/kernel/i8259.c                            |  1 +
 arch/x86/kernel/smp.c                              |  3 +
 arch/x86/xen/smp.c                                 | 49 +++++++-----
 block/blk-mq.c                                     |  4 +-
 drivers/acpi/pmic/intel_pmic_xpower.c              | 50 ++++++------
 drivers/acpi/power.c                               | 10 +++
 drivers/acpi/processor_driver.c                    | 10 ++-
 drivers/acpi/processor_throttling.c                | 62 ++++++++-------
 drivers/acpi/sleep.c                               |  1 +
 drivers/acpi/sleep.h                               |  1 +
 drivers/block/mtip32xx/mtip32xx.c                  | 36 ++++++---
 drivers/bluetooth/btqcomsmd.c                      |  3 +-
 drivers/bluetooth/hci_ldisc.c                      | 11 ++-
 drivers/bluetooth/hci_qca.c                        |  3 +
 drivers/char/ipmi/ipmi_watchdog.c                  |  8 +-
 drivers/char/tpm/tpm-interface.c                   |  5 ++
 drivers/char/tpm/tpm2-cmd.c                        |  6 ++
 drivers/clk/bcm/clk-ns2.c                          |  2 +-
 drivers/clk/clk-axi-clkgen.c                       | 29 +++++--
 drivers/clk/clk-si5351.c                           |  2 +-
 drivers/clk/clk.c                                  | 32 +++++---
 drivers/cpufreq/sh-cpufreq.c                       | 45 ++++++-----
 drivers/dma/ti-dma-crossbar.c                      | 10 ++-
 drivers/dma/xilinx/zynqmp_dma.c                    |  3 +-
 drivers/gpio/gpio-wcove.c                          |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  7 +-
 drivers/gpu/drm/msm/msm_gem.c                      | 14 +++-
 drivers/gpu/drm/nouveau/nouveau_display.c          |  2 +-
 .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |  3 +
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |  5 ++
 drivers/gpu/drm/tilcdc/tilcdc_regs.h               |  2 +-
 drivers/hsi/clients/ssi_protocol.c                 |  5 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       | 13 +++-
 drivers/i2c/busses/i2c-scmi.c                      |  4 +
 drivers/iio/accel/st_accel_core.c                  |  7 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  4 +-
 drivers/iio/pressure/st_pressure_core.c            |  8 +-
 drivers/infiniband/core/cma.c                      |  5 +-
 drivers/infiniband/core/iwpm_util.c                |  1 +
 drivers/infiniband/core/ucma.c                     |  8 +-
 drivers/infiniband/core/umem.c                     |  2 +-
 drivers/infiniband/core/uverbs_cmd.c               | 13 +++-
 drivers/infiniband/hw/hfi1/chip.c                  | 86 ++++++++++++---------
 drivers/infiniband/hw/hfi1/hfi.h                   |  7 +-
 drivers/infiniband/hw/hfi1/init.c                  |  2 +-
 drivers/infiniband/hw/mlx4/main.c                  |  6 +-
 drivers/infiniband/hw/mlx5/cq.c                    | 19 ++++-
 drivers/infiniband/hw/mlx5/main.c                  |  5 +-
 drivers/infiniband/hw/mlx5/qp.c                    | 24 ++++--
 drivers/infiniband/hw/mlx5/srq.c                   | 15 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |  2 +-
 drivers/infiniband/sw/rdmavt/ah.c                  |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  2 -
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            | 13 ++++
 drivers/infiniband/ulp/ipoib/ipoib_main.c          | 16 ++++
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     | 11 ++-
 drivers/infiniband/ulp/isert/ib_isert.c            |  7 ++
 drivers/infiniband/ulp/isert/ib_isert.h            |  1 +
 drivers/input/misc/twl4030-pwrbutton.c             |  2 +-
 drivers/input/touchscreen/ar1021_i2c.c             |  2 +-
 drivers/iommu/intel-svm.c                          |  9 ++-
 drivers/iommu/omap-iommu.c                         | 21 ++++-
 drivers/irqchip/irq-mips-gic.c                     | 12 +--
 drivers/leds/led-core.c                            |  3 +-
 drivers/md/raid10.c                                |  6 ++
 drivers/media/dvb-core/dvb_ca_en50221.c            | 23 ++++++
 drivers/media/dvb-frontends/si2168.c               |  3 +
 drivers/media/pci/bt8xx/bt878.c                    |  3 +-
 .../media/platform/sti/c8sectpfe/c8sectpfe-core.c  |  4 +-
 drivers/mfd/palmas.c                               | 14 ++++
 drivers/mmc/core/core.c                            |  8 ++
 drivers/mmc/host/omap_hsmmc.c                      |  4 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  | 14 ++++
 drivers/net/bonding/bond_main.c                    |  3 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  1 +
 drivers/net/ethernet/freescale/ucc_geth.c          |  8 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 | 18 +++++
 drivers/net/ethernet/intel/e1000e/netdev.c         |  6 ++
 drivers/net/ethernet/intel/ixgbevf/ethtool.c       |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |  2 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |  2 +
 drivers/net/hyperv/netvsc.c                        | 16 ++++
 drivers/net/usb/qmi_wwan.c                         |  4 +-
 drivers/net/vxlan.c                                | 10 ++-
 drivers/net/wan/pc300too.c                         |  1 +
 drivers/net/wireless/ath/ath10k/debug.c            | 16 ++--
 drivers/net/wireless/ath/ath10k/mac.c              |  2 +-
 drivers/net/wireless/ath/regd.c                    | 19 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-a000.c      |  6 +-
 .../net/wireless/intel/iwlwifi/iwl-notif-wait.c    | 10 +--
 .../net/wireless/intel/iwlwifi/iwl-notif-wait.h    | 25 ++++--
 drivers/net/wireless/marvell/libertas/if_spi.c     |  5 ++
 drivers/net/wireless/marvell/mwifiex/main.c        |  4 +-
 drivers/net/wireless/mediatek/mt7601u/mcu.c        | 10 ++-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  7 ++
 drivers/net/wireless/rndis_wlan.c                  |  4 +
 drivers/pinctrl/core.c                             | 24 ++++--
 drivers/pinctrl/pinctrl-rockchip.c                 |  8 ++
 drivers/platform/chrome/cros_ec_proto.c            |  8 +-
 drivers/platform/chrome/cros_ec_sysfs.c            |  2 +-
 drivers/platform/x86/asus-nb-wmi.c                 | 22 ++++++
 drivers/platform/x86/asus-wmi.c                    | 12 +++
 drivers/platform/x86/asus-wmi.h                    |  1 +
 drivers/platform/x86/intel-vbtn.c                  |  4 +
 drivers/power/supply/bq24190_charger.c             | 10 ++-
 drivers/power/supply/isp1704_charger.c             |  4 +
 drivers/power/supply/pda_power.c                   | 49 ++++++------
 drivers/ptp/ptp_clock.c                            | 18 ++---
 drivers/regulator/anatop-regulator.c               |  5 ++
 drivers/rtc/rtc-ac100.c                            | 19 +++--
 drivers/rtc/rtc-cmos.c                             | 17 ++++-
 drivers/rtc/rtc-ds1374.c                           | 10 ++-
 drivers/scsi/lpfc/lpfc_init.c                      |  6 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |  3 +
 drivers/scsi/mac_esp.c                             | 33 +++++---
 drivers/scsi/virtio_scsi.c                         | 24 ++++++
 drivers/soc/fsl/qe/qe.c                            | 13 ++++
 drivers/spi/spi-dw-mmio.c                          |  2 +-
 drivers/staging/android/ashmem.c                   |  8 +-
 drivers/staging/unisys/visorhba/visorhba_main.c    |  8 +-
 drivers/staging/wilc1000/linux_mon.c               |  2 +
 drivers/target/target_core_file.c                  | 23 ++++--
 drivers/tty/serial/8250/8250_dw.c                  |  3 +-
 drivers/tty/tty_io.c                               |  2 +
 drivers/usb/gadget/function/f_hid.c                | 89 ++++++++++++++++------
 drivers/video/console/vgacon.c                     | 34 +++++++--
 .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |  3 +
 drivers/video/fbdev/sm501fb.c                      |  1 +
 drivers/video/fbdev/udlfb.c                        | 14 +++-
 drivers/watchdog/watchdog_dev.c                    |  6 +-
 fs/btrfs/file.c                                    |  4 +-
 fs/btrfs/inode.c                                   |  6 +-
 fs/btrfs/send.c                                    | 23 +++++-
 fs/btrfs/volumes.c                                 | 12 ++-
 fs/cifs/netmisc.c                                  |  6 +-
 fs/cifs/sess.c                                     | 22 +++---
 fs/cifs/smb2pdu.c                                  | 15 ++--
 fs/jbd2/journal.c                                  | 15 +++-
 fs/nfs/pagelist.c                                  |  6 +-
 fs/nfs/pnfs.c                                      | 18 +++--
 fs/nfsd/nfs4proc.c                                 |  6 +-
 fs/nfsd/vfs.c                                      | 24 +++++-
 fs/orangefs/waitqueue.c                            |  9 ++-
 include/acpi/actbl2.h                              |  9 +++
 include/linux/mlx5/driver.h                        |  4 +-
 include/linux/posix-clock.h                        | 10 +--
 include/soc/fsl/qe/qe.h                            |  1 +
 kernel/irq/manage.c                                |  4 +-
 kernel/time/posix-clock.c                          | 34 ++++++---
 mm/memory-failure.c                                |  8 ++
 mm/vmscan.c                                        |  6 +-
 mm/vmstat.c                                        | 20 +++--
 net/ipv4/tcp_input.c                               | 16 ++--
 net/ipv6/ip6_vti.c                                 | 20 +++++
 net/ipv6/ndisc.c                                   |  2 +
 net/mac80211/cfg.c                                 | 30 ++++----
 net/mac80211/ibss.c                                |  6 +-
 net/mac80211/ieee80211_i.h                         | 36 +++++----
 net/mac80211/mesh.c                                | 29 ++++---
 net/mac80211/mesh_plink.c                          | 37 ++++++---
 net/mac80211/mlme.c                                | 14 +++-
 net/mac80211/rate.c                                |  4 +-
 net/mac80211/sta_info.c                            | 13 +++-
 net/mac80211/status.c                              |  1 +
 net/mac80211/tdls.c                                | 29 ++++---
 net/mac80211/tx.c                                  |  5 +-
 net/mac80211/util.c                                |  6 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     | 22 ++++--
 net/netfilter/nf_conntrack_helper.c                | 26 +++++--
 net/netfilter/nft_dynset.c                         |  5 +-
 net/netfilter/x_tables.c                           |  4 +-
 net/netfilter/xt_CT.c                              | 11 ++-
 net/openvswitch/conntrack.c                        | 30 +++++++-
 net/sunrpc/xprtrdma/verbs.c                        |  1 +
 net/tipc/node.c                                    |  2 +
 sound/pci/hda/patch_realtek.c                      | 12 ++-
 sound/soc/intel/atom/sst/sst_acpi.c                | 16 +++-
 sound/soc/intel/skylake/skl.c                      |  2 +-
 sound/soc/sh/rcar/cmd.c                            |  3 +
 tools/perf/tests/kmod-path.c                       |  2 +
 tools/testing/nvdimm/test/nfit.c                   | 10 ++-
 197 files changed, 1624 insertions(+), 607 deletions(-)
