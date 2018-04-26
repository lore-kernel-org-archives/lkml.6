Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736179; cv=none;
        d=google.com; s=arc-20160816;
        b=XtvFis8a5GejarqUE9IHdO9Wq9EsP+50lDGNcP0WO3FP7b5wgw/Jlf+qhJcAWWeRZG
         q0RM76ODDkO/8Q/qs1sIWl7mB6Ph4A7jVliDsxMEo6DRVKrzYNJuoK79MG1QcEMfYUWB
         zBmu0MBeAXDZRqHrmfRya1sCbFIl/3zGUq6Zg9tgskPkmQOZ0q3SirSd/vIhwvDpOvfc
         FPMTdyDBP6BS64cO+y2MwjlcMbzH2rmBAXyjD2Xbm5s46K6uEZ+WxA7aCQdNwzKFShrQ
         pXAGGGmTGtDIxPgQtce+gPomyojdX8G1TkPuC4Tt5d5uPWtQKJZpZ7cdRCfPGF63OH1P
         tUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=LY0EpzYVVGUzS4DTaLqS5Q+chnhmKmg7+eib4hHUhsU=;
        b=zUrmrqy/iAjSNqjWJuCOWzT0FKpLQVJ1UJjfiTgcoWrVSVZMq+EAA5rY6PN1OR7c8l
         sZMqSNYjvA78CfEoc8fVR2Pf4W1TgwXbykPGXU5zy4TIe3r3R8whdJVG76p/e2+orATH
         kqnnPChdAiklYeBUUSb9mOPJ7Vu+7UNyCHC1ZEsAU7mNp3NaO2LhurGRULKoseVU/DFr
         WP4eqqNxcmWOx9rdbv7xHH4IylUlRbJQUQRVnZ4Sb02Obxygjba7P2nK3JwzRZ9zY8Rn
         Jnob36107mf9MQOADeeDCdpbDcRp0kLMFW1lFn6DUVVr/MDpw9fgyZoM8pi/4atgc6pi
         NJLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lc03XMG6;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lc03XMG6;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/buqFqah1WOHv1mgoWVQpzwdFTt40LaQgWwHPn4TX9liSNzbJQ0p5HyCZ+3OK25yqcpDUXHg==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org,
	bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 07/24] ASoC: qdsp6: q6common: Add qdsp6 helper functions
Date: Thu, 26 Apr 2018 10:45:49 +0100
Message-Id: <20180426094606.4775-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801763722391707?=
X-GMAIL-MSGID: =?utf-8?q?1598801763722391707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds some common helper functions like translating dsp error
to linux error codes and channel mappings etc.

These functions are used in all the following qdsp6 drivers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig              | 13 ++++++++
 sound/soc/qcom/Makefile             |  3 ++
 sound/soc/qcom/qdsp6/Makefile       |  1 +
 sound/soc/qcom/qdsp6/q6dsp-common.c | 66 +++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6dsp-common.h | 24 ++++++++++++++
 sound/soc/qcom/qdsp6/q6dsp-errno.h  | 51 ++++++++++++++++++++++++++++
 6 files changed, 158 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/Makefile
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8ec9a074b38b..8247ade16dbe 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -43,3 +43,16 @@ config SND_SOC_APQ8016_SBC
           Support for Qualcomm Technologies LPASS audio block in
           APQ8016 SOC-based systems.
           Say Y if you want to use audio devices on MI2S.
