Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeCTIl3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:41:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43242 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeCTIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:41:25 -0400
X-Google-Smtp-Source: AG47ELtPNVyCLfhBfzlKCvi+feP13SzzSJhl79aeHWh0ZPpgTnAY834qDy3IF9gvx1Ey3CECb/UcMA==
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ASoC: rsnd: set pm_ops in hibernate-compatible way
Date: Tue, 20 Mar 2018 11:41:15 +0300
Message-Id: <20180320084115.23880-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SET_SYSTEM_SLEEP_PM_OPS() macro instead of direct assignment to
.suspend and .resume fields.

This makes driver working after restore from hibernation.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/sh/rcar/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 64d5ecb86528..dabf9a35c25c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1560,8 +1560,7 @@ static int rsnd_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rsnd_pm_ops = {
-	.suspend		= rsnd_suspend,
-	.resume			= rsnd_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(rsnd_suspend, rsnd_resume)
 };
 
 static struct platform_driver rsnd_driver = {
-- 
2.11.0
