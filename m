Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D96ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BB820873
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BB820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJ1PPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 11:15:06 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:49143
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbeJ1PPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 11:15:06 -0400
X-IronPort-AV: E=Sophos;i="5.54,435,1534802400"; 
   d="scan'208";a="283535952"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 28 Oct 2018 07:31:24 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: AMD: constify regulator_desc structure
Date:   Sun, 28 Oct 2018 06:56:08 +0100
Message-Id: <1540706168-30601-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator_desc structure can be const as it is only passed as the
second argument of devm_regulator_register and the corresponding
parameter is declared as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/amd/acp-da7219-max98357a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 3f813ea5210a..a5daad973ce5 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -403,7 +403,7 @@ static struct regulator_config acp_da7219_cfg = {
 static struct regulator_ops acp_da7219_ops = {
 };
 
-static struct regulator_desc acp_da7219_desc = {
+static const struct regulator_desc acp_da7219_desc = {
 	.name = "reg-fixed-1.8V",
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,

