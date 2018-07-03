Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306ACC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E674524B1B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E674524B1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeGCMum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:50:42 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeGCMuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:50:39 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MUhut-1fiCxA0JP9-00RLwd; Tue, 03 Jul 2018 14:49:59 +0200
Date:   Tue, 3 Jul 2018 14:49:56 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] iio: hx711: add delay until DOUT is ready
Message-ID: <20180703124956.GA18097@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:Y0TEjiA6u2GC1z0fSyjLFQyD18QKY7Pd4MIKCkRXlhIoDl/jxgs
 /aRvHaeA3TpCm7wgSIDI7wT29hZgucaJRrIWdFfdVcxUX0/TbFPS0VSjblbeC8NA1+aftkH
 3YW1RmrIRtnllQpA4N8hE3jn6xK6zovYdRG42c7pmwOWvLADTLe488krXVCIh/u343TjV9O
 49nViXlOYZVaaiPJj46dA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zpIlA8EkHOc=:NhH/NghxbVSX7y2l8AX5M0
 QOwm5Qy4xGz59FQ/ZN5C2LlaT2+QtIDNXdH9ztkpjRSQTD4OG/+LPiwhNa6oNyKl0AHh93I8j
 VZDaUa/P7+TNCrs4JYGWMoOsSG+1wyctMiFWrTZrf8vRCeava1SE8pfer8jXWJFz8gxOwOuht
 zeivZiUrmdyYvEprhL1DwE3oJnuc7olwNepcoGldhjptP1OoR3xedl4pXzuzpQ/ZSKqc69DZB
 buiWbywOGfkowp6wvoIMAa5C9LlQe4dpafOhmyLBRWjfKaBeq0xBbSmv2pOY6sxFnrXm3yPUu
 qoNJPkm/DvvjOuincZYc/nxplbUkaBYlqh8EFs61cjWVlRcGjGlVz/leVTPyU9e7f9JvCLAdi
 U0SRYgEa8z4YVnYnZ3KwOuyn04Lx1/0KAE/jbqVYiyluaXKBlHh6Df6sXNqYFe5mCRo6+IwYn
 YAcgAc4qOGPV032qmf9FV/cO4XF5yMsmlBbCVvP0Szm2MtSRRJOfqBVyso+l+5p0gbl708EAz
 KzzL6OULCn4hjJSJbeH79KUXHdwgCz0dVeOr3/zLosHY/zOFAwzYm3RjAnZp0/ma+ze3PR+Iq
 Y1od4rHV1FBUKtJ0yx/iWMlCLl+ME3yxjGw5lyIeMARBg7FPdV8/Tv7FIcMVbuJnnqxc2obNI
 fgxUKTmRwsQ8eULFjTdKz7Nsa4Oh4nIHNUzIgNTA/bXn/zZPEDToNgmWHBETTyaokzvk=
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
index 9430b54121e0..d944d1abedac 100644
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
 
+	ret = of_property_read_u32(np, "avia,data-ready-delay-ns",
+					&hx711_data->data_ready_delay_ns);
+	if (ret < 0) {
+		dev_warn(dev, "avia,data-ready-delay-ns not set - assuming 0 ns\n");
+		hx711_data->data_ready_delay_ns = 0;
+	}
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = "hx711";
-- 
2.1.4
