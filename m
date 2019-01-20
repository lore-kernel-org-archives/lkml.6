Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C90C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D8F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfAUHc7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:32:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43572 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfAUHc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:32:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2F83F14C1500A;
        Sun, 20 Jan 2019 14:09:07 -0800 (PST)
Date:   Sun, 20 Jan 2019 14:09:04 -0800 (PST)
Message-Id: <20190120.140904.1469008705040899269.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 20 Jan 2019 14:09:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix endless loop in nf_tables, from Phil Sutter.

2) Fix cross namespace ip6_gre tunnel hash list corruption, from
   Olivier Matz.

3) Don't be too strict in phy_start_aneg() otherwise we might not
   allow restarting auto negotiation.  From Heiner Kallweit.

4) Fix various KMSAN uninitialized value cases in tipc, from
   Ying Xue.

5) Memory leak in act_tunnel_key, from Davide Caratti.

6) Handle chip errata of mv88e6390 PHY, from Andrew Lunn.

7) Remove linear SKB assumption in fou/fou6, from Eric Dumazet.

8) Missing udplite rehash callbacks, from Alexey Kodanev.

9) Log dirty pages properly in vhost, from Jason Wang.

10) Use consume_skb() in neigh_probe() as this is a normal free not a
    drop, from Yang Wei.  Likewise in macvlan_process_broadcast().

11) Missing device_del() in mdiobus_register() error paths, from
    Thomas Petazzoni.

12) Fix checksum handling of short packets in mlx5, from Cong Wang.

Please pull, thanks a lot!

The following changes since commit 7939f8beecf1cfb10d255be65bfbd3793fae82a1:

  Merge tag 'trace-v5.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2019-01-16 05:28:26 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to 6436408e814b81046f4595245c1f9bc4409e945c:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2019-01-19 16:38:12 -0800)

----------------------------------------------------------------
Alexey Kodanev (2):
      udp: add missing rehash callback to udplite
      udp6: add missing rehash callback to udplite

Andrew Lunn (3):
      net: phy: marvell: Errata for mv88e6390 internal PHYs
      net: phy: marvell: Fix deadlock from wrong locking
      net: phy: Add missing features to PHY drivers

Camelia Groza (2):
      net: phy: add missing phy driver features
      net: phy: phy driver features are mandatory

Colin Ian King (1):
      atm: he: fix sign-extension overflow on large shift

Cong Wang (2):
      net_sched: refetch skb protocol for each filter
      net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames

Dan Carpenter (1):
      selftests/txtimestamp: Fix an equals vs assign bug

Daniel Borkmann (2):
      bpf: pull in pkt_sched.h header for tooling to fix bpftool build
      bpf: fix inner map masking to prevent oob under speculation

David Howells (1):
      Revert "rxrpc: Allow failed client calls to be retried"

David S. Miller (6):
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'sch_cake-leaf-qdisc-fixes'
      Merge branch 'tipc-uninit-values'
      Merge branch 'mlxsw-fixes'
      Merge tag 'mlx5-fixes-2019-01-18' of git://git.kernel.org/.../saeed/linux
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (4):
      net/sched: act_tunnel_key: fix memory leak in case of action replace
      selftests: tc-testing: drop test on missing tunnel key id
      selftests: tc-testing: fix tunnel_key failure if dst_port is unspecified
      selftests: tc-testing: fix parsing of ife type

Dmitry Bezrukov (1):
      net: usb: aqc111: Extend HWID table by TRENDnet device

Eli Britstein (1):
      net/mlx5e: Fix cb_ident duplicate in indirect block register

Eric Dumazet (1):
      fou, fou6: do not assume linear skbs

Felix Manlunas (1):
      MAINTAINERS: update email addresses of liquidio driver maintainers

Greg Kroah-Hartman (1):
      IN_BADCLASS: fix macro to actually work

Hangbin Liu (1):
      ip6_gre: update version related info when changing link

Heiner Kallweit (2):
      net: phy: fix too strict check in phy_start_aneg
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ9031

Henry Yen (1):
      netfilter: nft_flow_offload: fix checking method of conntrack helper

