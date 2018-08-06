Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4649C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A078121A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A078121A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbeHFSAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:00:47 -0400
Received: from bran.ispras.ru ([83.149.199.196]:23792 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728626AbeHFSAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:00:47 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 319E3203C7;
        Mon,  6 Aug 2018 18:51:04 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2 2/2] media: davinci: vpif_display: remove duplicate check
Date:   Mon,  6 Aug 2018 18:50:25 +0300
Message-Id: <20180806155025.8912-2-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806155025.8912-1-vasilyev@ispras.ru>
References: <20180806155025.8912-1-vasilyev@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch removes the duplicate platform_data check from vpif_probe().

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
v2: divided the original patch into two and made stylistic fixes based
on the Prabhakar's rewiev.
---
 drivers/media/platform/davinci/vpif_display.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index d9e578ac79c2..f000fc492ef9 100644
--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -1255,11 +1255,6 @@ static __init int vpif_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!pdev->dev.platform_data) {
-		dev_warn(&pdev->dev, "Missing platform data.  Giving up.\n");
-		return -EINVAL;
-	}
-
 	vpif_dev = &pdev->dev;
 	err = initialize_vpif();
 
-- 
2.18.0

