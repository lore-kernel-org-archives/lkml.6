Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030716AbeCAN1O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:27:14 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:48251 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030379AbeCAN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:27:10 -0500
Authentication-Results: mx-rz-1.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 217.238.5.165
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] block: sed-opal: fix u64 short atom length
Date: Thu,  1 Mar 2018 14:27:00 +0100
Message-Id: <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length must be given as bytes and not as 4 bit tuples.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 36842bfa572e..d5f565e1557a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -562,7 +562,7 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 	}
 
 	msb = fls(number);
-	len = DIV_ROUND_UP(msb, 4);
+	len = DIV_ROUND_UP(msb, 8);
 
 	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
 		pr_debug("Error adding u64: end of buffer.\n");
-- 
2.13.6
