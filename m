Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4715DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5B220652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HzAR1g2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfARNRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:17:20 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60194 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfARNRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:17:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190118131715euoutp017c348c32d3338cde9308f1de0eb3dc99~688G4OVo-1815518155euoutp016
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:17:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190118131715euoutp017c348c32d3338cde9308f1de0eb3dc99~688G4OVo-1815518155euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547817435;
        bh=0b95Ew6mlVQAmCd8W9+6vQaVfV0wIQUbFZyv/QEtiIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzAR1g2qzbD6VeYtja5B5iqREC/Qlyx5xOUPV5WRAf0d2drECThXVB6rqmh7w0muh
         YXn5chkk3jCx6zeTWGIjDQbZKu4UBxXQpxKHUxO+JUGYnaoucueJEpJqQjtIh0ru2j
         sexe3k6O7yy45hKidxVkl4PyTdi/dhQ7Ez4js0fc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190118131714eucas1p1b57b44d860b376c628bac5f1bb5a3f87~688GU7AIU1967419674eucas1p1H;
        Fri, 18 Jan 2019 13:17:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DA.3F.04806.AD1D14C5; Fri, 18
        Jan 2019 13:17:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c~688FlSvLX1555915559eucas1p1s;
        Fri, 18 Jan 2019 13:17:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190118131713eusmtrp163be05bc6cafe69890d30148bb80ab0f~688FQ_p5g1588415884eusmtrp1P;
        Fri, 18 Jan 2019 13:17:13 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-66-5c41d1dab7b9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.0F.04284.9D1D14C5; Fri, 18
        Jan 2019 13:17:13 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190118131712eusmtip154225cdd136edc77330e03f3e1decfa5~688EsiqaJ2065420654eusmtip1Q;
        Fri, 18 Jan 2019 13:17:12 +0000 (GMT)
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
Subject: [PATCH v4 5/5] clk: samsung: exynos5433: add imem clocks
Date:   Fri, 18 Jan 2019 14:16:39 +0100
Message-Id: <20190118131639.17578-6-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118131639.17578-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7q3LjrGGLw+L22xccZ6VovrX56z
        Wsw/co7Vom/ff0aL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8li7ZG77BZLr19ksmjde4Td
        4vCbdlYHXo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj
        ye7fbAU7+StmPt3J2sDYytvFyMkhIWAicXvHNlYQW0hgBaPE5stiXYwcQPYXRolXBV2MXEDm
        Z0aJJxcvsMPU9z+6zgRRv5xR4uacLIgioPqNH94zgiTYBMwlHm0/A1YkIuAm0Td5NhtIEbPA
        emaJjtNbwRLCAo4Sfw91gzWwCKhKHNrfzAJi8wq4SJzeOoMVYpu8xLTVXWD1nAKuEvPWrWCF
        qBGUODnzCVg9M1BN89bZzCALJAQOsUtsOHWdDaLZReLfrwNQg4QlXh3fAvWCjMTpyT0sEHa5
        xO6tz9ghmlsYJeZOXsQEkbCWOHz8IisoLJgFNCXW79KHCDtKPPmzkxkkLCHAJ3HjrSDEDXwS
        k7ZNhwrzSnS0CUFU60rM+38G6gJpia7/66BsD4k50xexT2BUnIXkm1lIvpmFsHcBI/MqRvHU
        0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwFR1+t/xrzsY9/1JOsQowMGoxMP7YptDjBBrYllx
        Ze4hRgkOZiURXq4VjjFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbB
        ZJk4OKUaGLdci0pddf7Hz5bC++X3Atz7HV01toWIppyYvq8p54H2SzNXKZ+/e69sj3/wk+G6
        WRG/zc1zReV2HVUbDmZtZjFh+aSgtiNixrrNc2vfPtUV3/Nv3ia3TK7L24vu+biJtk762hgc
        Lhg0/z//UwcOt+8K13XnzezbU92lUGTFmMldK/O/jWHrcSWW4oxEQy3mouJEAMLQTwJRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7o3LzrGGByaqmCxccZ6VovrX56z
        Wsw/co7Vom/ff0aL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8li7ZG77BZLr19ksmjde4Td
        4vCbdlYHXo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtSs+mKL+0JFUhI7+4xFYp
        2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jye7fbAU7+StmPt3J2sDYytvF
        yMkhIWAi0f/oOlMXIxeHkMBSRolp3X+ZIBLSEo2nV0PZwhJ/rnWxgdhCAp8YJT5+LwCx2QTM
        JR5tPwNWIyLgITFj4mJWkEHMAjuZJZbfbmcBSQgLOEr8PdTNCGKzCKhKHNrfDBbnFXCROL11
        BivEAnmJaau7wAZxCrhKzFu3ghVimYvEhTkdzBD1ghInZz4B62UGqm/eOpt5AqPALCSpWUhS
        CxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG1rZjPzfvYLy0MfgQowAHoxIP74ttDjFC
        rIllxZW5hxglOJiVRHi5VjjGCPGmJFZWpRblxxeV5qQWH2I0BXpiIrOUaHI+MOrzSuINTQ3N
        LSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwFs3kN++233aZL4eppLFAY96e
        sL+XvjPcy5fi+StU1mEUyymtsNPn+lllqU7TwpfTT4Se9IzuDlCp3C48s+RIxWlzzr7PW4/6
        SbYc2XNid9/Waedy9JctNrl3SueOx8Sz5tXTOf0KztidO+Ayh2f6vdy5dpxVKtXJ+h4rg5s7
        LvQqRLgsZVBVYinOSDTUYi4qTgQAtiRlAMICAAA=
X-CMS-MailID: 20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c
References: <20190118131639.17578-1-k.konieczny@partner.samsung.com>
        <CGME20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imem clocks for exynos5433. This will enable to use crypto Slim
Security SubSystem (in short SlimSSS) IP block.

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

