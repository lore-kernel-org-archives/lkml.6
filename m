Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B402421906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbeLUUmc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:42:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52726 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbeLUUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:42:32 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0030A14A92C08;
        Fri, 21 Dec 2018 12:42:31 -0800 (PST)
Date:   Fri, 21 Dec 2018 12:42:25 -0800 (PST)
Message-Id: <20181221.124225.1063250530021518943.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Dec 2018 12:42:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some more bug fixes have trickled in, we have:

1) Local MAC entries properly in mscc driver, from Allan W. Nielsen.

2) Eric Dumazet found some more of the typical "pskb_may_pull() -->
   oops forgot to reload the header pointer" bugs in ipv6 tunnel
   handling.

3) Bad SKB socket pointer in ipv6 fragmentation handling, from Herbert
   Xu.

4) Overflow fix in sk_msg_clone(), from Vakul Garg.

5) Validate address lengths in AF_PACKET, from Willem de Bruijn.

Please pull, thanks a lot!

The following changes since commit 1d51b4b1d3f2db0d6d144175e31a84e472fbd99a:

  Merge tag 'm68k-for-v4.20-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k (2018-12-20 07:35:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to d667044f49513d55fcfefe4fa8f8d96091782901:

  qmi_wwan: Fix qmap header retrieval in qmimux_rx_fixup (2018-12-21 10:58:45 -0800)

----------------------------------------------------------------
Allan W. Nielsen (1):
      mscc: Configured MAC entries should be locked.

Daniele Palmas (1):
      qmi_wwan: Fix qmap header retrieval in qmimux_rx_fixup

Eric Dumazet (2):
      tcp: fix a race in inet_diag_dump_icsk()
      ipv6: tunnels: fix two use-after-free

Ganesh Goudar (1):
      MAINTAINERS: update cxgb4 and cxgb3 maintainer

Herbert Xu (1):
      ipv6: frags: Fix bogus skb->sk in reassembled packets

Jörgen Storvist (1):
      qmi_wwan: Add support for Fibocom NL678 series

Kangjie Lu (1):
      net: netxen: fix a missing check and an uninitialized use

Vakul Garg (2):
      Prevent overflow of sk_msg in sk_msg_clone()
      tls: Do not call sk_memcopy_from_iter with zero length

Willem de Bruijn (1):
      packet: validate address length

 MAINTAINERS                                          |  4 ++--
 drivers/net/ethernet/mscc/ocelot.c                   |  2 +-
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c |  3 ++-
 drivers/net/usb/qmi_wwan.c                           | 16 +++++++++-------
 net/core/skmsg.c                                     |  3 +++
 net/ipv4/inet_diag.c                                 |  4 +++-
 net/ipv6/ip6_tunnel.c                                |  1 +
 net/ipv6/ip6_vti.c                                   |  1 +
 net/ipv6/reassembly.c                                |  1 +
 net/packet/af_packet.c                               |  4 ++++
 net/tls/tls_sw.c                                     | 10 ++++++----
 11 files changed, 33 insertions(+), 16 deletions(-)
