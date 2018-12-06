Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD7C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDEF214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133577;
	bh=qI+x7KX1LQfHNFIZrqaNQqxTPX0eOjucR8y8glR2iTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aK50YMouShsnbTuaG0bqyTJ1iozZoHurdjxas5zMm6EYfzRd9euQS1sTF+pQGgV/W
	 Jig0lU359tKfjVJuyjSRx/Q1jYsoOyinZRksNHhqhGVClZjDGZStr1Mv7go9tnABI6
	 5ZuPUIrmvfdQNfdHLQ/9t+iBdwHNOSk6NFCa1L1w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDEF214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLFV7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:59:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbeLFV7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:59:00 -0500
Received: from mail.kernel.org (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A28E214DA;
        Thu,  6 Dec 2018 21:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133540;
        bh=qI+x7KX1LQfHNFIZrqaNQqxTPX0eOjucR8y8glR2iTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xKhu1Dzk7cAB8mFw8I0SjHgIB/611KPa9dGODuKpPcHpXwWoJL1ntYzWdNz/kAySl
         nPYrBMf3p0psD/uT++JIr0RbFaLYcEuAd1mVZn+wEWfSycr9to+MClWXX8fIZW61vA
         NsbkumQqeZEI1zqvgADLXzKPrKs8X749w7myR+I4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Anders Berg <anders.berg@lsi.com>
Subject: [PATCH 3/8] clk: axm5516: Remove usage of CLK_IS_BASIC
Date:   Thu,  6 Dec 2018 13:58:53 -0800
Message-Id: <20181206215858.3880-4-sboyd@kernel.org>
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

Cc: Anders Berg <anders.berg@lsi.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-axm5516.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/clk-axm5516.c b/drivers/clk/clk-axm5516.c
index 5d7ae333257e..98e0c9ba7b61 100644
--- a/drivers/clk/clk-axm5516.c
+++ b/drivers/clk/clk-axm5516.c
@@ -311,7 +311,6 @@ static struct axxia_divclk clk_per_div = {
 			"clk_sm1_pll"
 		},
 		.num_parents = 1,
-		.flags = CLK_IS_BASIC,
 		.ops = &axxia_divclk_ops,
 	},
 	.reg   = 0x1000c,
@@ -326,7 +325,6 @@ static struct axxia_divclk clk_mmc_div = {
 			"clk_sm1_pll"
 		},
 		.num_parents = 1,
-		.flags = CLK_IS_BASIC,
 		.ops = &axxia_divclk_ops,
 	},
 	.reg   = 0x1000c,
-- 
Sent by a computer through tubes

