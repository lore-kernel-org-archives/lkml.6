Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA24C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A01521871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfAECDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:03:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:49511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfAECDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:03:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634698"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:03:41 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/21] ASoC: codecs: fix kernel doc descriptions
Date:   Fri,  4 Jan 2019 20:02:32 -0600
Message-Id: <20190105020249.8639-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing or spurious parameter descriptions. Fix warnings with W=1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/nau8825.c | 1 +
 sound/soc/codecs/rt5514.c  | 1 +
 sound/soc/codecs/rt5677.c  | 8 ++++----
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 7bbcbf5f05c8..47e65cf99879 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -351,6 +351,7 @@ static void nau8825_hpvol_ramp(struct nau8825 *nau8825,
  * Computes log10 of a value; the result is round off to 3 decimal. This func-
  * tion takes reference to dvb-math. The source code locates as the following.
  * Linux/drivers/media/dvb-core/dvb_math.c
+ * @value:  input for log10
  *
  * return log10(value) * 1000
  */
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index a67de68b6da6..f9ad6e36ab16 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -489,6 +489,7 @@ static const struct snd_kcontrol_new rt5514_sto2_dmic_mux =
 /**
  * rt5514_calc_dmic_clk - Calculate the frequency divider parameter of dmic.
  *
+ * @component: only used for dev_warn
  * @rate: base clock rate.
  *
  * Choose divider parameter that gives the highest possible DMIC frequency in
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9b7a1833d331..6fc70e441458 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -547,7 +547,7 @@ static bool rt5677_readable_register(struct device *dev, unsigned int reg)
  * @rt5677: Private Data.
  * @addr: Address index.
  * @value: Address data.
- *
+ * @opcode: opcode value
  *
  * Returns 0 for success or negative error code.
  */
@@ -602,7 +602,7 @@ static int rt5677_dsp_mode_i2c_write_addr(struct rt5677_priv *rt5677,
 
 /**
  * rt5677_dsp_mode_i2c_read_addr - Read value from address on DSP mode.
- * rt5677: Private Data.
+ * @rt5677: Private Data.
  * @addr: Address index.
  * @value: Address data.
  *
@@ -651,7 +651,7 @@ static int rt5677_dsp_mode_i2c_read_addr(
 
 /**
  * rt5677_dsp_mode_i2c_write - Write register on DSP mode.
- * rt5677: Private Data.
+ * @rt5677: Private Data.
  * @reg: Register index.
  * @value: Register data.
  *
@@ -667,7 +667,7 @@ static int rt5677_dsp_mode_i2c_write(struct rt5677_priv *rt5677,
 
 /**
  * rt5677_dsp_mode_i2c_read - Read register on DSP mode.
- * @codec: SoC audio codec device.
+ * @rt5677: Private Data
  * @reg: Register index.
  * @value: Register data.
  *
-- 
2.17.1

