Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4690C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5DF20658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5DF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeIEAJa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:09:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33764 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEAJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:09:30 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 09E35108E608A;
        Tue,  4 Sep 2018 12:42:55 -0700 (PDT)
Date:   Tue, 04 Sep 2018 12:42:54 -0700 (PDT)
Message-Id: <20180904.124254.286629003346268054.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Sep 2018 12:42:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Must perform TXQ teardown before unregistering interfaces in
   mac80211, from Toke Høiland-Jørgensen.

2) Don't allow creating mac80211_hwsim with less than one channel,
   from Johannes Berg.

3) Division by zero in cfg80211, fix from Johannes Berg.

4) Fix endian issue in tipc, from Haiqing Bai.

5) BPF sockmap use-after-free fixes from Daniel Borkmann.

6) Spectre-v1 in mac80211_hwsim, from Jinbum Park.

7) Missing rhashtable_walk_exit() in tipc, from Cong Wang.

8) Revert kvzalloc() conversion of AF_PACKET, it breaks mmap() when
   kvzalloc() tries to use kmalloc() pages.  From Eric Dumazet.

9) Fix deadlock in hv_netvsc, from Dexuan Cui.

10) Do not restart timewait timer on RST, from Florian Westphal.

11) Fix double lwstate refcount grab in ipv6, from Alexey Kodanev.

12) Unsolicit report count handling is off-by-one, fix from Hangbin
    Liu.

13) Sleep-in-atomic in cadence driver, from Jia-Ju Bai.

14) Respect ttl-inherit in ip6 tunnel driver, from Hangbin Liu.

15) Use-after-free in act_ife, fix from Cong Wang.

16) Missing hold to meta module in act_ife, from Vlad Buslov.

Please pull, thanks a lot!

