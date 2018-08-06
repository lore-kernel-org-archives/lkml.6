Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1710C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EE121A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEq6hV6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EE121A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbeHFSnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeHFSnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:43:40 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E52B621A57;
        Mon,  6 Aug 2018 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533573228;
        bh=DLcKtzh92cscqHdkqVLm8/Uja7KcT2BV7x90eL1IjvI=;
        h=From:To:Subject:Date:From;
        b=HEq6hV6+njKeDrSa+zvERJEWcPDUgLjCm7WiwIFm82tssuHZanogdEwcak42q0L/c
         /9xVO4IxFhSbtEj0aAJW3oNGNVFDq9hb+0LvHQBHer0RjBYqSWuqwSFT4luD624aJy
         MgHFFU/BkVFM2R+4ni0BeGoAaK1Dk+RiAL78tV2E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: samsung: Remove duplicated "wakeup" in printk
Date:   Mon,  6 Aug 2018 18:33:40 +0200
Message-Id: <20180806163340.27276-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Double "wakeup" appears in printed message.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 40ef14956876..f49ea3d92aa1 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -588,7 +588,7 @@ exynos_pinctrl_set_eint_wakeup_mask(struct samsung_pinctrl_drv_data *drvdata,
 
 	pmu_regs = drvdata->retention_ctrl->priv;
 	dev_info(drvdata->dev,
-		 "Setting external wakeup interrupt wakeup mask: 0x%x\n",
+		 "Setting external wakeup interrupt mask: 0x%x\n",
 		 irq_chip->eint_wake_mask_value);
 
 	regmap_write(pmu_regs, irq_chip->eint_wake_mask_reg,
-- 
2.14.1

