Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF4AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A783521722
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A783521722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeH0BVr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:21:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46292 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0BVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:21:47 -0400
Received: from localhost (unknown [70.97.65.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CD244146C88BA;
        Sun, 26 Aug 2018 14:37:59 -0700 (PDT)
Date:   Sun, 26 Aug 2018 14:37:58 -0700 (PDT)
Message-Id: <20180826.143758.2727231512605735.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 26 Aug 2018 14:38:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) ICE, E1000, IGB, IXGBE, and I40E bug fixes from the Intel folks.

2) Better fix for AB-BA deadlock in packet scheduler code, from Cong
   Wang.

3) bpf sockmap fixes (zero sized key handling, etc.) from Daniel
   Borkmann.

4) Send zero IPID in TCP resets and SYN-RECV state ACKs, to prevent
   attackers using it as a side-channel.  From Eric Dumazet.

5) Memory leak in mediatek bluetooth driver, from Gustavo A. R. Silva.

6) Hook up rt->dst.input of ipv6 anycast routes properly, from Hangbin
   Liu.

7) hns and hns3 bug fixes from Huazhong Tan.

8) Fix RIF leak in mlxsw driver, from Ido Schimmel.

9) iova range check fix in vhost, from Jason Wang.

10) Fix hang in do_tcp_sendpages() with tls, from John Fastabend.

11) More r8152 chips need to disable RX aggregation, from Kai-Heng
    Feng.

12) Memory exposure in TCA_U32_SEL handling, from Kees Cook.

13) TCP BBR congestion control fixes from Kevin Yang.

14) hv_netvsc, ignore non-PCI devices, from Stephen Hemminger.

15) qed driver fixes from Tomer Tayar.

Please pull, thanks a lot!

The following changes since commit 2ad0d52699700a91660a406a4046017a2d7f246a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-08-19 11:51:45 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 98c8f125fd8a6240ea343c1aa50a1be9047791b8:

  net: sched: Fix memory exposure from short TCA_U32_SEL (2018-08-26 14:21:50 -0700)

----------------------------------------------------------------
Ahmad Fatoum (1):
      net: macb: Fix regression breaking non-MDIO fixed-link PHYs

Anirudh Venkataramanan (5):
      ice: Fix multiple static analyser warnings
      ice: Cleanup magic number
      ice: Fix bugs in control queue processing
      ice: Fix a few null pointer dereference issues
      ice: Trivial formatting fixes

Anssi Hannula (1):
      net: macb: do not disable MDIO bus at open/close time

Arnd Bergmann (1):
      net_sched: fix unused variable warning in stmmac

Bo Chen (2):
      e1000: check on netif_running() before calling e1000_up()
      e1000: ensure to free old tx/rx rings in set_ringparam()

Brett Creeley (1):
      ice: Set VLAN flags correctly

Bruce Allan (3):
      ice: Remove unnecessary node owner check
      ice: Update to interrupts enabled in OICR
      ice: Change struct members from bool to u8

Colin Ian King (1):
      qed: fix spelling mistake "comparsion" -> "comparison"

Cong Wang (10):
      net_sched: improve and refactor tcf_action_put_many()
      net_sched: remove unnecessary ops->delete()
      net_sched: remove unused parameter for tcf_action_delete()
      net_sched: remove unused tcf_idr_check()
      net_sched: remove list_head from tc_action
      net_sched: remove unused tcfa_capab
      Revert "net: sched: act_ife: disable bh when taking ife_mod_lock"
      act_ife: move tcfa_lock down to where necessary
      act_ife: fix a potential deadlock
      addrconf: reduce unnecessary atomic allocations

Daniel Borkmann (3):
      bpf, sockmap: fix sock_hash_alloc and reject zero-sized keys
      bpf, sockmap: fix sock hash count in alloc_sock_hash_elem
      bpf: use per htab salt for bucket hash

David Ahern (1):
      net/ipv6: Put lwtstate when destroying fib6_info

David S. Miller (9):
      Merge branch 'qed-Misc-fixes-in-the-interface-with-the-MFW'
      Merge branch 'net_sched-fixes'
      Merge branch 'tcp_bbr-PROBE_RTT-minor-bug-fixes'
      Merge branch 'hns-fixes'
      Merge branch 'hns3-fixes'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth
      Merge branch '100GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch '1GbE' of git://git.kernel.org/.../jkirsher/net-queue

Eric Dumazet (1):
      ipv4: tcp: send zero IPID for RST and ACK sent in SYN-RECV and TIME-WAIT state

Geert Uytterhoeven (1):
      Revert "net: stmmac: fix build failure due to missing COMMON_CLK dependency"

