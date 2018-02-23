Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeBWSES (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:04:18 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:35748 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeBWSER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:04:17 -0500
Date: Fri, 23 Feb 2018 13:04:15 -0500 (EST)
Message-Id: <20180223.130415.1224168828680978056.davem@davemloft.net>
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


1) Fix TTL offset calculation in mac80211 mesh code, from Peter Oh.

2) Fix races with procfs in ipt_CLUSTERIP, from Cong Wang.

3) Memory leak fix in lpm_trie BPF map code, from Yonghong Song.

4) Need to use GFP_ATOMIC in BPF cpumap allocations, from Jason Wang.

5) Fix potential deadlocks in netfilter getsockopt() code paths, from
   Paolo Abeni.

6) Netfilter stackpointer size checks really are needed to validate
   user input, from Florian Westphal.

7) Missing timer init in x_tables, from Paolo Abeni.

8) Don't use WQ_MEM_RECLAIM in mac80211 hwsim, from Johannes Berg.

9) When an ibmvnic device is brought down then back up again, it can
   be sent queue entries from a previous session, handle this properly
   instead of crashing.  From Thomas Falcon.

10) Fix TCP checkums on LRO buffers in mlx5e, from Gal Pressman.

11) When we are dumping filters in cls_api, the output SKB is empty,
    and the filter we are dumping is too large for the space in the
    SKB, we should return -EMSGSIZE like other netlink dump operations
    do.  Otherwise userland has no signal that is needs to increase
    the size of it's read buffer.  From Roman Kapl.

12) Several XDP fixes for virtio_net, from Jesper Dangaard Brouer.

13) Module refcount leak in netlink when a dump start fails, from
    Jason A. Donenfeld.

14) Handle sub-optimal GSO sizes better in TCP BBR congestion control,
    from Eric Dumazet.

15) Releasing bpf per-cpu arraymaps can take a long time, add a
    condtional scheduling point.  From Eric Dumazet.

16) Implement retpolines for tail calls in x64 and arm64 bpf JITs.
    From Daniel Borkmann.

17) Fix page leak in gianfar driver, from Andy Spencer.

18) Missed clearing of estimator scratch buffer, from Eric Dumazet.

Please pull, thanks a lot!

The following changes since commit 79c0ef3e85c015b0921a8fd5dd539d1480e9cd6c:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-02-19 11:58:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to a5f7add332b4ea6d4b9480971b3b0f5e66466ae9:

  net_sched: gen_estimator: fix broken estimators based on percpu stats (2018-02-23 12:35:46 -0500)

----------------------------------------------------------------
Alexey Kodanev (1):
      macvlan: fix use-after-free in macvlan_common_newlink()

Anders Roxell (2):
      selftests/bpf: tcpbpf_kern: use in6_* macros from glibc
      selftests/bpf: update gitignore with test_libbpf_open

Andy Spencer (1):
      gianfar: simplify FCS handling and fix memory leak

Arnd Bergmann (3):
      cfg80211: fix cfg80211_beacon_dup
      bpf: clean up unused-variable warning
      ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Avraham Stern (1):
      cfg80211: clear wep keys after disconnection

Cong Wang (2):
      netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation
      netfilter: ipt_CLUSTERIP: fix a refcount bug in clusterip_config_find_get()

Dan Carpenter (1):
      net: aquantia: Fix error handling in aq_pci_probe()

Daniel Borkmann (5):
      bpf: fix bpf_prog_array_copy_to_user warning from perf event prog query
      Merge branch 'bpf-bpftool-json-fixes'
      bpf: fix mlock precharge on arraymaps
      bpf, x64: implement retpoline for tail call
      bpf, arm64: fix out of bounds access in tail call

Daniel Jurgens (1):
      net/mlx5: Use 128B cacheline size for 128B or larger cachelines

David Ahern (1):
      net: ipv4: Set addr_type in hash_keys for forwarded case

David Howells (1):
      rxrpc: Fix send in rxrpc_send_data_packet()

