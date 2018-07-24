Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B66BC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9953920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9953920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbeGYBAQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:00:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40162 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388487AbeGYBAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:00:15 -0400
Received: from localhost (unknown [172.58.43.160])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DBB29108A924D;
        Tue, 24 Jul 2018 16:51:16 -0700 (PDT)
Date:   Tue, 24 Jul 2018 16:51:13 -0700 (PDT)
Message-Id: <20180724.165113.715069335839134652.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 24 Jul 2018 16:51:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Handle stations tiest to AP_VLANs properly during mac80211 hw
   reconfig.  From Manikanta Pubbisetty.

2) Fix jump stack depth validation in nf_tables, from Taehee Yoo.

3) Fix quota handling in aRFS flow expiration of mlx5 driver, from
   Eran Ben Elisha.

4) Exit path handling fix in powerpc64 BPF JIT, from Daniel Borkmann.

5) Use ptr_ring_consume_bh() in page pool code, from Tariq Toukan.

6) Fix cached netdev name leak in nf_tables, from Florian Westphal.

7) Fix memory leaks on chain rename, also from Florian Westphal.

8) Several fixes to DCTCP congestion control ACK handling, from
   Yuchunk Cheng.

9) Missing rcu_read_unlock() in CAIF protocol code, from Yue Haibing.

10) Fix link local address handling with VRF, from David Ahern.

11) Don't clobber 'err' on a successful call to __skb_linearize()
    in skb_segment().  From Eric Dumazet.

12) Fix vxlan fdb notification races, from Roopa Prabhu.

13) Hash UDP framgnets consistently, from Paolo Abeni.

14) If TCP receives lots of out of order tiny packets, we do really
    silly stuff.  Make the out-of-order queue ending more robust to
    this kind of behavior, from Eric Dumazet.

15) Don't leak netlink dump state in nf_tables, from Florian Westphal.

Please pull, thanks a lot!

The following changes since commit f39f28ff82c14b4f628973d9bba835195a71d437:

  Merge tag 'sound-4.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2018-07-19 07:43:17 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 03bc7cab7d7218088412a75e141696a89059ab00:

  net: axienet: Fix double deregister of mdio (2018-07-24 16:38:01 -0700)

----------------------------------------------------------------
Aleksander Morgado (1):
      qmi_wwan: fix interface number for DW5821e production firmware

Alexei Starovoitov (1):
      Merge branch 'ppc-fix'

Amar Singhal (1):
      cfg80211: never ignore user regulatory hint

Anssi Hannula (7):
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix recovery from error states not being propagated
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting
      can: xilinx_can: fix RX overflow interrupt not being enabled
      can: xilinx_can: fix incorrect clear of non-processed interrupts
      can: xilinx_can: fix power management handling

Ariel Levkovich (1):
      net/mlx5: Adjust clock overflow work period

Bernd Edlinger (1):
      nl80211: Add a missing break in parse_station_flags

Daniel Borkmann (3):
      bpf, ppc64: fix unexpected r0=0 exit path inside bpf_xadd
      bpf: test case to check whether src/dst regs got mangled by xadd
      sock: fix sg page frag coalescing in sk_alloc_sg

David Ahern (1):
      net/ipv6: Fix linklocal to global address with VRF

David S. Miller (9):
      Merge branch 'tcp-fix-DCTCP-ECE-Ack-series'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge tag 'mlx5-fixes-2018-07-18' of git://git.kernel.org/.../saeed/linux
      Merge branch 'qed-Fix-series-II'
      Merge branch 'vxlan-fix-default-fdb-entry-user-space-notify-ordering-race'
      Merge tag 'linux-can-fixes-for-4.18-20180723' of ssh://gitolite.kernel.org/.../mkl/linux-can
      Merge branch 'tcp-robust-ooo'
      Merge tag 'mac80211-for-davem-2018-07-24' of git://git.kernel.org/.../jberg/mac80211
      Merge git://git.kernel.org/.../pablo/nf

Denis Kenzior (1):
      nl80211/mac80211: allow non-linear skb in rx_control_port

Doron Roberts-Kedes (1):
      tls: check RCV_SHUTDOWN in tls_wait_data

Eran Ben Elisha (2):
      net/mlx5e: Fix quota counting in aRFS expire flow
      net/mlx5e: Don't allow aRFS for encapsulated packets

