Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB57EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8D82084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8D82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeKZKNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:13:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55120 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZKNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:13:25 -0500
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gR3i8-0005u6-TT; Sun, 25 Nov 2018 23:21:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firestream: fix spelling mistake: "Inititing" -> "Initializing"
Date:   Sun, 25 Nov 2018 23:21:08 +0000
Message-Id: <20181125232108.14548-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in debug messages, fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/atm/firestream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 4e46dc9e41ad..11e1663bdc4d 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1410,7 +1410,7 @@ static int init_q(struct fs_dev *dev, struct queue *txq, int queue,
 
 	func_enter ();
 
-	fs_dprintk (FS_DEBUG_INIT, "Inititing queue at %x: %d entries:\n", 
+	fs_dprintk (FS_DEBUG_INIT, "Initializing queue at %x: %d entries:\n",
 		    queue, nentries);
 
 	p = aligned_kmalloc (sz, GFP_KERNEL, 0x10);
@@ -1443,7 +1443,7 @@ static int init_fp(struct fs_dev *dev, struct freepool *fp, int queue,
 {
 	func_enter ();
 
-	fs_dprintk (FS_DEBUG_INIT, "Inititing free pool at %x:\n", queue);
+	fs_dprintk (FS_DEBUG_INIT, "Initializing free pool at %x:\n", queue);
 
 	write_fs (dev, FP_CNF(queue), (bufsize * RBFP_RBS) | RBFP_RBSVAL | RBFP_CME);
 	write_fs (dev, FP_SA(queue),  0);
-- 
2.19.1

