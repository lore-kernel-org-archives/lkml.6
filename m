Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDAEECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380F220854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQTBIaLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380F220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeKDXzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:55:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729422AbeKDXzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:55:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E45204FD;
        Sun,  4 Nov 2018 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541342402;
        bh=xun10mN4pMXdXEP+wQvMujiH13JDbtXYNP6olyDG0eI=;
        h=Date:From:To:Cc:Subject:From;
        b=iQTBIaLvTzaelYEHq8Zps8dCnQKSn0LZ6pZIZTjQIpQsQFjmawcqRSOH5uG6zCEzy
         2kY66vhazIEUgb2kv5kWuSpgLY8v4Ly3L9CCwh5i9RsVa38/fUk2Sm4+zek8ArCYPG
         m3ndgWogW3ZRqZwKsl3ZS+YndVw50ywF3/Mju6Cc=
Date:   Sun, 4 Nov 2018 15:40:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.79
Message-ID: <20181104144000.GA30742@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.79 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                |    6=20
 arch/Kconfig                                            |    8=20
 arch/arm/boot/dts/bcm63138.dtsi                         |   14=20
 arch/arm/boot/dts/imx53-qsb-common.dtsi                 |   11=20
 arch/arm/boot/dts/r8a7790.dtsi                          |    2=20
 arch/arm/boot/dts/tegra20.dtsi                          |    2=20
 arch/arm/mm/ioremap.c                                   |    2=20
 arch/arm64/mm/hugetlbpage.c                             |   12=20
 arch/mips/Kconfig                                       |    1=20
 arch/mips/include/asm/compiler.h                        |   35 +
 arch/powerpc/include/asm/topology.h                     |    3=20
 arch/sparc/mm/tlb.c                                     |   19=20
 arch/x86/events/amd/uncore.c                            |   10=20
 arch/x86/events/intel/uncore_snbep.c                    |   12=20
 arch/x86/include/asm/perf_event.h                       |    8=20
 arch/x86/kernel/paravirt.c                              |    4=20
 arch/x86/kvm/paging_tmpl.h                              |   11=20
 arch/x86/kvm/x86.c                                      |    6=20
 drivers/char/tpm/tpm-interface.c                        |    3=20
 drivers/char/tpm/tpm_crb.c                              |   10=20
 drivers/gpu/drm/i915/gvt/cmd_parser.c                   |    1=20
 drivers/infiniband/hw/mlx5/main.c                       |    2=20
 drivers/infiniband/hw/mlx5/qp.c                         |    7=20
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c            |    2=20
 drivers/infiniband/hw/usnic/usnic_uiom.c                |   40 +
 drivers/infiniband/hw/usnic/usnic_uiom.h                |    5=20
 drivers/infiniband/sw/rxe/rxe_pool.c                    |   16=20
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                 |    7=20
 drivers/md/dm-integrity.c                               |    3=20
 drivers/media/usb/uvc/uvc_driver.c                      |   11=20
 drivers/mmc/host/dw_mmc-rockchip.c                      |    4=20
 drivers/mtd/spi-nor/spi-nor.c                           |    6=20
 drivers/net/bonding/bond_netlink.c                      |    3=20
 drivers/net/ethernet/amazon/ena/ena_netdev.c            |   18=20
 drivers/net/ethernet/amd/declance.c                     |   10=20
 drivers/net/ethernet/broadcom/genet/bcmmii.c            |    9=20
 drivers/net/ethernet/cadence/macb_main.c                |    1=20
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c         |   17=20
 drivers/net/ethernet/cisco/enic/enic_main.c             |    9=20
 drivers/net/ethernet/emulex/benet/be_main.c             |    5=20
 drivers/net/ethernet/freescale/fec.h                    |    4=20
 drivers/net/ethernet/freescale/fec_main.c               |   24 -
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c      |   17=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c         |   45 --
 drivers/net/ethernet/mellanox/mlx5/core/eq.c            |    2=20
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c             |    4=20
 drivers/net/ethernet/qlogic/qed/qed_roce.c              |   15=20
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c       |    2=20
 drivers/net/ethernet/qlogic/qed/qed_vf.c                |    5=20
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c    |    3=20
 drivers/net/ethernet/realtek/r8169.c                    |    8=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c       |    2=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c        |    4=20
 drivers/net/hamradio/yam.c                              |    4=20
 drivers/net/phy/phy_device.c                            |   17=20
 drivers/net/phy/phylink.c                               |    2=20
 drivers/net/phy/realtek.c                               |    2=20
 drivers/net/usb/asix_common.c                           |    3=20
 drivers/net/usb/ax88179_178a.c                          |    3=20
 drivers/net/usb/lan78xx.c                               |   21=20
 drivers/net/usb/r8152.c                                 |    3=20
 drivers/net/usb/smsc75xx.c                              |    3=20
 drivers/net/usb/smsc95xx.c                              |    3=20
 drivers/net/usb/sr9800.c                                |    3=20
 drivers/net/virtio_net.c                                |    5=20
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h       |    4=20
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c             |   15=20
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c             |    3=20
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c           |    4=20
 drivers/net/wireless/mac80211_hwsim.c                   |    3=20
 drivers/net/wireless/marvell/libertas/if_sdio.c         |    4=20
 drivers/net/xen-netfront.c                              |   11=20
 drivers/s390/net/qeth_core_main.c                       |   85 +--
 drivers/scsi/aacraid/commsup.c                          |    8=20
 drivers/scsi/ibmvscsi/ibmvfc.c                          |    6=20
 drivers/scsi/qla2xxx/qla_init.c                         |    4=20
 drivers/scsi/sd.c                                       |    2=20
 drivers/soc/fsl/qbman/qman.c                            |    3=20
 drivers/soc/fsl/qe/ucc.c                                |    2=20
 drivers/usb/usbip/vhci_sysfs.c                          |   12=20
 drivers/vhost/vhost.c                                   |    2=20
 drivers/video/fbdev/pxa168fb.c                          |    6=20
 fs/btrfs/qgroup.c                                       |    4=20
 fs/cifs/inode.c                                         |    2=20
 fs/fat/fatent.c                                         |    1=20
 fs/ocfs2/refcounttree.c                                 |   16=20
 include/linux/bpf.h                                     |    2=20
 include/linux/compiler_types.h                          |   12=20
 include/linux/iio/buffer-dma.h                          |    2=20
 include/linux/mlx5/driver.h                             |   20=20
 include/linux/phy.h                                     |    4=20
 kernel/bpf/arraymap.c                                   |    3=20
 kernel/bpf/sockmap.c                                    |    4=20
 kernel/bpf/syscall.c                                    |    4=20
 kernel/events/core.c                                    |   11=20
 kernel/locking/test-ww_mutex.c                          |   10=20
 lib/test_bpf.c                                          |    2=20
 net/bluetooth/mgmt.c                                    |    7=20
 net/bluetooth/smp.c                                     |   29 +
 net/bluetooth/smp.h                                     |    3=20
 net/bridge/br_multicast.c                               |    9=20
 net/bridge/br_netfilter_hooks.c                         |    3=20
 net/core/datagram.c                                     |    5=20
 net/core/ethtool.c                                      |    8=20
 net/core/rtnetlink.c                                    |   10=20
 net/core/skbuff.c                                       |    5=20
 net/ipv4/ip_fragment.c                                  |   12=20
 net/ipv4/ipmr.c                                         |    2=20
 net/ipv4/udp.c                                          |   20=20
 net/ipv4/xfrm4_input.c                                  |    1=20
 net/ipv4/xfrm4_mode_transport.c                         |    4=20
 net/ipv6/addrconf.c                                     |    6=20
 net/ipv6/ip6_checksum.c                                 |   20=20
 net/ipv6/ip6_tunnel.c                                   |    9=20
 net/ipv6/mcast.c                                        |   16=20
 net/ipv6/ndisc.c                                        |    3=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                 |    2=20
 net/ipv6/udp.c                                          |    6=20
 net/ipv6/xfrm6_input.c                                  |    1=20
 net/ipv6/xfrm6_mode_transport.c                         |    4=20
 net/ipv6/xfrm6_output.c                                 |    2=20
 net/l2tp/l2tp_core.c                                    |   14=20
 net/l2tp/l2tp_core.h                                    |    3=20
 net/l2tp/l2tp_debugfs.c                                 |    4=20
 net/l2tp/l2tp_netlink.c                                 |    3=20
 net/llc/llc_conn.c                                      |    1=20
 net/mac80211/mesh.h                                     |    3=20
 net/mac80211/mesh_hwmp.c                                |    9=20
 net/mac80211/status.c                                   |   11=20
 net/mac80211/tdls.c                                     |    8=20
 net/mac80211/tx.c                                       |    2=20
 net/openvswitch/flow_netlink.c                          |    4=20
 net/rxrpc/ar-internal.h                                 |    4=20
 net/rxrpc/call_accept.c                                 |    4=20
 net/rxrpc/conn_event.c                                  |   26 -
 net/rxrpc/input.c                                       |   54 +-
 net/sched/cls_api.c                                     |    7=20
 net/sched/sch_api.c                                     |    3=20
 net/sched/sch_gred.c                                    |    2=20
 net/sched/sch_netem.c                                   |    4=20
 net/sctp/socket.c                                       |    5=20
 net/socket.c                                            |   11=20
 net/wireless/nl80211.c                                  |   20=20
 net/wireless/reg.c                                      |    8=20
 net/wireless/scan.c                                     |   58 ++
 net/xfrm/xfrm_input.c                                   |    1=20
 net/xfrm/xfrm_output.c                                  |    4=20
 net/xfrm/xfrm_policy.c                                  |    4=20
 net/xfrm/xfrm_user.c                                    |   15=20
 scripts/kconfig/zconf.y                                 |    4=20
 sound/usb/usx2y/usb_stream.c                            |   23 -
 tools/perf/Makefile                                     |    4=20
 tools/perf/tests/builtin-test.c                         |    4=20
 tools/perf/util/setup.py                                |    2=20
 tools/testing/nvdimm/test/nfit.c                        |   18=20
 tools/testing/selftests/net/rtnetlink.sh                |    2=20
 tools/testing/selftests/powerpc/ptrace/.gitignore       |    1=20
 tools/testing/selftests/powerpc/ptrace/Makefile         |    2=20
 tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c |  342 +++++++++++=
