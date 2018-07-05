Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B24C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B44F24139
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B44F24139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeGECUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:20:20 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:63215 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeGECUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:20:19 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1fatsM-0001ea-4x from Jiada_Wang@mentor.com ; Wed, 04 Jul 2018 19:20:06 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 4 Jul 2018 19:20:02 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <jiada_wang@mentor.com>, <keescook@chromium.org>,
        <andrew_gabbasov@mentor.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] ASoC: rsnd: cmd: Add missing newline to debug message
Date:   Thu, 5 Jul 2018 11:20:04 +0900
Message-ID: <20180705022004.24524-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Gabbasov <andrew_gabbasov@mentor.com>

To comply with the style of all kernel messages, add newline
to the end of every message.

Fixes: 70fb10529f61 ("ASoC: rsnd: add MIX (Mixer) support")
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index d8043ad33540..cc191cd5fb82 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -86,7 +86,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 			cmd_case[rsnd_mod_id(src)] << 16;
 	}
 
-	dev_dbg(dev, "ctu/mix path = 0x%08x", data);
+	dev_dbg(dev, "ctu/mix path = 0x%08x\n", data);
 
 	rsnd_mod_write(mod, CMD_ROUTE_SLCT, data);
 	rsnd_mod_write(mod, CMD_BUSIF_MODE, rsnd_get_busif_shift(io, mod) | 1);
-- 
2.17.0

