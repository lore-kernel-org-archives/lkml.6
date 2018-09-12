Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25EAC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8672820866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8672820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeILFU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:20:58 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51576 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeILFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:20:30 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 64FC62A7D3; Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <348ad9ee1da7853b59e3ffeda38b652470ec4515.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1536709753.git.fthain@telegraphics.com.au>
References: <cover.1536709753.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 6/7] macintosh/via-macii, macintosh/adb-iop: Modernize printk
 calls
Date:   Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing severity level to log messages.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c   | 2 +-
 drivers/macintosh/via-macii.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index ca623e6446e4..3a1e995ecc0e 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -208,7 +208,7 @@ int adb_iop_probe(void)
 
 int adb_iop_init(void)
 {
-	printk("adb: IOP ISM driver v0.4 for Unified ADB.\n");
+	pr_info("adb: IOP ISM driver v0.4 for Unified ADB\n");
 	iop_listen(ADB_IOP, ADB_CHAN, adb_iop_listen, "ADB");
 	return 0;
 }
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 6ed9ac91aca1..a38f57ba50cb 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -127,7 +127,7 @@ static int macii_probe(void)
 
 	via = via1;
 
-	printk("adb: Mac II ADB Driver v1.0 for Unified ADB\n");
+	pr_info("adb: Mac II ADB Driver v1.0 for Unified ADB\n");
 	return 0;
 }
 
-- 
2.16.4

