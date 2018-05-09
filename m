Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870864; cv=none;
        d=google.com; s=arc-20160816;
        b=weY+omc8RvYdz9kJC3lu1iPIDYjWsaMFggg7Bc3dkB3QnwMPuAf3FLixMCZ4+tLa0G
         LzL8htIBX6R8aGce8dauid8QuFsvVt3MN5sfQR5Ocz69VAmCj8d61OJ4oYubgRCdpx5E
         xFMZIWOx2JK614a8afS0uTeTvcNwQiFPGS5XFF7A74mV9Je/87+j/Ri7A+0Im6P0A+Xt
         xJAL3xiHdeNVPWEfeJ36moiPBdx/YC0Y1hdbK09uDE9UpgXdWFfYpeFitCIyL47Xjh1m
         cHCxJDPRxTSU9Ff17+C4KMfXuZo4By+LJjnQixkMgk+Zq3iWTGi4PrlFtqzrcsj/tXgV
         pSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=wfEIW5AIMBO8SFKDTYxtILtgWdRSASEPNOwZFU2ZK0M=;
        b=Rru6rL/ht1rbtbVeXA5y21KfnkmFiwYiIO7js1oXzLlYWVR8vZT+W1+nwAWcj50ljv
         7hfXShjjDVe+KYaGmnux57x4Q9D7fnLyZcAP+CUWN3j21jzyq8f3t0T22GUsiuLMHt9g
         VuLlk2lm5b2X0euFTrMZCoaZ/UpqJpWOAzMkyc27HieoqTxYQrdjqfOghTImjX6V9OlN
         b2bzK1SuztRylzqsMjBMyWGcaDLwqWHB4WgM4MtdNwr7u6vhqRLqpbVTGDYgRyfOT464
         mtLe6S7EBhgLsdDMU6O3fS/6t51TQggDJ4O0j/fdffCfy5Q8Yc4b2z7w4Nf4Dly3u+hC
         RP0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WX3RX3Qx;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WX3RX3Qx;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqjg2GFOGoovy/2INW1NkloA2/QWOrMOm8QsY6IB6xWkVB8ZUigLmLbmnfgjN0yj4d1W9xurg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
Subject: [PATCH v8 17/24] ASoC: qdsp6: q6routing: Add q6routing driver
Date: Wed,  9 May 2018 13:56:28 +0100
Message-Id: <20180509125635.5653-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991566974422422?=
X-GMAIL-MSGID: =?utf-8?q?1599991566974422422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to q6 routing driver which configures route
between ASM and AFE module using ADM apis.

This driver uses dapm widgets to setup the matrix between AFE ports and
ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/Kconfig           |   4 +
 sound/soc/qcom/qdsp6/Makefile    |   1 +
 sound/soc/qcom/qdsp6/q6routing.c | 392 +++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6routing.h |   9 +
 4 files changed, 406 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 941774abd94f..43f9ed85efa8 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -53,6 +53,9 @@ config SND_SOC_QDSP6_AFE
 config SND_SOC_QDSP6_ADM
 	tristate
 
+config SND_SOC_QDSP6_ROUTING
+	tristate
+
 config SND_SOC_QDSP6_ASM
 	tristate
 
@@ -63,6 +66,7 @@ config SND_SOC_QDSP6
 	select SND_SOC_QDSP6_CORE
 	select SND_SOC_QDSP6_AFE
 	select SND_SOC_QDSP6_ADM
+	select SND_SOC_QDSP6_ROUTING
 	select SND_SOC_QDSP6_ASM
 	help
 	 To add support for MSM QDSP6 Soc Audio.
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 01d9dcf3375c..0e8e2febb7ec 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
+obj-$(CONFIG_SND_SOC_QDSP6_ROUTING) += q6routing.o
 obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
