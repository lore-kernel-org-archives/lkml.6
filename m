Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EB9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01E6208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01E6208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbeGJSTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:19:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45836 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbeGJSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:19:52 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MDkte-1frkXf3eNa-00H63n; Tue, 10 Jul 2018 20:19:06 +0200
Date:   Tue, 10 Jul 2018 20:19:03 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] iio: hx711: add delay until DOUT is ready
Message-ID: <20180710181903.GA5386@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:FPlXaVHvqgxq0QkGvFUbikxjOvQ4Qw0coBElOFmeEGv7Ioi4Atq
 l950E3/mB/sNACnhp2GSQjM+Y+QEyfnNknDQRhWfkhGRIYqtNdcQEkGEI3+PCmfzIDfoCfy
 ipWQNIHvWEswJ+ZGdQfBMjtWP9oWxHAz1fBswKrOYrau+u5j/zSfXOwbNaf/gy3Hbf6HzhH
 nu6Tnb4OVX+dE+IzveLcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6nOlLAxueXU=:2FGwY4pmvu1+pLs2eNe6v1
 IEyqpVgt4FzNirziuwQKC7ikKJzK052vPwO9mQX9ptR55K2G8vqny3SnoxJ3XZPUUZz4phsp6
 Vzb+AOt9y+3pOQfWwpifbw4ggHT5EIr6kKYJ7Tlak4noCfpIL6DNYd6MsTgifTpPvju3Am62/
 O5XwdhK0FgVI5QtgGB0hjumV4SQOLfs/7LIS1Lb7iQ1APEoldDw+uPLLIFLMczGYKT67jd5Yh
 e1Jzg3S/BuRBmd9fR8yllAgXlmtBXwmA1Lah7bBiQ9LtTyK5vFPIwGdyOZc9yX80x6KeeR2vu
 Vwou++luBgjuITo28CH76eZUFC//Py0wtLwfvQ99xhiiLXdMob1AYEUgZ510gG+EKfiAevGqr
 y7l2cKRgzPCSCzBevhim5HMn92V+Z3eEQWcpcA7+c3qe/mtlg3YtOymSXZloOhwgIuAxqkdwK
 fWmaMajm8Q2DW/7zzdQB6W96xZgSpH/r9k4Vlpln6SYssiZeW3DmluuqaBM7AGnj2vsxBNes1
 UW4vxK9y73eX83gHvJPXzfcb4fvZao2xF5KnjSh3wXf3OzEV+fh0gk2z09h2sF2Xf5ykE6lxh
 uV4W4fHQKFxFbseQrC0kTtxcJ30EM5+HjpfdQkI6Vli51OVboOL6GwZgMfP+rHYydlFs228hT
 5EGmIseNRc/wXYPHwXWcECgiNnk6F5a8VqWcwZYla3cPVzkd135ThuYPjLJox35kBEkM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with parasitic capacitance it turned out that DOUT is not ready
after 100 ns after PD_SCK has raised. A measurement showed almost 1000 ns
until DOUT has reached its correct value.

With this patch its now possible to wait until data is ready.

The wait time should not be higher than the maximum PD_SCK high time which
is corresponding to the datasheet 50000 ns.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 9430b54121e0..36b59d8957fb 100644
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
@@ -120,6 +136,12 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
 	preempt_enable();
 
+	/*
+	 * make it a square wave for addressing cases with capacitance on
+	 * PC_SCK
+	 */
+	ndelay(hx711_data->data_ready_delay_ns);
+
 	return val;
 }
 
@@ -458,6 +480,7 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 static int hx711_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -530,6 +553,22 @@ static int hx711_probe(struct platform_device *pdev)
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