+++++
 159 files changed, 1212 insertions(+), 499 deletions(-)

Ake Koomsin (1):
      virtio_net: avoid using netif_tx_disable() for serializing tx routine

Alex Vesker (1):
      IB/ipoib: Fix lockdep issue found on ipoib_ib_dev_heavy_flush

Alexandre Belloni (1):
      soc: fsl: qbman: qman: avoid allocating from non existing gen_pool

Andrei Otcheretianski (2):
      mac80211: Always report TX status
      cfg80211: reg: Init wiphy_idx in regulatory_hint_core()

Arnaldo Carvalho de Melo (1):
      perf python: Use -Wno-redundant-decls to build with PYTHON=3Dpython3

Arnd Bergmann (2):
      scsi: aacraid: address UBSAN warning regression
      net: stmmac: mark PM functions as __maybe_unused

Arthur Kiyanovski (2):
      net: ena: fix warning in rmmod caused by double iounmap
      net: ena: fix NULL dereference due to untimely napi initialization

Ben Hutchings (1):
      scsi: qla2xxx: Avoid double completion of abort command

Bob Copeland (1):
      mac80211: fix pending queue hang due to TX_DROP

Brian King (1):
      scsi: ibmvfc: Avoid unnecessary port relogin

Chris Paterson (1):
      ARM: dts: r8a7790: Correct critical CPU temperature

