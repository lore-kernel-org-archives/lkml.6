Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE82C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0D5223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+pjfoGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0D5223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbeKMPr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732277AbeKMPr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:57 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FBF82251C;
        Tue, 13 Nov 2018 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088289;
        bh=rEW7FOhsjb5KfIVyFm4ZAPHnT612BU0DenklrHKMRwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+pjfoGAUcddffV0Q0bJDh688kcTuvlO5ZXGje+gFRTd+ifklQ2TNXM3HUWJGEmij
         4PARDxopDlG7BwzzDhlL3Hgj1D32Tc62GdIEZTMzsFl6f/x8qFBk8KlzFnconLuvtf
         YwW+pUJmj9V7Kq5u2opUjiasXBz6Wsdox8VAoJy0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 25/39] clk: samsung: exynos5420: Enable PERIS clocks for suspend
Date:   Tue, 13 Nov 2018 00:50:39 -0500
Message-Id: <20181113055053.78352-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit b33228029d842269e17bba591609e83ed422005d ]

Ensure that clocks for core SoC modules (including TZPC0..9 modules)
are enabled for suspend/resume cycle. This fixes suspend/resume
support on Exynos5422-based Odroid XU3/XU4 boards.

Suggested-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <snawrocki@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 95e1bf69449b..d4f77c4eb277 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -281,6 +281,7 @@ static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
 	{ .offset = GATE_BUS_TOP,		.value = 0xffffffff, },
 	{ .offset = GATE_BUS_DISP1,		.value = 0xffffffff, },
 	{ .offset = GATE_IP_PERIC,		.value = 0xffffffff, },
+	{ .offset = GATE_IP_PERIS,		.value = 0xffffffff, },
 };
 
 static int exynos5420_clk_suspend(void)
-- 
2.17.1

