Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeETXau (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 19:30:50 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47098 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeETXas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 19:30:48 -0400
Date: Sun, 20 May 2018 19:30:45 -0400 (EDT)
Message-Id: <20180520.193045.579059113509503813.davem@davemloft.net>
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


Sorry, no drug fuelled pull request this time.  As for the commits
themselves, I can't say for sure.... :-)

1) Fix refcounting bug for connections in on-packet scheduling
   mode of IPVS, from Julian Anastasov.

2) Set network header properly in AF_PACKET's packet_snd, from
   Willem de Bruijn.

3) Fix regressions in 3c59x by converting to generic DMA API.
   It was relying upon the hack that the PCI DMA interfaces
   would accept NULL for EISA devices.  From Christoph
   Hellwig.

4) Remove RDMA devices before unregistering netdev in QEDE driver,
   from Michal Kalderon.

5) Use after free in TUN driver ptr_ring usage, from Jason Wang.

6) Properly check for missing netlink attributes in SMC_PNETID
   requests, from Eric Biggers.

7) Set DMA mask before performaing any DMA operations in vmxnet3
   driver, from Regis Duchesne.

8) Fix mlx5 build with SMP=n, from Saeed Mahameed.

9) Classifier fixes in bcm_sf2 driver from Florian Fainelli.

10) Tuntap use after free during release, from Jason Wang.

11) Don't use stack memory in scatterlists in tls code, from
    Matt Mullins.

12) Not fully initialized flow key object in ipv4 routing code,
    from David Ahern.

13) Various packet headroom bug fixes in ip6_gre driver, from Petr
    Machata.

14) Remove queues from XPS maps using correct index, from Amritha
    Nambiar.

15) Fix use after free in sock_diag, from Eric Dumazet.

Please pull, thanks a lot!

The following changes since commit 4bc871984f7cb5b2dec3ae64b570cb02f9ce2227:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-05-11 14:14:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to b80d0b93b991e551a32157e0d9d38fc5bc9348a7:

  net: ip6_gre: fix tunnel metadata device sharing. (2018-05-19 23:32:12 -0400)

----------------------------------------------------------------
Amritha Nambiar (1):
      net: Fix a bug in removing queues from XPS map

Christoph Hellwig (1):
      3c59x: convert to generic DMA API

Colin Ian King (1):
      netfilter: nf_tables: fix memory leak on error exit return

Daniel Borkmann (1):
      bpf: fix truncated jump targets on heavy expansions

David Ahern (1):
      net/ipv4: Initialize proto and ports in flow struct

David S. Miller (7):
      Merge git://git.kernel.org/.../pablo/nf
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'dsa-bcm_sf2-CFP-fixes'
      Merge branch 'qed-LL2-fixes'
      Merge branch 'ibmvnic-Fix-bugs-and-memory-leaks'
      Merge branch 'ip6_gre-Fixes-in-headroom-handling'
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (1):
      net/sched: fix refcnt leak in the error path of tcf_vlan_init()

Eric Biggers (1):
      net/smc: check for missing nlattrs in SMC_PNETID messages

Eric Dumazet (2):
      tcp: purge write queue in tcp_connect_init()
      sock_diag: fix use-after-free read in __sk_free

Florian Fainelli (4):
      net: dsa: bcm_sf2: Fix RX_CLS_LOC_ANY overwrite for last rule
      net: dsa: bcm_sf2: Fix IPv6 rules and chain ID
      net: dsa: bcm_sf2: Fix IPv6 rule half deletion
      net: dsa: Do not register devlink for unused ports

Florian Westphal (9):
      netfilter: x_tables: check name length in find_match/target, too
      netfilter: nf_tables: skip synchronize_rcu if transaction log is empty
      netfilter: nf_tables: nft_compat: fix refcount leak on xt module
      netfilter: core: add missing __rcu annotation
      netfilter: prefer nla_strlcpy for dealing with NLA_STRING attributes
      netfilter: x_tables: add module alias for icmp matches
      netfilter: nf_tables: don't assume chain stats are set when jumplabel is set
      netfilter: nft_compat: prepare for indirect info storage
      netfilter: nft_compat: fix handling of large matchinfo size

Geert Uytterhoeven (2):
      net: 8390: ne: Fix accidentally removed RBTX4927 support
      sh_eth: Change platform check to CONFIG_ARCH_RENESAS

Jakub Kicinski (2):
      nfp: bpf: allow zero-length capabilities
      tools: bpf: handle NULL return in bpf_prog_load_xattr()

Jason Wang (2):
      tun: fix use after free for ptr_ring
      tuntap: fix use after free during release

Jesper Dangaard Brouer (1):
      selftests/bpf: check return value of fopen in test_verifier.c

John Fastabend (2):
      bpf: sockmap update rollback on error can incorrectly dec prog refcnt
      bpf: parse and verdict prog attach may race with bpf map update

Jozsef Kadlecsik (1):
      netfilter: Fix handling simultaneous open in TCP conntrack

Julian Anastasov (2):
      ipvs: fix refcount usage for conns in ops mode
      ipvs: fix stats update from local clients

Keefe Liu (1):
      ipvlan: call netdevice notifier when master mac address changed

Kumar Sanghvi (1):
      cxgb4: Correct ntuple mask validation for hash filters

Markus Niebel (1):
      net: phy: micrel: add 125MHz reference clock workaround

Matt Mullins (1):
      tls: don't use stack memory in a scatterlist

Michal Kalderon (4):
      qede: Fix ref-cnt usage count
      qed: LL2 flush isles when connection is closed
      qed: Fix possibility of list corruption during rmmod flows
      qed: Fix LL2 race during connection terminate

