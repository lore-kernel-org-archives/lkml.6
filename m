Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7E8C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B43217BD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B43217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeHECYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:24:53 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.182]:15300 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbeHECYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:24:53 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 8206519C213
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 19:22:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m6oRfPooZSjJAm6oRf9R7n; Sat, 04 Aug 2018 19:22:23 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=35036 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fm6oQ-003dNy-Sj; Sat, 04 Aug 2018 19:22:22 -0500
Date:   Sat, 4 Aug 2018 19:22:22 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] clk: qcom: clk-branch: Use true and false for boolean values
Message-ID: <20180805002222.GA24789@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1fm6oQ-003dNy-Sj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:35036
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 33
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/clk/qcom/clk-branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index bc2205c..99446bf 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -18,7 +18,7 @@ static bool clk_branch_in_hwcg_mode(const struct clk_branch *br)
 	u32 val;
 
 	if (!br->hwcg_reg)
-		return 0;
+		return false;
 
 	regmap_read(br->clkr.regmap, br->hwcg_reg, &val);
 
-- 
2.7.4

