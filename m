Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeC3U22 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 16:28:28 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35484 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbeC3U20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 16:28:26 -0400
Date: Fri, 30 Mar 2018 16:28:22 -0400 (EDT)
Message-Id: <20180330.162822.1497200713457706073.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2UKSZ7t019860


1) Fix RCU locking in xfrm_local_error(), from Taehee Yoo.

2) Fix return value assignments and thus error checking in
   iwl_mvm_start_ap_ibss(), from Johannes Berg.

3) Don't count header length twice in vti4, from Stefano Brivio.

4) Fix deadlock in rt6_age_examine_exception, from Eric Dumazet.

5) Fix out-of-bounds access in nf_sk_lookup_slow{v4,v6}() from
   Subash Abhinov.

6) Check nladdr size in netlink_connect(), from Alexander
   Potapenko.

7) VF representor SQ numbers are 32 not 16 bits, in mlx5 driver,
   from Or Gerlitz.

8) Out of bounds read in skb_network_protocol(), from Eric Dumazet.

9) r8169 driver sets driver data pointer after register_netdev() which
   is too late.  Fix from Heiner Kallweit.

10) Fix memory leak in mlx4 driver, from Moshe Shemesh.

11) The multi-VLAN decap fix added a regression when dealing with
    device that lack a MAC header, such as tun.  Fix from Toshiaki
    Makita.

12) Fix integer overflow in dynamic interrupt coalescing code.  From Tal
    Gilboa.

13) Use after free in vrf code, from David Ahern.

14) IPV6 route leak between VRFs fix, also from David Ahern.

Please pull, thanks a lot!

