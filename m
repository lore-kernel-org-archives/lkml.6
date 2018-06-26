Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F0BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50E6263AE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivy95Yi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50E6263AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935289AbeFZBBo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:01:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:47008 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934022AbeFZA7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:03 -0400
Received: by mail-io0-f196.google.com with SMTP id u23-v6so10609288ioc.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n+sOnaiAnzk1RDU6WjGHWVb8XkDgEeSKO+QskCnkucM=;
        b=ivy95Yi0EqPpQYJ8I/RxN1PSs/JcwqSIDlRr1iMc5fhHPhx2Xeuj74vZqM8SlBI08P
         NXOQNCq1iezmJvoatgaGSGGWQw6B2Z1Glt0zWmz6jC/XBJDvuTifpbMe4vt0QhzGA5HI
         LID1/KR3h5uQPfgLV1PYSRw3p+clk8v8d7xKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n+sOnaiAnzk1RDU6WjGHWVb8XkDgEeSKO+QskCnkucM=;
        b=XXai1jh7F+2Cho9YKbcCX+JFRkUObF56EKBDLUkmSb7Tl9lgPTJA0yYMmNFT25J6AK
         xotkN53GD2RQrLSY7RDkBjEwSz/2cgPTeMA/tG3y5wctMrmQEuGSDZLS+CEOQOFwbbX5
         FwLmIuwYXQXxoBwmv7LaZCwScSo3AUdprEpGLuvUKb8c6DGFxEwI8f+6ni0+hTonSess
         +Ycy8qMj2oa90yylf3haWepwXO6ai9cnEZnjfezvvlh8Y5kS+7nMXfI7scmcr5bEpvlZ
         Ah8oVW2tDbkqBvCT4us/TyDFhn4k6hdjqyCUNetrmTYHmnKHMXIydFBCQZaHViQgy62w
         m5LA==
X-Gm-Message-State: APt69E2Ut1qjpQd5ArLlMFhIONuPwH0jehx/6yAMe+mRlkafZGoGGXeL
        EkpTys3D5LX9qGze6JTTlyc3FQ==
X-Google-Smtp-Source: AAOMgpdSEmzPbiN6FGC0Tq0cMHJ541lMeCKos7+gdfyYLOiF0wY86QMUrPOXXmrQmtwSfjN9ZaSxfg==
X-Received: by 2002:a6b:3942:: with SMTP id g63-v6mr11547178ioa.225.1529974742442;
        Mon, 25 Jun 2018 17:59:02 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:02 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 01/12] soc: qcom: smem: rename variable in qcom_smem_get_global()
Date:   Mon, 25 Jun 2018 19:58:45 -0500
Message-Id: <20180626005856.14174-2-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
2.17.1

