Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeDKGDb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:03:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeDKGD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:03:29 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 0/2] Fix __GFP_ZERO vs constructor
Date: Tue, 10 Apr 2018 23:03:18 -0700
Message-Id: <20180411060320.14458-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

v1->v2:
 - Added review/ack tags (thanks!)
 - Switched the order of the patches
 - Reworded commit message of the patch which actually fixes the bug
 - Moved slab debug patches under CONFIG_DEBUG_VM to check _every_
   allocation and added checks in the slowpath for the allocations which
   end up allocating a page.

Matthew Wilcox (2):
  Fix NULL pointer in page_cache_tree_insert
  slab: __GFP_ZERO is incompatible with a constructor

 mm/filemap.c | 9 ++++-----
 mm/slab.c    | 7 ++++---
 mm/slab.h    | 7 +++++++
 mm/slob.c    | 4 +++-
 mm/slub.c    | 5 +++--
 5 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.16.3
