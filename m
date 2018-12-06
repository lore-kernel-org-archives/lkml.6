Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DFFC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DB3214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133582;
	bh=/PsWJCtNsXjp9U8RIwZTkBhHyX23fq+fd9OQL+vfoYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P9BGb4awumao+/MZjA3U4j04EHCR49rs/ObwdmevEkcfO7pn9D03dG13xyme9AdAZ
	 lZ+1YvrLY5P6r8U2gIrDAyztV7+sKB6VwtPa0RjPVlztSgZD+9Pu3VfbpyAr4vSOpt
	 80ld2PfVi9UihkY//2wYCi8zAV2yC4y6AczFkmwQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DB3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLFV7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbeLFV7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:59:01 -0500
Received: from mail.kernel.org (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7359C21508;
        Thu,  6 Dec 2018 21:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133540;
        bh=/PsWJCtNsXjp9U8RIwZTkBhHyX23fq+fd9OQL+vfoYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Juqy2DxApRPUyos+1/Gd9Y5dnrqwiRQ/i4dlfndQVTzxk8v+XrCLWHEI5k/ipK0rL
         8mItRu/jv4h9pniEWlUVxPXbOjnZHOvJPxUYkg9z4rvzBXWslehFlPrUF5Ar9u0lyK
         /cUSp0mB1Vedie8Rg1cH5cr5wh1c0E5u/o5ytHAQ=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH 4/8] clk: h8300: Remove usage of CLK_IS_BASIC
Date:   Thu,  6 Dec 2018 13:58:54 -0800
Message-Id: <20181206215858.3880-5-sboyd@kernel.org>
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: <uclinux-h8-devel@lists.sourceforge.jp>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/h8300/clk-h8s2678.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/h8300/clk-h8s2678.c b/drivers/clk/h8300/clk-h8s2678.c
index b68045d8b921..c7ae653c8a16 100644
--- a/drivers/clk/h8300/clk-h8s2678.c
+++ b/drivers/clk/h8300/clk-h8s2678.c
@@ -117,7 +117,7 @@ static void __init h8s2678_pll_clk_setup(struct device_node *node)
 	parent_name = of_clk_get_parent_name(node, 0);
 	init.name = clk_name;
 	init.ops = &pll_ops;
-	init.flags = CLK_IS_BASIC;
+	init.flags = 0;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 	pll_clock->hw.init = &init;
-- 
Sent by a computer through tubes

