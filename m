Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF86ECDFBD
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2DC20868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCJq6L04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2DC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbeGUVQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:16:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35180 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeGUVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:16:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id f18-v6so3925880lfc.2;
        Sat, 21 Jul 2018 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pB4WGB3VFQ2FWQ619kOnwU1YCO9kt/VNE4GZTFk+Soo=;
        b=iCJq6L04KGEIMI42wdezBl/33AzT6FXRXFMmk9jfw3jszsOq3CTrfj1vuhq8drFcLz
         JiIZffkm8R4TbJ76FL4c0weIl/LV23CqwuTN7BwMHHw1wS4r4Qef5ENU2Ofp1YT5Pfv0
         SXDlfyKjtg6yX3qHoQXbph34jOq7+Dk2zalogOC0Z+yAkof+F+vnAtFi279kGbaxtxR6
         M8AF3vMYrUBNSOheU7qxDnpmIpEGEjsRweYzrIMCmBmAiC8+jRhPzlXB9AxbHWxL1ZvC
         RHiK6X5Z2YavSAV6/upIhDEJ1WQxyWE0Donf4XqiKyNGwizUXuCms1zWZYWCqatFlDIK
         pF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pB4WGB3VFQ2FWQ619kOnwU1YCO9kt/VNE4GZTFk+Soo=;
        b=cw69JunA+DSVqSzNHvxfDMH1idSLATt53K/9a4Wqhoie38QwdeWUizKxR+0Mq6zYfl
         x458pAtuq1cuH1eoUxBTt0kRSi3eLvnPeUn6DhQVqY4nqLytLTeaXe7CPZU1u70Hseva
         0Y6uorgc6grMCWtbDNPxJmS2awiIjEkG3fAJLvoVVQQOTVhKDSdrdCyvDpVqST1ikuJZ
         9GP9+Wrv+Cm3rjbOMsgBrDGbbGiinXM1QAdL+O0PZ4W2PWzcgt9k7UGICNmNKjFK0f9l
         wDcjnbOcn1jKuujFk2pyYxNgD6i5QLkVHsHYuSfbbjbN0heFGP8dUzntzQaP8FNpaeWn
         bCJw==
X-Gm-Message-State: AOUpUlFq7edSoP215HfIiwHU6FZS+Te0KnSfbuF9bx4Cq0TxHHv002i0
        AmuQFrOuxs6IPiOKZGRYL4Y=
X-Google-Smtp-Source: AAOMgpdqyoDiDCgDmf1nZ/9AwuzkyVTU78Z+L/Jcz7t7zpY0EXwqIXW1WEE1lSie0PDh/L1vPtM6GQ==
X-Received: by 2002:a19:8e5c:: with SMTP id q89-v6mr3905923lfd.35.1532204544282;
        Sat, 21 Jul 2018 13:22:24 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2f9f0-74736162.cust.telenor.se. [46.194.249.240])
        by smtp.gmail.com with ESMTPSA id z5-v6sm756742lff.96.2018.07.21.13.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 13:22:23 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Date:   Sat, 21 Jul 2018 21:59:22 +0200
Message-Id: <20180721195923.7610-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180721195923.7610-1-marcus.folkesson@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP3911 is a dual channel Analog Front End (AFE) containing two
synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
---
 .../devicetree/bindings/iio/adc/mcp3911.txt        | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
new file mode 100644
index 000000000000..e233ee94ad96
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
@@ -0,0 +1,33 @@
+* Microchip MCP3911 Dual channel analog front end (ADC)
+
+Required properties:
+ - compatible: Should be "microchip,mcp3911"
+ - reg: SPI chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+	 Documentation/devicetree/bindings/spi/spi-bus.txt.
+	 Max frequency for this chip is 20MHz.
+
+Optional properties:
+ - device-addr: Device address when multiple MCP3911 chips are present on the
+	same SPI bus. Valid values are 0-3. Defaults to 0.
+ - external-clock: Use external clock instead of crystal oscillator.
+ - external-vref: Use external voltage reference
+ - vref-supply:	Phandle to the external reference voltage supply. (only valid in combination with `external-vref`)
+ - ch0-width: width for channel0. Valid widths are 16 and 24bits.
+ - ch1-width: width for channel1. Valid widths are 16 and 24bits.
+
+
+Example:
+adc@0 {
+	compatible = "microchip,mcp3911";
+	reg = <0>;
+	spi-max-frequency = <20000000>;
+	device-addr = <0>;
+	ch0-width = <16>;
+	ch1-width = <24>;
+	external-clock;
+	external-vref;
+	vref-supply = <&vref_reg>;
+};
-- 
2.11.0.rc2

