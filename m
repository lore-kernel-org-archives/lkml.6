Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19433C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C862081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C862081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeKAGWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:22:24 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60178 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKAGWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:22:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DA20D603C29D;
        Wed, 31 Oct 2018 22:22:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DwLgk-BjTTCp; Wed, 31 Oct 2018 22:22:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7702C603C29E;
        Wed, 31 Oct 2018 22:22:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mPohOTeXDMQi; Wed, 31 Oct 2018 22:22:31 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 3F3E6603C29D;
        Wed, 31 Oct 2018 22:22:31 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linuxfoundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UBIFS updates for 4.20-rc1
Date:   Wed, 31 Oct 2018 22:22:30 +0100
Message-ID: <2346471.iD2boZGiFq@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  git://git.infradead.org/linux-ubifs.git tags/tags/upstream-4.20-rc1

for you to fetch changes up to 84db119f5a83e1bf9cffbc6d9cf16487eda1c056:

  ubifs: Remove unneeded semicolon (2018-10-23 13:49:02 +0200)

----------------------------------------------------------------
This pull request contains updates for UBIFS:

- Full filesystem authentication feature,
  UBIFS is now able to have the whole filesystem structure
  authenticated plus user data encrypted and authenticated.
- Minor cleanups

----------------------------------------------------------------
Ding Xiang (1):
      ubifs: Remove unneeded semicolon

Gustavo A. R. Silva (1):
      ubi: Mark expected switch fall-throughs

Sascha Hauer (24):
      ubifs: Refactor create_default_filesystem()
      ubifs: Pass ubifs_zbranch to try_read_node()
      ubifs: Pass ubifs_zbranch to read_znode()
      ubifs: Export pnode_lookup as ubifs_pnode_lookup
      ubifs: Implement ubifs_lpt_lookup using ubifs_pnode_lookup
      ubifs: Drop write_node
      ubifs: Store read superblock node
      ubifs: Format changes for authentication support
      ubifs: Add separate functions to init/crc a node
      ubifs: Add helper functions for authentication support
      ubifs: Create functions to embed a HMAC in a node
      ubifs: Add hashes to the tree node cache
      ubifs: authentication: Add hashes to index nodes
      ubifs: Add authentication nodes to journal
      ubifs: Add auth nodes to garbage collector journal head
      ubifs: Authenticate replayed journal
      ubifs: authentication: Authenticate LPT
      ubfis: authentication: Authenticate master node
      ubifs: Create hash for default LPT
      ubifs: authentication: Authenticate super block node
      ubifs: Add hashes and HMACs to default filesystem
      ubifs: Do not update inode size in-place in authenticated mode
      ubifs: Enable authentication support
      Documentation: ubifs: Add authentication whitepaper

 Documentation/filesystems/ubifs-authentication.md | 426 ++++++++++++++++++
 Documentation/filesystems/ubifs.txt               |   7 +
 drivers/mtd/ubi/attach.c                          |   1 +
 drivers/mtd/ubi/build.c                           |   2 +
 fs/ubifs/Kconfig                                  |  11 +
 fs/ubifs/Makefile                                 |   1 +
 fs/ubifs/auth.c                                   | 502 ++++++++++++++++++++++
 fs/ubifs/debug.c                                  |   6 +
 fs/ubifs/gc.c                                     |  49 ++-
 fs/ubifs/io.c                                     | 110 ++++-
 fs/ubifs/journal.c                                | 289 ++++++++++---
 fs/ubifs/log.c                                    |  24 ++
 fs/ubifs/lpt.c                                    | 184 +++++++-
 fs/ubifs/lpt_commit.c                             |  44 +-
 fs/ubifs/master.c                                 |  64 ++-
 fs/ubifs/misc.h                                   |   5 +-
 fs/ubifs/recovery.c                               | 120 ++++--
 fs/ubifs/replay.c                                 | 177 +++++++-
 fs/ubifs/sb.c                                     | 209 ++++++---
 fs/ubifs/super.c                                  |  91 +++-
 fs/ubifs/tnc.c                                    |  36 +-
 fs/ubifs/tnc_commit.c                             |  27 ++
 fs/ubifs/tnc_misc.c                               |  26 +-
 fs/ubifs/ubifs-media.h                            |  46 +-
 fs/ubifs/ubifs.h                                  | 253 ++++++++++-
 25 files changed, 2418 insertions(+), 292 deletions(-)
 create mode 100644 Documentation/filesystems/ubifs-authentication.md
 create mode 100644 fs/ubifs/auth.c



