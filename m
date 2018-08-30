Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5007C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68237205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68237205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeH3Ql6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:41:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37030 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeH3Ql5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:41:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fvMEw-0008HC-Uo; Thu, 30 Aug 2018 12:39:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Damien Riegel <damien.riegel@savoirfairelinux.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tca8418: remove redundant variable max_keys
Date:   Thu, 30 Aug 2018 13:39:58 +0100
Message-Id: <20180830123958.25368-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable max_keys is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
variable 'max_keys' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 6da607d3b811..3bbd7e652533 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -266,7 +266,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	struct tca8418_keypad *keypad_data;
 	struct input_dev *input;
 	u32 rows = 0, cols = 0;
-	int error, row_shift, max_keys;
+	int error, row_shift;
 	u8 reg;
 
 	/* Check i2c driver capabilities */
@@ -291,7 +291,6 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	}
 
 	row_shift = get_count_order(cols);
-	max_keys = rows << row_shift;
 
 	/* Allocate memory for keypad_data and input device */
 	keypad_data = devm_kzalloc(dev, sizeof(*keypad_data), GFP_KERNEL);
-- 
2.17.1

