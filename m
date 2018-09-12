Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1322C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB632146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB632146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeIMBf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:35:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIMBf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:35:57 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1E7B312DE57F3;
        Wed, 12 Sep 2018 13:29:44 -0700 (PDT)
Date:   Wed, 12 Sep 2018 13:29:43 -0700 (PDT)
Message-Id: <20180912.132943.1274736843286775781.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Sep 2018 13:29:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix up several Kconfig dependencies in netfilter, from Martin Willi and
   Florian Westphal.

2) Memory leak in be2net driver, from Petr Oros.

3) Memory leak in E-Switch handling of mlx5 driver, from Raed Salem.

4) mlx5_attach_interface needs to check for errors, from Huy Nguyen.

5) tipc_release() needs to orphan the sock, from Cong Wang.

6) Need to program TxConfig register after TX/RX is enabled in r8169
   driver, not beforehand, from Maciej S. Szmigiero.

7) Handle 64K PAGE_SIZE properly in ena driver, from Netanel Belgazal.

8) Fix crash regression in ip_do_fragment(), from Taehee Yoo.

9) syzbot can create conditions where kernel log is flooded with
   synflood warnings due to creation of many listening sockets,
   fix that.  From Willem de Bruijn.

10) Fix RCU issues in rds socket layer, from Cong Wang.

11) Fix vlan matching in nfp driver, from Pieter Jansen van Vuuren.

Please pull, thanks a lot!

The following changes since commit 28619527b8a712590c93d0a9e24b4425b9376a8c:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-09-04 12:45:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 4851bfd64d42d9fb6d2d30a41c8523614b412a7a:

  Merge branch 'nfp-flower-fixes' (2018-09-12 13:18:30 -0700)

----------------------------------------------------------------
Cong Wang (6):
      tipc: orphan sock in tipc_release()
      tipc: call start and done ops directly in __tipc_nl_compat_dumpit()
      net_sched: properly cancel netlink dump on failure
      netfilter: xt_hashlimit: use s->file instead of s->private
      rds: fix two RCU related problems
      tipc: check return value of __tipc_dump_start()

Daniel Jurgens (1):
      net/mlx5: Consider PCI domain in search for next dev

David S. Miller (6):
      Merge branch 'iucv-fixes'
      Merge tag 'mlx5e-fixes-2018-09-05' of git://git.kernel.org/.../saeed/linux
      Merge branch 'ena-fixes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'qeth-fixes'
      Merge branch 'nfp-flower-fixes'

Davide Caratti (1):
      net/sched: fix memory leak in act_tunnel_key_init()

Florian Westphal (5):
      netfilter: xt_checksum: ignore gso skbs
      netfilter: conntrack: place 'new' timeout in first location too
      netfilter: nf_tables: rework ct timeout set support
      netfilter: kconfig: nat related expression depend on nftables core
      netfilter: conntrack: reset tcp maxwin on re-register

Haishuang Yan (2):
      erspan: return PACKET_REJECT when the appropriate tunnel is not found
      erspan: fix error handling for erspan tunnel

Hauke Mehrtens (1):
      MIPS: lantiq: dma: add dev pointer

Huy Nguyen (1):
      net/mlx5: Check for error in mlx5_attach_interface

Jack Morgenstein (2):
      net/mlx5: Fix use-after-free in self-healing flow
      net/mlx5: Fix debugfs cleanup in the device init/remove flow

Juergen Gross (1):
      xen/netfront: fix waiting for xenbus state change

Julian Wiedmann (6):
      net/af_iucv: drop inbound packets with invalid flags
      net/af_iucv: fix skb handling on HiperTransport xmit error
      net/iucv: declare iucv_path_table_empty() as static
      s390/qeth: indicate error when netdev allocation fails
      s390/qeth: switch on SG by default for IQD devices
      s390/qeth: don't dump past end of unknown HW header

Kai-Heng Feng (1):
      r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED

Kristian Evensen (1):
      qmi_wwan: Support dynamic config on Quectel EP06

