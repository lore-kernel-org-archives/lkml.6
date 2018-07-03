Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF38C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7754424B1B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7754424B1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeGCMuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:50:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeGCMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:50:05 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MEaJJ-1fKcMl2vQP-00FhGC; Tue, 03 Jul 2018 14:49:22 +0200
Date:   Tue, 3 Jul 2018 14:49:22 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] iio: hx711: add avia,data-ready-delay-ns property in
 DT
Message-ID: <20180703124922.GA18022@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:7nJkyO78xqlTGxK3jJsp0WXt08qRiXBPEbjVXx9mKCl/PgUbyie
 Pi08aIlQnur89BupTAjddhdJyWWcO8P861GJIV2q6j4n+UkncbM9yaBqnzztpwpuY2s4A+G
 WWIUGSZaO8WsXrp2xkVfKbxy81kylr6tX2xYBVO4KdtNLpLqV5qG6vspcxJoDwZElQ7YZ+F
 f1T3eni53OfHxYhbKoENA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZpicJW8w38I=:YHLUc1l3unpIeetd7t/WsP
 6FZcD8hJ3JT87jxLkkiQzCf57fr88yCxdsjWd7T12TuBsy3H6HI6bHrglyP7M/qtMHoESXmO7
 lTmeZfXVhWych5A+Rqyk7ldjZc9vr3O7hjtUhoAHPdtFoODkFH+dqnI0xZe8jD2v7Oj3UYrwq
 26hjo6Xmf97igPI9xAo546AG9hDX3iZykWycZzF1eOEGiw9+/lbRW+qVOimNorxiXauJ1pgIr
 EkoORIkFaY9iXDmG/n/SEPJqJgcWKgjwBELgSXzAYhBkYN0Fz7ZQ8G4w1jbkhtchM3MRbvNiF
 WWZ+OmFMsQ8zz6aIS6A/DWzJC8CK3ToHIbpcPYSaYwYVlUKh0MCDOMcr1IWRDHQSRq4bdFK15
 c4YqTrnF5XU550Wqdtndc8UaITtst6PdX8J3LwYmOifGof3e2iTa5fYG8NPZiYqbkdsgCdYnJ
 GM6uH2xMr1ytCcDxd5BmlhaAFDESkmxAINWaNkbemYAK06NxxFLAaLjXM/yhV7lGcoXdo3TKX
 OM0S9J6X3G2LN7ui40OJ0BQGn/og+uohx9rmMq9xK7bQkQI8cm4CnIQSBjXtVFxWiwco4p6g4
 1r3g2dqAtpUi8N9ucHPZ0PjD2ezUZ4QJUywKCXoYTtBa/9QZjYjGq7VTPAMj68dW5Rw490N/X
 /p4PwVE58zDV27QEpSTUH9t0InRep/ItrEclDZMsgje8Q4tHGuchAKhl+gGYAn2RUZNo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add avia,data-ready-delay-ns property for hx711 ADC
this is the delay after rising PD_SCK until DOUT is read and assumed to be
ready

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
index b3629405f568..669d213e2964 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -8,11 +8,18 @@ Required properties:
 		See Documentation/devicetree/bindings/gpio/gpio.txt
  - avdd-supply:	Definition of the regulator used as analog supply
 
+Optional properties:
+ - avia,data-ready-delay-ns:	additional delay in nanoseconds between
+				rising of PD_SCK until DOUT is ready
+				should be less then maximum PD_SCK high
+				time which is 50000 in the datasheet
+
 Example:
 weight@0 {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
 	avdd-suppy = <&avdd>;
+	avia,data-ready-delay-ns = <1000>;
 };
 
-- 
2.1.4