Ido Schimmel (6):
      net: ipv4: Fix memory leak in network namespace dismantle
      mlxsw: pci: Ring CQ's doorbell before RDQ's
      net: bridge: Mark FDB entries that were added by user as such
      mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky
      selftests: mlxsw: Test FDB offload indication
      selftests: forwarding: Add a test case for externally learned FDB entries

Ivan Vecera (1):
      net/sched: cls_flower: allocate mask dynamically in fl_change()

Jakub Kicinski (2):
      ipv6: route: place a warning with duplicated string with correct extack
      Documentation: timestamping: correct path to net_tstamp.h

Jason Wang (1):
      vhost: log dirty page correctly

Jeff Kirsher (1):
      Revert "igb: reduce CPU0 latency when updating statistics"

Johan Hovold (1):
      net: dsa: realtek-smi: fix OF child-node lookup

Jonathan Neuschäfer (1):
      net: Fix typo in NET_FAILOVER help text

Konstantin Khlebnikov (1):
      net/core/neighbour: fix kmemleak minimal reference count for hash tables

Krzysztof Kazimierczak (1):
      xsk: Check if a queue exists during umem setup

Lendacky, Thomas (1):
      amd-xgbe: Fix mdio access for non-zero ports and clause 45 PHYs

Lorenz Bauer (1):
      bpf: libbpf: retry loading program on EAGAIN

Madalin Bucur (1):
      dpaa_eth: NETIF_F_LLTX requires to do our own update of trans_start

Mathieu Malaterre (3):
      bpf: Make function btf_name_offset_valid static
      bpf: Annotate implicit fall through in cgroup_dev_func_proto
      bpf: Correctly annotate implicit fall through in bpf_base_func_proto

Michael S. Tsirkin (1):
      virtio_net: bulk free tx skbs

Nathan Chancellor (1):
      isdn: avm: Fix string plus integer warning from Clang

Nicolas Dichtel (1):
      af_packet: fix raw sockets over 6in4 tunnel

Nir Dotan (3):
      mlxsw: pci: Increase PCI SW reset timeout
      mlxsw: pci: Return error on PCI reset timeout
      mlxsw: spectrum_fid: Update dummy FID index

Olivier Matz (1):
      ip6_gre: fix tunnel list corruption for x-netns

Otto Sabart (1):
      doc: net: fix bad references to network drivers

Pablo Neira Ayuso (1):
      netfilter: nf_tables: selective rule dump needs table to be specified

Peter Oskolkov (1):
      bpf: bpf_setsockopt: reset sock dst on SO_MARK changes

Phil Sutter (1):
      netfilter: nf_tables: Fix for endless loop when dumping ruleset

Ross Lagerwall (2):
      openvswitch: Avoid OOB read when parsing flow nlattrs
      net: Fix usage of pskb_trim_rcsum

Shakeel Butt (1):
      netfilter: ebtables: account ebt_table_info to kmemcg

Shay Agroskin (1):
      net/mlx5e: Fix wrong error code return on FEC query failure

Stanislav Fomichev (5):
      selftests/bpf: install with_tunnels.sh for test_flow_dissector.sh
      tools/bpf: properly account for libbfd variations
      bpf: don't assume build-id length is always 20 bytes
      bpf: zero out build_id for BPF_STACK_BUILD_ID_IP
      selftests/bpf: retry tests that expect build-id

Taehee Yoo (2):
      netfilter: nf_tables: fix leaking object reference count
      net: bpfilter: change section name of bpfilter UMH blob.

Tariq Toukan (1):
      net/mlx5e: Fix wrong (zero) TX drop counter indication for representor

Thomas Gleixner (1):
      tools: bpftool: Cleanup license mess

Thomas Petazzoni (1):
      net: phy: mdio_bus: add missing device_del() in mdiobus_register() error handling

Timotej Lazar (1):
      net: phy: meson-gxl: Use the genphy_soft_reset callback

Toke Høiland-Jørgensen (3):
      sched: Avoid dereferencing skb pointer after child enqueue
      sched: Fix detection of empty queues in child qdiscs
      sch_cake: Correctly update parent qlen when splitting GSO packets

