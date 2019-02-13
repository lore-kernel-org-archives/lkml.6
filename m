Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E70CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F7520836
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbfBMN6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:58:45 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:59309 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbfBMN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:58:42 -0500
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id AC49A10000E;
        Wed, 13 Feb 2019 13:58:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Florian Lohoff <f@zz.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: hid-sensor-time: stop selecting IIO
Date:   Wed, 13 Feb 2019 14:58:35 +0100
Message-Id: <20190213135835.17387-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make RTC_DRV_HID_SENSOR_TIME depend on IIO and HID_SENSOR_HUB to remove
possible circular dependencies as this is the only symbol selecting those.

Suggested-by: Florian Lohoff <f@zz.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a08785ac8903..5d155ce99517 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1835,8 +1835,7 @@ comment "HID Sensor RTC drivers"
 config RTC_DRV_HID_SENSOR_TIME
 	tristate "HID Sensor Time"
 	depends on USB_HID
-	select IIO
-	select HID_SENSOR_HUB
+	depends on HID_SENSOR_HUB && IIO
 	select HID_SENSOR_IIO_COMMON
 	help
 	  Say yes here to build support for the HID Sensors of type Time.
-- 
2.20.1

