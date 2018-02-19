Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeBSGEp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 01:04:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56094 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeBSGEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 01:04:44 -0500
X-Google-Smtp-Source: AH8x224bpPhFXm7bRg6uF6rB4p3akFVZDKQP5sXXtM2qnIzKiPRSQpkzg9NMkgoTDyajqzbotjjKDA==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Harsha Priya N <harshapriya.n@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: Skylake: Fix compiler warning -Wmaybe-uninitialized
Date: Mon, 19 Feb 2018 07:02:29 +0100
Message-Id: <20180219060229.17215-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configuration:

SND_SOC_INTEL_SKYLAKE=y
PM_SLEEP=y

Warning message:

sound/soc/intel/skylake/skl.c: In function 'skl_resume':
sound/soc/intel/skylake/skl.c:326:6: warning: 'ret' may be used
uninitialized in this function [-Wmaybe-uninitialized]
  int ret;
      ^~~

Fixes: 4557c305d4fc ("ASoC: Intel: Skylake: Add support for active suspend")
Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: Naveen Manohar <naveen.m@intel.com>
Cc: Harsha Priya N <harshapriya.n@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/intel/skylake/skl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 31d8634e8aa1..273a9ab75489 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -323,7 +323,7 @@ static int skl_resume(struct device *dev)
 	struct skl *skl  = ebus_to_skl(ebus);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct hdac_ext_link *hlink = NULL;
-	int ret;
+	int ret = 0;
 
 	/* Turned OFF in HDMI codec driver after codec reconfiguration */
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-- 
2.13.6
