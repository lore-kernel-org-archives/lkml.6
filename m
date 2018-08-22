Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B43C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4954208DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4954208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHWAYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:24:04 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46766 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeHWAYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:24:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CADAF606B6C0;
        Wed, 22 Aug 2018 22:57:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vGIHarlwQNCF; Wed, 22 Aug 2018 22:57:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 77ADB605AD30;
        Wed, 22 Aug 2018 22:57:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T4B4lNEy53hQ; Wed, 22 Aug 2018 22:57:33 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 3F5BF605AD2D;
        Wed, 22 Aug 2018 22:57:33 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UBI/UBIFS updates for 4.19-rc1
Date:   Wed, 22 Aug 2018 22:57:32 +0200
Message-ID: <25583958.CCRG8GzgUh@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-ubifs.git tags/upstream-4.19-rc1

for you to fetch changes up to 99a24e02ccf6604e3020cf9e2c7a042b6ebb655f:

  ubifs: Set default assert action to read-only (2018-08-15 00:25:22 +0200)

----------------------------------------------------------------
This pull request contains updates for both UBI and UBIFS:

- Year 2038 preparations
- New UBI feature to skip CRC checks of static volumes
- A new Kconfig option to disable xattrs in UBIFS
- Lots of fixes in UBIFS, found by our new test framework

----------------------------------------------------------------
Arnd Bergmann (2):
      ubifs: use timespec64 for inode timestamps
      ubifs: tnc: use monotonic znode timestamp

Gustavo A. R. Silva (1):
      ubifs: use swap macro in swap_dirty_idx

Quentin Schulz (2):
      ubi: provide a way to skip CRC checks
      ubi: expose the volume CRC check skip flag

Richard Weinberger (15):
      ubifs: Fix directory size calculation for symlinks
      ubifs: Fix synced_i_size calculation for xattr inodes
      ubi: Initialize Fastmap checkmapping correctly
      ubifs: Fix memory leak in lprobs self-check
      ubifs: gc: Fix typo
      ubifs: xattr: Don't operate on deleted inodes
      ubifs: Add comment on c->commit_sem
      Revert "UBIFS: Fix potential integer overflow in allocation"
      ubifs: Check data node size before truncate
      ubifs: Use kmalloc_array()
      ubifs: Turn two ubifs_assert() into a WARN_ON()
      ubifs: Pass struct ubifs_info to ubifs_assert()
      ubifs: Rework ubifs_assert()
      ubifs: Allow setting assert action as mount parameter
      ubifs: Set default assert action to read-only

Stefan Agner (1):
      ubifs: introduce Kconfig symbol for xattr support

 drivers/mtd/ubi/cdev.c      |  11 +++++
 drivers/mtd/ubi/kapi.c      |   2 +-
 drivers/mtd/ubi/ubi-media.h |   6 +++
 drivers/mtd/ubi/ubi.h       |   4 ++
 drivers/mtd/ubi/vmt.c       |  12 +++++
 drivers/mtd/ubi/vtbl.c      |  23 +++++----
 fs/ubifs/Kconfig            |  15 +++++-
 fs/ubifs/Makefile           |   3 +-
 fs/ubifs/budget.c           |  68 +++++++++++++--------------
 fs/ubifs/commit.c           |   8 ++--
 fs/ubifs/crypto.c           |   4 +-
 fs/ubifs/debug.c            |  42 +++++++++++++----
 fs/ubifs/debug.h            |  14 +++---
 fs/ubifs/dir.c              |  42 +++++++++--------
 fs/ubifs/file.c             |  62 ++++++++++++++----------
 fs/ubifs/file.h             |   0
 fs/ubifs/find.c             |  59 +++++++++++------------
 fs/ubifs/gc.c               |  66 +++++++++++++-------------
 fs/ubifs/io.c               |  97 +++++++++++++++++++-------------------
 fs/ubifs/journal.c          |  72 ++++++++++++++++------------
 fs/ubifs/key.h              |  14 +++---
 fs/ubifs/log.c              |  12 ++---
 fs/ubifs/lprops.c           |  94 ++++++++++++++++++-------------------
 fs/ubifs/lpt.c              | 112 ++++++++++++++++++++++----------------------
 fs/ubifs/lpt_commit.c       |  50 ++++++++++----------
 fs/ubifs/master.c           |   2 +-
 fs/ubifs/misc.c             |  11 +++++
 fs/ubifs/misc.h             |  16 ++++---
 fs/ubifs/orphan.c           |  26 +++++-----
 fs/ubifs/recovery.c         |  14 +++---
 fs/ubifs/replay.c           |  13 ++---
 fs/ubifs/sb.c               |  18 +++----
 fs/ubifs/scan.c             |   2 +-
 fs/ubifs/shrinker.c         |  12 ++---
 fs/ubifs/super.c            |  76 ++++++++++++++++++++----------
 fs/ubifs/tnc.c              | 111 +++++++++++++++++++++----------------------
 fs/ubifs/tnc_commit.c       |  28 +++++------
 fs/ubifs/tnc_misc.c         |  40 +++++++++-------
 fs/ubifs/ubifs.h            |  39 ++++++++++++---
 fs/ubifs/xattr.c            |  40 ++++++++++++----
 include/uapi/mtd/ubi-user.h |  18 ++++++-
 41 files changed, 787 insertions(+), 571 deletions(-)
 create mode 100644 fs/ubifs/file.h



