Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648887; cv=none;
        d=google.com; s=arc-20160816;
        b=I8CD3uCisYWGw5ayvjb8nWWmmcI95kjxBuX5oLFiUP7akLlZOZeSel6yhDvN5Vh7KC
         vnVtWGzbw/uRQIJbCeHEuV5jwisgHjds99+qXtIUmGqkIAIhPTXf77os7OTZwsToiFNw
         QZ9oCjb9k/ldYxUsutzNnYpdbGS7yKnLn48tSw+YCFIwcV2qW117xWFrQlVb5Y8sQyMO
         QHJKzFV8xJjZgB3NqwwHtTArjByd5QoztgvySFJun5IqnCLSSDeYn2fqadLK4i1bMjot
         chDZ11pgj4Kotw8V/si+PvstRTWaqMduKSh5+5lf/6XwL+1E7dJaBzBrZW2jOEzWzwHC
         qc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TOrjsuH4byN0Szd5SOIyyliA3CKWInNLqWJiNrmVeJc=;
        b=bZrScKV+wATkfzPL+HotBsIuhEqQMsxtyPytqA3QVjOrWkXIB6D+1Rz0IrvSwgVUNM
         jmhsBhtKelhcoB/1nC3TswSPvrjHJwvB4Pxao8DisQt+dJw7ag3Y49PEokFBNM3D6tBH
         IhwLHZQmjUnL1j24Hol6wZOcpDeJ1ksM+DnFQ/UhLFqVUOx6KSLriNUGwylMeTBRP6GD
         Nf+791w1xm4l/8iKXgn3jxQRIsPkKWgNFMJsUOVuvKe98rGjcbBf54cVmfVhk1shrxUe
         LE4X9yeIgUyacYsJhiEnRGfHbiB/Jt8B1EUgIwZ5qEEJ7nO7h0i9z0h59NkG/8Se62dA
         AnVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=W8rAoow/;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=W8rAoow/;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvQM07rozRfYxBViNLpIsaI4CX1io+DMXNKqXoYq26gHEFZSk/cN0s2+tZIQueDAjIYxSn8kg==
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
Subject: [PATCH v4 19/24] ASoC: qdsp6: q6afe: Add q6afe dai driver
Date: Sat, 10 Mar 2018 02:24:51 +0000
Message-Id: <20180310022456.26739-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515927178058728?=
X-GMAIL-MSGID: =?utf-8?q?1594515927178058728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to q6afe backend dais driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig           |   4 +
 sound/soc/qcom/qdsp6/Makefile    |   1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c | 746 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 751 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 7a868a6fac1b..9b630686eb19 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -50,6 +50,9 @@ config SND_SOC_QDSP6_COMMON
 config SND_SOC_QDSP6_AFE
 	tristate
 
+config SND_SOC_QDSP6_AFE_DAI
+	tristate
+
 config SND_SOC_QDSP6_ADM
 	tristate
 
@@ -67,6 +70,7 @@ config SND_SOC_QDSP6
 	depends on QCOM_APR && HAS_DMA
 	select SND_SOC_QDSP6_COMMON
 	select SND_SOC_QDSP6_AFE
+	select SND_SOC_QDSP6_AFE_DAI
 	select SND_SOC_QDSP6_ADM
 	select SND_SOC_QDSP6_ROUTING
 	select SND_SOC_QDSP6_ASM
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 6640bceccc18..6a8ae698f22f 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
+obj-$(CONFIG_SND_SOC_QDSP6_AFE_DAI) += q6afe-dai.o
 obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
 obj-$(CONFIG_SND_SOC_QDSP6_ROUTING) += q6routing.o
 obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
