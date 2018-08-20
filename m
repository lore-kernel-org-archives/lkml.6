Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF19C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ED0213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ED0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHTUnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:43:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37802 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbeHTUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:43:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so7101864pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 10:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LDi2q6slR2CALVvjK2a7dhG0FcXtkkX1M1my+s3T4MU=;
        b=r8dLitdUltk6Nl5J6l42V0wdOUQe/J5xtdyff2yTxZmzTBQTCc+Hjzi3thr0Ehp7mh
         +Rrc24pgZJ9+7hi/D9SEMUYzKY18o09hAugAI6hMDpNAu11cAGNvhgmZ3zgo93pPtSwN
         WuYjRtIdcbsinSsYeoOUtVNy4OMpJgDAeLNF7yP8nu8PjzwDi5jeoG7j1oJfDYadfAqP
         +fa0ysej+C4loNSETC9BIpnJFRmqAiAdylKjL/MZDo46sjj5VxqtZCx5/jjtSnpRNNVw
         GRNDYvc4NsFpMoHq+KximA633jrm/yyUozUJ3KVcb/S5LdSyCOtdTl1KX/B9Ig68zQKE
         t2gw==
X-Gm-Message-State: AOUpUlF0yy9ftKnE1v1e8IE6umB1oYnJrucqcL8pjxBetd5+8HVTG+QF
        qi46c8pZJzkpQaaH7IWaic1wrQ==
X-Google-Smtp-Source: AA+uWPycXkLE8zUFMPvYCOWF6D4hbYxRXeS96+aSIVugVs25vXlDD2tVGamlad28sWAu0kBDXPRGcw==
X-Received: by 2002:a63:2f45:: with SMTP id v66-v6mr11350750pgv.91.1534786041679;
        Mon, 20 Aug 2018 10:27:21 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id d19-v6sm459590pgv.61.2018.08.20.10.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 10:27:20 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     hao.wu@intel.com
Cc:     atull@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2] fpga: dfl: region: Restory symmetry in probe()/remove()
Date:   Mon, 20 Aug 2018 10:18:18 -0700
Message-Id: <20180820171818.7710-1-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dev_get_drvdata() with platform_get_drvdata() to
match the platform_set_drvdata() in the probe function of
the platform driver.

Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for FME")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v1:
- Still compile after change ...

---
 drivers/fpga/dfl-fme-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 0b7e19c27c6d..11d3c23a8936 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
 
 static int fme_region_remove(struct platform_device *pdev)
 {
-	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_region *region = platform_get_drvdata(pdev);
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(region->mgr);
-- 
2.18.0

