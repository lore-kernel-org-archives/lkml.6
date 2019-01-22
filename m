Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C34C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE80420854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lK+xZFFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfAVJC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:02:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51446 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfAVJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:02:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190122090253euoutp022a846ff394b66d2a5bdc2e367117f013~8IDKwphBi0949709497euoutp024
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 09:02:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190122090253euoutp022a846ff394b66d2a5bdc2e367117f013~8IDKwphBi0949709497euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548147774;
        bh=Q/4f3YtlujODsfOS+QnEIqs7vj836/eeMsIngMZkX1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lK+xZFFXNjnQStJC/3L/fmlDI3YHhvjItko0UNOAEwN9bjICYS2xs90H5XG3DGZUw
         Mp+82K8LI1yRnuYPUO8DpGO90eKLKTnZ2qDDPYeEIcqVMc8h+KZIrI/DM1i8XnXaO0
         cAo+nA1oG28iFtkbhD+NXoePmm2lJ0AbkkdT6svY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190122090253eucas1p27c9be6de97a0a1ee4b8ed944678cbaad~8IDJ82nuR2904029040eucas1p2e;
        Tue, 22 Jan 2019 09:02:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 65.ED.04294.C3CD64C5; Tue, 22
        Jan 2019 09:02:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d~8IDJOaAOw1350713507eucas1p2T;
        Tue, 22 Jan 2019 09:02:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190122090252eusmtrp1b52380bf1136b25cbb38e913215fedb1~8IDI-U-g92574925749eusmtrp1g;
        Tue, 22 Jan 2019 09:02:52 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-60-5c46dc3c16b2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.E2.04284.B3CD64C5; Tue, 22
        Jan 2019 09:02:52 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190122090251eusmtip19fe2a3964cc9720884d063daa9d556d5~8IDIYsknD2863128631eusmtip1v;
        Tue, 22 Jan 2019 09:02:51 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
To:     k.konieczny@partner.samsung.com, linux-samsung-soc@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 5/5] clk: samsung: exynos5433: add imem clocks
Date:   Tue, 22 Jan 2019 10:02:32 +0100
Message-Id: <20190122090232.29194-6-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190122090232.29194-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87o2d9xiDFY9NbHYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gt9j0+BqrxeVdc9gsZpzfx2Sx9shddoul1y8yWbTuPcJu
        cfhNO6sDr8eaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXx
        5/Zq5oKX/BVL3z1hbmDcwNvFyMkhIWAi8bX5MHsXIxeHkMAKRonVz5qhnC+MEk9O3GWFcD4z
        SnzefZQJpqXxWxcjiC0ksJxRYs3LaAgbqGP22gQQm03AXOLR9jNg9SICbhJ9k2ezgQxiFljP
        LNFxeitYQljAUWLl3nfMIDaLgKrEo/33wWxeAReJebM3s0Msk5eYtroLrJ5TwFVi1qsdbBA1
        ghInZz5hAbGZgWqat85mBlkgIbCPXeLbqm9sEM0uEmfXbIWyhSVeHd8CNVRG4vTkHhYIu1xi
        99Zn7BDNLYwScycvgnrTWuLw8YtA/3MAbdCUWL9LHyLsKPHh3EMWkLCEAJ/EjbeCEDfwSUza
        Np0ZIswr0dEmBFGtKzHv/xlWCFtaouv/OijbQ2L2wd/MExgVZyH5ZhaSb2Yh7F3AyLyKUTy1
        tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMF2d/nf8yw7GXX+SDjEKcDAq8fAmXHCNEWJNLCuu
        zD3EKMHBrCTC63rRLUaINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKY
        LBMHp1QD42QTbY27p36tbOY9lcEuKdbEEXgm1TVw7+ScJS7VZcEXi7wOq/4p9PIKYF7b/2nv
        1MirU07c7zv65KOE5O5Lt43NV4u9m//LUzeuLvDHjrUSy28u6jRZtYzl9rGCY7HZMY//Pa21
        Fg75U2J/PFGi2dZhubejvq6vwb6EiOy02fNjPmZWfKs4oMRSnJFoqMVcVJwIABgGTidTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7o2d9xiDBo9LDbOWM9qcf3Lc1aL
        +UfOsVr07fvPaNH/+DWzxfnzG9gtNj2+xmpxedccNosZ5/cxWaw9cpfdYun1i0wWrXuPsFsc
        ftPO6sDrsWbeGkaPTas62Tw2L6n3OPhuD5NH35ZVjB6fN8kFsEXp2RTll5akKmTkF5fYKkUb
        WhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfy5vZq54CV/xdJ3T5gbGDfwdjFy
        ckgImEg0futi7GLk4hASWMoosfTADjaIhLRE4+nVTBC2sMSfa11sEEWfGCWmfNrMApJgEzCX
        eLT9DFiRiICHxIyJi1lBipgFdjJLLL/dDlYkLOAosXLvO2YQm0VAVeLR/vtgNq+Ai8S82ZvZ
        ITbIS0xb3QU2iFPAVWLWK4grhIBqrnZeZoWoF5Q4OfMJ2ExmoPrmrbOZJzAKzEKSmoUktYCR
        aRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgZG079nPzDsZLG4MPMQpwMCrx8HKcc40RYk0s
        K67MPcQowcGsJMLretEtRog3JbGyKrUoP76oNCe1+BCjKdATE5mlRJPzgVGfVxJvaGpobmFp
        aG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qB0fbDnckszjMaWk3iz0QGtUvkZPtJ
        dPq06ZZ+PJZpaMxWYLftoXLcst0ee14f2e2sl5v1UHaPbap2aAzDf7/D7fe2GkwQffyXbyb3
        9h9nPS5L6LWaFa/86+F8JLKwuKzIb3bQBxsVw5VlnQlz106bvWv5fo+NE+WC50Wz+grWXpiR
        I7bpsm6PEktxRqKhFnNRcSIA6M0mUsICAAA=
