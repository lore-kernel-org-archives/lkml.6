Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F4ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC3621477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE4+gD3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC3621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeIXGqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33970 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id f6-v6so8351653plo.1;
        Sun, 23 Sep 2018 17:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgvd47ntIDWOVMFx52mLZxwC1YUjcA5K/VrZts78hGo=;
        b=dE4+gD3eWRl6MqDgR5cnOpaC+9i1FNbQg4OmU4XEPauv3Gn5SSIhQX2qCn81XDG3oo
         0EBKME3dBkkKYrmu8+YIRnIGVIv8aUxsdHGDb1TV2WeO4Rm0Vw899MqxWFR0nFjGDJJq
         7ulsffMNMX1PuRkp9TkSTuMNF8zITHMDEcJ7tKV40VQZQnLYn55uvSLArCayG4/3sg/C
         1Nd2QTrZoW53QgOSwKqEpQyQcRQYH552QghrJqAXhlRxhzRdhQknglr0vu57+8HuIt0s
         hQc1D5pG+6r7ztCEBSYhxNnVjPFsXvEjSJRwzkkFGcpN8ksNC8ePFiotuFnw+0jxczM+
         zOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgvd47ntIDWOVMFx52mLZxwC1YUjcA5K/VrZts78hGo=;
        b=RTteJORJOJZv5b9zb/DA7t6qEEJLDxOK+zWUKw6drmxsGwguxGoTZq4S0ywjhKhulf
         zCCYh6mTAF23YECFqyyJO6WzcQSeDWEG3Z+1NVFEfHmugr4jlFTJurg2LVc5rqBoHA9e
         KN7rJCliPe40HoclJY3DqA3PHAns/aIVK3j/GzMXAGpzr5S/kcZ5j/jiocnCxJHbTkeI
         KZYqVQScOQH5pTlM0yPlYriPSHrdpAIJjxYDChNYzNFzJRIBbudphxkJkmBjojjavZWo
         DzesMt+1xz3i4PVBFOpQWgIWP5QG6DefJAthSdFPOC75KEpmIWDb9gGCqB/dTuLRz3BI
         /dgw==
X-Gm-Message-State: ABuFfojWzTN99gQccuY7IyTZUQcTZsEjqKOV7RzfQTGnL4a5DVF3kByQ
        IdpXHTmsd0/F69nXuFz+R2M=
X-Google-Smtp-Source: ACcGV62HHSzdFrB6PwmUo/G9bbcalxNT4YYBS+XvKOydi59D2Ktf2Nt8aidtHohWyWu37T5eogbo9Q==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61-v6mr8244943plb.172.1537750005122;
        Sun, 23 Sep 2018 17:46:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/20] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Mon, 24 Sep 2018 03:41:41 +0300
Message-Id: <20180924004153.8232-9-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
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
---
 drivers/memory/tegra/mc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bd25faf6d13d..e56862495f36 100644
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
2.19.0

