Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EDBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4401B214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133549;
	bh=FOODpTya/Nv3a1+GmllTtk5Na2vE8twE7PHI564SuQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aMX6vokfZGH3vfiHmWg2/MavG2YKxtV3b6jxDGtNfjDe90/AdmlWG9ClPq+uYWdiV
	 7RpL6l/je+h+xf29ySca3dzMAEXCge7Gsy6kEb2hoJLRbvXwsH21U5Yqtlvccbz7CM
	 YcEfB3WxV5+O0BCR1ECxHFMZjID/LBtDFbCVGjNQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4401B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLFV7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLFV7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:59:02 -0500
Received: from mail.kernel.org (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4D0215E5;
        Thu,  6 Dec 2018 21:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133541;
        bh=FOODpTya/Nv3a1+GmllTtk5Na2vE8twE7PHI564SuQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvDS2OjSsIL29J8n5Lhhtm+4OHQpCGKAvyAYXrKPLTC9sdHfsPj4msixAHI87IMdO
         ERy6tEXOgmJsjH5WjREb+I9dfsHSctWdPopppTx35nniOBnyB6kBCdZZWjP5dVArAV
         5qq74eTMa8pjS6WP78VBUrVBAgyixhPbIGnwnXfg=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 8/8] clk: Loongson1: Remove usage of CLK_IS_BASIC
Date:   Thu,  6 Dec 2018 13:58:58 -0800
Message-Id: <20181206215858.3880-9-sboyd@kernel.org>
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
structure and then never tested again. Remove it from this driver as it
doesn't provide any benefit. Also remove parenthesis nearby that are not
needed and include clk.h to fix a sparse warning about static function
definition.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/loongson1/clk.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/loongson1/clk.c b/drivers/clk/loongson1/clk.c
index cfcfd143fccb..983ce9f6edbb 100644
--- a/drivers/clk/loongson1/clk.c
+++ b/drivers/clk/loongson1/clk.c
@@ -10,6 +10,8 @@
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 
+#include "clk.h"
+
 struct clk_hw *__init clk_hw_register_pll(struct device *dev,
 					  const char *name,
 					  const char *parent_name,
@@ -27,9 +29,9 @@ struct clk_hw *__init clk_hw_register_pll(struct device *dev,
 
 	init.name = name;
 	init.ops = ops;
-	init.flags = flags | CLK_IS_BASIC;
-	init.parent_names = (parent_name ? &parent_name : NULL);
-	init.num_parents = (parent_name ? 1 : 0);
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
 	hw->init = &init;
 
 	/* register the clock */
-- 
Sent by a computer through tubes

