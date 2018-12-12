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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BBEC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457CF2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zoio9Bim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457CF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeLLUxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35208 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeLLUxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so9162180plo.2;
        Wed, 12 Dec 2018 12:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMYR9IeA85noSAK/OpqYWRb/I0AEsHldjTDUqxIg6JE=;
        b=Zoio9BimUIeRW9c2FqcHN+1aH4DMVmN5BbCImJe3ewRhrlZJSdi6z7ZNDX9g0QqUtG
         3+xeMiB/w4nFVxgnjsXvCkM9n6gDmvnN1ICd9GEatlo3AGGDjUt/hp+7+prcwiTWRwPk
         ejodRYN2oBNUkXvGCixQk7uYppgPfcCWqdF0li3qS2DrOyyuUDw0gBvgXYw+kG0Wa3Ks
         WyRLpzw0eKNsN5daTJxuR4df3vN8NggB6ZESV915Vczj1oO67oCmVFBRpz5lEBOUXOfX
         Ynx44wTg9RH4HvYiThDkXyTvg7GFmGQiVFfOs0oPTm+yypeoV5q/lb1pdkkUkVyh113M
         YmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMYR9IeA85noSAK/OpqYWRb/I0AEsHldjTDUqxIg6JE=;
        b=D8S1jSo2dpGjKKZ52zINx608ZupLaXkvnV9a/xN1ANicJxiiPiLr6GdngKDuo0vw7v
         IW4BCB/gy6nZc8GH/4oG3Ro63TvYDc4lWR4OyRTgjAbhJfo3Ne9/17kBRYsDT5sfRKzl
         vYr0zCf7eJ0YawcV3otcQTd1M5aWhjPFHZIaRjzlUYS5TfJTwNy9X4hWmYRd2M/oR+Ma
         vtI+7bcc8vn+iNuNAw0SE7aZy/0MMowi+5j3Hg7i5CMRa24HBoMbDBm1s34jIXtF4V+v
         DgvV0e9WjEA9mN8Q0g7GIZFP6vIl3Z4BszgW1Pg9IrTwipSo0CXNOKypRFri1Jbvzqbo
         gZ/A==
X-Gm-Message-State: AA+aEWbcINMuyA26I/UZf+p5J8PKQY3TgIxQm354ylneBudWej42YRx0
        aRHYMYPmfn4IUethuf4ySeM=
X-Google-Smtp-Source: AFSGD/Wkt+hDr6n7IbAqDWIELiPWn8A0Gs4jByK3GJajcIZk+mI3A+1GyWL2ABph9/L2983WYPc4cA==
X-Received: by 2002:a17:902:b7c7:: with SMTP id v7mr21288663plz.75.1544647981338;
        Wed, 12 Dec 2018 12:53:01 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/24] memory: tegra: Read client ID on GART page fault
Date:   Wed, 12 Dec 2018 23:38:53 +0300
Message-Id: <20181212203907.23461-11-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the device tree binding changes, now Memory Controller has access to
GART registers. Hence it is now possible to read client ID on GART page
fault to get information about what memory client causes the fault.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 59db13287b47..ce8cf81b55d7 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -38,6 +38,7 @@
 
 #define MC_ERR_ADR 0x0c
 
+#define MC_GART_ERROR_REQ		0x30
 #define MC_DECERR_EMEM_OTHERS_STATUS	0x58
 #define MC_SECURITY_VIOLATION_STATUS	0x74
 
@@ -575,8 +576,15 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			break;
 
 		case MC_INT_INVALID_GART_PAGE:
-			dev_err_ratelimited(mc->dev, "%s\n", error);
-			continue;
+			reg = MC_GART_ERROR_REQ;
+			value = mc_readl(mc, reg);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
 
 		case MC_INT_SECURITY_VIOLATION:
 			reg = MC_SECURITY_VIOLATION_STATUS;
-- 
2.20.0