Eric Dumazet (6):
      net: skb_segment() should not return NULL
      tcp: free batches of packets in tcp_prune_ofo_queue()
      tcp: avoid collapses in tcp_prune_queue() if possible
      tcp: detect malicious patterns in tcp_collapse_ofo_queue()
      tcp: call tcp_drop() from tcp_data_queue_ofo()
      tcp: add tcp_ooo_try_coalesce() helper

Faiz Abbas (2):
      can: m_can: Fix runtime resume call
      can: m_can: Move accessing of message ram to after clocks are enabled

Florian Westphal (7):
      netfilter: nf_tables: use dev->name directly
      netfilter: nf_tables: free flow table struct too
      netfilter: nf_tables: fix memory leaks on chain rename
      netfilter: nf_tables: don't allow to rename to already-pending name
      netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior state
      atl1c: reserve min skb headroom
      netfilter: nf_tables: move dumper state allocation into ->start

Hangbin Liu (1):
      multicast: do not restore deleted record source filter mode to new one

Heiner Kallweit (2):
      net: phy: consider PHY_IGNORE_INTERRUPT in phy_start_aneg_priv
      r8169: restore previous behavior to accept BIOS WoL settings

Jack Morgenstein (1):
      net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapper

Jarod Wilson (1):
      bonding: set default miimon value for non-arp modes if not set

John Hurley (1):
      nfp: flower: ensure dead neighbour entries are not offloaded

Martin KaFai Lau (2):
      bpf: btf: Clean up BTF_INT_BITS() in uapi btf.h
      bpf: Use option "help" in the llvm-objcopy test

Nicholas Mc Guire (1):
      can: mpc5xxx_can: check of_iomap return before use

Paolo Abeni (1):
      ip: hash fragments consistently

Raed Salem (1):
      net/mlx5: Fix 'DON'T_TRAP' functionality

Randy Dunlap (1):
      net: prevent ISA drivers from building on PPC32

Roi Dayan (1):
      net/mlx5e: Only allow offloading decap egress (egdev) flows

Roman Fietze (1):
      can: m_can.c: fix setup of CCCR register: clear CCCR NISO bit before checking can.ctrlmode

Roopa Prabhu (4):
      rtnetlink: add rtnl_link_state check in rtnl_configure_link
      vxlan: add new fdb alloc and create helpers
      vxlan: make netlink notify in vxlan_fdb_destroy optional
      vxlan: fix default fdb entry netlink notify ordering during netdev create

Saeed Mahameed (1):
      net/mlx5: E-Switch, UBSAN fix undefined behavior in mlx5_eswitch_mode

Shay Agroskin (1):
      net/mlx5e: Refine ets validation function

Shubhrajyoti Datta (1):
      net: axienet: Fix double deregister of mdio

Stephane Grosjean (1):
      can: peak_canfd: fix firmware < v3.3.0: limit allocation to 32-bit DMA addr only

Sudarsana Reddy Kalluru (4):
      qed: Fix link flap issue due to mismatching EEE capabilities.
      qed: Fix possible race for the link state value.
      qed: Correct Multicast API to reflect existence of 256 approximate buckets.
      bnx2x: Fix invalid memory access in rss hash config path.

Taehee Yoo (3):
      netfilter: nf_tables: fix jumpstack depth validation
      netfilter: nft_set_hash: add rcu_barrier() in the nft_rhash_destroy()
      netfilter: nft_set_rbtree: fix panic when destroying set by GC

Taeung Song (1):
      tools/bpftool: Fix segfault case regarding 'pin' arguments

Tariq Toukan (2):
      net/mlx5: Fix QP fragmented buffer allocation
      net/page_pool: Fix inconsistent lock state warning

Uwe Kleine-König (1):
      net: dsa: mv88e6xxx: fix races between lock and irq freeing

Wei Wang (1):
      ipv6: use fib6_info_hold_safe() when necessary

Willem de Bruijn (1):
      ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull

Yuchung Cheng (3):
      tcp: helpers to send special DCTCP ack
      tcp: do not cancel delay-AcK on DCTCP special ACK
      tcp: do not delay ACK in DCTCP upon CE status change

YueHaibing (2):
      net: caif: Add a missing rcu_read_unlock() in caif_flow_cb
      bpfilter: Fix mismatch in function argument types

Zhao Chen (1):
      net-next/hinic: fix a problem in hinic_xmit_frame()

