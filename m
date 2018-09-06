Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6F3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EC920659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EC920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeIFTNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:13:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729735AbeIFTNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD45BAFC5;
        Thu,  6 Sep 2018 14:37:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0021FDAD85; Thu,  6 Sep 2018 16:37:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 4.19-rc2
Date:   Thu,  6 Sep 2018 16:37:18 +0200
Message-Id: <cover.1536241480.git.dsterba@suse.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are a few more fixes that were sent after the 1st pull request
cut and postponed after the merge window settles down.

* fix for improper fsync after hardlink
* fix for a corruption during file deduplication
* use after free fixes
* RCU warning fix
* fix for buffered write to nodatacow file

There are no merge conflicts. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 39379faaad79e3cf403a6904a08676b7850043ae:

  btrfs: revert fs_devices state on error of btrfs_init_new_device (2018-08-06 13:13:04 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.19-rc2-tag

for you to fetch changes up to b6fdfbff078975c53383fc146a2a54985eab6b6d:

  btrfs: Fix suspicious RCU usage warning in btrfs_debug_in_rcu (2018-08-24 14:09:43 +0200)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: btrfs_shrink_device should call commit transaction at the end

Dan Carpenter (1):
      btrfs: use after free in btrfs_quota_enable

Filipe Manana (2):
      Btrfs: sync log after logging new name
      Btrfs: fix data corruption when deduplicating between different files

Lu Fengqi (1):
      btrfs: fix qgroup_free wrong num_bytes in btrfs_subvolume_reserve_metadata

Misono Tomohiro (1):
      btrfs: Fix suspicious RCU usage warning in btrfs_debug_in_rcu

Robbie Ko (1):
      Btrfs: fix unexpected failure of nocow buffered writes after snapshotting when low on space

 fs/btrfs/ctree.h       |  12 ++++-
 fs/btrfs/disk-io.c     |   1 +
 fs/btrfs/extent-tree.c |  17 ++++---
 fs/btrfs/inode.c       | 117 +++++++++++++++++++++++++++++++++++--------------
 fs/btrfs/ioctl.c       |  35 +++++++++++++++
 fs/btrfs/qgroup.c      |   5 +--
 fs/btrfs/tree-log.c    |  48 +++++++++++++++++---
 fs/btrfs/tree-log.h    |  10 ++++-
 fs/btrfs/volumes.c     |   7 ++-
 9 files changed, 197 insertions(+), 55 deletions(-)
