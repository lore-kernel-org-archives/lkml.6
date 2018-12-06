Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6605C214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6605C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLFW0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:26:13 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:38538 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLFW0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:26:12 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990411AbeLFWYXY4dWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Thu, 6 Dec 2018 23:24:23 +0100
Date:   Thu, 6 Dec 2018 23:24:22 +0100
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        anish kumar <yesanishhere@gmail.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: max9867: Remove useless assignment
Message-ID: <20181206222422.GA29787@lenoch>
References: <20181207080122.20d3d342@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207080122.20d3d342@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret is assigned later, no need to initialize it.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 CHANGES:
 -v2: add missing Signed-off-by
 (I'm sorry for that...)

 sound/soc/codecs/max9867.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 1cda54b59854..1b155f40b106 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -476,7 +476,7 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 		const struct i2c_device_id *id)
 {
 	struct max9867_priv *max9867;
-	int ret = 0, reg;
+	int ret, reg;
 
 	max9867 = devm_kzalloc(&i2c->dev, sizeof(*max9867), GFP_KERNEL);
 	if (!max9867)
@@ -497,10 +497,8 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 	dev_info(&i2c->dev, "device revision: %x\n", reg);
 	ret = devm_snd_soc_register_component(&i2c->dev, &max9867_component,
 			max9867_dai, ARRAY_SIZE(max9867_dai));
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
-		return ret;
-	}
 	return ret;
 }
 
-- 
2.20.0.rc2

