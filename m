Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeBLWHD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:07:03 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36674 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932413AbeBLWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:02:39 -0500
X-Google-Smtp-Source: AH8x225NG9ClhxU/kY0pdGWOZTpfbA1evETW1w5notyGSv/Dj8E/3McKgoZOobtRmV9pkl9CXMaLYg==
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org, timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 01/17] ASoC: fsl_ssi: Redefine RX and TX macros
Date: Mon, 12 Feb 2018 14:03:09 -0800
Message-Id: <1518473005-14090-2-git-send-email-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RX and TX macros were defined implicitly and there was
a potential risk if someone changes their values.

Since they were defined to index the array ssi->regvals[2],
this patch moves these two macros to fsl_ssi.c, closer to
its owner ssi->regvals. And it also puts some comments here
to limit their value within [0, 1].

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++++
 sound/soc/fsl/fsl_ssi.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 24fb672..3c8dd60 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -56,6 +56,10 @@
 #include "fsl_ssi.h"
 #include "imx-pcm.h"
 
+/* Define RX and TX to index ssi->regvals array; Can be 0 or 1 only */
+#define RX 0
+#define TX 1
+
 /**
  * FSLSSI_I2S_FORMATS: audio formats supported by the SSI
  *
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index de2fdc5..18f8dd5 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -12,9 +12,6 @@
 #ifndef _MPC8610_I2S_H
 #define _MPC8610_I2S_H
 
-#define RX 0
-#define TX 1
-
 /* -- SSI Register Map -- */
 
 /* SSI Transmit Data Register 0 */
-- 
2.1.4
