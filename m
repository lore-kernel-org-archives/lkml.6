Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ACAC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80172208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039508;
	bh=/Mf9lkbFWlWsrBODBZfbt8kW8HIna6A1hCkUrRKohWo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JKumZdfEx/QWN4YAJ8fJcnR5CKlEV9x92MJo7B1zJpQvzHJ/VXh4KeCT+IuIGWV6u
	 htP7fMhL4bAg6PgR3xeo8tpG/JbP+G/BeoqIGMHvBZk4lS8Ia4peuRpKzlfbeMZh0s
	 UniZK0twgZMD4uGvAcTsk+ns+4X2ImJkhloY4Itk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80172208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeLETvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46669 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbeLETv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so19773731otm.13;
        Wed, 05 Dec 2018 11:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThQ7RT0snc2eXhKBllFE/yVobWH1ZvOxkwfOj6s8tE8=;
        b=Xb0dr03n9GAJ5BEKTLca5y35Q2eJlgI4oSTXhzcngJmRPPtnDBSfoNnIbKq/GomoGy
         1WF8cC6gjMr06CgO8HBeFaE/EXf1cRuvcg7lQSkVUgnne5WZZMnF3Hqx2aoWKVIaF2ao
         lq8lNHnp61k7KN8o88TyRtfQN/gDop2l+0wYXM7ulMmbPBz6ZZJ+9Q3bhdxfebuIX1/Y
         hrVWpDkMm/tjUZ5OaWn7OSxoB64WpIpSWm+rV+WHtvwPN2s5BUDw8c7ccUt++g0uc4cF
         yteFBs679x7Heni2l8uE2k6Dh1Rfcak2QSY2xypy8DCG/bHFR8rIr3dCuIRAs5WMIwgN
         zfZA==
X-Gm-Message-State: AA+aEWYWbXbsbSGIdwL2SJiOAHejsdgS5p5uWmiQQ1WsxdaekpvfxGwJ
        K8Ol7QQt4Y02tLi1aB1A0JvlNAdoAA==
X-Google-Smtp-Source: AFSGD/WpzdhTG/04KfFGOZWhkfcbxlLfUQArESSierVbdwONFtNtAjGMAkfqvVdxhqqgqIJsIfGAnQ==
X-Received: by 2002:a05:6830:13c2:: with SMTP id e2mr15266877otq.15.1544039488275;
        Wed, 05 Dec 2018 11:51:28 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:27 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:49 -0600
Message-Id: <20181205195050.4759-33-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For the FSL ASoC card, the full node names appear to be "ssi", "esai",
and "sai", so there's not any reason to use strstr and of_node_name_eq
can be used instead.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c       | 6 +++---
 sound/soc/generic/simple-scu-card.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 44433b20435c..81f2fe2c6d23 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -571,17 +571,17 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 	/* Common settings for corresponding Freescale CPU DAI driver */
-	if (strstr(cpu_np->name, "ssi")) {
+	if (of_node_name_eq(cpu_np, "ssi")) {
 		/* Only SSI needs to configure AUDMUX */
 		ret = fsl_asoc_card_audmux_init(np, priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to init audmux\n");
 			goto asrc_fail;
 		}
-	} else if (strstr(cpu_np->name, "esai")) {
+	} else if (of_node_name_eq(cpu_np, "esai")) {
 		priv->cpu_priv.sysclk_id[1] = ESAI_HCKT_EXTAL;
 		priv->cpu_priv.sysclk_id[0] = ESAI_HCKR_EXTAL;
-	} else if (strstr(cpu_np->name, "sai")) {
+	} else if (of_node_name_eq(cpu_np, "sai")) {
 		priv->cpu_priv.sysclk_id[1] = FSL_SAI_CLK_MAST1;
 		priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
 	}
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 85b46f0eae0f..e9a1acffcf5b 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -216,7 +216,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	i = 0;
 	for_each_child_of_node(node, np) {
 		is_fe = false;
-		if (strcmp(np->name, PREFIX "cpu") == 0)
+		if (of_node_name_eq(np, PREFIX "cpu"))
 			is_fe = true;
 
 		ret = asoc_simple_card_dai_link_of(np, priv, daifmt, i, is_fe);
-- 
2.19.1