Kuninori Morimoto (1):
      ethernet: renesas: convert to SPDX identifiers

Louis Peens (1):
      nfp: flower: reject tunnel encap with ipv6 outer headers for offloading

Maciej S. Szmigiero (1):
      r8169: set TxConfig register after TX / RX is enabled, just like RxConfig

Martin Willi (1):
      netfilter: xt_cluster: add dependency on conntrack module

Michal 'vorner' Vaner (1):
      netfilter: nfnetlink_queue: Solve the NFQUEUE/conntrack clash for NF_REPEAT

Netanel Belgazal (7):
      net: ena: fix surprise unplug NULL dereference kernel crash
      net: ena: fix driver when PAGE_SIZE == 64kB
      net: ena: fix device destruction to gracefully free resources
      net: ena: fix potential double ena_destroy_device()
      net: ena: fix missing lock during device destruction
      net: ena: fix missing calls to READ_ONCE
      net: ena: fix incorrect usage of memory barriers

Pablo Neira Ayuso (2):
      netfilter: conntrack: timeout interface depend on CONFIG_NF_CONNTRACK_TIMEOUT
      netfilter: cttimeout: ctnl_timeout_find_get() returns incorrect pointer to type

Petr Machata (1):
      mlxsw: spectrum_buffers: Set up a dedicated pool for BUM traffic

Petr Oros (1):
      be2net: Fix memory leak in be_cmd_get_profile_config()

Pieter Jansen van Vuuren (1):
      nfp: flower: fix vlan match by checking both vlan id and vlan pcp

Raed Salem (1):
      net/mlx5: E-Switch, Fix memory leak when creating switchdev mode FDB tables

Roi Dayan (2):
      net/mlx5: Fix not releasing read lock when adding flow rules
      net/mlx5: Fix possible deadlock from lockdep when adding fte to fg

Saeed Mahameed (1):
      net/mlx5e: Ethtool steering, fix udp source port value

Stefan Wahren (1):
      net: qca_spi: Fix race condition in spi transfers

Taehee Yoo (2):
      netfilter: nf_tables: release chain in flushing set
      ip: frags: fix crash in ip_do_fragment()

Tariq Toukan (2):
      net/mlx5: Use u16 for Work Queue buffer fragment size
      net/mlx5: Use u16 for Work Queue buffer strides offset

Vakul Garg (1):
      net/tls: Set count of SG entries if sk_alloc_sg returns -ENOSPC

Vincent Whitchurch (1):
      tcp: really ignore MSG_ZEROCOPY if no SO_ZEROCOPY

Wenjia Zhang (1):
      s390/qeth: use vzalloc for QUERY OAT buffer

Willem de Bruijn (1):
      tcp: rate limit synflood warnings further

