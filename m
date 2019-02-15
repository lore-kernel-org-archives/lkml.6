Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D3CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655ED21B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfBOCBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:01:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfBOCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:01:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1486C14DA9D07;
        Thu, 14 Feb 2019 18:01:00 -0800 (PST)
Date:   Thu, 14 Feb 2019 18:00:59 -0800 (PST)
Message-Id: <20190214.180059.144820443701078080.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Feb 2019 18:01:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix MAC address setting in mac80211 pmsr code, from Johannes Berg.

2) Probe SFP modules after being attached, from Russell King.

3) Byte ordering bug in SMC rx_curs_confirmed code, from Ursula Braun.

4) Revert some r8169 changes that are causing regressions, from Heiner
   Kallweit.

5) Fix spurious connection timeouts in netfilter nat code, from
   Florian Westphal.

6) SKB leak in tipc, from Hoang Le.

7) Short packet checkum issue in mlx4, similar to a previous mlx5
   change, from Saeed Mahameed.  The issue is that whilst padding
   bytes are usually zero, it is not guarateed and the hardware
   doesn't take the padding bytes into consideration when generating
   the checksum.

8) Fix various races in cls_tcindex, from Cong Wang.

9) Need to set stream ext to NULL before freeing in SCTP code, from
   Xin Long.

10) Fix locking in phy_is_started, from Heiner Kallweit.

Please pull, thanks a lot!

The following changes since commit 27b4ad621e887ce8e5eb508a0103f13d30f6b38a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2019-02-08 11:21:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to f9bcc9f3ee4fbbe8f11dfec76745476f5780517e:

  net: ethernet: freescale: set FEC ethtool regs version (2019-02-14 12:45:35 -0500)

----------------------------------------------------------------
Andrea Claudi (1):
      ipvs: fix dependency on nf_defrag_ipv6

Arthur Kiyanovski (2):
      net: ena: fix race between link up and device initalization
      net: ena: update driver version from 2.0.2 to 2.0.3

Aviya Erenfeld (1):
      nl80211: Fix FTM per burst maximum value

Bert Kenward (1):
      sfc: initialise found bitmap in efx_ef10_mtd_probe

Cong Wang (4):
      net_sched: fix a race condition in tcindex_destroy()
      net_sched: fix a memory leak in cls_tcindex
      net_sched: fix two more memory leaks in cls_tcindex
      team: avoid complex list operations in team_nl_cmd_options_set()

Dan Carpenter (1):
      net: dsa: bcm_sf2: potential array overflow in bcm_sf2_sw_suspend()

David S. Miller (8):
      Merge branch 'r8169-revert-two-commits-due-to-a-regression'
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'mac80211-for-davem-2019-02-12' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'ena-races'
      Merge branch 'net_sched-some-fixes-for-cls_tcindex'
      Merge tag 'mlx5-fixes-2019-02-13' of git://git.kernel.org/.../saeed/linux
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'net-phy-fix-locking-issue'

Deepa Dinamani (1):
      selftests: fix timestamping Makefile

Eric Dumazet (4):
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      net/x25: do not hold the cpu too long in x25_new_lci()
      batman-adv: fix uninit-value in batadv_interface_tx()
      net: fix possible overflow in __sk_mem_raise_allocated()

Florian Westphal (1):
      netfilter: nat: fix spurious connection timeouts

Francesco Ruggeri (1):
      netfilter: compat: initialize all fields in xt_init

Heiner Kallweit (5):
      Revert "r8169: remove unneeded mmiowb barriers"
      Revert "r8169: make use of xmit_more and __netdev_sent_queue"
      net: phy: fix interrupt handling in non-started states
      net: phy: don't use locking in phy_is_started
      net: phy: fix potential race in the phylib state machine

Hoang Le (1):
      tipc: fix skb may be leaky in tipc_link_input

Huang Zijiang (1):
      net: hns: Fix object reference leaks in hns_dsaf_roce_reset()

Huy Nguyen (1):
      net/mlx5: No command allowed when command interface is not ready

Ilan Peer (1):
      mac80211: Fix Tx aggregation session tear down with ITXQs

Jann Horn (2):
      netfilter: nf_nat_snmp_basic: add missing length checks in ASN.1 cbs
      mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs

Johannes Berg (5):
      cfg80211: pmsr: fix MAC address setting
      cfg80211: pmsr: fix abort locking
      mac80211: call drv_ibss_join() on restart
      cfg80211: pmsr: record netlink port ID
      cfg80211: prevent speculation on cfg80211_classify8021d() return

John David Anglin (1):
      dsa: mv88e6xxx: Ensure all pending interrupts are handled prior to exit

Jouke Witteveen (1):
      Documentation: bring operstate documentation up-to-date

Kal Conley (1):
      net/packet: fix 4gb buffer limit due to overflow check

Konstantin Khlebnikov (1):
      inet_diag: fix reporting cgroup classid and fallback to priority

Li RongQing (1):
      ipv6: propagate genlmsg_reply return code

