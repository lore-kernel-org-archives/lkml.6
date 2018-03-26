Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeC0BvQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:51:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:38945 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeC0BvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:51:15 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 27 Mar 2018 10:33:04 +1100
Subject: [PATCH 0/6] rhashtable: assorted fixes and enhancements
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152210688405.11435.13010923693146415942.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I'm hoping to use rhashtable in lustre, to replace the resizeable
 hashtable implementation in libcfs.
 While working through the conversion I found some minor bugs in the
 rhashtable code and documentation, and some areas where enhancements
 could make rhashtable a better fit for lustre.

 Following 6 patches are the result.  Please review.

 It would help me if I could get an Ack for these patches, and could
 then submit them through the drivers/staging tree together with the
 lustre changes that make use to rhashtable.  The first 2 are mostly
 just fixes to comments and can go in through the netdev tree if you
 prefer - the last 4 are needed for lustre to work
 correctly/optimally.

Thanks,
NeilBrown


---

NeilBrown (6):
      rhashtable: improve documentation for rhashtable_walk_peek()
      rhashtable: remove outdated comments about grow_decision etc
      rhashtable: reset iter when rhashtable_walk_start sees new table
      rhashtable: allow a walk of the hash table without missing objects.
      rhashtable: support guaranteed successful insertion.
      rhashtable: allow element counting to be disabled.


 include/linux/rhashtable.h |   89 ++++++++++++++++++++++++++++----------
 lib/rhashtable.c           |  102 +++++++++++++++++++++++++++++++-------------
 2 files changed, 136 insertions(+), 55 deletions(-)

--
Signature
