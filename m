Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936257AbeEYOjq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:39:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46238 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936185AbeEYOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:38:26 -0400
X-Google-Smtp-Source: AB8JxZryAlPapHDH2svzINutIlIYc6HdolxCPukFK7rDZwY7JiPHsjeqb+3qf5IPojfIgSai+ZKZSA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/8] slimbus: messaging: pass correct wbuf
Date: Fri, 25 May 2018 15:36:13 +0100
Message-Id: <20180525143618.820-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a typo while filling msg for slim_write, wbuf is
set to NULL instead of rbuf.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 457ea1f8db30..5a2ff01b394c 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -307,7 +307,7 @@ int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val)
 {
 	struct slim_val_inf msg;
 
-	slim_fill_msg(&msg, addr, count,  val, NULL);
+	slim_fill_msg(&msg, addr, count,  NULL, val);
 
 	return slim_xfer_msg(sdev, &msg, SLIM_MSG_MC_CHANGE_VALUE);
 }
-- 
2.16.2
