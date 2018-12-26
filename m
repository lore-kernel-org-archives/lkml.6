Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14471C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D371F218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPncZjQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeLZN3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:29:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38658 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeLZN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:29:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so7559656plb.5;
        Wed, 26 Dec 2018 05:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cZCqMyU2i0bTE0fJ/dKEPI9v0HFk11WpDVLEPGl7Eyo=;
        b=hPncZjQo3A24KgaRhz/XLt28+TNt5vVk6LDyRjDjMVEhZ94U9JX7069aFnuCITAlVA
         WAiZsRorZ3sseLsf1NVdI8xhwvWjcxrRPmQVdW9Ti58jizdfBN9mbvD6V4dN9k/EUPJG
         OLLBEx83TEgjJSUj8upD8NUfwiakdDJWn8vTCk98aJ8g6WLZXBNQon9yl7GSEysd4cem
         +De3hkIvWjpX5rdDQvA4xBvANOtmFhbQEAArURi3PGYsOD0tWqTZ21jj4TT3w+nNenKl
         ZnKBGZwAlDteDp07Ze3xgf1sTVDuBFpB9TD10jLRYZ1HFD04LZkgHOVDoFX1UJwGn/xX
         XYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cZCqMyU2i0bTE0fJ/dKEPI9v0HFk11WpDVLEPGl7Eyo=;
        b=b1R40t3TyH68jUOV8QiPQ5H6wIPzNGyGJL/9S5j7Gdp84sZllRmnHCnJ/zIG/jZO4/
         PMJkfkatfnfurebccJPm5lcMCP40EP0IZwAPc6kOWlBb8Xy1Fe+YnJtgCvRUZCLg5Y8O
         52Rjq4VC208oblM3ZdXLC/Y2dpxvZ0XlG9pBfYzbzqsRYWGAd9ER4CATLHyTLbD8eRas
         VLE6LzV3lTVwis3ygJulNYvztjzcBWZM3MwCrXS977mkqvDH6JZvM8hjaSxZDN9M1l8F
         8PWwt5LYgA2vYi9p2p6OvEb07Kx5+hGEwAvLNXKL8V/rNuyo5wtqPx0wGvMjIW8Ti+VS
         tbbg==
X-Gm-Message-State: AJcUukf7NV7T85merTJ7ARTdtvmmQOp55f1QfKdPh/I3KC393Gz2FZVD
        lFaUQiHHWnzeV693F4rSX/4=
X-Google-Smtp-Source: ALg8bN4zO0PGpAA+wLXiM0eZ7YGJaalLPgcuS/4MXawTgS2EN/OL+agh4H7GDvSjgw4w26xyNAbRCg==
X-Received: by 2002:a17:902:365:: with SMTP id 92mr18914147pld.327.1545830944597;
        Wed, 26 Dec 2018 05:29:04 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t5sm51109895pfb.60.2018.12.26.05.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:29:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     dinguyen@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: socfpga: fix refcount leak
Date:   Wed, 26 Dec 2018 08:29:02 -0500
Message-Id: <20181226132902.4807-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/socfpga/clk-pll-a10.c | 1 +
 drivers/clk/socfpga/clk-pll.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index 35fabe1a32c3..269467e8e07e 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -95,6 +95,7 @@ static struct clk * __init __socfpga_pll_init(struct device_node *node,
 
 	clkmgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
 	clk_mgr_a10_base_addr = of_iomap(clkmgr_np, 0);
+	of_node_put(clkmgr_np);
 	BUG_ON(!clk_mgr_a10_base_addr);
 	pll_clk->hw.reg = clk_mgr_a10_base_addr + reg;
 
diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index c7f463172e4b..b4b44e9b5901 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -100,6 +100,7 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
 
 	clkmgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
 	clk_mgr_base_addr = of_iomap(clkmgr_np, 0);
+	of_node_put(clkmgr_np);
 	BUG_ON(!clk_mgr_base_addr);
 	pll_clk->hw.reg = clk_mgr_base_addr + reg;
 
-- 
2.17.0

