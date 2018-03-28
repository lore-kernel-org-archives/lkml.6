Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeC1Oyl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:54:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeC1Oyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:54:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rsnd: mark PM functions __maybe_unused
Date: Wed, 28 Mar 2018 16:53:10 +0200
Message-Id: <20180328145318.10136-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:P9BT+t04wRIJOMK3z+6ASPKc9g/SgEYEahrvMBhQTqD+2wvxFFd
 c5N0SrJyl14qtwKJraZ4KLABwsjpdqpWE+k/GosHlnS5uLnunY1Ghe9bkQOPAVa9pwuzr2M
 EzItVgQ9soYr9Ox6D3k8zo9jKWn7c4HShalE+JUyElyM8nBn26uph+5iBQIzFkEuNlmSEAC
 sPLRV/G39hTh6AAQrPZpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1WlKLa/IMZU=:64Pst7i0Vn7jXwADyzlfu6
 TiAmAskOCHv8EiDJtAnuoh+wk/ytaYDVbS2PD9ghv6V3P99/lPN0I4EIJDo46LU017cF/OeTy
 F5EXuJ1E5DUbLAH2SPpmp9jkzeeUYWBV8b5eY9IsKQdu3ZxI6ZRXalw+rVzywYTd/xkKiT/w+
 EnUDKCJKGlq17pKw7oQIs6nbbxPwArQ1OoyJG7yrTMUxafrPy31tkoYUP7miUoiwGk0atxbyF
 FFB9ZuBXTiZO4F4rw7kbUt9NWd4s8qQ0NGXUo9ajJPkqOq9JMA8iO0zSSHqq2/GdOhb81O7lL
 DTvgwDg0f4vW+M//XBQhj/9Aor6BVxL3bvsZYqLnel6T5QFGGlYri9DN1X2ZSgJd/n78q0Osu
 tnNCSj0XJ3lzIFjBij4iPAcf0THOOvywldAgiPHIRBxZUUy8BUpqZiQoHxemkBfM83LBcMKXT
 fwXeHX4t5QTe4GZ8NL2sEaDDfOGEj6oMIuOoBAxwRgWRNxlpgSVFMISf4rkYhRarjpgJdcudt
 853UlbvJyzsXnO0sk6gYX7viIbLjiXDvQhViXgxcrIiH5R2BXRuJFffkK1YyPe4DRAKncc6Mq
 1AsrBTfCfX8enqo1/TRSbNJ5fGaTKudyY0X6GXcoOQ77imkOX5GWrhsNUQNhCFvunCZuo3lTr
 70P07/15SONBQdqFG/2QCSbmq1l8Cc/Q6lKKzyy3jUckyRY7JXlKPYKq7SIXGkb45W1K10mwP
 3z6au9qgeQxZKOKROnkmb6AF4hnvN/T69OdK3w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suspend/resume callbacks are now optional, leading to a warning
when they are unused:

sound/soc/sh/rcar/core.c:1548:12: error: 'rsnd_resume' defined but not used [-Werror=unused-function]
 static int rsnd_resume(struct device *dev)
            ^~~~~~~~~~~
sound/soc/sh/rcar/core.c:1539:12: error: 'rsnd_suspend' defined but not used [-Werror=unused-function]
 static int rsnd_suspend(struct device *dev)

This marks the as __maybe_unused to avoid the warning.

Fixes: f8a9a29c4fe9 ("ASoC: rsnd: set pm_ops in hibernate-compatible way")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sh/rcar/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6a76688a8ba9..94f081b93258 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1536,7 +1536,7 @@ static int rsnd_remove(struct platform_device *pdev)
 	return ret;
 }
 
-static int rsnd_suspend(struct device *dev)
+static int __maybe_unused rsnd_suspend(struct device *dev)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(dev);
 
@@ -1545,7 +1545,7 @@ static int rsnd_suspend(struct device *dev)
 	return 0;
 }
 
-static int rsnd_resume(struct device *dev)
+static int __maybe_unused rsnd_resume(struct device *dev)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(dev);
 
-- 
2.9.0