Christoph Paasch (1):
      sch_netem: restore skb->dev after dequeuing from the rbtree

Colin Ian King (1):
      drm/i915/gvt: fix memory leak of a cmd_entry struct on error exit path

Cong Wang (2):
      llc: set SOCK_RCU_FREE in llc_sap_add_socket()
      net: drop skb on failure in ip_check_defrag()

Corentin Labbe (1):
      powerpc/pseries: Add empty update_numa_cpu_lookup_table() for NUMA=3Dn

Dan Carpenter (1):
      x86/paravirt: Fix some warning messages

Dan Williams (1):
      tools/testing/nvdimm: unit test clear-error commands

Daniel Mack (1):
      libertas: call into generic suspend code before turning off power

David Ahern (2):
      netfilter: bridge: Don't sabotage nf_hook calls from an l3mdev
      net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs

David Howells (3):
      rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_w=
indow()
      rxrpc: Only take the rwind and mtu values from latest ACK
      rxrpc: Fix connection-level abort handling

David S. Miller (1):
      sparc64: Fix regression in pmdp_invalidate().

Davide Caratti (2):
      be2net: don't flip hw_features when VXLANs are added/deleted
      net/sched: cls_api: add missing validation of netlink attributes

Dimitris Michailidis (1):
      net: fix pskb_trim_rcsum_slow() with odd trim offset

