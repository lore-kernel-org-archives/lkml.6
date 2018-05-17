Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeEQJB3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:01:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40456 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeEQJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:01:04 -0400
X-Google-Smtp-Source: AB8JxZomWMLDR1Q9tl302KvCyXVGwzerudCNOLuSwIqy6j+TAK1M/JxtqnkarNqQK5weIuWiT9s+8w==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH v2 7/8] slimbus: messaging: initialize completion correctly
Date: Thu, 17 May 2018 09:58:49 +0100
Message-Id: <20180517085850.14276-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
References: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slim_val_inf can contain random value from stack, make sure the completion
is initialized to NULL while filling the msg.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index fd0788019357..2635eaaadf4a 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -277,6 +277,7 @@ static void slim_fill_msg(struct slim_val_inf *msg, u32 addr,
 	msg->num_bytes = count;
 	msg->rbuf = rbuf;
 	msg->wbuf = wbuf;
+	msg->comp = NULL;
 }
 
 /**
-- 
2.16.2
