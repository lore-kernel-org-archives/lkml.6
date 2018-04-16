Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754715AbeDPM5T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:57:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33771 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbeDPM5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:57:04 -0400
X-Google-Smtp-Source: AIpwx485qhSViCe5cqHgigD/se0DXgmoeePdl1/DcPCiz/4b4JP5gVS2nyOApePLZwLdzC+yyTEYLw==
From: Lee Jones <lee.jones@linaro.org>
To: linus.walleij@linaro.org, ldewangan@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 3/3] mfd: db8500-prcmu: Example using new OF_MFD_CELL/MFD_CELL_BASIC MACROs
Date: Mon, 16 Apr 2018 13:56:27 +0100
Message-Id: <20180416125627.22156-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416125627.22156-1-lee.jones@linaro.org>
References: <20180416125627.22156-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... with and without 'resources'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5970b8def548..91259addab54 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3038,23 +3038,13 @@ static const struct mfd_cell common_prcmu_devs[] = {
 };
 
 static const struct mfd_cell db8500_prcmu_devs[] = {
-	{
-		.name = "db8500-prcmu-regulators",
-		.of_compatible = "stericsson,db8500-prcmu-regulator",
-		.platform_data = &db8500_regulators,
-		.pdata_size = sizeof(db8500_regulators),
-	},
-	{
-		.name = "cpuidle-dbx500",
-		.of_compatible = "stericsson,cpuidle-dbx500",
-	},
-	{
-		.name = "db8500-thermal",
-		.num_resources = ARRAY_SIZE(db8500_thsens_resources),
-		.resources = db8500_thsens_resources,
-		.platform_data = &db8500_thsens_data,
-		.pdata_size = sizeof(db8500_thsens_data),
-	},
+	OF_MFD_CELL("db8500-prcmu-regulators", NULL, &db8500_regulators,
+		    sizeof(db8500_regulators), 0,
+		    "stericsson,db8500-prcmu-regulator"),
+	OF_MFD_CELL("cpuidle-dbx500", NULL, NULL, 0, 0,
+		    "stericsson,cpuidle-dbx500"),
+	MFD_CELL_BASIC("db8500-thermal", db8500_thsens_resources,
+		       &db8500_thsens_data, sizeof(db8500_thsens_data), 0),
 };
 
 static int db8500_prcmu_register_ab8500(struct device *parent)
-- 
2.14.1
