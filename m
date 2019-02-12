Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0872080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfBLNwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:52:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12116 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729952AbfBLNwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:52:14 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CDprZZ013420;
        Tue, 12 Feb 2019 14:52:02 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qhv0m1749-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Feb 2019 14:52:02 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 07FEC34;
        Tue, 12 Feb 2019 13:52:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5860512A;
        Tue, 12 Feb 2019 13:52:01 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 12 Feb 2019 14:52:01
 +0100
From:   <gabriel.fernandez@st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH 1/7] clk: stm32mp1: parent clocks update
Date:   Tue, 12 Feb 2019 14:51:48 +0100
Message-ID: <20190212135154.2733-2-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190212135154.2733-1-gabriel.fernandez@st.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch updates parent clocks for axi, fdcan, sai and adc12.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 6a31f7f434ce..be2ed35977ca 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -121,7 +121,7 @@ static const char * const cpu_src[] = {
 };
 
 static const char * const axi_src[] = {
-	"ck_hsi", "ck_hse", "pll2_p", "pll3_p"
+	"ck_hsi", "ck_hse", "pll2_p"
 };
 
 static const char * const per_src[] = {
@@ -225,19 +225,19 @@ static const char * const usart6_src[] = {
 };
 
 static const char * const fdcan_src[] = {
-	"ck_hse", "pll3_q", "pll4_q"
+	"ck_hse", "pll3_q", "pll4_q", "pll4_r"
 };
 
 static const char * const sai_src[] = {
-	"pll4_q", "pll3_q", "i2s_ckin", "ck_per"
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "pll3_r"
 };
 
 static const char * const sai2_src[] = {
-	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb"
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb", "pll3_r"
 };
 
 static const char * const adc12_src[] = {
-	"pll4_q", "ck_per"
+	"pll4_r", "ck_per", "pll3_q"
 };
 
 static const char * const dsi_src[] = {
-- 
2.17.0

