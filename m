Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtLsdGaVSKvRIBwLnH7VqBITe3hkrNLwx4msZNIUiD2rq9OHlZb8A2Mn8GHlnSDLOca2sno
ARC-Seal: i=1; a=rsa-sha256; t=1519980992; cv=none;
        d=google.com; s=arc-20160816;
        b=j90jGCV64+v9zZFIqdOgcQIJCAUutFtbN7DVD5q/08Bqbp83a427i2dyLvCG3QbdnB
         A+uKBQLZ6dJrhXbaZukVgoRST3ckXCjEdtVu2W0pXtmi5oYlpCgMrusNAfCKs/VaMmPt
         ELxvdYzgdmK7VMKGZ5fDl1/DOP7lAbl7whT6cdRQpcgXt5k7nyrNXSn5HcPhcWmdBJIT
         S01Qv36rgMXv18n/XH2zWpW3pZnp1m6MLfXhKi6LVN7HyhZssEmjMkeSG0rDDZziyX+Z
         DaYFWA06zb1MRLAc4YAizBPTA7AYOx7ELH8d3Jqbrl8xjgRWCuezDo1oMccHeaR5qN7U
         rt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NoTvgXn1KJZFsttDf623CPMh4G/XV55uXGEKh/Jh2dw=;
        b=MrWen2zw+HSr24/J+42dnMVyroRuW/su/g6EMj+mc7iWRBjGoOr4XUhIHpyzfGfEJr
         LeyOadjHYeVFaJSWFzYbucvFy6R2kPr4+GUqByfRZ45ejyREe7tNBfLn3U2Kh7Ey4wBl
         yb9hmPkpIKyq9Ri6PYB9xBeto3kxXmOzk19bCA0FcWi9Kdn1NU9j2M5AMD24WmNkxMAS
         5PtesK+IS/hGBPhfO9OwVA7odsvMZW9a6XijA/n5Rfvhn1Wk8ON/C/6TJuSL58YqlIT7
         yH6mXmT8dqoKloU3bpsq5g6FPi6TDFq4yfGVu5JM5BYCRS/d74wPCuKWZsGsCcWNIMea
         xlcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.9 00/56] 4.9.86-stable review
Date: Fri,  2 Mar 2018 09:50:46 +0100
Message-Id: <20180302084449.568562222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.86-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.86-rc1
X-KernelTest-Deadline: 2018-03-04T08:44+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815589612434030?=
X-GMAIL-MSGID: =?utf-8?q?1593815589612434030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.86 release.
There are 56 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar  4 08:44:26 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.86-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.86-rc1

James Hogan <jhogan@kernel.org>
    MIPS: Implement __multi3 for GCC7 MIPS64r6 builds

Punit Agrawal <punit.agrawal@arm.com>
    KVM: arm/arm64: Fix check for hugepage size when allocating at Stage 2

Yangbo Lu <yangbo.lu@nxp.com>
    net: gianfar_ptp: move set_fipers() to spinlock protecting area

Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
    sctp: make use of pre-calculated len

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/gntdev: Fix partial gntdev_mmap() cleanup

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/gntdev: Fix off-by-one error when unmapping with holes

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    SolutionEngine771x: fix Ether platform data

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mdio-sun4i: Fix a memory leak

Eduardo Otubo <otubo@redhat.com>
    xen-netfront: enable device after manual module load

Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
    bnxt_en: Fix the 'Invalid VF' id check in bnxt_vf_ndo_prep routine.

Luu An Phu <phu.luuan@nxp.com>
    can: flex_can: Correct the checking for frame length in flexcan_start_xmit()

Johannes Berg <johannes.berg@intel.com>
    mac80211: mesh: drop frames appearing to be from us

Hao Chen <flank3rsky@gmail.com>
    nl80211: Check for the required netlink attribute presence

Alexander Duyck <alexander.h.duyck@intel.com>
    i40e/i40evf: Account for frags split over multiple descriptors in check linearize

Felix Janda <felix.janda@posteo.de>
    uapi libc compat: add fallback for unsupported libcs

