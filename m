Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6937BC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA7E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA7E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeILFU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:20:29 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51512 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeILFU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:20:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id F416E2A7CF; Tue, 11 Sep 2018 20:18:43 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <cover.1536709753.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/7] Miscellaneous Macintosh fixes and clean up
Date:   Tue, 11 Sep 2018 20:18:43 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has some minor fixes and cleanups under drivers/macintosh,
including a patch to rework recent printk changes in adb-hid.c.
There's also a re-based RTC code de-duplication patch.


Finn Thain (7):
  macintosh: Use common code to access RTC
  macintosh/adb: Rework printk output again
  macintosh/via-macii: Synchronous bus reset
  macintosh/via-macii: Remove BUG_ON assertions
  macintosh/via-macii: Simplify locking
  macintosh/via-macii, macintosh/adb-iop: Modernize printk calls
  macintosh/via-macii, macintosh/adb-iop: Clean up whitespace

 arch/m68k/mac/misc.c                   |  75 +------
 arch/powerpc/platforms/powermac/time.c | 126 ++----------
 drivers/macintosh/adb-iop.c            |  50 +++--
 drivers/macintosh/adb.c                |   8 +-
 drivers/macintosh/adbhid.c             |  53 ++---
 drivers/macintosh/via-cuda.c           |  35 ++++
 drivers/macintosh/via-macii.c          | 352 ++++++++++++++++-----------------
 drivers/macintosh/via-pmu.c            |  33 ++++
 include/linux/cuda.h                   |   4 +
 include/linux/pmu.h                    |   4 +
 10 files changed, 328 insertions(+), 412 deletions(-)

-- 
2.16.4

