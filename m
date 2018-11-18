Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F637C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24342080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24342080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeKROf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:35:56 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:61083 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeKROf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:35:56 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAI4GL1B079076;
        Sun, 18 Nov 2018 13:16:21 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Sun, 18 Nov 2018 13:16:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from localhost.localdomain (199.247.151.153.ap.dti.ne.jp [153.151.247.199])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAI4GFB2079045
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 18 Nov 2018 13:16:21 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] clk: rockchip: fix I2S1 clock gate register for rk3328
Date:   Sun, 18 Nov 2018 13:16:12 +0900
Message-Id: <20181118041612.2773-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes definition of I2S1 clock gate register for rk3328.
Current setting is not related I2S clocks.
  - bit6 of CRU_CLKGATE_CON0 means clk_ddrmon_en
  - bit6 of CRU_CLKGATE_CON1 means clk_i2s1_en

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/rockchip/clk-rk3328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 2c5426607790..1eb46aa8b2fa 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -392,7 +392,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 			RK3328_CLKGATE_CON(1), 5, GFLAGS,
 			&rk3328_i2s1_fracmux),
 	GATE(SCLK_I2S1, "clk_i2s1", "i2s1_pre", CLK_SET_RATE_PARENT,
-			RK3328_CLKGATE_CON(0), 6, GFLAGS),
+			RK3328_CLKGATE_CON(1), 6, GFLAGS),
 	COMPOSITE_NODIV(SCLK_I2S1_OUT, "i2s1_out", mux_i2s1out_p, 0,
 			RK3328_CLKSEL_CON(8), 12, 1, MFLAGS,
 			RK3328_CLKGATE_CON(1), 7, GFLAGS),
-- 
2.19.1

