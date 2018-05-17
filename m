Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEQFAI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:00:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:33152 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQFAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:00:04 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0Nfyq4rHQ=="
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 1/3] gpio: pca953x: set the PCA_PCAL flag also when matching by DT
Date: Thu, 17 May 2018 06:59:47 +0200
Message-Id: <7c9ab1d702eb62755993321865d260fa54b90358.1526533188.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1526533188.git.hns@goldelico.com>
References: <cover.1526533188.git.hns@goldelico.com>
In-Reply-To: <cover.1526533188.git.hns@goldelico.com>
References: <cover.1526533188.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_device_table is missing the PCA_PCAL flag so the
pcal6524 would be operated in tca6424 compatibility mode which
does not handle the new interrupt mask registers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 7d37692d672e..2b667166e855 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -58,6 +58,7 @@
 #define PCA_GPIO_MASK		0x00FF
 #define PCA_INT			0x0100
 #define PCA_PCAL		0x0200
+#define PCA_LATCH_INT (PCA_PCAL | PCA_INT)
 #define PCA953X_TYPE		0x1000
 #define PCA957X_TYPE		0x2000
 #define PCA_TYPE_MASK		0xF000
@@ -946,8 +947,8 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "nxp,pca9575", .data = OF_957X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9698", .data = OF_953X(40, 0), },
 
-	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_INT), },
-	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_INT), },
+	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_LATCH_INT), },
+	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_LATCH_INT), },
 
 	{ .compatible = "maxim,max7310", .data = OF_953X( 8, 0), },
 	{ .compatible = "maxim,max7312", .data = OF_953X(16, PCA_INT), },
-- 
2.12.2
