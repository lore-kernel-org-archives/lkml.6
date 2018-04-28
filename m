Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759017AbeD1Qd7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 12:33:59 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:9099 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758307AbeD1Qdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 12:33:55 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0Nfzb0=
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
Subject: [PATCH v5 2/7] gpio: pca953x: add more register definitions for pcal953x
Date: Sat, 28 Apr 2018 18:31:32 +0200
Message-Id: <79da0e04213915b797222027bbeaebf513387e62.1524933096.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com>
In-Reply-To: <cover.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCAL chips ("L" seems to stand for "latched") have additional
registers starting at address 0x40 to control the latches,
interrupt mask, pull-up and pull down etc.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 508d0f6dceb7..fecd0e0aba93 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -41,9 +41,13 @@
 #define PCA957X_MSK		0x06
 #define PCA957X_INTS		0x07
 
+#define PCAL953X_OUT_STRENGTH	0x20
 #define PCAL953X_IN_LATCH	0x22
+#define PCAL953X_PULL_EN	0x23
+#define PCAL953X_PULL_SEL	0x24
 #define PCAL953X_INT_MASK	0x25
 #define PCAL953X_INT_STAT	0x26
+#define PCAL953X_OUT_CONF	0x27
 
 #define PCA_GPIO_MASK		0x00FF
 #define PCA_INT			0x0100
-- 
2.12.2
