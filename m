Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A60EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49D9222B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfBKNtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:49:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40095 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfBKNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:49:24 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gtBxZ-0007DG-Ap; Mon, 11 Feb 2019 13:49:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Robert Baldyga <r.baldyga@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools: ffs-aio-example: fix uninitialized boolean variable 'ready'
Date:   Mon, 11 Feb 2019 13:49:21 +0000
Message-Id: <20190211134921.11975-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The boolean variable is uninitialized and is only set if file
descriptor ep0 is ready. Fix this by ensuring the variable is
initialized by setting it to false.

Fixes: b34e08d5c706 ("tools: usb: aio example applications")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c b/tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c
index aaca1f44e788..1dda6e816b3c 100644
--- a/tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c
+++ b/tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c
@@ -246,7 +246,7 @@ int main(int argc, char *argv[])
 
 	struct io_buffer iobuf[2];
 	int actual = 0;
-	bool ready;
+	bool ready = false;
 
 	if (argc != 2) {
 		printf("ffs directory not specified!\n");
-- 
2.20.1

