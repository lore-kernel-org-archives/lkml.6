Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeEHO4T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:56:19 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:37882 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932689AbeEHO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:56:17 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.899
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/4] rtc: ds1307: fix data pointer to m41t0
Date: Tue,  8 May 2018 16:56:08 +0200
Message-Id: <20180508145611.49072-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data field points to m41t00, instead it should point to m41t0.
Driver works correctly because on both cases(m41t0 and m41t00) chip_desc
are equal.

Point to right enum m41t0 instead of m41t00.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a13e59edff53..32aadcbc377f 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -298,7 +298,7 @@ static const struct of_device_id ds1307_of_match[] = {
 	},
 	{
 		.compatible = "st,m41t0",
-		.data = (void *)m41t00
+		.data = (void *)m41t0
 	},
 	{
 		.compatible = "st,m41t00",
-- 
2.17.0
