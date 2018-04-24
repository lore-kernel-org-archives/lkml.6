Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeDXUib (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:38:31 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40112 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeDXUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:38:27 -0400
Date: Tue, 24 Apr 2018 16:38:25 -0400 (EDT)
Message-Id: <20180424.163825.2169782541915561179.davem@davemloft.net>
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


1) Fix rtnl deadlock in ipvs, from Julian Anastasov.

2) s390 qeth fixes from Julian Wiedmann (control IO completion stalls, bad MAC
   address update sequence, request side races on command IO timeouts).

3) Handle seq_file overflow properly in l2tp, from Guillaume Nault.

4) Fix VLAN priority mappings in cpsw driver, from Ivan Khoronzhuk.

5) Packet scheduler ife action fixes (malformed TLV lengths, etc.)
   from Alexander Aring.

6) Fix out of bounds access in tcp md5 option parser, from Jann Horn.

7) Missing netlink attribute policies in rtm_ipv6_policy table, from
   Eric Dumazet.

8) Missing socket address length checks in l2tp and pppoe connect,
   from Guillaume Nault.

9) Fix netconsole over team and bonding, from Xin Long.

10) Fix race with AF_PACKET socket state bitfields, from Willem de
    Bruijn.

Pulled, thanks a lot!

The following changes since commit 83beed7b2b26f232d782127792dd0cd4362fdc41:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal (2018-04-20 10:56:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to d19efb729f10339f91c35003d480dc718cae3b3c:

  Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue (2018-04-24 16:17:59 -0400)

----------------------------------------------------------------
Ahmed Abdelsalam (1):
      ipv6: sr: fix NULL pointer dereference in seg6_do_srh_encap()- v4 pkts

Alexander Aring (3):
      net: sched: ife: signal not finding metaid
      net: sched: ife: handle malformed tlv length
      net: sched: ife: check on metadata length

Anders Roxell (1):
      selftests: bpf: update .gitignore with missing generated files

Anirudh Venkataramanan (2):
      ice: Fix initialization for num_nodes_added
      ice: Fix incorrect comment for action type

Arnd Bergmann (1):
      netfilter: fix CONFIG_NF_REJECT_IPV6=m link error

Ben Shelton (1):
      ice: Do not check INTEVENT bit for OICR interrupts

Colin Ian King (1):
      ixgbevf: ensure xdp_ring resources are free'd on error exit

Cong Wang (3):
      netfilter: conntrack: silent a memory leak warning
      llc: delete timers synchronously in llc_sk_free()
      llc: fix NULL pointer deref for SOCK_ZAPPED

David S. Miller (6):
      Merge branch 's390-qeth-fixes'
      Merge branch 'net-sched-ife-malformed-ife-packet-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'amd-xgbe-fixes'
      Merge branch '1GbE' of git://git.kernel.org/.../jkirsher/net-queue

Doron Roberts-Kedes (1):
      strparser: Do not call mod_delayed_work with a timeout of LONG_MAX

Edward Cree (1):
      sfc: ARFS filter IDs

Eric Dumazet (1):
      ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Florian Fainelli (1):
      net: ethtool: Add missing kernel doc for FEC parameters

Florian Westphal (4):
      netfilter: nf_conntrack_sip: allow duplicate SDP expectations
      netfilter: ebtables: don't attempt to allocate 0-sized compat array
      netfilter: nf_tables: can't fail after linking rule into active rule list
      netfilter: nf_tables: free set name in error path

Guillaume Nault (3):
      l2tp: fix {pppol2tp, l2tp_dfs}_seq_stop() in case of seq_file overflow
      l2tp: check sockaddr length in pppol2tp_connect()
      pppoe: check sockaddr length in pppoe_connect()

Ivan Khoronzhuk (1):
      net: ethernet: ti: cpsw: fix tx vlan priority mapping

Jack Ma (1):
      netfilter: xt_connmark: Add bit mapping for bit-shift operation.

Jann Horn (2):
      bpf: sockmap remove dead check
      tcp: don't read out-of-bounds opsize

Jingju Hou (1):
      net: phy: marvell: clear wol event before setting it

Julian Anastasov (1):
      ipvs: fix rtnl_lock lockups caused by start_sync_thread

Julian Wiedmann (6):
      s390/qeth: fix error handling in adapter command callbacks
      s390/qeth: avoid control IO completion stalls
      s390/qeth: handle failure on workqueue creation
      s390/qeth: fix MAC address update sequence
      s390/qeth: fix request-side race during cmd IO timeout
      s390/qeth: use Read device to query hypervisor for MAC

Md Fahad Iqbal Polash (1):
      ice: Fix insufficient memory issue in ice_aq_manage_mac_read

Pablo Neira Ayuso (2):
      netfilter: nf_tables: NAT chain and extensions require NF_TABLES
      netfilter: xt_connmark: do not cast xt_connmark_tginfo1 to xt_connmark_tginfo2

Stephen Rothwell (1):
      netfilter: conntrack: include kmemleak.h for kmemleak_not_leak()

Taehee Yoo (1):
      netfilter: nf_tables: fix out-of-bounds in nft_chain_commit_update

Thomas Falcon (1):
      ibmvnic: Clean actual number of RX or TX pools

Tom Lendacky (3):
      amd-xgbe: Add pre/post auto-negotiation phy hooks
      amd-xgbe: Improve KR auto-negotiation and training
      amd-xgbe: Only use the SFP supported transceiver signals

Vinicius Costa Gomes (1):
      igb: Fix the transmission mode of queue 0 for Qav mode

Willem de Bruijn (1):
      packet: fix bitfield update race

Xin Long (2):
      bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave
      team: fix netconsole setup over team

Yonghong Song (2):
      bpf/tracing: fix a deadlock in perf_event_detach_bpf_prog
      tools/bpf: fix test_sock and test_sock_addr.sh failure

 drivers/net/bonding/bond_main.c                   |   3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h       |   8 +++++
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c      |  16 +++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-main.c         |   1 +
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c         |  24 ++++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c          |   2 ++
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c       | 196 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 drivers/net/ethernet/amd/xgbe/xgbe.h              |   9 +++++
 drivers/net/ethernet/ibm/ibmvnic.c                |   4 +--
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.c       |  22 +++++++++---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h   |   2 --
 drivers/net/ethernet/intel/ice/ice_main.c         |   4 ---
 drivers/net/ethernet/intel/ice/ice_sched.c        |   4 +--
 drivers/net/ethernet/intel/igb/igb_main.c         |  17 ++++++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   2 +-
 drivers/net/ethernet/sfc/ef10.c                   |  80 +++++++++++++++++++++++------------------
 drivers/net/ethernet/sfc/efx.c                    | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx.h                    |  21 +++++++++++
 drivers/net/ethernet/sfc/farch.c                  |  41 +++++++++++++++++----
 drivers/net/ethernet/sfc/net_driver.h             |  36 +++++++++++++++++++
 drivers/net/ethernet/sfc/rx.c                     |  62 +++++++++++++++++++++++++++++---
 drivers/net/ethernet/ti/cpsw.c                    |   2 +-
 drivers/net/phy/marvell.c                         |   9 +++++
 drivers/net/ppp/pppoe.c                           |   4 +++
 drivers/net/team/team.c                           |  19 ++++++----
 drivers/s390/net/qeth_core.h                      |   2 --
 drivers/s390/net/qeth_core_main.c                 | 158 ++++++++++++++++++++++++++++++++++++--------------------------------------------
 drivers/s390/net/qeth_core_mpc.h                  |  12 +++++++
 drivers/s390/net/qeth_l2_main.c                   |  59 ++++++++++++++++--------------
 include/linux/bpf.h                               |   4 +--
 include/linux/ethtool.h                           |   2 ++
 include/net/ife.h                                 |   3 +-
 include/net/llc_conn.h                            |   1 +
 kernel/bpf/core.c                                 |  45 ++++++++++++++---------
 kernel/bpf/sockmap.c                              |   3 --
 kernel/trace/bpf_trace.c                          |  25 ++++++++++---
 net/bridge/netfilter/ebtables.c                   |  11 +++---
 net/ife/ife.c                                     |  38 ++++++++++++++++++--
 net/ipv4/tcp_input.c                              |   7 ++--
 net/ipv6/netfilter/Kconfig                        |  55 ++++++++++++++--------------
 net/ipv6/route.c                                  |   2 ++
 net/ipv6/seg6_iptunnel.c                          |   2 +-
 net/l2tp/l2tp_debugfs.c                           |   5 ++-
 net/l2tp/l2tp_ppp.c                               |  12 ++++++-
 net/llc/af_llc.c                                  |  21 ++++++-----
 net/llc/llc_c_ac.c                                |   9 +----
 net/llc/llc_conn.c                                |  22 +++++++++++-
 net/netfilter/Kconfig                             |   1 +
 net/netfilter/ipvs/ip_vs_ctl.c                    |   8 -----
 net/netfilter/ipvs/ip_vs_sync.c                   | 155 ++++++++++++++++++++++++++++++++++++++++--------------------------------------
 net/netfilter/nf_conntrack_expect.c               |   5 ++-
 net/netfilter/nf_conntrack_extend.c               |   2 ++
 net/netfilter/nf_conntrack_sip.c                  |  16 ++++++---
 net/netfilter/nf_tables_api.c                     |  69 +++++++++++++++++++----------------
 net/netfilter/xt_connmark.c                       |  49 ++++++++++++++-----------
 net/packet/af_packet.c                            |  60 ++++++++++++++++++++++---------
 net/packet/internal.h                             |  10 +++---
 net/sched/act_ife.c                               |   9 +++--
 net/strparser/strparser.c                         |   2 +-
 tools/testing/selftests/bpf/.gitignore            |   3 ++
 tools/testing/selftests/bpf/test_sock.c           |   1 +
 tools/testing/selftests/bpf/test_sock_addr.c      |   1 +
 tools/testing/selftests/bpf/test_sock_addr.sh     |   4 +--
 64 files changed, 1163 insertions(+), 463 deletions(-)
