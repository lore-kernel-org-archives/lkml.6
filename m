Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeDKQly (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:41:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41081 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbeDKQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:41:50 -0400
X-Google-Smtp-Source: AIpwx4+7lgmAQlPn6ICVUncPf9ZhifgPaZWPXfn0d3d0x21Pm08jcM76qO32TsMT85TiXr5rJw857Q==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: afaerber@suse.de, robh+dt@kernel.org
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/4] soc: actions: sps: Add S900 power domains
Date: Wed, 11 Apr 2018 22:10:35 +0530
Message-Id: <20180411164036.8046-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/actions/owl-sps.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/soc/actions/owl-sps.c b/drivers/soc/actions/owl-sps.c
index 38b276e6f319..f6445d671f22 100644
--- a/drivers/soc/actions/owl-sps.c
+++ b/drivers/soc/actions/owl-sps.c
@@ -14,6 +14,7 @@
 #include <linux/soc/actions/owl-sps.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
 #include <dt-bindings/power/owl-s700-powergate.h>
+#include <dt-bindings/power/owl-s900-powergate.h>
 
 struct owl_sps_domain_info {
 	const char *name;
@@ -240,9 +241,66 @@ static const struct owl_sps_info s700_sps_info = {
 	.domains = s700_sps_domains,
 };
 
+static const struct owl_sps_domain_info s900_sps_domains[] = {
+	[S900_PD_GPU_B] = {
+		.name = "GPU_B",
+		.pwr_bit = 3,
+	},
+	[S900_PD_VCE] = {
+		.name = "VCE",
+		.pwr_bit = 4,
+	},
+	[S900_PD_SENSOR] = {
+		.name = "SENSOR",
+		.pwr_bit = 5,
+	},
+	[S900_PD_VDE] = {
+		.name = "VDE",
+		.pwr_bit = 6,
+	},
+	[S900_PD_HDE] = {
+		.name = "HDE",
+		.pwr_bit = 7,
+	},
+	[S900_PD_USB3] = {
+		.name = "USB3",
+		.pwr_bit = 8,
+	},
+	[S900_PD_DDR0] = {
+		.name = "DDR0",
+		.pwr_bit = 9,
+	},
+	[S900_PD_DDR1] = {
+		.name = "DDR1",
+		.pwr_bit = 10,
+	},
+	[S900_PD_DE] = {
+		.name = "DE",
+		.pwr_bit = 13,
+	},
+	[S900_PD_NAND] = {
+		.name = "NAND",
+		.pwr_bit = 14,
+	},
+	[S900_PD_USB2_H0] = {
+		.name = "USB2_H0",
+		.pwr_bit = 15,
+	},
+	[S900_PD_USB2_H1] = {
+		.name = "USB2_H1",
+		.pwr_bit = 16,
+	},
+};
+
+static const struct owl_sps_info s900_sps_info = {
+	.num_domains = ARRAY_SIZE(s900_sps_domains),
+	.domains = s900_sps_domains,
+};
+
 static const struct of_device_id owl_sps_of_matches[] = {
 	{ .compatible = "actions,s500-sps", .data = &s500_sps_info },
 	{ .compatible = "actions,s700-sps", .data = &s700_sps_info },
+	{ .compatible = "actions,s900-sps", .data = &s900_sps_info },
 	{ }
 };
 
-- 
2.14.1
