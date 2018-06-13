Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 230BFC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD19420891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD19420891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964941AbeFMPOJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:14:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964870AbeFMPOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:14:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CAADCAD73;
        Wed, 13 Jun 2018 15:14:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49F13DACEB; Wed, 13 Jun 2018 17:11:18 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 4.18, part 2
Date:   Wed, 13 Jun 2018 17:11:17 +0200
Message-Id: <cover.1528881676.git.dsterba@suse.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a handful of minor updates that would fit the 1st pull but were in next
at that time or arrived last week and there's no reason to delay them
for later rc.

Please pull thanks.

- error handling fixup for one of the new ioctls from 1st pull
- fix for device-replace that incorrectly uses inode pages and can mess up
  compressed extents in some cases
- fiemap fix for reporting incorrect number of extents
- vm_fault_t type conversion

----------------------------------------------------------------
The following changes since commit 23d0b79dfaed2305b500b0215b0421701ada6b1a:

  btrfs: Add unprivileged version of ino_lookup ioctl (2018-05-31 11:35:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.18-part2-tag

for you to fetch changes up to ac0b4145d662a3b9e34085dea460fb06ede9b69b:

  btrfs: scrub: Don't use inode pages for device replace (2018-06-11 15:59:14 +0200)

----------------------------------------------------------------
Misono Tomohiro (1):
      btrfs: Check error of btrfs_iget in btrfs_search_path_in_tree_user

Qu Wenruo (1):
      btrfs: scrub: Don't use inode pages for device replace

Robbie Ko (1):
      Btrfs: fiemap: pass correct bytenr when fm_extent_count is zero

Souptick Joarder (1):
      btrfs: change return type of btrfs_page_mkwrite to vm_fault_t

 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/extent_io.c |  4 +---
 fs/btrfs/inode.c     | 26 ++++++++++++--------------
 fs/btrfs/ioctl.c     |  4 ++++
 fs/btrfs/scrub.c     |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)
