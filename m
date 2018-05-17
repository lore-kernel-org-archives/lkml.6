Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEQJBD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:01:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37125 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeEQJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:01:00 -0400
X-Google-Smtp-Source: AB8JxZpqrzY4g+X8OvqMmq1xIQeEPpKB+aK3keZNpU+RQUokWnqsACUy1lafQzRVU66iADvz1JrqZw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH v2 3/8] slimbus: core: add need_tid flag to slim_msg_txn
Date: Thu, 17 May 2018 09:58:45 +0100
Message-Id: <20180517085850.14276-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
References: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add need_tid flag to txn, this flag can be set before start of transcation.
Having this flag would avoid calling slim_tid_txn() multiple times on the
same txn. Also it is handy for controller drivers too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 79f8e05d92dd..3ec5a85fba8e 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -102,6 +102,7 @@ struct slim_framer {
  * @msg: Elemental access message to be read/written
  * @comp: completion if read/write is synchronous, used internally
  *	for tid based transactions.
+ * @need_tid: flag indicating if a tid is required for this txn
  */
 struct slim_msg_txn {
 	u8			rl;
@@ -113,6 +114,7 @@ struct slim_msg_txn {
 	u8			la;
 	struct slim_val_inf	*msg;
 	struct	completion	*comp;
+	bool			need_tid;
 };
 
 /* Frequently used message transaction structures */
-- 
2.16.2
