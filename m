Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeELEf3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 00:35:29 -0400
Received: from ozlabs.org ([203.11.71.1]:50431 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeELEf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 00:35:27 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 12 May 2018 14:35:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        0-Day Mailing List <lkp@lists.01.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Linus <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: linux-next: a new pending-fixes branch
Message-ID: <20180512143523.250ab803@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ro8BT7A4pCVS5HwS8XpjFbT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ro8BT7A4pCVS5HwS8XpjFbT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As an outcome of some discussion, I have added a pending-fixes branch
to linux-next.  This branch contains Linus' tree merged with branches
containing only fixes pending for the current release.  The branch is a
strict subset of linux-next each day (as so rebases like linux-next
does).

It would be good if this branch could be tested by the 0-Day service
and any other testing that people do - in the hope of sending fewer
"fixes causing bugs" patches to Linus.

There is not intention that bug fixes for Linus' tree should
necessarily be tested in linux-next before being forwarded, but
(especially for slightly less urgent bugs, at least) it seems like a
good idea.

I currently have 55 branches of bug fixes included.  As of yesterday
the branch contains 165 commits and looks like this:


 .mailmap                                           |   3 +
 .../devicetree/bindings/net/can/rcar_canfd.txt     |   4 +-
 MAINTAINERS                                        |   8 +-
 arch/arm/boot/compressed/Makefile                  |   8 +-
 arch/arm/boot/compressed/head.S                    |  20 +-
 arch/arm/boot/dts/dm8148-evm.dts                   |   2 +-
 arch/arm/boot/dts/dm8148-t410.dts                  |   2 +-
 arch/arm/boot/dts/dm8168-evm.dts                   |   2 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |   2 +-
 arch/arm/boot/dts/imx35.dtsi                       |   4 +-
 arch/arm/boot/dts/imx53.dtsi                       |   4 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  11 +-
 arch/arm/kernel/machine_kexec.c                    |  36 ++--
 arch/arm/mach-omap1/ams-delta-fiq.c                |  28 +--
 arch/arm/mach-omap2/powerdomain.c                  |   4 +-
 arch/powerpc/include/asm/ftrace.h                  |  29 ++-
 arch/powerpc/include/asm/paca.h                    |   1 -
 arch/powerpc/include/asm/topology.h                |  13 +-
 drivers/atm/firestream.c                           |   2 +-
 drivers/atm/zatm.c                                 |   3 +
 drivers/bluetooth/btusb.c                          |  19 +-
 drivers/dma/pl330.c                                |  28 ---
 drivers/gpu/drm/bridge/Kconfig                     |   1 +
 drivers/gpu/drm/drm_atomic.c                       |   8 +
 drivers/gpu/drm/i915/intel_cdclk.c                 |  41 ++++-
 drivers/gpu/drm/i915/intel_display.c               |   2 +
 drivers/gpu/drm/i915/intel_dp.c                    |  20 --
 drivers/gpu/drm/i915/intel_lvds.c                  |   3 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |  20 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c           |   7 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   2 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |  10 +
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |   6 +-
 drivers/gpu/drm/omapdrm/tcm-sita.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |  25 ++-
 drivers/gpu/drm/vc4/vc4_plane.c                    |   2 +-
 drivers/hwmon/k10temp.c                            |  40 +++-
 drivers/iio/adc/Kconfig                            |   1 +
 drivers/iio/adc/ad7793.c                           |  75 +++-----
 drivers/iio/adc/at91-sama5d2_adc.c                 |  41 ++++-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  17 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |   2 +-
 drivers/iio/buffer/kfifo_buf.c                     |  11 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   8 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |  17 +-
 drivers/mtd/nand/onenand/omap2.c                   | 105 ++++-------
 drivers/mtd/nand/raw/marvell_nand.c                |  12 +-
 drivers/mtd/nand/raw/nand_base.c                   |   5 +
 drivers/net/can/dev.c                              |   2 +-
 drivers/net/can/flexcan.c                          |  26 +--
 drivers/net/can/spi/hi311x.c                       |  11 +-
 drivers/net/can/usb/kvaser_usb.c                   |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  26 +++
 drivers/net/dsa/mv88e6xxx/chip.h                   |   1 +
 drivers/net/dsa/mv88e6xxx/global2.c                |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   3 +
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h    |   1 +
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |  20 +-
 drivers/net/ethernet/broadcom/tg3.c                |   9 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  16 ++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |   7 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c      |   2 +-
 drivers/net/ethernet/netronome/nfp/flower/main.c   |  19 --
 drivers/net/ethernet/ni/nixge.c                    |  10 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |   6 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_rdma.c       |   2 +-
 drivers/net/ethernet/realtek/r8169.c               |   3 +
 drivers/net/ethernet/sun/niu.c                     |   5 +-
 drivers/net/hyperv/netvsc_drv.c                    |   3 +-
 drivers/net/hyperv/rndis_filter.c                  |   2 +-
 drivers/net/ieee802154/atusb.c                     |   2 +-
 drivers/net/ieee802154/mcr20a.c                    |  15 +-
 drivers/net/phy/broadcom.c                         |  10 +
 drivers/net/phy/sfp-bus.c                          |   2 +-
 drivers/net/wireless/mac80211_hwsim.c              |   1 +
 drivers/reset/reset-uniphier.c                     |   6 +-
 drivers/spi/spi-bcm-qspi.c                         |  28 ++-
 drivers/spi/spi-bcm2835aux.c                       |   5 +
 drivers/spi/spi-cadence.c                          |   8 +
 drivers/spi/spi-imx.c                              |   2 +-
 drivers/spi/spi-pxa2xx.h                           |   2 +-
 drivers/spi/spi-sh-msiof.c                         |   1 +
 drivers/video/backlight/as3711_bl.c                |  45 +++--
 drivers/video/backlight/max8925_bl.c               |   4 +-
 drivers/video/backlight/tps65217_bl.c              |   4 +-
 include/linux/brcmphy.h                            |   1 +
 include/linux/iio/buffer_impl.h                    |   6 +-
 include/linux/mfd/as3711.h                         |   4 +-
 include/net/flow_dissector.h                       |   2 +-
 include/net/mac80211.h                             |   2 +-
 include/net/netfilter/nf_tables.h                  |   5 +
 include/net/xfrm.h                                 |   1 +
 include/sound/soc-dai.h                            |   4 +-
 include/uapi/linux/netfilter/nf_conntrack_tcp.h    |   3 +
 include/uapi/linux/nl80211.h                       |   2 +
 kernel/bpf/syscall.c                               |  19 +-
 lib/radix-tree.c                                   |   6 +-
 net/9p/trans_common.c                              |   2 +-
 net/9p/trans_fd.c                                  |   4 +-
 net/9p/trans_rdma.c                                |   4 +-
 net/9p/trans_virtio.c                              |   5 +-
 net/9p/trans_xen.c                                 |   2 +-
 net/atm/lec.c                                      |   9 +-
 net/bridge/netfilter/ebt_stp.c                     |   4 +-
 net/ieee802154/6lowpan/6lowpan_i.h                 |   4 +-
 net/ieee802154/6lowpan/reassembly.c                |  14 +-
 net/ipv4/netfilter/ip_tables.c                     |   1 +
 net/ipv4/route.c                                   |   1 +
 net/ipv4/udp.c                                     |   4 +-
 net/ipv6/Kconfig                                   |   9 +-
 net/ipv6/ip6_vti.c                                 |   4 +-
 net/ipv6/netfilter/ip6_tables.c                    |   1 +
 net/ipv6/udp.c                                     |   4 +-
 net/ipv6/xfrm6_tunnel.c                            |   3 +
 net/key/af_key.c                                   |  45 ++++-
 net/llc/af_llc.c                                   |   3 +
 net/mac80211/agg-tx.c                              |   4 +
 net/mac80211/mlme.c                                |  27 ++-
 net/mac80211/tx.c                                  |   3 +-
 net/netfilter/core.c                               |   3 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |  17 +-
 net/netfilter/ipvs/ip_vs_core.c                    |  12 ++
 net/netfilter/nf_conntrack_proto_tcp.c             |  11 ++
 net/netfilter/nf_tables_api.c                      |  71 ++++++--
 net/netfilter/nf_tables_core.c                     |  21 ++-
 net/netfilter/nfnetlink_acct.c                     |   2 +-
 net/netfilter/nfnetlink_cthelper.c                 |   7 +-
 net/netfilter/nft_compat.c                         | 201 ++++++++++++++++-=
----
 net/netfilter/nft_immediate.c                      |  15 +-
 net/netfilter/x_tables.c                           |   6 +
 net/netlink/af_netlink.c                           |   6 +-
 net/nsh/nsh.c                                      |   4 +
 net/openvswitch/flow_netlink.c                     |   9 +-
 net/rfkill/rfkill-gpio.c                           |   7 +-
 net/sctp/associola.c                               |  30 ++-
 net/sctp/sm_make_chunk.c                           |   2 +-
 net/sctp/sm_statefuns.c                            |  86 +++++----
 net/sctp/ulpevent.c                                |   1 -
 net/tipc/node.c                                    |  15 +-
 net/tipc/socket.c                                  |   3 +-
 net/tls/tls_main.c                                 |  12 +-
 net/wireless/core.c                                |   3 +
 net/wireless/nl80211.c                             |   1 +
 net/wireless/reg.c                                 |   1 +
 net/xfrm/xfrm_state.c                              |   6 +
 sound/soc/cirrus/edb93xx.c                         |   2 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |  26 +--
 sound/soc/cirrus/snappercl15.c                     |   2 +-
 sound/soc/codecs/cs35l35.c                         |   1 +
 sound/soc/intel/boards/bytcr_rt5651.c              |   5 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |   4 +-
 sound/soc/omap/n810.c                              |  10 +-
 sound/soc/soc-compress.c                           |  52 +++---
 tools/include/linux/spinlock.h                     |   3 +-
 tools/testing/radix-tree/Makefile                  |   6 +-
 tools/testing/radix-tree/multiorder.c              |  63 +++++++
 tools/testing/radix-tree/test.c                    |  19 ++
 tools/testing/radix-tree/test.h                    |   3 +
 tools/testing/selftests/intel_pstate/run.sh        |  24 +--
 tools/testing/selftests/net/Makefile               |   2 +-
 .../selftests/tc-testing/tc-tests/actions/bpf.json |  11 +-
 tools/testing/selftests/x86/protection_keys.c      |  40 ++--
 166 files changed, 1358 insertions(+), 727 deletions(-)

--=20
Cheers,
Stephen Rothwell

--Sig_/ro8BT7A4pCVS5HwS8XpjFbT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr2bwsACgkQAVBC80lX
0GySXggAm9wRf2fE2HjwFMEngV9EPNSdIVuM007ZBcG/v4KXV89E5w6DWfRaZUfQ
G9+eHjFPylhGZb4fJn7DIIqznfxGFX7ftW61byQYmi24FS5L/At6bkbW3xewe9KS
QjVb+tPXnCDXnEeb4rLgAe9NHIXyTHKRcnTmVqa+6V4ue8+GeFwON64ckenR4utx
N+YI5+M2hOWQjPu6JyQYyR0j7nYdxRdiT+dmznT/SUinKnl9lq0KTMlKdRMSpGax
HNSVggKk2hVFTM+bdrTYb7ljPGZ3fNCcc7VWOaaoDbUmkleVBw/JKfEHZrnMXFKM
PFqCRmQjLplVDYxOn/BVh7mC8UQSNA==
=PoPi
-----END PGP SIGNATURE-----

--Sig_/ro8BT7A4pCVS5HwS8XpjFbT--
