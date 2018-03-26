Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeCZKCK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:02:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58235 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750989AbeCZKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:02:09 -0400
X-UUID: f3cffa3287b94c5296223148f5bf1d34-20180326
From: <sean.wang@mediatek.com>
To: <thierry.reding@gmail.com>, <matthias.bgg@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: [PATCH] pwm: mediatek: remove redundant MODULE_ALIAS entries
Date: Mon, 26 Mar 2018 18:02:01 +0800
Message-ID: <0fbf589c69bc584c46c683ee7fa38d80e04624f6.1522055092.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TM-AS-Result: No-4.382700-8.000000-10
X-TMASE-MatchedRID: Ei0WBMmFdJjLqx3pQDUvTo0JVVcEm48nXs5nqGvDCfOl4EP+dy+wBGEj
        04n4UkciNMW1025grLlEOP/MktCQ9nEjLiYgp5vhA9lly13c/gHt/okBLaEo+N7qoZLm7F0iNuG
        E1/yHeZvi8zVgXoAltmHJPdY2OmlS0C1sQRfQzEHEQdG7H66TyJ8TMnmE+d0Z6dRKarUMrrQVWq
        yRlT7aUh6Kc65eHchzWn1zmUDUtcFlToWyw+n6G2alIygMo8bkPCAEq6enCrMu5B6q6cMXbX0++
        BlWaS2/k3UkV5Qp4wSI45Rd9ORJwFlJvEhEss3fvN+d4ahMo5NWXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.382700-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MODULE_ALIAS exports information to allow the module to be auto-loaded at
boot for the drivers registered using legacy platform registration.

However, currently the driver is always used by DT-only platform,
MODULE_ALIAS is redundant and should be removed properly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 98b0a93..328c1247 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -305,5 +305,4 @@ static struct platform_driver mtk_pwm_driver = {
 module_platform_driver(mtk_pwm_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
-MODULE_ALIAS("platform:mtk-pwm");
 MODULE_LICENSE("GPL");
-- 
2.7.4