David S. Miller (6):
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'mlx5-fixes-2018-02-20' of git://git.kernel.org/.../saeed/linux
      Merge branch 'virtio_net-XDP-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge tag 'mac80211-for-davem-2018-02-22' of git://git.kernel.org/.../jberg/mac80211
      Merge git://git.kernel.org/.../bpf/bpf

Eran Ben Elisha (1):
      net/mlx5e: Verify inline header size do not exceed SKB linear size

Eric Dumazet (7):
      bpf: fix sock_map_alloc() error path
      netfilter: xt_hashlimit: fix lock imbalance
      netfilter: IDLETIMER: be syzkaller friendly
      smsc75xx: fix smsc75xx_set_features()
      tcp_bbr: better deal with suboptimal GSO
      bpf: add schedule points in percpu arrays management
      net_sched: gen_estimator: fix broken estimators based on percpu stats

Eugenia Emantayev (1):
      net/mlx5: E-Switch, Fix drop counters use before creation

Felix Fietkau (1):
      mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4

Finn Thain (1):
      net/smc9194: Remove bogus CONFIG_MAC reference

Florian Westphal (10):
      netfilter: add back stackpointer size checks
      netfilter: x_tables: remove pr_info where possible
      netfilter: x_tables: use pr ratelimiting in xt core
      netfilter: xt_CT: use pr ratelimiting
      netfilter: xt_NFQUEUE: use pr ratelimiting
      netfilter: xt_set: use pr ratelimiting
      netfilter: bridge: use pr ratelimiting
      netfilter: x_tables: rate-limit table mismatch warnings
      netfilter: x_tables: use pr ratelimiting in matches/targets
      netfilter: x_tables: use pr ratelimiting in all remaining spots

Gal Pressman (2):
      net/mlx5e: Fix TCP checksum in LRO buffers
      net/mlx5e: Specify numa node when allocating drop rq

Ilan Peer (2):
      mac80211: Do not disconnect on invalid operating class
      mac80211: Fix sending ADDBA response for an ongoing session

Inbar Karmy (1):
      net/mlx5e: Fix loopback self test when GRO is off

Jason A. Donenfeld (1):
      netlink: put module reference if dump start fails

Jason Wang (1):
      bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in __cpu_map_entry_alloc()

Jeremy Cline (1):
      tools/libbpf: Avoid possibly using uninitialized variable

Jesper Dangaard Brouer (4):
      virtio_net: disable XDP_REDIRECT in receive_mergeable() case
      virtio_net: fix XDP code path in receive_small()
      virtio_net: fix memory leak in XDP_REDIRECT
      virtio_net: fix ndo_xdp_xmit crash towards dev not ready for XDP

Johannes Berg (3):
      cfg80211: use only 1Mbps for basic rates in mesh
      mac80211_hwsim: don't use WQ_MEM_RECLAIM
      regulatory: add NUL to request alpha2

Li Zhijian (1):
      selftests/bpf/test_maps: exit child process without error in ENOMEM case

Michal Hocko (1):
      netfilter: x_tables: remove size check

Or Gerlitz (4):
      net/mlx5e: Eliminate build warnings on no previous prototype
      net/mlx5: Address static checker warnings on non-constant initializers
      net/mlx5e: Return error if prio is specified when offloading eswitch vlan push
      net/mlx5: Add header re-write to the checks for conflicting actions

Paolo Abeni (3):
      netfilter: drop outermost socket lock in getsockopt()
      netfilter: x_tables: fix missing timer initialization in xt_LED
      netfilter: nat: cope with negative port range

Peter Oh (1):
      mac80211: mesh: fix wrong mesh TTL offset calculation

Quentin Monnet (2):
      tools: bpftool: preserve JSON for batch mode when dumping insns to file
      tools: bpftool: preserve JSON output on errors on batch file parsing

Roman Kapl (1):
      net: sched: report if filter is too large to dump

Sara Sharon (2):
      mac80211: fix a possible leak of station stats
      mac80211: fix calling sleeping function in atomic context

