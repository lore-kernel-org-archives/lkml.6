Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933121AbeEHWmJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:42:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43592 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932759AbeEHWmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:42:08 -0400
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        John Hsu <KCHSU0@nuvoton.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: nau8824: fix spelling mistake: "semaphone" -> "semaphore"
Date: Tue,  8 May 2018 23:41:55 +0100
Message-Id: <20180508224155.26486-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/nau8824.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 76502c090654..6bd14453f06e 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -205,11 +205,11 @@ static int nau8824_sema_acquire(struct nau8824 *nau8824, long timeout)
 	if (timeout) {
 		ret = down_timeout(&nau8824->jd_sem, timeout);
 		if (ret < 0)
-			dev_warn(nau8824->dev, "Acquire semaphone timeout\n");
+			dev_warn(nau8824->dev, "Acquire semaphore timeout\n");
 	} else {
 		ret = down_interruptible(&nau8824->jd_sem);
 		if (ret < 0)
-			dev_warn(nau8824->dev, "Acquire semaphone fail\n");
+			dev_warn(nau8824->dev, "Acquire semaphore fail\n");
 	}
 
 	return ret;
-- 
2.17.0
