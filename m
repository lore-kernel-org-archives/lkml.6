Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E15C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8891208E5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8891208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935032AbeFYPSs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:18:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934725AbeFYPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:18:44 -0400
Received: from localhost ([83.135.237.7]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MgCZR-1flZlO3Onl-00NNjQ; Mon, 25 Jun 2018 17:18:03 +0200
Date:   Mon, 25 Jun 2018 17:18:02 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] iio: hx711: add data-ready-delay-ns property in DT
Message-ID: <20180625151802.GA6369@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:9TPxrJbohkoL+lQBTpArem5NwTrcTNw01dLUqcwEsvNoChTL5e6
 XGHUCd1fvkov1Ndh8ip7u+uKrRv5Ky0hTwIaRi4mJYpYQUTQskIRhAwn87cHr46j9jm/2bu
 u8OR/6SMDqxcHrLCbw10rECK/eFwJewGy99w3e8G+CWEfl+1s8I9ET8O+YNuAEaNiWaS1y9
 fHh9f8sFv2khsbXCdEzQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7KfFwbU7dH0=:p4Yp4AS6A5rhYYEbXwWoYY
 kM1lufTtXJd9zCvlvx42OblIksyunthDfKp5kue6IcHfiUsrtKVpFQ0ierboi/45QLw2uAW0s
 ypz1Rw5RVSPG5RTK5DbtYoungxQJf0FbEuLzulxf9JHA3mpTUiFdQJfxf/ly0w7ez5egftz/p
 pasoqEMrm4tVpUy7My+QhXHweqBkHnwAoFwBDcak3Jtye/PNkc3jcjkm3xjRaUu8QJpHD4zdO
 iLkS0nKf4lEqwS+9sf61g88xwzj3jElzvEoCJR5uXwJTdnk/NX1vQSTgil3jYD5kt72OLu66J
 c3SINmPRUNnleLlySPEHorIvkleArRHLMWqaPk+s01Jx7HWe61Jbn9KkhVTANae7k2h6kEa65
 D6Y3g/iEQxstyHubE1Dfl0iG0SJoKzy3IpD1PEc07PJJP9OFjO6NyRC82OnW/0g6m5W2wF8R2
 o4rupR9vd3MxY3RuvNX8zVePdXpe8wHf/U2LERwMqd9n56Ljgh5QTi5VPcYQ9c12mzKPo15zF
 GohUh+HbrJDQ0fk99pn79JPRqMTjqgf0W1Lv6RrRp0p4reOIUugpmO2D/nG0tMEIbhCoZgtKu
 8C95VDoCdh4oS1jrnoQ0HpEhNfyJZgdWHhf9xzBkHYVYuea338u9QcuNL4AYNpydWoAezO6rk
 qfQbEr6sS0A0bRbVqeBoJNyClXh+6y5r9hivDcjtMcQvRgTJeOeQumZs2fgzEVzxAZrg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add data-ready-delay-ns property for hx711 ADC
this is the delay after rising PD_SCK until DOUT is read and assumed to be
ready

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
index b3629405f568..d0c066e3df69 100644
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
 weight@0 {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
 	avdd-suppy = <&avdd>;
+	data-ready-delay-ns = <1000>;
 };
 
-- 
2.1.4
