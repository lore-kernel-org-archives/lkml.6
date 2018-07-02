Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB16C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A9D24104
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A9D24104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeGBNe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:34:59 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:30186 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeGBNem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:34:42 -0400
Received: from localhost.localdomain (10.18.20.250) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Mon, 2 Jul 2018
 21:34:35 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        "Jian Hu" <jian.hu@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] clk: meson-axg: add pcie and mipi clock bindings
Date:   Mon, 2 Jul 2018 21:31:17 +0000
Message-ID: <20180702213118.19222-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702213118.19222-1-yixun.lan@amlogic.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pcie and mipi clock dt-bindings for the pcie driver.

Since the mipi clock isalso used by the pcie driver,
we add it together in this patch.

Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 include/dt-bindings/clock/axg-clkc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
index 555937a25504..70371228b7e0 100644
--- a/include/dt-bindings/clock/axg-clkc.h
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -68,5 +68,8 @@
 #define CLKID_SD_EMMC_B_CLK0			59
 #define CLKID_SD_EMMC_C_CLK0			60
 #define CLKID_HIFI_PLL				69
+#define CLKID_PCIE_CML_EN0			79
+#define CLKID_PCIE_CML_EN1			80
+#define CLKID_MIPI_ENABLE			81
 
 #endif /* __AXG_CLKC_H */
-- 
2.18.0

