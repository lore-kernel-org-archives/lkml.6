Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E16C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FB220658
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FB220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeJKHUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:20:07 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:32591 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbeJKHUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:20:07 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 11 Oct 2018 10:25:35 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gAOKE-0003MO-CR; Thu, 11 Oct 2018 10:55:34 +1100
Date:   Thu, 11 Oct 2018 10:55:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     gregkh@linuxfoundation.org
Cc:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: [GIT PULL] xfs: fixes for v4.19-rc7
Message-ID: <20181010235534.GA8838@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Can you please pull the XFS update from the tag listed below? This
contains the fix for the clone_file_range data corruption issue I
mentioned in my -rc6 pull request (zero post-eof blocks), as well as
fixes for several other equally serious problems we found while
auditing the clone/dedupe ioctls for other issues. The rest of the
problems we found (there were a *lot*) will be addressed in the 4.20
cycle.

Cheers,

Dave.

The following changes since commit e55ec4ddbef9897199c307dfb23167e3801fdaf5:

  xfs: fix error handling in xfs_bmap_extents_to_btree (2018-10-01 08:11:07 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux tags/xfs-fixes-for-4.19-rc7

for you to fetch changes up to b39989009bdb84992915c9869f58094ed5becf10:

  xfs: fix data corruption w/ unaligned reflink ranges (2018-10-06 11:44:39 +1000)

----------------------------------------------------------------
xfs: fixes for 4.19-rc7

Update for 4.19-rc7 to fix numerous file clone and deduplication issues.

----------------------------------------------------------------
Darrick J. Wong (3):
      xfs: refactor clonerange preparation into a separate helper
      xfs: zero posteof blocks when cloning above eof
      xfs: update ctime and remove suid before cloning files

Dave Chinner (2):
      xfs: fix data corruption w/ unaligned dedupe ranges
      xfs: fix data corruption w/ unaligned reflink ranges

 fs/xfs/xfs_reflink.c | 200 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 165 insertions(+), 35 deletions(-)

-- 
Dave Chinner
david@fromorbit.com
