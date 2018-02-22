Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeBVJzA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:55:00 -0500
Received: from mail.phytec.co.uk ([217.6.246.34]:54779 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbeBVJy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:54:59 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, W.Egorov@phytec.de
Subject: [PATCH] mfd: rk808: Fix RK818 ID template
Date: Thu, 22 Feb 2018 10:54:52 +0100
Message-Id: <1519293292-46451-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 22.02.2018 10:54:57,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 22.02.2018 10:54:57,
        Serialize complete at 22.02.2018 10:54:57
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip PMIC driver can automatically detect connected component
versions by reading the ID_MSB and ID_LSB registers. The probe function
will always fail with RK818 PMICs because the ID_MSK is 0xFFF0 and the
RK818 template ID is 0x8181.

This patch changes this value to 0x8180.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/linux/mfd/rk808.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index d315659..338e0f6 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -443,7 +443,7 @@ enum {
 enum {
 	RK805_ID = 0x8050,
 	RK808_ID = 0x0000,
-	RK818_ID = 0x8181,
+	RK818_ID = 0x8180,
 };
 
 struct rk808 {
-- 
2.7.4
