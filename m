Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEDFC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D116820C0A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D116820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeHSVuU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 17:50:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33888 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeHSVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 17:50:20 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1609B1473D027;
        Sun, 19 Aug 2018 11:37:56 -0700 (PDT)
Date:   Sun, 19 Aug 2018 11:37:55 -0700 (PDT)
Message-Id: <20180819.113755.653387288670482490.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Aug 2018 11:37:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix races in IPVS, from Tan Hu.

2) Missing unbind in matchall classifier, from Hangbin Liu.

3) Missing act_ife action release, from Vlad Buslov.

4) Cure lockdep splats in ila, from Cong Wang.

5) veth queue leak on link delete, from Toshiaki Makita.

6) Disable isdn's IIOCDBGVAR ioctl, it exposes kernel addresses.
   From Kees Cook.

7) RCU usage fixup in XDP, from Tariq Toukan.

8) Two TCP ULP fixes from Daniel Borkmann.

9) r8169 needs REALTEK_PHY as a Kconfig dependency, from Heiner
   Kallweit.

10) Always take tcf_lock with BH disabled, otherwise we can deadlock
    with rate estimator code paths.  From Vlad Buslov.

11) Don't use MSI-X on RTL8106e r8169 chips, they don't resume
    properly.  From Jian-Hong Pan.

Please pull, thanks a lot!

