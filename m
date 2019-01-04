Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65575C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFA520874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkTDiFXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfADKr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:47:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:47:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so756344wml.2;
        Fri, 04 Jan 2019 02:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xpDAL9/YCh1qqkCTeD/Mgy8bX1iUucEHanYuvewn0w=;
        b=dkTDiFXTkneJgNyoG/Vj1rfPAjMDhfXwAe3cokQdhvJaSvCIp5z2hCW0v3qgylK7Tg
         65ZzGmh9LCuxa/usRDslBQxeiVd0e8joe3FfmFjpYiAgpc33s9Rir9twlK0EJkFuheUp
         AnJXLhiF4qNlTYL6Njn58v89MQ+eY76ycvsieMVKhd5YfnvynUQbK7qoi4XuY8QVoXo/
         kFiz7cjNEqpeBkefY/fYDtqa2Ykpjx3j6lw6OMh30d5giMyTX0enh7YkgeunLQ1SCZs9
         /MNzphwsRSeKTRyfAHnI4qZZD34K3hBTVYTTUe5E35yV3aOI+ClkmFES7UZa4cRIdYXV
         Dedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xpDAL9/YCh1qqkCTeD/Mgy8bX1iUucEHanYuvewn0w=;
        b=IBTEP6kDYMSt8jcSw8UXk58yL14X7H6EiLqeW34MLVtjC0WS/qlrbjieyHykr5K0bZ
         korRslWIDtSCODkAfTlz983IDyGOyVIX7GV7JnOiazSXfjl2b8BRtR555XWDz34m+ENa
         TrGbMvyMhOo959CcMYA1MFJjyCwdX5mz3FqYD8EAF1E+d8pi9Mgup22iUdmVoz0G5lRg
         f4GBdJ0BCGX5UQhp1Y6MX0/XFnff9s4uvJy9UikBbby22F4gpQr/SoJ31GCxn1PYnyyF
         d+QbnGKwLlop4nrJhbg0EWYlCe7LxXlb15nHZcLtUXS0tqNezWOV14OB353pCI9pma+q
         3rrA==
X-Gm-Message-State: AJcUukddkT+CyH7+pyjLYFoEAky7g2WFu4ws/kjd0+4ltQbYq/wwfw6E
        uzs5A+K/szFQfc7lt+KJG7g=
X-Google-Smtp-Source: ALg8bN7kHOy0rtk4BhtbMkAar92/PRIlPuLEamvR1DVfKquT4XcprgBIDQ6TZFbJD42W6DsSOKXIkw==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr903236wmi.57.1546598875060;
        Fri, 04 Jan 2019 02:47:55 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id o5sm703510wmg.25.2019.01.04.02.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 02:47:54 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Date:   Fri,  4 Jan 2019 11:47:52 +0100
Message-Id: <20190104104753.3383-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The implementation of sdhci_set_dma_mask() is conflating two things: on
one hand it uses the SDHCI_USE_64_BIT_DMA flag to determine whether or
not to use the 64-bit addressing capability of the controller and on the
other hand it also uses that flag to set a DMA mask for the controller's
parent device.

However, a controller supporting 64-bit addressing doesn't mean that it
needs to support addressing 64 bits of address range. It's perfectly
acceptable to use 64-bit addressing for a 32-bit address range or even
smaller, even if that makes little sense, considering the extra overhead
of the 64-bit addressing descriptors.

But it is fairly common for hardware to support somewhere between 32 and
64 bits of address range. Tegra124 and Tegra210, for example, support 34
bits and the newer Tegra186 and Tegra194 support 40 bits. The latter can
also use an IOMMU for address translation, which has an input address
range of 48 bits. This causes problems with the current algorithm in the
SDHCI core for choosing the DMA mask. If the DMA mask is set to 64 bits,
the DMA memory allocations can (and usually do because the allocator
starts from the top) end up beyond the 40 bit boundary addressable by
the SDHCI controller, causing IOMMU faults.

For Tegra specifically this problem is currently worked around by
setting the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk. This causes the DMA
mask to always be set to 32 bits and therefore all allocations will fit
within the range addressable by the controller.

This commit reworks the code in sdhci_set_dma_mask() to fix the above
issue. The rationale behind this change is that the SDHCI controller
driver should be the authoritative source of the DMA mask setting. The
SDHCI core has no way of knowing what the individual SDHCI controllers
are capable of. So instead of overriding the DMA mask depending on
whether or not 64-bit addressing mode is used, the DMA mask is only
modified if absolutely necessary. On one hand, if the controller can
only address 32 bits of memory or less, we disable use of 64-bit
addressing mode because it is not needed. On the other hand, we also
want to make sure that if we don't support 64-bit addressing mode, such
as in the case where the BROKEN_64_BIT_DMA quirk is set, we do restrict
the DMA mask to fit the capabilities. The latter is an inconsistency by
the driver, so we warn about it to make sure it will be addressed in the
driver.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7c6c93e85b7e..01f81e96be23 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3499,27 +3499,35 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct device *dev = mmc_dev(mmc);
-	int ret = -EINVAL;
+	u64 dma_mask = dma_get_mask(dev);
+	u64 dma32 = DMA_BIT_MASK(32);
+	int ret = 0;
 
 	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
 		host->flags &= ~SDHCI_USE_64_BIT_DMA;
 
-	/* Try 64-bit mask if hardware is capable  of it */
-	if (host->flags & SDHCI_USE_64_BIT_DMA) {
-		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-		if (ret) {
-			pr_warn("%s: Failed to set 64-bit DMA mask.\n",
-				mmc_hostname(mmc));
-			host->flags &= ~SDHCI_USE_64_BIT_DMA;
-		}
+	/*
+	 * Hardware that can't address more than the 32-bit address range does
+	 * not need to use 64-bit addressing mode, even if it supports it.
+	 */
+	if ((host->flags & SDHCI_USE_64_BIT_DMA) && (dma_mask <= dma32)) {
+		pr_debug("%s: controller needs addresses <= 32-bits\n",
+			mmc_hostname(mmc));
+		host->flags &= ~SDHCI_USE_64_BIT_DMA;
 	}
 
-	/* 32-bit mask as default & fallback */
-	if (ret) {
-		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	/*
+	 * If the hardware doesn't support 64-bit addressing, make sure to
+	 * restrict the DMA mask so we don't get buffers allocated beyond the
+	 * 32-bit boundary.
+	 */
+	if (!(host->flags & SDHCI_USE_64_BIT_DMA) && (dma_mask > dma32)) {
+		WARN(1, "64-bit DMA not supported, DMA mask %llx\n", dma_mask);
+
+		ret = dma_set_mask_and_coherent(dev, dma32);
 		if (ret)
-			pr_warn("%s: Failed to set 32-bit DMA mask.\n",
-				mmc_hostname(mmc));
+			pr_warn("%s: failed to set 32-bit DMA mask: %d\n",
+				mmc_hostname(mmc), ret);
 	}
 
 	return ret;
-- 
2.19.1

