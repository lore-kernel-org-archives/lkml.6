Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971239AbeEXTtc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:49:32 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:52748 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971226AbeEXTt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:49:29 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
        Chintan Patel <chintan.m.patel@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 3/3] ASoC: topology: Move skl-tplg-interface.h to uapi
Date: Thu, 24 May 2018 12:49:23 -0700
Message-Id: <1527191363-21021-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <groeck@chromium.org>

skl-tplg-interface.h describes firmware format details for Skylake
topology files. It is part of the ABI and should reside in the uapi
directory.

While moving the file, also replace the license boilerplate with
the SPDX License Identifier.

No functional change.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
---
v2: Added patch to series

 .../uapi/sound}/skl-tplg-interface.h                  | 11 +----------
 sound/soc/intel/skylake/skl-debug.c                   |  2 +-
 sound/soc/intel/skylake/skl-messages.c                |  2 +-
 sound/soc/intel/skylake/skl-topology.c                |  2 +-
 sound/soc/intel/skylake/skl-topology.h                |  2 +-
 5 files changed, 5 insertions(+), 14 deletions(-)
 rename {sound/soc/intel/skylake => include/uapi/sound}/skl-tplg-interface.h (90%)

diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/include/uapi/sound/skl-tplg-interface.h
similarity index 90%
rename from sound/soc/intel/skylake/skl-tplg-interface.h
rename to include/uapi/sound/skl-tplg-interface.h
index b0e3d376594c..f58cafa42f18 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/include/uapi/sound/skl-tplg-interface.h
@@ -1,19 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * skl-tplg-interface.h - Intel DSP FW private data interface
  *
  * Copyright (C) 2015 Intel Corp
  * Author: Jeeja KP <jeeja.kp@intel.com>
  *	    Nilofer, Samreen <samreen.nilofer@intel.com>
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #ifndef __HDA_TPLG_INTERFACE_H__
diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index a016455a6ddb..a7a5deaf12f3 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -15,10 +15,10 @@
 
 #include <linux/pci.h>
 #include <linux/debugfs.h>
+#include <uapi/sound/skl-tplg-interface.h>
 #include "skl.h"
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
-#include "skl-tplg-interface.h"
 #include "skl-topology.h"
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 57d4a58522a6..fdea186615c6 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <uapi/sound/skl-tplg-interface.h>
 #include "skl-sst-dsp.h"
 #include "cnl-sst-dsp.h"
 #include "skl-sst-ipc.h"
@@ -28,7 +29,6 @@
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
 #include "skl-topology.h"
-#include "skl-tplg-interface.h"
 
 static int skl_alloc_dma_buf(struct device *dev,
 		struct snd_dma_buffer *dmab, size_t size)
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 9e4c2cb88dea..2c5129782959 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -23,11 +23,11 @@
 #include <sound/soc.h>
 #include <sound/soc-topology.h>
 #include <uapi/sound/snd_sst_tokens.h>
+#include <uapi/sound/skl-tplg-interface.h>
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
 #include "skl-topology.h"
 #include "skl.h"
-#include "skl-tplg-interface.h"
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
 
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index b1e0667c0ae0..6d7e0569695f 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -25,8 +25,8 @@
 
 #include <sound/hdaudio_ext.h>
 #include <sound/soc.h>
+#include <uapi/sound/skl-tplg-interface.h>
 #include "skl.h"
-#include "skl-tplg-interface.h"
 
 #define BITS_PER_BYTE 8
 #define MAX_TS_GROUPS 8
-- 
2.17.0.441.gb46fe60e1d-goog
