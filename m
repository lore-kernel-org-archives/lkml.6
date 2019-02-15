Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29757C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9322192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198559;
	bh=rS1SbKaSUqm9ftT4tUjE8TiJRTQUMZw49ERPV7se18E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LO1T2lQNYNlHR/VxqdYDXdLiSiQ7PZPiKFJ/fz27qSUqG504DPN7APgsTru9aI6vB
	 Vcf9ZcHit0LpgBJLB+R7BuFbEktyhQSGLdwbC5nMHfPD/Cj0nZu1e8l5vbC3mR2JxY
	 cX0WHJjpHe3Xg9OeGSktpObrNCtAySInbLDzy4Xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfBOCJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbfBOCJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4CE222C9;
        Fri, 15 Feb 2019 02:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196548;
        bh=rS1SbKaSUqm9ftT4tUjE8TiJRTQUMZw49ERPV7se18E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLHi/x0jB2zn1MQGKOAd7V45xhxlRKdnI4THJH2cZUcP16b1KonF+PSINAjL+1Jf+
         k9opBYy59QvrOSTYdr1HGN/vDnQE/VrJDYkgBY9QtYWBggaPThtz6ahKZNz3944O6V
         y5GkPAco0Eh9vXgzxYV4TLvwVUTcNhq41IxxwhGo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 08/77] clk: sysfs: fix invalid JSON in clk_dump
Date:   Thu, 14 Feb 2019 21:07:46 -0500
Message-Id: <20190215020855.176727-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
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
index af011974d4ec..2bcd9cb26348 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2782,7 +2782,7 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
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

