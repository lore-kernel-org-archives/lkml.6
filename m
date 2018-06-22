Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1304EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9913423C8D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQcFbwHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9913423C8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934394AbeFVDYv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:24:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41324 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934351AbeFVDYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:24:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11-v6so2503150pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=paUx3mbJ/fGKTrCzR9iWMd0cKrJ2DrCtPIBJlU27mGU=;
        b=DQcFbwHdVjXgwNHsPmH/5+YmkRsdmeVOJf+ZekByCAcieL3gIrpms653HeFKzfHmbe
         zK7D1nY2PHQwPJLcsmnD4nqhIUQ9fJJrK5ml8ui8oQdrl4YmGZ52vSpzz87d/aLcSZxI
         rCdUgfL0BZ2t9X0ovS3oeC5RUHxWCli6Fw2ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=paUx3mbJ/fGKTrCzR9iWMd0cKrJ2DrCtPIBJlU27mGU=;
        b=BtRAT/CpCHvtAX/H4vCVtWCi4QHlIy7qPcGc2KpLefpeZkn6WLNN900FadIGPazCYc
         xXW6KKMA/D8ThMUsWPVggVVmJo57jng3TjhrS90B72rcpoR/4l98OLNlNGOjbgnOTlz7
         aPy6X+J2iSSa56ENR9cs7SN4bLR3/Rbltq+7ZTa4n+EAOOLnxme4n9tjyvKtArV2vHXO
         gxTzzDxraOe/g6PBtTZU0B8H/Vfqz0CY4sQ8L+/boVAX9yxQCRbxHUIQL9bnqkemUHhu
         HVNztxn09R4bLEltXikFawtV6p+SRrVqTpfS+kihYoLYTYTtyVlSh8Ctv6gGqHVRy6FW
         Vg9w==
X-Gm-Message-State: APt69E1I8Tf4NFLBD6GiUk1JGS+vHQuSRoTgvhm25nad3HQT6In1E4In
        LuUOnGeYxU+KTXnHDW6sKK/TSw==
X-Google-Smtp-Source: ADUXVKJodmSUOgqjSfId0B+dBIh5A8tJFf3xr897MvtoedZcErNGeAeAHWlRIkHSRnP2LPtRpK2gRA==
X-Received: by 2002:a65:4146:: with SMTP id x6-v6mr24869475pgp.221.1529637886034;
        Thu, 21 Jun 2018 20:24:46 -0700 (PDT)
Received: from localhost.localdomain ([45.56.155.153])
        by smtp.gmail.com with ESMTPSA id a23-v6sm9286253pfn.113.2018.06.21.20.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 20:24:45 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH 3/3] k3dma: delete axi_config
Date:   Fri, 22 Jun 2018 11:24:16 +0800
Message-Id: <20180622032416.20133-4-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622032416.20133-1-guodong.xu@linaro.org>
References: <20180622032416.20133-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

Axi_config controls whether DMA resources can be accessed in non-secure
mode, such as linux kernel. The setting is actually done in
bootloader stage.

This patch removes axi_config from k3dma driver.

Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/dma/k3dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 13cec12742e3..ddd7d1e054c0 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -52,8 +52,6 @@
 #define CX_SRC			0x814
 #define CX_DST			0x818
 #define CX_CFG			0x81c
-#define AXI_CFG			0x820
-#define AXI_CFG_DEFAULT		0x201201
 
 #define CX_LLI_CHAIN_EN		0x2
 #define CX_CFG_EN		0x1
@@ -158,7 +156,6 @@ static void k3_dma_set_desc(struct k3_dma_phy *phy, struct k3_desc_hw *hw)
 	writel_relaxed(hw->count, phy->base + CX_CNT0);
 	writel_relaxed(hw->saddr, phy->base + CX_SRC);
 	writel_relaxed(hw->daddr, phy->base + CX_DST);
-	writel_relaxed(AXI_CFG_DEFAULT, phy->base + AXI_CFG);
 	writel_relaxed(hw->config, phy->base + CX_CFG);
 }
 
-- 
2.17.1