mpubbise@codeaurora.org (1):
      mac80211: add stations tied to AP_VLANs during hw reconfig

 arch/powerpc/net/bpf_jit_comp64.c                       |  29 ++-----
 drivers/net/bonding/bond_options.c                      |  23 +++---
 drivers/net/can/m_can/m_can.c                           |  18 ++---
 drivers/net/can/mscan/mpc5xxx_can.c                     |   5 ++
 drivers/net/can/peak_canfd/peak_pciefd_main.c           |  19 +++++
 drivers/net/can/xilinx_can.c                            | 392 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 drivers/net/dsa/mv88e6xxx/chip.c                        |  21 +++--
 drivers/net/ethernet/3com/Kconfig                       |   2 +-
 drivers/net/ethernet/amd/Kconfig                        |   4 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c         |   1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c     |  13 +++-
 drivers/net/ethernet/cirrus/Kconfig                     |   1 +
 drivers/net/ethernet/huawei/hinic/hinic_tx.c            |   1 +
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c       |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c      |  17 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c         |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c       |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c       |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c     |  12 ++-
 drivers/net/ethernet/mellanox/mlx5/core/wq.c            |  34 ++++++---
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c                |  15 ++--
 drivers/net/ethernet/qlogic/qed/qed_l2.h                |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c               |  13 +++-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c             |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c                |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.h                |   7 +-
 drivers/net/ethernet/realtek/r8169.c                    |   3 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c       |   1 +
 drivers/net/phy/phy.c                                   |   2 +-
 drivers/net/usb/qmi_wwan.c                              |   2 +-
 drivers/net/vxlan.c                                     | 126 ++++++++++++++++++++----------
 include/linux/bpfilter.h                                |   6 +-
 include/linux/mlx5/driver.h                             |  18 ++++-
 include/net/cfg80211.h                                  |  12 +--
 include/net/ip6_fib.h                                   |   5 ++
 include/net/netfilter/nf_tables.h                       |   5 +-
 include/net/tcp.h                                       |   7 ++
 include/uapi/linux/btf.h                                |   2 +-
 kernel/bpf/btf.c                                        |  16 ++--
 net/caif/caif_dev.c                                     |   4 +-
 net/core/page_pool.c                                    |   2 +-
 net/core/rtnetlink.c                                    |   9 ++-
 net/core/skbuff.c                                       |  10 +--
 net/core/sock.c                                         |   6 +-
 net/ipv4/igmp.c                                         |   3 +-
 net/ipv4/ip_output.c                                    |   2 +
 net/ipv4/ip_sockglue.c                                  |   7 +-
 net/ipv4/tcp_dctcp.c                                    |  52 ++++---------
 net/ipv4/tcp_input.c                                    |  65 ++++++++++++----
 net/ipv4/tcp_output.c                                   |  32 ++++++--
 net/ipv6/addrconf.c                                     |   3 +-
 net/ipv6/datagram.c                                     |   7 +-
 net/ipv6/icmp.c                                         |   5 +-
 net/ipv6/ip6_output.c                                   |   2 +
 net/ipv6/mcast.c                                        |   3 +-
 net/ipv6/route.c                                        |  41 +++++++---
 net/ipv6/tcp_ipv6.c                                     |   6 +-
 net/mac80211/rx.c                                       |   5 +-
 net/mac80211/util.c                                     |   3 +-
 net/netfilter/nf_conntrack_proto_dccp.c                 |   8 +-
 net/netfilter/nf_tables_api.c                           | 304 ++++++++++++++++++++++++++++++++++++++++---------------------------------
 net/netfilter/nft_immediate.c                           |   3 +
 net/netfilter/nft_lookup.c                              |  13 +++-
 net/netfilter/nft_set_hash.c                            |   1 +
 net/netfilter/nft_set_rbtree.c                          |   7 +-
 net/tls/tls_sw.c                                        |   3 +
 net/wireless/nl80211.c                                  |  25 +++---
 net/wireless/reg.c                                      |  28 +------
 net/wireless/trace.h                                    |  18 +++--
 tools/bpf/bpftool/common.c                              |  11 ++-
 tools/testing/selftests/bpf/Makefile                    |   2 +-
 tools/testing/selftests/bpf/test_verifier.c             |  40 ++++++++++
 75 files changed, 1029 insertions(+), 562 deletions(-)
