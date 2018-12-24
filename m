Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C4C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EB4218D2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uXPzhB4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeLXA05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 19:26:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34736 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeLXA05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 19:26:57 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBO0QqPL156118;
        Mon, 24 Dec 2018 00:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=/E/ohEbDkq72XAfSYrTv/dYJbfOVeZL6LgtPOGsxclE=;
 b=uXPzhB4qT3wbNiYhghXsczTwEowDz0mWvizR1DxnVxCgb4Yr91vYau3WsfOo7tcdz4X4
 b4vIquezPiSFClPCwJm0Xi0nqGQgjgqE7NaYbTYpOHkfz1IhFFekvxN69CixHKbCySaJ
 WiJMI5WcHZ3jAjzp1UAwSNG7EHdjYO1rP3oqK3WZgbvh4IK6f9Jq/ubdMKxBzWdONEFn
 Gra6kRKxGyYdzX1jjt5djrQQCnjCx4dXzFZtxNJI5AotL7lcuorrjbnWJ8+BdVsqGCPo
 sTy/+QVA7K2gH0EInhZezZ6MLR+OYt+TCQpiW/27XzfwfzbLxtHsZETKf8Lx1rmU92zD Aw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2phasdk5nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Dec 2018 00:26:52 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBO0Qp34012361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Dec 2018 00:26:51 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBO0Qp5p009318;
        Mon, 24 Dec 2018 00:26:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Dec 2018 16:26:50 -0800
Date:   Sun, 23 Dec 2018 16:26:49 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: [GIT PULL] xfs: updates for v4.21
Message-ID: <20181224002649.GJ27208@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9116 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812240001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a number of bug fixes for 4.21-rc1.  It has undergone the usual
testing regimen and merges cleanly with 4.20 final.  Let me know if you
encounter any problems with the merge.

--D

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.21-merge-2

for you to fetch changes up to 65eed012d1f2d0f0bf0ffc036826d58147de77b8:

  xfs: reallocate realtime summary cache on growfs (2018-12-21 18:45:18 -0800)

----------------------------------------------------------------
XFS changes for 4.21:
- Fix CoW remapping of extremely fragmented file areas
- Fix a zero-length symlink verifier error
- Constify some of the rmap owner structures for per-AG metadata
- Precalculate inode geometry for later use
- Fix scrub counting problems
- Don't crash when rtsummary inode is null
- Fix x32 ioctl operation
- Fix enum->string mappings for ftrace output
- Cache realtime summary information in memory

----------------------------------------------------------------
Colin Ian King (1):
      xfs: clean up indentation issues, remove an unwanted space

Darrick J. Wong (16):
      xfs: split up the xfs_reflink_end_cow work into smaller transactions
      xfs: idiotproof defer op type configuration
      xfs: streamline defer op type handling
      xfs: const-ify xfs_owner_info arguments
      xfs: remove xfs_rmap_ag_owner and friends
      xfs: add a block to inode count converter
      xfs: precalculate inodes and blocks per inode cluster
      xfs: precalculate cluster alignment in inodes and blocks
      xfs: count inode blocks correctly in inobt scrub
      xfs: require both realtime inodes to mount
      xfs: fix function pointer type in ftrace format
      xfs: fix symbolic enum printing in ftrace output
      xfs: move XFS_AG_BTREE_CMP_FORMAT_STR mappings to libxfs
      xfs: move XFS_INODE_FORMAT_STR mappings to libxfs
      xfs: stringify btree cursor types in ftrace output
      xfs: stringify scrub types in ftrace output

Dave Chinner (1):
      xfs: zero length symlinks are not valid

Nick Bowler (3):
      xfs: Align compat attrlist_by_handle with native implementation.
      xfs: Fix bulkstat compat ioctls on x32 userspace.
      xfs: Fix x32 ioctls when cmd numbers differ from ia32.

Omar Sandoval (2):
      xfs: cache minimum realtime summary level
      xfs: reallocate realtime summary cache on growfs

Pan Bian (1):
      xfs: libxfs: move xfs_perag_put late

 fs/xfs/libxfs/xfs_ag.c             |   9 +-
 fs/xfs/libxfs/xfs_alloc.c          |  79 ++++++------
 fs/xfs/libxfs/xfs_alloc.h          |   4 +-
 fs/xfs/libxfs/xfs_bmap.c           |   6 +-
 fs/xfs/libxfs/xfs_bmap.h           |   4 +-
 fs/xfs/libxfs/xfs_defer.c          |  67 ++++++-----
 fs/xfs/libxfs/xfs_defer.h          |  37 +++---
 fs/xfs/libxfs/xfs_format.h         |  12 ++
 fs/xfs/libxfs/xfs_ialloc.c         |  54 ++++-----
 fs/xfs/libxfs/xfs_ialloc_btree.c   |   7 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |   6 +-
 fs/xfs/libxfs/xfs_rmap.c           | 240 +++++++++++++++++++++----------------
 fs/xfs/libxfs/xfs_rmap.h           |  54 ++++-----
 fs/xfs/libxfs/xfs_rtbitmap.c       |   6 +
 fs/xfs/libxfs/xfs_symlink_remote.c |  14 ++-
 fs/xfs/libxfs/xfs_types.c          |   9 +-
 fs/xfs/libxfs/xfs_types.h          |  22 ++++
 fs/xfs/scrub/agheader.c            |  25 ++--
 fs/xfs/scrub/agheader_repair.c     |   5 +-
 fs/xfs/scrub/alloc.c               |   4 +-
 fs/xfs/scrub/btree.c               |  45 +++----
 fs/xfs/scrub/btree.h               |  22 ++--
 fs/xfs/scrub/common.c              |  14 +--
 fs/xfs/scrub/common.h              |   2 +-
 fs/xfs/scrub/ialloc.c              |  64 +++++-----
 fs/xfs/scrub/inode.c               |   4 +-
 fs/xfs/scrub/refcount.c            |  16 +--
 fs/xfs/scrub/repair.c              |  54 ++++-----
 fs/xfs/scrub/repair.h              |   7 +-
 fs/xfs/scrub/rmap.c                |  35 +++---
 fs/xfs/scrub/scrub.h               |   4 +-
 fs/xfs/scrub/trace.h               | 131 +++++++++++++++-----
 fs/xfs/xfs_aops.h                  |   3 +
 fs/xfs/xfs_extfree_item.c          |   5 +-
 fs/xfs/xfs_fsops.c                 |   2 +-
 fs/xfs/xfs_inode.c                 |  16 +--
 fs/xfs/xfs_ioctl32.c               |  58 +++++++--
 fs/xfs/xfs_itable.c                |  14 +--
 fs/xfs/xfs_log_recover.c           |   8 +-
 fs/xfs/xfs_mount.c                 |   4 +
 fs/xfs/xfs_mount.h                 |  11 ++
 fs/xfs/xfs_reflink.c               | 232 ++++++++++++++++++++---------------
 fs/xfs/xfs_rtalloc.c               |  57 +++++++--
 fs/xfs/xfs_super.c                 |  10 +-
 fs/xfs/xfs_symlink.c               |  33 ++---
 fs/xfs/xfs_trace.h                 |  51 +++++---
 fs/xfs/xfs_trans.h                 |   7 +-
 fs/xfs/xfs_trans_bmap.c            |  11 +-
 fs/xfs/xfs_trans_extfree.c         |  40 +++----
 fs/xfs/xfs_trans_refcount.c        |  11 +-
 fs/xfs/xfs_trans_rmap.c            |  11 +-
 51 files changed, 932 insertions(+), 714 deletions(-)
