Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53D7C606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbeFFJLx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:11:53 -0400
Received: from mx1.emlix.com ([46.4.235.150]:46872 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932265AbeFFJLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:11:52 -0400
From: Philipp Puschmann <pp@emlix.com>
To: slongerbeam@gmail.com
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, pp@emlix.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: ov5640: adjust xclk_max
Date: Wed,  6 Jun 2018 11:11:38 +0200
Message-Id: <20180606091138.9522-1-pp@emlix.com>
Organization: emlix gmbh, Goettingen, Germany
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to ov5640 datasheet xvclk is allowed to be between 6 and 54 MHz.
I run a successful test with 27 MHz.

Signed-off-by: Philipp Puschmann <pp@emlix.com>
---
 drivers/media/i2c/ov5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 852026baa2e7..a713cf1909ed 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -30,7 +30,7 @@
 
 /* min/typical/max system clock (xclk) frequencies */
 #define OV5640_XCLK_MIN  6000000
-#define OV5640_XCLK_MAX 24000000
+#define OV5640_XCLK_MAX 54000000
 
 #define OV5640_DEFAULT_SLAVE_ID 0x3c
 
-- 
2.17.0
