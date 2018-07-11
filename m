Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B0120C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqufhuFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B0120C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbeGKSAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:00:36 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32920 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeGKSAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:00:36 -0400
Received: by mail-io0-f195.google.com with SMTP id z20-v6so24833720iol.0;
        Wed, 11 Jul 2018 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WX4l85ZsTDv6EbsxhJ4gmKlqmjuEbVTB8jyGLPldx5g=;
        b=KqufhuFi6joY574vp+Sup05zjPhSkaFuv3q6iLKIhiOS/d2HalQ0EhHQhzIGmDq/f5
         tNkUCr/3EJGIXA101X9AxNDdcjaAyo3NiCB0SU0nk2sOJTASIxnUZ8INuuDIIay37qD3
         nafHo+r7dueZeYnyiFfTcvKdbCCKXznvKBr3knhbgzVPfyaYZYNm36FxYqwo1gbM94NC
         U+Apb/kxB1WijuoJxUDFpzvqSfxL8Bx/nwqT9X4Sx0S+/np9nWEzXt6XY/ijCgUVp/Mg
         +mMztn+raQR0m/Pq58q8NHqKL9kGFdL5n2/L+w7IQeIRmC4CvH5pgirxfV8XBG9sHJIr
         kjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WX4l85ZsTDv6EbsxhJ4gmKlqmjuEbVTB8jyGLPldx5g=;
        b=sxN0T8x+Cojsp8Im7xJAZivfmcQQ5WOtzhAfiJPhXl9G1I86fSnoDjr7I9YI3jEhIy
         cizcsnDJWKt5aaYQlgNbKoIILlBPTwJ/GqvBME0fZ1a8CvkiFJSRcFq4Eys04aYTGa8H
         jyLG4Uus69AdoD3k1uMmq9ZCHSKOoSpy0NqIOpvkNyKd6vB3ApYaPH8CYpscrv2MIWTF
         dTU55Kf2QRwJtGxcl2zxCpAsmYzZP0w3wWFtR0EAys8ccgB1FhG9uU1wqj86s5ThnXvP
         HnFdLL0gdsJ/MngCw+DFQv8zk/teKylUtDgVgU2Vqark4/y1uomsY9ALfB5NVf6pcrM0
         lAcw==
X-Gm-Message-State: APt69E2fKZ/d0LjnptfDjjoyqSyUhOIb1sbMBWYgTEseAtT8/6ZRJ6uU
        8/HmeghQvt6tCN5WCsjm81A=
X-Google-Smtp-Source: AAOMgpeBUcu2uwqvcHE6q2qkf7gwQCSwpEMuBSASr/xdEmLKGT/GlWupawwenQcngJJX8QOKZ8B8EA==
X-Received: by 2002:a5e:d713:: with SMTP id v19-v6mr24861409iom.75.1531331710149;
        Wed, 11 Jul 2018 10:55:10 -0700 (PDT)
Received: from localhost.localdomain (c-75-73-34-135.hsd1.mn.comcast.net. [75.73.34.135])
        by smtp.gmail.com with ESMTPSA id z21-v6sm9833813iog.63.2018.07.11.10.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 10:55:09 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     adam.ford@logicpd.com
Cc:     Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: DTS: am3517.dtsi:  Disable reference to OMAP3 OTG controller
Date:   Wed, 11 Jul 2018 12:54:54 -0500
Message-Id: <20180711175454.9464-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM3517 has a different OTG controller location than the OMAP3,
which is included from omap3.dtsi.  This results in a hwmod error.
Since the AM3517 has a different OTG controller address, this patch
disabes one that is isn't available.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index c17cfe6a2132..cb264220dcb8 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -87,6 +87,11 @@
 	};
 };
 
+/* Table Table 5-79 of the TRM shows 480ab000 is reserved */
+&usb_otg_hs {
+	status = "disabled";
+};
+
 &iva {
 	status = "disabled";
 };
-- 
2.17.1

