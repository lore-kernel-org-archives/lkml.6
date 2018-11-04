Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C52AECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45B3204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8W1gn2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45B3204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbeKDXyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:54:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbeKDXyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:54:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6EAD204FD;
        Sun,  4 Nov 2018 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541342380;
        bh=H1xaZu0s8/kCpsRUI2QhGddplBlC78X0e7yp+cpqUe8=;
        h=Date:From:To:Cc:Subject:From;
        b=R8W1gn2LLui1spC09PJQeCNKu+Ymm6VH2svCrzVRy2X+3T6Lt+hGEPxIoZUj4BcYd
         0eb3ivwIwFWpANmg2gq+Ru5O6L9kb79GN0hKm0qGsxhoKximrmAUuqD6wUfjVYSsvC
         r+V1/vuy57EmiCVMNJWv8dhacKSHj+/55Atg6zbM=
Date:   Sun, 4 Nov 2018 15:39:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.17
Message-ID: <20181104143937.GA30679@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.17 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                 |    2=20
 arch/Kconfig                                             |    8 +
 arch/arm/boot/dts/bcm63138.dtsi                          |   14 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi                  |   11 +
 arch/arm/kernel/vmlinux.lds.h                            |    2=20
 arch/arm/mm/ioremap.c                                    |    2=20
 arch/arm64/mm/hugetlbpage.c                              |   12 +-
 arch/powerpc/mm/numa.c                                   |    5=20
 arch/riscv/kernel/setup.c                                |    2=20
 arch/sparc/include/asm/cpudata_64.h                      |    2=20
 arch/sparc/include/asm/switch_to_64.h                    |    3=20
 arch/sparc/kernel/perf_event.c                           |   26 +++-
 arch/sparc/kernel/process_64.c                           |   25 +++-
 arch/sparc/kernel/rtrap_64.S                             |    4=20
 arch/sparc/kernel/signal32.c                             |   12 +-
 arch/sparc/kernel/signal_64.c                            |    6 -
 arch/sparc/kernel/systbls_64.S                           |    4=20
 arch/sparc/mm/init_64.c                                  |    1=20
 arch/sparc/vdso/vclock_gettime.c                         |   12 +-
 arch/x86/events/amd/uncore.c                             |   10 +
 arch/x86/events/intel/uncore_snbep.c                     |   14 +-
 arch/x86/include/asm/perf_event.h                        |    8 +
 arch/x86/kernel/paravirt.c                               |    4=20
 arch/x86/kvm/svm.c                                       |    6 -
 arch/x86/kvm/vmx.c                                       |   39 +++++-
 arch/x86/kvm/x86.c                                       |    2=20
 drivers/clk/mvebu/armada-37xx-periph.c                   |    1=20
 drivers/gpio/gpiolib.c                                   |    3=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c        |   10 +
 drivers/gpu/drm/i2c/tda9950.c                            |    5=20
 drivers/hid/hid-ids.h                                    |    1=20
 drivers/hid/i2c-hid/i2c-hid.c                            |   18 ---
 drivers/infiniband/hw/mlx5/mr.c                          |   12 +-
 drivers/net/bonding/bond_netlink.c                       |    3=20
 drivers/net/ethernet/amazon/ena/ena_netdev.c             |   22 ++-
 drivers/net/ethernet/amd/declance.c                      |   10 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c             |    7 -
 drivers/net/ethernet/cadence/macb_main.c                 |    1=20
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c          |   17 ++
 drivers/net/ethernet/emulex/benet/be_main.c              |    5=20
 drivers/net/ethernet/freescale/fec.h                     |    4=20
 drivers/net/ethernet/freescale/fec_main.c                |   24 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          |   57 ++-------
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c          |   22 +--
 drivers/net/ethernet/mellanox/mlx5/core/eq.c             |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c     |    9 -
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h    |    5=20
 drivers/net/ethernet/mellanox/mlx5/core/wq.c             |    5=20
 drivers/net/ethernet/mellanox/mlx5/core/wq.h             |   11 -
 drivers/net/ethernet/mellanox/mlxsw/core.c               |   24 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |    2=20
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c              |    4=20
 drivers/net/ethernet/qlogic/qed/qed_roce.c               |   15 --
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c        |    2=20
 drivers/net/ethernet/qlogic/qed/qed_vf.c                 |    5=20
 drivers/net/ethernet/realtek/r8169.c                     |    8 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c        |    2=20
 drivers/net/hamradio/yam.c                               |    4=20
 drivers/net/usb/asix_common.c                            |    3=20
 drivers/net/usb/ax88179_178a.c                           |    3=20
 drivers/net/usb/lan78xx.c                                |   17 --
 drivers/net/usb/r8152.c                                  |    3=20
 drivers/net/usb/smsc75xx.c                               |    3=20
 drivers/net/usb/smsc95xx.c                               |    3=20
 drivers/net/usb/sr9800.c                                 |    3=20
 drivers/net/virtio_net.c                                 |    5=20
 drivers/net/wireless/mac80211_hwsim.c                    |   36 ++----
 drivers/net/wireless/marvell/libertas/if_sdio.c          |    4=20
 drivers/scsi/qedi/qedi_main.c                            |    1=20
 drivers/soc/fsl/qbman/qman.c                             |    3=20
 drivers/soc/fsl/qe/ucc.c                                 |    2=20
 drivers/thunderbolt/icm.c                                |   49 +++-----
 drivers/thunderbolt/nhi.c                                |    2=20
 drivers/tty/serial/8250/8250_dw.c                        |    4=20
 drivers/vhost/vhost.c                                    |    2=20
 drivers/video/fbdev/pxa168fb.c                           |    6 -
 fs/afs/cell.c                                            |   17 ++
 fs/afs/dynroot.c                                         |    2=20
 fs/afs/internal.h                                        |    4=20
 fs/afs/main.c                                            |    2=20
 fs/afs/proc.c                                            |    7 -
 fs/fat/fatent.c                                          |    1=20
 fs/ocfs2/refcounttree.c                                  |   16 ++
 include/asm-generic/vmlinux.lds.h                        |    6 -
 include/linux/compiler_types.h                           |   12 ++
 include/linux/gpio/driver.h                              |    7 +
 include/linux/mlx5/driver.h                              |    8 +
 include/linux/netfilter.h                                |    2=20
 include/net/ip6_fib.h                                    |    4=20
 include/net/sctp/sm.h                                    |    2=20
 include/trace/events/rxrpc.h                             |    4=20
 kernel/events/core.c                                     |   11 -
 kernel/locking/test-ww_mutex.c                           |   10 +
 mm/gup_benchmark.c                                       |    3=20
 mm/migrate.c                                             |    2=20
 mm/vmscan.c                                              |   11 -
 net/bluetooth/mgmt.c                                     |    7 -
 net/bluetooth/smp.c                                      |   29 ++++
 net/bluetooth/smp.h                                      |    3=20
 net/bpfilter/bpfilter_kern.c                             |    6 -
 net/bridge/br_multicast.c                                |    9 +
 net/bridge/br_netfilter_hooks.c                          |    3=20
 net/core/datagram.c                                      |    5=20
 net/core/ethtool.c                                       |    8 +
 net/core/rtnetlink.c                                     |   10 +
 net/core/skbuff.c                                        |    5=20
 net/ipv4/ip_fragment.c                                   |   12 +-
 net/ipv4/ipmr_base.c                                     |    2=20
 net/ipv4/udp.c                                           |   20 +++
 net/ipv4/xfrm4_input.c                                   |    1=20
 net/ipv4/xfrm4_mode_transport.c                          |    4=20
 net/ipv6/addrconf.c                                      |    6 -
 net/ipv6/ip6_checksum.c                                  |   20 +++
 net/ipv6/ip6_tunnel.c                                    |    9 -
 net/ipv6/mcast.c                                         |   16 +-
 net/ipv6/ndisc.c                                         |    3=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                  |    2=20
 net/ipv6/route.c                                         |   14 +-
 net/ipv6/udp.c                                           |    6 -
 net/ipv6/xfrm6_input.c                                   |    1=20
 net/ipv6/xfrm6_mode_transport.c                          |    4=20
 net/ipv6/xfrm6_output.c                                  |    2=20
 net/llc/llc_conn.c                                       |    1=20
 net/mac80211/mesh.h                                      |    3=20
 net/mac80211/mesh_hwmp.c                                 |    9 -
 net/mac80211/status.c                                    |   11 -
 net/mac80211/tdls.c                                      |    8 -
 net/mac80211/tx.c                                        |    2=20
 net/netfilter/nf_conntrack_proto_tcp.c                   |    4=20
 net/netfilter/nft_set_rbtree.c                           |   28 ++--
 net/openvswitch/flow_netlink.c                           |    4=20
 net/rds/send.c                                           |   13 +-
 net/rxrpc/ar-internal.h                                  |   19 ++-
 net/rxrpc/call_accept.c                                  |    4=20
 net/rxrpc/call_object.c                                  |    2=20
 net/rxrpc/conn_client.c                                  |    4=20
 net/rxrpc/conn_event.c                                   |   26 ++--
 net/rxrpc/conn_object.c                                  |    4=20
 net/rxrpc/input.c                                        |   88 ++++++++--=
