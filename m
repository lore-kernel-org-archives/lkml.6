Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176657; cv=none;
        d=google.com; s=arc-20160816;
        b=JCxVyV4XyWtOzWxsVQdYQSv5D1rtUwz+rYlDhusEurONLQX77e+t2NRZfDRocDuiPO
         VRECv3oqT0Ei1gpB9Y/5fp5MR7iimua5IhW3wFHiy8/odXlvNO8NOK4yHMU6Wjk+Y7p2
         jFQE426xOWsol1SIGIflRciY/dg2ZJ+hCM2dWq/90cA2J/frsouPlimLfBhp5bDIa7rY
         LiWE3LxmRGFhmTE6l0MHK7JsqNanJBdZ+CjAT0qKi8X2tFgLrm+oItHsNpLnbyM4G2mn
         rnxFte+HHXYouMrXSSW0pOuDhHs7xikOS+BXkdJyE+Hq1HvFi8t+VENUI0274/UZ/vf1
         mgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6f+Pi1xQMR7HkcRV+nF5QjdarlGC3lQ7sY0nYAKB0go=;
        b=zU0oNu2u0vHmLJmInemvFHjr23jSQJCpJhLseaDfqf8UJEgbi7caaldhdq10n/1naq
         HS81CftQUvRwBKXutNeEkOpEgDeiLsw+m46p4CXlsydG5w9Yxq8oeZzr3YSITmIQbhWw
         3JzCP5QBAJ004JSVDaUUTZx0g+UUF8E63XoF0Ute2Dk9cGAQUfURTGSpKmj0Y7v1kT0h
         ZTIO2TFJgfQh77y02ndPnjH0vQG0BxoY+6gyDOwgfCyf9YTsd0B2bjbDBrEGMkpdCxRX
         tB7B2EZzrmVE2cb4Zs7zlsZHjjlMWcF3ny9PhfHoULM3gp8F9/lSmiDM9+DFZ1k5aFJa
         47hA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=howCpHKz;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=howCpHKz;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpyt2vtSMQkcSAy3IvGe0Rxpa2sbYU/HEy9x3rddZn6xoB+nTVRjeqf8fk3Wr6/OEl+Nf4M3g==
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
Subject: [PATCH v7 23/24] ASoC: qcom: apq8096: Add db820c machine driver
Date: Tue,  1 May 2018 13:08:19 +0100
Message-Id: <20180501120820.11016-24-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263638421096230?=
X-GMAIL-MSGID: =?utf-8?q?1599263638421096230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to DB820c machine driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig   |   9 ++
 sound/soc/qcom/Makefile  |   2 +
 sound/soc/qcom/apq8096.c | 238 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)
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
index 000000000000..73abf862db94
--- /dev/null
+++ b/sound/soc/qcom/apq8096.c
@@ -0,0 +1,238 @@
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
+	struct device_node *np, *codec, *platform, *cpu, *node;
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
+	node = dev->of_node;
+
+	/* DAPM routes */
+	if (of_property_read_bool(node, "qcom,audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card,
+					"qcom,audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	/* Populate links */
+	num_links = of_get_child_count(node);
+
+	/* Allocate the DAI link array */
+	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links	= num_links;
+	link = card->dai_link;
+
+	for_each_child_of_node(node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+
+		if (!cpu) {
+			dev_err(dev, "Can't find cpu DT node\n");
+			return -EINVAL;
+		}
+
+		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!link->cpu_of_node) {
+			dev_err(card->dev, "error getting cpu phandle\n");
+			return -EINVAL;
+		}
+
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting cpu dai name\n");
+			return ret;
+		}
+
+		if (codec && platform) {
+			link->platform_of_node = of_parse_phandle(platform,
+								  "sound-dai",
+								   0);
+			if (!link->platform_of_node) {
+				dev_err(card->dev, "platform dai not found\n");
+				return -EINVAL;
+			}
+
+			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+			if (ret < 0) {
+				dev_err(card->dev, "codec dai not found\n");
+				return ret;
+			}
+			link->no_pcm = 1;
+			link->ignore_suspend = 1;
+			link->ignore_pmdown_time = 1;
+			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
+		} else {
+			link->platform_of_node = link->cpu_of_node;
+			link->codec_dai_name = "snd-soc-dummy-dai";
+			link->codec_name = "snd-soc-dummy";
+			link->dynamic = 1;
+		}
+
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			return ret;
+		}
+
+		link->dpcm_playback = 1;
+		link->dpcm_capture = 1;
+		link->stream_name = link->name;
+		link++;
+	}
+
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
+		component_unbind_all(dev, card);
+		return ret;
+	}
+
+	return snd_soc_register_card(card);
+}
+
+static void apq8096_unbind(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	component_unbind_all(dev, card);
+	snd_soc_unregister_card(card);
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