Yue Haibing (1):
      netfilter: conntrack: remove duplicated include from nf_conntrack_proto_udp.c

 arch/mips/include/asm/mach-lantiq/xway/xway_dma.h          |   1 +
 arch/mips/lantiq/xway/dma.c                                |   4 +--
 drivers/net/ethernet/amazon/ena/ena_com.c                  |  24 ++++++++---------
 drivers/net/ethernet/amazon/ena/ena_eth_com.c              |   6 +++++
 drivers/net/ethernet/amazon/ena/ena_eth_com.h              |   8 ++----
 drivers/net/ethernet/amazon/ena/ena_netdev.c               |  82 ++++++++++++++++++++++++++------------------------------
 drivers/net/ethernet/amazon/ena/ena_netdev.h               |  11 ++++++++
 drivers/net/ethernet/emulex/benet/be_cmds.c                |   2 +-
 drivers/net/ethernet/lantiq_etop.c                         |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c              |  22 ++++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c          |  76 ++++++++++++++++++++++++++--------------------------
 drivers/net/ethernet/mellanox/mlx5/core/health.c           |  10 ++++++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c             |  12 +++++----
 drivers/net/ethernet/mellanox/mlx5/core/wq.c               |   6 ++---
 drivers/net/ethernet/mellanox/mlx5/core/wq.h               |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c     |  16 +++++------
 drivers/net/ethernet/netronome/nfp/flower/action.c         |   6 +++++
 drivers/net/ethernet/netronome/nfp/flower/main.h           |   1 +
 drivers/net/ethernet/netronome/nfp/flower/match.c          |   2 +-
 drivers/net/ethernet/netronome/nfp/flower/offload.c        |  11 ++++++++
 drivers/net/ethernet/qualcomm/qca_7k.c                     |  76 +++++++++++++++++++++++++---------------------------
 drivers/net/ethernet/qualcomm/qca_spi.c                    | 110 +++++++++++++++++++++++++++++++++++++++-------------------------------------
 drivers/net/ethernet/qualcomm/qca_spi.h                    |   5 ----
 drivers/net/ethernet/realtek/r8169.c                       |  11 +++++---
 drivers/net/ethernet/renesas/Kconfig                       |   1 +
 drivers/net/ethernet/renesas/Makefile                      |   1 +
 drivers/net/ethernet/renesas/ravb_ptp.c                    |   6 +----
 drivers/net/usb/qmi_wwan.c                                 |  30 ++++++++++++++++++++-
 drivers/net/xen-netfront.c                                 |  24 +++++++----------
 drivers/s390/net/qeth_core_main.c                          |  11 +++++---
 drivers/s390/net/qeth_l2_main.c                            |   2 +-
 drivers/s390/net/qeth_l3_main.c                            |   2 +-
 include/linux/mlx5/driver.h                                |   8 +++---
 include/net/netfilter/nf_conntrack_timeout.h               |   2 +-
 net/core/skbuff.c                                          |   3 ---
 net/ipv4/ip_fragment.c                                     |   1 +
 net/ipv4/ip_gre.c                                          |   5 ++++
 net/ipv4/netfilter/Kconfig                                 |   8 +++---
 net/ipv4/tcp.c                                             |   2 +-
 net/ipv4/tcp_input.c                                       |   4 +--
 net/ipv6/netfilter/nf_conntrack_reasm.c                    |   1 +
 net/iucv/af_iucv.c                                         |  38 +++++++++++++++++---------
 net/iucv/iucv.c                                            |   2 +-
 net/netfilter/Kconfig                                      |  12 ++++-----
 net/netfilter/nf_conntrack_proto.c                         |  26 ++++++++++++++++++
 net/netfilter/nf_conntrack_proto_dccp.c                    |  19 ++++++++-----
 net/netfilter/nf_conntrack_proto_generic.c                 |   8 +++---
 net/netfilter/nf_conntrack_proto_gre.c                     |   8 +++---
 net/netfilter/nf_conntrack_proto_icmp.c                    |   8 +++---
 net/netfilter/nf_conntrack_proto_icmpv6.c                  |   8 +++---
 net/netfilter/nf_conntrack_proto_sctp.c                    |  21 ++++++++++-----
 net/netfilter/nf_conntrack_proto_tcp.c                     |  19 ++++++++-----
 net/netfilter/nf_conntrack_proto_udp.c                     |  21 +++++++--------
 net/netfilter/nf_tables_api.c                              |   1 +
 net/netfilter/nfnetlink_cttimeout.c                        |   6 ++---
 net/netfilter/nfnetlink_queue.c                            |   1 +
 net/netfilter/nft_ct.c                                     |  59 ++++++++++++++++++++---------------------
 net/netfilter/xt_CHECKSUM.c                                |  22 +++++++++++++++-
 net/netfilter/xt_cluster.c                                 |  14 +++++++++-
 net/netfilter/xt_hashlimit.c                               |  18 ++++++-------
 net/rds/bind.c                                             |   5 +++-
 net/sched/act_tunnel_key.c                                 |  28 +++++++++++++-------
 net/tipc/netlink_compat.c                                  |   5 ++++
 net/tipc/socket.c                                          |  18 ++++++++-----
 net/tipc/socket.h                                          |   1 +
 net/tls/tls_sw.c                                           |   6 +++++
 68 files changed, 593 insertions(+), 400 deletions(-)
