Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeEDDym (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44941 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeEDDyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:54:41 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 04 May 2018 13:54:14 +1000
Subject: [PATCH 0/8] Assorted rhashtable fixes and cleanups
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152540595840.18473.11298241115621799037.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some bugfixes, mostly minor though one
is worthy of a stable backport I think - tagged with Fixes and Cc: stable.

Then there are improvements to walking, which have been discussed
to some degree already.
Finally a code simplification which I think is correct...

Thanks,
NeilBrown

---

NeilBrown (8):
      rhashtable: silence RCU warning in rhashtable_test.
      rhashtable: remove nulls_base and related code.
      rhashtable: use cmpxchg() to protect ->future_tbl.
      rhashtable: fix race in nested_table_alloc()
      rhashtable: remove rhashtable_walk_peek()
      rhashtable: further improve stability of rhashtable_walk
      rhashtable: add rhashtable_walk_prev()
      rhashtable: don't hold lock on first table throughout insertion.


 include/linux/rhashtable.h |   61 +++----------
 lib/rhashtable.c           |  202 +++++++++++++++++++++-----------------------
 lib/test_rhashtable.c      |    8 +-
 3 files changed, 113 insertions(+), 158 deletions(-)

--
Signature
