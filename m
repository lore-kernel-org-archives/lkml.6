Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F26C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D9925003
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D9925003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933879AbeGBKAi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:00:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55155 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbeGBKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:00:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZvdC-0003MJ-NS; Mon, 02 Jul 2018 10:00:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ide-tape: remove redundant variable buffer_size
Date:   Mon,  2 Jul 2018 11:00:26 +0100
Message-Id: <20180702100026.16007-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable buffer_size is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'buffer_size' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ide/ide-tape.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index aee7b46d2330..34c1165226a4 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1746,7 +1746,6 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 {
 	unsigned long t;
 	int speed;
-	int buffer_size;
 	u16 *ctl = (u16 *)&tape->caps[12];
 
 	ide_debug_log(IDE_DBG_FUNC, "minor: %d", minor);
@@ -1781,7 +1780,6 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 		*ctl /= 2;
 		tape->buffer_size = *ctl * tape->blk_size;
 	}
-	buffer_size = tape->buffer_size;
 
 	/* select the "best" DSC read/write polling freq */
 	speed = max(*(u16 *)&tape->caps[14], *(u16 *)&tape->caps[8]);
-- 
2.17.1

