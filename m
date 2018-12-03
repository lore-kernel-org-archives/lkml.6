Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF79C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4B320851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4B320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeLCLWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:22:36 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:40800 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeLCLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:22:36 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gTmIX-0004aB-11 from Jiada_Wang@mentor.com ; Mon, 03 Dec 2018 03:21:57 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 3 Dec 2018 03:21:54 -0800
From:   <jiada_wang@mentor.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <vladimir_zapolskiy@mentor.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next v2 2/6] clk: renesas: r8a7796: Add ADG clock
Date:   Mon, 3 Dec 2018 20:21:56 +0900
Message-ID: <20181203112200.18220-3-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181203112200.18220-1-jiada_wang@mentor.com>
References: <20181203112200.18220-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds ADG clock to the R8A7796 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 10567386e6dd..7568204e9ed6 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -209,6 +209,7 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
 	DEF_MOD("can-if0",		 916,	R8A7796_CLK_S3D4),
 	DEF_MOD("i2c6",			 918,	R8A7796_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A7796_CLK_S0D6),
+	DEF_MOD("adg",			 922,	R8A7796_CLK_S0D1),
 	DEF_MOD("i2c-dvfs",		 926,	R8A7796_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A7796_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A7796_CLK_S0D6),
-- 
2.17.0

