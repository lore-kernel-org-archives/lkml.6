Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7892DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211FF21717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211FF21717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbeHCMno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:43:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53413 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732251AbeHCMno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:43:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1flXce-0004Hj-Q7; Fri, 03 Aug 2018 10:47:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] st: remove redundant pointer STbuffer
Date:   Fri,  3 Aug 2018 11:47:52 +0100
Message-Id: <20180803104752.17081-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer STbuffer is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'STbuffer' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/st.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 50c66ccc4b41..307df2fa39a3 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -828,11 +828,8 @@ static int st_flush_write_buffer(struct scsi_tape * STp)
 static int flush_buffer(struct scsi_tape *STp, int seek_next)
 {
 	int backspace, result;
-	struct st_buffer *STbuffer;
 	struct st_partstat *STps;
 
-	STbuffer = STp->buffer;
-
 	/*
 	 * If there was a bus reset, block further access
 	 * to this device.
-- 
2.17.1

