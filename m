Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF492084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cbJeclvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF492084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbeGTRdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:33:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58854 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbeGTRdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NsUclS4k88D/l+q1KZSPx2Gmn8EtUDMcopRhvPULvvE=; b=cbJeclvf6ZU2
        6GAs/C1+ciHBKvBUBn+vG3bWhBkV/Yoetcxgmk/hEGNcGrmm+eENKycyMDCdsf0qUIG9a3+nSADnD
        IwBfayY/eoD3SI+bZA+JG3uMMToW4uUx/IEPjqycdbSeIYBlfh4O9V9EkDUPFmG8AkyNRA5SsPJvW
        kx8m8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYW7-00005m-Mv; Fri, 20 Jul 2018 16:44:31 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYW7-0000x8-8Q; Fri, 20 Jul 2018 17:44:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add tdm formatter base driver" to the asoc tree
In-Reply-To:  <20180717153643.8806-13-jbrunet@baylibre.com>
Message-Id: <E1fgYW7-0000x8-8Q@debutante>
Date:   Fri, 20 Jul 2018 17:44:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add tdm formatter base driver

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

From 1a11d88f499ceb69e9b4098ddc36866820335a54 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:42:58 +0200
Subject: [PATCH] ASoC: meson: add tdm formatter base driver

Add Amlogic's axg TDM core driver. On this SoC, tdm is bit more
complex than usual, mainly because the different TDM input decoders can
be attached to any of TDM pad interface, including the output pads.

For the this, TDM on this SoC is modeled like this:
- TDM interface provides the DAIs the codecs will be attached to.
  The main responsibility of this driver is to manage the pad format
  and the TDM clock rates.
- TDM Formatters: These are the entities which are actually dealing with
  the TDM signal. TDMOUT produce a TDM signal from the audio sample
  provided by FRDDR using the clocks provided the TDM interface. TDMIN
  feeds TODDR with audio sample using the clocks and TDM signal provided
  by the TDM Interface.
- TDM Streams: This provides the link between 1 DAI stream of the TDM
  interface and one (or more) TDM formatters.

This driver provides the TDM formatter and TDM stream operations.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig             |   4 +
 sound/soc/meson/Makefile            |   2 +
 sound/soc/meson/axg-tdm-formatter.c | 381 ++++++++++++++++++++++++++++
 sound/soc/meson/axg-tdm-formatter.h |  39 +++
 sound/soc/meson/axg-tdm.h           |  74 ++++++
 5 files changed, 500 insertions(+)
 create mode 100644 sound/soc/meson/axg-tdm-formatter.c
 create mode 100644 sound/soc/meson/axg-tdm-formatter.h
 create mode 100644 sound/soc/meson/axg-tdm.h

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 9408214b5854..80a88689491f 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -19,6 +19,10 @@ config SND_MESON_AXG_TODDR
 	  Select Y or M to add support for the frontend capture interfaces
 	  embedded in the Amlogic AXG SoC family
 
+config SND_MESON_AXG_TDM_FORMATTER
+	tristate
+	select REGMAP_MMIO
+
 config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
 	imply SND_SOC_SPDIF
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index d51ae045ef08..a06b56a1c995 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -3,9 +3,11 @@
 snd-soc-meson-axg-fifo-objs := axg-fifo.o
 snd-soc-meson-axg-frddr-objs := axg-frddr.o
 snd-soc-meson-axg-toddr-objs := axg-toddr.o
+snd-soc-meson-axg-tdm-formatter-objs := axg-tdm-formatter.o
 snd-soc-meson-axg-spdifout-objs := axg-spdifout.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
 obj-$(CONFIG_SND_MESON_AXG_FRDDR) += snd-soc-meson-axg-frddr.o
 obj-$(CONFIG_SND_MESON_AXG_TODDR) += snd-soc-meson-axg-toddr.o
