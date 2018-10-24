Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E885FC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E7E20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="CWtirCw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E7E20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJXXQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:16:02 -0400
Received: from imap.thunk.org ([74.207.234.97]:52996 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeJXXQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=71dO589UcB3D7tgXaPO/3lsA6A2aTdJXVPJgso5bx8Q=; b=CWtirCw3GTUz8IRcClqvn5PAoU
        6hF7UQXgsQOZewqLq8JZOiB61tIooDCkHeOjZ7e4hqhk9okXYRX8RwWEPnV3BAb0XwDUW48IdrLAf
        /5yvguZJLQ77nP4TPy0iW9/sG7pmtK7l0Mqg1DwSIOnirREbbvrLU6FGOeOFwsoDGTOI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gFKRd-0008QW-7S; Wed, 24 Oct 2018 14:47:37 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 958BE7A56BE; Wed, 24 Oct 2018 10:47:35 -0400 (EDT)
Date:   Wed, 24 Oct 2018 10:47:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 4.20-rc1
Message-ID: <20181024144735.GA28816@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
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

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 33458eaba4dfe778a426df6a19b7aad2ff9f7eec:

  ext4: fix use-after-free race in ext4_remount()'s error path (2018-10-12 09:28:09 -0400)

(The documentation restructuring changes were ack'ed by Jon Corbet)

----------------------------------------------------------------
Further restructure ext4 documentation; fix up ext4's delayed
allocation for bigalloc file systems; fix up some syzbot-detected
races in EXT4_IOC_MOVE_EXT, EXT4_IOC_SWAP_BOOT, and ext4_remount; and
a few other miscellaneous bugs and optimizations.

----------------------------------------------------------------
Chengguang Xu (1):
      ext4: cache NULL when both default_acl and acl are NULL

Darrick J. Wong (5):
      docs: generate a separate ext4 pdf file from the documentation
      docs: fix ext4 documentation table formatting problems
      docs: make ext4 readme tables readable
      docs: move ext4 administrative docs to admin-guide/
      docs: promote the ext4 data structures book to top level

Eric Whitney (6):
      ext4: generalize extents status tree search functions
      ext4: add new pending reservation mechanism
      ext4: fix reserved cluster accounting at delayed write time
      ext4: reduce reserved cluster count by number of allocated clusters
      ext4: adjust reserved cluster count when removing extents
      ext4: fix reserved cluster accounting at page invalidation time

Gabriel Krisman Bertazi (1):
      ext4: fix build error when DX_DEBUG is defined

Jan Kara (1):
      jbd2: fix use after free in jbd2_log_do_checkpoint()

Lukas Czerner (1):
      ext4: initialize retries variable in ext4_da_write_inline_data_begin()

Souptick Joarder (1):
      ext4: convert fault handler to use vm_fault_t type

Theodore Ts'o (3):
      ext4: fix argument checking in EXT4_IOC_MOVE_EXT
      ext4: fix EXT4_IOC_SWAP_BOOT
      ext4: fix use-after-free race in ext4_remount()'s error path

Wang Shilong (2):
      ext4: fix setattr project check in fssetxattr ioctl
      ext4: propagate error from dquot_initialize() in EXT4_IOC_FSSETXATTR

 Documentation/admin-guide/ext4.rst                      | 574 +++++++++++++++++++++
 Documentation/admin-guide/index.rst                     |   1 +
 Documentation/conf.py                                   |   4 +
 Documentation/filesystems/ext4/{ondisk => }/about.rst   |   0
 .../filesystems/ext4/{ondisk => }/allocators.rst        |   0
 .../filesystems/ext4/{ondisk => }/attributes.rst        |   8 +-
 .../filesystems/ext4/{ondisk => }/bigalloc.rst          |   0
 Documentation/filesystems/ext4/{ondisk => }/bitmaps.rst |   0
 .../filesystems/ext4/{ondisk => }/blockgroup.rst        |   0
 .../filesystems/ext4/{ondisk => }/blockmap.rst          |   0
 Documentation/filesystems/ext4/{ondisk => }/blocks.rst  |   0
 .../filesystems/ext4/{ondisk => }/checksums.rst         |   2 +-
 .../filesystems/ext4/{ondisk => }/directory.rst         |  18 +-
 Documentation/filesystems/ext4/{ondisk => }/dynamic.rst |   0
 Documentation/filesystems/ext4/{ondisk => }/eainode.rst |   0
 Documentation/filesystems/ext4/ext4.rst                 | 613 ----------------------
 Documentation/filesystems/ext4/{ondisk => }/globals.rst |   0
 .../filesystems/ext4/{ondisk => }/group_descr.rst       |   4 +-
 Documentation/filesystems/ext4/{ondisk => }/ifork.rst   |   8 +-
 Documentation/filesystems/ext4/index.rst                |  19 +-
 .../filesystems/ext4/{ondisk => }/inlinedata.rst        |   0
 Documentation/filesystems/ext4/{ondisk => }/inodes.rst  |  19 +-
 Documentation/filesystems/ext4/{ondisk => }/journal.rst |  32 +-
 Documentation/filesystems/ext4/{ondisk => }/mmp.rst     |   2 +-
 Documentation/filesystems/ext4/ondisk/index.rst         |   9 -
 .../filesystems/ext4/{ondisk => }/overview.rst          |   0
 .../filesystems/ext4/{ondisk => }/special_inodes.rst    |   2 +-
 Documentation/filesystems/ext4/{ondisk => }/super.rst   |  24 +-
 fs/ext4/acl.c                                           |   4 +
 fs/ext4/ext4.h                                          |  17 +-
 fs/ext4/ext4_extents.h                                  |  13 +
 fs/ext4/extents.c                                       | 595 +++++++++++----------
 fs/ext4/extents_status.c                                | 654 +++++++++++++++++++++++-
 fs/ext4/extents_status.h                                |  80 ++-
 fs/ext4/inline.c                                        |   2 +-
 fs/ext4/inode.c                                         | 142 +++--
 fs/ext4/ioctl.c                                         |  97 ++--
 fs/ext4/mballoc.c                                       |  14 +-
 fs/ext4/move_extent.c                                   |   8 +-
 fs/ext4/namei.c                                         |   2 +-
 fs/ext4/super.c                                         |  81 ++-
 fs/jbd2/checkpoint.c                                    |   4 +-
 include/linux/buffer_head.h                             |   2 +-
 include/trace/events/ext4.h                             |  99 +++-
 44 files changed, 1984 insertions(+), 1169 deletions(-)
 create mode 100644 Documentation/admin-guide/ext4.rst
 rename Documentation/filesystems/ext4/{ondisk => }/about.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/allocators.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/attributes.rst (98%)
 rename Documentation/filesystems/ext4/{ondisk => }/bigalloc.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/bitmaps.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/blockgroup.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/blockmap.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/blocks.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/checksums.rst (99%)
 rename Documentation/filesystems/ext4/{ondisk => }/directory.rst (98%)
 rename Documentation/filesystems/ext4/{ondisk => }/dynamic.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/eainode.rst (100%)
 delete mode 100644 Documentation/filesystems/ext4/ext4.rst
 rename Documentation/filesystems/ext4/{ondisk => }/globals.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/group_descr.rst (99%)
 rename Documentation/filesystems/ext4/{ondisk => }/ifork.rst (98%)
 rename Documentation/filesystems/ext4/{ondisk => }/inlinedata.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/inodes.rst (98%)
 rename Documentation/filesystems/ext4/{ondisk => }/journal.rst (98%)
 rename Documentation/filesystems/ext4/{ondisk => }/mmp.rst (99%)
 delete mode 100644 Documentation/filesystems/ext4/ondisk/index.rst
 rename Documentation/filesystems/ext4/{ondisk => }/overview.rst (100%)
 rename Documentation/filesystems/ext4/{ondisk => }/special_inodes.rst (97%)
 rename Documentation/filesystems/ext4/{ondisk => }/super.rst (99%)
