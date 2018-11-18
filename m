Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED674C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42122086B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="TTYvO4L9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42122086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeKROp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:45:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40892 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeKROp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:45:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so43866254qki.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 20:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LbTCHeHGilCnfPYHT4tj0WlGCcK4WPxi/1Koox5eezY=;
        b=TTYvO4L9TcRHBUUw2NnvzLiUiM3++li0s4a7l/VOBv/6bAH987r2kgUZTvtYFJumC1
         UZy91qqULKSAqYS7er192QUFA+Ti3kKn4PrCqc0WRTkFrTOWJWHNPbqVuQdONeZRt4mT
         pdxQI3CpZMm854UoKowpiJdiRQAmw6WGn0HKrTwxKQCASX9MYIJ/aPQo/VydLkvaGyaB
         ea4PCOASYqGNHsYBnkuS64WMIG4TqlTdaDu/M0OH342KyoOw6IfvjlVAYQTWzmnn+WKC
         CJ2GvZKGI+S+FypjbCpeSdslYANH4uAI3ZoIOfVykmAUNS6HqYd5R8T9gB+uVbNCTIjB
         T78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LbTCHeHGilCnfPYHT4tj0WlGCcK4WPxi/1Koox5eezY=;
        b=uY6lKsWyJEq63e0E1gRhEYf3qvEXksOLUvFmhe83EzwKw4kje0Knu9hmhwqrzU9TmP
         0W2bkql0qJtaSdcwh0p7SxSemQBnSoDGjr4IIIYlxo3Og8bHu+bm1amj/L0ze86CdOIF
         uiw8N3jJ6UoHuOm4jL+IYR0mDvvwAmMcu6w7Eo9ki2Va0u86pW5k2e0eenF7ttMFpmsk
         izR7M/TzY4gbM86YoSBaPl8gBRcYmAhSwcbzOT9Gfs9yTJVZPxzjefG6ufsZ0PPNbNGL
         sN66YrEcclcU44CKs5nSbJQ3nBjXoDq8Zw1rQUsQGM+sz27JwsxuKcRQHa8MmTuc6YPW
         CpbQ==
X-Gm-Message-State: AGRZ1gJ99BZe0gA4tlV/qCr4PwGyHmnwl6hVZURoBrtVUt7TFN8Y9sgj
        DVgx9luQlD7BNJxboPp18t/MCQ==
X-Google-Smtp-Source: AJdET5cj17K9hOJ2qdLJcjLj5wyrp0r54jer/usB4snabjxxPT/OptGG0AG3DMR4u3kDF/hJOzUtjA==
X-Received: by 2002:ac8:22ca:: with SMTP id g10mr16745011qta.105.1542515187492;
        Sat, 17 Nov 2018 20:26:27 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id b6sm16112350qtq.29.2018.11.17.20.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 20:26:27 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v2 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
Date:   Sun, 18 Nov 2018 02:25:37 -0200
Message-Id: <20181118042540.12697-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118042540.12697-1-matheus.bernardino@usp.br>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree binding documentation for the ad2s90
resolver-to-digital converter.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Rewritten 'spi-cpol and spi-cpha' item to say that the device can
 work in either mode (0,0) or (1,1) and explain how they should be
 specified in DT.

 .../bindings/iio/resolver/ad2s90.txt          | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt

diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
new file mode 100644
index 000000000000..594417539938
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
@@ -0,0 +1,28 @@
+Analog Devices AD2S90 Resolver-to-Digital Converter
+
+https://www.analog.com/en/products/ad2s90.html
+
+Required properties:
+  - compatible: should be "adi,ad2s90"
+  - reg: SPI chip select number for the device
+  - spi-max-frequency: set maximum clock frequency, must be 830000
+  - spi-cpol and spi-cpha:
+        Either SPI mode (0,0) or (1,1) must be used, so specify none or both of
+        spi-cpha, spi-cpol.
+
+Note about max frequency:
+    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a 600ns
+    delay is expected between the application of a logic LO to CS and the
+    application of SCLK, as also specified. And since the delay is not
+    implemented in the spi code, to satisfy it, SCLK's period should be at most
+    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which gives
+    roughly 830000Hz.
+
+Example:
+resolver@0 {
+	compatible = "adi,ad2s90";
+	reg = <0>;
+	spi-max-frequency = <830000>;
+	spi-cpol;
+	spi-cpha;
+};
-- 
2.18.0

