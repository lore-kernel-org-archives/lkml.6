Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6L1VMbkZHVtyJwAAmS7hNA
	; Sun, 10 Jun 2018 20:37:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8C8AD60791; Sun, 10 Jun 2018 20:37:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 99BF46032D;
	Sun, 10 Jun 2018 20:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99BF46032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeFJUhQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 16:37:16 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36910 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbeFJUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 16:37:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 37FE4609197B;
        Sun, 10 Jun 2018 22:37:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZsqZjo35RpNw; Sun, 10 Jun 2018 22:37:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D8DD96091989;
        Sun, 10 Jun 2018 22:37:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5JbtEo9xJ36O; Sun, 10 Jun 2018 22:37:12 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B1FC4609197B;
        Sun, 10 Jun 2018 22:37:12 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Linus <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UBI/UBIFS updates for 4.18-rc1
Date: Sun, 10 Jun 2018 22:37:11 +0200
Message-ID: <3354112.NtT4H96kfh@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-ubifs.git tags/upstream-4.18-rc1

for you to fetch changes up to f5a926dd529870de4bd19199ce7b36985f130d70:

  mtd: ubi: Update ubi-media.h to dual license (2018-06-07 15:53:17 +0200)

----------------------------------------------------------------
This pull request contains updates for both UBI and UBIFS:
- The UBI on-disk format header file is now dual licensed
- New way to detect Fastmap problems during runtime
- Bugfix for Fastmap
- Minor updates for UBIFS (spelling, comments, vm_fault_t, ...)

----------------------------------------------------------------
Lionel Debieve (1):
      mtd: ubi: Update ubi-media.h to dual license

Richard Weinberger (4):
      ubi: fastmap: Cancel work upon detach
      ubi: fastmap: Correctly handle interrupted erasures in EBA
      ubi: fastmap: Check each mapping only once
      ubi: fastmap: Detect EBA mismatches on-the-fly

Sascha Hauer (6):
      ubifs: remove set but never used variable
      ubifs: journal: Remove wrong comment
      ubifs: Spelling fix someting -> something
      ubifs: log: Some spelling fixes
      ubifs: gc: Fix typo
      ubifs: lpt: Fix wrong pnode number range in comment

Souptick Joarder (1):
      fs: ubifs: Adding new return type vm_fault_t

Wang Shilong (1):
      ubifs, xattr: remove misguided quota flags

 drivers/mtd/ubi/build.c     |   4 ++
 drivers/mtd/ubi/eba.c       | 111 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/mtd/ubi/fastmap.c   |  20 ++++++++
 drivers/mtd/ubi/ubi-media.h |  22 ++-------
 drivers/mtd/ubi/ubi.h       |  11 +++++
 drivers/mtd/ubi/vmt.c       |   1 +
 drivers/mtd/ubi/vtbl.c      |  16 ++++++-
 drivers/mtd/ubi/wl.c        |   4 +-
 fs/ubifs/file.c             |  11 ++---
 fs/ubifs/gc.c               |   2 +-
 fs/ubifs/journal.c          |   5 +-
 fs/ubifs/log.c              |   6 +--
 fs/ubifs/lpt_commit.c       |   2 +-
 fs/ubifs/replay.c           |   5 +-
 fs/ubifs/ubifs.h            |   2 -
 fs/ubifs/xattr.c            |   2 +-
 16 files changed, 178 insertions(+), 46 deletions(-)
