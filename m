Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACEDC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2758B218E0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAECFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:05:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:49511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfAECEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:04:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:03:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634744"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:03:57 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/21] ASoC: rt274: fix boolean tests
Date:   Fri,  4 Jan 2019 20:02:38 -0600
Message-Id: <20190105020249.8639-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Coccinelle:

sound/soc/codecs/rt274.c:958:6-8: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:961:6-9: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:384:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:387:5-8: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt274.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index e2855ab9a2c6..9e88f7b25d38 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -381,10 +381,10 @@ static void rt274_jack_detect_work(struct work_struct *work)
 	if (rt274_jack_detect(rt274, &hp, &mic) < 0)
 		return;
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt274->jack, status,
@@ -955,10 +955,10 @@ static irqreturn_t rt274_irq(int irq, void *data)
 	ret = rt274_jack_detect(rt274, &hp, &mic);
 
 	if (ret == 0) {
-		if (hp == true)
+		if (hp)
 			status |= SND_JACK_HEADPHONE;
 
-		if (mic == true)
+		if (mic)
 			status |= SND_JACK_MICROPHONE;
 
 		snd_soc_jack_report(rt274->jack, status,
-- 
2.17.1

