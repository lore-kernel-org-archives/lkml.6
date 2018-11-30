Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9926EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA4620863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA4620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeK3QX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:23:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40020 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeK3QX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 11:23:28 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gSb98-000688-Ps; Fri, 30 Nov 2018 05:15:22 +0000
Date:   Fri, 30 Nov 2018 05:15:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20181130051522.GM2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assorted fixes all over the place; iov_iter one is this cycle regression
(splice from UDP triggering WARN_ON()), the rest is older.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 73116df7bb90435ccb2817f44113295240d15034:

  afs: Use d_instantiate() rather than d_add() and don't d_drop() (2018-11-29 21:08:14 -0500)

----------------------------------------------------------------
Al Viro (1):
      iov_iter: teach csum_and_copy_to_iter() to handle pipe-backed ones

David Howells (3):
      afs: Fix validation/callback interaction
      afs: Fix missing net error handling
      afs: Use d_instantiate() rather than d_add() and don't d_drop()

Jens Axboe (1):
      aio: fix failure to put the file pointer

Pan Bian (1):
      exportfs: do not read dentry after free

YueHaibing (2):
      sysv: return 'err' instead of 0 in __sysv_write_inode
      exportfs: fix 'passing zero to ERR_PTR()' warning

 fs/afs/dir.c        |  4 +---
 fs/afs/fs_probe.c   | 39 ++++++++++++++++++++++++---------------
 fs/afs/inode.c      | 18 ++++++++++++------
 fs/afs/internal.h   |  9 +++++++++
 fs/afs/misc.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/rotate.c     | 53 +++++++++++++----------------------------------------
 fs/afs/vl_probe.c   | 45 +++++++++++++++++++++++++++------------------
 fs/afs/vl_rotate.c  | 50 ++++++++++----------------------------------------
 fs/aio.c            |  1 +
 fs/exportfs/expfs.c |  3 ++-
 fs/sysv/inode.c     |  2 +-
 lib/iov_iter.c      | 38 +++++++++++++++++++++++++++++++++++++-
 12 files changed, 189 insertions(+), 125 deletions(-)