The following changes since commit f36b7534b83357cf52e747905de6d65b4f7c2512:

  Merge branch 'akpm' (patches from Andrew) (2018-03-22 18:48:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to e81b5e01c14add8395dfba7130f8829206bb507d:

  net: mvneta: fix enable of all initialized RXQs (2018-03-30 14:27:47 -0400)

----------------------------------------------------------------
Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()

Andrei Otcheretianski (2):
      iwlwifi: mvm: Increase session protection time after CS
      iwlwifi: mvm: Move unused phy's to a default channel

Avraham Stern (3):
      iwlwifi: mvm: clear tx queue id when unreserving aggregation queue
      iwlwifi: mvm: make sure internal station has a valid id
      iwlwifi: mvm: fix array out of bounds reference

Beni Lev (1):
      iwlwifi: mvm: Correctly set IGTK for AP

Colin Ian King (1):
      atm: iphase: fix spelling mistake: "Receiverd" -> "Received"

Cong Wang (1):
      llc: properly handle dev_queue_xmit() return value

Craig Dillabaugh (1):
      net sched actions: fix dumping which requires several messages to user space

Dave Watson (1):
      strparser: Fix sign of err codes

David Ahern (2):
      vrf: Fix use after free and double free in vrf_finish_output
      net/ipv6: Fix route leaking between VRFs

David Lebrun (1):
      ipv6: sr: fix seg6 encap performances with TSO enabled

David S. Miller (11):
      Merge branch 'mlxsw-GRE-mtu-changes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'wireless-drivers-for-davem-2018-03-24' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge branch 'bond-hwaddr-sync-fixes'
      Merge tag 'batadv-net-for-davem-20180326' of git://git.open-mesh.org/linux-merge
      Merge tag 'mlx5-fixes-2018-03-23' of git://git.kernel.org/.../saeed/linux
      Merge branch 'mlx4-misc-fixes-for-4.16'
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      ip_tunnel: Resolve ipsec merge conflict properly.
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'vlan-fix'

Emmanuel Grumbach (1):
      iwlwifi: mvm: set the correct tid when we flush the MCAST sta

Eran Ben Elisha (1):
      net/mlx4_en: Fix mixed PFC and Global pause user control requests

Eric Dumazet (2):
      ipv6: fix possible deadlock in rt6_age_examine_exception()
      net: fix possible out-of-bound read in skb_network_protocol()

Florian Westphal (3):
      netfilter: nf_tables: meter: pick a set backend that supports updates
      netfilter: nf_tables: permit second nat hook if colliding hook is going away
      netfilter: nf_tables: add missing netlink attrs to policies

Giuseppe Lippolis (1):
      net-usb: add qmi_wwan if on lte modem wistron neweb d18q1

Hans Wippel (1):
      net/ipv4: disable SMC TCP option with SYN Cookies

Heiner Kallweit (1):
      r8169: fix setting driver_data after register_netdev

Jakub Kicinski (2):
      tools: bpftool: don't use hex numbers in JSON output
      nfp: bpf: fix check of program max insn count

Jason Wang (3):
      vhost_net: add missing lock nesting notation
      vhost: correctly remove wait queue during poll failure
      vhost: validate log when IOTLB is enabled

Jianbo Liu (2):
      net/mlx5e: Don't override vport admin link state in switchdev mode
      net/mlx5e: Fix memory usage issues in offloading TC flows

Johannes Berg (1):
      iwlwifi: mvm: fix error checking for multi/broadcast sta

John Fastabend (1):
      net: sched, fix OOO packets with pfifo_fast

Kalle Valo (2):
      Merge tag 'iwlwifi-for-kalle-2018-03-16' of git://git.kernel.org/.../iwlwifi/iwlwifi-fixes
      Merge tag 'iwlwifi-for-kalle-2018-03-19' of git://git.kernel.org/.../iwlwifi/iwlwifi-fixes

Linus Lüssing (2):
      batman-adv: fix multicast-via-unicast transmission with AP isolation
      batman-adv: fix packet loss for broadcasted DHCP packets to a server

Luca Coelho (1):
      iwlwifi: add shared clock PHY config flag for some devices

Manish Chopra (2):
      qede: Fix barrier usage after tx doorbell write.
      qede: Do not drop rx-checksum invalidated packets.

Moshe Shemesh (2):
      net/mlx5e: Verify coalescing parameters in range
      net/mlx4_core: Fix memory leak while delete slave's resources

Or Gerlitz (3):
      net/mlx5e: Use 32 bits to store VF representor SQ number
      net/mlx5: Make eswitch support to depend on switchdev
      net/mlx5e: Avoid using the ipv6 stub in the TC offload neigh update path

Pablo Neira Ayuso (2):
      netfilter: nf_tables: cache device name in flowtable object
      netfilter: nf_tables: do not hold reference on netdevice from preparation phase

Paolo Abeni (2):
      netfilter: drop template ct when conntrack is skipped.
      ipv6: the entire IPv6 header chain must fit the first fragment

Pawel Dembicki (1):
      net: qmi_wwan: add BroadMobi BM806U 2020:2033

Petr Machata (3):
      ip_tunnel: Emit events for post-register MTU changes
      mlxsw: spectrum_router: Move mlxsw_sp_rif_ipip_lb_op()
      mlxsw: spectrum_router: Handle MTU change of GRE netdevs

Rafał Miłecki (1):
      brcmfmac: drop Inter-Access Point Protocol packets by default

Raghuram Chary J (2):
      lan78xx: Set ASD in MAC_CR when EEE is enabled.
      lan78xx: Crash in lan78xx_writ_reg (Workqueue: events lan78xx_deferred_multicast_write)

Roi Dayan (1):
      net/mlx5e: Fix traffic being dropped on VF representor

Sanjeev Gupta (1):
      Documentation/isdn: check and fix dead links ...

Sean Wang (2):
      net: dsa: mt7530: remove redundant MODULE_ALIAS entries
      net: dsa: mt7530: fix module autoloading for OF platform drivers

Shahar Klein (1):
      net/mlx5e: Sync netdev vxlan ports at open

Stefan Wahren (1):
      brcmfmac: Fix check for ISO3166 code

Stefano Brivio (6):
      vti4: Don't count header length twice on tunnel setup
      ip_tunnel: Clamp MTU to bounds on new link
      vti4: Don't override MTU passed on link creation via IFLA_MTU
      vti6: Properly adjust vti6 MTU from MTU of lower device
      vti6: Keep set MTU on link creation or change, validate it
      vti6: Fix dev->max_mtu setting

Steffen Klassert (1):
      xfrm: Fix transport mode skb control buffer usage.

Stephen Hemminger (1):
      hv_netvsc: enable multicast if necessary

Subash Abhinov Kasiviswanathan (1):
      netfilter: nf_socket: Fix out of bounds access in nf_sk_lookup_slow_v{4,6}

Taehee Yoo (1):
      xfrm: fix rcu_read_unlock usage in xfrm_local_error

Tal Gilboa (1):
      net/dim: Fix int overflow

Torsten Hilbrich (1):
      net/usb/qmi_wwan.c: Add USB id for lt4120 modem

Toshiaki Makita (2):
      net: Fix untag for vlan packets without ethernet header
      vlan: Fix vlan insertion for packets without ethernet header

Ursula Braun (1):
      net/smc: use announced length in sock_recvmsg()

Xin Long (4):
      bonding: fix the err path for dev hwaddr sync in bond_enslave
      bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
      bonding: process the err returned by dev_set_allmulti properly in bond_enslave
      team: move dev_mc_sync after master_upper_dev_link in team_port_add

Yelena Krivosheev (1):
      net: mvneta: fix enable of all initialized RXQs

 Documentation/isdn/INTERFACE.CAPI                           |   2 +-
 Documentation/isdn/README                                   |   4 ++--
 Documentation/isdn/README.FAQ                               |   4 ++--
 Documentation/isdn/README.gigaset                           |  16 ++++++++------
 drivers/atm/iphase.c                                        |   2 +-
 drivers/net/bonding/bond_main.c                             |  73 +++++++++++++++++++++++++++++++------------------------------
 drivers/net/dsa/mt7530.c                                    |   2 +-
 drivers/net/ethernet/marvell/mvneta.c                       |   1 +
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c              |  72 ++++++++++++++++++++++++++++++++++--------------------------
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c             |  33 ++++++++++++++++------------
 drivers/net/ethernet/mellanox/mlx4/en_main.c                |   4 ++--
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c       |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig             |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c        |  17 +++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           |  13 +++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c            |  34 ++++++++++++++++-------------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c             |  18 +++++++--------
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c       |  78 ++++++++++++++++++++++++++++++++++++++++++-----------------------
 drivers/net/ethernet/netronome/nfp/bpf/jit.c                |   6 ++++-
 drivers/net/ethernet/qlogic/qede/qede_fp.c                  |  20 +++++------------
 drivers/net/ethernet/realtek/r8169.c                        |   4 ++--
 drivers/net/hyperv/rndis_filter.c                           |   2 +-
 drivers/net/team/team.c                                     |  12 +++++-----
 drivers/net/usb/lan78xx.c                                   |  33 ++++++++++++++++++++++++++--
 drivers/net/usb/qmi_wwan.c                                  |   5 +++++
 drivers/net/vrf.c                                           |   5 +++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |   2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c   |   5 +++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h   |   1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c     |  57 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c               |  62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h                |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h             |   5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                 |   4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c           |   9 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                |   3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c           |  21 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                |  74 ++++++++++++++++++++++++++++----------------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c         |  15 +++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                 |  10 ++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c               |  38 ++++++++++++++++----------------
 drivers/vhost/net.c                                         |   4 ++--
 drivers/vhost/vhost.c                                       |  17 ++++++---------
 include/linux/if_vlan.h                                     |  15 +++++++++++--
 include/linux/net_dim.h                                     |   2 +-
 include/net/llc_conn.h                                      |   2 +-
 include/net/netfilter/nf_tables.h                           |   4 ++++
 include/net/sch_generic.h                                   |   1 +
 net/batman-adv/gateway_client.c                             |   5 ++++-
 net/batman-adv/multicast.c                                  |   4 ++--
 net/core/dev.c                                              |   2 +-
 net/core/skbuff.c                                           |   6 +++--
 net/ipv4/ip_tunnel.c                                        |  31 +++++++++++++++++++++-----
 net/ipv4/ip_vti.c                                           |   2 --
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c              |  14 +++++++++++-
 net/ipv4/netfilter/nf_socket_ipv4.c                         |   6 +++--
 net/ipv4/syncookies.c                                       |   2 ++
 net/ipv4/tcp_input.c                                        |   3 +++
 net/ipv6/ip6_output.c                                       |  13 +++++++----
 net/ipv6/ip6_vti.c                                          |  36 +++++++++++++++++++-----------
 net/ipv6/netfilter/nf_socket_ipv6.c                         |   6 +++--
 net/ipv6/route.c                                            |  16 +++++++++-----
 net/ipv6/seg6_iptunnel.c                                    |  16 ++++++--------
 net/ipv6/syncookies.c                                       |   2 ++
 net/llc/llc_c_ac.c                                          |  15 ++++++++-----
 net/llc/llc_conn.c                                          |  32 +++++++++++++++++++--------
 net/netfilter/nf_tables_api.c                               | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 net/netfilter/nft_set_hash.c                                |   2 +-
 net/netlink/af_netlink.c                                    |   3 +++
 net/sched/act_api.c                                         |   4 +++-
 net/sched/sch_generic.c                                     |  17 +++++++++++----
 net/smc/smc_clc.c                                           |   2 +-
 net/strparser/strparser.c                                   |   4 ++--
 net/xfrm/xfrm_input.c                                       |   6 +++++
 net/xfrm/xfrm_output.c                                      |   5 +++--
 tools/bpf/bpftool/map.c                                     |   2 +-
 76 files changed, 793 insertions(+), 384 deletions(-)
