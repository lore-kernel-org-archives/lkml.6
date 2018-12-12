Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3392C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854DC2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDCeYsFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854DC2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeLLUwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42626 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeLLUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so8881338pga.9;
        Wed, 12 Dec 2018 12:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jTAKXOxUqIS7qMJZ/cOzO/lJyZZGoS6ctb+zjRYbHw=;
        b=mDCeYsFJUeeKzPRwC3TFQ+tZubwK3LOV43LJUM822g/1lGzvHYpKNb4WSShzTcal6L
         vwLxldm2DdoLc0S9tTIoHTIx1kO8i+ffrgpv6PJzDl90PkELY5o2bAAaIVtfmgTJMimo
         usozCUfv7ynaUq724CrgpyyJT2XuEZiqWUVhNLvw5SZdxfR5T+wixDtHm3O+puoEPi/A
         8Cw818c+EEsm2O0FGrSgQo3WnhSz0UGvz6SY52KQwebT0MoAsxJANU6gITlRPBPKvfsX
         OCLoFtKqMEJmO/1o/K6FXMdTXKbwWq2LLl9DHvtKRVVT2POuBo0JNw+Pl43ssVJSjknJ
         ptRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jTAKXOxUqIS7qMJZ/cOzO/lJyZZGoS6ctb+zjRYbHw=;
        b=HY+KALQKO21xH4CN1xpGe5QPdi9kYinLSgk3Pv6WQk3DLJQJxnSpeaGNCrlGXLGTvI
         c39Zgd+kI6nKzgHaD9s6GFzbWmtWWMyK9LdrMXLn7l3O+O5LVD8fNpcMXjYWXVzWBgQf
         IArDMguRBRJ7cvLzxG4wiFzTLy/QSdLPvWtD11zrlGhtws1mUTdpn+JPE3B4dFhS5Z+Z
         L742/qoxpWrYbrYiAIJ5n7CGL3LvLQ8wjfaDF4+XcrC9CCQEvMRI3ch4JFibVS+p3Gk3
         MKvKPlP8C6wag2zrIP8kF3TLjL+Y/c+FgvqXyQCWhzP/1zEuoJAW68EMShUsoyhWqmdP
         qzuQ==
X-Gm-Message-State: AA+aEWY1+2bvNF0vTNWZbkfiHW5XeL2offJi8L5K1GOSoTvGxgdpFKag
        7UdtHkvdA91VEyU0+hyxoXo=
X-Google-Smtp-Source: AFSGD/UdTePp7+J4aAC4rQyUexiNuhpeIj636QOVz2XvPVXkqGMfuBfEnie2qnw0lbyRhWertJS14g==
X-Received: by 2002:a65:4ccb:: with SMTP id n11mr19991514pgt.257.1544647968817;
        Wed, 12 Dec 2018 12:52:48 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/24] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Wed, 12 Dec 2018 23:38:51 +0300
Message-Id: <20181212203907.23461-9-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes irrelevant "tegra-mc 7000f000.memory-controller: no memory
timings for RAM code 0 registered" warning message during of kernels
boot-up on Tegra20.

Fixes: a8d502fd3348 ("memory: tegra: Squash tegra20-mc into common tegra-mc driver")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 24afc36833bf..b99f3c620f6c 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -664,12 +664,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		}
 
 		isr = tegra_mc_irq;
-	}
 
-	err = tegra_mc_setup_timings(mc);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to setup timings: %d\n", err);
-		return err;
+		err = tegra_mc_setup_timings(mc);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to setup timings: %d\n",
+				err);
+			return err;
+		}
 	}
 
 	mc->irq = platform_get_irq(pdev, 0);
-- 
2.20.0

