Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31915C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48792639E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0Oyxgxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48792639E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964916AbeFZA7n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:59:43 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53811 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935032AbeFZA7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:13 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so15194709itd.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q/oytLGFLVRRIBLXYs4209CjepSv9RVJ004ROdrEisY=;
        b=B0Oyxgxv42nR+j95ZjkMjf/e78vZgYARaa38mgsIf3Y78JDQrFB3MYS7s7NF65Fwqa
         CfgVnnEf3RS7uUGltwgrAD2KURFoDHspBof/yDHATp9xdx3BiRV7POk8KTjOLN2KzEnc
         Ll98jXq340RyujuGoS9dqZ9z9dPBoGjjaNBwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q/oytLGFLVRRIBLXYs4209CjepSv9RVJ004ROdrEisY=;
        b=Jy2SfNc72xPbHd5L17IJBuW8HArVL8jd7LIaxwVWc3vc1M4mE+j1CHMlYw3WluvI/w
         XCJ+Eq1nIgtLw2hp2+PIWb/mPXx825OD0ixnops/G0RR7SZ5UtmNQbsy6TLP4XlU5yzf
         f5jCsPVJ44IQDRwLElR2nBvvVJFsC+fAi2ZIUSA/AGCznqzaN7/vlPHkCrN4KbhIMtN3
         65mKzVkTp/XsuHFDmyLKdB9VViQmrHawGXqI8EaKowENlh5kia1A4hdkz4usRhEDAOfg
         VfVJR41GLnGKGWPGV+tM2Q+iiWzKAJHBmZqkLs1mLk9zxAPVIommdT64ONkcR1K5JDY9
         Ij3A==
X-Gm-Message-State: APt69E1fvKiw6HxkWZP2cWjuGUfYQFUVQ96/XFkIGi99IJpofpLnviu3
        9Lrcy69+U8F9IqyzhB4o/y66YA==
X-Google-Smtp-Source: ADUXVKI7tHrnL+vSN/ykWlnzjGvJbAcPoFLqFH36/DB7qLVz/TE/KX4Wazo2I8LBvmFjee61V0eD4w==
X-Received: by 2002:a02:6f47:: with SMTP id b7-v6mr9563847jae.32.1529974752662;
        Mon, 25 Jun 2018 17:59:12 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:12 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 12/12] soc: qcom: smem: a few last cleanups
Date:   Mon, 25 Jun 2018 19:58:56 -0500
Message-Id: <20180626005856.14174-13-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains several small cleanups:
  - In qcom_smem_enumerate_partitions(), change the "local_host"
    argument to have 16 bit unsigned type
  - Also in qcom_smem_enumerate_partitions(), change the type of
    the "host0" and "host1" local variables to be u16
  - Fix error messages reporting host ids to use the right format
    specifier
  - Shorten the error messages as well, to fit on one line
  - Add a compile-time check to ensure the local host value passed
    to qcom_smem_enumerate_partitions() is in range

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7383a0e1b468..0d7f369c3f7a 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -819,14 +819,14 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	return 0;
 }
 
-static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
-					  unsigned int local_host)
+static int
+qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 {
 	struct smem_partition_header *header;
 	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
 	unsigned int remote_host;
-	u32 host0, host1;
+	u16 host0, host1;
 	int i;
 
 	ptable = qcom_smem_get_ptable(smem);
@@ -850,16 +850,12 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			continue;
 
 		if (remote_host >= SMEM_HOST_COUNT) {
-			dev_err(smem->dev,
-				"Invalid remote host %d\n",
-				remote_host);
+			dev_err(smem->dev, "bad host %hu\n", remote_host);
 			return -EINVAL;
 		}
 
 		if (smem->partitions[remote_host]) {
-			dev_err(smem->dev,
-				"Already found a partition for host %d\n",
-				remote_host);
+			dev_err(smem->dev, "duplicate host %hu\n", remote_host);
 			return -EINVAL;
 		}
 
@@ -956,6 +952,7 @@ static int qcom_smem_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(SMEM_HOST_APPS >= SMEM_HOST_COUNT);
 	ret = qcom_smem_enumerate_partitions(smem, SMEM_HOST_APPS);
 	if (ret < 0 && ret != -ENOENT)
 		return ret;
-- 
2.17.1