new file mode 100644
index 000000000000..f7ee9a1a29b2
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/bitops.h>
+#include <linux/component.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/control.h>
+#include <sound/asound.h>
+#include <sound/pcm_params.h>
+#include "q6afe.h"
+#include "q6asm.h"
+#include "q6adm.h"
+#include "q6routing.h"
+
+#define DRV_NAME "q6routing-component"
+
+struct session_data {
+	int state;
+	int port_id;
+	int path_type;
+	int app_type;
+	int acdb_id;
+	int sample_rate;
+	int bits_per_sample;
+	int channels;
+	int perf_mode;
+	int numcopps;
+	int fedai_id;
+	unsigned long copp_map;
+};
+
+struct msm_routing_data {
+	struct session_data sessions[MAX_SESSIONS];
+	struct session_data port_data[AFE_MAX_PORTS];
+	struct device *dev;
+	struct mutex lock;
+};
+
+static struct msm_routing_data *routing_data;
+
+/**
+ * q6routing_stream_open() - Register a new stream for route setup
+ *
+ * @fedai_id: Frontend dai id.
+ * @perf_mode: Performance mode.
+ * @stream_id: ASM stream id to map.
+ * @stream_type: Direction of stream
+ *
+ * Return: Will be an negative on error or a zero on success.
+ */
+int q6routing_stream_open(int fedai_id, int perf_mode,
+			   int stream_id, int stream_type)
+{
+	int j, topology, num_copps = 0;
+	struct route_payload payload;
+	int copp_idx;
+	struct session_data *session, *pdata;
+
+	if (!routing_data) {
+		pr_err("Routing driver not yet ready\n");
+		return -EINVAL;
+	}
+
+	session = &routing_data->sessions[stream_id - 1];
+	pdata = &routing_data->port_data[session->port_id];
+
+	mutex_lock(&routing_data->lock);
+	session->fedai_id = fedai_id;
+
+	session->path_type = pdata->path_type;
+	session->sample_rate = pdata->sample_rate;
+	session->channels = pdata->channels;
+	session->bits_per_sample = pdata->bits_per_sample;
+
+	payload.num_copps = 0; /* only RX needs to use payload */
+	topology = NULL_COPP_TOPOLOGY;
+	copp_idx = q6adm_open(routing_data->dev, session->port_id,
+			      session->path_type, session->sample_rate,
+			      session->channels, topology, perf_mode,
+			      session->bits_per_sample, 0, 0);
+
+	if (copp_idx < 0) {
+		mutex_unlock(&routing_data->lock);
+		return -EINVAL;
+	}
+
+	set_bit(copp_idx, &session->copp_map);
+
+	for_each_set_bit(j, &session->copp_map, MAX_COPPS_PER_PORT) {
+		payload.port_id[num_copps] = session->port_id;
+		payload.copp_idx[num_copps] = j;
+		num_copps++;
+	}
+
+	if (num_copps) {
+		payload.num_copps = num_copps;
+		payload.session_id = stream_id;
+		q6adm_matrix_map(routing_data->dev, session->path_type,
+				 payload, perf_mode);
+	}
+	mutex_unlock(&routing_data->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6routing_stream_open);
+
+static struct session_data *get_session_from_id(struct msm_routing_data *data,
+						int fedai_id)
+{
+	int i;
+
+	for (i = 0; i < MAX_SESSIONS; i++) {
+		if (fedai_id == data->sessions[i].fedai_id)
+			return &data->sessions[i];
+	}
+
+	return NULL;
+}
+/**
+ * q6routing_stream_close() - Deregister a stream
+ *
+ * @fedai_id: Frontend dai id.
+ * @stream_type: Direction of stream
+ *
+ * Return: Will be an negative on error or a zero on success.
+ */
+void q6routing_stream_close(int fedai_id, int stream_type)
+{
+	struct session_data *session;
+	int idx;
+
+	session = get_session_from_id(routing_data, fedai_id);
+	if (!session)
+		return;
+
+	for_each_set_bit(idx, &session->copp_map, MAX_COPPS_PER_PORT)
+		q6adm_close(routing_data->dev, session->port_id, idx);
+
+	session->fedai_id = -1;
+	session->copp_map = 0;
+}
+EXPORT_SYMBOL_GPL(q6routing_stream_close);
+
+static int msm_routing_get_audio_mixer(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm =
+	    snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	int session_id = mc->shift;
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
+	struct msm_routing_data *priv = dev_get_drvdata(c->dev);
+	struct session_data *session = &priv->sessions[session_id];
+
+	if (session->port_id == mc->reg)
+		ucontrol->value.integer.value[0] = 1;
+	else
+		ucontrol->value.integer.value[0] = 0;
+
+	return 0;
+}
+
+static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm =
+				    snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
+	struct msm_routing_data *data = dev_get_drvdata(c->dev);
+	struct soc_mixer_control *mc =
+		    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_dapm_update *update = NULL;
+	int be_id = mc->reg;
+	int session_id = mc->shift;
+	struct session_data *session = &data->sessions[session_id];
+
+	if (ucontrol->value.integer.value[0]) {
+		session->port_id = be_id;
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, update);
+	} else {
+		session->port_id = -1;
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, update);
+	}
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+};
+
+static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
+	/* Frontend AIF */
+	SND_SOC_DAPM_AIF_IN("MM_DL1", "MultiMedia1 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL2", "MultiMedia2 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL3", "MultiMedia3 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL4", "MultiMedia4 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL5", "MultiMedia5 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL6", "MultiMedia6 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL7", "MultiMedia7 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL8", "MultiMedia8 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL1", "MultiMedia1 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL2", "MultiMedia2 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL3", "MultiMedia3 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL4", "MultiMedia4 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL5", "MultiMedia5 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL6", "MultiMedia6 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL7", "MultiMedia7 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL8", "MultiMedia8 Capture", 0, 0, 0, 0),
+
+	/* Mixer definitions */
+	SND_SOC_DAPM_MIXER("HDMI Mixer", SND_SOC_NOPM, 0, 0,
+			   hdmi_mixer_controls,
+			   ARRAY_SIZE(hdmi_mixer_controls)),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"HDMI Mixer", "MultiMedia1", "MM_DL1"},
+	{"HDMI Mixer", "MultiMedia2", "MM_DL2"},
+	{"HDMI Mixer", "MultiMedia3", "MM_DL3"},
+	{"HDMI Mixer", "MultiMedia4", "MM_DL4"},
+	{"HDMI Mixer", "MultiMedia5", "MM_DL5"},
+	{"HDMI Mixer", "MultiMedia6", "MM_DL6"},
+	{"HDMI Mixer", "MultiMedia7", "MM_DL7"},
+	{"HDMI Mixer", "MultiMedia8", "MM_DL8"},
+	{"HDMI_RX", NULL, "HDMI Mixer"},
+};
+
+static int routing_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct msm_routing_data *data = dev_get_drvdata(c->dev);
+	unsigned int be_id = rtd->cpu_dai->id;
+	struct session_data *session;
+	int path_type;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		path_type = ADM_PATH_PLAYBACK;
+	else
+		path_type = ADM_PATH_LIVE_REC;
+
+	if (be_id > AFE_MAX_PORTS)
+		return -EINVAL;
+
+	session = &data->port_data[be_id];
+
+	mutex_lock(&data->lock);
+
+	session->path_type = path_type;
+	session->sample_rate = params_rate(params);
+	session->channels = params_channels(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+			session->bits_per_sample = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+			session->bits_per_sample = 24;
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
+static struct snd_pcm_ops q6pcm_routing_ops = {
+	.hw_params = routing_hw_params,
+};
+
+static int msm_routing_probe(struct snd_soc_component *c)
+{
+	int i;
+
+	for (i = 0; i < MAX_SESSIONS; i++)
+		routing_data->sessions[i].port_id = -1;
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver msm_soc_routing_component = {
+	.ops = &q6pcm_routing_ops,
+	.probe = msm_routing_probe,
+	.name = DRV_NAME,
+	.dapm_widgets = msm_qdsp6_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(msm_qdsp6_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
+};
+
+static int q6routing_dai_bind(struct device *dev, struct device *master,
+			      void *data)
+{
+	routing_data = kzalloc(sizeof(*routing_data), GFP_KERNEL);
+	if (!routing_data)
+		return -ENOMEM;
+
+	routing_data->dev = dev;
+
+	mutex_init(&routing_data->lock);
+	dev_set_drvdata(dev, routing_data);
+
+	return snd_soc_register_component(dev, &msm_soc_routing_component,
+					  NULL, 0);
+}
+
+static void q6routing_dai_unbind(struct device *dev, struct device *master,
+				 void *d)
+{
+	struct msm_routing_data *data = dev_get_drvdata(dev);
+
+	snd_soc_unregister_component(dev);
+
+	kfree(data);
+
+	routing_data = NULL;
+}
+
+static const struct component_ops q6routing_dai_comp_ops = {
+	.bind   = q6routing_dai_bind,
+	.unbind = q6routing_dai_unbind,
+};
+
+static int q6pcm_routing_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &q6routing_dai_comp_ops);
+}
+
+static int q6pcm_routing_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &q6routing_dai_comp_ops);
+	return 0;
+}
+
+static struct platform_driver q6pcm_routing_platform_driver = {
+	.driver = {
+		.name = "q6routing",
+	},
+	.probe = q6pcm_routing_probe,
+	.remove = q6pcm_routing_remove,
+};
+module_platform_driver(q6pcm_routing_platform_driver);
+
+MODULE_DESCRIPTION("Q6 Routing platform");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6routing.h b/sound/soc/qcom/qdsp6/q6routing.h
new file mode 100644
index 000000000000..35514e651130
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6routing.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _Q6_PCM_ROUTING_H
+#define _Q6_PCM_ROUTING_H
+
+int q6routing_stream_open(int fedai_id, int perf_mode,
+			   int stream_id, int stream_type);
+void q6routing_stream_close(int fedai_id, int stream_type);
+
+#endif /*_Q6_PCM_ROUTING_H */
-- 
2.16.2
