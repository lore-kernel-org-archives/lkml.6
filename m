Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 361CAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47D5208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47D5208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935803AbeFMVYC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:24:02 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45304 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935589AbeFMVYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 9CD8F181A6C84;
        Wed, 13 Jun 2018 23:23:59 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 00/14] ubi: Fastmap updates
Date:   Wed, 13 Jun 2018 23:23:30 +0200
Message-Id: <20180613212344.11608-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Support for preseeded fastmaps.
A preseeded fastmap is a fastmap created by tools such as ubinize.
That way fastmap deployment is less painful and fast attach is
available upon first boot.

2. Refine various checks.
Detect misconfigured setups better.

3. Allow a forcing a full scan.
Forcing a full scan is useful mostly for debugging and making sure that
it works.

4. Remove the experimental stigma.

Richard Weinberger (14):
  ubi: fastmap: Read PEB numbers more carefully
  ubi: Fix assert in ubi_wl_init
  ubi: fastmap: Add support for flags
  ubi: fastmap: Add UBI_FM_SB_PRESEEDED_FLG flag
  ubi: fastmap: Implement PEB translation
  ubi: fastmap: Handle bad block count for preseeded fastmap case
  ubi: fastmap: Fixup pool sizes for preseeded fastmaps
  ubi: fastmap: Scan empty space if fastmap is preseeded
  ubi: fastmap: Relax size check
  ubi: fastmap: Change a WARN_ON() to ubi_err()
  ubi: Add module parameter to force a full scan
  ubi: uapi: Add mode selector to attach request
  ubi: Wire up attach mode selector
  ubi: Remove experimental stigma from Fastmap

 drivers/mtd/ubi/Kconfig     |   7 +-
 drivers/mtd/ubi/attach.c    |  14 +-
 drivers/mtd/ubi/build.c     |  18 ++-
 drivers/mtd/ubi/cdev.c      |   7 +-
 drivers/mtd/ubi/fastmap.c   | 326 +++++++++++++++++++++++++++++++++++++++-----
 drivers/mtd/ubi/ubi-media.h |  15 +-
 drivers/mtd/ubi/ubi.h       |   7 +-
 drivers/mtd/ubi/wl.c        |  12 +-
 include/uapi/mtd/ubi-user.h |  14 +-
 9 files changed, 369 insertions(+), 51 deletions(-)

-- 
2.13.6

