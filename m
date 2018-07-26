Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80781C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3315D20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiFVAHnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3315D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbeGZTkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbeGZTkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:40:43 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2200020862;
        Thu, 26 Jul 2018 18:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532629364;
        bh=cUy9VX+WlepETxczmcR2VjpohG9X9O2MU3xllAhYwYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiFVAHnjNavhL/CK7sgyh1BqZFIt+YjGVDDfTUK1G7gOAFhfGc+hDOoeP9e3pxF2x
         cd5hnWnVYO+4ClG8sRDW9YifdxTwv2Daho0ZkG23zTXhUMJLK68lo5BjhC/klff8kN
         U42onAjJlc4iR/XmmKE5ZxmWVdgg/NRM6iQ8TW8U=
Date:   Thu, 26 Jul 2018 11:22:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Subject: [GIT PULL] xfs: 4.18 fixes, part 2
Message-ID: <20180726182243.GG30972@magnolia>
References: <20180627182421.GE5711@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627182421.GE5711@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a couple of late patches for 4.18 to fix a coding bug
introduced in -rc1 and a fix for incorrect metadata verification of
on-disk data.

This series has been run through a full xfstests run over the weekend
and through a quick xfstests run against this morning's master, with no
major failures reported.

--D

The following changes since commit d8cb5e42378918e00eda58792f3ab86dd1e7d214:

  xfs: fix fdblocks accounting w/ RMAPBT per-AG reservation (2018-06-24 12:00:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.18-fixes-4

for you to fetch changes up to d4a34e16555708bab5b67e679a95f055d8ef9882:

  xfs: properly handle free inodes in extent hint validators (2018-07-24 11:34:52 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix some uninitialized variable errors
- Fix an incorrect check in metadata verifiers

----------------------------------------------------------------
Carlos Maiolino (1):
      xfs: Initialize variables in xfs_alloc_get_rec before using them

Eric Sandeen (1):
      xfs: properly handle free inodes in extent hint validators

 fs/xfs/libxfs/xfs_alloc.c     | 5 +++--
 fs/xfs/libxfs/xfs_inode_buf.c | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)
