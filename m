Date: Mon, 5 Mar 2018 13:50:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.86
Message-ID: <20180305125005.GA17165@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.86 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                              |    2=20
 arch/arm/boot/dts/ls1021a-qds.dts                     |    2=20
 arch/arm/boot/dts/ls1021a-twr.dts                     |    2=20
 arch/arm/kvm/mmu.c                                    |    2=20
 arch/arm/lib/csumpartialcopyuser.S                    |    4 +
 arch/mips/lib/Makefile                                |    3=20
 arch/mips/lib/libgcc.h                                |   17 +++++
 arch/mips/lib/multi3.c                                |   54 +++++++++++++=
++++
 arch/sh/boards/mach-se/770x/setup.c                   |   10 ++-
 arch/x86/include/asm/asm.h                            |    2=20
 drivers/dma/fsl-edma.c                                |   28 ++++-----
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c        |    7 ++
 drivers/gpu/drm/ttm/ttm_page_alloc.c                  |    2=20
 drivers/i2c/busses/i2c-designware-core.c              |    2=20
 drivers/infiniband/hw/mlx4/mr.c                       |    2=20
 drivers/infiniband/hw/mlx5/mr.c                       |    1=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c             |   25 +++++---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c        |    5 +
 drivers/leds/led-core.c                               |    2=20
 drivers/mtd/nand/brcmnand/brcmnand.c                  |    2=20
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c                |    6 -
 drivers/net/can/flexcan.c                             |    2=20
 drivers/net/ethernet/arc/emac_main.c                  |   53 ++++++++++---=
----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c       |    4 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c      |   14 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c       |    2=20
 drivers/net/ethernet/broadcom/tg3.c                   |   13 +++-
 drivers/net/ethernet/broadcom/tg3.h                   |    4 +
 drivers/net/ethernet/freescale/gianfar_ptp.c          |    3=20
 drivers/net/ethernet/intel/e1000/e1000.h              |    3=20
 drivers/net/ethernet/intel/e1000/e1000_main.c         |   27 +++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c           |   26 +++++++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c         |   26 +++++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c           |   11 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |    6 +
 drivers/net/macvlan.c                                 |    7 +-
 drivers/net/phy/mdio-sun4i.c                          |    6 +
 drivers/net/phy/mdio-xgene.c                          |   21 ++++--
 drivers/net/usb/qmi_wwan.c                            |    2=20
 drivers/net/wireless/mac80211_hwsim.c                 |    2=20
 drivers/net/xen-netfront.c                            |    1=20
 drivers/nvme/host/core.c                              |    3=20
 drivers/s390/block/dasd_3990_erp.c                    |   10 +++
 drivers/scsi/storvsc_drv.c                            |    3=20
 drivers/spi/spi-atmel.c                               |    2=20
 drivers/xen/gntdev.c                                  |    8 +-
 fs/f2fs/extent_cache.c                                |   12 +++
 fs/super.c                                            |    6 +
 fs/xfs/xfs_qm.c                                       |   46 +++++++++----=
--
 include/uapi/linux/libc-compat.h                      |   55 +++++++++++++=
++++-
 kernel/irq/debug.h                                    |    5 +
 kernel/time/hrtimer.c                                 |    7 +-
 lib/mpi/longlong.h                                    |   18 +++++
 net/ipv6/ip6_tunnel.c                                 |    9 ++
 net/ipv6/route.c                                      |    1=20
 net/mac80211/rx.c                                     |    2=20
 net/sctp/socket.c                                     |   16 +++--
 net/tipc/bearer.c                                     |    5 +
 net/tipc/monitor.c                                    |    6 +
 net/wireless/nl80211.c                                |    3=20
 sound/soc/codecs/nau8825.c                            |    1=20
 61 files changed, 497 insertions(+), 134 deletions(-)

Abhijeet Kumar (1):
      ASoC: nau8825: fix issue that pop noise when start capture

Al Viro (1):
      sget(): handle failures of register_shrinker()

Albert Hsieh (1):
      mtd: nand: brcmnand: Zero bitflip is not an error

Alexander Duyck (1):
      i40e/i40evf: Account for frags split over multiple descriptors in che=
ck linearize

Alexander Kochetkov (1):
      net: arc_emac: fix arc_emac_rx() error paths

Alexey Khoroshilov (1):
      net: phy: xgene: disable clk on error paths

Aliaksei Karaliou (2):
      xfs: quota: fix missed destroy of qi_tree_lock
      xfs: quota: check result of register_shrinker()

Andreas Platschek (1):
      dmaengine: fsl-edma: disable clks on all error paths

Anna-Maria Gleixner (1):
      hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)

Arnaldo Carvalho de Melo (1):
      x86/asm: Allow again using asm.h when building for the 'bpf' clang ta=
rget

Arnd Bergmann (1):
      ARM: dts: ls1021a: fix incorrect clock references

Ben Gardner (1):
      i2c: designware: must wait for enable

Brendan McGrath (1):
      ipv6: icmp6: Allow icmp messages to be looped back

Cathy Avery (1):
      scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error

Christophe JAILLET (1):
      mdio-sun4i: Fix a memory leak

Chunyan Zhang (1):
      ARM: 8731/1: Fix csum_partial_copy_from_user() stack mismatch

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit ME910 PID 0x1101 support