+
+config SND_SOC_QDSP6_COMMON
+	tristate
+
+config SND_SOC_QDSP6
+	tristate "SoC ALSA audio driver for QDSP6"
+	depends on QCOM_APR && HAS_DMA
+	select SND_SOC_QDSP6_COMMON
+	help
+	 To add support for MSM QDSP6 Soc Audio.
+	 This will enable sound soc platform specific
+	 audio drivers. This includes q6asm, q6adm,
+	 q6afe interfaces to DSP using apr.
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index d5280355c24f..0276717917c0 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -16,3 +16,6 @@ snd-soc-apq8016-sbc-objs := apq8016_sbc.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
+
+#DSP lib
+obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
new file mode 100644
index 000000000000..accebdb49306
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
diff --git a/sound/soc/qcom/qdsp6/q6dsp-common.c b/sound/soc/qcom/qdsp6/q6dsp-common.c
new file mode 100644
index 000000000000..fc86a747cc7b
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-common.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+// Copyright (c) 2018, Linaro Limited
+
+#include "q6dsp-common.h"
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+
+int q6dsp_map_channels(u8 ch_map[PCM_FORMAT_MAX_NUM_CHANNEL], int ch)
+{
+	memset(ch_map, 0, PCM_FORMAT_MAX_NUM_CHANNEL);
+
+	switch (ch) {
+	case 1:
+		ch_map[0] = PCM_CHANNEL_FC;
+		break;
+	case 2:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		break;
+	case 3:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_FC;
+		break;
+	case 4:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_LS;
+		ch_map[3] = PCM_CHANNEL_RS;
+		break;
+	case 5:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_FC;
+		ch_map[3] = PCM_CHANNEL_LS;
+		ch_map[4] = PCM_CHANNEL_RS;
+		break;
+	case 6:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_LFE;
+		ch_map[3] = PCM_CHANNEL_FC;
+		ch_map[4] = PCM_CHANNEL_LS;
+		ch_map[5] = PCM_CHANNEL_RS;
+		break;
+	case 8:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_LFE;
+		ch_map[3] = PCM_CHANNEL_FC;
+		ch_map[4] = PCM_CHANNEL_LS;
+		ch_map[5] = PCM_CHANNEL_RS;
+		ch_map[6] = PCM_CHANNEL_LB;
+		ch_map[7] = PCM_CHANNEL_RB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6dsp_map_channels);
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6dsp-common.h b/sound/soc/qcom/qdsp6/q6dsp-common.h
new file mode 100644
index 000000000000..f0f0bd247bb1
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-common.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __Q6DSP_COMMON_H__
+#define __Q6DSP_COMMON_H__
+
+#include <linux/kernel.h>
+
+#define PCM_FORMAT_MAX_NUM_CHANNEL  8
+#define PCM_CHANNEL_NULL 0
+
+#define PCM_CHANNEL_FL    1	/* Front left channel. */
+#define PCM_CHANNEL_FR    2	/* Front right channel. */
+#define PCM_CHANNEL_FC    3	/* Front center channel. */
+#define PCM_CHANNEL_LS   4	/* Left surround channel. */
+#define PCM_CHANNEL_RS   5	/* Right surround channel. */
+#define PCM_CHANNEL_LFE  6	/* Low frequency effect channel. */
+#define PCM_CHANNEL_CS   7	/* Center surround channel; Rear center ch */
+#define PCM_CHANNEL_LB   8	/* Left back channel; Rear left channel. */
+#define PCM_CHANNEL_RB   9	/* Right back channel; Rear right channel. */
+#define PCM_CHANNELS   10	/* Top surround channel. */
+
+int q6dsp_map_channels(u8 ch_map[PCM_FORMAT_MAX_NUM_CHANNEL], int ch);
+
+#endif /* __Q6DSP_COMMON_H__ */
diff --git a/sound/soc/qcom/qdsp6/q6dsp-errno.h b/sound/soc/qcom/qdsp6/q6dsp-errno.h
new file mode 100644
index 000000000000..1ec00ff8c1d2
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-errno.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __Q6DSP_ERR_NO_H__
+#define __Q6DSP_ERR_NO_H__
+#include <linux/kernel.h>
+
+/* Success. The operation completed with no errors. */
+#define ADSP_EOK          0x00000000
+/* General failure. */
+#define ADSP_EFAILED      0x00000001
+/* Bad operation parameter. */
+#define ADSP_EBADPARAM    0x00000002
+/* Unsupported routine or operation. */
+#define ADSP_EUNSUPPORTED 0x00000003
+/* Unsupported version. */
+#define ADSP_EVERSION     0x00000004
+/* Unexpected problem encountered. */
+#define ADSP_EUNEXPECTED  0x00000005
+/* Unhandled problem occurred. */
+#define ADSP_EPANIC       0x00000006
+/* Unable to allocate resource. */
+#define ADSP_ENORESOURCE  0x00000007
+/* Invalid handle. */
+#define ADSP_EHANDLE      0x00000008
+/* Operation is already processed. */
+#define ADSP_EALREADY     0x00000009
+/* Operation is not ready to be processed. */
+#define ADSP_ENOTREADY    0x0000000A
+/* Operation is pending completion. */
+#define ADSP_EPENDING     0x0000000B
+/* Operation could not be accepted or processed. */
+#define ADSP_EBUSY        0x0000000C
+/* Operation aborted due to an error. */
+#define ADSP_EABORTED     0x0000000D
+/* Operation preempted by a higher priority. */
+#define ADSP_EPREEMPTED   0x0000000E
+/* Operation requests intervention to complete. */
+#define ADSP_ECONTINUE    0x0000000F
+/* Operation requests immediate intervention to complete. */
+#define ADSP_EIMMEDIATE   0x00000010
+/* Operation is not implemented. */
+#define ADSP_ENOTIMPL     0x00000011
+/* Operation needs more data or resources. */
+#define ADSP_ENEEDMORE    0x00000012
+/* Operation does not have memory. */
+#define ADSP_ENOMEMORY    0x00000014
+/* Item does not exist. */
+#define ADSP_ENOTEXIST    0x00000015
+/* Max count for adsp error code sent to HLOS*/
+
+#endif /*__Q6DSP_ERR_NO_H__ */
-- 
2.16.2
