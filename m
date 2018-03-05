Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932618AbeCEDan convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 22:30:43 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:47050 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeCEDak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 22:30:40 -0500
Date: Sun, 04 Mar 2018 22:30:38 -0500 (EST)
Message-Id: <20180304.223038.900345994131797482.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Use an appropriate TSQ pacing shift in mac80211, from Toke Høiland-Jørgensen.

2) Just like ipv4's ip_route_me_harder(), we have to use skb_to_full_sk
   in ip6_route_me_harder, from Eric Dumazet.

3) Fix several shutdown races and similar other problems in l2tp, from
   James Chapman.

4) Handle missing XDP flush properly in tuntap, for real this time.
   From Jason Wang.

5) Out-of-bounds access in powerpc ebpf tailcalls, from Daniel Borkmann.

6) Fix phy_resume() locking, from Andrew Lunn.

7) IFLA_MTU values are ignored on newlink for some tunnel types, fix
   from Xin Long.

8) Revert F-RTO middle box workarounds, they only handle one dimension
   of the problem.  From Yuchung Cheng.

9) Fix socket refcounting in RDS, from Ka-Cheong Poon.

10) Don't allow ppp unit registration to an unregistered channel, from
    Guillaume Nault.

11) Various hv_netvsc fixes from Stephen Hemminger.

Please pull, thanks a lot!

The following changes since commit 9cb9c07d6b0c5fd97d83b8ab14d7e308ba4b612f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-02-23 15:14:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to a7f0fb1bfb66ded5d556d6723d691b77a7146b6f:

  Merge branch 'hv_netvsc-minor-fixes' (2018-03-04 22:18:21 -0500)

----------------------------------------------------------------
Andrew Lunn (1):
      net: phy: Restore phy_resume() locking assumption

Arkadi Sharshevsky (2):
      devlink: Compare to size_new in case of resource child validation
      devlink: Fix resource coverity errors

Arnd Bergmann (1):
      net: ipv4: avoid unused variable warning for sysctl

Bassem Boubaker (1):
      cdc_ether: flag the Cinterion PLS8 modem by gemalto as WWAN

Boris Pismenny (1):
      tls: Use correct sk->sk_prot for IPV6

Claudiu Manoil (1):
      gianfar: Fix Rx byte accounting for ndev stats

Daniel Axtens (4):
      net: rename skb_gso_validate_mtu -> skb_gso_validate_network_len
      net: sched: tbf: handle GSO_BY_FRAGS case in enqueue
      net: xfrm: use skb_gso_validate_network_len() to check gso sizes
      net: make skb_gso_*_seglen functions private

Daniel Borkmann (2):
      bpf: allow xadd only on aligned memory
      bpf, ppc64: fix out of bounds access in tail call

David S. Miller (14):
      Merge branch 'l2tp-fix-API-races-discovered-by-syzbot'
      ARM: orion5x: Revert commit 4904dbda41c8.
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth
      Merge branch 'tunnel-mtu-fixes'
      Merge branch 's390-qeth-fixes'
      Merge branch 'tcp-revert-a-F-RTO-extension-due-to-broken-middle-boxes'
      Merge branch 'net-smc-fixes'
      Merge branch 'mlxsw-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge tag 'mac80211-for-davem-2018-03-02' of git://git.kernel.org/.../jberg/mac80211
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'batadv-net-for-davem-20180302' of git://git.open-mesh.org/linux-merge
      Merge branch 'GSO_BY_FRAGS-correctness-improvements'
      Merge branch 'hv_netvsc-minor-fixes'

Davide Caratti (2):
      net/smc: fix NULL pointer dereference on sock_create_kern() error path
      tc-testing: skbmod: fix match value of ethertype

Denis Du (1):
      hdlc_ppp: carrier detect ok, don't turn off negotiation

Edward Cree (1):
      net: ethtool: don't ignore return from driver get_fecparam method

Emil Tantilov (1):
      ixgbe: fix crash in build_skb Rx code path

