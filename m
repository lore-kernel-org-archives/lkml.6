Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A75DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADAA21919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549623269;
	bh=jRy73PEi6cLePEwFOQxJZvXBFQvTuvFNjB8IzKxb8/Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ESWgIYNB5cP71QaC8KbenE3SKr0C0zTrqOrlv32kngato/IWqqlsqHiEhvwWa21YM
	 oK9hNqxN4U09yrK3LwoZq709kqOffOHq7488iiz3PBi41uo8Aw6blx3mtkPuSkIClb
	 55cnZ4cCia0TtRYh6I/AEej5Bh3sL1CoDnDux6E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfBHKy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfBHKy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:54:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B40421919;
        Fri,  8 Feb 2019 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549623264;
        bh=jRy73PEi6cLePEwFOQxJZvXBFQvTuvFNjB8IzKxb8/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=wcsV5bO/zCG7KD6NoOqACvlrC3d6HEukY6Z94Fr4FKmnDGIHpcFHpEqwdwNmotpaH
         DZEhUvd7FCi8Fd2tm0hQyBYLQOwzAzpf7dU596wbcz/sqlxCUoq7t/Xgw8KUbHQaRd
         4rcGtbTJl4m3L39x80dJWP5/hYovIVVfQu5Xj2TE=
Date:   Fri, 8 Feb 2019 11:54:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.174
Message-ID: <20190208105422.GA32328@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.4.174 kernel.

All users of the 4.4 kernel series must upgrade.

Many thanks to Ben Hutchings for this release, it's pretty much just his
work here in doing the backporting of networking fixes to help resolve
"FragmentSmack" (i.e. CVE-2018-5391).

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/networking/ip-sysctl.txt  |   13 
 Makefile                                |    2 
 include/linux/rhashtable.h              |  143 ++++++--
 include/linux/skbuff.h                  |   16 
 include/net/inet_frag.h                 |  133 +++----
 include/net/ip.h                        |    1 
 include/net/ipv6.h                      |   26 -
 include/uapi/linux/snmp.h               |    1 
 kernel/rcu/tree.c                       |    2 
 lib/rhashtable.c                        |   15 
 net/core/skbuff.c                       |   21 +
 net/ieee802154/6lowpan/6lowpan_i.h      |   26 -
 net/ieee802154/6lowpan/reassembly.c     |  148 ++++----
 net/ipv4/inet_fragment.c                |  389 ++++-----------------
 net/ipv4/ip_fragment.c                  |  571 +++++++++++++++++---------------
 net/ipv4/proc.c                         |    7 
 net/ipv6/netfilter/nf_conntrack_reasm.c |  100 ++---
 net/ipv6/proc.c                         |    5 
 net/ipv6/reassembly.c                   |  209 ++++++-----
 19 files changed, 867 insertions(+), 961 deletions(-)

Alexander Aring (1):
      net: ieee802154: 6lowpan: fix frag reassembly

Ben Hutchings (1):
      rhashtable: Add rhashtable_lookup()

Dan Carpenter (1):
      ipv4: frags: precedence bug in ip_expire()

Dimitris Michailidis (1):
      net: fix pskb_trim_rcsum_slow() with odd trim offset

Eric Dumazet (19):
      inet: frags: change inet_frags_init_net() return value
      inet: frags: add a pointer to struct netns_frags
      inet: frags: refactor ipfrag_init()
      inet: frags: refactor ipv6_frag_init()
      inet: frags: refactor lowpan_net_frag_init()
      rhashtable: add schedule points
      inet: frags: use rhashtables for reassembly units
      inet: frags: remove some helpers
      inet: frags: get rif of inet_frag_evicting()
      inet: frags: remove inet_frag_maybe_warn_overflow()
      inet: frags: break the 2GB limit for frags storage
      inet: frags: do not clone skb in ip_expire()
      ipv6: frags: rewrite ip6_expire_frag_queue()
      rhashtable: reorganize struct rhashtable layout
      inet: frags: reorganize struct netns_frags
      inet: frags: get rid of ipfrag_skb_cb/FRAG_CB
      inet: frags: fix ip6frag_low_thresh boundary
      net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends
      inet: frags: better deal with smp races

Florian Westphal (1):
      ipv6: defrag: drop non-last frags smaller than min mtu

Greg Kroah-Hartman (1):
      Linux 4.4.174

Michal Kubecek (1):
      net: ipv4: do not handle duplicate fragments as overlapping

Pablo Neira Ayuso (1):
      rhashtable: add rhashtable_lookup_get_insert_key()

Paolo Abeni (1):
      ipfrag: really prevent allocation on netns exit

Paul E. McKenney (1):
      rcu: Force boolean subscript for expedited stall warnings

Peter Oskolkov (5):
      ip: discard IPv4 datagrams with overlapping segments.
      net: modify skb_rbtree_purge to return the truesize of all purged skbs.
      ip: use rb trees for IP frag queue.
      ip: add helpers to process in-order fragments faster.
      ip: process in-order fragments efficiently

Taehee Yoo (1):
      ip: frags: fix crash in ip_do_fragment()