Doug Ledford (1):
      IB/rxe: put the pool on allocation failure

Emmanuel Grumbach (1):
      iwlwifi: fix the ALIVE notification layout

Eric Dumazet (2):
      ipv6: mcast: fix a use-after-free in inet6_mc_check
      net/mlx5e: fix csum adjustments caused by RXFCS

Florian Fainelli (10):
      ARM: dts: BCM63xx: Fix incorrect interrupt specifiers
      asix: Check for supported Wake-on-LAN modes
      ax88179_178a: Check for supported Wake-on-LAN modes
      lan78xx: Check for supported Wake-on-LAN modes
      sr9800: Check for supported Wake-on-LAN modes
      r8152: Check for supported Wake-on-LAN Modes
      smsc75xx: Check for Wake-on-LAN modes
      smsc95xx: Check for Wake-on-LAN modes
      net: phy: phylink: Don't release NULL GPIO
      net: bcmgenet: Poll internal PHY for GENETv5

Fugang Duan (1):
      net: fec: don't dump RX FIFO register when not available

Geert Uytterhoeven (1):
      cifs: Use ULL suffix for 64-bit constant

Govindarajulu Varadarajan (1):
      enic: do not overwrite error code

Greg Kroah-Hartman (1):
      Linux 4.14.79

Guenter Roeck (1):
      locking/ww_mutex: Fix runtime warning in the WW mutex selftest

Hangbin Liu (1):
      bridge: do not add port to router list when receives query with sourc=
e 0.0.0.0

Heiner Kallweit (1):
      r8169: fix NAPI handling under high load

Huy Nguyen (1):
      net/mlx5: Take only bit 24-26 of wqe.pftype_wq for page fault type

Ido Schimmel (1):
      rtnetlink: Disallow FDB configuration for non-Ethernet device

Israel Rukshin (1):
      net/mlx5: Fix mlx5_get_vector_affinity function

Jaime Caama=F1o Ruiz (1):
      openvswitch: Fix push/pop ethernet validation

Jakub Kicinski (1):
      net: sched: gred: pass the right attribute to gred_change_table_def()

James Chapman (1):
      l2tp: remove configurable payload offset

Jason Gunthorpe (1):
      IB/usnic: Update with bug fixes from core code

Jason Wang (1):
      vhost: Fix Spectre V1 vulnerability

Jiri Olsa (1):
      perf/ring_buffer: Prevent concurent ring buffer access

Johannes Berg (1):
      mac80211: TDLS: fix skb queue/priority assignment

John Fastabend (1):
      bpf: sockmap, map_release does not hold refcnt for pinned maps

John Keeping (1):
      mmc: dw_mmc-rockchip: correct property names in debug