Thomas Falcon (2):
      ibmvnic: Check for NULL skb's in NAPI poll routine
      ibmvnic: Fix early release of login buffer

Tom Lendacky (1):
      amd-xgbe: Restore PCI interrupt enablement setting on resume

Vlad Buslov (1):
      net/mlx5: Fix error handling when adding flow rules

Yonghong Song (2):
      bpf: fix memory leak in lpm_trie map_free callback function
      bpf: fix rcu lockdep warning for lpm_trie map_free callback

Zhu Lingshan (1):
      .gitignore: ignore ASN.1 auto generated files

 .gitignore                                                   |  4 ++++
 arch/arm64/net/bpf_jit_comp.c                                |  5 +++--
 arch/x86/include/asm/nospec-branch.h                         | 37 +++++++++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c                                  |  9 +++++----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c                     |  2 ++
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c         | 14 ++++++++++----
 drivers/net/ethernet/freescale/gianfar.c                     | 23 +++++++----------------
 drivers/net/ethernet/ibm/ibmvnic.c                           |  7 ++++++-
 drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.c |  8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c            | 14 ++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c              | 49 +++++++++++++++++++++++++++++++++++--------------
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c        |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c              |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c              |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c            |  8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c            | 13 ++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c          |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c               |  2 +-
 drivers/net/ethernet/smsc/Kconfig                            |  2 +-
 drivers/net/macvlan.c                                        |  2 +-
 drivers/net/usb/smsc75xx.c                                   |  7 ++++---
 drivers/net/virtio_net.c                                     | 58 ++++++++++++++++++++++++++++++++++------------------------
 drivers/net/wireless/mac80211_hwsim.c                        |  2 +-
 include/net/mac80211.h                                       |  2 +-
 include/net/regulatory.h                                     |  2 +-
 kernel/bpf/arraymap.c                                        | 33 ++++++++++++++++++++-------------
 kernel/bpf/core.c                                            |  2 +-
 kernel/bpf/cpumap.c                                          |  2 +-
 kernel/bpf/lpm_trie.c                                        | 14 ++++++++------
 kernel/bpf/sockmap.c                                         |  3 ++-
 kernel/trace/bpf_trace.c                                     |  2 ++
 net/bridge/netfilter/ebt_among.c                             | 10 +++++-----
 net/bridge/netfilter/ebt_limit.c                             |  4 ++--
 net/core/filter.c                                            |  6 +-----
 net/core/gen_estimator.c                                     |  1 +
 net/ipv4/ip_sockglue.c                                       |  7 +------
 net/ipv4/netfilter/arp_tables.c                              |  4 ++++
 net/ipv4/netfilter/ip_tables.c                               |  7 ++++++-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                           | 20 ++++++++++++--------
 net/ipv4/netfilter/ipt_ECN.c                                 | 12 +++++-------
 net/ipv4/netfilter/ipt_REJECT.c                              |  4 ++--
 net/ipv4/netfilter/ipt_rpfilter.c                            |  6 +++---
 net/ipv4/route.c                                             |  2 ++
 net/ipv4/tcp_output.c                                        |  9 +++++----
 net/ipv6/ipv6_sockglue.c                                     | 10 ++--------
 net/ipv6/netfilter/ip6_tables.c                              |  4 ++++
 net/ipv6/netfilter/ip6t_REJECT.c                             |  4 ++--
 net/ipv6/netfilter/ip6t_rpfilter.c                           |  6 +++---
 net/ipv6/netfilter/ip6t_srh.c                                |  6 ++++--
 net/ipv6/sit.c                                               |  2 +-
 net/mac80211/agg-rx.c                                        |  4 +---
 net/mac80211/cfg.c                                           |  2 +-
 net/mac80211/ieee80211_i.h                                   |  2 +-
 net/mac80211/mesh.c                                          | 17 ++++++-----------
 net/mac80211/spectmgmt.c                                     |  7 +++----
 net/mac80211/sta_info.c                                      |  3 ++-
 net/netfilter/nf_nat_proto_common.c                          |  7 +++++--
 net/netfilter/x_tables.c                                     | 74 ++++++++++++++++++++++++++++++++++----------------------------------------
 net/netfilter/xt_AUDIT.c                                     |  4 ++--
 net/netfilter/xt_CHECKSUM.c                                  |  8 ++++----
 net/netfilter/xt_CONNSECMARK.c                               | 10 +++++-----
 net/netfilter/xt_CT.c                                        | 25 +++++++++++++------------
 net/netfilter/xt_DSCP.c                                      |  4 +---
 net/netfilter/xt_HL.c                                        | 13 +++----------
 net/netfilter/xt_HMARK.c                                     | 27 +++++++++++++++------------
 net/netfilter/xt_IDLETIMER.c                                 |  9 ++++++---
 net/netfilter/xt_LED.c                                       | 16 +++++++---------
 net/netfilter/xt_NFQUEUE.c                                   |  8 +++++---
 net/netfilter/xt_SECMARK.c                                   | 18 ++++++++++--------
 net/netfilter/xt_TCPMSS.c                                    | 10 ++++------
 net/netfilter/xt_TPROXY.c                                    |  6 ++----
 net/netfilter/xt_addrtype.c                                  | 33 ++++++++++++++++-----------------
 net/netfilter/xt_bpf.c                                       |  4 +++-
 net/netfilter/xt_cgroup.c                                    |  8 +++++---
 net/netfilter/xt_cluster.c                                   |  8 +++-----
 net/netfilter/xt_connbytes.c                                 |  4 ++--
 net/netfilter/xt_connlabel.c                                 |  7 ++++---
 net/netfilter/xt_connmark.c                                  |  8 ++++----
 net/netfilter/xt_conntrack.c                                 |  4 ++--
 net/netfilter/xt_dscp.c                                      |  4 +---
 net/netfilter/xt_ecn.c                                       |  4 ++--
 net/netfilter/xt_hashlimit.c                                 | 26 ++++++++++++++------------
 net/netfilter/xt_helper.c                                    |  4 ++--
 net/netfilter/xt_ipcomp.c                                    |  2 +-
 net/netfilter/xt_ipvs.c                                      |  3 ++-
 net/netfilter/xt_l2tp.c                                      | 22 +++++++++++++---------
 net/netfilter/xt_limit.c                                     |  4 ++--
 net/netfilter/xt_nat.c                                       |  5 +++--
 net/netfilter/xt_nfacct.c                                    |  6 ++++--
 net/netfilter/xt_physdev.c                                   |  4 +---
 net/netfilter/xt_policy.c                                    | 23 +++++++++++++----------
 net/netfilter/xt_recent.c                                    | 14 ++++++--------
 net/netfilter/xt_set.c                                       | 50 +++++++++++++++++++++++++-------------------------
 net/netfilter/xt_socket.c                                    | 10 ++++++----
 net/netfilter/xt_state.c                                     |  4 ++--
 net/netfilter/xt_time.c                                      |  6 +++---
 net/netlink/af_netlink.c                                     |  4 +++-
 net/rxrpc/output.c                                           |  2 +-
 net/sched/cls_api.c                                          |  7 ++++++-
 net/wireless/mesh.c                                          | 25 ++++++++++++++++++++++---
 net/wireless/sme.c                                           |  2 ++
 tools/bpf/bpftool/main.c                                     |  2 +-
 tools/bpf/bpftool/prog.c                                     |  3 +++
 tools/lib/bpf/libbpf.c                                       |  5 +++--
 tools/testing/selftests/bpf/.gitignore                       |  1 +
 tools/testing/selftests/bpf/test_maps.c                      |  2 ++
 tools/testing/selftests/bpf/test_tcpbpf_kern.c               |  1 -
 tools/testing/selftests/bpf/test_verifier.c                  | 26 ++++++++++++++++++++++++++
 108 files changed, 625 insertions(+), 455 deletions(-)
