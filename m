Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDJQHU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:07:20 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:33703 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDJQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:07:15 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0NfySCnhA==
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
Subject: [PATCH v3 1/4] gpio: pca953x: set the PCA_PCAL flag also when matching by DT
Date: Tue, 10 Apr 2018 18:07:01 +0200
Message-Id: <a5b37e5feff8a58dc63799ec76ef906695fd7239.1523376423.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1523376423.git.hns@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com>
In-Reply-To: <cover.1523376423.git.hns@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_device_table is missing the PCA_PCAL flag so the
pcal6524 would be operated in tca6424 compatibility mode which
does not handle the new interrupt mask registers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d2ead4b1cf61..4a075619b93e 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -936,8 +936,10 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "nxp,pca9575", .data = OF_957X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9698", .data = OF_953X(40, 0), },
 
-	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_INT), },
-	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_INT), },
+	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_INT |
+							    PCA_PCAL), },
+	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_INT |
+							     PCA_PCAL), },
 
 	{ .compatible = "maxim,max7310", .data = OF_953X( 8, 0), },
 	{ .compatible = "maxim,max7312", .data = OF_953X(16, PCA_INT), },
-- 
2.12.2
