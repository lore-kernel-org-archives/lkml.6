Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeCJLDQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 06:03:16 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:31603 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeCJLDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 06:03:13 -0500
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pF1YSOLNQ=
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] drivers: gpio: pca953x: add compatibility for pcal6524 and pcal9555a
Date: Sat, 10 Mar 2018 12:00:01 +0100
Message-Id: <49f6922ba342cf69bfd2a787d0c2a93b4df2c429.1520664883.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pyra-Handheld originally used the tca6424 but recently we have
replaced it by the pin and package compatible pcal6524. So let's
add this to the bindings and the driver.

And while we are at it, the pcal9555a does not have a compatible entry
either but is already supported by the device id table.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 2 ++
 drivers/gpio/gpio-pca953x.c                             | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
index 0d0158728f89..d2a937682836 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
@@ -16,6 +16,8 @@ Required properties:
 	nxp,pca9574
 	nxp,pca9575
 	nxp,pca9698
+	nxp,pcal6524
+	nxp,pcal9555a
 	maxim,max7310
 	maxim,max7312
 	maxim,max7313
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index a0a5f9730aa7..d2ead4b1cf61 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -70,6 +70,7 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "pca9575", 16 | PCA957X_TYPE | PCA_INT, },
 	{ "pca9698", 40 | PCA953X_TYPE, },
 
+	{ "pcal6524", 24 | PCA953X_TYPE | PCA_INT | PCA_PCAL, },
 	{ "pcal9555a", 16 | PCA953X_TYPE | PCA_INT | PCA_PCAL, },
 
 	{ "max7310", 8  | PCA953X_TYPE, },
@@ -935,6 +936,9 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "nxp,pca9575", .data = OF_957X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9698", .data = OF_953X(40, 0), },
 
+	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_INT), },
+	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_INT), },
+
 	{ .compatible = "maxim,max7310", .data = OF_953X( 8, 0), },
 	{ .compatible = "maxim,max7312", .data = OF_953X(16, PCA_INT), },
 	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT), },
-- 
2.12.2
