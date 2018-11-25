Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBA9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639A520868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639A520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeKZEsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 23:48:07 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:43663 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeKZEsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 23:48:07 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAPHuBvk042393;
        Mon, 26 Nov 2018 02:56:11 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Mon, 26 Nov 2018 02:56:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from localhost.localdomain (199.247.151.153.ap.dti.ne.jp [153.151.247.199])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAPHu6cT042387
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 26 Nov 2018 02:56:10 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] clk: rockchip: add clock gate of ACODEC for rk3328
Date:   Mon, 26 Nov 2018 02:56:03 +0900
Message-Id: <20181125175603.30592-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds small changes into clock gate definition to enable
ACODEC for rk3328.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/rockchip/clk-rk3328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 1eb46aa8b2fa..faa94adb2a37 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -804,7 +804,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	GATE(PCLK_USB3_GRF, "pclk_usb3_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 2, GFLAGS),
 	GATE(PCLK_USB2_GRF, "pclk_usb2_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 14, GFLAGS),
 	GATE(0, "pclk_ddrphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 13, GFLAGS),
-	GATE(0, "pclk_acodecphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 5, GFLAGS),
+	GATE(PCLK_ACODECPHY, "pclk_acodecphy", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(17), 5, GFLAGS),
 	GATE(PCLK_HDMIPHY, "pclk_hdmiphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 7, GFLAGS),
 	GATE(0, "pclk_vdacphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 8, GFLAGS),
 	GATE(0, "pclk_phy_niu", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(15), 15, GFLAGS),
-- 
2.19.1