Eric Dumazet (4):
      netfilter: use skb_to_full_sk in ip6_route_me_harder
      test_bpf: add a schedule point
      r8152: fix tx packets accounting
      test_bpf: reduce MAX_TESTRUNS

Felix Fietkau (2):
      mac80211: drop frames with unexpected DS bits from fast-rx to slow path
      netfilter: nf_flow_table: fix checksum when handling DNAT

Florian Westphal (7):
      netfilter: ipt_CLUSTERIP: put config struct if we can't increment ct refcount
      netfilter: ipt_CLUSTERIP: put config instead of freeing it
      netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
      netfilter: bridge: ebt_among: add missing match size checks
      netfilter: ebtables: convert BUG_ONs to WARN_ONs
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
      netfilter: don't set F_IFACE on ipv6 fib lookups

Guillaume Nault (1):
      ppp: prevent unregistered channels from connecting to PPP units

Hans de Goede (1):
      Bluetooth: btusb: Use DMI matching for QCA reset_resume quirking

Ido Schimmel (3):
      bridge: Fix VLAN reference count problem
      mlxsw: spectrum: Treat IPv6 unregistered multicast as broadcast
      spectrum: Reference count VLAN entries

James Chapman (5):
      l2tp: don't use inet_shutdown on tunnel destroy
      l2tp: don't use inet_shutdown on ppp session destroy
      l2tp: fix races with tunnel socket close
      l2tp: fix race in pppol2tp_release with session object destroy
      l2tp: fix tunnel lookup use-after-free race

Jason Wang (5):
      Revert "tuntap: add missing xdp flush"
      tuntap: disable preemption during XDP processing
      tuntap: correctly add the missing XDP flush
      virtio-net: disable NAPI only when enabled during XDP set
      virtio-net: re enable XDP_REDIRECT for mergeable buffer

Jiri Pirko (2):
      mlxsw: core: Fix flex keys scratchpad offset conflict
      mlxsw: spectrum: Fix handling of resource_size_param

Joey Pabalinas (1):
      net/tcp/illinois: replace broken algorithm reference link

Jon Maloy (1):
      tipc: correct initial value for group congestion flag

Julian Anastasov (1):
      ipvs: remove IPS_NAT_MASK check to fix passive FTP

Julian Wiedmann (6):
      s390/qeth: fix overestimated count of buffer elements
      s390/qeth: fix IP removal on offline cards
      s390/qeth: fix double-free on IP add/remove race
      Revert "s390/qeth: fix using of ref counter for rxip addresses"
      s390/qeth: fix IP address lookup for L3 devices
      s390/qeth: fix IPA command submission race

Ka-Cheong Poon (1):
      rds: Incorrect reference counting in TCP socket creation

Karsten Graul (2):
      net/smc: use a constant for control message length
      net/smc: use link_id of server in confirm link reply

Matthias Schiffer (2):
      batman-adv: fix packet checksum in receive path
      batman-adv: invalidate checksum on fragment reassembly

Mike Manning (1):
      net: allow interface to be set into VRF if VLAN interface in same VRF

Pablo Neira Ayuso (3):
      netfilter: nf_tables: return EBUSY if device already belongs to flowtable
      netfilter: nf_tables: missing attribute validation in nf_tables_delflowtable()
      netfilter: nf_tables: use the right index from flowtable error path

Ramon Fried (1):
      qrtr: add MODULE_ALIAS macro to smd

Romain Naour (1):
      cfg80211: add missing dependency to CFG80211 suboptions

Sabrina Dubroca (1):
      net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Sergei Shtylyov (2):
      DT: net: renesas,ravb: document R8A77980 bindings
      sh_eth: uninline TSU register accessors

Shalom Toledo (1):
      mlxsw: spectrum_switchdev: Check success of FDB add operation

Soheil Hassas Yeganeh (1):
      tcp: purge write queue upon RST

Stefan Wahren (1):
      Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional

