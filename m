Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeFAJGn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:06:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42867 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeFAJFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:05:55 -0400
X-Google-Smtp-Source: ADUXVKI+AGtrnPK/KFKFmPoSgvYqska8R5eHerEuN8NuQ7PO8u6LcMCACHiKCiC/I8Am6mMeWs9iKQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc: baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] spi: sprd: Replace of_hwspin_lock_get_id() with of_hwspin_lock_get_id_byname()
Date: Fri,  1 Jun 2018 17:04:54 +0800
Message-Id: <1ee51555e05ad1fbfca7fac60050d318be9181f6.1527843425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
References: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
In-Reply-To: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
References: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the hwlock core has supplied new function to get a specific hwlock id
by one hwlock name, which is more clear for users. So change to use
of_hwspin_lock_get_id_byname().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 6fc50cf..d8d5e2f 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -459,7 +459,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	sadi->slave_pbase = res->start + ADI_SLAVE_OFFSET;
 	sadi->ctlr = ctlr;
 	sadi->dev = &pdev->dev;
-	ret = of_hwspin_lock_get_id(np, 0);
+	ret = of_hwspin_lock_get_id_byname(np, "adi");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not get the hardware spinlock\n");
 		goto put_ctlr;
-- 
1.7.9.5
