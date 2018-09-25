Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC65C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCF820C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCF820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIYJhu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:37:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIYJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:37:50 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C1EA813FF9D20;
        Mon, 24 Sep 2018 20:32:24 -0700 (PDT)
Date:   Mon, 24 Sep 2018 20:32:24 -0700 (PDT)
Message-Id: <20180924.203224.1604558581746424370.davem@davemloft.net>
To:     gregkh@linux-foundation.org
CC:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Sep 2018 20:32:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix multiqueue handling of coalesce timer in stmmac, from Jose
   Abreu.

2) Fix memory corruption in NFC, from Suren Baghdasaryan.

3) Don't write reserved bits in ravb driver, from Kazuya Mizuguchi.

4) SMC bug fixes from Karsten Graul, YueHaibing, and Ursula Braun.

5) Fix TX done race in mvpp2, from Antoine Tenart.

6) ipv6 metrics leak, from Wei Wang.

7) Adjust firmware version requirements in mlxsw, from Petr Machata.

8) Fix autonegotiation on resume in r8169, from Heiner Kallweit.

9) Fixed missing entries when dumping /proc/net/if_inet6, from Jeff
   Barnhill.

10) Fix double free in devlink, from Dan Carpenter.

11) Fix ethtool regression from UFO feature removal, from Maciej
    ¯enczykowski.

12) Fix drivers that have a ndo_poll_controller() that captures the
    cpu entirely on loaded hosts by trying to drain all rx and tx
    queues, from Eric Dumazet.

13) Fix memory corruption with jumbo frames in aquantia driver, from
    Friedemann Gerold.

Please pull, thanks a lot!

The following changes since commit 5211da9ca526a5adddee1ccd078e6e33a583ab36:

  Merge gitolite.kernel.org:/pub/scm/linux/kernel/git/davem/net (2018-09-18 09:31:53 +0200)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to f4a518797b40e956b6e6220b42657e045dc24470:

  net: mvneta: fix the remaining Rx descriptor unmapping issues (2018-09-24 12:27:28 -0700)

----------------------------------------------------------------
Alaa Hleihel (1):
      net/mlx5: Check for SQ and not RQ state when modifying hairpin SQ

Antoine Tenart (4):
      net: mvpp2: fix a txq_done race condition
      net: mvneta: fix the Rx desc buffer DMA unmapping
      net: mscc: fix the frame extraction into the skb
      net: mvneta: fix the remaining Rx descriptor unmapping issues

Christian Lamparter (1):
      net: emac: fix fixed-link setup for the RTL8363SB switch

Dan Carpenter (1):
      devlink: double free in devlink_resource_fill()

Daniel Borkmann (1):
      Merge branch 'bpf-sockmap-estab-fixes'

David S. Miller (9):
      Merge branch 'stmmac-Coalesce-and-tail-addr-fixes'
      Merge tag 'mlx5-fixes-2018-09-17' of git://git.kernel.org/.../saeed/linux
      Merge branch 'net-smc-fixes'
      Merge branch 'ipv6-fix-issues-on-accessing-fib6_metrics'
      Merge tag 'batadv-net-for-davem-20180919' of git://git.open-mesh.org/linux-merge
      Merge branch 'qed-fixes'
      rds: Fix build regression.
      Merge branch 'netpoll-avoid-capture-effects-for-NAPI-drivers'
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (1):
      bnxt_en: don't try to offload VLAN 'modify' action

Eli Cohen (1):
      net/mlx5: Fix read from coherent memory

Eric Dumazet (15):
      netpoll: make ndo_poll_controller() optional
      bonding: use netpoll_poll_dev() helper
      ixgbe: remove ndo_poll_controller
      ixgbevf: remove ndo_poll_controller
      fm10k: remove ndo_poll_controller
      ixgb: remove ndo_poll_controller
      igb: remove ndo_poll_controller
      ice: remove ndo_poll_controller
      i40evf: remove ndo_poll_controller
      mlx4: remove ndo_poll_controller
      mlx5: remove ndo_poll_controller
      bnx2x: remove ndo_poll_controller
      bnxt: remove ndo_poll_controller
      nfp: remove ndo_poll_controller
      tun: remove ndo_poll_controller

Friedemann Gerold (1):
      net: aquantia: memory corruption on jumbo frames

Heiner Kallweit (1):
      r8169: fix autoneg issue on resume with RTL8168E

Jakub Kicinski (1):
      tools: bpf: fix license for a compat header file

