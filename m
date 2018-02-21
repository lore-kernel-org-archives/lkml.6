Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeBUU5a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:30 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46977 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeBUU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:24 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 029/100] rtc: efi: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:24 +0100
Message-Id: <20180221205635.31314-30-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index 0130afd7fe88..3454e7814524 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -176,7 +176,7 @@ static int efi_read_time(struct device *dev, struct rtc_time *tm)
 	if (!convert_from_efi_time(&eft, tm))
 		return -EIO;
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int efi_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
