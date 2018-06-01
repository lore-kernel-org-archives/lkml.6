Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeFARMW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:12:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60552 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeFARMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:12:20 -0400
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <groeck@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Chintan Patel <chintan.m.patel@intel.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: topology: Move skl-tplg-interface.h to uapi" to the asoc tree
In-Reply-To: <1527191363-21021-3-git-send-email-linux@roeck-us.net>
Message-Id: <E1fOnb1-0003ET-Ry@debutante>
Date: Fri, 01 Jun 2018 18:12:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: topology: Move skl-tplg-interface.h to uapi

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0c24fdc00244cc08309e397e3783f2943221dc53 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <groeck@chromium.org>
Date: Thu, 24 May 2018 12:49:23 -0700
Subject: [PATCH] ASoC: topology: Move skl-tplg-interface.h to uapi

skl-tplg-interface.h describes firmware format details for Skylake
topology files. It is part of the ABI and should reside in the uapi
directory.

While moving the file, also replace the license boilerplate with
the SPDX License Identifier.

No functional change.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
index 302b40e63e6c..5d7ac2ee7a3c 100644
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
index dd590a1c58e2..d5f9c30eba32 100644
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
2.17.0
