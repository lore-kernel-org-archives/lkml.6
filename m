Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634CEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B52826395
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRnGHuqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B52826395
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934945AbeFZA7K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:59:10 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55887 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934743AbeFZA7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:07 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so15191013itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqgmo0i4y6iTyIYd+DAmlJreZeAqlQhGPtH0NQFjIq0=;
        b=SRnGHuqGRWAP9bcYjbBbeEsbcOvOZkdcGCB1Iq9kv18JrY9oKTjqquT1IIQXlbi575
         23ez0uSDFaXLHQqbyoYYmatCE/Y7i/+oHQ3gCJ5c2z4StuosYA7hpb8bXdnr3gNGxps0
         c/3SaytnfzVdbNLHcKl/60qDy3ATWQevcA6hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqgmo0i4y6iTyIYd+DAmlJreZeAqlQhGPtH0NQFjIq0=;
        b=ZiuEfDlA5+fBi1wCnMwIPWRe4BjU6UgE6Sv6dcceDL7eXuTzE30zumkH5iWsGnUOBx
         IOnCpHWKrDZgD9JP79XLXz4t1FR7H5ccs11+P1mq/Eat5dEgiTcSrtd880T9iBy4qGp4
         ajrUTeu/Tp+2BjIBDqsdCKPkDQOeL9ZFn/NQMcxYE8r0uQ7Bx4XDWD5vR5i2CY3JUfXq
         QJ6U0oxSRp2aS6dFBsVaeu88mYULsL2BvOdS/jAKKL5hkx+IzP8m20Vfd7xhlzFvtiaT
         NMoIA1rVcVv/t9fXOnR9LuKzzH+OuQdPcePqLYAfsdGNl9qqEvP2A5JSzNGBGKQSCfdy
         0nYw==
X-Gm-Message-State: APt69E2CWErLhnTw+jOS/+n3awYAA/E1Ps+c4AkxBKhC7xvnZbkK5gQY
        M2X+rOf06EmOSxbwhgx+HVvcWg==
X-Google-Smtp-Source: AAOMgpdSIK0bq/xvdLubW6mzRjKJVFf4mv9a3BUKvxQfA1qNNSdL6GLm48pHJqgn5POZBL4HJ0rOFw==
X-Received: by 2002:a24:f549:: with SMTP id k70-v6mr883648ith.123.1529974747021;
        Mon, 25 Jun 2018 17:59:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:06 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 06/12] soc: qcom: smem: require order of host ids to match
Date:   Mon, 25 Jun 2018 19:58:50 -0500
Message-Id: <20180626005856.14174-7-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qcom_smem_enumerate_partitions(), we find all partitions that
have a given local host id in either its host0 or its host1 field
in the partition table entry.  We then verify that the header
structure at the start of each partition also contains the same two
host ids as is found in the table of contents.

There is no requirement that the order of the two host ids be the
same in the table of contents and in the partition header.

This patch changes that, requiring host0 to in the partition table
entry to equal host0 in the partition header structure (and similar
for the host1 values).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6931602d9a9e..49f228e9d2d3 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -847,15 +847,9 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		if (host0 != local_host && host1 != local_host) {
+		if (host0 != host0 || host1 != host1) {
 			dev_err(smem->dev,
-				"Partition %d hosts are invalid\n", i);
-			return -EINVAL;
-		}
-
-		if (host0 != remote_host && host1 != remote_host) {
-			dev_err(smem->dev,
-				"Partition %d hosts are invalid\n", i);
+				"Partition %d hosts don't match\n", i);
 			return -EINVAL;
 		}
 
-- 
2.17.1

