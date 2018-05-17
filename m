Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeEQJCb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:02:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38915 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeEQJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:01:02 -0400
X-Google-Smtp-Source: AB8JxZo1cUK3+k4JtFGREr993ByES7kxgirIGmTWnI6lXAkQGiKvU06/pShWrLJxMqwUN9gVt2fgqA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH v2 5/8] slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
Date: Thu, 17 May 2018 09:58:47 +0100
Message-Id: <20180517085850.14276-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
References: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a multiple calls to pm_runtime_mark_last_busy(),
which looks like a typo.
Fix this by properly adding pm_runtime_put_autosuspend to put controller
in auto suspend state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 5a2ff01b394c..1c57b631031a 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -139,7 +139,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 		 * if there was error during this transaction
 		 */
 		pm_runtime_mark_last_busy(ctrl->dev);
-		pm_runtime_mark_last_busy(ctrl->dev);
+		pm_runtime_put_autosuspend(ctrl->dev);
 	}
 	return ret;
 }
-- 
2.16.2
