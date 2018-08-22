Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78153C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16340208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkHACjEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16340208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeHVM1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:27:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45138 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeHVM1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:27:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id u83-v6so855973lje.12;
        Wed, 22 Aug 2018 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=pe90KY5CQaYJKUnXzF74fKqsP8Ey1m1Hc5xUHpQ9xg0=;
        b=mkHACjEI2Jl8RGj50mgOL++Ov2JOSHmBTeuWYMY2x3v0uCCK8Q+09B3a1AZvENi0At
         5TxvtQqeAgBVMGlwfOA/kVITgdEaqqRqvLR8/ts+aQfWOOW0l0uUGsqxgrLrZY4MRqby
         B4oub3qGk/H+8/iH2aDCMFQwc2i+d0lH81F79uYB4hph8OSiWdzf+Rqjp0e0wn5Wwvgg
         JHVbcfhS9ih9nvPk79IaKpM2f7RlC0wrXFIFS5+gz117t6Hh79L9y+mU31W9vzw6i4w8
         9N3J8/of0bM/uV64KsjCO45eVJgpjnG9YeWIUp0MA1a/BC/An71YfFy7u07Mnbcy7+tf
         ZFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=pe90KY5CQaYJKUnXzF74fKqsP8Ey1m1Hc5xUHpQ9xg0=;
        b=dQuptJ/OcrJGOe/kVLOxK7aVY1BmzM4GQw1Q2sXqfKFBKhaS7DBjZfG19QkaOvzH9b
         YaON0DNHbxmOoNlq/DZFRmV+KOrSuXQdoPR7z/U7SVuM49X8jmZLM4hotc3Vry2wUWLv
         RnVAUDF4Wdgogxq7G2bgYC3c7wLkMLyGPRnNDDLuBtgYkflTAIj722/Dqi5IzxgsO8S/
         KkXEo50Hca8gzB4zQYSYrUZNOaGPYuFBitNgqPEhZhxO5OCOAuFfWqfcbOlOAWwAzlrJ
         IQbs0PPapnFAE4B7+heFf0dfXi0QfKq1WhBHWBnhEW7Jwugwluapoc0XNZ0xFF+5Hf48
         HbRw==
X-Gm-Message-State: AOUpUlEeMvyNurFqCxRfVcqS4lmgJcp2Pw3D2Tnn9+ZFFtNfh5h3fFbB
        8IXlKHrzbaC/RlekxAI3sq4=
X-Google-Smtp-Source: ANB0VdaRJnHXu59bc0cM06T9BMZaWMQrsYTuEeJcg6ArCCnTnuHm01up0F+l1XXRHdgwQ8CyOKis3w==
X-Received: by 2002:a2e:4089:: with SMTP id r9-v6mr5251021lje.2.1534928612398;
        Wed, 22 Aug 2018 02:03:32 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l25-v6sm209030lfi.94.2018.08.22.02.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:03:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsP37-0007bB-18; Wed, 22 Aug 2018 11:03:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] clk: ti: fix OF child-node lookup
Date:   Wed, 22 Aug 2018 11:03:19 +0200
Message-Id: <20180822090319.29167-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix child-node lookup which by using the wrong OF helper was searching
the whole tree depth-first, something which could end up matching an
unrelated node.

Also fix the related node-reference leaks.

Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clk/ti/clk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 7d22e1af2247..27e0979b3158 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -129,7 +129,7 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
 void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 {
 	struct ti_dt_clk *c;
-	struct device_node *node;
+	struct device_node *node, *parent;
 	struct clk *clk;
 	struct of_phandle_args clkspec;
 	char buf[64];
@@ -164,8 +164,12 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			continue;
 
 		node = of_find_node_by_name(NULL, buf);
-		if (num_args)
-			node = of_find_node_by_name(node, "clk");
+		if (num_args) {
+			parent = node;
+			node = of_get_child_by_name(parent, "clk");
+			of_node_put(parent);
+		}
+
 		clkspec.np = node;
 		clkspec.args_count = num_args;
 		for (i = 0; i < num_args; i++) {
@@ -173,11 +177,12 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			if (ret) {
 				pr_warn("Bad tag in %s at %d: %s\n",
 					c->node_name, i, tags[i]);
+				of_node_put(node);
 				return;
 			}
 		}
 		clk = of_clk_get_from_provider(&clkspec);
-
+		of_node_put(node);
 		if (!IS_ERR(clk)) {
 			c->lk.clk = clk;
 			clkdev_add(&c->lk);
-- 
2.18.0

