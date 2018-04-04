Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754739AbeDDBJf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 21:09:35 -0400
Received: from gateway36.websitewelcome.com ([192.185.199.121]:43937 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754203AbeDDBJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 21:09:34 -0400
Date: Tue, 3 Apr 2018 20:09:31 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] clk: samsung: s3c: Mark expected switch fall-through
Message-ID: <20180404010931.GA30291@embeddedor.com>
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
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3Wvd-003acI-A7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:57914
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case I replaced the comma wiht a dash,
which is what GCC is expecting to find when there are other comments
in the same line in which "fall through" appears.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
This code was compiled with GCC 7.3.0

 drivers/clk/samsung/clk-s3c2443.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index c46e6d5..7ebb87f 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -429,7 +429,7 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 				ARRAY_SIZE(s3c2450_gates));
 		samsung_clk_register_alias(ctx, s3c2450_aliases,
 				ARRAY_SIZE(s3c2450_aliases));
-		/* fall through, as s3c2450 extends the s3c2416 clocks */
+		/* fall through - as s3c2450 extends the s3c2416 clocks */
 	case S3C2416:
 		samsung_clk_register_div(ctx, s3c2416_dividers,
 				ARRAY_SIZE(s3c2416_dividers));
-- 
2.7.4
