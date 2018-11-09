Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F93C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54352208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ahqEazFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54352208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeKJHoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:44:00 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43037 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbeKJHoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:44:00 -0500
Received: by mail-qk1-f175.google.com with SMTP id r71so4343326qkr.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LhpxHGS44Lcj5Lch5D6YJeYb8TZ7ZrrJRAOf+39PfYk=;
        b=ahqEazFPXrR326X1+ybyRmOJ54W6cO27ZGRlOy4Nn929cxSXbcA6ac+BrYxLEZkiQW
         bCGG/IbrQo3dkvj3h9xmZSzoPKrE5ArMVbTuMoo8hg83QvLFkcF7rjoimSM9zjoazo2G
         /8dL8/WQVmkUIyboPHNj7Nv5wIC5zQosAZd58BMNGEelZ3KzC+EFfkUMGQVn8BD0L87w
         l9C3uYJD5dpLf4PM0QgmWwaLRMSg0FyNgYxbv8bTwVzijdXsRmUfTPQUHvZjDetKBw76
         vZoGEE0HL+JQJOCtU4OrTpdr255YHCecMUfdEHB+05mgD4dppvY5F6BGI8SEHQv6WvZz
         QNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LhpxHGS44Lcj5Lch5D6YJeYb8TZ7ZrrJRAOf+39PfYk=;
        b=fly1wMjAsHICFQfRlPr6Mv/ydowsEh3OTaJ0YnLQJXW06V57BKBisZa2S4Z1tySnfE
         KsH6XG4e6mbp6wxoSxiuA49jboI74PCrvsGGi2vMTrc+3gma3bH4F5ugyV05C640zGcs
         Zemd1mg7Abjff81z4Z1sx19GwY4TfBhVglJuAV+O/foq/30SGzfg0a1R+x2GPKpGVD0r
         v/MZoC71tisu0K8D4XZ8EYJc8g6WUk41EsAce13QejhmEP5jqGSdQyLuhWJmCbmOX/F5
         0wFrN3MepHxVuDkeaw+tA41HGzMGgcxM8SgedQtMBE3ZamvHyD1m0d77K/5piw5J4xjP
         2Djg==
X-Gm-Message-State: AGRZ1gKI4ugoLVe/z0wqQl0yN+w7kXxp7tobVVGkyF2gswF6NUVyRql4
        tVSs4mDyf3hgHCyFGAiPAKmiHQ==
X-Google-Smtp-Source: AJdET5dfosKORZMJ/SXRBPjaQAUx4+GjI4d149fU+6gZ0txwAQIOts5VEfXZOUAkOX06qgBHKfvbQg==
X-Received: by 2002:a37:2008:: with SMTP id g8mr9822709qkg.120.1541800889594;
        Fri, 09 Nov 2018 14:01:29 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id k6sm6082723qtk.41.2018.11.09.14.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:01:29 -0800 (PST)
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
Subject: [PATCH 4/6] dt-bindings:iio:resolver: Add docs for ad2s90
Date:   Fri,  9 Nov 2018 20:00:42 -0200
Message-Id: <20181109220044.24843-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181109220044.24843-1-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree binding documentation for the ad2s90
resolver-to-digital converter.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 .../bindings/iio/resolver/ad2s90.txt          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt

diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
new file mode 100644
index 000000000000..b42cc7752ffd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
@@ -0,0 +1,26 @@
+Analog Devices AD2S90 Resolver-to-Digital Converter
+
+https://www.analog.com/en/products/ad2s90.html
+
+Required properties:
+  - compatible : should be "adi,ad2s90"
+  - reg : SPI chip select number for the device
+  - spi-max-frequency : set maximum clock frequency, must be 830000
+  - spi-cpol and spi-cpha : must be defined to enable SPI mode 3
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

