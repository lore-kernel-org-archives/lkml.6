Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF12AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAF220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAF220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeKFLFX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:05:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37734 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeKFLFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:05:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D8CDE14A65078;
        Mon,  5 Nov 2018 17:42:42 -0800 (PST)
Date:   Mon, 05 Nov 2018 17:42:42 -0800 (PST)
Message-Id: <20181105.174242.2248944127095829834.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 17:42:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Handle errors mid-stream of an all dump, from Alexey Kodanev.

2) Fix build of openvswitch with certain combinations of netfilter
   options, from Arnd Bergmann.

3) Fix interactions between GSO and BQL, from Eric Dumazet.

4) Don't put a '/' in RTL8201F's sysfs file name, from Holger
   Hoffstätte.

5) S390 qeth driver fixes from Julian Wiedmann.

6) Allow ipv6 link local addresses for netconsole when both source
   and destination are link local, from Matwey V. Kornilov.

7) Fix the BPF program address seen in /proc/kallsyms, from Song Liu.

8) Initialize mutex before use in dsa microchip driver, from Tristram
   Ha.

9) Out-of-bounds access in hns3, from Yunsheng Lin.

10) Various netfilter fixes from Stefano Brivio, Jozsef Kadlecsik,
    Jiri Slaby, Florian Westphal, Eric Westbrook, Andrey Ryabinin, and
    Pablo Neira Ayuso.

Please pull, thanks!

The following changes since commit 7c6c54b505b8aea1782ce6a6e8f3b8297d179937:

  Merge branch 'i2c/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2018-11-01 09:31:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to a422757e8c323ae12163fa74bc21c41606a233df:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf (2018-11-05 17:19:25 -0800)

----------------------------------------------------------------
Alexey Kodanev (2):
      rtnetlink: restore handling of dumpit return value in rtnl_dump_all()
      ipv6: properly check return value in inet6_dump_all()

Andrei Vagin (1):
      sock_diag: fix autoloading of the raw_diag module

Andrey Ryabinin (1):
      netfilter: ipset: fix ip_set_list allocation failure

Arnd Bergmann (2):
      qed: fix link config error handling
      openvswitch: fix linking without CONFIG_NF_CONNTRACK_LABELS

Cong Wang (1):
      net: drop skb on failure in ip_check_defrag()

Daniel Borkmann (2):
      Merge branch 'bpf-accurate-prog-addr'
      bpf: fix bpf_prog_get_info_by_fd to return 0 func_lens for unpriv

David Howells (1):
      rxrpc: Fix lockup due to no error backoff after ack transmit error

David S. Miller (5):
      Merge branch 'net-timeout-fixes-for-GENET-and-SYSTEMPORT'
      Merge branch 's390-qeth-fixes'
      Merge branch 'net-bql-better-deal-with-GSO'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge git://git.kernel.org/.../pablo/nf

Doug Berger (1):
      net: bcmgenet: protect stop from timeout

Eric Dumazet (3):
      net: bql: add __netdev_tx_sent_queue()
      net: do not abort bulk send on BQL status
      net/mlx4_en: use __netdev_tx_sent_queue()

Eric Westbrook (1):
      netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net

Florian Fainelli (1):
      net: systemport: Protect stop from timeout

Florian Westphal (2):
      netfilter: ipv6: fix oops when defragmenting locally generated fragments
      netfilter: nft_compat: ebtables 'nat' table is normal chain type

Frieder Schrempf (1):
      usbnet: smsc95xx: disable carrier check while suspending

Holger Hoffstätte (1):
      net: phy: realtek: fix RTL8201F sysfs name

Jarod Wilson (1):
      bonding/802.3ad: fix link_failure_count tracking

Jeff Barnhill (2):
      net/ipv6: Add anycast addresses to a global hashtable
      net/ipv6: Move anycast init/cleanup functions out of CONFIG_PROC_FS

Jiri Slaby (1):
      netfilter: bridge: define INT_MIN & INT_MAX in userspace

Jozsef Kadlecsik (2):
      netfilter: ipset: Correct rcu_dereference() call in ip_set_put_comment()
      netfilter: ipset: Fix calling ip_set() macro at dumping

Julian Wiedmann (6):
      s390/qeth: sanitize strings in debug messages
      s390/qeth: fix HiperSockets sniffer
      s390/qeth: unregister netdevice only when registered
      s390/qeth: fix initial operstate
      s390/qeth: sanitize ARP requests
      s390/qeth: report 25Gbit link speed

Mathieu Malaterre (1):
      net: document skb parameter in function 'skb_gso_size_check'

Matwey V. Kornilov (1):
      net: core: netpoll: Enable netconsole IPv6 link local address

Pablo Neira Ayuso (4):
      netfilter: nft_osf: check if attribute is present
      Revert "netfilter: nft_numgen: add map lookups for numgen random operations"
      netfilter: conntrack: add nf_{tcp,udp,sctp,icmp,dccp,icmpv6,generic}_pernet()
      netfilter: nfnetlink_cttimeout: pass default timeout policy to obj_to_nlattr

Rasmus Villemoes (1):
      net: alx: make alx_drv_name static