Willem de Bruijn (3):
      tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state
      udp: with udp_segment release on error path
      bpf: in __bpf_redirect_no_mac pull mac only if present

Xin Long (2):
      erspan: build the header with the right proto according to erspan_ver
      sctp: allocate sctp_sockaddr_entry with kzalloc

Yang Wei (2):
      neighbour: Do not perturb drop profiles when neigh_probe
      macvlan: replace kfree_skb by consume_skb for drop profiles

Ying Xue (6):
      tipc: fix uninit-value in in tipc_conn_rcv_sub
      tipc: fix uninit-value in tipc_nl_compat_link_reset_stats
      tipc: fix uninit-value in tipc_nl_compat_bearer_enable
      tipc: fix uninit-value in tipc_nl_compat_link_set
      tipc: fix uninit-value in tipc_nl_compat_name_table_dump
      tipc: fix uninit-value in tipc_nl_compat_doit

Yonghong Song (1):
      samples/bpf: workaround clang asm goto compilation errors

Yuchung Cheng (1):
      bpf: fix SO_MAX_PACING_RATE to support TCP internal pacing

Yunjian Wang (1):
      net: bridge: Fix ethernet header pointer before check skb forwardable

wenxu (2):
      netfilter: nft_flow_offload: Fix reverse route lookup
      netfilter: nft_flow_offload: fix interaction with vrf slave device