new file mode 100644
index 000000000000..5cb8b59a8cd9
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -0,0 +1,746 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2016, The Linux Foundation
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include "q6afe.h"
+
+struct q6afe_dai_priv_data {
+	uint32_t sd_line_mask;
+};
+
+struct q6afe_dai_data {
+	struct q6afe_port *port[AFE_PORT_MAX];
+	struct q6afe_port_config port_config[AFE_PORT_MAX];
+	bool is_port_started[AFE_PORT_MAX];
+	struct q6afe_dai_priv_data priv[AFE_PORT_MAX];
+};
+
+static int q6slim_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_slim_cfg *slim = &dai_data->port_config[dai->id].slim;
+
+	slim->num_channels = params_channels(params);
+	slim->sample_rate = params_rate(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_SPECIAL:
+		slim->bit_width = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		slim->bit_width = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		slim->bit_width = 32;
+		break;
+	default:
+		pr_err("%s: format %d\n",
+			__func__, params_format(params));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int channels = params_channels(params);
+	struct q6afe_hdmi_cfg *hdmi = &dai_data->port_config[dai->id].hdmi;
+
+	hdmi->sample_rate = params_rate(params);
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		hdmi->bit_width = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		hdmi->bit_width = 24;
+		break;
+	}
+
+	/* HDMI spec CEA-861-E: Table 28 Audio InfoFrame Data Byte 4 */
+	switch (channels) {
+	case 2:
+		hdmi->channel_allocation = 0;
+		break;
+	case 3:
+		hdmi->channel_allocation = 0x02;
+		break;
+	case 4:
+		hdmi->channel_allocation = 0x06;
+		break;
+	case 5:
+		hdmi->channel_allocation = 0x0A;
+		break;
+	case 6:
+		hdmi->channel_allocation = 0x0B;
+		break;
+	case 7:
+		hdmi->channel_allocation = 0x12;
+		break;
+	case 8:
+		hdmi->channel_allocation = 0x13;
+		break;
+	default:
+		dev_err(dai->dev, "invalid Channels = %u\n", channels);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int q6i2s_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_i2s_cfg *i2s = &dai_data->port_config[dai->id].i2s_cfg;
+
+	i2s->sample_rate = params_rate(params);
+	i2s->bit_width = params_width(params);
+	i2s->num_channels = params_channels(params);
+	i2s->sd_line_mask = dai_data->priv[dai->id].sd_line_mask;
+
+	return 0;
+}
+
+static int q6i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_i2s_cfg *i2s = &dai_data->port_config[dai->id].i2s_cfg;
+
+	i2s->fmt = fmt;
+
+	return 0;
+}
+
+static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int rc;
+
+	rc = q6afe_port_stop(dai_data->port[dai->id]);
+	if (rc < 0)
+		dev_err(dai->dev, "fail to close AFE port (%d)\n", rc);
+
+	dai_data->is_port_started[dai->id] = false;
+
+}
+
+static int q6afe_mi2s_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int rc;
+
+	if (dai_data->is_port_started[dai->id]) {
+		/* stop the port and restart with new port config */
+		rc = q6afe_port_stop(dai_data->port[dai->id]);
+		if (rc < 0) {
+			dev_err(dai->dev, "fail to close AFE port (%d)\n", rc);
+			return rc;
+		}
+	}
+
+	rc = q6afe_i2s_port_prepare(dai_data->port[dai->id],
+			       &dai_data->port_config[dai->id].i2s_cfg);
+	if (rc < 0) {
+		dev_err(dai->dev, "fail to prepare AFE port %x\n", dai->id);
+		return rc;
+	}
+
+	rc = q6afe_port_start(dai_data->port[dai->id]);
+	if (rc < 0) {
+		dev_err(dai->dev, "fail to start AFE port %x\n", dai->id);
+		return rc;
+	}
+	dai_data->is_port_started[dai->id] = true;
+
+	return 0;
+}
+
+static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int rc;
+
+	if (dai_data->is_port_started[dai->id]) {
+		/* stop the port and restart with new port config */
+		rc = q6afe_port_stop(dai_data->port[dai->id]);
+		if (rc < 0) {
+			dev_err(dai->dev, "fail to close AFE port (%d)\n", rc);
+			return rc;
+		}
+	}
+
+	if (dai->id == HDMI_RX)
+		q6afe_hdmi_port_prepare(dai_data->port[dai->id],
+					&dai_data->port_config[dai->id].hdmi);
+	else if (dai->id >= SLIMBUS_0_RX && dai->id <= SLIMBUS_6_TX)
+		q6afe_slim_port_prepare(dai_data->port[dai->id],
+					&dai_data->port_config[dai->id].slim);
+
+	rc = q6afe_port_start(dai_data->port[dai->id]);
+	if (rc < 0) {
+		dev_err(dai->dev, "fail to start AFE port %x\n", dai->id);
+		return rc;
+	}
+	dai_data->is_port_started[dai->id] = true;
+
+	return 0;
+}
+
+static int q6slim_set_channel_map(struct snd_soc_dai *dai,
+				unsigned int tx_num, unsigned int *tx_slot,
+				unsigned int rx_num, unsigned int *rx_slot)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_port_config *pcfg = &dai_data->port_config[dai->id];
+	int i;
+
+	if (!rx_slot) {
+		pr_err("%s: rx slot not found\n", __func__);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < rx_num; i++) {
+		pcfg->slim.ch_mapping[i] =   rx_slot[i];
+		pr_debug("%s: find number of channels[%d] ch[%d]\n",
+		       __func__, i, rx_slot[i]);
+	}
+
+	pcfg->slim.num_channels = rx_num;
+
+	pr_debug("%s: SLIMBUS_%d_RX cnt[%d] ch[%d %d]\n", __func__,
+		(dai->id - SLIMBUS_0_RX) / 2, rx_num,
+		pcfg->slim.ch_mapping[0],
+		pcfg->slim.ch_mapping[1]);
+
+	return 0;
+}
+
+static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_port *port = dai_data->port[dai->id];
+
+	switch (clk_id) {
+	case LPAIF_DIG_CLK:
+		return q6afe_port_set_sysclk(port, clk_id, 0, 5, freq, dir);
+	case LPAIF_BIT_CLK:
+	case LPAIF_OSR_CLK:
+		return q6afe_port_set_sysclk(port, clk_id,
+					     Q6AFE_LPASS_CLK_SRC_INTERNAL,
+					     Q6AFE_LPASS_CLK_ROOT_DEFAULT,
+					     freq, dir);
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
+	{"HDMI Playback", NULL, "HDMI_RX"},
+	{"Slimbus1 Playback", NULL, "SLIMBUS_1_RX"},
+	{"Slimbus2 Playback", NULL, "SLIMBUS_2_RX"},
+	{"Slimbus3 Playback", NULL, "SLIMBUS_3_RX"},
+	{"Slimbus4 Playback", NULL, "SLIMBUS_4_RX"},
+	{"Slimbus5 Playback", NULL, "SLIMBUS_5_RX"},
+	{"Slimbus6 Playback", NULL, "SLIMBUS_6_RX"},
+
+	{"Primary MI2S Playback", NULL, "PRI_MI2S_RX"},
+	{"Secondary MI2S Playback", NULL, "SEC_MI2S_RX"},
+	{"Tertiary MI2S Playback", NULL, "TERT_MI2S_RX"},
+	{"Quaternary MI2S Playback", NULL, "QUAT_MI2S_RX"},
+
+	{"TERT_MI2S_TX", NULL, "Tertiary MI2S Capture"},
+	{"PRI_MI2S_TX", NULL, "Primary MI2S Capture"},
+	{"SEC_MI2S_TX", NULL, "Secondary MI2S Capture"},
+	{"QUAT_MI2S_TX", NULL, "Quaternary MI2S Capture"},
+};
+
+static struct snd_soc_dai_ops q6hdmi_ops = {
+	.prepare	= q6afe_dai_prepare,
+	.hw_params	= q6hdmi_hw_params,
+	.shutdown	= q6afe_dai_shutdown,
+};
+
+static struct snd_soc_dai_ops q6i2s_ops = {
+	.prepare	= q6afe_mi2s_prepare,
+	.hw_params	= q6i2s_hw_params,
+	.set_fmt	= q6i2s_set_fmt,
+	.shutdown	= q6afe_dai_shutdown,
+	.set_sysclk	= q6afe_mi2s_set_sysclk,
+};
+
+static struct snd_soc_dai_ops q6slim_ops = {
+	.prepare	= q6afe_dai_prepare,
+	.hw_params	= q6slim_hw_params,
+	.shutdown	= q6afe_dai_shutdown,
+	.set_channel_map = q6slim_set_channel_map,
+};
+
+static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct snd_soc_dapm_context *dapm;
+	struct q6afe_port *port;
+
+	dapm = snd_soc_component_get_dapm(dai->component);
+
+	port = q6afe_port_get_from_id(dai->dev, dai->id);
+	if (IS_ERR(port)) {
+		dev_err(dai->dev, "Unable to get afe port\n");
+		return -EINVAL;
+	}
+	dai_data->port[dai->id] = port;
+
+	return 0;
+}
+
+static int msm_dai_q6_dai_remove(struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+
+	q6afe_port_put(dai_data->port[dai->id]);
+	dai_data->port[dai->id] = NULL;
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver q6afe_dais[] = {
+	{
+		.playback = {
+			.stream_name = "HDMI Playback",
+			.rates = SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_max =     192000,
+			.rate_min =	48000,
+		},
+		.ops = &q6hdmi_ops,
+		.id = HDMI_RX,
+		.name = "HDMI",
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.name = "SLIMBUS_0_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_0_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.playback = {
+			.stream_name = "Slimbus Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+	}, {
+		.playback = {
+			.stream_name = "Slimbus1 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_1_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_1_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus2 Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_2_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_2_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus3 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_3_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_3_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus4 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_4_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_4_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus5 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_5_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_5_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus6 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.ops = &q6slim_ops,
+		.name = "SLIMBUS_6_RX",
+		.id = SLIMBUS_6_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Primary MI2S Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.id = PRIMARY_MI2S_RX,
+		.name = "PRI_MI2S_RX",
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.capture = {
+			.stream_name = "Primary MI2S Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.id = PRIMARY_MI2S_TX,
+		.name = "PRI_MI2S_TX",
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Secondary MI2S Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.name = "SEC_MI2S_RX",
+		.id = SECONDARY_MI2S_RX,
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.capture = {
+			.stream_name = "Secondary MI2S Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.id = SECONDARY_MI2S_TX,
+		.name = "SEC_MI2S_TX",
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Tertiary MI2S Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.name = "TERT_MI2S_RX",
+		.id = TERTIARY_MI2S_RX,
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.capture = {
+			.stream_name = "Tertiary MI2S Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.id = TERTIARY_MI2S_TX,
+		.name = "TERT_MI2S_TX",
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Quaternary MI2S Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.name = "QUAT_MI2S_RX",
+		.id = QUATERNARY_MI2S_RX,
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.capture = {
+			.stream_name = "Quaternary MI2S Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.id = QUATERNARY_MI2S_TX,
+		.name = "QUAT_MI2S_TX",
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	},
+};
+
+static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
+				   struct of_phandle_args *args,
+				   const char **dai_name)
+{
+	int id = args->args[0];
+	int ret = -EINVAL;
+	int i;
+
+	for (i = 0; i  < ARRAY_SIZE(q6afe_dais); i++) {
+		if (q6afe_dais[i].id == id) {
+			*dai_name = q6afe_dais[i].name;
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT("HDMI_RX", "HDMI Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_0_RX", "Slimbus Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_1_RX", "Slimbus1 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_2_RX", "Slimbus2 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_3_RX", "Slimbus3 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_RX", "Slimbus4 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_RX", "Slimbus5 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_RX", "Slimbus6 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_RX", "Quaternary MI2S Playback",
+						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_TX", "Quaternary MI2S Capture",
+						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TERT_MI2S_RX", "Tertiary MI2S Playback",
+						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("TERT_MI2S_TX", "Tertiary MI2S Capture",
+						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_RX", "Secondary MI2S Playback",
+			     0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SEC_MI2S_TX", "Secondary MI2S Capture",
+						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_RX_SD1",
+			"Secondary MI2S Playback SD1",
+			0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("PRI_MI2S_RX", "Primary MI2S Playback",
+			     0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("PRI_MI2S_TX", "Primary MI2S Capture",
+						0, 0, 0, 0),
+};
+
+static const struct snd_soc_component_driver q6afe_dai_component = {
+	.name		= "q6afe-dai-component",
+	.dapm_widgets = q6afe_dai_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(q6afe_dai_widgets),
+	.dapm_routes = q6afe_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(q6afe_dapm_routes),
+	.of_xlate_dai_name = q6afe_of_xlate_dai_name,
+
+};
+
+static void of_q6afe_parse_dai_data(struct device *dev,
+				    struct q6afe_dai_data *data)
+{
+	struct device_node *node;
+	int ret;
+
+	for_each_child_of_node(dev->of_node, node) {
+		unsigned int lines[Q6AFE_MAX_MI2S_LINES];
+		struct q6afe_dai_priv_data *priv;
+		const char *if_type;
+		int id, i, num_lines;
+
+		ret = of_property_read_u32(node, "reg", &id);
+		if (ret || id > AFE_PORT_MAX) {
+			dev_err(dev, "valid dai id not found:%d\n", ret);
+			continue;
+		}
+
+		if (of_property_read_string(node, "interface-type", &if_type))
+			continue;
+
+		priv = &data->priv[id];
+
+		/* MI2S specific properties */
+		if (!strcmp(if_type, "mi2s")) {
+			ret = of_property_read_variable_u32_array(node,
+							"qcom,sd-lines", lines, 0,
+							Q6AFE_MAX_MI2S_LINES);
+			if (ret < 0)
+				num_lines = 0;
+			else
+				num_lines = ret;
+
+			priv->sd_line_mask = 0;
+
+			for (i = 0; i < num_lines; i++)
+				priv->sd_line_mask |= BIT(lines[i]);
+		}
+	}
+}
+
+static int q6afe_dai_bind(struct device *dev, struct device *master, void *data)
+{
+	struct q6afe_dai_data *dai_data;
+	int rc = 0;
+
+	dai_data = kzalloc(sizeof(*dai_data), GFP_KERNEL);
+	if (!dai_data)
+		rc = -ENOMEM;
+
+	dev_set_drvdata(dev, dai_data);
+
+	of_q6afe_parse_dai_data(dev, dai_data);
+
+	return snd_soc_register_component(dev, &q6afe_dai_component,
+					  q6afe_dais, ARRAY_SIZE(q6afe_dais));
+}
+
+static void q6afe_dai_unbind(struct device *dev, struct device *master,
+			     void *data)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dev);
+
+	snd_soc_unregister_component(dev);
+	kfree(dai_data);
+}
+
+static const struct component_ops q6afe_dai_comp_ops = {
+	.bind   = q6afe_dai_bind,
+	.unbind = q6afe_dai_unbind,
+};
+
+static int q6afe_dai_dev_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &q6afe_dai_comp_ops);
+}
+
+static int q6afe_dai_dev_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &q6afe_dai_comp_ops);
+	return 0;
+}
+
+static struct platform_driver q6afe_dai_platform_driver = {
+	.driver = {
+		.name = "q6afe-dai",
+	},
+	.probe = q6afe_dai_dev_probe,
+	.remove = q6afe_dai_dev_remove,
+};
+module_platform_driver(q6afe_dai_platform_driver);
+
+MODULE_DESCRIPTION("Q6 Audio Fronend dai driver");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1
