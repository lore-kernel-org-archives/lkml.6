Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A25C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E62121871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAECDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:03:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:49511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAECDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:03:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634686"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:03:35 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/21] ASoC: max98090: remove unused constant variables
Date:   Fri,  4 Jan 2019 20:02:30 -0600
Message-Id: <20190105020249.8639-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings with W=1

If these variables are useful then this driver should be modified to
expose them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c97f21836c66..30c242c38d99 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -314,9 +314,6 @@ static const DECLARE_TLV_DB_SCALE(max98090_av_tlv, -1200, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_dvg_tlv, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_dv_tlv, -1500, 100, 0);
 
-static const DECLARE_TLV_DB_SCALE(max98090_sidetone_tlv, -6050, 200, 0);
-
-static const DECLARE_TLV_DB_SCALE(max98090_alc_tlv, -1500, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_alcmakeup_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_alccomp_tlv, -3100, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_drcexp_tlv, -6600, 100, 0);
@@ -817,18 +814,6 @@ static SOC_ENUM_SINGLE_VIRT_DECL(dmic_mux_enum, dmic_mux_text);
 static const struct snd_kcontrol_new max98090_dmic_mux =
 	SOC_DAPM_ENUM("DMIC Mux", dmic_mux_enum);
 
-static const char *max98090_micpre_text[] = { "Off", "On" };
-
-static SOC_ENUM_SINGLE_DECL(max98090_pa1en_enum,
-			    M98090_REG_MIC1_INPUT_LEVEL,
-			    M98090_MIC_PA1EN_SHIFT,
-			    max98090_micpre_text);
-
-static SOC_ENUM_SINGLE_DECL(max98090_pa2en_enum,
-			    M98090_REG_MIC2_INPUT_LEVEL,
-			    M98090_MIC_PA2EN_SHIFT,
-			    max98090_micpre_text);
-
 /* LINEA mixer switch */
 static const struct snd_kcontrol_new max98090_linea_mixer_controls[] = {
 	SOC_DAPM_SINGLE("IN1 Switch", M98090_REG_LINE_INPUT_CONFIG,
-- 
2.17.1