Jeff Barnhill (1):
      net/ipv6: Display all addresses in output of /proc/net/if_inet6

Johannes Berg (1):
      smc: generic netlink family should be __ro_after_init

John Fastabend (3):
      bpf: sockmap only allow ESTABLISHED sock state
      bpf: sockmap, fix transition through disconnect without close
      bpf: test_maps, only support ESTABLISHED socks

Jose Abreu (2):
      net: stmmac: Rework coalesce timer and fix multi-queue races
      net: stmmac: Fixup the tail addr setting in xmit path

Karsten Graul (1):
      net/smc: no urgent data check for listen sockets

Kazuya Mizuguchi (1):
      ravb: do not write 1 to reserved bits

Maciej ¯enczykowski (1):
      net-ethtool: ETHTOOL_GUFO did not and should not require CAP_NET_ADMIN

Marek Lindner (2):
      batman-adv: fix backbone_gw refcount on queue_work() failure
      batman-adv: fix hardif_neigh refcount on queue_work() failure

Nathan Chancellor (2):
      net/mlx4: Use cpumask_available for eq->affinity_mask
      RDS: IB: Use DEFINE_PER_CPU_SHARED_ALIGNED for rds_ib_stats

Paolo Abeni (2):
      ip6_tunnel: be careful when accessing the inner header
      ip_tunnel: be careful when accessing the inner header

Petr Machata (1):
      mlxsw: spectrum: Bump required firmware version

Russell King (1):
      sfp: fix oops with ethtool -m

Sabrina Dubroca (1):
      selftests: pmtu: properly redirect stderr to /dev/null

Saeed Mahameed (1):
      net/mlx5e: TLS, Read capabilities only when it is safe

Saif Hasan (1):
      mpls: allow routes on ip6gre devices

Sean Tranchetti (1):
      netlabel: check for IPV4MASK in addrinfo_get

Sudarsana Reddy Kalluru (3):
      qed: Fix populating the invalid stag value in multi function mode.
      qed: Do not add VLAN 0 tag to untagged frames in multi-function mode.
      qed: Add missing device config for RoCE EDPM in UFP mode.

Suren Baghdasaryan (2):
      NFC: Fix possible memory corruption when handling SHDLC I-Frame commands
      NFC: Fix the number of pipes

Sven Eckelmann (9):
      batman-adv: Avoid probe ELP information leak
      batman-adv: Fix segfault when writing to throughput_override
      batman-adv: Fix segfault when writing to sysfs elp_interval
      batman-adv: Prevent duplicated gateway_node entry
      batman-adv: Prevent duplicated nc_node entry
      batman-adv: Prevent duplicated softif_vlan entry
      batman-adv: Prevent duplicated global TT entry
      batman-adv: Prevent duplicated tvlv handler
      batman-adv: Increase version number to 2018.3

Ursula Braun (3):
      net/smc: fix non-blocking connect problem
      net/smc: remove duplicate mutex_unlock
      net/smc: enable fallback for connection abort in state INIT

Wei Wang (2):
      Revert "ipv6: fix double refcount of fib6_metrics"
      ipv6: fix memory leak on dst->_metrics

Wei Yongjun (1):
      PCI: hv: Fix return value check in hv_pci_assign_slots()

Xin Long (1):
      sctp: update dst pmtu with the correct daddr

YueHaibing (7):
      net/smc: fix sizeof to int comparison
      net: seeq: fix return type of ndo_start_xmit function
      net: cirrus: fix return type of ndo_start_xmit function
      net: sgi: fix return type of ndo_start_xmit function
      net: wiznet: fix return type of ndo_start_xmit function
      net: i825xx: fix return type of ndo_start_xmit function
      net: apple: fix return type of ndo_start_xmit function

