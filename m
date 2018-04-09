Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755567AbeDICud (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:50:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:57344 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755357AbeDICub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:50:31 -0400
Date: Sun, 08 Apr 2018 22:50:30 -0400 (EDT)
Message-Id: <20180408.225030.1531175620528526172.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) The sockmap code has to free socket memory on close if
   there is corked data, from John Fastabend.

2) Tunnel names coming from userspace need to be length
   validated.  From Eric Dumazet.

3) arp_filter() has to take VRFs properly into account, from
   Miguel Fadon Perlines.

4) Fix oops in error path of tcf_bpf_init(), from Davide Caratti.

5) Missing idr_remove() in u32_delete_key(), from Cong Wang.

6) More syzbot stuff.  Several use of uninitialized value fixes all
   over, from Eric Dumazet.

7) Do not leak kernel memory to userspace in sctp, also from Eric
   Dumazet.

8) Discard frames from unused ports in DSA, from Andrew Lunn.

9) Fix DMA mapping and reset/failover problems in ibmvnic, from Thomas
   Falcon.

10) Do not access dp83640 PHY registers prematurely after reset, from
    Esben Haabendal.

Please pull, thanks a lot!

The following changes since commit 06dd3dfeea60e2a6457a6aedf97afc8e6d2ba497:

  Merge tag 'char-misc-4.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2018-04-04 20:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 76327a35caabd1a932e83d6a42b967aa08584e5d:

  dp83640: Ensure against premature access to PHY registers after reset (2018-04-08 19:58:52 -0400)

----------------------------------------------------------------
Anders Roxell (1):
      kernel/bpf/syscall: fix warning defined but not used

Andrew Lunn (1):
      net: dsa: Discard frames from unused ports

Anirudh Venkataramanan (1):
      ice: Bug fixes in ethtool code

Cong Wang (2):
      net_sched: fix a missing idr_remove() in u32_delete_key()
      tipc: use the right skb in tipc_sk_fill_sock_diag()

David S. Miller (7):
      Merge branch 'net-tunnel-name-validate'
      Merge branch 'hv_netvsc-Fix-shutdown-issues-on-older-Windows-hosts'
      Merge branch '100GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge branch 'net-fix-uninit-values-in-networking-stack'
      Merge branch 'ibmvnic-Fix-driver-reset-and-DMA-bugs'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (1):
      net/sched: fix NULL dereference in the error path of tcf_bpf_init()

Eric Dumazet (16):
      net: fool proof dev_valid_name()
      ip_tunnel: better validate user provided tunnel names
      ipv6: sit: better validate user provided tunnel names
      ip6_gre: better validate user provided tunnel names
      ip6_tunnel: better validate user provided tunnel names
      vti6: better validate user provided tunnel names
      crypto: af_alg - fix possible uninit-value in alg_bind()
      netlink: fix uninit-value in netlink_sendmsg
      net: fix rtnh_ok()
      net: initialize skb->peeked when cloning
      net: fix uninit-value in __hw_addr_add_ex()
      dccp: initialize ireq->ir_mark
      ipv4: fix uninit-value in ip_route_output_key_hash_rcu()
      soreuseport: initialise timewait reuseport field
      sctp: do not leak kernel memory to user space
      sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6

Esben Haabendal (4):
      net: phy: marvell: Enable interrupt function on LED2 pin
      net/fsl_pq_mdio: Allow explicit speficition of TBIPA address
      ARM: dts: ls1021a: Specify TBIPA register address
      dp83640: Ensure against premature access to PHY registers after reset

Jeff Barnhill (1):
      net/ipv6: Increment OUTxxx counters after netfilter hook

Jiri Pirko (1):
      devlink: convert occ_get op to separate registration

John Fastabend (2):
      bpf: sockmap, free memory on sock close with cork data
      bpf: sockmap, duplicates release calls may NULL sk_prot

Maxime Chevallier (1):
      net: mvpp2: Fix parser entry init boundary check

Miguel Fadon Perlines (1):
      arp: fix arp_filter on l3slave devices

