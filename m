Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZpqCUPVCfPJoAQw5HBUmg8bei/rAefWnT+7EMleLPILKaop+0lSRmg23aNlRuvH5S0xT24W
ARC-Seal: i=1; a=rsa-sha256; t=1526008545; cv=none;
        d=google.com; s=arc-20160816;
        b=mfSZfJEm4XKbEU9iaf3yc7sIUBha2ql5Sp+/jYvbH0LVRDShQ62+KGkt032TX5s2nX
         Pq0nWNhOydJWCve1snBQc6hbAdEQMXqV+nO0Dxd63oRAGnW/rkBHIMzRcZ0aS7Ek+5BK
         4NpYOyQ2sggpgbmIb69iQpFi2QoT7VCvhMTVNWDedayNnak2SvaoakBW6gsutOK6w1jf
         XmUBb512SutAdsGJAKK3BhVhnUZDjJXaOGsnnPkyQersVireHgRkRu6zw5YG66TZIw77
         Y1Mau1aKF3PNAAyMuJvWo7RchzO8Z0bJyNiJVwOOQNqlZxSG8Tg/yTQiZGJkSX4nhdDJ
         fA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=S9g7tE+LCsil3ngjyLJAg5rpofNjwkRff/H8zE693Kg=;
        b=jQUN3L81J365xybZR3pdyEUNu0KEH6NEohv64ITd4rrtivUwg2PLAMHWjZ/NWkIZee
         2W8uuIw0j6j2IveIktxiOGPKKDIxvbSXQ7MLHDNdYr0cHRYo/rbnYQmukcNNaPjkknlJ
         zNk5kUcT/iWqzqUV+tJZeXIsSe+C4il+n9PTpz9D/9LCRCdn+j/MNOqrujzMvkyTSusG
         m+KYgQ1Cmfv2XJ/cHMejS956CYbaeVGMaugsBIxgptb2vrgFyXOClrY84iQEDFhqs4Qj
         6tX9i+2fNHEeBE3xErIErZe8krRCQyXV9Bnph9xQ1w6QR3sleGdj6qczt91gU3gowS25
         vmFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=BNjkjemx;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=BNjkjemx;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6common: Add qdsp6 helper functions" to the asoc tree
In-Reply-To: <20180501120820.11016-8-srinivas.kandagatla@linaro.org>
Message-Id: <20180511031526.825CE44007A@finisterre.ee.mobilebroadband>
Date: Fri, 11 May 2018 04:15:26 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600135936817301528?=
X-GMAIL-MSGID: =?utf-8?q?1600135936817301528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: q6common: Add qdsp6 helper functions

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

>From 4dddbddbce324dc027182ba33d6cbbaf797dfd9e Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 May 2018 13:56:18 +0100
Subject: [PATCH] ASoC: qdsp6: q6common: Add qdsp6 helper functions

This patch adds some common helper functions like translating dsp error
to linux error codes and channel mappings etc.

These functions are used in all the following qdsp6 drivers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig              | 13 ++++++
 sound/soc/qcom/Makefile             |  3 ++
 sound/soc/qcom/qdsp6/Makefile       |  1 +
 sound/soc/qcom/qdsp6/q6dsp-common.c | 66 +++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6dsp-common.h | 24 +++++++++++
 sound/soc/qcom/qdsp6/q6dsp-errno.h  | 51 ++++++++++++++++++++++
 6 files changed, 158 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/Makefile
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 3cc252e55468..b44a9fcd7ed3 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -40,3 +40,16 @@ config SND_SOC_APQ8016_SBC
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
index 000000000000..d393003492c7
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
+int q6dsp_map_channels(u8 ch_map[PCM_MAX_NUM_CHANNEL], int ch)
+{
+	memset(ch_map, 0, PCM_MAX_NUM_CHANNEL);
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
index 000000000000..01094d108b8a
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
+#define PCM_MAX_NUM_CHANNEL  8
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
+int q6dsp_map_channels(u8 ch_map[PCM_MAX_NUM_CHANNEL], int ch);
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
2.17.0
