Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA7DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A8B24CD2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A8B24CD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeFWSzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 14:55:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:38239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFWSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 14:55:07 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LvRqd-1gEU8B2vKt-010dk0; Sat, 23 Jun 2018 20:54:24 +0200
Date:   Sat, 23 Jun 2018 20:54:21 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: hx711: add data-ready-delay-ns property in DT
Message-ID: <20180623185420.GA17842@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:76LOJmFfToqRxhpmDosCC967j9e9ifRZqhdN/JQ+f844enYI/ag
 azxLNo+DvyGsPzTut40hrYA01YJLms+s/6fJP0bW3tCENggtDmjFDfhiiC87Gd8093KH0EG
 nQYl/i7PMlrej7uudkKsNyAjvwo8OcI2UOSDmqUtkuoscRTEypyxO9gu4fNrBz+FQSYdN1P
 YUi/zLonUaAMMm6xyxmpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QkxKoAJsf8g=:G1EmF6xwxvnL6t5aBzGS4B
 9pFvLVkW2E4F9z1NPX1GUVrcw6/S1lvOIw+blfzwFdsycErP/saGIoCAvKEF4nWFOBqb0DEh1
 WULk5AkG83kPdw8xVtVHohbwRV66mobwId97nLD1ZplfNu5VgMarQG9LnxubHdJCqjkSyKpS3
 wUvgqb3l6h9tI+ZwrOLZP87adzHPXqe7cqacGDXAoOjBQt/ILlYE1sel6psLn6e9ILazS8Uhc
 PGbkYtm2IFeDOZR27cJyZxRbjj7l8IzCp/r3C6LvS7bYGehWV6gEN62eiqU97sMtf1Ho02yLT
 4zdDhWlwmShPeAUd4j8VzfzhlKlcpYJl4sd0I82eHFaOxbz4R/XT63ye/vGCkTlHeomXAgG1w
 vrfS49PWuAhZYcWQFzk/SlvsVSsyrlHlyJx/jAsIUGRrNmp25TpsfKYRSY74szTSGeOaH8f/5
 fGJ6xPtTY3PEUNCYt2SBW7XciFVOkHWj7LWuWE/fPOl8FbAQKsGWVMllt8sVR2xSjAc9LaUVc
 EiLRt+NNACXqjLGUeUShbJcO6kkt3q595wbuWQ0wi9FwNSp7gKHeBU4+c1+FPQaoumtzWU3Gn
 4nSyhv/iUZmr0b33BTezc+oWlrD8/YBST+cYyv2R+49VrL2pd35ynDungexfqUm6g5gNkWH9j
 tOUcP/VL5JIFDi0UShLDyDMAxKlUWt/Db7zbzqCu9LnXF+0mxBj6AKyuJwpKz9y7R+5I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add data-ready-delay-ns property for hx711 ADC
this is the delay after rising PD_SCK until DOUT is read and assumed to be
ready

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
index b3629405f568..8c9bcaa4d750 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -8,11 +8,18 @@ Required properties:
 		See Documentation/devicetree/bindings/gpio/gpio.txt
  - avdd-supply:	Definition of the regulator used as analog supply
 
+Optional properties:
+ - data-ready-delay-ns:	additional delay in nanoseconds between rising of
+			PD_SCK until DOUT is ready
+			should be less then maximum PD_SCK high time which
+			is 50000 in the datasheet
+
 Example:
-weight@0 {
+weight {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
 	avdd-suppy = <&avdd>;
+	data-ready-delay-ns = <1000>;
 };
 
-- 
2.1.4
