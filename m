Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791CC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7C024CD3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7C024CD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeFWSzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 14:55:32 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFWSza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 14:55:30 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LfznH-1fz0c62wOJ-00pfjb; Sat, 23 Jun 2018 20:54:49 +0200
Date:   Sat, 23 Jun 2018 20:54:47 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: hx711: add delay until DOUT is ready
Message-ID: <20180623185447.GA17853@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:wAzWFPnfRIcMxVuJLQf8WStkDbM2MxKpUVyVweA7btQbDE8PSv2
 cOrPSd0bKNHyXaxNSn7Dm4jDydCDPQvO6T9VaIlUL0Bt1Zn/WW9geXp5gmdJnBKzy6BRYqw
 N8yR7Mj+hhZlWI7NLXPgGv5hUFOSGvV6Pj2Gd8+rBdzXd4ypUAHnMWC42PvpflUklubpTA8
 +FbracugSt3ZfS1jig7kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h2+igRNAk1w=:OvTKIZxhXYVMQNHqU2zdBn
 3n/HurMKTgzK2l53CGrZ7iRajiV8JZ1azl875YZLIabRsrn3SImzheSfx7Y8ASeJV1z98S5cd
 vYNvdEbMOql0Y/NknAMOLXqsJxBBJ1C5pJ9n6D5tQR+gpU64W8zRJ+THdzlOnWvfHvrnQG36Z
 w5zAHuhAMTyNuriQObflfE048LuG6sUuHg/4NXI8QA0Sm8f7Ll9iFJiYJ9NmtvQJdQ3VQS6A8
 Is/OenXBJxN1mWN6sCKFTSVtcCTlMLLnoS+swZhPEnrNMAql2r9/TJMK85GmR0Ay5U0XhgQMH
 HoP1JmKpGMcKKpNcbWLlZo0mIOfGGMpEk3YTk6/W99jX8/WKOLipuyxvpZmKKt+BPHxw5MPjN
 wCZ+ghAWgCZseUUEAQDfx0hx0HOn5R0QzFoEWB9C7hMBegQUpKTWE1L49atJI3HzdCAKHUMa1
 QSCdh3ihRICsC7+VhyZ1TLOW6mrhNCZZeuM58oPlivTCgNEli34v/6TTUZSF2aHwwCqm4/zmq
 0SWoUVuUqH8WwvVu3VAGPnnjbZYyWfoL4LonuYQL6S1OHTucaBt0l2dPlq2O58nWe01VRde01
 9cUBjygKBEhV8b3pilS6XpNhwkuWo/73AXrKoKj7JAE5QO6eU9UhOhpHlvP38KvRkKcvkpkl4
 zqqznS7w7NqTggWcgMWqJXqzNeNoEXR13nUastBr8H8QsUW9hO1QZmBkpGu46Sc1niSg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with parasitic capacities it turned out that DOUT is not ready
after 100 ns after PD_SCK has raised. A measurement showed almost 1000 ns
until DOUT has reached its correct value.

With this patch its now possible to wait until data is ready.

The wait time should not be higher than the maximum PD_SCK high time which
is corresponding to the datasheet 50000 ns.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 9430b54121e0..41e26ef324ee 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -97,6 +97,13 @@ struct hx711_data {
 	 * 2x32-bit channel + 64-bit timestamp
 	 */
 	u32			buffer[4];
+	/*
+	 * delay after a rising edge on SCK until the data is ready DOUT
+	 * this is dependent on the hx711 where the datasheet tells a
+	 * maximum value of 100 ns
+	 * but also on potential parasitic capacities on the wiring
+	 */
+	u32			data_ready_delay_ns;
 };
 
 static int hx711_cycle(struct hx711_data *hx711_data)
@@ -110,6 +117,14 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	preempt_disable();
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
+
+	/*
+	 * wait until DOUT is ready
+	 * it turned out that parasitic capacities are extending the time
+	 * until DOUT has reached it's value
+	 */
+	ndelay(hx711_data->data_ready_delay_ns);
+
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 	/*
 	 * here we are not waiting for 0.2 us as suggested by the datasheet,
@@ -458,6 +473,7 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 static int hx711_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -530,6 +546,13 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->gain_set = 128;
 	hx711_data->gain_chan_a = 128;
 
+	ret = of_property_read_u32(np, "data-ready-delay-ns",
+					&hx711_data->data_ready_delay_ns);
+	if (ret < 0) {
+		dev_warn(dev, "data-ready-delay-ns not set - assuming 0 ns\n");
+		hx711_data->data_ready_delay_ns = 0;
+	}
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = "hx711";
-- 
2.1.4
