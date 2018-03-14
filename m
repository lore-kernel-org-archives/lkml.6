Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeCNT6I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:58:08 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:53632 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeCNT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:57:59 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Mar 2018 20:57:58 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] remoteproc: imx_rproc: Slightly simplify code in 'imx_rproc_probe()'
Date: Wed, 14 Mar 2018 20:56:39 +0100
Message-Id: <fbc1425293b6540a6fc835264fba2b71f2b63444.1521057013.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can return directly at the beginning of the function and save the 'err'
label.
We can also explicitly return 0 when the probe succeed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/remoteproc/imx_rproc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 6d02ef62a626..54c07fd3f204 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -333,10 +333,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	/* set some other name then imx */
 	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
 			    NULL, sizeof(*priv));
-	if (!rproc) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!rproc)
+		return -ENOMEM;
 
 	dcfg = of_device_get_match_data(dev);
 	if (!dcfg) {
@@ -381,13 +379,13 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		goto err_put_clk;
 	}
 
-	return ret;
+	return 0;
 
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
 err_put_rproc:
 	rproc_free(rproc);
-err:
+
 	return ret;
 }
 
-- 
2.14.1
