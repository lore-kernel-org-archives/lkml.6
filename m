Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B31C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3767721917
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3767721917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934739AbeGDMhk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:37:40 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52880 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbeGDMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:37:37 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MQA5P-1fX6843dEh-005Hz4; Wed, 04 Jul 2018 14:36:55 +0200
Date:   Wed, 4 Jul 2018 14:36:54 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] iio: hx711: add delay until DOUT is ready
Message-ID: <20180704123654.GA30568@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:u5EIs+iaOzGpnT3Ee0K7wk3Tg4T79A0WPfJjOtpRFBqE1YnTY/O
 vMBS+RjsiguZ1foxRlKuslTFW2fTXzU347s9+MsvqXq4yfjMu9SkhBt6Kchk3BwYwALqabI
 mHn6FdoyS1TcwCc7C+UzoYrxRi2ZPhzGemkhyTcNyOdvJ8JUD5CkzkTomeZ6Mils6YEbcPS
 dP1KjM/UkNqJBeCJESIQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yj7MV2Ka9QU=:Kh355EWBjnXhL9mRA6eoBL
 89APFDp/0f1GLfYGYcW0HhWdU0NLwMlJqHZcpt/y85LpM8CAQdlqMZvgNPeIz55Qe9+75ihN2
 wMiLXPcnR1ruYDIzXafZn4nnFVP2+kUAj/s10FZX6Wozz9Ta4kGxWyJzFWi29X288NLEW0M2x
 a0ovPZGJDczk+kDMTbOcoPoZ/oh8yHxlQItwQAhJVWFZ2nz13fAad5oshhrlI4VSZL7CQ66KW
 v+Gt2GEKcPeHy6Kval19VzfBDQLAYaYKdgNz1cwD/K15CterRFtYGigeMCOwINMSei2CKQSST
 k0pTtP+zSi6i/hgtad5lVEGGvuwjoAoUWPDfMlhcB6tjkzMRInLTONLJ28A+cnOlA1oMJNSpA
 NT8PKXVqAO3kmDSCWbd+Y/lVy74ULVDa1AGIc6gXa41Ms5ko7Ja6fb6ehUGFY9uofVQe+qbMR
 SQLwl/vGwhpWKxtu5QYlOqFvS2+DYufzCnmGM6fFVP2QaNIfjwp+ePOxnJGEql2lHInRuRm+z
 1x90GrT/ySRwlthmRPlDXOQeop7/6xTrAa2gwOkeRYcinxu4rjfmRIJquQOuJid4JBYa6q+6q
 Q0KLip5WOlqGXKeL0CB1v/b7izmXAyMN2+bkBohalGHOxwH8BykwwvJRJ1WDNvkJBCVFykjUr
 oysS/ve/IZVlfXZivnLc7s1CAWAHTCJ4kqwoO1491qDAvI/dc2AOLSJA2sDhJmt9gvmQ=
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
 drivers/iio/adc/hx711.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 9430b54121e0..c914c36f9cdf 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -97,6 +97,14 @@ struct hx711_data {
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
+	u32			clock_frequency;
 };
 
 static int hx711_cycle(struct hx711_data *hx711_data)
@@ -110,6 +118,14 @@ static int hx711_cycle(struct hx711_data *hx711_data)
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
@@ -458,6 +474,7 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 static int hx711_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -530,6 +547,22 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->gain_set = 128;
 	hx711_data->gain_chan_a = 128;
 
+	hx711_data->clock_frequency = 400000;
+	ret = of_property_read_u32(np, "clock-frequency",
+					&hx711_data->clock_frequency);
+
+	/*
+	 * datasheet says the high level of PD_SCK has a maximum duration
+	 * of 50 microseconds
+	 */
+	if (hx711_data->clock_frequency < 20000) {
+		dev_warn(dev, "clock-frequency too low - assuming 400 kHz\n");
+		hx711_data->clock_frequency = 400000;
+	}
+
+	hx711_data->data_ready_delay_ns =
+				1000000000 / hx711_data->clock_frequency;
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = "hx711";
-- 
2.1.4
