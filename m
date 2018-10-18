Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB00C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2452087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2452087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJRTUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:20:09 -0400
Received: from mout.perfora.net ([74.208.4.194]:41867 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeJRTUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:20:08 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M7rHi-1fQn5j1qbI-00vO1p; Thu, 18 Oct 2018 13:18:47 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M7rHi-1fQn5j1qbI-00vO1p; Thu, 18 Oct 2018 13:18:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v1 3/3] ASoC: soc-core: fix platform name vs. of_node assignement
Date:   Thu, 18 Oct 2018 13:18:29 +0200
Message-Id: <20181018111829.27056-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018111829.27056-1-marcel@ziswiler.com>
References: <20181018111829.27056-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:bJFLJ1BoDeEzEjC4mY7val9u3COLszVjxtmu6vKtlDs5pneUr6K
 QNlA7qSR9qp4V9U/cMWu3Jzkj6EZE9GdzkdHn+w09YwLtG5IGVIKFEiP+byJtTATVlJkNEW
 UOyH1tOs0CBqNPCpGW9pJY0Q4BguAqk2aUb4vH+p38cpzeWGSzIcf7MkO/HXkGbzQPbMq/s
 dMdSHbkBegza9UQtfOFEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D7mZHb7CjNo=:otoxnfwzhliN2YwBRYFb1/
 b72tsv8XZb+djVyUHcWIYqmHqiBQljgEERLIyZMx/+JsFuFpQazL22Vo7uL18c+UEXtATKuMM
 KOAI/EVKIHkR4MMn0Y6igTNkIONB3gwUW/LWl/ExbaZezdwdAtysXdjx4SJr9G9pZZtMda1/d
 92Pg+Ndmuvgd6aSTTm6bhwWWRbM/DtSAJmHYxBAeFN3kgLsv0SIev4/iSyJevnpQjpzvCxcSH
 uekajYKqMxeBZhrXMf8OcksFESGJPSLNufwS5ZlsXa/C/tjNDwkqm6kLqMQbxhPYqtI6bT7qH
 Wx6ImwIVXP6+R8ekMtn5cTNkKIiZIGlzybSpABE5hbdWZt8LscNC0d8MuVlw/TOLV9hc5HAKh
 MKDuKUTQFny0DTjogIEGmIODOkq54ohrDThlKelFZEA2lay+Yk1inXfnU6iY5cbOJxQTBot+K
 sNnF29zeto/goGrBnWUS0L7Y/I1OS+pW1xw5vs7Cy6nyaFvJdHV6f4OFUcs42wqiHNkaAMXS7
 bB22HBJnztshj7i3fEHqpqaM5vlYttYOZAN1v0gcVQ8Tbd0flD+PxyCv9G3OZTZ1iN4NASgk0
 14JvIPtHUtjYxfqiSgT6mvAM91clvtEhBv1jU2ZWS0x4I9LkpTJrPgHgM2F02L16vSLlUBdsu
 he/N7C2+QV3ekOHo/xoO/lM1L6s0NgUMpojLGmBfyF6u6E7tt8ZwGwuXso4i94IyIAA4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following error as seen post commit daecf46ee0e5
("ASoC: soc-core: use snd_soc_dai_link_component for platform") on
Apalis TK1 after initial probe deferral:

tegra-snd-sgtl5000 sound: ASoC: Both platform name/of_node are set for
 sgtl5000
tegra-snd-sgtl5000 sound: ASoC: failed to init link sgtl5000
tegra-snd-sgtl5000 sound: snd_soc_register_card failed (-22)
tegra-snd-sgtl5000: probe of sound failed with error -22

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v1:
- Split from the Tegra series as suggested by Mark.
- Fix issue in soc-core rather than working around it in tegra_sgtl5000.

 sound/soc/soc-core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6ddcf12bc030..b97624005976 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2733,7 +2733,7 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 int snd_soc_register_card(struct snd_soc_card *card)
 {
 	int i, ret;
-	struct snd_soc_dai_link *link;
+	struct snd_soc_dai_link *link = NULL;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -2744,7 +2744,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		if (ret) {
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
-			return ret;
+			goto err;
 		}
 	}
 
@@ -2763,7 +2763,17 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 
-	return snd_soc_bind_card(card);
+	ret = snd_soc_bind_card(card);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	if (link && link->platform)
+		link->platform = NULL;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
-- 
2.14.4

