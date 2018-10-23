Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A72C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F56204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F56204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeJXDux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:50:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A66688317;
        Tue, 23 Oct 2018 19:26:08 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B94D5DA63;
        Tue, 23 Oct 2018 19:26:08 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4F43E4BB74;
        Tue, 23 Oct 2018 19:26:08 +0000 (UTC)
Date:   Tue, 23 Oct 2018 15:26:08 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     cluster-devel <cluster-devel@redhat.com>,
        linux-kernel@vger.kernel.org
Message-ID: <200314933.23623823.1540322768252.JavaMail.zimbra@redhat.com>
In-Reply-To: <1929897739.23623737.1540322729596.JavaMail.zimbra@redhat.com>
Subject: GFS2: Pull request (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.65, 10.4.195.24]
Thread-Topic: GFS2: Pull request (merge window)
Thread-Index: 75c+qw/d95wVPL2sNZrRrWbgN3LJOg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 23 Oct 2018 19:26:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Welcome back.
Please consider pulling the following changes for the GFS2 file system.

Regards,

Bob Peterson
----------------------------------------------------------------
The following changes since commit 050cdc6c9501abcd64720b8cc3e7941efee9547d:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-08-27 11:59:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.20.fixes

for you to fetch changes up to 8e31582a9ab18093c0b7708b52d7f79eed9a8688:

  gfs2: Fix minor typo: couln't versus couldn't. (2018-10-19 11:34:04 -0500)

----------------------------------------------------------------
We've got 18 patches for this merge window, none of which are very major.

1. Andreas Gruenbacher contributed several patches to clean up the gfs2
   block allocator to prepare for future performance enhancements.
2. Andy Price contributed a patch to fix a use-after-free problem.
3. I contributed some patches that fix gfs2's broken rgrplvb mount option.
4. I contributed some cleanup patches and error message improvements.
5. Steve Whitehouse and Abhi Das sent a patch to enable getlabel support.
6. Tim Smith contributed a patch to flush the glock delete workqueue at exit.

----------------------------------------------------------------
Andreas Gruenbacher (8):
      gfs2: Always check the result of gfs2_rbm_from_block
      gfs2: Clean up out-of-bounds check in gfs2_rbm_from_block
      gfs2: Move rs_{sizehint, rgd_gh} fields into the inode
      gfs2: Remove unused RGRP_RSRV_MINBYTES definition
      gfs2: Rename bitmap.bi_{len => bytes}
      gfs2: Fix some minor typos
      gfs2: Fix marking bitmaps non-full
      gfs2: Pass resource group to rgblk_free

Andrew Price (1):
      gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd

Bob Peterson (7):
      gfs2: improve debug information when lvb mismatches are found
      gfs2: Don't set GFS2_RDF_UPTODATE when the lvb is updated
      gfs2: slow the deluge of io error messages
      gfs2: Use fs_* functions instead of pr_* function where we can
      gfs2: Remove unnecessary gfs2_rlist_alloc parameter
      gfs2: write revokes should traverse sd_ail1_list in reverse
      gfs2: Fix minor typo: couln't versus couldn't.

Steve Whitehouse (1):
      gfs2: getlabel support

Tim Smith (1):
      GFS2: Flush the GFS2 delete workqueue before stopping the kernel threads

 fs/gfs2/bmap.c       |   4 +-
 fs/gfs2/dir.c        |  28 ++++---
 fs/gfs2/file.c       |  18 ++++-
 fs/gfs2/glock.c      |  17 +++--
 fs/gfs2/incore.h     |   9 +--
 fs/gfs2/lock_dlm.c   |  10 +--
 fs/gfs2/log.c        |  11 ++-
 fs/gfs2/lops.c       |   2 +-
 fs/gfs2/main.c       |   2 +
 fs/gfs2/ops_fstype.c |   2 +-
 fs/gfs2/quota.c      |   2 +-
 fs/gfs2/rgrp.c       | 201 +++++++++++++++++++++++++++++----------------------
 fs/gfs2/rgrp.h       |  11 +--
 fs/gfs2/super.c      |   4 +-
 fs/gfs2/trans.c      |  15 ++--
 fs/gfs2/util.c       |  16 ++--
 fs/gfs2/util.h       |   2 +-
 fs/gfs2/xattr.c      |  18 +++--
 18 files changed, 218 insertions(+), 154 deletions(-)