Shalom Toledo (1):
      mlxsw: spectrum: Fix IP2ME CPU policer configuration

Song Liu (3):
      bpf: show real jited prog address in /proc/kallsyms
      bpf: show real jited address in bpf_prog_info->jited_ksyms
      bpf: show main program address and length in bpf_prog_info

Stefano Brivio (1):
      netfilter: ipset: list:set: Decrease refcount synchronously on deletion and replace

Taehee Yoo (2):
      netfilter: xt_IDLETIMER: add sysfs filename checking routine
      net: bpfilter: fix iptables failure if bpfilter_umh is disabled

Tristram Ha (1):
      net: dsa: microchip: initialize mutex before use

Vasily Khoruzhick (1):
      netfilter: conntrack: fix calculation of next bucket number in early_drop

Xin Long (2):
      sctp: fix strchange_flags name for Stream Change Event
      sctp: define SCTP_SS_DEFAULT for Stream schedulers

Yunsheng Lin (1):
      net: hns3: Fix for out-of-bounds access when setting pfc back pressure

 drivers/net/bonding/bond_main.c                       |   4 +-
 drivers/net/dsa/microchip/ksz_common.c                |  10 ++---
 drivers/net/ethernet/atheros/alx/alx.h                |   1 -
 drivers/net/ethernet/atheros/alx/main.c               |   2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c            |  15 ++++----
 drivers/net/ethernet/broadcom/genet/bcmgenet.c        |  13 ++++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c |  10 ++---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c            |   6 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c        |   1 -
 drivers/net/ethernet/qlogic/qed/qed_mcp.c             |   7 +++-
 drivers/net/phy/realtek.c                             |   2 +-
 drivers/net/usb/smsc95xx.c                            |   7 ++++
 drivers/s390/net/qeth_core.h                          |  27 +++++++++----
 drivers/s390/net/qeth_core_main.c                     | 172 ++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
 drivers/s390/net/qeth_core_mpc.h                      |   4 +-
 drivers/s390/net/qeth_l2_main.c                       |  39 ++++++++++---------
 drivers/s390/net/qeth_l3_main.c                       | 207 ++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
 include/linux/netdevice.h                             |  20 ++++++++++
 include/linux/netfilter/ipset/ip_set.h                |   2 +-
 include/linux/netfilter/ipset/ip_set_comment.h        |   4 +-
 include/net/addrconf.h                                |   2 +
 include/net/if_inet6.h                                |   2 +
 include/net/netfilter/nf_conntrack_l4proto.h          |  39 +++++++++++++++++++
 include/uapi/linux/netfilter/nf_tables.h              |   4 +-
 include/uapi/linux/netfilter_bridge.h                 |   4 ++
 include/uapi/linux/sctp.h                             |   3 ++
 kernel/bpf/core.c                                     |   4 +-
 kernel/bpf/syscall.c                                  |  35 ++++++++++++-----
 net/core/dev.c                                        |   2 +-
 net/core/netpoll.c                                    |   3 +-
 net/core/rtnetlink.c                                  |   2 +-
 net/core/skbuff.c                                     |   2 +
 net/core/sock.c                                       |   1 +
 net/ipv4/ip_fragment.c                                |  12 ++++--
 net/ipv4/ip_sockglue.c                                |   6 +--
 net/ipv6/af_inet6.c                                   |   5 +++
 net/ipv6/anycast.c                                    |  80 ++++++++++++++++++++++++++++++++++++--
 net/ipv6/ip6_fib.c                                    |   4 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c               |  13 +++++--
 net/netfilter/ipset/ip_set_core.c                     |  43 +++++++++++----------
 net/netfilter/ipset/ip_set_hash_netportnet.c          |   8 ++--
 net/netfilter/ipset/ip_set_list_set.c                 |  17 ++++++---
 net/netfilter/nf_conntrack_core.c                     |  13 ++++---
 net/netfilter/nf_conntrack_proto_dccp.c               |  13 ++-----
 net/netfilter/nf_conntrack_proto_generic.c            |  11 ++----
 net/netfilter/nf_conntrack_proto_icmp.c               |  11 ++----
 net/netfilter/nf_conntrack_proto_icmpv6.c             |  11 ++----
 net/netfilter/nf_conntrack_proto_sctp.c               |  11 ++----
 net/netfilter/nf_conntrack_proto_tcp.c                |  15 +++-----
 net/netfilter/nf_conntrack_proto_udp.c                |  11 ++----
 net/netfilter/nfnetlink_cttimeout.c                   |  47 +++++++++++++++++++----
 net/netfilter/nft_compat.c                            |  21 +++++-----
 net/netfilter/nft_numgen.c                            | 127 -------------------------------------------------------------
 net/netfilter/nft_osf.c                               |   2 +-
 net/netfilter/xt_IDLETIMER.c                          |  20 ++++++++++
 net/openvswitch/conntrack.c                           |   3 +-
 net/rxrpc/ar-internal.h                               |   1 +
 net/rxrpc/call_event.c                                |  18 +++++++--
 net/rxrpc/output.c                                    |  35 +++++++++++++++--
 net/sctp/outqueue.c                                   |   2 +-
 60 files changed, 653 insertions(+), 563 deletions(-)
