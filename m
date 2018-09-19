Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36135C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0ED214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0ED214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbeISGsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:48:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33545 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISGsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:48:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C2926207D4; Wed, 19 Sep 2018 03:13:36 +0200 (CEST)
Received: from localhost (unknown [65.155.82.100])
        by mail.bootlin.com (Postfix) with ESMTPSA id 100A12071E;
        Wed, 19 Sep 2018 03:13:25 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: move rtc_add_group/s definitions
Date:   Wed, 19 Sep 2018 03:13:21 +0200
Message-Id: <20180919011322.3985-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rtc_add_group and rtc_add_groups definition to rtc.h that is available
for all RTC drivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-core.h | 14 --------------
 include/linux/rtc.h    | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index ccc17a2e293d..0abf98983e13 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -40,23 +40,9 @@ static inline void rtc_proc_del_device(struct rtc_device *rtc)
 
 #ifdef CONFIG_RTC_INTF_SYSFS
 const struct attribute_group **rtc_get_dev_attribute_groups(void);
-int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp);
-int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps);
 #else
 static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
 {
 	return NULL;
 }
-
-static inline
-int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
-{
-	return 0;
-}
-
-static inline
-int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
-{
-	return 0;
-}
 #endif
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index faf00a1472d4..c8bb4a2b48c3 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -272,4 +272,20 @@ static inline int rtc_nvmem_register(struct rtc_device *rtc,
 static inline void rtc_nvmem_unregister(struct rtc_device *rtc) {}
 #endif
 
+#ifdef CONFIG_RTC_INTF_SYSFS
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp);
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps);
+#else
+static inline
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
+{
+	return 0;
+}
+
+static inline
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
+{
+	return 0;
+}
+#endif
 #endif /* _LINUX_RTC_H_ */
-- 
2.19.0

