Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D3BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EE520874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeLSObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:31:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbeLSObi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:31:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 888E1A0490;
        Wed, 19 Dec 2018 14:31:37 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B3BD17DF9;
        Wed, 19 Dec 2018 14:31:37 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7058A3F7CB;
        Wed, 19 Dec 2018 14:31:37 +0000 (UTC)
Date:   Wed, 19 Dec 2018 09:31:37 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     cluster-devel <cluster-devel@redhat.com>,
        linux-kernel@vger.kernel.org
Message-ID: <1374307029.56890917.1545229897334.JavaMail.zimbra@redhat.com>
In-Reply-To: <180051537.56890898.1545229879645.JavaMail.zimbra@redhat.com>
Subject: GFS2: Pull request (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.15, 10.4.195.14]
Thread-Topic: GFS2: Pull request (merge window)
Thread-Index: t5BYcXqjBmqI2h0GP0qGfQV5MQBNgQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Dec 2018 14:31:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the following changes for the GFS2 file system.

Regards,

Bob Peterson
----------------------------------------------------------------
The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.21.fixes

for you to fetch changes up to bc0205612bbd4dd4026d4ba6287f5643c37366ec:

  gfs2: take jdata unstuff into account in do_grow (2018-12-18 10:49:02 -0600)

----------------------------------------------------------------
We've got 11 patches for this merge window:

 - Enhancements and performance improvements to journal replay (Abhi Das)

 - Cleanup of gfs2_is_ordered and gfs2_is_writeback (Andreas Gruenbacher)

 - Fix a potential double-free in inode creation (Andreas Gruenbacher)

 - Fix the bitmap search loop that was searching too far (Andreas Gruenbacher)

 - Various cleanups (Andreas Gruenbacher, Bob Peterson)

 - Implement Steve Whitehouse's patch to dump nrpages for inodes (Bob Peterson)

 - Fix a withdraw bug where stuffed journaled data files didn't allocate
   enough journal space to be grown (Bob Peterson)

----------------------------------------------------------------
Abhi Das (4):
      gfs2: add more timing info to journal recovery process
      gfs2: changes to gfs2_log_XXX_bio
      gfs2: add a helper function to get_log_header that can be used elsewhere
      gfs2: read journal in large chunks to locate the head

Andreas Gruenbacher (4):
      gfs2: Clean up gfs2_is_{ordered,writeback}
      gfs2: Fix the gfs2_invalidatepage description
      gfs2: Get rid of potential double-freeing in gfs2_create_inode
      gfs2: Fix loop in gfs2_rbm_find

Bob Peterson (3):
      gfs2: Remove vestigial bd_ops
      gfs2: Dump nrpages for inodes and their glocks
      gfs2: take jdata unstuff into account in do_grow

 fs/gfs2/aops.c       |  16 ++--
 fs/gfs2/bmap.c       |  10 +-
 fs/gfs2/glock.c      |   2 +-
 fs/gfs2/glock.h      |   2 +-
 fs/gfs2/glops.c      |  17 +++-
 fs/gfs2/incore.h     |   3 +-
 fs/gfs2/inode.c      |  18 ++--
 fs/gfs2/inode.h      |  10 +-
 fs/gfs2/log.c        |   5 +-
 fs/gfs2/log.h        |   5 +-
 fs/gfs2/lops.c       | 257 +++++++++++++++++++++++++++++++++++++++++++--------
 fs/gfs2/lops.h       |   4 +-
 fs/gfs2/ops_fstype.c |   1 +
 fs/gfs2/recovery.c   | 178 +++++++----------------------------
 fs/gfs2/recovery.h   |   5 +-
 fs/gfs2/rgrp.c       |   4 +-
 fs/gfs2/rgrp.h       |   2 +-
 fs/gfs2/super.c      |   1 +
 fs/gfs2/trans.c      |   8 +-
 19 files changed, 317 insertions(+), 231 deletions(-)