-----
 net/rxrpc/local_object.c                                 |   32 +++--
 net/rxrpc/output.c                                       |   31 +++--
 net/rxrpc/peer_event.c                                   |   46 +------
 net/rxrpc/peer_object.c                                  |   17 --
 net/sched/cls_api.c                                      |   11 +
 net/sched/sch_api.c                                      |    3=20
 net/sched/sch_gred.c                                     |    2=20
 net/sctp/socket.c                                        |    9 -
 net/smc/smc_core.c                                       |   23 +--
 net/socket.c                                             |   11 +
 net/tipc/name_distr.c                                    |    4=20
 net/tls/tls_sw.c                                         |   12 --
 net/wireless/nl80211.c                                   |   20 ++-
 net/wireless/reg.c                                       |    8 -
 net/wireless/scan.c                                      |   58 ++++++++-
 net/xfrm/xfrm_input.c                                    |    1=20
 net/xfrm/xfrm_output.c                                   |    4=20
 net/xfrm/xfrm_policy.c                                   |    4=20
 net/xfrm/xfrm_user.c                                     |   15 ++
 tools/perf/Makefile                                      |    4=20
 tools/perf/util/machine.c                                |    8 -
 tools/perf/util/setup.py                                 |    2=20
 tools/testing/selftests/net/fib-onlink-tests.sh          |   14 +-
 tools/testing/selftests/net/rtnetlink.sh                 |    2=20
 tools/testing/selftests/net/udpgso_bench.sh              |    2=20
 164 files changed, 976 insertions(+), 640 deletions(-)