X-CMS-MailID: 20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d
References: <20190122090232.29194-1-k.konieczny@partner.samsung.com>
        <CGME20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imem clocks for exynos5433. This will enable to use crypto Slim
Security SubSystem (in short SlimSSS) IP block.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 24c3360db65b..dae1c96de933 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -5467,6 +5467,35 @@ static const struct samsung_cmu_info cam1_cmu_info __initconst = {
 	.clk_name		= "aclk_cam1_400",
 };
 
+/*
+ * Register offset definitions for CMU_IMEM
+ */
+#define ENABLE_ACLK_IMEM_SLIMSSS		0x080c
+#define ENABLE_PCLK_IMEM_SLIMSSS		0x0908
+
+static const unsigned long imem_clk_regs[] __initconst = {
+	ENABLE_ACLK_IMEM_SLIMSSS,
+	ENABLE_PCLK_IMEM_SLIMSSS,
+};
+
+static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
+	/* ENABLE_ACLK_IMEM_SLIMSSS */
+	GATE(CLK_ACLK_SLIMSSS, "aclk_slimsss", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_PCLK_IMEM_SLIMSSS */
+	GATE(CLK_PCLK_SLIMSSS, "pclk_slimsss", "aclk_imem_200",
+			ENABLE_PCLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info imem_cmu_info __initconst = {
+	.gate_clks		= imem_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(imem_gate_clks),
+	.nr_clk_ids		= IMEM_NR_CLK,
+	.clk_regs		= imem_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(imem_clk_regs),
+	.clk_name		= "aclk_imem_200",
+};
 
 struct exynos5433_cmu_data {
 	struct samsung_clk_reg_dump *clk_save;
@@ -5654,6 +5683,9 @@ static const struct of_device_id exynos5433_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos5433-cmu-mscl",
 		.data = &mscl_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-imem",
+		.data = &imem_cmu_info,
 	}, {
 	},
 };
-- 
2.20.0