+obj-$(CONFIG_SND_MESON_AXG_TDM_FORMATTER) += snd-soc-meson-axg-tdm-formatter.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFOUT) += snd-soc-meson-axg-spdifout.o
diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
new file mode 100644
index 000000000000..43e390f9358a
--- /dev/null
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+
+#include "axg-tdm-formatter.h"
+
+struct axg_tdm_formatter {
+	struct list_head list;
+	struct axg_tdm_stream *stream;
+	const struct axg_tdm_formatter_driver *drv;
+	struct clk *pclk;
+	struct clk *sclk;
+	struct clk *lrclk;
+	struct clk *sclk_sel;
+	struct clk *lrclk_sel;
+	bool enabled;
+	struct regmap *map;
+};
+
+int axg_tdm_formatter_set_channel_masks(struct regmap *map,
+					struct axg_tdm_stream *ts,
+					unsigned int offset)
+{
+	unsigned int val, ch = ts->channels;
+	unsigned long mask;
+	int i, j;
+
+	/*
+	 * Distribute the channels of the stream over the available slots
+	 * of each TDM lane
+	 */
+	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
+		val = 0;
+		mask = ts->mask[i];
+
+		for (j = find_first_bit(&mask, 32);
+		     (j < 32) && ch;
+		     j = find_next_bit(&mask, 32, j + 1)) {
+			val |= 1 << j;
+			ch -= 1;
+		}
+
+		regmap_write(map, offset, val);
+		offset += regmap_get_reg_stride(map);
+	}
+
+	/*
+	 * If we still have channel left at the end of the process, it means
+	 * the stream has more channels than we can accommodate and we should
+	 * have caught this earlier.
+	 */
+	if (WARN_ON(ch != 0)) {
+		pr_err("channel mask error\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
+
+static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
+{
+	struct axg_tdm_stream *ts = formatter->stream;
+	bool invert = formatter->drv->invert_sclk;
+	int ret;
+
+	/* Do nothing if the formatter is already enabled */
+	if (formatter->enabled)
+		return 0;
+
+	/*
+	 * If sclk is inverted, invert it back and provide the inversion
+	 * required by the formatter
+	 */
+	invert ^= axg_tdm_sclk_invert(ts->iface->fmt);
+	ret = clk_set_phase(formatter->sclk, invert ? 180 : 0);
+	if (ret)
+		return ret;
+
+	/* Setup the stream parameter in the formatter */
+	ret = formatter->drv->ops->prepare(formatter->map, formatter->stream);
+	if (ret)
+		return ret;
+
+	/* Enable the signal clocks feeding the formatter */
+	ret = clk_prepare_enable(formatter->sclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(formatter->lrclk);
+	if (ret) {
+		clk_disable_unprepare(formatter->sclk);
+		return ret;
+	}
+
+	/* Finally, actually enable the formatter */
+	formatter->drv->ops->enable(formatter->map);
+	formatter->enabled = true;
+
+	return 0;
+}
+
+static void axg_tdm_formatter_disable(struct axg_tdm_formatter *formatter)
+{
+	/* Do nothing if the formatter is already disabled */
+	if (!formatter->enabled)
+		return;
+
+	formatter->drv->ops->disable(formatter->map);
+	clk_disable_unprepare(formatter->lrclk);
+	clk_disable_unprepare(formatter->sclk);
+	formatter->enabled = false;
+}
+
+static int axg_tdm_formatter_attach(struct axg_tdm_formatter *formatter)
+{
+	struct axg_tdm_stream *ts = formatter->stream;
+	int ret = 0;
+
+	mutex_lock(&ts->lock);
+
+	/* Catch up if the stream is already running when we attach */
+	if (ts->ready) {
+		ret = axg_tdm_formatter_enable(formatter);
+		if (ret) {
+			pr_err("failed to enable formatter\n");
+			goto out;
+		}
+	}
+
+	list_add_tail(&formatter->list, &ts->formatter_list);
+out:
+	mutex_unlock(&ts->lock);
+	return ret;
+}
+
+static void axg_tdm_formatter_dettach(struct axg_tdm_formatter *formatter)
+{
+	struct axg_tdm_stream *ts = formatter->stream;
+
+	mutex_lock(&ts->lock);
+	list_del(&formatter->list);
+	mutex_unlock(&ts->lock);
+
+	axg_tdm_formatter_disable(formatter);
+}
+
+static int axg_tdm_formatter_power_up(struct axg_tdm_formatter *formatter,
+				      struct snd_soc_dapm_widget *w)
+{
+	struct axg_tdm_stream *ts = formatter->drv->ops->get_stream(w);
+	int ret;
+
+	/*
+	 * If we don't get a stream at this stage, it would mean that the
+	 * widget is powering up but is not attached to any backend DAI.
+	 * It should not happen, ever !
+	 */
+	if (WARN_ON(!ts))
+		return -ENODEV;
+
+	/* Clock our device */
+	ret = clk_prepare_enable(formatter->pclk);
+	if (ret)
+		return ret;
+
+	/* Reparent the bit clock to the TDM interface */
+	ret = clk_set_parent(formatter->sclk_sel, ts->iface->sclk);
+	if (ret)
+		goto disable_pclk;
+
+	/* Reparent the sample clock to the TDM interface */
+	ret = clk_set_parent(formatter->lrclk_sel, ts->iface->lrclk);
+	if (ret)
+		goto disable_pclk;
+
+	formatter->stream = ts;
+	ret = axg_tdm_formatter_attach(formatter);
+	if (ret)
+		goto disable_pclk;
+
+	return 0;
+
+disable_pclk:
+	clk_disable_unprepare(formatter->pclk);
+	return ret;
+}
+
+static void axg_tdm_formatter_power_down(struct axg_tdm_formatter *formatter)
+{
+	axg_tdm_formatter_dettach(formatter);
+	clk_disable_unprepare(formatter->pclk);
+	formatter->stream = NULL;
+}
+
+int axg_tdm_formatter_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *control,
+			    int event)
+{
+	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
+	struct axg_tdm_formatter *formatter = snd_soc_component_get_drvdata(c);
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = axg_tdm_formatter_power_up(formatter, w);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		axg_tdm_formatter_power_down(formatter);
+		break;
+
+	default:
+		dev_err(c->dev, "Unexpected event %d\n", event);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(axg_tdm_formatter_event);
+
+int axg_tdm_formatter_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct axg_tdm_formatter_driver *drv;
+	struct axg_tdm_formatter *formatter;
+	struct resource *res;
+	void __iomem *regs;
+	int ret;
+
+	drv = of_device_get_match_data(dev);
+	if (!drv) {
+		dev_err(dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
+	formatter = devm_kzalloc(dev, sizeof(*formatter), GFP_KERNEL);
+	if (!formatter)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, formatter);
+	formatter->drv = drv;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	formatter->map = devm_regmap_init_mmio(dev, regs, drv->regmap_cfg);
+	if (IS_ERR(formatter->map)) {
+		dev_err(dev, "failed to init regmap: %ld\n",
+			PTR_ERR(formatter->map));
+		return PTR_ERR(formatter->map);
+	}
+
+	/* Peripharal clock */
+	formatter->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(formatter->pclk)) {
+		ret = PTR_ERR(formatter->pclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get pclk: %d\n", ret);
+		return ret;
+	}
+
+	/* Formatter bit clock */
+	formatter->sclk = devm_clk_get(dev, "sclk");
+	if (IS_ERR(formatter->sclk)) {
+		ret = PTR_ERR(formatter->sclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get sclk: %d\n", ret);
+		return ret;
+	}
+
+	/* Formatter sample clock */
+	formatter->lrclk = devm_clk_get(dev, "lrclk");
+	if (IS_ERR(formatter->lrclk)) {
+		ret = PTR_ERR(formatter->lrclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get lrclk: %d\n", ret);
+		return ret;
+	}
+
+	/* Formatter bit clock input multiplexer */
+	formatter->sclk_sel = devm_clk_get(dev, "sclk_sel");
+	if (IS_ERR(formatter->sclk_sel)) {
+		ret = PTR_ERR(formatter->sclk_sel);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get sclk_sel: %d\n", ret);
+		return ret;
+	}
+
+	/* Formatter sample clock input multiplexer */
+	formatter->lrclk_sel = devm_clk_get(dev, "lrclk_sel");
+	if (IS_ERR(formatter->lrclk_sel)) {
+		ret = PTR_ERR(formatter->lrclk_sel);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get lrclk_sel: %d\n", ret);
+		return ret;
+	}
+
+	return devm_snd_soc_register_component(dev, drv->component_drv,
+					       NULL, 0);
+}
+EXPORT_SYMBOL_GPL(axg_tdm_formatter_probe);
+
+int axg_tdm_stream_start(struct axg_tdm_stream *ts)
+{
+	struct axg_tdm_formatter *formatter;
+	int ret = 0;
+
+	mutex_lock(&ts->lock);
+	ts->ready = true;
+
+	/* Start all the formatters attached to the stream */
+	list_for_each_entry(formatter, &ts->formatter_list, list) {
+		ret = axg_tdm_formatter_enable(formatter);
+		if (ret) {
+			pr_err("failed to start tdm stream\n");
+			goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&ts->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(axg_tdm_stream_start);
+
+void axg_tdm_stream_stop(struct axg_tdm_stream *ts)
+{
+	struct axg_tdm_formatter *formatter;
+
+	mutex_lock(&ts->lock);
+	ts->ready = false;
+
+	/* Stop all the formatters attached to the stream */
+	list_for_each_entry(formatter, &ts->formatter_list, list) {
+		axg_tdm_formatter_disable(formatter);
+	}
+
+	mutex_unlock(&ts->lock);
+}
+EXPORT_SYMBOL_GPL(axg_tdm_stream_stop);
+
+struct axg_tdm_stream *axg_tdm_stream_alloc(struct axg_tdm_iface *iface)
+{
+	struct axg_tdm_stream *ts;
+
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	if (ts) {
+		INIT_LIST_HEAD(&ts->formatter_list);
+		mutex_init(&ts->lock);
+		ts->iface = iface;
+	}
+
+	return ts;
+}
+EXPORT_SYMBOL_GPL(axg_tdm_stream_alloc);
+
+void axg_tdm_stream_free(struct axg_tdm_stream *ts)
+{
+	/*
+	 * If the list is not empty, it would mean that one of the formatter
+	 * widget is still powered and attached to the interface while we
+	 * we are removing the TDM DAI. It should not be possible
+	 */
+	WARN_ON(!list_empty(&ts->formatter_list));
+	mutex_destroy(&ts->lock);
+	kfree(ts);
+}
+EXPORT_SYMBOL_GPL(axg_tdm_stream_free);
+
+MODULE_DESCRIPTION("Amlogic AXG TDM formatter driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/meson/axg-tdm-formatter.h b/sound/soc/meson/axg-tdm-formatter.h
new file mode 100644
index 000000000000..cf947caf3cb1
--- /dev/null
+++ b/sound/soc/meson/axg-tdm-formatter.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT)
+ *
+ * Copyright (c) 2018 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef _MESON_AXG_TDM_FORMATTER_H
+#define _MESON_AXG_TDM_FORMATTER_H
+
+#include "axg-tdm.h"
+
+struct platform_device;
+struct regmap;
+struct snd_soc_dapm_widget;
+struct snd_kcontrol;
+
+struct axg_tdm_formatter_ops {
+	struct axg_tdm_stream *(*get_stream)(struct snd_soc_dapm_widget *w);
+	void (*enable)(struct regmap *map);
+	void (*disable)(struct regmap *map);
+	int (*prepare)(struct regmap *map, struct axg_tdm_stream *ts);
+};
+
+struct axg_tdm_formatter_driver {
+	const struct snd_soc_component_driver *component_drv;
+	const struct regmap_config *regmap_cfg;
+	const struct axg_tdm_formatter_ops *ops;
+	bool invert_sclk;
+};
+
+int axg_tdm_formatter_set_channel_masks(struct regmap *map,
+					struct axg_tdm_stream *ts,
+					unsigned int offset);
+int axg_tdm_formatter_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *control,
+			    int event);
+int axg_tdm_formatter_probe(struct platform_device *pdev);
+
+#endif /* _MESON_AXG_TDM_FORMATTER_H */
diff --git a/sound/soc/meson/axg-tdm.h b/sound/soc/meson/axg-tdm.h
new file mode 100644
index 000000000000..435d95b86457
--- /dev/null
+++ b/sound/soc/meson/axg-tdm.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT)
+ *
+ * Copyright (c) 2018 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef _MESON_AXG_TDM_H
+#define _MESON_AXG_TDM_H
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#define AXG_TDM_NUM_LANES	4
+#define AXG_TDM_CHANNEL_MAX	128
+#define AXG_TDM_RATES		(SNDRV_PCM_RATE_5512 |		\
+				 SNDRV_PCM_RATE_8000_192000)
+#define AXG_TDM_FORMATS		(SNDRV_PCM_FMTBIT_S8 |		\
+				 SNDRV_PCM_FMTBIT_S16_LE |	\
+				 SNDRV_PCM_FMTBIT_S20_LE |	\
+				 SNDRV_PCM_FMTBIT_S24_LE |	\
+				 SNDRV_PCM_FMTBIT_S32_LE)
+
+struct axg_tdm_iface {
+	struct clk *sclk;
+	struct clk *lrclk;
+	struct clk *mclk;
+	unsigned long mclk_rate;
+
+	/* format is common to all the DAIs of the iface */
+	unsigned int fmt;
+	unsigned int slots;
+	unsigned int slot_width;
+
+	/* For component wide symmetry */
+	int rate;
+};
+
+static inline bool axg_tdm_lrclk_invert(unsigned int fmt)
+{
+	return (fmt & SND_SOC_DAIFMT_I2S) ^
+		!!(fmt & (SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_NB_IF));
+}
+
+static inline bool axg_tdm_sclk_invert(unsigned int fmt)
+{
+	return fmt & (SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_IB_NF);
+}
+
+struct axg_tdm_stream {
+	struct axg_tdm_iface *iface;
+	struct list_head formatter_list;
+	struct mutex lock;
+	unsigned int channels;
+	unsigned int width;
+	unsigned int physical_width;
+	u32 *mask;
+	bool ready;
+};
+
+struct axg_tdm_stream *axg_tdm_stream_alloc(struct axg_tdm_iface *iface);
+void axg_tdm_stream_free(struct axg_tdm_stream *ts);
+int axg_tdm_stream_start(struct axg_tdm_stream *ts);
+void axg_tdm_stream_stop(struct axg_tdm_stream *ts);
+
+static inline int axg_tdm_stream_reset(struct axg_tdm_stream *ts)
+{
+	axg_tdm_stream_stop(ts);
+	return axg_tdm_stream_start(ts);
+}
+
+#endif /* _MESON_AXG_TDM_H */
-- 
2.18.0