zhong jiang (1):
      net: bnxt: Fix a uninitialized variable warning.

 drivers/net/bonding/bond_main.c                        |  11 +---
 drivers/net/ethernet/apple/bmac.c                      |   4 +-
 drivers/net/ethernet/apple/mace.c                      |   4 +-
 drivers/net/ethernet/apple/macmace.c                   |   4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c       |  32 ++++++-----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c       |  16 ------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c              |  18 -------
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c      |   3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c           |  20 ++++---
 drivers/net/ethernet/cirrus/ep93xx_eth.c               |   2 +-
 drivers/net/ethernet/cirrus/mac89x0.c                  |   4 +-
 drivers/net/ethernet/i825xx/ether1.c                   |   5 +-
 drivers/net/ethernet/i825xx/lib82596.c                 |   4 +-
 drivers/net/ethernet/i825xx/sun3_82586.c               |   6 ++-
 drivers/net/ethernet/ibm/emac/core.c                   |  15 ++++--
 drivers/net/ethernet/intel/fm10k/fm10k.h               |   3 --
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c        |   3 --
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c           |  22 --------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c        |  26 ---------
 drivers/net/ethernet/intel/ice/ice_main.c              |  27 ----------
 drivers/net/ethernet/intel/igb/igb_main.c              |  30 -----------
 drivers/net/ethernet/intel/ixgb/ixgb_main.c            |  25 ---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c          |  25 ---------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c      |  21 --------
 drivers/net/ethernet/marvell/mvneta.c                  |  13 +++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c        |  10 ++--
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c         |  20 -------
 drivers/net/ethernet/mellanox/mlx4/eq.c                |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c          |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls.c |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      |  19 -------
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c     |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c         |   4 +-
 drivers/net/ethernet/mscc/ocelot_board.c               |  12 +++--
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c    |  18 -------
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c             |  45 ++++++++++------
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h             |   1 +
 drivers/net/ethernet/qlogic/qed/qed_dev.c              |  15 +++++-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h              |   4 ++
 drivers/net/ethernet/qlogic/qed/qed_mcp.c              |  24 +++++++--
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h         |   6 +++
 drivers/net/ethernet/realtek/r8169.c                   |   9 ++++
 drivers/net/ethernet/renesas/ravb.h                    |   5 ++
 drivers/net/ethernet/renesas/ravb_main.c               |  11 ++--
 drivers/net/ethernet/renesas/ravb_ptp.c                |   2 +-
 drivers/net/ethernet/seeq/ether3.c                     |   5 +-
 drivers/net/ethernet/seeq/sgiseeq.c                    |   3 +-
 drivers/net/ethernet/sgi/ioc3-eth.c                    |   4 +-
 drivers/net/ethernet/sgi/meth.c                        |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h           |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h           |  14 ++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      | 238 ++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 drivers/net/ethernet/wiznet/w5100.c                    |   2 +-
 drivers/net/ethernet/wiznet/w5300.c                    |   2 +-
 drivers/net/phy/sfp-bus.c                              |   4 +-
 drivers/net/tun.c                                      |  43 ---------------
 drivers/pci/controller/pci-hyperv.c                    |   4 +-
 include/linux/netpoll.h                                |   5 +-
 include/linux/stmmac.h                                 |   1 +
 include/net/nfc/hci.h                                  |   2 +-
 kernel/bpf/sockmap.c                                   |  91 ++++++++++++++++++++++++-------
 net/batman-adv/bat_v_elp.c                             |  10 ++--
 net/batman-adv/bridge_loop_avoidance.c                 |  10 +++-
 net/batman-adv/gateway_client.c                        |  11 +++-
 net/batman-adv/main.h                                  |   2 +-
 net/batman-adv/network-coding.c                        |  27 +++++-----
 net/batman-adv/soft-interface.c                        |  25 ++++++---
 net/batman-adv/sysfs.c                                 |  30 +++++++----
 net/batman-adv/translation-table.c                     |   6 ++-
 net/batman-adv/tvlv.c                                  |   8 ++-
 net/core/devlink.c                                     |   3 +-
 net/core/ethtool.c                                     |   1 +
 net/core/netpoll.c                                     |  19 +++----
 net/ipv4/ip_tunnel.c                                   |   9 ++++
 net/ipv6/addrconf.c                                    |   4 +-
 net/ipv6/ip6_tunnel.c                                  |  13 ++++-
 net/ipv6/route.c                                       |   9 +++-
 net/mpls/af_mpls.c                                     |   6 ++-
 net/netlabel/netlabel_unlabeled.c                      |   3 +-
 net/nfc/hci/core.c                                     |  10 ++++
 net/rds/ib.h                                           |   2 +-
 net/sctp/transport.c                                   |  12 ++++-
 net/smc/af_smc.c                                       |  26 +++++----
 net/smc/smc_clc.c                                      |  14 +++--
 net/smc/smc_close.c                                    |  14 ++---
 net/smc/smc_pnet.c                                     |   2 +-
 tools/include/tools/libc_compat.h                      |   2 +-
 tools/testing/selftests/bpf/test_maps.c                |  10 ++--
 tools/testing/selftests/net/pmtu.sh                    |   4 +-
 89 files changed, 621 insertions(+), 653 deletions(-)
