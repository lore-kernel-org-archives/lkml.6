Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C81ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4342147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="FqMJ88fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4342147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIQKKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:10:25 -0400
Received: from imap.thunk.org ([74.207.234.97]:39260 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeIQKKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xYqv5IpZSarqC1qLaGz5QJpvhxy0MqfvvN8mzfM1qCE=; b=FqMJ88fgiQxIBh1rrFc1i1M5dO
        yy5EEMU2Qx9gNmwSVtDSTtbx2ojO1Zz36yjUWSox30QSta0bPRCiiOV6pBaA4UeaaW6NVh15V8l0w
        AG9BK1cl2h/8k7IiDF/LfJrimcOOmnpUJvw2q5+3QnS2NkE5JESIiDL4Ev0vXV6RGPIw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g1lOv-0005qP-Qs; Mon, 17 Sep 2018 04:44:45 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BC63C7A586E; Mon, 17 Sep 2018 00:44:44 -0400 (EDT)
Date:   Mon, 17 Sep 2018 00:44:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 4.19-rc5
Message-ID: <20180917044444.GA29836@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ This pull request was originally intended for 4.19-rc4, but some
  testing hiccups delayed my sending this earlier.  Given Linus's
  comments, I'm not sure whether PULL requests should be going to Linus
  or Greg, so I'm sending it to both.  -- Ted ]

The following changes since commit 863c37fcb14f8b66ea831b45fb35a53ac4a8d69e:

  ext4: remove unneeded variable "err" in ext4_mb_release_inode_pa() (2018-08-04 17:34:07 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to cce6c9f7e6029caee45c459db5b3e78fec6973cb:

  ext4, dax: set ext4_dax_aops for dax files (2018-09-15 21:37:59 -0400)

----------------------------------------------------------------
Various ext4 bug fixes; primarily making ext4 more robust against
maliciously crafted file systems, and some DAX fixes.

----------------------------------------------------------------
Eric Biggers (1):
      ext4: show test_dummy_encryption mount option in /proc/mounts

Li Dongyang (1):
      ext4: don't mark mmp buffer head dirty

Ross Zwisler (1):
      ext4: close race between direct IO and ext4_break_layouts()

Theodore Ts'o (7):
      ext4: add nonstring annotations to ext4.h
      ext4: check to make sure the rename(2)'s destination is not freed
      ext4: avoid divide by zero fault when deleting corrupted inline directories
      ext4: avoid arithemetic overflow that can trigger a BUG
      ext4: recalucate superblock checksum after updating free blocks/inodes
      ext4: fix online resize's handling of a too-small final block group
      ext4: fix online resizing for bigalloc file systems with a 1k block size

Toshi Kani (2):
      ext4, dax: add ext4_bmap to ext4_dax_aops
      ext4, dax: set ext4_dax_aops for dax files

 fs/ext4/dir.c    | 20 +++++++++-----------
 fs/ext4/ext4.h   | 20 +++++++++++++++++---
 fs/ext4/inline.c |  4 +++-
 fs/ext4/inode.c  | 20 +++++++++++---------
 fs/ext4/mmp.c    |  1 -
 fs/ext4/namei.c  |  6 ++++++
 fs/ext4/resize.c | 23 ++++++++++++++++++++++-
 fs/ext4/super.c  |  4 ++++
 8 files changed, 72 insertions(+), 26 deletions(-)
