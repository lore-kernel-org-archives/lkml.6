Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967163AbeBNKT5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:19:57 -0500
Received: from mout.web.de ([217.72.192.78]:46845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966996AbeBNKTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:19:55 -0500
Subject: [PATCH 2/4] crypto: ux500: Adjust two condition checks in
 ux500_cryp_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Geliang Tang <geliangtang@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Message-ID: <d79ef7ab-cf49-6b32-01d8-e4aa77424e39@users.sourceforge.net>
Date: Wed, 14 Feb 2018 11:19:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:X1i36V9/ySxeNqGrbAhUyvLOYcEFoFEcQxx9Pm2sZj1PIt11vqN
 Ef34y8z7bYiKMlRu88XZ+BS4gfdxbK4y38nvWI0n1Ina+X8+I8xU8gz7b6dKS7B7QB36pDl
 c+/VK74epHU29TrIUDr6NowPFWX/4/ngFpCC5gzswXJi7L1gnD1m0Wj+aKWW5BKU7zQwcdM
 Pnu5jT80vpKkXX1pne2Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gbo1eNjzl7w=:qHl0Os8J54/BLXigrOMyWu
 ypqPRMeWnJGl6MB3Pwwb4s0ino/tBMTGgseri3FG62ZZcXsRTljggAr+wiiPh0p37sBQhnx4n
 +ZEb9fMOtW7nTSlpaDG92YvUrxpYHUm771YS+vctfkIIVYRG+6UKy+Z+4NdRbcZL4be8z2mqS
 MwOu+z5r7olV44Riq1zZscJCJODNTqvFStpHp/cAsZvUD7z52zunxy9ULo/+vgSAsCJ0quUDU
 2puXo9bALuS/QqJ01VFSCfJNwRlHVfMqtQVM+T8Drs9gaZ6na1wKfDKfm1MIevMyAbaTtAh7Q
 SWHiNrlSn5XdopWHZruWzc1LyDHmVvJxvg16BY7INrRuQUDj8IxSqc950IJqfN7iQNBHsQCI2
 XTTrps8KxRHeWeFPDApj+GAM8IAZMChGcoicRv3Hjh8JP6wT8MrdTIEpnPTuGYigqz2qpyWjW
 W9d2RsBiOGSufA0PqrdD6TJ7wzie2dJS4e+Hi9ZOSMwh604TdJ26jQZUsus+OgrvaKFb6ShYR
 scCww5BwTE3133BwohTiQH1T0SQPTfbpMtTA7BefQdSg0jHEByNPh2IzU3lkQnaYhLoR3FUC1
 iwChCpaLuvrNcRZGc0kegrqtZ3FWaoQc72zzKKuR2tjss6s1cAJAjRP4e5FFnPnVMx9WQW5ed
 c1QCXe9bl7HBib9ehVRxj2V/EYGYafW/ThUKJ0kvblTD/6j3XDyC1JKqcOk8ia+yUXoxnsmy+
 GEySWivISbcLqzgw+4l5wztSTjBZTw/lF2y509USU5e3DF9x6iIkTLadthb2OwBJ3Agsqa50E
 rIVPV+HH+LlbnjYay/wS/aO0JeW5RFY6B+6QhVpCTvNrwiDzAY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 10:38:44 +0100

The local variable "cryp_error" was used only for two condition checks.

* Check the return values from these function calls directly instead.

* Delete this variable which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/ux500/cryp/cryp_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 50bfc7b4c641..07cc92f88933 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1404,7 +1404,6 @@ static void cryp_algs_unregister_all(void)
 static int ux500_cryp_probe(struct platform_device *pdev)
 {
 	int ret;
-	int cryp_error = 0;
 	struct resource *res = NULL;
 	struct resource *res_irq = NULL;
 	struct cryp_device_data *device_data;
@@ -1478,15 +1477,13 @@ static int ux500_cryp_probe(struct platform_device *pdev)
 		goto out_clk_unprepare;
 	}
 
-	cryp_error = cryp_check(device_data);
-	if (cryp_error != 0) {
+	if (cryp_check(device_data)) {
 		dev_err(dev, "[%s]: cryp_init() failed!", __func__);
 		ret = -EINVAL;
 		goto out_power;
 	}
 
-	cryp_error = cryp_configure_protection(device_data, &prot);
-	if (cryp_error != 0) {
+	if (cryp_configure_protection(device_data, &prot)) {
 		dev_err(dev, "[%s]: cryp_configure_protection() failed!",
 			__func__);
 		ret = -EINVAL;
-- 
2.16.1
