Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B931C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F5A263B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAX6MZpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F5A263B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935169AbeFZBAf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:00:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53200 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755764AbeFZA7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:09 -0400
Received: by mail-it0-f66.google.com with SMTP id m194-v6so15208037itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ykWRwse3ZZFWvvwZIi1NRP2Kheq0JMqj14q6nMHsCMc=;
        b=UAX6MZppTydTMGxWWX8cy7zgQBwTSL8npUO3M79SWxNhgDT22eCvkE9/rj7Vat4+7V
         iixRVz7ODWBGE6ZiHPWbpK5YoVFDt3/BsNHJS5eqr3cupKFlRPF0xO/KLZeQNgcoswKc
         +FziDtZcCdhoTHBiEnqleNtI9t7ll3jutcfSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ykWRwse3ZZFWvvwZIi1NRP2Kheq0JMqj14q6nMHsCMc=;
        b=l2IODsYu5x80b/mOouiZe7xtUx/nXeoD2m8ITwhiyKvJzZ2Ved3rdw6kNe3YyZCHKz
         ATPjeIlelNvxITBi8I6kZWBkBvwPGJ8JvUKlUGN/2IXqD5wfqd4KrByf00Ns6xs5UfuI
         tDDpNhe63FCu6P+pt73X1+6Hs936xhPom5Y8lJpk3rYQra+QRuKCq58qVU6KZ60L+W3V
         A1TKxzOMCIikcscIgQWS8I8z8STAm0z36RlCyIIBpTM3yWKY8GojdP0iczHkN/XZmyL2
         HGecNA8WbI+5sqY1Txjt2iahPkVorZKNGv3nefElEhYTtt5bUoXaANrBkz3XTvbqr/BK
         MDzg==
X-Gm-Message-State: APt69E3qAFlbgN0TszqWCftkgZU+iuqB0XhXeRc9ymQdX0S6vMvuBM7Q
        SP7WIkr9QhYLDO5y2d/neNbnIw==
X-Google-Smtp-Source: ADUXVKLHGbZwu3SE+900AXlQLfKGXLitCp8lWvF0JnD7acbLyoIKLKNL7kgH/JB78Z+4B09KxPF0gA==
X-Received: by 2002:a24:6e95:: with SMTP id w143-v6mr2726834itc.108.1529974748034;
        Mon, 25 Jun 2018 17:59:08 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:07 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 07/12] soc: qcom: smem: introduce qcom_smem_partition_header()
Date:   Mon, 25 Jun 2018 19:58:51 -0500
Message-Id: <20180626005856.14174-8-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new function qcom_smem_partition_header() to encapsulate
validating locating a partition header and validating information
found within it.  This will be built up over a few commits to make
it more obvious how the common function is replacing duplicated code
elsewhere.  Initially it just verifies the header has the right
magic number.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 45 ++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 49f228e9d2d3..516a17d340af 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -727,6 +727,29 @@ static u32 qcom_smem_get_item_count(struct qcom_smem *smem)
 	return le16_to_cpu(info->num_items);
 }
 
+/*
+ * Validate the partition header for a partition whose partition
+ * table entry is supplied.  Returns a pointer to its header if
+ * valid, or a null pointer otherwise.
+ */
+static struct smem_partition_header *
+qcom_smem_partition_header(struct qcom_smem *smem,
+		struct smem_ptable_entry *entry)
+{
+	struct smem_partition_header *header;
+
+	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
+
+	if (memcmp(header->magic, SMEM_PART_MAGIC, sizeof(header->magic))) {
+		dev_err(smem->dev, "bad partition magic %02x %02x %02x %02x\n",
+			header->magic[0], header->magic[1],
+			header->magic[2], header->magic[3]);
+		return NULL;
+	}
+
+	return header;
+}
+
 static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 {
 	struct smem_partition_header *header;
@@ -760,15 +783,13 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
+	header = qcom_smem_partition_header(smem, entry);
+	if (!header)
+		return -EINVAL;
+
 	host0 = le16_to_cpu(header->host0);
 	host1 = le16_to_cpu(header->host1);
 
-	if (memcmp(header->magic, SMEM_PART_MAGIC, sizeof(header->magic))) {
-		dev_err(smem->dev, "Global partition has invalid magic\n");
-		return -EINVAL;
-	}
-
 	if (host0 != SMEM_GLOBAL_HOST || host1 != SMEM_GLOBAL_HOST) {
 		dev_err(smem->dev, "Global partition hosts are invalid\n");
 		return -EINVAL;
@@ -836,17 +857,13 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
+		header = qcom_smem_partition_header(smem, entry);
+		if (!header)
+			return -EINVAL;
+
 		host0 = le16_to_cpu(header->host0);
 		host1 = le16_to_cpu(header->host1);
 
-		if (memcmp(header->magic, SMEM_PART_MAGIC,
-			    sizeof(header->magic))) {
-			dev_err(smem->dev,
-				"Partition %d has invalid magic\n", i);
-			return -EINVAL;
-		}
-
 		if (host0 != host0 || host1 != host1) {
 			dev_err(smem->dev,
 				"Partition %d hosts don't match\n", i);
-- 
2.17.1