Eduardo Otubo (1):
      xen-netfront: enable device after manual module load

Erez Shitrit (1):
      IB/ipoib: Fix race condition in neigh creation

Felix Janda (1):
      uapi libc compat: add fallback for unsupported libcs

Fredrik Hallenberg (1):
      net: stmmac: Fix TX timestamp calculation

Gao Feng (1):
      macvlan: Fix one possible double free

Greg Kroah-Hartman (1):
      Linux 4.9.86

Guenter Roeck (1):
      genirq: Guard handle_bad_irq log messages

Guilherme G. Piccoli (1):
      bnx2x: Improve reliability in case of nested PCI errors

Hao Chen (1):
      nl80211: Check for the required netlink attribute presence

James Hogan (2):
      lib/mpi: Fix umul_ppmm() for MIPS64r6
      MIPS: Implement __multi3 for GCC7 MIPS64r6 builds

Jia-Ju Bai (1):
      mac80211_hwsim: Fix a possible sleep-in-atomic bug in hwsim_get_radio=
_nl

Johannes Berg (1):
      mac80211: mesh: drop frames appearing to be from us

Karol Herbst (1):
      drm/nouveau/pci: do a msi rearm on init

Keith Busch (1):
      nvme: check hw sectors before setting chunk sectors

Leon Romanovsky (1):
      IB/mlx4: Fix mlx4_ib_alloc_mr error flow

Luu An Phu (1):
      can: flex_can: Correct the checking for frame length in flexcan_start=
_xmit()

Marcelo Ricardo Leitner (1):
      sctp: make use of pre-calculated len

Matthieu CASTET (1):
      led: core: Fix brightness setting when setting delay_off=3D0

Nitzan Carmi (1):
      IB/mlx5: Fix mlx5_ib_alloc_mr error flow

Punit Agrawal (1):
      KVM: arm/arm64: Fix check for hugepage size when allocating at Stage 2

Radu Pirea (1):
      spi: atmel: fixed spin_lock usage inside atmel_spi_remove

Ross Lagerwall (2):
      xen/gntdev: Fix off-by-one error when unmapping with holes
      xen/gntdev: Fix partial gntdev_mmap() cleanup

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      NET: usb: qmi_wwan: add support for YUGA CLM920-NC5 PID 0x9625

Sascha Hauer (1):
      mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM

Sean Wang (1):
      net: mediatek: setup proper state for disabled GMAC on the default

Sergei Shtylyov (1):
      SolutionEngine771x: fix Ether platform data

Siva Reddy Kallam (2):
      tg3: Add workaround to restrict 5762 MRRS to 2048
      tg3: Enable PHY reset in MTU change path for 5720

Stefan Haberland (1):
      s390/dasd: fix wrongly assigned configuration data

Tommi Rantala (2):
      tipc: error path leak fixes in tipc_enable_bearer()
      tipc: fix tipc_mon_delete() oops in tipc_enable_bearer() error path

Tushar Dave (1):
      e1000: fix disabling already-disabled warning

Venkat Duvvuru (1):
      bnxt_en: Fix the 'Invalid VF' id check in bnxt_vf_ndo_prep routine.

Xin Long (1):
      ip6_tunnel: get the min mtu properly in ip6_tnl_xmit

Xiongwei Song (1):
      drm/ttm: check the return value of kzalloc

Yangbo Lu (1):
      net: gianfar_ptp: move set_fipers() to spinlock protecting area

Yunlei He (1):
      f2fs: fix a bug caused by NULL extent tree


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqdPPwACgkQONu9yGCS
aT6nxg/9FBRiuLw1RBUshTBbera/t1wj6DLvF3upeZbVuF5w25yNeQ/gh1sDN0gh
A7Al/1miqygrsT8/GKW+cN9KRFuOMoldn2R52uw9Cr6oM/hv97egXKjVi4SSjQNo
9lTdDQQrf72ZGwPRqAP0mQchsHlYNqrUUYrCYBwIHiMepJagetPOEUij2TZWur1H
kEVi3gXQVSPSDIFyTvox3shiF5k4ClFbcJulYsr8xbXVr7yRkR6jN55QL7imApLe
e5RuoHQ3aWtuG0Z8lANaR2bKDveyMTx7gVR11lbeEgUNN/hR+ArWjH9AReN58eoe
/ECblOLzZnKz7rn9skQ6itipIh+6p0/KCTBVEOMkyJ8rF3V26+kRtVqkDmjLjUbe
W7U5xzq2g+LT/m/la5G6MhL+UonVOyvVY5oTD7/ow0XgiZjloCkbMvDB8iwQJLFr
0LobDDKMvgbNm4UKH9pSn6d3IG3DPFPY9UFqUAf/VMbRKQ8+h8Zb4N5jfQICaViT
5Zld0yqIaCqUucpox0jkuYNnKdxDDKolhGRhK4dpkvhvPCwY8iXYOUJGjXJ/IX9G
fMOSE+gf536pTKqgA1vj2tc7WH5YCpENzNR2OriEZZcreYJxeWdq6blIyVXzYwjN
saf50IUaBl5nSZq7WToD7gN1yxG7gMFheSwao+Rb6poLuQ+uTic=
=rFpi
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