The following changes since commit 050cdc6c9501abcd64720b8cc3e7941efee9547d:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-08-27 11:59:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to a33710bdb6b284f8f1e24f1119d167037b374ebb:

  net: phy: sfp: Handle unimplemented hwmon limits and alarms (2018-09-04 12:22:41 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'bpf_msg_pull_data-fixes'

Alexey Kodanev (2):
      vti6: remove !skb->ignore_df check from vti6_xmit()
      ipv6: don't get lwtstate twice in ip6_rt_copy_init()

Andrew Lunn (1):
      net: phy: sfp: Handle unimplemented hwmon limits and alarms

Anthony Wong (1):
      r8169: add support for NCube 8168 network card

Arnd Bergmann (1):
      rfkill-gpio: include linux/mod_devicetable.h

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Azat Khuzhin (1):
      r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices

Baruch Siach (1):
      net: mvpp2: initialize port of_node pointer

Chris Brandt (1):
      sh_eth: Add R7S9210 support

Cong Wang (3):
      tipc: fix a missing rhashtable_walk_exit()
      tipc: switch to rhashtable iterator
      act_ife: fix a potential use-after-free

Dan Carpenter (1):
      cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()

Danek Duvall (2):
      mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X
      mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Daniel Borkmann (6):
      bpf, sockmap: fix potential use after free in bpf_tcp_close
      bpf, sockmap: fix psock refcount leak in bpf_tcp_recvmsg
      bpf: fix several offset tests in bpf_msg_pull_data
      bpf: fix msg->data/data_end after sg shift repair in bpf_msg_pull_data
      bpf: fix shift upon scatterlist ring wrap-around in bpf_msg_pull_data
      bpf: fix sg shift repair start offset in bpf_msg_pull_data

David Ahern (1):
      net/ipv6: Only update MTU metric if it set

David S. Miller (10):
      Merge branch 'net-sched-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'hns-fixes'
      Merge branch 'ipv6-fix-error-path-of-inet6_init'
      Merge branch 'net_sched-reject-unknown-tcfa_action-values'
      Merge branch 'igmp-fix-two-incorrect-unsolicit-report-count-issues'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'sctp-two-fixes-for-spp_ipv6_flowlabel-and-spp_dscp-sockopts'
      Merge branch 'bnxt_en-Bug-fixes'
      Merge tag 'mac80211-for-davem-2018-09-03' of git://git.kernel.org/.../jberg/mac80211

Davide Caratti (1):
      net/sched: act_pedit: fix dump of extended layered op

Dexuan Cui (1):
      hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()

Dinh Nguyen (1):
      net: stmmac: build the dwmac-socfpga platform driver for Stratix10

Doug Berger (1):
      net: bcmgenet: use MAC link status for fixed phy

Dreyfuss, Haim (1):
      mac80211: fix WMM TXOP calculation

Emmanuel Grumbach (4):
      mac80211: don't update the PM state of a peer upon a multicast frame
      mac80211: fix a race between restart and CSA flows
      mac80211: don't Tx a deauth frame if the AP forbade Tx
      mac80211: shorten the IBSS debug messages

Eric Dumazet (1):
      Revert "packet: switch kvzalloc to allocate memory"

Florian Westphal (1):
      tcp: do not restart timewait timer on rst reception

Gleb Fotengauer-Malinovskiy (1):
      vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request definition

Haim Dreyfuss (2):
      nl80211: Fix nla_put_u8 to u16 for NL80211_WMMR_TXOP
      nl80211: Pass center frequency in kHz instead of MHz

Haiqing Bai (1):
      tipc: fix the big/little endian issue in tipc_dest

Hangbin Liu (3):
      igmp: fix incorrect unsolicit report count when join group
      igmp: fix incorrect unsolicit report count after link down and up
      ip6_tunnel: respect ttl inherit for ip6tnl

Ilan Peer (1):
      mac80211: Fix station bandwidth setting after channel switch

Ivan Mikhaylov (1):
      net/ibm/emac: wrong emac_calc_base call was used by typo

Jakub Kicinski (1):
      nfp: wait for posted reconfigs when disabling the device

Jerome Brunet (1):
      Revert "net: stmmac: Do not keep rearming the coalesce timer in stmmac_xmit"

Jia-Ju Bai (1):
      net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Jinbum Park (1):
      mac80211_hwsim: Fix possible Spectre-v1 for hwsim_world_regdom_custom

Jiri Pirko (2):
      net: sched: fix extack error message when chain is failed to be created
      net: sched: return -ENOENT when trying to remove filter from non-existent chain

Johannes Berg (3):
      mac80211_hwsim: require at least one channel
      cfg80211: remove division by size of sizeof(struct ieee80211_wmm_rule)
      mac80211: always account for A-MSDU header changes

John Fastabend (2):
      bpf: sockmap, decrement copied count correctly in redirect error case
      bpf: avoid misuse of psock when TCP_ULP_BPF collides with another ULP

Linus Walleij (1):
      net: dsa: Drop GPIO includes

Lorenzo Bianconi (2):
      mac80211: do not convert to A-MSDU if frag/subframe limited
      mac80211: fix an off-by-one issue in A-MSDU max_subframe computation

Michael Chan (3):
      bnxt_en: Fix firmware signaled resource change logic in open.
      bnxt_en: Clean up unused functions.
      bnxt_en: Do not adjust max_cp_rings by the ones used by RDMA.

Paolo Abeni (2):
      net_sched: reject unknown tcfa_action values
      tc-testing: add test-cases for numeric and invalid control action

Pavel Machek (1):
      net/rds: RDS is not Radio Data System

Peng Li (2):
      net: hns: add the code for cleaning pkt in chip
      net: hns: add netif_carrier_off before change speed and duplex

Prashant Bhole (1):
      tools/bpf: bpftool, add xskmap in map types

Sabrina Dubroca (5):
      ipv6: fix cleanup ordering for ip6_mr failure
      ipv6: fix cleanup ordering for pingv6 registration
      net: rtnl: return early from rtnl_unregister_all when protocol isn't registered
      selftests: pmtu: maximum MTU for vti4 is 2^16-1-20
      selftests: pmtu: detect correct binary to ping ipv6 addresses

Sara Sharon (1):
      mac80211: avoid kernel panic when building AMSDU from non-linear SKB

Stanislaw Gruszka (1):
      cfg80211: make wmm_rule part of the reg_rule structure

Stefan Agner (1):
      bpf: fix build error with clang

Tariq Toukan (1):
      net/mlx5: Fix SQ offset in QPs with small RQ

Thomas Falcon (1):
      ibmvnic: Include missing return code checks in reset function

Toke Høiland-Jørgensen (1):
      mac80211: Run TXQ teardown code before de-registering interfaces

Tony Lindgren (2):
      dt-bindings: net: cpsw: Document cpsw-phy-sel usage but prefer phandle
      net: ethernet: cpsw-phy-sel: prefer phandle for phy sel

Tushar Dave (1):
      bpf: Fix bpf_msg_pull_data()

Vinson Lee (1):
      uapi: Fix linux/rds.h userspace compilation errors.

Vlad Buslov (2):
      net: sched: null actions array pointer before releasing action
      net: sched: action_ife: take reference to meta module

Xin Long (5):
      sctp: hold transport before accessing its asoc in sctp_transport_get_next
      sctp: remove useless start_fail from sctp_ht_iter in proc
      erspan: set erspan_ver to 1 by default when adding an erspan dev
      sctp: fix invalid reference to the index variable of the iterator
      sctp: not traverse asoc trans list if non-ipv6 trans exists for ipv6_flowlabel

Yuan-Chi Pang (1):
      mac80211: mesh: fix HWMP sequence numbering to follow standard

Zhenbo Gao (2):
      tipc: correct spelling errors for struct tipc_bc_base's comment
      tipc: correct spelling errors for tipc_topsrv_queue_evt() comments

Zhu Yanjun (1):
      net/rds: Use rdma_read_gids to get connection SGID/DGID in IPv6

 Documentation/devicetree/bindings/net/cpsw.txt                  |  6 ++++++
 Documentation/devicetree/bindings/net/sh_eth.txt                |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                       | 22 +++++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                       |  3 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                 |  7 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                   | 20 --------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h                   |  1 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                  |  3 +++
 drivers/net/ethernet/broadcom/genet/bcmmii.c                    | 10 ++++++++--
 drivers/net/ethernet/cadence/macb_main.c                        |  2 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h                       |  2 ++
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c               | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c              | 36 ++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c               | 44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h               |  8 ++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c              | 29 +++++++++++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h              |  3 +++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c               | 23 +++++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h               |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c               | 23 +++++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h               |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h               |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c                   | 21 ++++++++++++++++++---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c                |  2 ++
 drivers/net/ethernet/ibm/emac/core.c                            |  6 +++---
 drivers/net/ethernet/ibm/ibmvnic.c                              | 12 +++++++++---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                 |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/wq.c                    |  5 +++--
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c             | 48 +++++++++++++++++++++++++++++++++---------------
 drivers/net/ethernet/realtek/r8169.c                            |  7 +++++--
 drivers/net/ethernet/renesas/sh_eth.c                           | 36 ++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig                     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                    |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c               |  5 +----
 drivers/net/ethernet/ti/cpsw-phy-sel.c                          |  9 ++++++---
 drivers/net/hyperv/netvsc_drv.c                                 | 11 ++++++++++-
 drivers/net/phy/sfp.c                                           | 20 ++++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c              | 50 +++++---------------------------------------------
 drivers/net/wireless/mac80211_hwsim.c                           | 12 +++++++++---
 include/linux/pci_ids.h                                         |  2 ++
 include/net/cfg80211.h                                          |  4 ++--
 include/net/regulatory.h                                        |  4 ++--
 include/uapi/linux/rds.h                                        |  1 +
 include/uapi/linux/vhost.h                                      |  2 +-
 kernel/bpf/sockmap.c                                            | 64 ++++++++++++++++++++++++++++++++++++----------------------------
 net/core/filter.c                                               | 59 ++++++++++++++++++++++++++++++++---------------------------
 net/core/rtnetlink.c                                            |  4 ++++
 net/dsa/dsa.c                                                   |  2 --
 net/ipv4/igmp.c                                                 | 11 ++++-------
 net/ipv4/ip_gre.c                                               |  3 +++
 net/ipv4/tcp_minisocks.c                                        |  3 ++-
 net/ipv6/af_inet6.c                                             | 10 +++++-----
 net/ipv6/ip6_fib.c                                              |  5 ++++-
 net/ipv6/ip6_gre.c                                              |  1 +
 net/ipv6/ip6_tunnel.c                                           | 10 +++++++++-
 net/ipv6/ip6_vti.c                                              |  2 +-
 net/ipv6/route.c                                                |  1 -
 net/mac80211/ibss.c                                             | 22 +++++++++++-----------
 net/mac80211/main.c                                             | 28 ++++++++++++++++++++++------
 net/mac80211/mesh_hwmp.c                                        |  4 ++++
 net/mac80211/mlme.c                                             | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 net/mac80211/rx.c                                               |  1 +
 net/mac80211/tx.c                                               | 54 ++++++++++++++++++++++++++++++------------------------
 net/mac80211/util.c                                             | 11 +++++------
 net/packet/af_packet.c                                          | 44 +++++++++++++++++++++++++++++++-------------
 net/packet/internal.h                                           |  1 +
 net/rds/Kconfig                                                 |  2 +-
 net/rds/ib.c                                                    |  9 ++-------
 net/rfkill/rfkill-gpio.c                                        |  1 +
 net/sched/act_api.c                                             | 18 ++++++++++++------
 net/sched/act_ife.c                                             | 18 ++++++++++++++++--
 net/sched/act_pedit.c                                           | 18 +++++++++++++-----
 net/sched/cls_api.c                                             |  4 ++--
 net/sctp/proc.c                                                 |  8 --------
 net/sctp/socket.c                                               | 56 ++++++++++++++++++++++++++++++++++----------------------
 net/tipc/bcast.c                                                |  4 ++--
 net/tipc/diag.c                                                 |  2 ++
 net/tipc/name_table.c                                           | 10 ++++------
 net/tipc/name_table.h                                           |  9 ++-------
 net/tipc/netlink.c                                              |  2 ++
 net/tipc/socket.c                                               | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 net/tipc/socket.h                                               |  2 ++
 net/tipc/topsrv.c                                               |  4 ++--
 net/wireless/nl80211.c                                          | 15 ++++++++-------
 net/wireless/reg.c                                              | 91 +++++++++++++------------------------------------------------------------------------------
 net/wireless/util.c                                             |  2 +-
 tools/bpf/bpftool/map.c                                         |  1 +
 tools/testing/selftests/net/pmtu.sh                             |  7 +++++--
 tools/testing/selftests/tc-testing/tc-tests/actions/police.json | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 89 files changed, 941 insertions(+), 452 deletions(-)