Ake Koomsin (1):
      virtio_net: avoid using netif_tx_disable() for serializing tx routine

Alexandre Belloni (1):
      soc: fsl: qbman: qman: avoid allocating from non existing gen_pool

Anders Roxell (1):
      clk: mvebu: armada-37xx-periph: Remove unused var num_parents

Andrei Otcheretianski (2):
      mac80211: Always report TX status
      cfg80211: reg: Init wiphy_idx in regulatory_hint_core()

Anshuman Khandual (1):
      mm/migrate.c: split only transparent huge pages when allocation fails

Arnaldo Carvalho de Melo (1):
      perf python: Use -Wno-redundant-decls to build with PYTHON=3Dpython3

Arthur Kiyanovski (3):
      net: ena: fix warning in rmmod caused by double iounmap
      net: ena: fix rare bug when failed restart/resume is followed by driv=
er removal
      net: ena: fix NULL dereference due to untimely napi initialization

Atish Patra (1):
      RISCV: Fix end PFN for low memory

Bob Copeland (1):
      mac80211: fix pending queue hang due to TX_DROP

Colin Ian King (1):
      drm/i2c: tda9950: fix timeout counter check

Cong Wang (2):
      llc: set SOCK_RCU_FREE in llc_sap_add_socket()
      net: drop skb on failure in ip_check_defrag()

Dan Carpenter (1):
      x86/paravirt: Fix some warning messages

