Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E3AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D12421905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbeLTUUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:20:02 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:47784 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbeLTUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:20:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5745B608A3BA;
        Thu, 20 Dec 2018 21:19:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wRQ-nPEWKwLh; Thu, 20 Dec 2018 21:19:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ECCC1608A3BE;
        Thu, 20 Dec 2018 21:19:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DggS0NfteUX2; Thu, 20 Dec 2018 21:19:58 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A8CC5608A3BA;
        Thu, 20 Dec 2018 21:19:58 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [GIT PULL] UBI/UBIFS fixes for 4.20-rc7
Date:   Thu, 20 Dec 2018 21:19:58 +0100
Message-ID: <2752856.A3Cxyq1uY3@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-ubifs.git tags/upstream-4.20-rc7

for you to fetch changes up to e58725d51fa8da9133f3f1c54170aa2e43056b91:

  ubifs: Handle re-linking of inodes correctly while recovery (2018-12-13 22:18:24 +0100)

----------------------------------------------------------------
This pull request contains fixes for both UBI and UBIFS:

- Kconfig dependency fixes for our new auth feature
- Fix for selecting the right compressor when creating a fs
- Bugfix for a bug in UBIFS's O_TMPFILE implementation
- Refcounting fixes for UBI

----------------------------------------------------------------
Arnd Bergmann (2):
      ubifs: replay: Fix high stack usage
      ubifs: auth: Add CONFIG_KEYS dependency

Gabor Juhos (1):
      ubifs: Fix default compression selection in ubifs

Garry McNulty (1):
      ubifs: Fix memory leak on error condition

Geert Uytterhoeven (1):
      ubifs: CONFIG_UBIFS_FS_AUTHENTICATION should depend on UBIFS_FS

Pan Bian (2):
      ubi: Put MTD device after it is not used
      ubi: Do not drop UBI device reference before using

Richard Weinberger (1):
      ubifs: Handle re-linking of inodes correctly while recovery

 drivers/mtd/ubi/build.c |  2 +-
 drivers/mtd/ubi/kapi.c  |  2 +-
 fs/ubifs/Kconfig        | 16 +++++------
 fs/ubifs/lpt.c          | 12 ++++-----
 fs/ubifs/replay.c       | 72 +++++++++++++++++++++++++++++++++++++++++--------
 fs/ubifs/sb.c           | 13 ++++++++-
 6 files changed, 89 insertions(+), 28 deletions(-)



