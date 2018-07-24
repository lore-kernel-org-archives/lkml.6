Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440AAECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FFB20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJpdDjKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FFB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbeGXUAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:00:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41060 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbeGXUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:00:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so4499282ljy.8;
        Tue, 24 Jul 2018 11:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1QrJ9VckbUPpX37Ei7qrFRSaKDtiOV4qBRPgod67DcU=;
        b=hJpdDjKiU3DwtyKeOzCHtO+EWjBsCD/CSPovk070/Af6RKcjOeQUA4TunvgQpoSUc0
         UniBSnPC+lhPip5tI98drVQux/E2GgAQ/jQnW6KDvRT7OXB4GoTcGv5GDGOyQRexobtg
         DurOpfn5mfWfmN6V5ZnJ7IOHKCQ+k4nPvmaZyf64g9ONC4QDV9zhUCT/1eqiqjU41sp0
         IWMqrX8r2qCxd/80xUvH3dUpZPcf3Vc35U3JU4P8JpmZWreUw/GYczYHg5CHnbfz1F/B
         EBRmnNDVoZ3X7e54YgFxnGd4rk6POvlDwAl6UMXUk90oe8mpcgRK2xOF/D99AdDC0ncZ
         hKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1QrJ9VckbUPpX37Ei7qrFRSaKDtiOV4qBRPgod67DcU=;
        b=JZh4ingeAxB7FNFRJpH5M3ZLRn4IVIuoxWZm40VU1zkWC8EtplgANjz0ZV0VyL1/4q
         FAFwLABuZLbhbCZWbtIYUUU2UTF29SorY0HAOYk5inScphrUBr8NJzRAliuBXNcG+Rnr
         R9ECn6cX2XTaP7jZZfGeta4Rff57P5UVwJiQ6UvRtrnmdU2THRzVOuklpCOMzF3GvIBw
         XrkjIAWXuWYfBMLJBeMOGsutnf6m1bJ4XSXA1m88fYQaU9Q9n/oPFoSEvSSZT3msFJbo
         V+uXSMAId8cryrCjkIJU5lUaSxzASGWcyAx4/s99zdpgZj97q8XTIyl2jUBDevGbe33Q
         BDKw==
X-Gm-Message-State: AOUpUlHfISXI8NaKHAcVE2M7M2RjfJGRuGO2g2KaHh1HQP6NDaSP7vLf
        jBlTa6ged6ZzBnzQqcEcCEs=
X-Google-Smtp-Source: AAOMgpfyGP2dL98jEscqAz6vyqrzHSxapWnjn2vRTyoQ0i4wJNJfw9exjMBnOEIMxRiF4otZpkLk6A==
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr12683646ljb.86.1532458375722;
        Tue, 24 Jul 2018 11:52:55 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2f9f0-74736162.cust.telenor.se. [46.194.249.240])
        by smtp.gmail.com with ESMTPSA id q14-v6sm1899287lfq.7.2018.07.24.11.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 11:52:54 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Date:   Tue, 24 Jul 2018 20:30:03 +0200
Message-Id: <20180724183004.20279-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180724183004.20279-1-marcus.folkesson@gmail.com>
References: <20180724183004.20279-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP3911 is a dual channel Analog Front End (AFE) containing two
synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
---

Notes:
    v2:
    	- drop channel width
    	- drop `external_vref`
    	- replace `external-clock` with proper clock bindings

 .../devicetree/bindings/iio/adc/mcp3911.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
new file mode 100644
index 000000000000..af5472f51a84
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
@@ -0,0 +1,28 @@
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
+ - vref-supply: Phandle to the external reference voltage supply.
+ - clocks: Phandle and clock identifier (see clock-names)
+ - clock-names: "adc_clk" for the ADC (sampling) clock
+
+Example:
+adc@0 {
+	compatible = "microchip,mcp3911";
+	reg = <0>;
+	spi-max-frequency = <20000000>;
+	device-addr = <0>;
+	vref-supply = <&vref_reg>;
+	clocks = <&xtal>;
+	clock-names = "adc_clk";
+};
-- 
2.11.0.rc2