Lorenzo Bianconi (1):
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Maria Pasechnik (1):
      net/mlx5e: Fix NULL pointer derefernce in set channels error flow

Matteo Croce (1):
      geneve: change NET_UDP_TUNNEL dependency to select

Pablo Neira Ayuso (1):
      netfilter: nft_compat: use-after-free when deleting targets

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time

Russell King (2):
      net: sfp: do not probe SFP module before we're attached
      net: phylink: avoid resolving link state too early

Saeed Mahameed (2):
      net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames
      net/mlx5e: XDP, fix redirect resources availability check

Tariq Toukan (1):
      net/mlx5: Fix a compilation warning in events.c

Tuong Lien (1):
      tipc: fix link session and re-establish issues

Ursula Braun (1):
      net/smc: fix byte_order for rx_curs_confirmed

Vivien Didelot (1):
      net: ethernet: freescale: set FEC ethtool regs version

Xin Long (2):
      sctp: call gso_reset_checksum when computing checksum in sctp_gso_segment
      sctp: set stream ext to NULL after freeing it in sctp_stream_outq_migrate

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue

 Documentation/networking/operstates.txt                  | 14 ++++++++------
 drivers/net/Kconfig                                      |  4 ++--
 drivers/net/dsa/bcm_sf2.c                                |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                         | 28 ++++++++++++++++++++++------
 drivers/net/ethernet/amazon/ena/ena_netdev.c             | 10 +++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.h             |  2 +-
 drivers/net/ethernet/freescale/fec_main.c                |  4 ++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c       |  2 ++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c               | 22 ++++++++++++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c            | 18 ++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h             |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c         |  6 ++----
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h         | 17 +++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c     |  7 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/events.c         | 17 +++++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/health.c         |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h      |  1 +
 drivers/net/ethernet/realtek/r8169.c                     | 21 ++++++++++++++-------
 drivers/net/ethernet/sfc/ef10.c                          |  2 +-
 drivers/net/phy/phy.c                                    | 16 +++++++---------
 drivers/net/phy/phylink.c                                | 19 +++++++++++++------
 drivers/net/phy/sfp-bus.c                                |  2 ++
 drivers/net/phy/sfp.c                                    | 30 +++++++++++++++++++++---------
 drivers/net/phy/sfp.h                                    |  2 ++
 drivers/net/team/team.c                                  | 27 +++++----------------------
 drivers/net/vxlan.c                                      | 14 +++++++++++---
 include/linux/phy.h                                      | 15 +--------------
 include/net/inetpeer.h                                   |  1 +
 include/net/sock.h                                       |  2 +-
 include/uapi/linux/inet_diag.h                           | 16 +++++++++++-----
 mm/page_alloc.c                                          |  8 ++++----
 net/batman-adv/soft-interface.c                          |  2 ++
 net/core/sock.c                                          |  2 +-
 net/ipv4/inet_diag.c                                     | 10 +++++++++-
 net/ipv4/inetpeer.c                                      |  1 +
 net/ipv4/netfilter/nf_nat_l3proto_ipv4.c                 |  1 +
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c              |  7 ++++++-
 net/ipv4/route.c                                         |  7 +++++--
 net/ipv6/addrconf.c                                      |  3 ++-
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c                 |  1 +
 net/ipv6/seg6.c                                          |  4 +---
 net/mac80211/agg-tx.c                                    |  4 +++-
 net/mac80211/util.c                                      |  6 +++++-
 net/netfilter/ipvs/Kconfig                               |  1 +
 net/netfilter/ipvs/ip_vs_core.c                          | 10 ++++------
 net/netfilter/ipvs/ip_vs_ctl.c                           | 10 ++++++++++
 net/netfilter/nft_compat.c                               |  3 ++-
 net/netfilter/x_tables.c                                 |  2 +-
 net/packet/af_packet.c                                   |  2 +-
 net/sched/cls_tcindex.c                                  | 80 ++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
 net/sched/sch_generic.c                                  |  2 +-
 net/sctp/diag.c                                          |  1 +
 net/sctp/offload.c                                       |  1 +
 net/sctp/stream.c                                        |  4 +++-
 net/smc/smc_cdc.c                                        |  4 +---
 net/smc/smc_cdc.h                                        | 19 ++++++++++---------
 net/tipc/link.c                                          | 17 ++++++++++++++++-
 net/tipc/msg.h                                           | 22 ++++++++++++++++++++++
 net/tipc/node.c                                          | 11 ++++++-----
 net/vmw_vsock/vmci_transport.c                           |  4 ++++
 net/wireless/core.c                                      |  2 ++
 net/wireless/nl80211.c                                   |  2 +-
 net/wireless/pmsr.c                                      | 26 +++++++++++++++++---------
 net/wireless/util.c                                      | 35 ++++++++++++++++++++++++-----------
 net/x25/af_x25.c                                         |  6 ++----
 tools/testing/selftests/networking/timestamping/Makefile |  3 ---
 67 files changed, 429 insertions(+), 220 deletions(-)