Xiongwei Song <sxwjean@gmail.com>
    drm/ttm: check the return value of kzalloc

SZ Lin (林上智) <sz.lin@moxa.com>
    NET: usb: qmi_wwan: add support for YUGA CLM920-NC5 PID 0x9625

Tushar Dave <tushar.n.dave@oracle.com>
    e1000: fix disabling already-disabled warning

Gao Feng <gfree.wind@vip.163.com>
    macvlan: Fix one possible double free

Aliaksei Karaliou <akaraliou.dev@gmail.com>
    xfs: quota: check result of register_shrinker()

Aliaksei Karaliou <akaraliou.dev@gmail.com>
    xfs: quota: fix missed destroy of qi_tree_lock

Erez Shitrit <erezsh@mellanox.com>
    IB/ipoib: Fix race condition in neigh creation

Leon Romanovsky <leonro@mellanox.com>
    IB/mlx4: Fix mlx4_ib_alloc_mr error flow

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: fix wrongly assigned configuration data

Guenter Roeck <linux@roeck-us.net>
    genirq: Guard handle_bad_irq log messages

Nitzan Carmi <nitzanc@mellanox.com>
    IB/mlx5: Fix mlx5_ib_alloc_mr error flow

Matthieu CASTET <matthieu.castet@parrot.com>
    led: core: Fix brightness setting when setting delay_off=0

Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
    bnx2x: Improve reliability in case of nested PCI errors

Siva Reddy Kallam <siva.kallam@broadcom.com>
    tg3: Enable PHY reset in MTU change path for 5720

Siva Reddy Kallam <siva.kallam@broadcom.com>
    tg3: Add workaround to restrict 5762 MRRS to 2048

Tommi Rantala <tommi.t.rantala@nokia.com>
    tipc: fix tipc_mon_delete() oops in tipc_enable_bearer() error path

Tommi Rantala <tommi.t.rantala@nokia.com>
    tipc: error path leak fixes in tipc_enable_bearer()

James Hogan <jhogan@kernel.org>
    lib/mpi: Fix umul_ppmm() for MIPS64r6

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: ls1021a: fix incorrect clock references

Cathy Avery <cavery@redhat.com>
    scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error

Fredrik Hallenberg <megahallon@gmail.com>
    net: stmmac: Fix TX timestamp calculation

Xin Long <lucien.xin@gmail.com>
    ip6_tunnel: get the min mtu properly in ip6_tnl_xmit

Alexander Kochetkov <al.kochet@gmail.com>
    net: arc_emac: fix arc_emac_rx() error paths

Sean Wang <sean.wang@mediatek.com>
    net: mediatek: setup proper state for disabled GMAC on the default

Abhijeet Kumar <abhijeet.kumar@intel.com>
    ASoC: nau8825: fix issue that pop noise when start capture

Radu Pirea <radu.pirea@microchip.com>
    spi: atmel: fixed spin_lock usage inside atmel_spi_remove

Jia-Ju Bai <baijiaju1990@163.com>
    mac80211_hwsim: Fix a possible sleep-in-atomic bug in hwsim_get_radio_nl

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/pci: do a msi rearm on init

Alexey Khoroshilov <khoroshilov@ispras.ru>
    net: phy: xgene: disable clk on error paths

Al Viro <viro@zeniv.linux.org.uk>
    sget(): handle failures of register_shrinker()

Arnaldo Carvalho de Melo <acme@redhat.com>
    x86/asm: Allow again using asm.h when building for the 'bpf' clang target

Chunyan Zhang <zhang.lyra@gmail.com>
    ARM: 8731/1: Fix csum_partial_copy_from_user() stack mismatch

Brendan McGrath <redmcg@redmandi.dyndns.org>
    ipv6: icmp6: Allow icmp messages to be looped back

Albert Hsieh <wen.hsieh@broadcom.com>
    mtd: nand: brcmnand: Zero bitflip is not an error

Sascha Hauer <s.hauer@pengutronix.de>
    mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM

Daniele Palmas <dnlplm@gmail.com>
    net: usb: qmi_wwan: add Telit ME910 PID 0x1101 support

Keith Busch <keith.busch@intel.com>
    nvme: check hw sectors before setting chunk sectors

Andreas Platschek <andreas.platschek@opentech.at>
    dmaengine: fsl-edma: disable clks on all error paths

Yunlei He <heyunlei@huawei.com>
    f2fs: fix a bug caused by NULL extent tree

Ben Gardner <gardner.ben@gmail.com>
    i2c: designware: must wait for enable

Anna-Maria Gleixner <anna-maria@linutronix.de>
    hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/ls1021a-qds.dts                  |  2 +-
 arch/arm/boot/dts/ls1021a-twr.dts                  |  2 +-
 arch/arm/kvm/mmu.c                                 |  2 +-
 arch/arm/lib/csumpartialcopyuser.S                 |  4 ++
 arch/mips/lib/Makefile                             |  3 +-
 arch/mips/lib/libgcc.h                             | 17 +++++++
 arch/mips/lib/multi3.c                             | 54 +++++++++++++++++++++
 arch/sh/boards/mach-se/770x/setup.c                | 10 +++-
 arch/x86/include/asm/asm.h                         |  2 +
 drivers/dma/fsl-edma.c                             | 28 +++++------
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c     |  7 +++
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |  2 +
 drivers/i2c/busses/i2c-designware-core.c           |  2 +-
 drivers/infiniband/hw/mlx4/mr.c                    |  2 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  1 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c          | 25 +++++++---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |  5 +-
 drivers/leds/led-core.c                            |  2 +-
 drivers/mtd/nand/brcmnand/brcmnand.c               |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |  6 +--
 drivers/net/can/flexcan.c                          |  2 +-
 drivers/net/ethernet/arc/emac_main.c               | 53 ++++++++++++---------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 14 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |  2 +-
 drivers/net/ethernet/broadcom/tg3.c                | 13 ++++-
 drivers/net/ethernet/broadcom/tg3.h                |  4 ++
 drivers/net/ethernet/freescale/gianfar_ptp.c       |  3 +-
 drivers/net/ethernet/intel/e1000/e1000.h           |  3 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      | 27 +++++++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 26 ++++++++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 26 ++++++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 11 +++--
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  6 ++-
 drivers/net/macvlan.c                              |  7 ++-
 drivers/net/phy/mdio-sun4i.c                       |  6 ++-
 drivers/net/phy/mdio-xgene.c                       | 21 ++++++---
 drivers/net/usb/qmi_wwan.c                         |  2 +
 drivers/net/wireless/mac80211_hwsim.c              |  2 +-
 drivers/net/xen-netfront.c                         |  1 +
 drivers/nvme/host/core.c                           |  3 +-
 drivers/s390/block/dasd_3990_erp.c                 | 10 ++++
 drivers/scsi/storvsc_drv.c                         |  3 +-
 drivers/spi/spi-atmel.c                            |  2 +-
 drivers/xen/gntdev.c                               |  8 ++--
 fs/f2fs/extent_cache.c                             | 12 ++++-
 fs/super.c                                         |  6 ++-
 fs/xfs/xfs_qm.c                                    | 46 +++++++++++-------
 include/uapi/linux/libc-compat.h                   | 55 +++++++++++++++++++++-
 kernel/irq/debug.h                                 |  5 ++
 kernel/time/hrtimer.c                              |  7 ++-
 lib/mpi/longlong.h                                 | 18 ++++++-
 net/ipv6/ip6_tunnel.c                              |  9 +++-
 net/ipv6/route.c                                   |  1 +
 net/mac80211/rx.c                                  |  2 +
 net/sctp/socket.c                                  | 16 ++++---
 net/tipc/bearer.c                                  |  5 +-
 net/tipc/monitor.c                                 |  6 ++-
 net/wireless/nl80211.c                             |  3 +-
 sound/soc/codecs/nau8825.c                         |  1 +
 61 files changed, 498 insertions(+), 135 deletions(-)
