Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeDRHOe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36313 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752634AbeDRHOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:14:33 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 18 Apr 2018 16:47:01 +1000
Subject: [PATCH 0/6] Assorted rhashtable improvements. RESEND
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152403346237.16895.8767189357062722046.stgit2@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[[ I mistyped linux-kernel the first time I sent these, so
   resending.  Please reply to this set.  Sorry - neilb ]]


Some of these have been posted before and a couple
received an Ack from Herbert, but haven't appeared in any git tree
yet.
Another (the first) has been sent but received no ack.

I've added the second patch, which removes more incorrect
documentation, and added the last two patches.

One further improves rhashtable_walk stability.
The last added rhashtable_walk_prev(), as discussed with Herbert,
which should be useful for seq_files.
(Separately I've posted a patch to Al Viro to make seq_file even
easier to use with rhashtables, but this series does not depend
on that patch).

I don't see these patches as particularly urgent, though the third is a
bugfix that currently prevents me from allowing one rhashtable in
lustre to auto-shrink.

I previously suggested it might be good for some of these patches to
go upstream through 'staging' with the lustre patches.  I no longer
think that is necessary.  It is probably best for them to go upstream
through net or net-next.

Thanks,
NeilBrown


---

NeilBrown (6):
      rhashtable: remove outdated comments about grow_decision etc
      rhashtable: remove incorrect comment on r{hl,hash}table_walk_enter()
      rhashtable: reset iter when rhashtable_walk_start sees new table
      rhashtable: improve rhashtable_walk stability when stop/start used.
      rhashtable: further improve stability of rhashtable_walk
      rhashtable: add rhashtable_walk_prev()


 include/linux/rhashtable.h |   49 +++++++++---------
 lib/rhashtable.c           |  121 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 126 insertions(+), 44 deletions(-)

--
Signature
