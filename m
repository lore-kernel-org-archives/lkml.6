Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C46C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971CC217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546032534;
	bh=kNIv4pSeATsLB/Ty+Y4jxJItI7JGwFnkJiIRi6ggHhc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=f7xGBzRE3B3UFIpujBUvdCB1F8+DXiec1kqmpxxNToM4U4Dbrj3maKIBSUuZOQNn8
	 k/ueqS07kMlBe1u41TWMiWZZQSgz6PDS7m/OfveOgwdDToKDddSAiwP7mQjJm3w49I
	 qW1Kez/Wj81xXwT5Y6lnWkiEeM5ONRQRy4TbxUJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeL1V2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeL1V2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:28:53 -0500
Received: from localhost (unknown [104.132.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DAD20665;
        Fri, 28 Dec 2018 21:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546032531;
        bh=kNIv4pSeATsLB/Ty+Y4jxJItI7JGwFnkJiIRi6ggHhc=;
        h=Date:From:To:Cc:Subject:From;
        b=Eabr+5EeWqscFLjt+qbF82jVOJEjwJCmo4lozL7fuTadws+6xOPdFZAZRskO6lK0x
         I/pZoYO1/S/kvIO93jJy7WpP3lba+Ya8NfqhkHmHB5KOhmGBXYO1F/jbhuCOpkHV7W
         8wFT4PmsPVrDVW6PzMsCIocN2V6mtLU8BLkhXTcY=
Date:   Fri, 28 Dec 2018 13:28:50 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs-for-4.21
Message-ID: <20181228212850.GA49768@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 6f8b52ba442ce1372a58df4e85f169686ef52a0d:

  Merge tag 'hwmon-for-v4.20-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2018-11-26 09:34:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.21

for you to fetch changes up to 64beba0558fce7b59e9a8a7afd77290e82a22163:

  f2fs: sanity check of xattr entry size (2018-12-26 19:56:23 -0800)

----------------------------------------------------------------
f2fs-for-4.21-rc1

In this round, we've focused on bug fixes since Pixel devices have been
shipping with f2fs. Some of them were related to hardware encryption support
which are actually not an issue in mainline, but would be better to merge
them in order to avoid potential bugs.

Enhancement:
 - do GC sub-sections when the section is large
 - add a flag in ioctl(SHUTDOWN) to trigger fsck for QA
 - use kvmalloc() in order to give another chance to avoid ENOMEM

Bug fix:
 - fix accessing memory boundaries in a malformed iamge
 - GC gives stale unencrypted block
 - GC counts in large sections
 - detect idle time more precisely
 - block allocation of DIO writes
 - race conditions between write_begin and write_checkpoint
 - allow GCs for node segments via ioctl()

There are various clean-ups and minor bug fixes as well.

----------------------------------------------------------------
Alexey Dobriyan (1):
      f2fs: make "f2fs_fault_name[]" const char *

Chao Yu (13):
      f2fs: fix to account preflush command for noflush_merge mode
      f2fs: clean up f2fs_sb_has_##feature_name
      f2fs: introduce __is_large_section() for cleanup
      f2fs: support subsectional garbage collection
      f2fs: export migration_granularity sysfs entry
      f2fs: add to account direct IO
      f2fs: fix to be aware discard/preflush/dio command in is_idle()
      f2fs: fix out-place-update DIO write
      f2fs: fix to reorder set_page_dirty and wait_on_page_writeback
      f2fs: clean up checkpoint flow
      f2fs: clean up structure extent_node
      f2fs: fix to dirty inode synchronously
      f2fs: check PageWriteback flag for ordered case

Jaegeuk Kim (9):
      f2fs: check memory boundary by insane namelen
      f2fs: avoid build warn of fall_through
      f2fs: avoid frequent costly fsck triggers
      f2fs: add an ioctl() to explicitly trigger fsck later
      f2fs: use kvmalloc, if kmalloc is failed
      f2fs: correct wrong spelling, issing_*
      f2fs: flush stale issued discard candidates
      f2fs: fix missing unlock(sbi->gc_mutex)
      f2fs: sanity check of xattr entry size

Jia Zhu (2):
      f2fs: fix to update new block address correctly for OPU
      f2fs: fix m_may_create to make OPU DIO write correctly

Martin Blumenstingl (1):
      f2fs: fix validation of the block count in sanity_check_raw_super

Pan Bian (1):
      f2fs: read page index before freeing

Qiuyang Sun (1):
      f2fs: fix block address for __check_sit_bitmap

Sahitya Tummala (4):
      f2fs: fix to allow node segment for GC by ioctl path
      f2fs: adjust trace print in f2fs_get_victim() to cover all paths
      f2fs: fix sbi->extent_list corruption issue
      f2fs: fix use-after-free issue when accessing sbi->stat_info

Sheng Yong (2):
      f2fs: fix race between write_checkpoint and write_begin
      f2fs: clear PG_writeback if IPU failed

Tiezhu Yang (1):
      f2fs: fix wrong return value of f2fs_acl_create

Yangtao Li (1):
      f2fs: Change to use DEFINE_SHOW_ATTRIBUTE macro

Yunlei He (1):
      f2fs: move dir data flush to write checkpoint process

Yunlong Song (6):
      f2fs: avoid GC causing encrypted file corrupted
      f2fs: fix count of seg_freed to make sec_freed correct
      f2fs: remove codes of unused wio_mutex
      f2fs: change segment to section in f2fs_ioc_gc_range
      f2fs: only flush the single temp bio cache which owns the target page
      f2fs: remove redundant comment of unused wio_mutex

 Documentation/ABI/testing/sysfs-fs-f2fs |   9 ++
 fs/f2fs/acl.c                           |  20 ++--
 fs/f2fs/checkpoint.c                    |  33 +++----
 fs/f2fs/data.c                          | 160 +++++++++++++++++++++---------
 fs/f2fs/debug.c                         |  25 ++---
 fs/f2fs/dir.c                           |  20 +++-
 fs/f2fs/f2fs.h                          |  98 +++++++++++-------
 fs/f2fs/file.c                          |  42 +++++---
 fs/f2fs/gc.c                            |  81 +++++++++++----
 fs/f2fs/inline.c                        |  20 ++--
 fs/f2fs/inode.c                         |  22 ++---
 fs/f2fs/namei.c                         |   8 +-
 fs/f2fs/node.c                          |  40 ++++----
 fs/f2fs/node.h                          |   2 +-
 fs/f2fs/recovery.c                      |   4 +-
 fs/f2fs/segment.c                       | 101 ++++++++++---------
 fs/f2fs/segment.h                       |   2 +-
 fs/f2fs/shrinker.c                      |   2 +-
 fs/f2fs/super.c                         | 170 ++++++++++++++++----------------
 fs/f2fs/sysfs.c                         |  27 +++--
 fs/f2fs/xattr.c                         |  22 +++--
 21 files changed, 542 insertions(+), 366 deletions(-)
