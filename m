Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDEAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A8208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5A8208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbeGJSUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:20:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbeGJSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:20:31 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MeXc7-1fRaqb35I7-00Q8oA; Tue, 10 Jul 2018 20:19:38 +0200
Date:   Tue, 10 Jul 2018 20:19:37 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] iio: hx711: fix spurious unit-address in example
Message-ID: <20180710181937.GA5398@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:AfjvaIs2XiiiZ+qfm7zE388orWpIbVlUsVVkvSdKQM90YScdzVy
 wdVvgBqPZOTOxWLSq70X3clsSHNufG2RivZiNGZ/Nqx/OnKbE6ChtnDCWHJ2Ir8QSVy+7aj
 lSaGuuWRLUYY6L0CP5wh3klL4+1+FZxcvPhnViyFeY2iaopkk/J+EBMY+Rwe4Ov358ZMHBl
 XiO3Fg3CJPEAxVNT3R2xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZgUwC0OU3CA=:Ca8V5kaWvHBlfij5rA9SAS
 pnoCWsUcAKssYqrp1KGbvkAsOxTFyyf0YswKSYB9YhcZYBzo9BZe50VB71E9auj/RXaj6fHAe
 8FI0DJMMn9h5ZY6B9+4B4i2YKTfraxy58IvhIXtIUqtBKc0GqYtgoUu3v8vy/cpRPPwkrHRr8
 sgyabZLi6FNRnhpPW4MbIqQqvyGrZD7p9XtViDHKawc9EyPT8n8tlXaMrrqO4S5kwEb3/81If
 Q2watOevbRrU9wlWqmq5THXn7RlphQ/9o00QVE3qp3GcFu4rHmDNbAaO67qya7Z1Sld4ymYRs
 ALwTz0VZl8fIDtveTB7kxxJlJ8dmps6RAPTg213+o1YmlHy58/1T+d38rLJipDdl5dbYNvZ9T
 Kp0SmeM+92hVbKCGkrxENW01vLpTtpIA4J2jyIfv4lM2ehKH7qJ/UhakcBPyOmjD80SwvulKX
 cKCxDPyXSv78pm9G0LyKisCJ6n0yp4K2Qxi3rNiC1sq2T6B+ia5SQGbccewguWr5xlqIfwZuC
 KaitAZo2BOirvnIiC6YVjNc26YGFl9HOmYbc0InMZbyKYmPlr5FUb4H4ttLYJSrRLNE9DCyhC
 BnpoAWZ0e1RVrmFZLp1jZPEX9XETL+po0cz8E3l4zdO5TD9b6Ph9dt+Lzw9ZIl4YHrw6D7T+n
 /29zl1dxoap1eMtm0Suz6fMgid6U4Xp1dWRt1UY91qVKKlf1fa5ojwTNfVKM4N6jQCAc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree compiler (dtc) gives a warning if a device node has "@" with a
following number as it's name but no reg property.

Fix the example in the documentation of avia,hx711 to conform to dtc
behavior.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
index 2c1b67d33c49..7222328a3d0d 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -14,7 +14,7 @@ Optional properties:
 			high time of 50 microseconds.
 
 Example:
-weight@0 {
+weight {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
-- 
2.1.4
