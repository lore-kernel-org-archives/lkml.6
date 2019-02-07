Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B9421901
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfBGBcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 20:32:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:39684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbfBGBcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 20:32:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EEAAAFA8;
        Thu,  7 Feb 2019 01:32:06 +0000 (UTC)
Date:   Wed, 6 Feb 2019 17:31:55 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jgg@ziepe.ca, akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/6] Documentation/infiniband: update from locked to pinned_vm
Message-ID: <20190207013155.lq5diwqc2svyt3t3@linux-r8p5>
Mail-Followup-To: jgg@ziepe.ca, akpm@linux-foundation.org,
        dledford@redhat.com, jgg@mellanox.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190206175920.31082-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190206175920.31082-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are really talking about pinned_vm here.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 Documentation/infiniband/user_verbs.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/infiniband/user_verbs.txt b/Documentation/infiniband/user_verbs.txt
index df049b9f5b6e..47ebf2f80b2b 100644
--- a/Documentation/infiniband/user_verbs.txt
+++ b/Documentation/infiniband/user_verbs.txt
@@ -46,11 +46,11 @@ Memory pinning
   I/O targets be kept resident at the same physical address.  The
   ib_uverbs module manages pinning and unpinning memory regions via
   get_user_pages() and put_page() calls.  It also accounts for the
-  amount of memory pinned in the process's locked_vm, and checks that
+  amount of memory pinned in the process's pinned_vm, and checks that
   unprivileged processes do not exceed their RLIMIT_MEMLOCK limit.
 
   Pages that are pinned multiple times are counted each time they are
-  pinned, so the value of locked_vm may be an overestimate of the
+  pinned, so the value of pinned_vm may be an overestimate of the
   number of pages pinned by a process.
 
 /dev files
-- 
2.16.4
