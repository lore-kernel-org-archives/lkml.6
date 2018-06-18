Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753D8208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753D8208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbeFRC4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:56:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:47589 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754516AbeFRC4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:56:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2250AEC2;
        Mon, 18 Jun 2018 02:56:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Mon, 18 Jun 2018 12:52:50 +1000
Subject: [PATCH 0/7] Assorted rhashtables cleanups.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152929034948.23173.8671757672560065344.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following 7 patches are selections from a recent RFC series I posted
that have all received suitable Acks.

The most visible changes are that rhashtable-types.h is now preferred
for inclusion in include/linux/*.h rather than rhashtable.h, and
that the full hash is used - no bits a reserved for a NULLS pointer.

Thanks,
NeilBrown

---

NeilBrown (7):
      rhashtable: silence RCU warning in rhashtable_test.
      rhashtable: split rhashtable.h
      rhashtable: remove nulls_base and related code.
      rhashtable: simplify INIT_RHT_NULLS_HEAD()
      rhashtable: simplify nested_table_alloc() and rht_bucket_nested_insert()
      rhashtable: use cmpxchg() to protect ->future_tbl.
      rhashtable: clean up dereference of ->future_tbl.


 MAINTAINERS                                |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h |    1 
 include/linux/ipc.h                        |    2 
 include/linux/ipc_namespace.h              |    2 
 include/linux/mroute_base.h                |    2 
 include/linux/rhashtable-types.h           |  137 +++++++++++++++++++++++
 include/linux/rhashtable.h                 |  164 +---------------------------
 include/net/inet_frag.h                    |    2 
 include/net/netfilter/nf_flow_table.h      |    2 
 include/net/sctp/structs.h                 |    2 
 include/net/seg6.h                         |    2 
 include/net/seg6_hmac.h                    |    2 
 ipc/msg.c                                  |    1 
 ipc/sem.c                                  |    1 
 ipc/shm.c                                  |    1 
 ipc/util.c                                 |    1 
 lib/rhashtable.c                           |   58 +++-------
 lib/test_rhashtable.c                      |    8 +
 net/core/xdp.c                             |    4 -
 net/ipv4/inet_fragment.c                   |    1 
 net/ipv4/ipmr.c                            |    1 
 net/ipv4/ipmr_base.c                       |    1 
 net/ipv6/ip6mr.c                           |    1 
 net/ipv6/seg6.c                            |    1 
 net/ipv6/seg6_hmac.c                       |    1 
 net/netfilter/nf_tables_api.c              |    1 
 net/sctp/input.c                           |    1 
 net/sctp/socket.c                          |    1 
 28 files changed, 191 insertions(+), 212 deletions(-)
 create mode 100644 include/linux/rhashtable-types.h

--
Signature

