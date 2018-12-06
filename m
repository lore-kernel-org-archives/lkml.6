Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD76FC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D00F214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133556;
	bh=4cPuc37tFbT0nyIr47SeItG2csFFwfoPQ/arO18N7iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bg8A3V57tB+bVfgORQIUGRE/mdCGuaFZylcTUSg4jgyIVxY7VITNMs5uOntttwIPG
	 VZ0tPWkWIFRxo8Bo7KaYmhW8Mg0+ppaazG8RrSIeK/vzpH6co3WOwis19rfy//SAnc
	 /PBhUK5KIUZc91rkClYfrgkXtn2mCEUjpfu611Kw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D00F214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLFV7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbeLFV7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:59:02 -0500
Received: from mail.kernel.org (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751AC214DE;
        Thu,  6 Dec 2018 21:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133541;
        bh=4cPuc37tFbT0nyIr47SeItG2csFFwfoPQ/arO18N7iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1VEatuIcpiiUqmrg9FAr+oKoOeopZPDOWBE8DrZ9i4BZ3+0FGwcaZ0AgQ47gdRns
         VtBCU3achSHik0xEUUMUXCRxUBCcraDC2SaYqukmHE2JSEMncqi4AaA+3K0c0BXRHE
         7gb2Q/0JBtxfqQ56EMx94MpcTZz276GKrsE2F+YA=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 7/8] clk: samsung: s3c2410: Remove usage of CLK_IS_BASIC
Date:   Thu,  6 Dec 2018 13:58:57 -0800
Message-Id: <20181206215858.3880-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181206215858.3880-1-sboyd@kernel.org>
References: <20181206215858.3880-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag doesn't look to be used by any code, just set in the clk init
structure and then never tested again. Remove it from this drivers as it
doesn't provide any benefit.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/samsung/clk-s3c2410-dclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 0d92f3e5e3d9..82f8ae22fd34 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -105,7 +105,7 @@ static struct clk_hw *s3c24xx_register_clkout(struct device *dev,
 
 	init.name = name;
 	init.ops = &s3c24xx_clkout_ops;
-	init.flags = CLK_IS_BASIC;
+	init.flags = 0;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
-- 
Sent by a computer through tubes

