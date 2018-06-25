Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354C4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A6225C78
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A6225C78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964790AbeFYPTQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:19:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934725AbeFYPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:19:12 -0400
Received: from localhost ([83.135.237.7]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MFKXk-1fLQ3D3Nf2-00EKUv; Mon, 25 Jun 2018 17:18:28 +0200
Date:   Mon, 25 Jun 2018 17:18:24 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] iio: hx711: add delay until DOUT is ready
Message-ID: <20180625151824.GA6380@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:PBwqrmFS+/jSJl7YqKzej7uxocDP4s2zDk3pziOtqs6Z2MrGbWi
 BsYAVKC45FwhW83Emzjipb0q/FuMnwWR7gbC1PZsCfMvLNJeGE7wqthC905nxKkoo35dkAM
 LgdNP4Xry2DdRH8mA0OJapKZ08TL3in3B5O5D006InNrgq7dbx9kTlacBZHK8WB+n1ZmQ0U
 vwfOh/+M755P9Z8UgstKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UasnbnSetNU=:vFNnkh9nRxPRARIN+Qpi+Q
 Uzg+8qOfEiVtE1LaTOYYPWxA1gAA7XdnA6biaxsg4b8kkAn5BFvqfuc2oiP/qK9HD3k/AhZIY
 PmHCrT7OIZ8rRepMY0G5CMar3BlTTqCLn5S2WmUHkPmJv7EmUvN86flBd2mrhLj6/H3qKDD29
 CAv3o8KGxMQGRF+gmJyLyQGiPOpErSWU+8T7p87BKgurbCMRQqv9WJo+W9zbEEgDB/rDptiHT
 qJ3edt3dSNmGbnSNa/+3V9R50O4W+jA5yC6q08hGqgj1n4XiL12Ky5xU49bB63OY7Lo69uQZA
 NuDEiVawq48L+FHw91tyvtg3FOXbz3Y/b0zR9FVeBfU6Uq3Z5MgttYUDX6fvA/r/WowDk9j6t
 AZJtxetQ6NF9gVW4Lf4peKs+0EHKmL78sLZLMiiOLzIb9ZEy4n2wxPhwbdCazWryDAIs7rSVZ
 ehktZixuxdAwGUAVwir8YjB5IpIEPE2Vz5Y+YJXNlscpbEu4Xi6wQqlnKJVzGF1x+ghRAZGy+
 rMgivzBPaS98PYktuYQgfJL9k2h4Nu1MccEEl8L1g4UFz5QGX5RXtv7ZhGRMkjTbWc8xB6Br1
 tAvP72KsNZAXB8DAUmHgabRGEoyNekhOY+LtSM/jMpA6RN0uArtJhdz76dkUm7A7AgUQFTgR8
 fwhZfMz1efjKsAkHTnMVDb+V5xoTxcWHEvI58kij5OipcqQK91d0GXBAL94zvXm3S9TE=
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
