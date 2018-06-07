Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ueoHKTM4GVvjeQAAmS7hNA
	; Thu, 07 Jun 2018 13:50:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 52B2C607DC; Thu,  7 Jun 2018 13:50:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D17B3601B4;
	Thu,  7 Jun 2018 13:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D17B3601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932689AbeFGNuy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:50:54 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:58012 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeFGNuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:50:52 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id vpqp1x00a3XaVaC01pqpUV; Thu, 07 Jun 2018 15:50:51 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fQvJR-0000Oz-IU; Thu, 07 Jun 2018 15:50:49 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fQvJR-00012E-Gr; Thu, 07 Jun 2018 15:50:49 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Shuming Fan <shumingf@realtek.com>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ASoC: rt1305: Use ULL suffixes for 64-bit constants
Date: Thu,  7 Jun 2018 15:50:48 +0200
Message-Id: <1528379448-3937-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.2:

    sound/soc/codecs/rt1305.c: In function ‘rt1305_calibrate’:
    sound/soc/codecs/rt1305.c:1069: warning: integer constant is too large for ‘long’ type
    sound/soc/codecs/rt1305.c:1086: warning: integer constant is too large for ‘long’ type

Add the missing "ULL" suffixes to fix this.

Fixes: 29bc643ddd7efb74 ("ASoC: rt1305: Add RT1305/RT1306 amplifier driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/codecs/rt1305.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index f4c8c45f40103cf8..421b8fb2fa04dd63 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -1066,7 +1066,7 @@ static void rt1305_calibrate(struct rt1305_priv *rt1305)
 	pr_debug("Left_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
 	pr_info("Left channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
 
-	r0l = 562949953421312;
+	r0l = 562949953421312ULL;
 	if (rhl != 0)
 		do_div(r0l, rhl);
 	pr_debug("Left_r0 = 0x%llx\n", r0l);
@@ -1083,7 +1083,7 @@ static void rt1305_calibrate(struct rt1305_priv *rt1305)
 	pr_debug("Right_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
 	pr_info("Right channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
 
-	r0r = 562949953421312;
+	r0r = 562949953421312ULL;
 	if (rhl != 0)
 		do_div(r0r, rhl);
 	pr_debug("Right_r0 = 0x%llx\n", r0r);
-- 
2.7.4