Daniel Mack (1):
      libertas: call into generic suspend code before turning off power

David Ahern (3):
      netfilter: bridge: Don't sabotage nf_hook calls from an l3mdev
      net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs
      net/ipv6: Allow onlink routes to have a device mismatch if it is the =
default route

David Howells (9):
      rxrpc: Fix checks as to whether we should set up a new call
      rxrpc: Fix RTT gathering
      rxrpc: Fix transport sockopts to get IPv4 errors on an IPv6 socket
      rxrpc: Fix error distribution
      rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_w=
indow()
      rxrpc: Carry call state out of locked section in rxrpc_rotate_tx_wind=
ow()
      rxrpc: Only take the rwind and mtu values from latest ACK
      rxrpc: Fix connection-level abort handling
      afs: Fix cell proc list

David Miller (1):
      sparc64: Make corrupted user stacks more debuggable.

David S. Miller (7):
      sparc64: Export __node_distance.
      sparc64: Make proc_id signed.
      sparc64: Set %l4 properly on trap return after handling signals.
      sparc64: Wire up compat getpeername and getsockname.
      sparc: Fix single-pcr perf event counter management.
      sparc: Fix syscall fallback bugs in VDSO.
      sparc: Throttle perf events properly.

Davide Caratti (2):
      be2net: don't flip hw_features when VXLANs are added/deleted
      net/sched: cls_api: add missing validation of netlink attributes

Dimitris Michailidis (1):
      net: fix pskb_trim_rcsum_slow() with odd trim offset

Doron Roberts-Kedes (1):
      tls: Fix improper revert in zerocopy_from_iter

Eric Dumazet (2):
      ipv6: mcast: fix a use-after-free in inet6_mc_check
      net/mlx5e: fix csum adjustments caused by RXFCS

Florian Fainelli (9):
      ARM: dts: BCM63xx: Fix incorrect interrupt specifiers
      asix: Check for supported Wake-on-LAN modes
      ax88179_178a: Check for supported Wake-on-LAN modes
      lan78xx: Check for supported Wake-on-LAN modes
      sr9800: Check for supported Wake-on-LAN modes
      r8152: Check for supported Wake-on-LAN Modes
      smsc75xx: Check for Wake-on-LAN modes
      smsc95xx: Check for Wake-on-LAN modes
      net: bcmgenet: Poll internal PHY for GENETv5

Florian Westphal (1):
      netfilter: avoid erronous array bounds warning

Fugang Duan (1):
      net: fec: don't dump RX FIFO register when not available

Greg Kroah-Hartman (1):
      Linux 4.18.17

Guenter Roeck (2):
      Revert "serial: 8250_dw: Fix runtime PM handling"
      locking/ww_mutex: Fix runtime warning in the WW mutex selftest

Hangbin Liu (1):
      bridge: do not add port to router list when receives query with sourc=
e 0.0.0.0

Hans Verkuil (1):
      drm/i2c: tda9950: set MAX_RETRIES for errors only

Hans de Goede (1):
      HID: i2c-hid: Remove RESEND_REPORT_DESCR quirk and its handling

Heiner Kallweit (1):
      r8169: fix NAPI handling under high load

Huy Nguyen (1):
      net/mlx5: Take only bit 24-26 of wqe.pftype_wq for page fault type

Ido Schimmel (1):
      rtnetlink: Disallow FDB configuration for non-Ethernet device

Jaime Caama=F1o Ruiz (1):
      openvswitch: Fix push/pop ethernet validation

Jakub Kicinski (1):
      net: sched: gred: pass the right attribute to gred_change_table_def()

Jason Wang (1):
      vhost: Fix Spectre V1 vulnerability

Jiri Olsa (1):
      perf/ring_buffer: Prevent concurent ring buffer access

Johannes Berg (1):
      mac80211: TDLS: fix skb queue/priority assignment

Jouni Malinen (1):
      cfg80211: Address some corner cases in scan result channel updating

Ka-Cheong Poon (1):
      rds: RDS (tcp) hangs on sendto() to unresponding address

Kan Liang (1):
      perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX

