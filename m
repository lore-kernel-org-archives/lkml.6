Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526648336; cv=none;
        d=google.com; s=arc-20160816;
        b=PODamQPRExcLcg9q4ZjJUsDMZFkPs6h4DUYaKCs0TeO6bPhcQPOnTocUI9hRlQH+3m
         5UAtinmPBKzMD+jg6N2kFehPmpl39cbePLWU2YrWuezide2leWkxas+maZNP1uxXHx5J
         FniBNgj9APH0CoW1wcvZB3hGzcj6fMs+3f7GT+LJzHcDK+4fCVwPjXQtAG5sdrzTFqG7
         xcAtHF/Piy8FdTUUCI7qW21X30SzB2vHXGEyDO2dLOX/IymIfMLT/sgR/blxm744Tn6c
         gyQ3/mRbmoAFBDxi/8GfvbrZsG31UD81KOGMl52pqHywT+sZW7VdQG8uoMpMMaOUP/06
         OQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uHDANnwKRCQYe/vXiaw+Vr+9LLesAapc457Ky6dGrxg=;
        b=eyOt39YVqs6uarF2GS04yWnnDlsnaxN79tkgLeOnBDNFuTD1/C7V9aSP1HjFHzmy6y
         JwGa5iCtCB8cxNyvan4bdh5W591Vi8oikFkiu4khuQJnPTks3HRyvFi0FBqvoO/Ugyzq
         lBiA3/zZtScYIYsTJsA+W12hO9WBZCylLERsFjQlAfcs6udMq9onLOojJS5NVnnM0Dr2
         QmOnDEM+Bf+eoWIKYvn5FSrsnPdUa4VFnSKuNbUkIpdgSMOMnKps9dpt4qVBHBSwPdl3
         ARo4V7cg/ow2lqRo1GAqYWL4hXs1w6DgWxNz7dub5X+2oPeqF6VbmnHPct7ZNmAXXgdC
         nsBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JE43rFob;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JE43rFob;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqSPBBXbfKUrNg1HbKzi61ck7G6rMlJauLi+URMV0Ve3YSrqE1D8TWXLPJvt5LWq2JveWFSAg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org
Cc: robh+dt@kernel.org,
	gregkh@linuxfoundation.org,
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
Subject: [PATCH v9 15/15] ASoC: qcom: apq8096: Add db820c machine driver
Date: Fri, 18 May 2018 13:56:10 +0100
Message-Id: <20180518125610.26200-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
References: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600806805846351162?=
X-GMAIL-MSGID: =?utf-8?q?1600806805846351162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to DB820c machine driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/Kconfig   |   9 ++
 sound/soc/qcom/Makefile  |   2 +
 sound/soc/qcom/apq8096.c | 255 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 sound/soc/qcom/apq8096.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 85bb7dd11fd9..87838fa27997 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -81,3 +81,12 @@ config SND_SOC_QDSP6
 	 This will enable sound soc platform specific
 	 audio drivers. This includes q6asm, q6adm,
 	 q6afe interfaces to DSP using apr.
+
+config SND_SOC_MSM8996
+	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
+	depends on QCOM_APR
+	select SND_SOC_QDSP6
+	help
+          Support for Qualcomm Technologies LPASS audio block in
+          APQ8096 SoC-based systems.
+          Say Y if you want to use audio device on this SoCs
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 0276717917c0..206945bb9ba1 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -13,9 +13,11 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 # Machine
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
+snd-soc-apq8096-objs := apq8096.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
+obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
 
 #DSP lib
 obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
