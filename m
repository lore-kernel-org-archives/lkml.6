Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F97C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DF4208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DF4208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966430AbeFOQsK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:48:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966148AbeFOQsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:48:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F133C40122BD;
        Fri, 15 Jun 2018 16:48:04 +0000 (UTC)
Received: from localhost (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78F682026609;
        Fri, 15 Jun 2018 16:48:03 +0000 (UTC)
Date:   Fri, 15 Jun 2018 09:48:02 -0700 (PDT)
Message-Id: <20180615.094802.292819136921102626.davem@redhat.com>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 16:48:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 16:48:05 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'davem@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Various netfilter fixlets from Pablo and the netfilter team.

2) Fix regression in IPVS caused by lack of PMTU exceptions on local
   routes in ipv6, from Julian Anastasov.

3) Check pskb_trim_rcsum for failure in DSA, from Zhouyang Jia.

4) Don't crash on poll in TLS, from Daniel Borkmann.

5) Revert SO_REUSE{ADDR,PORT} change, it regresses various things
   including Avahi mDNS.  From Bart Van Assche.

6) Missing of_node_put in qcom/emac driver, from Yue Haibing.

7) We lack checking of the TCP checking in one special case during
   SYN receive, from Frank van der Linden.

8) Fix module init error paths of mac80211 hwsim, from Johannes
   Berg.

9) Handle 802.1ad properly in stmmac driver, from Elad Nachman.

10) Must grab HW caps before doing quirk checks in stmmac driver,
    from Jose Abreu.

Please pull, thanks a lot!

The following changes since commit f0dc7f9c6dd99891611fca5849cbc4c6965b690e:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-06-10 19:25:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 7cfde0af731c14664e3882c7ba77ace1059f2c5e:

  net: stmmac: Run HWIF Quirks after getting HW caps (2018-06-15 09:38:52 -0700)

----------------------------------------------------------------
Alexander Duyck (5):
      ixgbe: Fix setting of TC configuration for macvlan case
      ixgbe: Use CONFIG_XFRM_OFFLOAD instead of CONFIG_XFRM
      ixgbe: Move ipsec init function to before reset call
      ixgbe: Avoid loopback and fix boolean logic in ipsec_stop_data
      ixgbe: Fix bit definitions and add support for testing for ipsec support

Alexey Kodanev (1):
      netfilter: nf_tables: check msg_type before nft_trans_set(trans)

Alin Nastac (1):
      netfilter: ebtables: fix compat entry padding

Anders Roxell (1):
      selftests: bpf: fix urandom_read build issue

Bart Van Assche (1):
      Revert "net: do not allow changing SO_REUSEADDR/SO_REUSEPORT on bound sockets"

Björn Töpel (1):
      xsk: silence warning on memory allocation failure

Christophe JAILLET (1):
      net: stmmac: dwmac-meson8b: Fix an error handling path in 'meson8b_dwmac_probe()'

Cong Wang (1):
      smc: convert to ->poll_mask

Corentin Labbe (1):
      netfilter: remove include/net/netfilter/nft_dup.h

Daniel Borkmann (4):
      bpf: implement dummy fops for bpf objects
      tls: fix NULL pointer dereference on poll
      tls: fix use-after-free in tls_push_record
      tls: fix waitall behavior in tls_sw_recvmsg

David Ahern (1):
      net/ipv6: Ensure cfg is properly initialized in ipv6_create_tempaddr

David Miller (1):
      tcp: Do not reload skb pointer after skb_gro_receive().

David S. Miller (12):
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'nfp-fixes'
      Merge branch 'hv_netvsc-notification-and-namespace-fixes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'emaclite-fixes'
      Merge branch 'l2tp-fixes'
      Merge tag 'mac80211-for-davem-2018-06-15' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'mlxsw-IPv6-and-reference-counting-fixes'
      Merge branch 'l2tp-l2tp_ppp-must-ignore-non-PPP-sessions'
      Merge branch 'tls-fixes'

Davide Caratti (1):
      tc-testing: ife: fix wrong teardown command in test b7b8

Dedy Lansky (1):
      cfg80211: fix rcu in cfg80211_unregister_wdev

Elad Nachman (1):
      stmmac: added support for 802.1ad vlan stripping

Florent Fourcot (1):
      netfilter: ipset: forbid family for hash:mac sets

Florian Westphal (6):
      netfilter: ebtables: reject non-bridge targets
      netfilter: x_tables: initialise match/target check parameter struct
      netfilter: nf_tables: fix module unload race
      netfilter: nf_tables: close race between netns exit and rmmod
      netfilter: ctnetlink: avoid null pointer dereference
      netfilter: xt_connmark: fix list corruption on rmmod

