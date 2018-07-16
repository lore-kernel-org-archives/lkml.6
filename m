Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6479EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0036D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aSRF+z7A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hXUZ1VZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0036D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeGPGU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:20:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeGPGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:20:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5205B607C6; Mon, 16 Jul 2018 05:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531720486;
        bh=3Ji04Bm9LPhg23mSqvX+wxZGHtHPXq5LZq9uxtQGRGA=;
        h=From:To:Cc:Subject:Date:From;
        b=aSRF+z7AcvgPTRRLH9Zoh79ve58Qo3Fbh+Vw9e1Ycu+EdYSJMRxW3AfhgBonw6bpc
         l3L2PkxUkRirD8RjCCiKkxQ6x9h8we4Mv4kvWkaH3wCVn82lvItE4DE26+paQObXx6
         pEIfEC68s2rmxtz9Ti3/3BBeRHrEjazRDP1UjQ0k=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE66060227;
        Mon, 16 Jul 2018 05:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531720485;
        bh=3Ji04Bm9LPhg23mSqvX+wxZGHtHPXq5LZq9uxtQGRGA=;
        h=From:To:Cc:Subject:Date:From;
        b=hXUZ1VZo0n23UWQfROypSwI7jzd6UFGqPK23N98CCWwdJHcU63D9IW8qd8hyNh6/j
         HKccrqIgdq8kz8EsJKrGW3Z4/hyoa6P/QR6Zf04571AkryG8jfw3kjNxRaS8al2DeO
         h7xuC7jc9QBZsxZv4avfDEmUNqzOwS+fy2v7gBXk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE66060227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: Update SPDX headers for common files
Date:   Mon, 16 Jul 2018 11:24:32 +0530
Message-Id: <1531720472-13093-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX headers updated for common/branch/pll/regmap files.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 10 +---------
 drivers/clk/qcom/clk-alpha-pll.h | 14 ++------------
 drivers/clk/qcom/clk-branch.c    | 10 +---------
 drivers/clk/qcom/clk-branch.h    | 14 ++------------
 drivers/clk/qcom/clk-regmap.c    | 10 +---------
 drivers/clk/qcom/clk-regmap.h    | 14 ++------------
 drivers/clk/qcom/common.c        | 10 +---------
 drivers/clk/qcom/common.h        | 15 +++------------
 8 files changed, 13 insertions(+), 84 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 3c49a60..a91d97c 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */

 #include <linux/kernel.h>
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index f981b48..66755f0 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved. */

 #ifndef __QCOM_CLK_ALPHA_PLL_H__
 #define __QCOM_CLK_ALPHA_PLL_H__
diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index c58c553..bc2205c 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */

 #include <linux/kernel.h>
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 1702efb..b3561e0 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2013, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2013, The Linux Foundation. All rights reserved. */

 #ifndef __QCOM_CLK_BRANCH_H__
 #define __QCOM_CLK_BRANCH_H__
diff --git a/drivers/clk/qcom/clk-regmap.c b/drivers/clk/qcom/clk-regmap.c
index 1c856d3..ce80db2 100644
--- a/drivers/clk/qcom/clk-regmap.c
+++ b/drivers/clk/qcom/clk-regmap.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */

 #include <linux/device.h>
diff --git a/drivers/clk/qcom/clk-regmap.h b/drivers/clk/qcom/clk-regmap.h
index 90d95cd..6cfc1bc 100644
--- a/drivers/clk/qcom/clk-regmap.h
+++ b/drivers/clk/qcom/clk-regmap.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2014, The Linux Foundation. All rights reserved. */

 #ifndef __QCOM_CLK_REGMAP_H__
 #define __QCOM_CLK_REGMAP_H__
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 39ce64c..db9b247 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */

 #include <linux/export.h>
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 00196ee..4aa33ee 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -1,15 +1,6 @@
-/*
- * Copyright (c) 2014, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2014, The Linux Foundation. All rights reserved. */
+
 #ifndef __QCOM_CLK_COMMON_H__
 #define __QCOM_CLK_COMMON_H__

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

