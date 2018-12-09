Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49795C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1102082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2v3Ommw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1102082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLIUci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:32:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45317 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLIUbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so6469788lfa.12;
        Sun, 09 Dec 2018 12:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8tWnqfTImTopunu8sUlacPuJT6sCtuddL2Qd9mEEDg=;
        b=o2v3OmmwFZ7+TbqFMu/BPxZ8TR/KA7olZiTUxpfJaJ/JOefVWqmltSLlG4X3ZxDSOB
         pZSWVMpl6ooYX3NmiS46ZsX29uJsewWg1ob6+UZiqb4LhrqUIwR1F8qn6SQ8YN5nqi/l
         XGxaJFBryNvWk6KaEzWYju+tZM3/d3IRzuv7e84xxUZhtua99CI2PtsFvprPZO/8yXhi
         K3mQJkzyiOe9eLzQuFFvypXsYlFvR6FvGYQkk/GVOqFj1aqqW0bXRXvIOoKy+F84cw1J
         KNYbJ/xom9y5msRwCZOXgfST0zWUmgOdvOHoZ2h/fArt8QlUYgcCP8fJKkNy13nm7/9J
         k9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8tWnqfTImTopunu8sUlacPuJT6sCtuddL2Qd9mEEDg=;
        b=jft1wozx6/OCheOq9GJfX6+hZ0pGnj7ZaEnm3pPwQAGLSYIF5IGvvn20KBRMFUWdyc
         LWtGVLimkundowevOHCtoqbwc0TLDeA1rTqFY9Plzej6T9YjOsrJ2tDXwUMJui/Hi4ki
         SfR7YVZb15uzWu2gu0/zw71mU59gGkzqRgWeD7BVoqZs1osD0/6aNCH8s5d9M6VhPAgu
         1ryWbC5OzYqHWyXvZuNfGS70d/TQi5Kyd8scOSg0X2Fim9/3lsBJ5FQfQW9EX/uFqdJ7
         07aO8E3H55noq8L7nj6Xzmr0Koaz/1D3TarGNB7Ua5M1qocD4VHOx7ZPnh7N/7BaQr85
         EogQ==
X-Gm-Message-State: AA+aEWYU2vOebTEKz2okSUge+PV59/aWBlC8rX2jv5VkqQsVcfIqQkgr
        TgtfaeVu+3Ew62aYb5wPYx8=
X-Google-Smtp-Source: AFSGD/VhzRuqckB1ezIXchcv4HFYBuPO75GaZFOuKIZfYRJxcPWdEXMMBtETbyreO6wio9o5fpG8mA==
X-Received: by 2002:a19:4ace:: with SMTP id x197mr5034313lfa.39.1544387466521;
        Sun, 09 Dec 2018 12:31:06 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/21] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Sun,  9 Dec 2018 23:29:37 +0300
Message-Id: <20181209202950.31486-9-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
2.19.1

