Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA753C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85601208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85601208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbeGJSTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:19:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbeGJSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:19:22 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LrDwG-1g4Cvu0MdY-0136gP; Tue, 10 Jul 2018 20:18:34 +0200
Date:   Tue, 10 Jul 2018 20:18:31 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] iio: hx711: add clock-frequency property in DT
Message-ID: <20180710181831.GA5374@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:6lB1bzeS3EeBLfsKQE1XEsvBwx8BCRuSY4YHbWbrSiZMcfJ1anc
 hm5rAXBW06xgJtmUQM9rvXED4Tmh7C/JHHETMDVRkUhnoM8XnjdKOnQfBhCFCgvNayi/NOR
 iMorgfyjJbB+6WtXH/0ISXovk++kpXoapQavwoYfU30WoMOOBWIzanzCUUVuXPF0rcm70c3
 DJB1tXhXKiv7RhqNMFviA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WvZhL9+nlVY=:b1gAhUjMR8jzJ7k1y1ljXW
 7vC1hcMmVjy2UghK6HQOM1VyYYI0hNQGIACdBiW0ctFiQKqU/QJMfHRYaRkdRO78dGuAJh6T1
 p0rfnwxlVeYYdaD8zyk5iJJ6VujZ8iZigXiuNQNVXDAjo6y/nP6VNcbUiogwm3UILCaqc1/K3
 ICD/0or3tW/f4Y9eC5pq6TwFUo28PbxWNSmMoE3k7tbsatKzlDZuffgr0FOsIoSDXX03HHMcT
 ZqRnt4Yujq7Mj6uJ4WEE/91IgJSZkjrXLBla6SQQ6tcLiIohJzUD6K0JthOeDa5FyupYOTRte
 injMhZP4H1Q9HEOzejUDEWA60KZldUDTapiDV/joVvAM1GwPlSGhFsphlw0oCB0H/tOTFci4q
 N+TKS59+mWlKXHg/WS30n4RSBA4+4CTQoH0bUNmGhRtBN0dlvHgiZgomPIYWhhiJqs0djTNU9
 ILs1yOfKYVh9FS4azCj+C0GybB7fymj+WIRVAmAPPVI2MjZqpCIyOtNsGIKflzcPFF5tnMrJR
 CpkfJDa83QhvNldFAaYmCmNDZWCEelLACKD/l8fCFaQ9ZswGXyb9g9K1UrPI3EsL79BpQeRKr
 QBRTrYHoYcrGVBzTz6d71DTKjOYw0sAcKjaYFxiS+lertW7E6VDTeRN94S7HMOUtGBobNKrQs
 ykap7gxTglCpX7Kup7Xbr/twERqlts0WGL0zF+aRn0Tt4ZCtORwg+Uu7n7osogNl8Xf4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock-frequency property for hx711 ADC. This is the frequency of
PD_SCK.

After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
This is necessary because of parasitic capacitance on the wiring.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
index b3629405f568..2c1b67d33c49 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -8,11 +8,17 @@ Required properties:
 		See Documentation/devicetree/bindings/gpio/gpio.txt
  - avdd-supply:	Definition of the regulator used as analog supply
 
+Optional properties:
+ - clock-frequency:	Frequency of PD_SCK in Hz
+			Minimum value allowed is 10 kHz because of maximum
+			high time of 50 microseconds.
+
 Example:
 weight@0 {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
 	avdd-suppy = <&avdd>;
+	clock-frequency = <100000>;
 };
 
-- 
2.1.4