Stephen Hemminger (9):
      hv_netvsc: avoid retry on send during shutdown
      hv_netvsc: only wake transmit queue if link is up
      hv_netvsc: fix error unwind handling if vmbus_open fails
      hv_netvsc: cancel subchannel setup before halting device
      hv_netvsc: fix race in napi poll when rescheduling
      hv_netvsc: use napi_schedule_irqoff
      hv_netvsc: defer queue selection to VF
      hv_netvsc: filter multicast/broadcast
      hv_netvsc: propagate rx filters to VF

Stephen Suryaputra (1):
      vrf: check forwarding on the original netdevice when generating ICMP dest unreachable

Sven Eckelmann (5):
      batman-adv: Ignore invalid batadv_iv_gw during netlink send
      batman-adv: Ignore invalid batadv_v_gw during netlink send
      batman-adv: Fix netlink dumping of BLA claims
      batman-adv: Fix netlink dumping of BLA backbones
      batman-adv: Fix internal interface indices types

Taehee Yoo (1):
      netfilter: increase IPSTATS_MIB_CSUMERRORS stat

Thomas Winter (1):
      ip_tunnel: Do not use mark in skb by default

Toke Høiland-Jørgensen (1):
      mac80211: Adjust TSQ pacing shift

Xin Long (3):
      ip_gre: fix IFLA_MTU ignored on NEWLINK
      ip6_tunnel: fix IFLA_MTU ignored on NEWLINK
      sit: fix IFLA_MTU ignored on NEWLINK

