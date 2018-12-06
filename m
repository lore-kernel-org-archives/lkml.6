Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E68DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B0C214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133569;
	bh=HPnvOA30vGDZB+ek1Sia7ED39pHJtjHQRmlE/RoeMuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wmx5zwIYwL1UoeY0GZPn9ceY4vzTsDXTj4F1XmLNg8x+NpeC88BiGNH37QG5Mgjbx
	 iPilHLUXZqu/eiCv4tu2/5ygKaqaSlogCZzFFZidah6uW1KG3sNFU4kyx6Ge3f2Ho+
	 3qqxSWtUJ7sHKndzbJVw4/im7pmfGNup7eBtDeNQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B0C214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLFV7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:59:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeLFV7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:59:01 -0500
Received: from mail.kernel.org (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36F6214DB;
        Thu,  6 Dec 2018 21:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133541;
        bh=HPnvOA30vGDZB+ek1Sia7ED39pHJtjHQRmlE/RoeMuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HP7CoFCclSGTt0LZzxK82bhsTH3D4kaZcFqJacEegKzwMhy/LSfRhrLc2hdYOTGYL
         SKjT8sXUhhjH4i1ZilzMcrI0y0HFcaW2osI6p1tu3fK1LZPmVQ2WoGUq8BHSs1IRlJ
         VKqOg5fAwSiVsNYF6ZDjvIcwsD3gWM5z3m6utfeY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH 5/8] clk: hisilicon: Remove usage of CLK_IS_BASIC
Date:   Thu,  6 Dec 2018 13:58:55 -0800
Message-Id: <20181206215858.3880-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181206215858.3880-1-sboyd@kernel.org>
References: <20181206215858.3880-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag doesn't look to be used by any code, just set in various clk
init structures and then never tested again. Remove it from these
drivers as it doesn't provide any benefit.

Cc: Jiancheng Xue <xuejiancheng@hisilicon.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Jianguo Sun <sunjianguo1@huawei.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3620.c        | 2 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    | 2 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       | 2 +-
 drivers/clk/hisilicon/clkgate-separated.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 77072c7778b9..2eda9bdf6d03 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -435,7 +435,7 @@ static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
 
 	init.name = mmc_clk->name;
 	init.ops = &clk_mmc_ops;
-	init.flags = mmc_clk->flags | CLK_IS_BASIC;
+	init.flags = mmc_clk->flags;
 	init.parent_names = (mmc_clk->parent_name ? &mmc_clk->parent_name : NULL);
 	init.num_parents = (mmc_clk->parent_name ? 1 : 0);
 	mclk->hw.init = &init;
diff --git a/drivers/clk/hisilicon/clk-hisi-phase.c b/drivers/clk/hisilicon/clk-hisi-phase.c
index 5bce9297b78b..5fdc267bb2da 100644
--- a/drivers/clk/hisilicon/clk-hisi-phase.c
+++ b/drivers/clk/hisilicon/clk-hisi-phase.c
@@ -103,7 +103,7 @@ struct clk *clk_register_hisi_phase(struct device *dev,
 
 	init.name = clks->name;
 	init.ops = &clk_phase_ops;
-	init.flags = clks->flags | CLK_IS_BASIC;
+	init.flags = clks->flags;
 	init.parent_names = clks->parent_names ? &clks->parent_names : NULL;
 	init.num_parents = clks->parent_names ? 1 : 0;
 
diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 9584f0c32dda..659bd5f493b8 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -274,7 +274,7 @@ hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
 		else
 			init.ops = &clk_complex_ops;
 
-		init.flags = CLK_IS_BASIC;
+		init.flags = 0;
 		init.parent_names =
 			(clks[i].parent_name ? &clks[i].parent_name : NULL);
 		init.num_parents = (clks[i].parent_name ? 1 : 0);
diff --git a/drivers/clk/hisilicon/clkgate-separated.c b/drivers/clk/hisilicon/clkgate-separated.c
index f36bdef91831..ae84884dc749 100644
--- a/drivers/clk/hisilicon/clkgate-separated.c
+++ b/drivers/clk/hisilicon/clkgate-separated.c
@@ -110,7 +110,7 @@ struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
 
 	init.name = name;
 	init.ops = &clkgate_separated_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = (parent_name ? &parent_name : NULL);
 	init.num_parents = (parent_name ? 1 : 0);
 
-- 
Sent by a computer through tubes

