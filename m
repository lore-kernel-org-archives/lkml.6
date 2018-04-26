Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757039AbeDZRfZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:35:25 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:24136 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754574AbeDZRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:35:16 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0Jfyqs9nA==
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
Subject: [PATCH v4 4/7] gpio: pca953x: define masks for addressing common and extended registers
Date: Thu, 26 Apr 2018 19:34:59 +0200
Message-Id: <602635f43a68cac5cfb973528320f2304e10b178.1524764101.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These mask bits are to be used to map the extended register
addreseses (which are defined for an unsupported 8-bit pcal chip)
to 16 and 24 bit chips (pcal6524).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 2b667166e855..fc863faa3ce4 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -56,6 +56,9 @@
 #define PCAL6524_DEBOUNCE	0x2d
 
 #define PCA_GPIO_MASK		0x00FF
+#define PCAL_GPIO_MASK		GENMASK(4, 0)
+#define PCAL_PINCTRL_MASK	(~PCAL_GPIO_MASK)
+
 #define PCA_INT			0x0100
 #define PCA_PCAL		0x0200
 #define PCA_LATCH_INT (PCA_PCAL | PCA_INT)
-- 
2.12.2