Yuchung Cheng (2):
      tcp: revert F-RTO middle-box workaround
      tcp: revert F-RTO extension to detect more spurious timeouts

 Documentation/devicetree/bindings/net/renesas,ravb.txt          |   1 +
 arch/arm/mach-orion5x/Kconfig                                   |   3 --
 arch/arm/mach-orion5x/dns323-setup.c                            |  53 +++++++++++++++++++++++++++--
 arch/arm/mach-orion5x/tsx09-common.c                            |  49 ++++++++++++++++++++++++---
 arch/powerpc/net/bpf_jit_comp64.c                               |   1 +
 drivers/bluetooth/btusb.c                                       |  25 ++++++++++----
 drivers/bluetooth/hci_bcm.c                                     |   7 ++--
 drivers/net/ethernet/freescale/gianfar.c                        |   7 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                   |   8 +++++
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h        |  20 +++++------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                  |  83 ++++++++++++++++++++++++---------------------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                  |   1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c              |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c        |  29 ++++++++++++++--
 drivers/net/ethernet/renesas/sh_eth.c                           |  11 ++++++
 drivers/net/ethernet/renesas/sh_eth.h                           |  11 ------
 drivers/net/hyperv/netvsc.c                                     |  33 +++++++-----------
 drivers/net/hyperv/netvsc_drv.c                                 |  62 ++++++++++++++++++++++++++++------
 drivers/net/hyperv/rndis_filter.c                               |  23 ++++++++-----
 drivers/net/phy/phy.c                                           |   2 +-
 drivers/net/phy/phy_device.c                                    |  18 +++++++---
 drivers/net/ppp/ppp_generic.c                                   |   9 +++++
 drivers/net/tun.c                                               |  22 ++++--------
 drivers/net/usb/cdc_ether.c                                     |   6 ++++
 drivers/net/usb/r8152.c                                         |   2 +-
 drivers/net/virtio_net.c                                        |  62 +++++++++++++++++++++++++---------
 drivers/net/wan/hdlc_ppp.c                                      |   5 ++-
 drivers/s390/net/qeth_core_main.c                               |  29 +++++++++-------
 drivers/s390/net/qeth_l3.h                                      |  34 ++++++++++++++++++-
 drivers/s390/net/qeth_l3_main.c                                 | 123 +++++++++++++++++++++++++++++-------------------------------------
 include/linux/phy.h                                             |   1 +
 include/linux/skbuff.h                                          |  35 +------------------
 include/net/devlink.h                                           |  18 ++++++++--
 kernel/bpf/verifier.c                                           |  42 ++++++++++++++---------
 lib/test_bpf.c                                                  |   4 ++-
 net/batman-adv/bat_iv_ogm.c                                     |  26 ++++++++------
 net/batman-adv/bat_v.c                                          |   2 +-
 net/batman-adv/bridge_loop_avoidance.c                          |  22 +++++++-----
 net/batman-adv/fragmentation.c                                  |   3 +-
 net/batman-adv/hard-interface.c                                 |   9 +++--
 net/batman-adv/originator.c                                     |   4 +--
 net/batman-adv/originator.h                                     |   4 +--
 net/batman-adv/soft-interface.c                                 |   8 +----
 net/batman-adv/types.h                                          |  11 +++---
 net/bridge/br_netfilter_hooks.c                                 |   4 ++-
 net/bridge/br_vlan.c                                            |   2 ++
 net/bridge/netfilter/ebt_among.c                                |  21 ++++++++++--
 net/bridge/netfilter/ebtables.c                                 |  40 ++++++++++++++++------
 net/core/dev.c                                                  |  14 +++++---
 net/core/devlink.c                                              |  46 ++++++++++++++-----------
 net/core/ethtool.c                                              |   5 ++-
 net/core/skbuff.c                                               |  48 ++++++++++++++++++++++----
 net/ipv4/ip_forward.c                                           |   2 +-
 net/ipv4/ip_gre.c                                               |   5 ---
 net/ipv4/ip_output.c                                            |   2 +-
 net/ipv4/ip_tunnel.c                                            |  13 ++-----
 net/ipv4/netfilter/ipt_CLUSTERIP.c                              |  15 ++++++---
 net/ipv4/netfilter/nf_flow_table_ipv4.c                         |   3 +-
 net/ipv4/route.c                                                |  18 ++++++++--
 net/ipv4/tcp_illinois.c                                         |   2 +-
 net/ipv4/tcp_input.c                                            |  24 +++++--------
 net/ipv4/xfrm4_output.c                                         |   3 +-
 net/ipv6/ip6_output.c                                           |   2 +-
 net/ipv6/ip6_tunnel.c                                           |  12 ++++---
 net/ipv6/netfilter.c                                            |   9 ++---
 net/ipv6/netfilter/ip6t_rpfilter.c                              |   4 ---
 net/ipv6/netfilter/nf_flow_table_ipv6.c                         |   2 +-
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c                        |   4 +++
 net/ipv6/netfilter/nft_fib_ipv6.c                               |  12 ++-----
 net/ipv6/sit.c                                                  |   7 ++++
 net/ipv6/xfrm6_output.c                                         |   2 +-
 net/l2tp/l2tp_core.c                                            | 142 ++++++++++++++++++++++++-----------------------------------------------------
 net/l2tp/l2tp_core.h                                            |  23 ++-----------
 net/l2tp/l2tp_ip.c                                              |  10 ++----
 net/l2tp/l2tp_ip6.c                                             |   8 ++---
 net/l2tp/l2tp_ppp.c                                             |  60 ++++++++++++++-------------------
 net/mac80211/rx.c                                               |   2 +-
 net/mac80211/tx.c                                               |   8 +++++
 net/mpls/af_mpls.c                                              |   2 +-
 net/netfilter/ipvs/ip_vs_ftp.c                                  |   2 +-
 net/netfilter/nf_tables_api.c                                   |  25 ++++++++++++--
 net/qrtr/smd.c                                                  |   1 +
 net/rds/tcp_listen.c                                            |  14 ++++++--
 net/sched/sch_tbf.c                                             |   3 +-
 net/smc/af_smc.c                                                |   4 ++-
 net/smc/smc_cdc.c                                               |   2 +-
 net/smc/smc_core.c                                              |   3 +-
 net/smc/smc_llc.c                                               |   2 +-
 net/tipc/group.c                                                |   1 +
 net/tipc/socket.c                                               |   1 +
 net/tls/tls_main.c                                              |  52 +++++++++++++++++++---------
 net/wireless/Kconfig                                            |  13 +++----
 net/xfrm/xfrm_device.c                                          |   2 +-
 tools/testing/selftests/bpf/test_verifier.c                     |  58 ++++++++++++++++++++++++++++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/skbmod.json |   2 +-
 95 files changed, 1033 insertions(+), 658 deletions(-)
