Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9EAC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566BD2070D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeL3TsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:48:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:39976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbeL3TsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:48:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 589BBAE1D;
        Sun, 30 Dec 2018 19:48:14 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Whitten <ben.whitten@gmail.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        linux-clk@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH lora-next] net: lora: sx125x: Clean up clock provider
Date:   Sun, 30 Dec 2018 20:47:59 +0100
Message-Id: <20181230194759.12204-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
References: <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_ variant to have the clock provider deleted again.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx125x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/lora/sx125x.c b/drivers/net/lora/sx125x.c
index 2c48301a12ab..68d8afed48ba 100644
--- a/drivers/net/lora/sx125x.c
+++ b/drivers/net/lora/sx125x.c
@@ -161,7 +161,7 @@ static int sx125x_register_clock_provider(struct sx125x_priv *priv)
 		dev_err(dev, "failed to register clkout\n");
 		return PTR_ERR(priv->clkout);
 	}
-	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get,
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
 			&priv->clkout_hw);
 	return ret;
 }
-- 
2.16.4

