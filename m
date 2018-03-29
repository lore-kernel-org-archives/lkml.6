Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeC2BUi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:20:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:44258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeC2BUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:20:37 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 29 Mar 2018 12:19:09 +1100
Subject: [PATCH 0/2] rhashtable_walk fixes
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152228607974.16370.14544827502467836789.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches apply on top of my previous "rhashtable: reset iter
when rhashtable_walk_start sees new table" patch.

The first fixes a bug that I found in rhltable_insert().

The second is an alternate to my "rhashtable: allow a walk of the hash
table without missing object."
This version doesn't require an API change and should be reliable for
rhltables too (my first version didn't handle these correctly).

Thanks,
NeilBrown


---

NeilBrown (2):
      rhashtable: fix insertion of in rhltable when duplicate found.
      rhashtable: improve rhashtable_walk stability when stop/start used.


 include/linux/rhashtable.h |    4 +++-
 lib/rhashtable.c           |   48 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)

--
Signature
