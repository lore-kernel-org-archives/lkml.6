Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC6C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CF3218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW+f4zbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeLZNkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:40:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44182 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeLZNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:40:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so7581035pgr.11;
        Wed, 26 Dec 2018 05:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QtyU9ucOXiNiIeNjszvbCZO0uYJnsnaAu1XagrwM4a4=;
        b=RW+f4zbdKKTuxJb4z6c1EDSpjskuMP/fNlnRX8H0lPCGS09WK8g1S/5q1lkgbYlXgJ
         gYDFoKo+QcwZ474oDMbKvMImNpA3Cg8x248l533QbF5BCmk7TUEGgaAagWhlATtcWJUt
         Y+3++rVbKQfi2vXxX/NH4ZUhIgc5vdaynkTWdEA5+XumZOahGlWnzZZ4ML5LVS6tx0b8
         wk1hRieDocohC6BrlFr9fJ+73pqRlo64D+gNEg/YQ11h1889yGqgfVKJKPXeRBIPNy1V
         Cym5Ob8vIyHwhZFQoOk20kCQOs/5ZAY/0DD8E/glX6wqOzcxDkhwcYo/d7eQsn4HjtCh
         qQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QtyU9ucOXiNiIeNjszvbCZO0uYJnsnaAu1XagrwM4a4=;
        b=hy92azVEW8LngkRFiF+jq8MG4lQZQ304d07txZ0UnrN06P2HW7XH1pecTuaof8JPKa
         vHXSUa72UUOAHv4GjEOJ70q1vh4LB+nAbpnjhnrSQY28aJy8UR8aihFpC40ikmmJJelZ
         cKmfb2INsqaHeN1NETtMkh2qYhbY2P9f8zBi9paIpbiuNfUYyTHlqstATiEvkxT34CQE
         Gsm8CAnxnwtxw6/6MYL6ujsmNvJ98MRt3a+z/CMhbzQKH5bjdkUv5F0DBXY5yUcxlueA
         51IKu/+8Qx2DcqP5gi9qQcVdePJo4zxsJ+u0vqxHOs+mIt+Fwr0P1WsdHKH9m50tTxw0
         HZ7A==
X-Gm-Message-State: AA+aEWYxNXCf8406WN1OJg//8oPuWFqgsMHPN8lIiHlhnERVxs9v2Jhp
        12wlyOxKDW/kLvhItd4vnPY=
X-Google-Smtp-Source: AFSGD/XFYspa/xUzEj5NeV3vcANlLDULhSBVjr9/Sdj/Aly7jSPCdjhuX2Px4rAkrkE/X7S4avlsVA==
X-Received: by 2002:a62:60c5:: with SMTP id u188mr20299330pfb.4.1545831623121;
        Wed, 26 Dec 2018 05:40:23 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e128sm49365293pfe.67.2018.12.26.05.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:40:22 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: kirkwood: fix refcount leak in kirkwood_clk_init()
Date:   Wed, 26 Dec 2018 08:40:19 -0500
Message-Id: <20181226134019.5229-1-tiny.windzz@gmail.com>
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
 drivers/clk/mvebu/kirkwood.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index 6f784167bda4..35af3aa18f1c 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -331,6 +331,8 @@ static void __init kirkwood_clk_init(struct device_node *np)
 	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, kirkwood_gating_desc);
 		kirkwood_clk_muxing_setup(cgnp, kirkwood_mux_desc);
+
+		of_node_put(cgnp);
 	}
 }
 CLK_OF_DECLARE(kirkwood_clk, "marvell,kirkwood-core-clock",
-- 
2.17.0

