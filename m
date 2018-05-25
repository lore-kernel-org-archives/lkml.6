Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966042AbeEYOii (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:38:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52036 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965074AbeEYOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:38:28 -0400
X-Google-Smtp-Source: ADUXVKLhutydzSxufaVRqvsKkr62/NEUj08ozroqBwakxUUGLgrmh+Zy9GnCx6y2bYUNuM/ZxXuGhQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 5/8] slimbus: messaging: initialize completion correctly
Date: Fri, 25 May 2018 15:36:15 +0100
Message-Id: <20180525143618.820-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
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
index 1c57b631031a..e3605ed1c459 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -246,6 +246,7 @@ static void slim_fill_msg(struct slim_val_inf *msg, u32 addr,
 	msg->num_bytes = count;
 	msg->rbuf = rbuf;
 	msg->wbuf = wbuf;
+	msg->comp = NULL;
 }
 
 /**
-- 
2.16.2
