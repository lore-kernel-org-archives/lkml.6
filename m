Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F577C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC722146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy8y2ied"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC722146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeK3Tti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3Tti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:49:38 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC57420863;
        Fri, 30 Nov 2018 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543567264;
        bh=lBfAH6Fdv6pt5aSgWvZeYjgK4PN/vTj7oibEqhT6GZA=;
        h=From:To:Cc:Subject:Date:From;
        b=Qy8y2iedhZeqsToWz+uC5mWVklUSj0QMZgnc7+Ztljrt9yyRuT4tR/URd5NUr28Sr
         f5I04e0ZD5g0c0dNz4YOhFhUj9tc8MU7DmRmugYjqOJXPTXo7Sh1dA8HyMp9Sf+KQQ
         5HrfUe4oYeMlPsWHOFF98oSYCBtwmT7FmPjPVckY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Wenzhen Yu <wenzhen.yu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 1/2] clk: mediatek: Drop __init from mtk_clk_register_cpumuxes()
Date:   Fri, 30 Nov 2018 00:41:02 -0800
Message-Id: <20181130084103.64722-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used from more places than just __init code. Removing
__init silences a section mismatch warning here.

Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Wenzhen Yu <wenzhen.yu@mediatek.com>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-cpumux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 16e56772d280..6c7eaa21e662 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -53,7 +53,7 @@ static const struct clk_ops clk_cpumux_ops = {
 	.set_parent = clk_cpumux_set_parent,
 };
 
-static struct clk __init *
+static struct clk *
 mtk_clk_register_cpumux(const struct mtk_composite *mux,
 			struct regmap *regmap)
 {
@@ -84,9 +84,9 @@ mtk_clk_register_cpumux(const struct mtk_composite *mux,
 	return clk;
 }
 
-int __init mtk_clk_register_cpumuxes(struct device_node *node,
-				     const struct mtk_composite *clks, int num,
-				     struct clk_onecell_data *clk_data)
+int mtk_clk_register_cpumuxes(struct device_node *node,
+			      const struct mtk_composite *clks, int num,
+			      struct clk_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
-- 
Sent by a computer through tubes

