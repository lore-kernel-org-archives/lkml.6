Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4172AECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F3A21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPSF0Mmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F3A21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbeIUQAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:00:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36345 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeIUQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:00:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so12304845wrt.3;
        Fri, 21 Sep 2018 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLAI+OxEpstiwUMaI0E8e9GJi/FAzAwPqs7evmpnfYs=;
        b=mPSF0MmiCUkvRERl0/2NE+IU+kGMnWxhvkBDkQCbLBpgZBY9GVnJoXUiIRGoHPJggI
         A75rwgXP8ILd8QDxL0pCdtlaKKnESK6RaUk2W0Dya30eJYayxPzZPtmtN+OH1yk3+v/9
         lDQBTtEIWNxq4eqjM8TdIojMbfrfQ+iZ7IPMp8299NyAH0YsYspUpvVOXUhH5PJdzeLZ
         Ylz14I8oU02oWwSaw7MmfaVEToRfixM2hn2dPu2TS/3pHGaDpAPRPBUDCtoiWbAAs0U7
         hqnJpf+vcr5KwZdvb0rlvRMRLmyaIrAwEsFTbp4I83/Eu1c6+NdIU/PyBNsLPgcK0fJB
         CYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLAI+OxEpstiwUMaI0E8e9GJi/FAzAwPqs7evmpnfYs=;
        b=WsM55/2vxahQ/etK0PqUp6EPgBGN2Eyfh4cg029T8zolrwC/x2n1DDbSzmt2K/23zu
         Xhf45yuA3PtkIONfhPbPweNNaS4265FnuBS1OL9xfMAEo7SJSuVauLpE0U45OU9cyc9P
         jOAdKaHH0ofauzfQ6EJwWHk21Fb+f83ImGcY5W8LRHLtTioibtbO/vWskiqCdtG0Eea1
         n4NO0/AjDZxTYcghlFsJzKBBsNjMlaVH2rNZNv1+fy2ApO5KQV6CG+39BEXzaAZb+9+H
         3toh+4nPXs1VenkTFlZmlVmEW2qD6zZnBxGTlZafl+jrlXI25e8y2wojYXZK9qI7mOWL
         Iw9Q==
X-Gm-Message-State: APzg51BCPHAhzdN7Pi1NHiZ+9s4XDF0lQtiTJGxVVtS4HRDliocGvJUN
        AYtQQZ6KF4UqDdZ3vpzkEZY=
X-Google-Smtp-Source: ANB0VdZW2VJuaFwzsUdIex6zz5aUhGSKxtGPZlPxm7hDd/sJUfc5kexfKfUtpnAvFQhZGpJBFPpRRA==
X-Received: by 2002:a5d:4cc8:: with SMTP id c8-v6mr39055587wrt.210.1537524730466;
        Fri, 21 Sep 2018 03:12:10 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id a1-v6sm822688wrt.9.2018.09.21.03.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:12:10 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, linux-rtc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: tegra: Propagate errors from platform_get_irq()
Date:   Fri, 21 Sep 2018 12:12:09 +0200
Message-Id: <20180921101209.11895-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Instead of confusingly returning -EBUSY on failure to obtain an
interrupt, propagate the real error code. While at it, let the user know
why the interrupt could not be acquired.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/rtc/rtc-tegra.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 8dc48fe7fc35..c9e77a83cd1b 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -322,9 +322,13 @@ static int __init tegra_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->rtc_base))
 		return PTR_ERR(info->rtc_base);
 
-	info->tegra_rtc_irq = platform_get_irq(pdev, 0);
-	if (info->tegra_rtc_irq <= 0)
-		return -EBUSY;
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
+		dev_err(&pdev->dev, "failed to get platform IRQ: %d\n", ret);
+		return ret;
+	}
+
+	info->tegra_rtc_irq = ret;
 
 	info->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk))
-- 
2.19.0

