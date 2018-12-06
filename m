Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28E7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAC7214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133596;
	bh=/mfoHx2kZTaQp8c5THvg+QbIVA2pPhgvvCcvtuZt20Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oM52qeqoRhZ3RMbCXogZEQNLIZkBCz7Qsn91jpujPdHI5MM32cTolCnBqQ1vpEz02
	 YsRDp0bYpfln98ixY7NvBvTz+lusIJm/iem2DNxEMPLFRAAcSa4DFSSofM17Jpn6b6
	 moMty1q/Ecp3ZzNTdDXTrx/sLyHaRkuy0m8zSwk0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAC7214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLFV7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeLFV7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:59:00 -0500
Received: from mail.kernel.org (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD2B214DB;
        Thu,  6 Dec 2018 21:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133540;
        bh=/mfoHx2kZTaQp8c5THvg+QbIVA2pPhgvvCcvtuZt20Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+cUFUxT6Z3LZ1EHE2mtMsEOA0SwifB9vYqaET1kUAQ61Sxov22A8ZYQLEHlfYdzR
         g3tlF7gMvqkl4TE/D1tbzuSSXtTRiavUzPki0cse6Q3YnSd2YqSRYzt99jowM9BDTO
         phx4YjzlAMJN0AkjfXranRD0KOzLOS7OEp+8dRXM=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/8] clk: st: Remove usage of CLK_IS_BASIC
Date:   Thu,  6 Dec 2018 13:58:52 -0800
Message-Id: <20181206215858.3880-3-sboyd@kernel.org>
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

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/st/clk-flexgen.c | 2 +-
 drivers/clk/st/clkgen-fsyn.c | 4 ++--
 drivers/clk/st/clkgen-pll.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 918ba3164da9..ca8d5350f94e 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -210,7 +210,7 @@ static struct clk *clk_register_flexgen(const char *name,
 
 	init.name = name;
 	init.ops = &flexgen_ops;
-	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE | flexgen_flags;
+	init.flags = CLK_GET_RATE_NOCACHE | flexgen_flags;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index cfa000007622..946ceb14dbf7 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -404,7 +404,7 @@ static struct clk * __init st_clk_register_quadfs_pll(
 
 	init.name = name;
 	init.ops = quadfs->pll_ops;
-	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE;
+	init.flags = CLK_GET_RATE_NOCACHE;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
@@ -843,7 +843,7 @@ static struct clk * __init st_clk_register_quadfs_fsynth(
 
 	init.name = name;
 	init.ops = &st_quadfs_ops;
-	init.flags = flags | CLK_GET_RATE_NOCACHE | CLK_IS_BASIC;
+	init.flags = flags | CLK_GET_RATE_NOCACHE;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 7a7106dc80bf..6930348ce843 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -613,7 +613,7 @@ static struct clk * __init clkgen_pll_register(const char *parent_name,
 	init.name = clk_name;
 	init.ops = pll_data->ops;
 
-	init.flags = pll_flags | CLK_IS_BASIC | CLK_GET_RATE_NOCACHE;
+	init.flags = pll_flags | CLK_GET_RATE_NOCACHE;
 	init.parent_names = &parent_name;
 	init.num_parents  = 1;
 
-- 
Sent by a computer through tubes

