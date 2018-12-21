Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78330C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5421929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbeLUUuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:50:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:31811 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbeLUUuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:50:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 12:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; 
   d="scan'208";a="100599557"
Received: from kmorgan8-mobl3.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.128.152])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2018 12:50:01 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: fix unmet dependencies in Kconfig
Date:   Fri, 21 Dec 2018 14:49:55 -0600
Message-Id: <20181221204955.30993-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove warnings by selecting SND_HDA_INTEL_DSP_DETECTION_XYZ only when
SND_HDA_INTEL is part of the config.

Fixes: c337104b1a16 ('ALSA: HD-Audio: SKL+: abort probe if DSP is present and Skylake driver selected')
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2fd1b61e8331..555cdb1d87d4 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -188,12 +188,12 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
 	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
-	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL
-	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL
-	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL
-	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK
-	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL
-	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL
+	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL && SND_HDA_INTEL
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
 	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
-- 
2.17.1

