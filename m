Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD8FC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DCD2172F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DCD2172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJUG7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:59:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36118 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeJUG7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:59:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3A202140A704B;
        Sat, 20 Oct 2018 15:47:38 -0700 (PDT)
Date:   Sat, 20 Oct 2018 15:47:37 -0700 (PDT)
Message-Id: <20181020.154737.106692150032143674.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 20 Oct 2018 15:47:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A few straggler bug fixes:

1) Fix indexing of multi-pass dumps of ipv6 addresses, from David
   Ahern.

2) Revert RCU locking change for bonding netpoll, causes worse problems
   than it solves.

3) pskb_trim_rcsum_slow() doesn't handle odd trim offsets, resulting in
   erroneous bad hw checksum triggers with CHECKSUM_COMPLETE devices.
   From Dimitris Michailidis.

Please pull, thanks a lot!

The following changes since commit 91b15613ce7fb3e724ca0d433eef8e6bf15322af:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-19 09:16:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to 4ba4c566ba8448a05e6257e0b98a21f1a0d55315:

  net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs (2018-10-20 15:43:14 -0700)

----------------------------------------------------------------
David Ahern (1):
      net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs

David S. Miller (1):
      Revert "bond: take rcu lock in netpoll_send_skb_on_dev"

Dimitris Michailidis (1):
      net: fix pskb_trim_rcsum_slow() with odd trim offset

 net/core/netpoll.c  | 2 --
 net/core/skbuff.c   | 5 +++--
 net/ipv6/addrconf.c | 6 ++++--
 3 files changed, 7 insertions(+), 6 deletions(-)