Karsten Graul (1):
      net/smc: fix smc_buf_unuse to use the lgr pointer

Khazhismel Kumykov (1):
      fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()

Larry Chen (1):
      ocfs2: fix crash in ocfs2_duplicate_clusters_by_page()

Liran Alon (3):
      KVM: nVMX: Do not expose MPX VMX controls when guest MPX disabled
      KVM: x86: Do not use kvm_x86_ops->mpx_supported() directly
      KVM: nVMX: Fix emulation of VM_ENTRY_LOAD_BNDCFGS

Lubomir Rintel (1):
      pxa168fb: prepare the clock

Maciej W. Rozycki (1):
      declance: Fix continuation with the adapter identification message

Marcelo Ricardo Leitner (1):
      sctp: fix race on sctp_id2asoc

Martin Willi (3):
      mac80211_hwsim: fix locking when iterating radios during ns exit
      mac80211_hwsim: fix race in radio destruction from netlink notifier
      mac80211_hwsim: do not omit multicast announce of first added radio

Masashi Honma (2):
      nl80211: Fix possible Spectre-v1 for NL80211_TXRATE_HT
      nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds

Masayoshi Mizuma (1):
      perf/x86/intel/uncore: Use boot_cpu_data.phys_proc_id instead of hard=
corded physical package ID 0

Matias Karhumaa (1):
      Bluetooth: SMP: fix crash in unpairing

Michal Simek (1):
      net: macb: Clean 64b dma addresses if they are not detected

Mika Westerberg (2):
      thunderbolt: Do not handle ICM events after domain is stopped
      thunderbolt: Initialize after IOMMUs

Milian Wolff (2):
      perf report: Don't try to map ip to invalid map
      perf record: Use unmapped IP for inline callchain cursors

Natarajan, Janakarajan (1):
      perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf e=
vents

Nathan Chancellor (5):
      qed: Avoid implicit enum conversion in qed_set_tunn_cls_info
      qed: Fix mask parameter in qed_vf_prep_tunn_req_tlv
      qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor
      qed: Avoid constant logical operation warning in qed_vf_pf_acquire
      qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt

Niklas Cassel (1):
      net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules

Nikolay Aleksandrov (2):
      net: ipmr: fix unresolved entry dumps
      net: bridge: remove ipv6 zero address check in mcast queries

Nilesh Javali (1):
      scsi: qedi: Initialize the stats mutex lock

Paolo Abeni (3):
      selftests: rtnetlink.sh explicitly requires bash.
      selftests: udpgso_bench.sh explicitly requires bash
      udp6: fix encap return code for resubmitting

Paolo Bonzini (1):
      KVM: x86: support CONFIG_KVM_AMD=3Dy with CONFIG_CRYPTO_DEV_CCP_DD=3Dm

Paul Burton (1):
      compiler.h: Allow arch-specific asm/compiler.h

Peter Oberparleiter (2):
      vmlinux.lds.h: Fix incomplete .text.exit discards
      vmlinux.lds.h: Fix linker warnings about orphan .LPBX sections

Peter Zijlstra (1):
      perf/core: Fix perf_pmu_unregister() locking

Petr Machata (1):
      mlxsw: spectrum_switchdev: Don't ignore deletions of learned MACs

Phil Sutter (1):
      net: sched: Fix for duplicate class dump

Rasmus Villemoes (1):
      perf tools: Disable parallelism for 'make clean'

Rickard x Andersson (1):
      net: fec: fix rare tx timeout

Sabrina Dubroca (1):
      ipv6: rate-limit probes for neighbourless routes

Sascha Hauer (1):
      ARM: dts: imx53-qsb: disable 1.2GHz OPP

Sasha Levin (2):
      Revert "mm: slowly shrink slabs with a relatively small number of obj=
ects"
      Revert "netfilter: ipv6: nf_defrag: drop skb dst before queueing"

Sean Tranchetti (2):
      xfrm: validate template mode
      net: udp: fix handling of CHECKSUM_COMPLETE packets

Shalom Toledo (1):
      mlxsw: core: Fix devlink unregister flow

Shirish S (1):
      drm/amd/display: Signal hw_done() after waiting for flip_done()

