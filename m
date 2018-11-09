Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1919AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D0020892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF274Bpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D0020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeKITbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:31:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeKITbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:31:33 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30C720855;
        Fri,  9 Nov 2018 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541757105;
        bh=1IKjVkwKoT3g7broH+MSlBM9qF+RloeryoopLsLHEPk=;
        h=From:To:Cc:Subject:Date:From;
        b=jF274BppQbiEO79/Rhd/LQ8kHeQMKIN9CED8ra00DkwbXoj+BAi4xmaGWzPZ616Pu
         7APW+q8pWamlGwCivhUo2QM5cpwtPUYamWPe5MWI4zeuRUIRJXafJd4K1IsQ+36jC7
         Wt/Ol5XjN9ct0M2aPWPZpvA7N2zyKn1smaDcp/N4=
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc: Fix board clock node name
Date:   Fri,  9 Nov 2018 15:20:54 +0530
Message-Id: <20181109095054.13924-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree node name are not supposed to have "_" in them so fix the
node name use of xo_board to xo-board

Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller driver for QCS404")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Steve: RobH pointed this on DTS patches, would be great if you can pick this
as a fix

 drivers/clk/qcom/gcc-qcs404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index e4ca6a45f313..ef1b267cb058 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -265,7 +265,7 @@ static struct clk_fixed_factor cxo = {
 	.div = 1,
 	.hw.init = &(struct clk_init_data){
 		.name = "cxo",
-		.parent_names = (const char *[]){ "xo_board" },
+		.parent_names = (const char *[]){ "xo-board" },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
 	},
-- 
2.14.4

