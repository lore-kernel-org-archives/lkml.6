Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Mi6XEYXFHVtGVAAAmS7hNA
	; Mon, 11 Jun 2018 00:42:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1DFD1607A4; Mon, 11 Jun 2018 00:42:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2C38E6070A;
	Mon, 11 Jun 2018 00:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C38E6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeFKAmj convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 21 others);
        Sun, 10 Jun 2018 20:42:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43622 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbeFKAmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 20:42:38 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 18619136D5170;
        Sun, 10 Jun 2018 17:42:37 -0700 (PDT)
Date: Sun, 10 Jun 2018 17:42:35 -0700 (PDT)
Message-Id: <20180610.174235.953455611231708401.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Jun 2018 17:42:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) For several bpfilter/UMH bugs, in particular make the UMH build not
   depend upon X86 specific Kconfig symbols.  From Alexei Starovoitov.

2) Fix handling of modified context pointer in bpf verifier, from
   Daniel Borkmann.

3) Kill regression in ifdown/ifup sequences for hv_netvsc driver, from
   Dexuan Cui.

4) When the bonding primary member name changes, we have to
   re-evaluate the bond->force_primary setting, from Xiangning Yu.

5) Eliminate possible padding beyone end of SKB in cdc_ncm driver,
   from Bjørn Mork.

6) RX queue length reported for UDP sockets in procfs and socket diag
   are inaccurate, from Paolo Abeni.

7) Fix br_fdb_find_port() locking, from Petr Machata.

8) Limit sk_rcvlowat values properly in TCP, from Soheil Hassas
   Yeganeh.

Please pull, thanks a lot!

The following changes since commit 3036bc45364f98515a2c446d7fac2c34dcfbeff4:

  Merge tag 'media/v4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-06-07 12:34:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 867f816badc01e6da655028810d468c9f935b37c:

  tcp: limit sk_rcvlowat by the maximum receive buffer (2018-06-10 14:12:50 -0700)

----------------------------------------------------------------
Alexei Starovoitov (3):
      umh: fix race condition
      bpfilter: fix OUTPUT_FORMAT
      bpfilter: fix race in pipe access

Alvaro Gamez Machado (1):
      net: phy: dp83822: use BMCR_ANENABLE instead of BMSR_ANEGCAPABLE for DP83620

Bjørn Mork (1):
      cdc_ncm: avoid padding beyond end of skb

Colin Ian King (1):
      net: aquantia: fix unsigned numvecs comparison with less than zero

Cong Wang (1):
      socket: close race condition between sock_close() and sockfs_setattr()

Corentin Labbe (1):
      net: stmmac: fix build failure due to missing COMMON_CLK dependency

Daniel Borkmann (2):
      bpf: reject passing modified ctx to helper functions
      bpf, xdp: fix crash in xdp_umem_unaccount_pages

David S. Miller (1):
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (1):
      net/sched: act_simple: fix parsing of TCA_DEF_DATA

Dexuan Cui (1):
      hv_netvsc: Fix a network regression after ifdown/ifup

Geert Uytterhoeven (2):
      net: mscc: ocelot: Fix uninitialized error in ocelot_netdevice_event()
      xsk: Fix umem fill/completion queue mmap on 32-bit

Pablo Neira Ayuso (1):
      netfilter: nf_tables: add NFT_LOGLEVEL_* enumeration and use it

Paolo Abeni (1):
      udp: fix rx queue len reported by diag and proc interface

Petr Machata (1):
      net: bridge: Fix locking in br_fdb_find_port()

Soheil Hassas Yeganeh (1):
      tcp: limit sk_rcvlowat by the maximum receive buffer

Sultan Alsawaf (1):
      ip_tunnel: Fix name string concatenate in __ip_tunnel_create()

Willem de Bruijn (1):
      net: in virtio_net_hdr only add VLAN_HLEN to csum_start if payload holds vlan

Xiangning Yu (1):
      bonding: re-evaluate force_primary when the primary slave name changes

Yonghong Song (1):
      tools/bpf: fix selftest get_cgroup_id_user

YueHaibing (1):
      net: fddi: fix a possible null-ptr-deref

 arch/um/drivers/vector_transports.c                  |  3 ++-
 drivers/net/bonding/bond_options.c                   |  1 +
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 11 +++++------
 drivers/net/ethernet/mscc/ocelot.c                   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig          | 10 +++++-----
 drivers/net/fddi/skfp/skfddi.c                       | 55 ++++++++++++++++++++++++++++---------------------------
 drivers/net/hyperv/netvsc_drv.c                      |  4 +++-
 drivers/net/phy/dp83848.c                            | 35 +++++++++++++++++++++++++++++------
 drivers/net/tap.c                                    |  5 ++++-
 drivers/net/tun.c                                    |  3 ++-
 drivers/net/usb/cdc_ncm.c                            |  4 ++--
 drivers/net/virtio_net.c                             |  3 ++-
 include/linux/virtio_net.h                           | 11 ++++-------
 include/net/transp_v6.h                              | 11 +++++++++--
 include/net/udp.h                                    |  5 +++++
 include/uapi/linux/if_xdp.h                          |  4 ++--
 include/uapi/linux/netfilter/nf_tables.h             | 28 +++++++++++++++++++++++++---
 kernel/bpf/verifier.c                                | 48 +++++++++++++++++++++++++++++++-----------------
 kernel/umh.c                                         |  3 +--
 net/bpfilter/Makefile                                |  2 +-
 net/bpfilter/bpfilter_kern.c                         | 10 +++++++---
 net/bridge/br_fdb.c                                  |  4 +++-
 net/ipv4/ip_tunnel.c                                 |  4 ++--
 net/ipv4/tcp.c                                       | 12 +++++++-----
 net/ipv4/udp.c                                       |  2 +-
 net/ipv4/udp_diag.c                                  |  2 +-
 net/ipv6/datagram.c                                  |  6 +++---
 net/ipv6/udp.c                                       |  3 ++-
 net/netfilter/nft_log.c                              | 10 +++++-----
 net/packet/af_packet.c                               |  4 ++--
 net/sched/act_simple.c                               | 15 ++++++---------
 net/socket.c                                         | 18 +++++++++++++++---
 net/xdp/xdp_umem.c                                   |  6 ++++--
 net/xdp/xsk.c                                        |  2 +-
 tools/testing/selftests/bpf/get_cgroup_id_kern.c     | 14 +++++++++++++-
 tools/testing/selftests/bpf/get_cgroup_id_user.c     | 12 ++++++++++--
 tools/testing/selftests/bpf/test_verifier.c          | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 37 files changed, 301 insertions(+), 129 deletions(-)