Sowmini Varadhan (2):
      xfrm: reset transport header back to network header after all input t=
ransforms ahave been applied
      xfrm: reset crypto_done when iterating over multiple input xfrms

Srikar Dronamraju (1):
      powerpc/numa: Skip onlining a offline node in kdump path

Stefano Brivio (2):
      ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers a=
re called
      ip6_tunnel: Fix encapsulation layout

Steffen Klassert (2):
      xfrm: Validate address prefix lengths in the xfrm selector.
      xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_=
entry.

Stephen Boyd (1):
      gpio: Assign gpio_irq_chip::parents to non-stack pointer

Steve Capper (1):
      arm64: hugetlb: Fix handling of young ptes

Taehee Yoo (2):
      netfilter: nft_set_rbtree: add missing rb_erase() in GC routine
      net: bpfilter: use get_pid_task instead of pid_task

Talat Batheesh (1):
      net/mlx5: Fix memory leak when setting fpga ipsec caps

Tariq Toukan (1):
      net/mlx5: WQ, fixes for fragmented WQ buffers API

Thadeu Lima de Souza Cascardo (1):
      xfrm6: call kfree_skb when skb is toobig

Thomas Petazzoni (1):
      ARM: 8799/1: mm: fix pci_ioremap_io() offset check

Tobias Jungel (1):
      bonding: fix length of actor system

Tung Nguyen (1):
      tipc: fix unsafe rcu locking when accessing publication list

Valentine Fatiev (1):
      IB/mlx5: Unmap DMA addr from HCA before IOMMU

Wenwen Wang (4):
      net: cxgb3_main: fix a missing-check bug
      yam: fix a missing-check bug
      net: socket: fix a missing-check bug
      ethtool: fix a privilege escalation bug

Xin Long (2):
      sctp: fix the data size calculation in sctp_data_size
      sctp: not free the new asoc when sctp_wait_for_connect returns err

Yu Zhao (1):
      cfg80211: fix use-after-free in reg_process_hint()

Yuan-Chi Pang (1):
      mac80211: fix TX status reporting for ieee80211s

YueHaibing (1):
      mm/gup_benchmark: fix unsigned comparison to zero in __gup_benchmark_=
ioctl

Zhao Qiang (1):
      soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()

zhong jiang (1):
      netfilter: conntrack: get rid of double sizeof


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvfBKkACgkQONu9yGCS
aT63zRAAwUybgOMB62oN4G//e37H/9CF/Ty/6/8sHPFwnuZANNRhEpqs2/LJeezE
kb5UlJ6mPaKzzalOIyCjXRuUNh8AjRQJdjnn/WwjCINdk6qSYRe3XHuZpUdeRQql
jw6UcG9YxKeN0K25Fy0q72Nj/sWkhJL7VJJVGHSzxtA+ZSmY0Jv+hXHDkhuzXBdq
HYt2S0TInKanRY2cWGRvrPfh9sEWKVscGe1or9qv5g/4CWHuTp3Xve3eiEi42Cr6
5zf7HT948kqqtA7GtcB1nulzqAe3hzvzmpYeTVhMmwGXR7IAKgfIVaFeQx3/V9jh
Cxn0mMAUiMD/boKSYtSPO3xKca8EKUehpgbSV6JWj0UdfQLUjYFv38nA9YiUM3/E
QmL8RF6J0dhJowxpYec2RA+shBz0SYXfpV2sUGTwG0Z/m/PyU4PEApi2XxhkyXE3
boNQQ3tTDt6V+Qp3Rdnj/9fbtby2zdI4nyl42EONX1r6w2npE5AFlQAWRwE5VV5z
m/ZMRMcJ17vMZdM2WyxyqXc7NKfnRDbCOCZzup5IMdVOwFzKorxoGyVyg+ywWTn/
SjvnDj42KeIN0wI9+lgo2wmkpmNO8p8rmlbVBw5mcbLxYelYYwKYAvriZMR69G7g
uJmN5qJzQtW4lY+YglQzAP7MhalrS0ojqgAf/RojBCtGmHxuTX4=
=lVob
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
