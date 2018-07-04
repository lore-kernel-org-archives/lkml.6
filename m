Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF323C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895E821917
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895E821917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934723AbeGDMhW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:37:22 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48934 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933777AbeGDMhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:37:20 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MgTUE-1fnO2z0ud4-00NjIr; Wed, 04 Jul 2018 14:36:39 +0200
Date:   Wed, 4 Jul 2018 14:36:38 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] iio: hx711: add clock-frequency property in DT
Message-ID: <20180704123638.GA30535@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:jnm4tvqBvGrTT7lJO2e7XKBe21wzvEJyvHrAY1957k2XFo5/UgJ
 3oY7FQFTHM7+MZ1K8u5XaGWQAHVOw32HzhomxCx21w2ZEv3e+k3dzNW2Nizx5h+dqCnoYry
 O1YgHBISJ0GIX9XIlxx9hQJlW4iOIAnIJrN1mF8uj5AChkD1t0qwI37giKDi8PSkRZ68usz
 UE2T1NvhV/cA7m7/VyUMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cB7H7PW1VME=:ZkmKBCy8KCtDej/GD+W62+
 2cQsFLKJnTv2R4533YNgBsbRVQKoEgRrIz8rPFqEumsDNVi+l/z0xW3theZX8AtYLR7sgUzUK
 kgtU7wu1u4xB4ldv+edUfdC3DEWaWS8ypAyI4YxoLtmgQYrDNTXQq3vUq9tO0XFHwOF1ScVFA
 x1wK0gRZTijk1G8WvVGNoIwCEMJXrPr1MM0gdmoBiT0VHllwFPBGyYYpLJexWpDSVYzhZGFrK
 lrcJ4i+R68PHp1FkFzTTQbmJj4wfZcX7cysZLsrFfNvR9CkaomW75qD8jhM1H23lg98X7QTDT
 3weAcGzhbtJX8Q8xQ58NBGc3SdkqrttuaryHK9Br3LagN7HVLmCjJcGXVU/90OwI1Cj9UbksW
 RQtcl+SHqRi0Gm0VaR6BBg5vsMJ/i3gt7NyTIdZQFMYX3gQN5ecCW6GbsPBJHFSRNqiFORfdj
 N0+s8mC2fyUwic1JZ+Wut5O45W5aZIB/tg7yv7T6ZhVyszBPiko638tW/yILoUhW+t44BEPN0
 umk+uzM25fTxkSmGMqs+nVTPEgaP2PggXD7owzxKsApOZ9ydgDM8UvWIYMQte6tnbPOYdcjlx
 tPkqqvgB3kJu8clSzGYW0fK2horwxTHGBbwwj+5HmZIlpJAMgyi8E2ePLgCuxfWuaAq/4IsEM
 OXio7neAPOZ0tErb/ngUkApfVVTu4qXRVT3C8rvtZmpe3CS7ivi+weftoJ5rzDVWv6fo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock-frequency property for hx711 ADC

This is the frequency of PD_SCK. It affects only the high value duration
since low value duration is not relevant and we are not able to switch
faster than the minimum duration specified.

After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
This is necessary because of parasitic capacities on the wiring.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
index b3629405f568..4bee51d536e1 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -8,11 +8,21 @@ Required properties:
 		See Documentation/devicetree/bindings/gpio/gpio.txt
  - avdd-supply:	Definition of the regulator used as analog supply
 
+Optional properties:
+ - clock-frequency:	Frequency of PD_SCK
+			This setting affects the duration of the high value
+			phase of the clock (PD_SCK). The low value phase is
+			not affected since it is not relevant for the
+			measurement.
+			Minimum value allowed is 20 kHz because of maximum
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