The following changes since commit d01e12dd3f4227f1be5d7c5bffa7b8240787bec1:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal (2018-08-16 10:21:18 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to e2948e5af8eeb6c945000772b7613b0323a0a203:

  ip6_vti: fix creating fallback tunnel device for vti6 (2018-08-19 11:26:39 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'sockmap-ulp-fixes'

Arnd Bergmann (1):
      net: lan743x_ptp: convert to ktime_get_clocktai_ts64

Cong Wang (1):
      ila: make lockdep happy again

Daniel Borkmann (6):
      tcp, ulp: add alias for all ulp modules
      tcp, ulp: fix leftover icsk_ulp_ops preventing sock from reattach
      bpf, sockmap: fix leakage of smap_psock_map_entry
      bpf, sockmap: fix map elem deletion race with smap_stop_sock
      bpf, sockmap: fix sock_map_ctx_update_elem race with exist/noexist
      bpf: fix redirect to map under tail calls

David S. Miller (2):
      Merge git://git.kernel.org/.../pablo/nf
      Merge git://git.kernel.org/.../bpf/bpf

Dmitry V. Levin (1):
      netfilter: uapi: fix linux/netfilter/nf_osf.h userspace compilation errors

Fabrizio Castro (1):
      dt-bindings: net: ravb: Add support for r8a774a1 SoC

Florian Westphal (5):
      netfilter: ip6t_rpfilter: set F_IFACE for linklocal addresses
      netfilter: fix memory leaks on netlink_dump_start error
      netfilter: nf_tables: fix register ordering
      netfilter: nf_tables: don't prevent event handler from device cleanup on netns exit
      netfilter: conntrack: fix removal of conntrack entries when l4tracker is removed

Haishuang Yan (3):
      ip6_vti: simplify stats handling in vti6_xmit
      ip_vti: fix a null pointer deferrence when create vti fallback tunnel
      ip6_vti: fix creating fallback tunnel device for vti6

Hangbin Liu (1):
      cls_matchall: fix tcf_unbind_filter missing

Harsha Sharma (1):
      netfilter: nft_ct: make l3 protocol field optional for timeout object

Heiner Kallweit (1):
      r8169: add missing Kconfig dependency

Ivan Khoronzhuk (1):
      Documentation: networking: ti-cpsw: correct cbs parameters for Eth1 100Mb

Jesper Dangaard Brouer (1):
      samples/bpf: all XDP samples should unload xdp/bpf prog on SIGTERM

Jian-Hong Pan (1):
      r8169: don't use MSI-X on RTL8106e

Kees Cook (1):
      isdn: Disable IIOCDBGVAR

Lad, Prabhakar (1):
      net: dsa: add support for ksz9897 ethernet switch

Matteo Croce (2):
      jiffies: add utility function to calculate delta in ms
      ipvs: don't show negative times in ip_vs_conn

Michal Hocko (1):
      netfilter: x_tables: do not fail xt_alloc_table_info too easilly

Máté Eckl (2):
      netfilter: doc: Add nf_tables part in tproxy.txt
      netfilter: nft_tproxy: Fix missing-braces warning

Pablo Neira Ayuso (1):
      netfilter: nft_dynset: allow dynamic updates of non-anonymous set

Taehee Yoo (1):
      netfilter: nft_set: fix allocation size overflow in privsize callback.

Tan Hu (1):
      ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Tariq Toukan (1):
      net/xdp: Fix suspicious RCU usage warning

Toshiaki Makita (1):
      veth: Free queues on link delete

Vlad Buslov (2):
      net: sched: act_ife: always release ife action on init error
      net: sched: always disable bh when taking tcf_lock

Yonghong Song (2):
      bpf: fix a rcu usage warning in bpf_prog_array_copy_core()
      tools/bpf: fix bpf selftest test_cgroup_storage failure

Yuval Shaia (1):
      net/mlx5e: Delete unneeded function argument

 Documentation/devicetree/bindings/net/dsa/ksz.txt      |   4 ++-
 Documentation/devicetree/bindings/net/renesas,ravb.txt |   3 ++-
 Documentation/networking/ti-cpsw.txt                   |  11 ++++----
 Documentation/networking/tproxy.txt                    |  34 +++++++++++++++++++-----
 drivers/isdn/i4l/isdn_common.c                         |   8 +-----
 drivers/net/dsa/microchip/ksz_common.c                 |   9 +++++++
 drivers/net/dsa/microchip/ksz_spi.c                    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c     |   4 +--
 drivers/net/ethernet/microchip/lan743x_ptp.c           |   3 +--
 drivers/net/ethernet/realtek/Kconfig                   |   1 +
 drivers/net/ethernet/realtek/r8169.c                   |   9 ++++---
 drivers/net/veth.c                                     |  70 ++++++++++++++++++++++++--------------------------
 include/linux/filter.h                                 |   3 ++-
 include/linux/jiffies.h                                |   5 ++++
 include/linux/spinlock.h                               |  17 +++++++++---
 include/net/netfilter/nf_tables.h                      |   6 ++---
 include/net/tcp.h                                      |   4 +++
 include/trace/events/xdp.h                             |   5 ++--
 include/uapi/linux/netfilter/nfnetlink_osf.h           |   2 ++
 include/uapi/linux/netfilter/xt_osf.h                  |   2 --
 kernel/bpf/core.c                                      |   2 +-
 kernel/bpf/cpumap.c                                    |   2 ++
 kernel/bpf/devmap.c                                    |   1 +
 kernel/bpf/sockmap.c                                   | 120 ++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 kernel/bpf/verifier.c                                  |  21 ---------------
 kernel/bpf/xskmap.c                                    |   1 +
 lib/bucket_locks.c                                     |  11 +++++---
 net/core/filter.c                                      |  68 ++++++++++++++++++++++--------------------------
 net/core/xdp.c                                         |  14 +++-------
 net/ipv4/ip_vti.c                                      |   3 ++-
 net/ipv4/tcp_ulp.c                                     |   4 ++-
 net/ipv6/ip6_vti.c                                     |  16 ++++--------
 net/ipv6/netfilter/ip6t_rpfilter.c                     |  12 ++++++++-
 net/netfilter/ipvs/ip_vs_conn.c                        |  22 ++++++++++------
 net/netfilter/ipvs/ip_vs_core.c                        |  15 ++++++++---
 net/netfilter/nf_conntrack_netlink.c                   |  26 ++++++++++++-------
 net/netfilter/nf_conntrack_proto.c                     |  15 +++++++----
 net/netfilter/nf_tables_api.c                          |  38 +++++++++++++++++----------
 net/netfilter/nfnetlink_acct.c                         |  29 ++++++++++-----------
 net/netfilter/nft_chain_filter.c                       |  14 +++++-----
 net/netfilter/nft_ct.c                                 |   7 ++---
 net/netfilter/nft_dynset.c                             |   2 --
 net/netfilter/nft_set_bitmap.c                         |   6 ++---
 net/netfilter/nft_set_hash.c                           |   8 +++---
 net/netfilter/nft_set_rbtree.c                         |   4 +--
 net/netfilter/nft_tproxy.c                             |   4 ++-
 net/netfilter/x_tables.c                               |   7 +----
 net/sched/act_bpf.c                                    |  10 ++++----
 net/sched/act_csum.c                                   |  10 ++++----
 net/sched/act_gact.c                                   |  10 ++++----
 net/sched/act_ife.c                                    |   8 ++----
 net/sched/act_mirred.c                                 |  16 ++++++------
 net/sched/act_sample.c                                 |  25 ++++++++++--------
 net/sched/act_tunnel_key.c                             |  10 ++++----
 net/sched/act_vlan.c                                   |  10 ++++----
 net/sched/cls_matchall.c                               |   2 ++
 net/tls/tls_main.c                                     |   1 +
 samples/bpf/xdp_redirect_cpu_user.c                    |   3 ++-
 samples/bpf/xdp_rxq_info_user.c                        |   3 ++-
 tools/testing/selftests/bpf/test_cgroup_storage.c      |   1 +
 60 files changed, 430 insertions(+), 352 deletions(-)