Jouni Malinen (1):
      cfg80211: Address some corner cases in scan result channel updating

Julian Wiedmann (1):
      s390/qeth: fix error handling in adapter command callbacks

Kan Liang (1):
      perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX

KarimAllah Ahmed (1):
      KVM: x86: Update the exit_qualification access bits while walking an =
address

Kevin Hao (2):
      net: phy: realtek: Use the dummy stubs for MMD register access for rt=
l8211b
      net: phy: Add general dummy stubs for MMD register access

Khazhismel Kumykov (1):
      fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()

Kimmo Rautkoski (1):
      mtd: spi-nor: Add support for is25wp series chips

Larry Chen (1):
      ocfs2: fix crash in ocfs2_duplicate_clusters_by_page()

Liad Kaufman (1):
      iwlwifi: dbg: allow wrt collection before ALIVE

Lubomir Rintel (1):
      pxa168fb: prepare the clock

Maciej W. Rozycki (1):
      declance: Fix continuation with the adapter identification message

Marcel Ziswiler (1):
      ARM: tegra: Fix ULPI regression on Tegra20

Marcelo Ricardo Leitner (1):
      sctp: fix race on sctp_id2asoc

Martin K. Petersen (1):
      scsi: sd: Remember that READ CAPACITY(16) succeeded

Martin Willi (1):
      mac80211_hwsim: do not omit multicast announce of first added radio

Masahiro Yamada (1):
      kconfig: fix the rule of mainmenu_stmt symbol

Masashi Honma (2):
      nl80211: Fix possible Spectre-v1 for NL80211_TXRATE_HT
      nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds

Matias Karhumaa (1):
      Bluetooth: SMP: fix crash in unpairing

Michael Neuling (1):
      selftests/powerpc: Add ptrace hw breakpoint test

Michal Simek (1):
      net: macb: Clean 64b dma addresses if they are not detected

Milan Broz (1):
      dm integrity: fail early if required HMAC key is not available

Natarajan, Janakarajan (1):
      perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf e=
vents

Nathan Chancellor (5):
      qed: Avoid implicit enum conversion in qed_set_tunn_cls_info
      qed: Fix mask parameter in qed_vf_prep_tunn_req_tlv
      qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor
      qed: Avoid constant logical operation warning in qed_vf_pf_acquire
      qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt

Nayna Jain (1):
      tpm: move the delay_msec increment after sleep in tpm_transmit()

Niklas Cassel (1):
      net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules

Nikolay Aleksandrov (2):
      net: bridge: remove ipv6 zero address check in mcast queries
      net: ipmr: fix unresolved entry dumps

Noa Osherovich (1):
      IB/mlx5: Avoid passing an invalid QP type to firmware

Paolo Abeni (2):
      selftests: rtnetlink.sh explicitly requires bash.
      udp6: fix encap return code for resubmitting

Paul Burton (2):
      MIPS: Workaround GCC __builtin_unreachable reordering bug
      compiler.h: Allow arch-specific asm/compiler.h

Peter Xu (1):
      kvm: x86: fix WARN due to uninitialized guest FPU state

Peter Zijlstra (1):
      perf/core: Fix perf_pmu_unregister() locking

Phil Elwell (1):
      lan78xx: Don't reset the interface on open

Phil Reid (1):
      iio: buffer: fix the function signature to match implementation

Phil Sutter (1):
      net: sched: Fix for duplicate class dump

Philipp Zabel (1):
      media: uvcvideo: Fix driver reference counting

Qu Wenruo (1):
      btrfs: quota: Set rescan progress to (u64)-1 if we hit last leaf

Rasmus Villemoes (1):
      perf tools: Disable parallelism for 'make clean'

Rickard x Andersson (1):
      net: fec: fix rare tx timeout

Ross Lagerwall (2):
      xen-netfront: Update features after registering netdev
      xen-netfront: Fix mismatched rtnl_unlock

Saeed Mahameed (1):
      net/mlx5: Fix build break when CONFIG_SMP=3Dn

