Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeENLYe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:24:34 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35550 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbeENLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:33 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/8] ubi: fastmap: Support for preseeded fastmap
Date: Mon, 14 May 2018 13:24:14 +0200
Message-Id: <20180514112422.23988-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements support for preseeded fastmaps.
A preseeded fastmap is a fastmap created by tools such as ubinize.
That way fastmap deployment is less painful.

I will send a v2 series for sure since I'm still testing the approach,
so far none of my tests explodes.

Richard Weinberger (8):
  ubi: fastmap: Add support for flags
  ubi: fastmap: Add UBI_FM_SB_PRESEEDED_FLG flag
  ubi: fastmap: Implement PEB fixup
  ubi: fastmap: Handle bad block count for preseeded fastmap case
  ubi: fastmap: Fixup pool sizes for preseeded fastmaps
  ubi: fastmap: Scan empty space if fastmap is preseeded
  ubi: fastmap: Relax size check
  ubi: Fix assert in ubi_wl_init

 drivers/mtd/ubi/attach.c    |   1 +
 drivers/mtd/ubi/fastmap.c   | 244 ++++++++++++++++++++++++++++++++++++++++----
 drivers/mtd/ubi/ubi-media.h |  15 ++-
 drivers/mtd/ubi/ubi.h       |   4 +
 drivers/mtd/ubi/wl.c        |   5 +-
 5 files changed, 243 insertions(+), 26 deletions(-)

-- 
2.13.6
