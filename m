Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeEBBNK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:13:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37747 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeEBBK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:29 -0400
X-Google-Smtp-Source: AB8JxZrhfU/HQI8dtttZQYEBuKxVpeCAFEAs8vTgNg7aPdC1U5C1Ja7Qmrppb8BTkfgamKErQpYmdQ==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] soc: qcom: smem: rename variable in qcom_smem_get_global()
Date: Tue,  1 May 2018 20:10:08 -0500
Message-Id: <20180502011019.22812-2-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable "area" to be "region" in qcom_smem_get_global(),
so its name better matches its type.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 70b2ee80d6bd..c46bb43c0f3d 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -277,7 +277,7 @@ struct qcom_smem {
 	u32 item_count;
 
 	unsigned num_regions;
-	struct smem_region regions[0];
+	struct smem_region regions[];
 };
 
 static void *
@@ -494,7 +494,7 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
 				  size_t *size)
 {
 	struct smem_header *header;
-	struct smem_region *area;
+	struct smem_region *region;
 	struct smem_global_entry *entry;
 	u32 aux_base;
 	unsigned i;
@@ -507,12 +507,12 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
 	aux_base = le32_to_cpu(entry->aux_base) & AUX_BASE_MASK;
 
 	for (i = 0; i < smem->num_regions; i++) {
-		area = &smem->regions[i];
+		region = &smem->regions[i];
 
-		if (area->aux_base == aux_base || !aux_base) {
+		if (region->aux_base == aux_base || !aux_base) {
 			if (size != NULL)
 				*size = le32_to_cpu(entry->size);
-			return area->virt_base + le32_to_cpu(entry->offset);
+			return region->virt_base + le32_to_cpu(entry->offset);
 		}
 	}
 
-- 
2.14.1
