Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D3C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8568E218CD
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8568E218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeHMBeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 21:34:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34768 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeHMBeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 21:34:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fozG6-0002Jc-8C; Sun, 12 Aug 2018 22:54:50 +0000
Date:   Sun, 12 Aug 2018 23:54:50 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] more conversions of ->lookup() to d_splice_alias()
Message-ID: <20180812225450.GO6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should be reasonably complete now - the only leftovers are in ceph.

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.lookup

for you to fetch changes up to 808aa6c5e34a25213bff4d80d3cdb588752879dd:

  Merge branch 'work.hpfs' into work.lookup (2018-08-05 15:51:10 -0400)

----------------------------------------------------------------
Al Viro (6):
      hostfs_lookup: switch to d_splice_alias()
      hpfs: fix an inode leak in lookup, switch to d_splice_alias()
      afs: switch dynroot lookups to d_splice_alias()
      afs_lookup(): switch to d_splice_alias()
      afs_try_auto_mntpt(): return NULL instead of ERR_PTR(-ENOENT)
      Merge branch 'work.hpfs' into work.lookup

 fs/afs/dir.c            | 45 ++++++++++-----------------------------------
 fs/afs/dynroot.c        | 25 ++-----------------------
 fs/hostfs/hostfs_kern.c | 28 ++++++++--------------------
 fs/hpfs/dir.c           | 23 +++++++----------------
 4 files changed, 27 insertions(+), 94 deletions(-)