Frank van der Linden (1):
      tcp: verify the checksum of the first data segment in a new connection

Gao Feng (2):
      netfilter: xt_CT: Reject the non-null terminated string from user space
      netfilter: nf_conntrack: Increase __IPS_MAX_BIT with new bit IPS_OFFLOAD_BIT

Guillaume Nault (6):
      l2tp: fix pseudo-wire type for sessions created by pppol2tp_connect()
      l2tp: only accept PPP sessions in pppol2tp_connect()
      l2tp: prevent pppol2tp_connect() from creating kernel sockets
      l2tp: clean up stale tunnel or session in pppol2tp_connect's error path
      l2tp: reject creation of non-PPP sessions on L2TPv2 tunnels
      l2tp: filter out non-PPP sessions in pppol2tp_tunnel_ioctl()

Haiyang Zhang (1):
      hv_netvsc: Fix the variable sizes in ipsecv2 and rsc offload

Ido Schimmel (3):
      ipv6: Only emit append events for appended routes
      mlxsw: spectrum_router: Allow appending to dev-only routes
      mlxsw: spectrum_router: Align with new route replace logic

Jakub Kicinski (3):
      nfp: don't pad strings in nfp_cpp_resource_find() to avoid gcc 8 warning
      nfp: include all ring counters in interface stats
      nfp: remove phys_port_name on flower's vNIC

Johannes Berg (1):
      mac80211_hwsim: fix module init error paths

Jose Abreu (1):
      net: stmmac: Run HWIF Quirks after getting HW caps

Jozsef Kadlecsik (2):
      netfilter: ipset: List timing out entries with "timeout 1" instead of zero
      netfilter: ipset: Limit max timeout value

Juergen Gross (1):
      xen/netfront: raise max number of slots in xennet_get_responses()

Julian Anastasov (3):
      ipvs: register conntrack hooks for ftp
      ipvs: fix check on xmit to non-local addresses
      ipv6: allow PMTU exceptions to local routes

Linus Walleij (1):
      net: phy: mdio-gpio: Cut surplus includes

Luca Coelho (1):
      nl80211: fix some kernel doc tag mistakes

Pablo Neira Ayuso (3):
      Merge git://blackhole.kfki.hu/nf
      netfilter: nft_socket: fix module autoload
      netfilter: nft_dynset: do not reject set updates with NFT_SET_EVAL

Petr Machata (1):
      mlxsw: spectrum_switchdev: Fix port_vlan refcounting

Pieter Jansen van Vuuren (1):
      nfp: flower: free dst_entry in route table

Prashant Bhole (1):
      netfilter: fix null-ptr-deref in nf_nat_decode_session

Radhey Shyam Pandey (4):
      net: emaclite: Fix position of lp->mii_bus assignment
      net: emaclite: Fix MDIO bus unregister bug
      net: emaclite: Remove unused 'has_mdio' flag.
      net: emaclite: Remove xemaclite_mdio_setup return check

Roopa Prabhu (1):
      neighbour: skip NTF_EXT_LEARNED entries during forced gc

Santosh Shilimkar (1):
      rds: avoid unenecessary cong_update in loop transport

Serhey Popovych (1):
      netfilter: xt_set: Check hook mask correctly

Stephen Hemminger (3):
      hv_netvsc: drop common code until callback model fixed
      hv_netvsc: fix network namespace issues with VF support
      hv_netvsc: move VF to same namespace as netvsc device

Sven Eckelmann (1):
      cfg80211: initialize sinfo in cfg80211_get_station

Taehee Yoo (3):
      netfilter: nft_reject_bridge: fix skb allocation size in nft_reject_br_send_v6_unreach
      netfilter: nft_set_rbtree: fix parameter of __nft_rbtree_lookup()
      netfilter: nf_tables: use WARN_ON_ONCE instead of BUG_ON in nft_do_chain()

Toke Høiland-Jørgensen (1):
      mac80211: Move up init of TXQs

Vadim Lomovtsev (1):
      net: thunderx: prevent concurrent data re-writing by nicvf_set_rx_mode

Xin Long (1):
      sctp: define sctp_packet_gso_append to build GSO frames

Yi-Hung Wei (1):
      netfilter: nf_conncount: Fix garbage collection with zones

YueHaibing (1):
      net: qcom/emac: Add missing of_node_put()