Gustavo A. R. Silva (1):
      Bluetooth: mediatek: Fix memory leak

Haishuang Yan (1):
      ip6_vti: fix a null pointer deference when destroy vti6 tunnel

Hangbin Liu (1):
      net/ipv6: init ip6 anycast rt->dst.input as ip6_input

Hans de Goede (1):
      Bluetooth: Make BT_HCIUART_RTL configuration option depend on ACPI

Huazhong Tan (6):
      net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_PAGES
      net: hns: modify variable type in hns_nic_reuse_page
      net: hns: fix skb->truesize underestimation
      net: hns: use eth_get_headlen interface instead of hns_nic_get_headlen
      net: hns3: fix page_offset overflow when CONFIG_ARM64_64K_PAGES
      net: hns3: modify variable type in hns3_nic_reuse_page

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Do not leak RIFs when removing bridge

Jacob Keller (3):
      ice: Report stats for allocated queues via ethtool stats
      ice: Use order_base_2 to calculate higher power of 2
      i40e: fix condition of WARN_ONCE for stat strings

Jason Wang (1):
      vhost: correctly check the iova range when waking virtqueue

Jesse Brandeburg (1):
      ice: Fix potential return of uninitialized value

Jesus Sanchez-Palencia (1):
      igb: Use an advanced ctx descriptor for launchtime

Jia-Ju Bai (3):
      igb: Replace GFP_ATOMIC with GFP_KERNEL in igb_sw_init()
      igb: Replace mdelay() with msleep() in igb_integrated_phy_loopback()
      ixgbe: Replace GFP_ATOMIC with GFP_KERNEL

John Fastabend (2):
      tls: possible hang when do_tcp_sendpages hits sndbuf is full case
      bpf: sockmap: write_space events need to be passed to TCP handler

Kai-Heng Feng (1):
      r8152: disable RX aggregation on new Dell TB16 dock

Kees Cook (1):
      net: sched: Fix memory exposure from short TCA_U32_SEL

Kevin Yang (3):
      tcp_bbr: add bbr_check_probe_rtt_done() helper
      tcp_bbr: in restart from idle, see if we should exit PROBE_RTT
      tcp_bbr: apply PROBE_RTT cwnd cap even if acked==0

Manish Chopra (1):
      qlge: Fix netdev features configuration.

Martyna Szapar (1):
      i40e: Fix for Tx timeouts when interface is brought up if DCB is enabled

Prashant Bhole (1):
      xsk: fix return value of xdp_umem_assign_dev()

Preethi Banala (1):
      ice: Clean control queues only when they are initialized

Quentin Monnet (1):
      tools: bpftool: return from do_event_pipe() on bad arguments

Samuel Mendoza-Jonas (1):
      net/ncsi: Fixup .dumpit message flags and ID check in Netlink handler

Sebastian Basierski (1):
      ixgbe: fix driver behaviour after issuing VFLR

Stephen Hemminger (1):
      hv_netvsc: ignore devices that are not PCI

Toke Høiland-Jørgensen (1):
      sch_cake: Fix TC filter flow override and expand it to hosts as well

Tomer Tayar (4):
      qed: Wait for ready indication before rereading the shmem
      qed: Wait for MCP halt and resume commands to take place
      qed: Prevent a possible deadlock during driver load and unload
      qed: Avoid sending mailbox commands when MFW is not responsive

Tony Nguyen (1):
      ixgbe: Prevent unsupported configurations with XDP

Wolfram Sang (1):
      net: ethernet: renesas: use SPDX identifier for Renesas drivers

Yue Haibing (3):
      rhashtable: remove duplicated include from rhashtable.c
      sch_cake: Remove unused including <linux/version.h>
      rds: tcp: remove duplicated include from tcp.c

