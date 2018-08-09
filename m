Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05209C46471
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86A221C36
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86A221C36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeHIH3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:29:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49854 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeHIH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:29:52 -0400
Received: from localhost (unknown [172.58.40.33])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6F5A51410605F;
        Wed,  8 Aug 2018 22:06:54 -0700 (PDT)
Date:   Wed, 08 Aug 2018 22:06:51 -0700 (PDT)
Message-Id: <20180808.220651.779695096932870433.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Aug 2018 22:06:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) The real fix for the ipv6 route metric leak Sabrina was seeing,
   from Cong Wang.

2) Fix syzbot triggers AF_PACKET v3 ring buffer insufficient room
   conditions, from Willem de Bruijn.

3) vsock can reinitialize active work struct, fix from Cong Wang.

4) RXRPC keepalive generator can wedge a cpu, fix from David Howells.

5) Fix locking in AF_SMC ioctl, from Ursula Braun.

Please pull, thanks a lot!

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 1be52e97ed3e524f82e25d6e53f48df3c6e85282:

  dsa: slave: eee: Allow ports to use phylink (2018-08-08 19:19:03 -0700)

----------------------------------------------------------------
Al Viro (1):
      cxgb4: mk_act_open_req() buggers ->{local, peer}_ip on big-endian hosts

Alexey Kodanev (1):
      dccp: fix undefined behavior with 'cwnd' shift in ccid2_cwnd_restart()

Andrew Lunn (1):
      dsa: slave: eee: Allow ports to use phylink

Colin Ian King (1):
      net: thunderx: check for failed allocation lmac->dmacs

Cong Wang (3):
      ipv6: fix double refcount of fib6_metrics
      vsock: split dwork to avoid reinitializations
      llc: use refcount_inc_not_zero() for llc_sap_find()

David Howells (1):
      rxrpc: Fix the keepalive generator [ver #2]

David S. Miller (2):
      Merge branch 'mlx5-fixes'
      Merge branch 'smc-fixes'

Dmitry Bogdanov (1):
      net: aquantia: Fix IFF_ALLMULTI flag functionality

Huy Nguyen (1):
      net/mlx5e: Cleanup of dcbnl related fields

Jason Wang (1):
      vhost: reset metadata cache when initializing new IOTLB

Or Gerlitz (1):
      net/mlx5e: Properly check if hairpin is possible between two functions

Ursula Braun (3):
      net/smc: no shutdown in state SMC_LISTEN
      net/smc: allow sysctl rmem and wmem defaults for servers
      net/smc: move sock lock in smc_ioctl()

Willem de Bruijn (1):
      packet: refine ring v3 block size test to hold one frame

Xin Long (1):
      ip6_tunnel: use the right value for ipv4 min mtu check in ip6_tnl_xmit

Ying Xue (1):
      tipc: fix an interrupt unsafe locking scenario

 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c |   2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c         |   2 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c         |   6 +--
 drivers/net/ethernet/mellanox/mlx5/core/en.h              |   2 -
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c        |  30 +++++---------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c           |   8 ++--
 drivers/vhost/vhost.c                                     |   9 ++--
 include/net/af_vsock.h                                    |   4 +-
 include/net/llc.h                                         |   5 +++
 net/dccp/ccids/ccid2.c                                    |   6 ++-
 net/dsa/slave.c                                           |   4 +-
 net/ipv6/ip6_tunnel.c                                     |   8 +---
 net/ipv6/route.c                                          |   4 --
 net/llc/llc_core.c                                        |   4 +-
 net/packet/af_packet.c                                    |  10 +++--
 net/rxrpc/ar-internal.h                                   |   8 ++--
 net/rxrpc/conn_event.c                                    |   4 +-
 net/rxrpc/net_ns.c                                        |   6 +--
 net/rxrpc/output.c                                        |  12 +++---
 net/rxrpc/peer_event.c                                    | 156 +++++++++++++++++++++++++++++++++++++++-------------------------------
 net/rxrpc/peer_object.c                                   |   8 ++--
 net/rxrpc/rxkad.c                                         |   4 +-
 net/smc/af_smc.c                                          |  15 ++++---
 net/tipc/net.c                                            |   4 +-
 net/vmw_vsock/af_vsock.c                                  |  15 +++----
 net/vmw_vsock/vmci_transport.c                            |   3 +-
 26 files changed, 178 insertions(+), 161 deletions(-)
