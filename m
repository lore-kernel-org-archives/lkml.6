Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA3C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F7021775
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5mcnghp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F7021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeHDHQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 03:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHDHQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 03:16:38 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB16221782;
        Sat,  4 Aug 2018 05:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533359839;
        bh=aoG1fOmkP0MT5yiOZ4pmRrcuUDEcfAqgCBtJs05TmQ4=;
        h=Date:From:To:Cc:Subject:From;
        b=j5mcnghpQtuOIuxTkBUv0Ug1N7wd+F0MZzTOXIKcbmC69//uP91idisDAT5vwJ8bx
         OXk9iLr11ScN4G7DVKIaTmdpOVFGR5wY2h781X1+OnN/7ouIQ+5ZvPpvYSpucCZA3A
         zNELoLbXnyZ2gYc5mQbwtn84SaZ5aO3HGalRUmvM=
Date:   Fri, 3 Aug 2018 22:17:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Subject: [GIT PULL] xfs: 4.18 fixes, part 3
Message-ID: <20180804051718.GY30972@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's one more patch for 4.18 to fix a coding error in the iomap_bmap
function introduced in -rc1.

This series has been run through a full xfstests run during the week and
through a quick xfstests run against this morning's master, with no
major failures reported.

--D

The following changes since commit d4a34e16555708bab5b67e679a95f055d8ef9882:

  xfs: properly handle free inodes in extent hint validators (2018-07-24 11:34:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.18-fixes-5

for you to fetch changes up to 79b3dbe4adb3420e74cf755b4beb5d2b43d5928d:

  fs: fix iomap_bmap position calculation (2018-08-02 13:09:27 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix incorrect shifting in the iomap bmap functions.

----------------------------------------------------------------
Eric Sandeen (1):
      fs: fix iomap_bmap position calculation

 fs/iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
