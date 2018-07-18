Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B464ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAA820854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXKulSXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAA820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbeGRUgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbeGRUgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:36:11 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A1720850;
        Wed, 18 Jul 2018 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531943805;
        bh=hJH56G2LGC7k7geWj6N9qc5NDABZN9B4Rh38st595NQ=;
        h=From:To:Subject:Date:From;
        b=oXKulSXZwiGY3/anxjQ7DD/i2Htxu4otu0VyGx7NjoW6BLPuV97o4cLJyYtqTnggq
         /MAEzNhd7MIFwDOmZ2p/d4wBS0/T2+3Mzjr6u6w2LIBzcnZ5y5q8AlUvXOdOE+QiNU
         l8f0bSqQFLfNiwm3vgs+nsIa5aMwTg7oEXreJlOU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: samsung: Remove unused mout_user_aclk400_mcuisp_p4x12 variable
Date:   Wed, 18 Jul 2018 21:56:20 +0200
Message-Id: <20180718195620.5331-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'mout_user_aclk400_mcuisp_p4x12' variable to fix GCC warning:

    drivers/clk/samsung/clk-exynos4412-isp.c:40:27: warning:
        'mout_user_aclk400_mcuisp_p4x12' defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos4412-isp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4412-isp.c b/drivers/clk/samsung/clk-exynos4412-isp.c
index d5f1ccb36300..cfaa057035ad 100644
--- a/drivers/clk/samsung/clk-exynos4412-isp.c
+++ b/drivers/clk/samsung/clk-exynos4412-isp.c
@@ -37,8 +37,6 @@ static const unsigned long exynos4x12_clk_isp_save[] __initconst = {
 	E4X12_GATE_ISP1,
 };
 
-PNAME(mout_user_aclk400_mcuisp_p4x12) = { "fin_pll", "div_aclk400_mcuisp", };
-
 static struct samsung_div_clock exynos4x12_isp_div_clks[] = {
 	DIV(CLK_ISP_DIV_ISP0, "div_isp0", "aclk200", E4X12_DIV_ISP0, 0, 3),
 	DIV(CLK_ISP_DIV_ISP1, "div_isp1", "aclk200", E4X12_DIV_ISP0, 4, 3),
-- 
2.14.1