YueHaibing (1):
      ixgb: use dma_zalloc_coherent instead of allocator/memset

 drivers/bluetooth/Kconfig                                |   1 +
 drivers/bluetooth/btmtkuart.c                            |   8 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c             |   6 +--
 drivers/net/ethernet/cadence/macb_main.c                 |  36 ++++++++++------
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c     |  10 ++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c        |   5 +--
 drivers/net/ethernet/hisilicon/hns/hnae.h                |   6 +--
 drivers/net/ethernet/hisilicon/hns/hns_enet.c            | 108 ++----------------------------------------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c          |   3 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h          |   6 +--
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c         |   7 ++--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c           |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c              |  15 +++----
 drivers/net/ethernet/intel/ice/ice.h                     |  15 +++++--
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h          |  25 ++++++------
 drivers/net/ethernet/intel/ice/ice_common.c              |  30 ++++++++------
 drivers/net/ethernet/intel/ice/ice_controlq.c            |  29 +++++++++----
 drivers/net/ethernet/intel/ice/ice_ethtool.c             |  52 ++++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h          |   8 ----
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h           |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c                | 115 ++++++++++++++++++++++++++++++----------------------
 drivers/net/ethernet/intel/ice/ice_nvm.c                 |   5 +--
 drivers/net/ethernet/intel/ice/ice_sched.c               |   3 +-
 drivers/net/ethernet/intel/ice/ice_switch.c              |   4 +-
 drivers/net/ethernet/intel/ice/ice_switch.h              |   6 +--
 drivers/net/ethernet/intel/ice/ice_txrx.h                |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h                |  16 ++++----
 drivers/net/ethernet/intel/igb/igb_ethtool.c             |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c                |   7 ++--
 drivers/net/ethernet/intel/ixgb/ixgb_main.c              |   5 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c            |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c            |  36 ++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c           |  31 ++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h            |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c          |  19 ++++-----
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c           |   3 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h           |   2 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c    |   6 +--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c    |  11 +++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |  20 +++++++++
 drivers/net/ethernet/netronome/nfp/flower/action.c       |   6 +--
 drivers/net/ethernet/qlogic/qed/qed_init_ops.c           |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 drivers/net/ethernet/qlogic/qed/qed_mcp.h                |  27 ++++++++----
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h           |   2 +
 drivers/net/ethernet/qlogic/qede/qede_filter.c           |   6 +--
 drivers/net/ethernet/qlogic/qlge/qlge_main.c             |  23 ++++-------
 drivers/net/ethernet/renesas/ravb.h                      |   5 +--
 drivers/net/ethernet/renesas/ravb_main.c                 |   5 +--
 drivers/net/ethernet/renesas/sh_eth.c                    |  13 +-----
 drivers/net/ethernet/renesas/sh_eth.h                    |  13 +-----
 drivers/net/ethernet/stmicro/stmmac/Kconfig              |  10 ++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c          |   5 +--
 drivers/net/hyperv/netvsc_drv.c                          |   5 +++
 drivers/net/usb/r8152.c                                  |   4 +-
 drivers/vhost/vhost.c                                    |   2 +-
 include/net/act_api.h                                    |   7 ----
 include/net/pkt_cls.h                                    |  25 +++++++-----
 kernel/bpf/hashtab.c                                     |  23 ++++++-----
 kernel/bpf/sockmap.c                                     |  11 ++++-
 lib/rhashtable.c                                         |   1 -
 net/dsa/slave.c                                          |   4 +-
 net/ipv4/tcp_bbr.c                                       |  42 +++++++++++--------
 net/ipv4/tcp_ipv4.c                                      |   6 +++
 net/ipv6/addrconf.c                                      |   6 +--
 net/ipv6/ip6_fib.c                                       |   2 +
 net/ipv6/ip6_vti.c                                       |   3 +-
 net/ipv6/route.c                                         |   2 +-
 net/ncsi/ncsi-netlink.c                                  |   4 +-
 net/rds/tcp.c                                            |   1 -
 net/sched/act_api.c                                      |  70 ++++++++++++--------------------
 net/sched/act_bpf.c                                      |   8 ----
 net/sched/act_connmark.c                                 |   8 ----
 net/sched/act_csum.c                                     |   8 ----
 net/sched/act_gact.c                                     |   8 ----
 net/sched/act_ife.c                                      |  92 ++++++++++++++++++-----------------------
 net/sched/act_ipt.c                                      |  16 --------
 net/sched/act_mirred.c                                   |   8 ----
 net/sched/act_nat.c                                      |   8 ----
 net/sched/act_pedit.c                                    |   8 ----
 net/sched/act_police.c                                   |   8 ----
 net/sched/act_sample.c                                   |   8 ----
 net/sched/act_simple.c                                   |   8 ----
 net/sched/act_skbedit.c                                  |   8 ----
 net/sched/act_skbmod.c                                   |   8 ----
 net/sched/act_tunnel_key.c                               |   8 ----
 net/sched/act_vlan.c                                     |   8 ----
 net/sched/cls_u32.c                                      |  10 ++++-
 net/sched/sch_cake.c                                     |  24 ++++++++---
 net/tls/tls_main.c                                       |   9 +++-
 net/xdp/xdp_umem.c                                       |   4 +-
 tools/bpf/bpftool/map_perf_ring.c                        |   5 ++-
 92 files changed, 754 insertions(+), 711 deletions(-)
