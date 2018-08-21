Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53519C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AD0217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+/Esg26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AD0217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeHUSdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeHUSdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:33:19 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EEC2177F;
        Tue, 21 Aug 2018 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534864366;
        bh=XqxMX2Sk3vMS9dhxKctIinudJJ4fCE0V6sSR6ar1kmc=;
        h=Date:From:To:Cc:Subject:From;
        b=f+/Esg26oLeLza7NY1lLHBHTR5eCgA/mlQ3OqxpyyTjOdfPiM3N86QCAxUB36KB2/
         F5fDJ8zC9OQ9vpAVvBe3GFGL+9A99Xu6D5VkA+Ti4AbDs7LQx3Z+5pUzBcCaIm7APm
         gRxoO8VrJZ/UUctOtG/krzH49NH6X0FC7fCXkTdI=
Date:   Tue, 21 Aug 2018 08:12:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>, agruenba@redhat.com,
        Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] xfs: 4.19 merge, part 3
Message-ID: <20180821151244.GC4334@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a few fixes that I've queued up for 4.19.  I need to recover
from some medical events, so don't be too surprised if the next pull
request(s) come from Dave Chinner.

--D

The following changes since commit 01239d77b9dd978863d1a75f0d095ab942a1fe66:

  xfs: fix a null pointer dereference in xfs_bmap_extents_to_btree (2018-08-12 08:37:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.19-merge-7

for you to fetch changes up to 7d5e049e72c4cb933b557c78cbd63285dd8102ce:

  iomap: fix WARN_ON_ONCE on uninitialized variable (2018-08-14 08:17:02 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix an uninitialized variable
- Don't use obviously garbage AG header counters to calculate
  transaction reservations
- Trigger icount recalculation on bad icount when monting.

----------------------------------------------------------------
Darrick J. Wong (3):
      xfs: recalculate summary counters at mount time if icount is bad
      xfs: sanity check ag header values in xrep_calc_ag_resblks
      iomap: fix WARN_ON_ONCE on uninitialized variable

 fs/iomap.c            |  2 +-
 fs/xfs/scrub/repair.c | 46 +++++++++++++++++++++++++++-------------------
 fs/xfs/xfs_mount.c    |  1 +
 3 files changed, 29 insertions(+), 20 deletions(-)