Pablo Neira Ayuso (1):
      netfilter: nf_tables: bogus EBUSY in chain deletions

Paolo Abeni (1):
      net: sched: red: avoid hashing NULL child

Petr Machata (7):
      net: ip6_gre: Request headroom in __gre6_xmit()
      net: ip6_gre: Fix headroom request in ip6erspan_tunnel_xmit()
      net: ip6_gre: Split up ip6gre_tnl_link_config()
      net: ip6_gre: Split up ip6gre_tnl_change()
      net: ip6_gre: Split up ip6gre_newlink()
      net: ip6_gre: Split up ip6gre_changelink()
      net: ip6_gre: Fix ip6erspan hlen calculation

Rahul Lakkireddy (1):
      cxgb4: fix offset in collecting TX rate limit info

Saeed Mahameed (1):
      net/mlx5: Fix build break when CONFIG_SMP=n

Stephen Hemminger (1):
      netfilter: bridge: stp fix reference to uninitialized data

Tarick Bedeir (1):
      net/mlx4_core: Fix error handling in mlx4_init_port_info.

Thomas Falcon (3):
      ibmvnic: Free coherent DMA memory if FW map failed
      ibmvnic: Fix non-fatal firmware error reset
      ibmvnic: Fix statistics buffers memory leak

Willem de Bruijn (2):
      packet: in packet_snd start writing at link layer allocation
      net: test tailroom before appending to linear skb

William Tu (2):
      erspan: fix invalid erspan version.
      net: ip6_gre: fix tunnel metadata device sharing.

hpreg@vmware.com (2):
      vmxnet3: set the DMA mask before the first DMA map operation
      vmxnet3: use DMA memory barriers where required

 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt |   7 ++
 drivers/net/dsa/bcm_sf2_cfp.c                            |  36 +++++----
 drivers/net/ethernet/3com/3c59x.c                        | 104 ++++++++++++------------
 drivers/net/ethernet/8390/ne.c                           |   4 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h        |  28 +++----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c        |  88 +++++++--------------
 drivers/net/ethernet/ibm/ibmvnic.c                       |  28 ++++---
 drivers/net/ethernet/mellanox/mlx4/main.c                |   4 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c            |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                |  61 +++++++++++---
 drivers/net/ethernet/qlogic/qede/qede_main.c             |   3 +-
 drivers/net/ethernet/renesas/sh_eth.h                    |   2 +-
 drivers/net/ipvlan/ipvlan_main.c                         |   4 +-
 drivers/net/phy/micrel.c                                 |  31 ++++++++
 drivers/net/tun.c                                        |  27 +++----
 drivers/net/vmxnet3/vmxnet3_drv.c                        |  72 +++++++++++------
 drivers/net/vmxnet3/vmxnet3_int.h                        |   8 +-
 include/linux/mlx5/driver.h                              |  12 +--
 include/net/netfilter/nf_tables.h                        |   5 ++
 include/net/tls.h                                        |   3 +
 include/uapi/linux/netfilter/nf_conntrack_tcp.h          |   3 +
 kernel/bpf/core.c                                        | 100 +++++++++++++++++------
 kernel/bpf/sockmap.c                                     |  18 ++---
 net/bridge/netfilter/ebt_stp.c                           |   4 +-
 net/core/dev.c                                           |   2 +-
 net/core/filter.c                                        |  11 ++-
 net/core/sock.c                                          |   2 +-
 net/dsa/dsa2.c                                           |   9 ++-
 net/ipv4/fib_frontend.c                                  |   8 +-
 net/ipv4/ip_gre.c                                        |   4 +-
 net/ipv4/ip_output.c                                     |   3 +-
 net/ipv4/netfilter/ip_tables.c                           |   1 +
 net/ipv4/netfilter/ipt_rpfilter.c                        |   2 +-
 net/ipv4/route.c                                         |   7 +-
 net/ipv4/tcp_output.c                                    |   7 +-
 net/ipv6/ip6_gre.c                                       | 286 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 net/ipv6/ip6_output.c                                    |   3 +-
 net/ipv6/netfilter/ip6_tables.c                          |   1 +
 net/netfilter/core.c                                     |   3 +-
 net/netfilter/ipvs/ip_vs_conn.c                          |  17 ++--
 net/netfilter/ipvs/ip_vs_core.c                          |  12 +++
 net/netfilter/nf_conntrack_proto_tcp.c                   |  11 +++
 net/netfilter/nf_tables_api.c                            |  77 ++++++++++++++----
 net/netfilter/nf_tables_core.c                           |  21 +++--
 net/netfilter/nfnetlink_acct.c                           |   2 +-
 net/netfilter/nfnetlink_cthelper.c                       |   7 +-
 net/netfilter/nft_compat.c                               | 201 +++++++++++++++++++++++++++++++++++-----------
 net/netfilter/nft_immediate.c                            |  15 +++-
 net/netfilter/x_tables.c                                 |   6 ++
 net/packet/af_packet.c                                   |   4 +-
 net/sched/act_vlan.c                                     |   2 +
 net/sched/sch_red.c                                      |   5 +-
 net/sched/sch_tbf.c                                      |   5 +-
 net/smc/smc_pnet.c                                       |  71 +++++++++--------
 net/tls/tls_sw.c                                         |   9 +--
 tools/lib/bpf/libbpf.c                                   |   2 +-
 tools/testing/selftests/bpf/test_verifier.c              |   5 ++
 57 files changed, 1010 insertions(+), 465 deletions(-)