yupeng (1):
      net: add document for several snmp counters

 Documentation/networking/index.rst                                  |   26 +-
 Documentation/networking/rxrpc.txt                                  |   45 ---
 Documentation/networking/snmp_counter.rst                           |  130 +++++++-
 Documentation/networking/timestamping.txt                           |    4 +-
 MAINTAINERS                                                         |    7 +-
 drivers/atm/he.c                                                    |    2 +-
 drivers/isdn/hardware/avm/b1.c                                      |    2 +-
 drivers/net/Kconfig                                                 |    2 +-
 drivers/net/dsa/realtek-smi.c                                       |   18 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                         |    2 -
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                            |   22 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                      |    6 +
 drivers/net/ethernet/intel/igb/igb.h                                |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c                        |    4 +-
 drivers/net/ethernet/intel/igb/igb_main.c                           |   14 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                    |   30 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                     |   13 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c                           |   16 +-
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h                        |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c                  |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c            |   12 +-
 drivers/net/macvlan.c                                               |    2 +-
 drivers/net/phy/bcm87xx.c                                           |    2 +
 drivers/net/phy/cortina.c                                           |    1 +
 drivers/net/phy/marvell.c                                           |   37 ++-
 drivers/net/phy/mdio_bus.c                                          |    1 +
 drivers/net/phy/meson-gxl.c                                         |    1 +
 drivers/net/phy/micrel.c                                            |    2 +
 drivers/net/phy/phy.c                                               |   19 +-
 drivers/net/phy/phy_device.c                                        |   17 +
 drivers/net/phy/teranetics.c                                        |    1 +
 drivers/net/ppp/pppoe.c                                             |    1 +
 drivers/net/usb/aqc111.c                                            |   15 +
 drivers/net/usb/cdc_ether.c                                         |    8 +
 drivers/net/virtio_net.c                                            |   12 +-
 drivers/vhost/net.c                                                 |    3 +-
 drivers/vhost/vhost.c                                               |   97 +++++-
 drivers/vhost/vhost.h                                               |    3 +-
 include/linux/phy.h                                                 |    6 +-
 include/linux/skbuff.h                                              |    1 +
 include/net/af_rxrpc.h                                              |   16 -
 include/net/ip_fib.h                                                |    2 +-
 include/net/netfilter/nf_flow_table.h                               |    1 -
 include/uapi/linux/in.h                                             |    2 +-
 kernel/bpf/btf.c                                                    |    2 +-
 kernel/bpf/cgroup.c                                                 |    1 +
 kernel/bpf/map_in_map.c                                             |   17 +-
 kernel/bpf/stackmap.c                                               |    9 +-
 net/bpfilter/bpfilter_umh_blob.S                                    |    2 +-
 net/bridge/br_fdb.c                                                 |    5 +
 net/bridge/br_forward.c                                             |    9 +-
 net/bridge/br_netfilter_ipv6.c                                      |    1 +
 net/bridge/netfilter/ebtables.c                                     |    6 +-
 net/bridge/netfilter/nft_reject_bridge.c                            |    1 +
 net/core/filter.c                                                   |   32 +-
 net/core/lwt_bpf.c                                                  |    1 +
 net/core/neighbour.c                                                |    4 +-
 net/ipv4/fib_frontend.c                                             |    4 +-
 net/ipv4/fib_trie.c                                                 |   15 +-
 net/ipv4/fou.c                                                      |    9 +-
 net/ipv4/ip_gre.c                                                   |   23 +-
 net/ipv4/ip_input.c                                                 |    1 +
 net/ipv4/tcp.c                                                      |    2 +-
 net/ipv4/udp.c                                                      |   18 +-
 net/ipv4/udp_impl.h                                                 |    1 +
 net/ipv4/udplite.c                                                  |    1 +
 net/ipv6/fou6.c                                                     |    9 +-
 net/ipv6/ip6_gre.c                                                  |   14 +-
 net/ipv6/route.c                                                    |   14 +-
 net/ipv6/udp.c                                                      |   18 +-
 net/ipv6/udp_impl.h                                                 |    1 +
 net/ipv6/udplite.c                                                  |    1 +
 net/netfilter/nf_flow_table_core.c                                  |    5 +-
 net/netfilter/nf_tables_api.c                                       |   14 +-
 net/netfilter/nft_flow_offload.c                                    |   13 +-
 net/openvswitch/flow_netlink.c                                      |    2 +-
 net/packet/af_packet.c                                              |    3 +-
 net/rxrpc/af_rxrpc.c                                                |   70 -----
 net/rxrpc/ar-internal.h                                             |   19 +-
 net/rxrpc/call_object.c                                             |   97 ------
 net/rxrpc/conn_client.c                                             |    5 +-
 net/rxrpc/sendmsg.c                                                 |   24 +-
 net/sched/act_tunnel_key.c                                          |   19 +-
 net/sched/cls_api.c                                                 |    3 +-
 net/sched/cls_flower.c                                              |   19 +-
 net/sched/sch_cake.c                                                |    5 +-
 net/sched/sch_cbs.c                                                 |    3 +-
 net/sched/sch_drr.c                                                 |    7 +-
 net/sched/sch_dsmark.c                                              |    3 +-
 net/sched/sch_hfsc.c                                                |    9 +-
 net/sched/sch_htb.c                                                 |    3 +-
 net/sched/sch_prio.c                                                |    3 +-
 net/sched/sch_qfq.c                                                 |   20 +-
 net/sched/sch_tbf.c                                                 |    3 +-
 net/sctp/ipv6.c                                                     |    5 +-
 net/sctp/protocol.c                                                 |    4 +-
 net/tipc/netlink_compat.c                                           |   50 ++-
 net/tipc/topsrv.c                                                   |    2 +-
 net/xdp/xdp_umem.c                                                  |   16 +-
 samples/bpf/Makefile                                                |    1 +
 samples/bpf/asm_goto_workaround.h                                   |   16 +
 tools/bpf/bpftool/Makefile                                          |    9 +-
 tools/bpf/bpftool/json_writer.c                                     |    7 +-
 tools/bpf/bpftool/json_writer.h                                     |    5 -
 tools/include/uapi/linux/pkt_sched.h                                | 1163 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.c                                                 |   19 +-
 tools/testing/selftests/bpf/Makefile                                |    1 +
 tools/testing/selftests/bpf/test_progs.c                            |   30 ++
 tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh              |   20 ++
 tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh         |   34 +-
 tools/testing/selftests/networking/timestamping/txtimestamp.c       |    2 +-
 tools/testing/selftests/tc-testing/tc-tests/actions/ife.json        |   88 +++---
 tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json |   31 +-
 114 files changed, 2090 insertions(+), 602 deletions(-)
 create mode 100644 samples/bpf/asm_goto_workaround.h
 create mode 100644 tools/include/uapi/linux/pkt_sched.h
