Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A200C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E795A20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqchyGy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E795A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388850AbeKFX72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:59:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39135 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388284AbeKFX72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:59:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so5896269pgv.6;
        Tue, 06 Nov 2018 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yer/Du/1VUiCviJYqajeeC5X6xv8Jq2VH6srI+DyCMs=;
        b=AqchyGy6ZOuxRSjaxvcM/Pj8cC2OvvDDwQCQKMYmwkdkGYUnA/ST9K2+XBjYJ7Ktdx
         3+m+anW6D5yeOQAMeeOhTes77tMQZyzL2FykxwRmNaOqlWWRriglB9By0Xw57xBjMutf
         sCb5SU61OCDqh0bpm49cKNifuYTAY8ZxzwxCv+uyVrYcw5X0MIO+VXvrf4j1gYorgfrS
         lNGtpoucTI4FatENZGEDcDRxTpQBO0iT/3BEXgoJjLEA0rD/Cc5M5lPZjj/jLmGuNMxX
         jui48aQ7B4m11hkqJwsZSxC1BRYM85HPdEd3IIopNDi6jStsarTb86+mEyJGzbGyB+XB
         2cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yer/Du/1VUiCviJYqajeeC5X6xv8Jq2VH6srI+DyCMs=;
        b=QONuqPHfHrap9VDHLc74V3b5okB4D3VtwR2/2hf3178IRwuN8kOIA5qCuzGevVqHwx
         46zpoEdG58jEMTjlRFAB4fKcPFPbP8mXkIzRteZbCS2N32GrTOa8Ybv6HGjPwgnCRJ0y
         t9P6outgZlQK9YVmGtXMRhC8ctRR5RhEdfNaj7/bMas97sSwgCPjarlenPkkv5xlRVFR
         jRVpi8f+kZkWjMEKFCH8gx5J+u9tK2HzTijCkw7tauydUOcglELnep6qV2UrBYy245Bt
         jRhRSl5UBEuKZTgmcI101ZMcwbFxsUSF/GpZWWx0OJCG8N36fTLFqOi4gN/imAbv1uDZ
         35dg==
X-Gm-Message-State: AGRZ1gI/uNaq4sDWiBM8f5vMC42azKJgrBFJf9LYU05EjPU+QnEIdk65
        b70Y4iNKjT/sqWWSU0RiUnaofo073cM=
X-Google-Smtp-Source: AJdET5e0TodW479xtgQ1UzuG7xceYJb6vT5esRGFnfnl+sYx3WbBSn9gkP5hHQdob20v6R/UQXgS8g==
X-Received: by 2002:a62:a218:: with SMTP id m24-v6mr25799492pff.99.1541514838296;
        Tue, 06 Nov 2018 06:33:58 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h25-v6sm46545194pgv.27.2018.11.06.06.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:33:57 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     paul@pwsan.com, aaro.koskinen@iki.fi, tony@atomide.com,
        linux@armlinux.org.uk
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ARM: OMAP1: clock: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  6 Nov 2018 09:33:55 -0500
Message-Id: <20181106143355.8340-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/mach-omap1/clock.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index fa512413a471..c8c6fe88b2d6 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -968,7 +968,7 @@ late_initcall(omap_clk_enable_autoidle_all);
 
 static struct dentry *clk_debugfs_root;
 
-static int clk_dbg_show_summary(struct seq_file *s, void *unused)
+static int debug_clock_show(struct seq_file *s, void *unused)
 {
 	struct clk *c;
 	struct clk *pa;
@@ -988,17 +988,7 @@ static int clk_dbg_show_summary(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int clk_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, clk_dbg_show_summary, inode->i_private);
-}
-
-static const struct file_operations debug_clock_fops = {
-	.open           = clk_dbg_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debug_clock);
 
 static int clk_debugfs_register_one(struct clk *c)
 {
-- 
2.17.0

