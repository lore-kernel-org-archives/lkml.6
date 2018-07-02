Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B167C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE7325220
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE7325220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbeGBHmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:42:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52238 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeGBHmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:42:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZtTm-0002dZ-Vn; Mon, 02 Jul 2018 07:42:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block/floppy: remove redundant variable dflags
Date:   Mon,  2 Jul 2018 08:42:34 +0100
Message-Id: <20180702074234.10435-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable dflags is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'dflags' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/floppy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8871b5044d9e..48f622728ce6 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1461,7 +1461,6 @@ static void setup_rw_floppy(void)
 	int i;
 	int r;
 	int flags;
-	int dflags;
 	unsigned long ready_date;
 	void (*function)(void);
 
@@ -1485,8 +1484,6 @@ static void setup_rw_floppy(void)
 		if (fd_wait_for_completion(ready_date, function))
 			return;
 	}
-	dflags = DRS->flags;
-
 	if ((flags & FD_RAW_READ) || (flags & FD_RAW_WRITE))
 		setup_DMA();
 
-- 
2.17.1

