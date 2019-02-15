Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0240CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200021927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198102;
	bh=8XUIlxSKIMBLJ1bbS2b+As4HwqZ1o/xAH4Ka+YOHEdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=poqo1VdpQKCOqN71IVoLYOgHAIGMpIpp+FJ11UGJwWjPOhICIh+BBMGwn7IMz4w8Q
	 5pddJ/k5UhzJDKYkeR64feWa+1M6z1toPdBFePGcAjQdAsGnooQJft0ZFmj6Xjc+vz
	 cFLI4FRqzHEU0VE6WGtutTYi/zJUIr2orjMnfP+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfBOCfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390805AbfBOCLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086B3206BA;
        Fri, 15 Feb 2019 02:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196691;
        bh=8XUIlxSKIMBLJ1bbS2b+As4HwqZ1o/xAH4Ka+YOHEdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXF3hZ+R9B8wqgMCQjWzgR3GxIYz7pXncNlR0wOXYAART8WRdMDSaNRTbMbDKj1IO
         kqJ3ijeC+UBpDtWJ1oEd7dUsEpJHyD2WRPX4r4m3U6ib27jx3XBg5Ls2YHD8BnFMOU
         KiK13N4ziMWzjg4zXN85QlivQi1sUlwfvXH+SOM8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/65] clk: sysfs: fix invalid JSON in clk_dump
Date:   Thu, 14 Feb 2019 21:10:22 -0500
Message-Id: <20190215021121.177674-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit c6e909972ef87aa2a479269f46b84126f99ec6db ]

Add a missing comma so that the output is valid JSON format again.

Fixes: 9fba738a53dd ("clk: add duty cycle support")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055ae6ec6..5413ffaf02e2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2687,7 +2687,7 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 	seq_printf(s, "\"protect_count\": %d,", c->protect_count);
 	seq_printf(s, "\"rate\": %lu,", clk_core_get_rate(c));
 	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
-	seq_printf(s, "\"phase\": %d", clk_core_get_phase(c));
+	seq_printf(s, "\"phase\": %d,", clk_core_get_phase(c));
 	seq_printf(s, "\"duty_cycle\": %u",
 		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
-- 
2.19.1

