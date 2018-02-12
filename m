Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933224AbeBLWyd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:54:33 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37575 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932937AbeBLWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:37 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 20/45] rtc: remove nvmem_config
Date: Mon, 12 Feb 2018 23:47:34 +0100
Message-Id: <20180212224759.15999-21-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because nvmem_config is only used and copied at nvmem registration, remove
it from struct rtc_device.

All the rtc drivers using nvmem are now calling rtc_nvmem_register
directly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c | 2 --
 include/linux/rtc.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 47c4aeed5106..999ed039da0d 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -453,8 +453,6 @@ int __rtc_register_device(struct module *owner, struct rtc_device *rtc)
 
 	rtc_proc_add_device(rtc);
 
-	rtc_nvmem_register(rtc, rtc->nvmem_config);
-
 	rtc->registered = true;
 	dev_info(rtc->dev.parent, "registered as %s\n",
 		 dev_name(&rtc->dev));
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index fbc92fff7c2e..37b041f72f8d 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -145,7 +145,6 @@ struct rtc_device {
 
 	bool registered;
 
-	struct nvmem_config *nvmem_config;
 	struct nvmem_device *nvmem;
 	/* Old ABI support */
 	bool nvram_old_abi;
-- 
2.16.1
