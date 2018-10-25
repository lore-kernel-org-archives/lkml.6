Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C911ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6B220831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6B220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeJYItO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:49:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36472 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:49:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTMX-0006sv-OY; Thu, 25 Oct 2018 00:18:57 +0000
Date:   Thu, 25 Oct 2018 01:18:57 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] more ->lookup() cleanups
Message-ID: <20181025001857.GD32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Some ->lookup() instances are still overcomplicating the life
for themselves, open-coding the stuff that would be handled by
d_splice_alias() just fine.  Simplify a couple of such cases caught
this cycle and document d_splice_alias() intended use.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.lookup

for you to fetch changes up to 1a16dbaf798c5b68ac767444eb045e6f3adaa16d:

  Document d_splice_alias() calling conventions for ->lookup() users. (2018-10-10 16:52:37 -0400)

----------------------------------------------------------------
Al Viro (3):
      clean erofs_lookup()
      simplify btrfs_lookup()
      Document d_splice_alias() calling conventions for ->lookup() users.

 Documentation/filesystems/porting | 11 +++++++++++
 drivers/staging/erofs/namei.c     | 19 +++++++------------
 fs/btrfs/inode.c                  | 12 +++---------
 3 files changed, 21 insertions(+), 21 deletions(-)
