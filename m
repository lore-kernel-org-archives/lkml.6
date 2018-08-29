Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD477C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788042084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ9gNWIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788042084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeH2J7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 05:59:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38205 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeH2J7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 05:59:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id e2-v6so1857258pgv.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QYs/+wtywkNmEn4RKbGv+95uUTJD4f+z+ToiDyC70jw=;
        b=KJ9gNWIrTIbnMM84F7GPQrOdUeQ5Vd7OUPBeDIOV1lnn5zgJO5OQkXcaED86nWEQYh
         uMhDaq8MLcLSyDZ2Vjfok8mT579dEtFIwIjJFrVY55vxtKmgc9/nzU+yuLL4Ct1WCbgY
         agnZQE2Sx91wEhIw4iyvkdIzInWgKDYuW77ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QYs/+wtywkNmEn4RKbGv+95uUTJD4f+z+ToiDyC70jw=;
        b=UIhEHB3KQjtIbqCA5P1AoWGkmLzuNJYDKkeDjQqFMydIumcsIkA2U8OPGGf5+mmddZ
         RLpDneYZZdZlSz4WhEFqQ4CV0WiikSmPpLPO9nXYhao6l4XiSirFwwYMXKHiWPHpet1k
         LLGbnElizj0bWSNXSY+eeQOwHgM8MuyPdOTitUkwecrdM9W1FIKM/liA3fz0sDlOlQSM
         Suo+jx6mev12MzQ3JK/HUU3NecW21sd1MWp4d5iHlI/uYnN1NdBQtcwWPe0dyM9qT2gi
         MblYBaWrwOW3u/Ob9H0MrztAbp+SBdVzM1WXdkXGEUKsc1DgkbItrT34YQ5/wK/ZOrqX
         XaNg==
X-Gm-Message-State: APzg51CPm/bquJCYDPTBfMYBNRcd1jgtKxeLGuyQ68iehU0d7Ltz2LyG
        aJku9/qQTLqQc2JgzouKoMGXQw==
X-Google-Smtp-Source: ANB0Vdbr+AVE7wAQ92tG1qes9It7RAP29McPzD05xKhxyS33BRYppudeai0ryygB6sMf3VsBhBJK1A==
X-Received: by 2002:a63:1618:: with SMTP id w24-v6mr4489155pgl.43.1535522663479;
        Tue, 28 Aug 2018 23:04:23 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c85-v6sm5188729pfd.110.2018.08.28.23.04.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 23:04:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@spreadtrum.com, broonie@kernel.org,
        baolin.wang@linaro.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: sc27xx: Add ADC scale calibration
Date:   Wed, 29 Aug 2018 14:04:05 +0800
Message-Id: <61cad47d5d10c771d3cc371744533e87d192ee96.1535434262.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
References: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
In-Reply-To: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
References: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to read calibration values from the eFuse
controller to calibrate the ADC channel scales, which can make ADC
sample data more accurate.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Use nvmem_cell_read() instead of nvmem_cell_read_u32().
---
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |    4 ++
 drivers/iio/adc/sc27xx_adc.c                       |   74 +++++++++++++++++++-
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
index 8aad960..b4daa15 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
@@ -12,6 +12,8 @@ Required properties:
 - interrupts: The interrupt number for the ADC device.
 - #io-channel-cells: Number of cells in an IIO specifier.
 - hwlocks: Reference to a phandle of a hwlock provider node.
+- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
+- nvmem-cell-names: Should be "big_scale_calib", "small_scale_calib".
 
 Example:
 
@@ -32,5 +34,7 @@ Example:
 			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
+			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
+			nvmem-cell-names = "big_scale_calib", "small_scale_calib";
 		};
 	};
diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 153c311..7940b23 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -5,10 +5,12 @@
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 
 /* PMIC global registers definition */
 #define SC27XX_MODULE_EN		0xc08
@@ -87,16 +89,73 @@ struct sc27xx_adc_linear_graph {
  * should use the small-scale graph, and if more than 1.2v, we should use the
  * big-scale graph.
  */
-static const struct sc27xx_adc_linear_graph big_scale_graph = {
+static struct sc27xx_adc_linear_graph big_scale_graph = {
 	4200, 3310,
 	3600, 2832,
 };
 
-static const struct sc27xx_adc_linear_graph small_scale_graph = {
+static struct sc27xx_adc_linear_graph small_scale_graph = {
 	1000, 3413,
 	100, 341,
 };
 
+static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
+	4200, 856,
+	3600, 733,
+};
+
+static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
+	1000, 833,
+	100, 80,
+};
+
+static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
+{
+	return ((calib_data & 0xff) + calib_adc - 128) * 4;
+}
+
+static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
+					bool big_scale)
+{
+	const struct sc27xx_adc_linear_graph *calib_graph;
+	struct sc27xx_adc_linear_graph *graph;
+	struct nvmem_cell *cell;
+	const char *cell_name;
+	u32 calib_data = 0;
+	void *buf;
+	size_t len;
+
+	if (big_scale) {
+		calib_graph = &big_scale_graph_calib;
+		graph = &big_scale_graph;
+		cell_name = "big_scale_calib";
+	} else {
+		calib_graph = &small_scale_graph_calib;
+		graph = &small_scale_graph;
+		cell_name = "small_scale_calib";
+	}
+
+	cell = nvmem_cell_get(data->dev, cell_name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	memcpy(&calib_data, buf, min(len, sizeof(u32)));
+
+	/* Only need to calibrate the adc values in the linear graph. */
+	graph->adc0 = sc27xx_adc_get_calib_data(calib_data, calib_graph->adc0);
+	graph->adc1 = sc27xx_adc_get_calib_data(calib_data >> 8,
+						calib_graph->adc1);
+
+	kfree(buf);
+	return 0;
+}
+
 static int sc27xx_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
@@ -209,7 +268,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
 
-static int sc27xx_adc_to_volt(const struct sc27xx_adc_linear_graph *graph,
+static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 			      int raw_adc)
 {
 	int tmp;
@@ -390,6 +449,15 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	if (ret)
 		goto disable_clk;
 
+	/* ADC channel scales' calibration from nvmem device */
+	ret = sc27xx_adc_scale_calibration(data, true);
+	if (ret)
+		goto disable_clk;
+
+	ret = sc27xx_adc_scale_calibration(data, false);
+	if (ret)
+		goto disable_clk;
+
 	return 0;
 
 disable_clk:
-- 
1.7.9.5

