Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2926730-1524570177-2-3323936057775488745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524570176; b=RvZ3w/d8m5X5QTtamTe83/bhDi4o1Ah9tPn64erogRpXoi2XI1
    VVnx6xNMWxUDlRDb2wO//kqGqP8ZQDuMz0Bo5wHrfM+hTi6RwMo0KrJe6UWJObUS
    AeVgf0E6YLye6oCA7F4qrTIEJDcOk5ypUSvn8PHUBnBPpszcN6KYWIzuxJUrRRyk
    23S+wW8L9UQtZQCVsycw/7r0AwYgTaDPBnPJV9t5guZHbC793DnHQwriL69m2LY6
    C6zD1mU2HfDL7nAmjUCpRGS9vCvYbxPClDW/w+yACxFtYdXkE7uq19pmuEeO/nzw
    gwiAhzvfxAWihyuvqEUdKdwciD36p6Fotluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524570176; bh=
    YYWHRh442Y2+JQnJzvmGWM6DnTG5BoPyLFp16w/Ps+o=; b=pkXSz+Hd03zDtuhN
    YrN+8EWL1wN7LsW2Jq9/P9IgUuWnx55hjmjzTnLOFcxDKLe9f0SE6qjqV/XLp8RE
    qQ7jSgB2yI5oEKaXE4ObecguFism8vmANr8KxeE9zuL7XaDgRD/wa/7dKAan/wVu
    b8HAZaVHWEqXd/WnA1eki0+DJd24EmGUppN6OpJbMQvqrRxXs3gLcZd9dcOKIJL9
    SUrQfIuoK4GjKyfUUahhwcAdQpDB52uGBiXjmymJbvQ/MuwIJ85J3npmSVgeyy5I
    OaLAtT65jatO603CtvMTSZGE8/BUpGFulELyiGFZ6ks0h+Y4ZH8K16+HDBcTOVi3
    ZN9ZRg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB0KTl1nP3dU17U7Ys60JUBujijcjpK9v7weWt2Tzz8E+NLSpo5l5SGyWEUawC9f47nSV4J8L4/Pi19X0snXUVU1BJrUdH0NSXn/0WXVcJLyaTlJ4mB2
    WAbF2WgxWQA7vQS4i0Ax19URhAE6q153MP1341XLfuZ1FKa3Ft1qWNt8sXb/LKtQPIBt6+F0REtsySXZ/aL2lRdj4Jd80GYlMmDzMsrC0aIRbL+aTimc3myV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=zu6OG0ZhAAAA:8 a=EZO-SZ4-EcPVLntcA8kA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=pAN39diAhXWuPx0-Vjn3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeDXLmy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 07:42:54 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:36378 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753080AbeDXLmy (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 07:42:54 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/7] ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2 regulator voltage
Date: Tue, 24 Apr 2018 19:34:18 +0800
Message-Id: <20180424113424.13196-2-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424113424.13196-1-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The voltage of the VCC-1V2 regulator on the ALL-H3-CC H3 ver. should be
1.2V, not the 3.3V currently defined in the device tree.

Fix the voltage in the device tree.

Fixes: 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre
		      Computer Board ALL-H3-CC H3 ver.")
Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index 5971b8b0b768..db6b35bb65ff 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -62,8 +62,8 @@
 	reg_vcc1v2: vcc1v2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v2";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
 		regulator-always-on;
 		regulator-boot-on;
 		vin-supply = <&reg_vcc5v0>;
-- 
2.17.0
