Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D753C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12223242B9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12223242B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeGBQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:28:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35345 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeGBQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:28:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fa1gw-0004H1-21; Mon, 02 Jul 2018 16:28:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: cros_ec_keyb: remove redundant variable num_cols
Date:   Mon,  2 Jul 2018 17:28:41 +0100
Message-Id: <20180702162841.12553-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable num_cols is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable ‘num_cols’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 820bebad519a..81be6f781f0b 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -160,9 +160,6 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
 	int col, row;
 	int new_state;
 	int old_state;
-	int num_cols;
-
-	num_cols = len;
 
 	if (ckdev->ghost_filter && cros_ec_keyb_has_ghosting(ckdev, kb_state)) {
 		/*
-- 
2.17.1

