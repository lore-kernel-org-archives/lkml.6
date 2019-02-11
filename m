Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AE121B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbfBKSjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:39:51 -0500
Received: from gateway30.websitewelcome.com ([192.185.147.85]:41885 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbfBKSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:39:51 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 433733A399
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:15:34 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tG7CgNHmy2PzOtG7CgsJl8; Mon, 11 Feb 2019 12:15:34 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=41332 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtG7A-001yty-PL; Mon, 11 Feb 2019 12:15:33 -0600
Date:   Mon, 11 Feb 2019 12:15:31 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
Message-ID: <20190211181531.GA3238@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gtG7A-001yty-PL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:41332
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/clk/samsung/clk-s3c2443.c: In function ‘s3c2443_common_clk_init’:
drivers/clk/samsung/clk-s3c2443.c:390:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   samsung_clk_register_alias(ctx, s3c2450_aliases,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     ARRAY_SIZE(s3c2450_aliases));
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/samsung/clk-s3c2443.c:393:2: note: here
  case S3C2416:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case,  the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/clk/samsung/clk-s3c2443.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index 884067e4f1a1..f38f0e24e3b6 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -389,7 +389,7 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 				ARRAY_SIZE(s3c2450_gates));
 		samsung_clk_register_alias(ctx, s3c2450_aliases,
 				ARRAY_SIZE(s3c2450_aliases));
-		/* fall through, as s3c2450 extends the s3c2416 clocks */
+		/* fall through - as s3c2450 extends the s3c2416 clocks */
 	case S3C2416:
 		samsung_clk_register_div(ctx, s3c2416_dividers,
 				ARRAY_SIZE(s3c2416_dividers));
-- 
2.20.1