new file mode 100644
index 000000000000..561cd429e6f2
--- /dev/null
+++ b/sound/soc/qcom/apq8096.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/soc/qcom/apr.h>
+#include <linux/module.h>
+#include <linux/component.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+
+static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	return 0;
+}
+
+static int apq8096_sbc_parse_of(struct snd_soc_card *card)
+{
+	struct device_node *np;
+	struct device_node *codec = NULL;
+	struct device_node *platform = NULL;
+	struct device_node *cpu = NULL;
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *link;
+	int ret, num_links;
+
+	ret = snd_soc_of_parse_card_name(card, "qcom,model");
+	if (ret) {
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+		return ret;
+	}
+
+	/* DAPM routes */
+	if (of_property_read_bool(dev->of_node, "qcom,audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card,
+					"qcom,audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	/* Populate links */
+	num_links = of_get_child_count(dev->of_node);
+
+	/* Allocate the DAI link array */
+	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links	= num_links;
+	link = card->dai_link;
+
+	for_each_child_of_node(dev->of_node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		if (!cpu) {
+			dev_err(dev, "Can't find cpu DT node\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!link->cpu_of_node) {
+			dev_err(card->dev, "error getting cpu phandle\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting cpu dai name\n");
+			goto err;
+		}
+
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+		if (codec && platform) {
+			link->platform_of_node = of_parse_phandle(platform,
+								  "sound-dai",
+								   0);
+			if (!link->platform_of_node) {
+				dev_err(card->dev, "platform dai not found\n");
+				ret = -EINVAL;
+				goto err;
+			}
+
+			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+			if (ret < 0) {
+				dev_err(card->dev, "codec dai not found\n");
+				goto err;
+			}
+			link->no_pcm = 1;
+			link->ignore_pmdown_time = 1;
+			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
+		} else {
+			link->platform_of_node = link->cpu_of_node;
+			link->codec_dai_name = "snd-soc-dummy-dai";
+			link->codec_name = "snd-soc-dummy";
+			link->dynamic = 1;
+		}
+
+		link->ignore_suspend = 1;
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			goto err;
+		}
+
+		link->dpcm_playback = 1;
+		link->dpcm_capture = 1;
+		link->stream_name = link->name;
+		link++;
+	}
+
+	return 0;
+err:
+	of_node_put(cpu);
+	of_node_put(codec);
+	of_node_put(platform);
+	kfree(card->dai_link);
+	return ret;
+}
+
+static int apq8096_bind(struct device *dev)
+{
+	struct snd_soc_card *card;
+	int ret;
+
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	component_bind_all(dev, card);
+	card->dev = dev;
+	ret = apq8096_sbc_parse_of(card);
+	if (ret) {
+		dev_err(dev, "Error parsing OF data\n");
+		goto err;
+	}
+
+	ret = snd_soc_register_card(card);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	component_unbind_all(dev, card);
+	kfree(card);
+	return ret;
+}
+
+static void apq8096_unbind(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	snd_soc_unregister_card(card);
+	component_unbind_all(dev, card);
+	kfree(card->dai_link);
+	kfree(card);
+}
+
+static const struct component_master_ops apq8096_ops = {
+	.bind = apq8096_bind,
+	.unbind = apq8096_unbind,
+};
+
+static int apq8016_compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static void apq8016_release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
+static int add_audio_components(struct device *dev,
+				struct component_match **matchptr)
+{
+	struct device_node *np, *platform, *cpu, *node, *dai_node;
+
+	node = dev->of_node;
+
+	for_each_child_of_node(node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		if (cpu) {
+			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
+			of_node_get(dai_node);
+			component_match_add_release(dev, matchptr,
+						    apq8016_release_of,
+						    apq8016_compare_of,
+						    dai_node);
+		}
+
+		platform = of_get_child_by_name(np, "platform");
+		if (platform) {
+			dai_node = of_parse_phandle(platform, "sound-dai", 0);
+			component_match_add_release(dev, matchptr,
+						    apq8016_release_of,
+						    apq8016_compare_of,
+						    dai_node);
+		}
+	}
+
+	return 0;
+}
+
+static int apq8096_platform_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+	int ret;
+
+	ret = add_audio_components(&pdev->dev, &match);
+	if (ret)
+		return ret;
+
+	return component_master_add_with_match(&pdev->dev, &apq8096_ops, match);
+}
+
+static int apq8096_platform_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &apq8096_ops);
+
+	return 0;
+}
+
+static const struct of_device_id msm_snd_apq8096_dt_match[] = {
+	{.compatible = "qcom,apq8096-sndcard"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, msm_snd_apq8096_dt_match);
+
+static struct platform_driver msm_snd_apq8096_driver = {
+	.probe  = apq8096_platform_probe,
+	.remove = apq8096_platform_remove,
+	.driver = {
+		.name = "msm-snd-apq8096",
+		.owner = THIS_MODULE,
+		.of_match_table = msm_snd_apq8096_dt_match,
+	},
+};
+module_platform_driver(msm_snd_apq8096_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("APQ8096 ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.16.2
