Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB40C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CAC21479
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWymFijX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CAC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeKZVrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF3E21104;
        Mon, 26 Nov 2018 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229604;
        bh=YOfImSsbLmBRexOWfLlZCbbCMMsa8IlllcGnue5BPCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWymFijXf4HIEmq6j3Ezp9bCaot0qhGjDoujP0a0kF1oYeqlmzvnnN+vSltdm5xOO
         d8sWQABVqi3Ct1PMzHeqFwVqTGRHAlGFk5M0ub1DDWDtB/5Syj0GrJSDE4XiKA3JUJ
         rbXe1KnV7424eovWqTz8ORNjcZIie4HISj6KjvtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 07/24] clk: samsung: exynos5420: Enable PERIS clocks for suspend
Date:   Mon, 26 Nov 2018 11:51:01 +0100
Message-Id: <20181126105030.812980030@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 848d602efc06..c810b3be6b48 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -273,6 +273,7 @@ static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
 	{ .offset = SRC_MASK_ISP,		.value = 0x11111000, },
 	{ .offset = GATE_BUS_DISP1,		.value = 0xffffffff, },
 	{ .offset = GATE_IP_PERIC,		.value = 0xffffffff, },
+	{ .offset = GATE_IP_PERIS,		.value = 0xffffffff, },
 };
 
 static int exynos5420_clk_suspend(void)
-- 
2.17.1