Sandipan Das (1):
      perf tests: Fix indexing when invoking subtests

Sara Sharon (1):
      iwlwifi: mvm: check for short GI only for OFDM

Sascha Hauer (1):
      ARM: dts: imx53-qsb: disable 1.2GHz OPP

Sasha Levin (1):
      Revert "netfilter: ipv6: nf_defrag: drop skb dst before queueing"

Sean Tranchetti (3):
      xfrm: validate template mode
      net: qualcomm: rmnet: Skip processing loopback packets
      net: udp: fix handling of CHECKSUM_COMPLETE packets

Shay Agroskin (1):
      net/mlx5e: Refine ets validation function

Shuah Khan (1):
      usbip: vhci_hcd: update 'status' file header and format

Sowmini Varadhan (2):
      xfrm: reset transport header back to network header after all input t=
ransforms ahave been applied
      xfrm: reset crypto_done when iterating over multiple input xfrms

Stefan Agner (1):
      kbuild: set no-integrated-as before incl. arch Makefile

Stefano Brivio (2):
      ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers a=
re called
      ip6_tunnel: Fix encapsulation layout

Steffen Klassert (2):
      xfrm: Validate address prefix lengths in the xfrm selector.
      xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_=
entry.

Steve Capper (1):
      arm64: hugetlb: Fix handling of young ptes

Takashi Iwai (1):
      ALSA: usx2y: Fix invalid stream URBs

Thadeu Lima de Souza Cascardo (2):
      xfrm6: call kfree_skb when skb is toobig
      test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=3Dy on other arch=
es

Thomas Petazzoni (1):
      ARM: 8799/1: mm: fix pci_ioremap_io() offset check

Tobias Jungel (1):
      bonding: fix length of actor system

Wenwen Wang (4):
      net: cxgb3_main: fix a missing-check bug
      yam: fix a missing-check bug
      net: socket: fix a missing-check bug
      ethtool: fix a privilege escalation bug

Winkler, Tomas (1):
      tpm: tpm_crb: relinquish locality on error path.

Yu Zhao (1):
      cfg80211: fix use-after-free in reg_process_hint()

Yuan-Chi Pang (1):
      mac80211: fix TX status reporting for ieee80211s

Zhao Qiang (1):
      soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvfBMAACgkQONu9yGCS
aT7Huw/+OGEkl9TMkuhFFR6ulnOusmiNfEFbsIxuu5vN/RFNtzX6csyPnQ0cIk5K
p/K1YAzbp3fmQzoVGkEkGKJPvJC+jESkhhRUHkSQEja37SprApwMH+nBiSeWMzj0
YuJVY84Fom9labTPqA/j2j3DPH2IFW24fSf1dftnc2q1rgDPnuB+1Zq7t0mjcXn+
ZbQ5WK+lMYHVGOrRvGfJr5bid9N/Izn7DqKK3r0mA6EDNT4XFaPmY0PcCKhkHzHP
eyiNwzrKX/H593XPWMVDSgrHes2vSVsr4dF4MhDx7ymgwoVfNsltGtlz9V3a4F8F
hoLg/o8UuTsfOfIt6lAl8yDaFCixc559SW8VvTkx+OFL85LthLLIHuIw4b/1k3aH
a6Wcd/TKqxVZLIn/aJzr+LWz7OO8jbiR4v3iiENZr9pjvlY9dhtggG2nvllkoStW
YkxU6w75DxpPSJ2ru7ibIvBSPNDUY5njE5vveVsMZXg8skA5H60/OaS+35VxuWAM
1Rbc7Twh4C1oYT6FD+6384swhSQUQ+RXHy5/OPp64LZyF6+lzLWHz3YcK0UUbrWp
V9oMCf6KevWvHNdSQEPPAldpOtNE1gbjYwRwn0ItAxeLE2ddkx6R0TbN6WT1rfOD
O6fWzGNY5BhnFsAwh3ozdPALw2/uRbNRb6kqzwXZ6eaJK54dIg0=
=KpeD
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