Mohammed Gamal (4):
      hv_netvsc: Use Windows version instead of NVSP version on GPAD teardown
      hv_netvsc: Split netvsc_revoke_buf() and netvsc_teardown_gpadl()
      hv_netvsc: Ensure correct teardown message sequence order
      hv_netvsc: Pass net_device parameter to revoke and teardown functions

Nathan Fontenot (1):
      ibmvnic: Do not reset CRQ for Mobility driver resets

Szymon Janc (1):
      Bluetooth: Fix connection if directed advertising and privacy is used

Thomas Falcon (4):
      ibmvnic: Fix DMA mapping mistakes
      ibmvnic: Zero used TX descriptor counter on reset
      ibmvnic: Fix reset scheduler error handling
      ibmvnic: Fix failover case for non-redundant configuration

Wei Yongjun (1):
      ice: Fix error return code in ice_init_hw()

 Documentation/devicetree/bindings/net/fsl-tsec-phy.txt |   6 +++-
 arch/arm/boot/dts/ls1021a.dtsi                         |   3 +-
 crypto/af_alg.c                                        |   8 ++---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c           |  50 ++++++++++++++++++++----------
 drivers/net/ethernet/ibm/ibmvnic.c                     | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 drivers/net/ethernet/ibm/ibmvnic.h                     |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c            |   4 ++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c           |   4 +--
 drivers/net/ethernet/marvell/mvpp2.c                   |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c         |  24 +++------------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h         |   1 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c    |  67 +++++++++++++++++++++++-----------------
 drivers/net/hyperv/netvsc.c                            |  60 ++++++++++++++++++++++++++----------
 drivers/net/netdevsim/devlink.c                        |  65 +++++++++++++++++++--------------------
 drivers/net/phy/dp83640.c                              |  18 +++++++++++
 drivers/net/phy/marvell.c                              |  20 ++++++++++--
 include/net/bluetooth/hci_core.h                       |   2 +-
 include/net/devlink.h                                  |  40 +++++++++++++++---------
 include/net/inet_timewait_sock.h                       |   1 +
 include/net/nexthop.h                                  |   2 +-
 kernel/bpf/sockmap.c                                   |  12 ++++++--
 kernel/bpf/syscall.c                                   |  24 +++++++--------
 net/bluetooth/hci_conn.c                               |  29 +++++++++++++-----
 net/bluetooth/hci_event.c                              |  15 ++++++---
 net/bluetooth/l2cap_core.c                             |   2 +-
 net/core/dev.c                                         |   2 +-
 net/core/dev_addr_lists.c                              |   4 +--
 net/core/devlink.c                                     |  74 ++++++++++++++++++++++++++++++++++++++------
 net/core/skbuff.c                                      |   1 +
 net/dccp/ipv4.c                                        |   1 +
 net/dccp/ipv6.c                                        |   1 +
 net/dsa/dsa_priv.h                                     |   8 ++++-
 net/ipv4/arp.c                                         |   2 +-
 net/ipv4/inet_timewait_sock.c                          |   1 +
 net/ipv4/ip_tunnel.c                                   |  11 ++++---
 net/ipv4/route.c                                       |  11 ++++---
 net/ipv6/ip6_gre.c                                     |   8 +++--
 net/ipv6/ip6_output.c                                  |   7 +++--
 net/ipv6/ip6_tunnel.c                                  |  11 ++++---
 net/ipv6/ip6_vti.c                                     |   7 +++--
 net/ipv6/sit.c                                         |   8 +++--
 net/netlink/af_netlink.c                               |   2 ++
 net/sched/act_bpf.c                                    |  12 +++++---
 net/sched/cls_u32.c                                    |   1 +
 net/sctp/ipv6.c                                        |   4 ++-
 net/sctp/socket.c                                      |  13 +++++---
 net/tipc/diag.c                                        |   2 +-
 net/tipc/socket.c                                      |   6 ++--
 net/tipc/socket.h                                      |   4 +--
 49 files changed, 534 insertions(+), 273 deletions(-)
