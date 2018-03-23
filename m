Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeCWJsh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:48:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60463 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeCWJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:48:36 -0400
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: amd: make pointer da7219_dai_clk static
Date: Fri, 23 Mar 2018 09:48:24 +0000
Message-Id: <20180323094824.26028-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer da7219_dai_clk  is local to the source and does not need to
be in global scope, so make it static.

Cleans up sparse warning:
sound/soc/amd/acp-da7219-max98357a.c:46:12: warning: symbol 'da7219_dai_clk'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 99c6b5ce5c6c..af458bd36c72 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -43,7 +43,7 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
-- 
2.15.1
