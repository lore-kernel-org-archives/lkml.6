Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99887C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA4D20672
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="BYGwc2t+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA4D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeKXLKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:10:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40489 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeKXLKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:10:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so12040327qtf.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oroyWqz7mhwKQukHd290ZNW1AWaEfORaZNjSC7qXdww=;
        b=BYGwc2t+78nSAvWlAoJvLaAmAwN1ZVk/Qj4LJBbed0k+XO9/aUiy2xhGc+hK/hAZkZ
         pMd3w5zXmFXuwuf2G243LRnK0uNgHb9aqyFJektF4xj6Q+yUQ3iXwBmgRSaRC9iO3IUf
         31slpD2Wj0RlAyR8AvmRyZPQvtIzskP2hActL81Z9i9Xx1J2vfAQSGVuwAdfX0q1orH6
         ZpOz19zw+LV323H1nDqnm/Hcc1ZRyJmLOnSZmLvktSGtW3nKXbG7LXRDrhHqEJvwEG1g
         Qc+Vs9BxjQgALn1oDeUu9+dQoo336blSsGIqYtVH+wyGW7g/p6vard7M3meDK6+7owe/
         1Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oroyWqz7mhwKQukHd290ZNW1AWaEfORaZNjSC7qXdww=;
        b=V9q8hg7isIUqs09Z4Zs1jRwi4c02y8jmP1vIgYnAh8vTvGyIW6V6OlCmQN3x4/jtgV
         pIOUqZIy0heiuZD9CuFihQ8hDh7EvX8gpSKpD+kUIcmHruiY2oJviBINfTCZH2bslbhR
         d9N+qhirqJDoHace0qcgNKblv4HYfnnU9Whe/wtPBtMf/Thgplht4M3u2lzisLd9+bOE
         cSJz9rcLTINHiuy7KYCw12ANK7QShmiPILekmyfioEU9bo8cO7uEEux0WvoDvoETn+wI
         +VNQ5ip/Db2MGO1QnkfNa5LY/Z6IQyHKoi15o+cUVAnpROvPRywkMMrXBkxK0/ji4yEw
         3UEQ==
X-Gm-Message-State: AA+aEWbW8r2smX6ECpXHYbu28lGFY4AdvGjju/IkyE0HkEVKGi4BMO9W
        nqOmDQhwnXI35TiGiohgHVn6Ig==
X-Google-Smtp-Source: AJdET5frUkPkzzrbrfSqMk1BTi1FOy8WYbKVrirfDYOci7yt9b8LyaBNeWMjvjxM65hKPnQhEOZNcg==
X-Received: by 2002:ac8:543:: with SMTP id c3mr16913925qth.34.1543019022545;
        Fri, 23 Nov 2018 16:23:42 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id o34sm26707515qte.4.2018.11.23.16.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:23:42 -0800 (PST)
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
Subject: [PATCH v3 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
Date:   Fri, 23 Nov 2018 22:23:09 -0200
Message-Id: <20181124002312.6923-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree binding documentation for the ad2s90
resolver-to-digital converter.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v3:
 - Added reference to spi-bus documentation after spi properties, as
 suggested by Alexandru Ardelean.

Changes in v2:
 - Rewritten 'spi-cpol and spi-cpha' item to say that the device can
 work in either mode (0,0) or (1,1) and explain how they should be
 specified in DT.

 .../bindings/iio/resolver/ad2s90.txt          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt

diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
new file mode 100644
index 000000000000..477d41fa6467
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
@@ -0,0 +1,31 @@
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
+See for more details:
+    Documentation/devicetree/bindings/spi/spi-bus.txt
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

