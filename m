Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeBZIfZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:35:25 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42240 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeBZIed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:34:33 -0500
X-Google-Smtp-Source: AG47ELtIjRoeiWZ7HCc3c/GMTzCoMWX/Pbw0nxeOXbXbFB+Kw/Uw6wDp+7XWlUbp8JST4sSjx37AgQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        alexandre.belloni@free-electrons.com
Subject: [RESEND PATCH 1/3] rtc: Use time64_t to save range_max of RTC
Date: Mon, 26 Feb 2018 16:33:56 +0800
Message-Id: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need use rtc->range_max to valid if the time values are valid,
and the time values are saved by time64_t type. So change the
rtc->range_max to time64_t type for comparison correctly.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/rtc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index bdfc0c4..8560282 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -152,7 +152,7 @@ struct rtc_device {
 	struct bin_attribute *nvram;
 
 	time64_t range_min;
-	timeu64_t range_max;
+	time64_t range_max;
 
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	struct work_struct uie_task;
-- 
1.7.9.5
