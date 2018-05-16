Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeEPTK1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:10:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56501 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbeEPTK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:10:26 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: nvmem: don't return an error when not enabled
Date: Wed, 16 May 2018 21:10:13 +0200
Message-Id: <20180516191013.28689-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid reporting an error when RTC_NVMEM is not selected.

Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 include/linux/rtc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 4c007f69082f..6268208760e9 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -285,7 +285,7 @@ void rtc_nvmem_unregister(struct rtc_device *rtc);
 static inline int rtc_nvmem_register(struct rtc_device *rtc,
 				     struct nvmem_config *nvmem_config)
 {
-	return -ENODEV;
+	return 0;
 }
 static inline void rtc_nvmem_unregister(struct rtc_device *rtc) {}
 #endif
-- 
2.17.0