Zhouyang Jia (2):
      net: dsa: add error handling for pskb_trim_rcsum
      net: cxgb3: add error handling for sysfs_create_group

 drivers/net/ethernet/cavium/thunder/nic.h                    |   2 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c             |  50 ++++++++++++++------
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c              |   7 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                     |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c               |  34 ++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c                 |   8 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                |  21 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                |   6 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c        |  48 +++++++++----------
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c     |   4 +-
 drivers/net/ethernet/netronome/nfp/flower/main.c             |   1 +
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c      |   2 +
 drivers/net/ethernet/netronome/nfp/nfp_net.h                 |   4 ++
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c          |   4 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c    |   7 +--
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c              |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c          |   7 +--
 drivers/net/ethernet/stmicro/stmmac/hwif.c                   |   9 +---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                 |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c            |  28 +++++++----
 drivers/net/ethernet/xilinx/xilinx_emaclite.c                |  12 ++---
 drivers/net/hyperv/Kconfig                                   |   1 -
 drivers/net/hyperv/hyperv_net.h                              |  30 ++++++------
 drivers/net/hyperv/netvsc_drv.c                              | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 drivers/net/phy/mdio-gpio.c                                  |   3 --
 drivers/net/wireless/mac80211_hwsim.c                        |  11 ++++-
 drivers/net/xen-netfront.c                                   |   4 +-
 include/linux/netfilter.h                                    |   2 +-
 include/linux/netfilter/ipset/ip_set_timeout.h               |  20 +++++---
 include/net/ip_vs.h                                          |  30 ++++++++++++
 include/net/netfilter/nf_conntrack_count.h                   |   3 +-
 include/net/netfilter/nft_dup.h                              |  10 ----
 include/net/sctp/structs.h                                   |   5 ++
 include/net/tls.h                                            |   6 +--
 include/uapi/linux/netfilter/nf_conntrack_common.h           |   2 +-
 include/uapi/linux/netfilter/nf_tables.h                     |   2 +-
 include/uapi/linux/nl80211.h                                 |  28 +++++------
 kernel/bpf/inode.c                                           |  14 +++++-
 net/bridge/netfilter/ebtables.c                              |  25 ++++++++--
 net/bridge/netfilter/nft_reject_bridge.c                     |   2 +-
 net/core/neighbour.c                                         |  10 ++--
 net/core/sock.c                                              |  15 +-----
 net/dsa/tag_trailer.c                                        |   3 +-
 net/ipv4/netfilter/ip_tables.c                               |   1 +
 net/ipv4/tcp_ipv4.c                                          |   4 ++
 net/ipv4/tcp_offload.c                                       |   2 -
 net/ipv6/addrconf.c                                          |   2 +-
 net/ipv6/ip6_fib.c                                           |   5 +-
 net/ipv6/netfilter/ip6_tables.c                              |   1 +
 net/ipv6/route.c                                             |   3 --
 net/ipv6/tcp_ipv6.c                                          |   4 ++
 net/l2tp/l2tp_netlink.c                                      |   6 +++
 net/l2tp/l2tp_ppp.c                                          |  28 ++++++++++-
 net/mac80211/main.c                                          |  12 ++---
 net/netfilter/ipset/ip_set_hash_gen.h                        |   5 +-
 net/netfilter/ipvs/ip_vs_ctl.c                               |   4 ++
 net/netfilter/ipvs/ip_vs_xmit.c                              |   2 +-
 net/netfilter/nf_conncount.c                                 |  13 ++++--
 net/netfilter/nf_conntrack_netlink.c                         |   3 +-
 net/netfilter/nf_tables_api.c                                |  36 ++++++++++-----
 net/netfilter/nf_tables_core.c                               |   3 +-
 net/netfilter/nfnetlink.c                                    |  10 ++--
 net/netfilter/nft_chain_filter.c                             |   5 ++
 net/netfilter/nft_connlimit.c                                |   2 +-
 net/netfilter/nft_dynset.c                                   |   4 +-
 net/netfilter/nft_set_rbtree.c                               |   2 +-
 net/netfilter/nft_socket.c                                   |   1 +
 net/netfilter/xt_CT.c                                        |  10 ++++
 net/netfilter/xt_connmark.c                                  |   2 +-
 net/netfilter/xt_set.c                                       |  10 ++--
 net/rds/loop.c                                               |   1 +
 net/rds/rds.h                                                |   5 ++
 net/rds/recv.c                                               |   5 ++
 net/sctp/output.c                                            |  28 +++++++----
 net/smc/af_smc.c                                             |  12 ++---
 net/tls/tls_main.c                                           |   2 +-
 net/tls/tls_sw.c                                             |  51 +++++++++++----------
 net/wireless/core.c                                          |   1 +
 net/wireless/util.c                                          |   2 +
 net/xdp/xdp_umem.c                                           |   3 +-
 tools/testing/selftests/bpf/Makefile                         |   4 +-
 tools/testing/selftests/tc-testing/tc-tests/actions/ife.json |   2 +-
 82 files changed, 681 insertions(+), 343 deletions(-)
 delete mode 100644 include/net/netfilter/nft_dup.h
