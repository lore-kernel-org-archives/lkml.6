Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2368C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF5022524
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C15DC3hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF5022524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbeKMPtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733072AbeKMPtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:49:17 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E5F2251F;
        Tue, 13 Nov 2018 05:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088369;
        bh=DLPe9Dy06+31l9Qrtr4FZwSQyGyZG538zVS3pIPqCS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C15DC3hrruizEAQh9T7y2KIuge/+lfUFZ/usQJXB5NpU4D8xw8MUfqUObjcbuNGdS
         tmUIJd3eqtGr+XwM9UduPIe0k70hznXa4wEIYWtDhJ7myv6dVZC4cIvgNebAGTDwvx
         b3zhyWUXtQLDFfT4R95G+moFWhbA6HVxwhE2vX5o=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 07/11] clk: samsung: exynos5420: Enable PERIS clocks for suspend
Date:   Tue, 13 Nov 2018 00:52:38 -0500
Message-Id: <20181113055242.79261-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055242.79261-1-sashal@kernel.org>
References: <20181113055242.79261-1-sashal@kernel.org>
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
index 389af3c15ec4..bde71b07f15e 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -273,6 +273,7 @@ static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
 	{ .offset = GATE_BUS_TOP,		.value = 0xffffffff, },
 	{ .offset = GATE_BUS_DISP1,		.value = 0xffffffff, },
 	{ .offset = GATE_IP_PERIC,		.value = 0xffffffff, },
+	{ .offset = GATE_IP_PERIS,		.value = 0xffffffff, },
 };
 
 static int exynos5420_clk_suspend(void)
-- 
2.17.1

