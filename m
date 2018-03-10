Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648866; cv=none;
        d=google.com; s=arc-20160816;
        b=rLFFa4mfMBIzJlFEPyz00SpbUzUJouzj7+wThRI9q59/dyrFSVYNRKyPTUdSO12sjZ
         FtujcZX8On8GVLPYg6NlE1rma9Tzd8/HDgIklEqF3p+6oVU1KWWA8Zx0fyOl7lO5jKW3
         Es8z488dLrFNpV413zxVXg+F9z1xd0bcrwD1w/TS5Jo5FqTVKyL1YBgSH7i4qsTec0v/
         XHZs7peKhWSaZtZ8cl8yVGGjCqKit4aeq66luze4uw3xPhWiCWJO0s9lVyvZV/yhACRi
         rlvzPzlVXUn0qH2kULqR4H++jlmr/4DKrGGFy9OZsNkItR+RsSQsTZli49R4nVROW7tt
         0AUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=wBeB8vX6L3AY/WzQ4cZv+e9QJKsD/Nw83cRKht3kMCg=;
        b=X+lcLBTdYoK7tRUitIEiPiD5nI5X2Bpg4mZghoQMftiaa3HKBtXEY5Uf9cP495zw+g
         cjDBto2dBMUmr60sLl5XaL/FIFinWyoRShFAWMdFiDTw+rLUJ7QohO4LLStaT4yo+DVG
         z55oIKbfKlhogtAPgbeiJE3osYzcAYKg1BxVjoArQY7C62zBvpfCw5aVXgI4HoLev280
         Ft2h/vQNUV43kS5xZFPs9lII+kRsyrdyQczHSScDqHcmFCJ7ubgl4VGxGudwjUH82pRC
         0yk4TLhsDLmr0/MlXS8E1CfQNGojDiXLke6zxxpec4169UpVIa/EB0pe3Bff+ptuSXuV
         ZhOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TQ/YSvEj;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TQ/YSvEj;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsf02Yshww1fn25OYZDAQdFPR436Q7yIQenlb63wWF28aMVECy0GQ22MPpTg9eGS/fUE2PFmg==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	bgoswami@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	srinivas.kandagatla@linaro.org
Subject: [PATCH v4 03/24] ASoC: qdsp6: q6common: Add qdsp6 helper functions
Date: Sat, 10 Mar 2018 02:24:35 +0000
Message-Id: <20180310022456.26739-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515906093115033?=
X-GMAIL-MSGID: =?utf-8?q?1594515906093115033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds some common helper functions like translating dsp error
to linux error codes and channel mappings etc.

These functions are used in all the following qdsp6 drivers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig              | 13 ++++++++
 sound/soc/qcom/qdsp6/Makefile       |  1 +
 sound/soc/qcom/qdsp6/q6dsp-common.c | 66 +++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6dsp-common.h | 24 ++++++++++++++
 sound/soc/qcom/qdsp6/q6dsp-errno.h  | 51 ++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+)
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
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
new file mode 100644
index 000000000000..accebdb49306
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
diff --git a/sound/soc/qcom/qdsp6/q6dsp-common.c b/sound/soc/qcom/qdsp6/q6dsp-common.c
new file mode 100644
index 000000000000..c342a073144c
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-common.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation
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
index 000000000000..32386f4a6432
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-common.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
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
index 000000000000..6285e1782824
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-errno.h
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
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
2.15.1
