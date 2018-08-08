Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7861CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD89216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzixXV4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD89216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeHHKvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:51:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34633 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHHKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:51:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id n96-v6so999572lfi.1;
        Wed, 08 Aug 2018 01:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKvCP6Yrq5nNjW/NO8RxvpTcxwJqX9GW80UsDhEpxSM=;
        b=hzixXV4Kj67rDgb8loSyydvOZjRGdjZC8kCaRMYP9Wa6/1BssfN4ojCi36e9Yka28s
         APfPhXZBCCxyzHP8Lk96dJI7xuSaDIvn4SG62KMKgmF23gCJpMq5m9VcT46qZn41Zztj
         1V4ZlISd+usnRnUIEdqENnxx29431TtvcmqaJrb7HDLY08366GIDSiccyw46JG3Gwk+v
         iytXy39sObDltW/R/EAYfLa6mJIWBH5hcbKdDCyeeEinuvGTpY6lcsGOhhCmPF0c8eV3
         IVCM6QYHyH85nY079DzL9tNKixTuTdNFEZr/746iO0fh3SfOZ+cr2wMcPQnm3oMs+nyY
         VbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKvCP6Yrq5nNjW/NO8RxvpTcxwJqX9GW80UsDhEpxSM=;
        b=Umv0cjnwPoxMQwGrwz6LkeO3JWtB5mAMbnmgq860ZRNZz7Wfx0E4K+n7k+K1DToci+
         WDdaNA8Cqzcqu1OF8bg1Ona1rOWxYDw/8YIFvIPcbSndfEaJX7ls392dsjiJWKGo3P8n
         fUbLNV+Ai6XBZiaBMPwiU1ortcjfIeh9/TY2BI7ysb8OLru5fCY3AJ9x1YAmt2vSL5eF
         2RuOp25owuUOKcXNycWXNnqqgT3Ogr+FZTatGtB7Nuyl35iMUWvCc5zEFXKqocG9mM38
         DymoyBD0ZvGK+tWOOhX7212IP+lpXtJlQWkyj0frWH0QOcdhbtfX5vDJ18wgv00BRgrJ
         LJ8A==
X-Gm-Message-State: AOUpUlEPrGDa5pmURbAQz409r377jIhOrPtC9okiFXiMzaSRG7jVtsVH
        vOMNZ2Tif6vGuu4f3O8lF34=
X-Google-Smtp-Source: AA+uWPzDWzHNoXq99TW/RSoGf97lXJnzPnJ79Vupah4pTafBNp3CK54fLgDk68SypzDlOjgkxJkO0Q==
X-Received: by 2002:a19:6902:: with SMTP id e2-v6mr1213074lfc.70.1533717191295;
        Wed, 08 Aug 2018 01:33:11 -0700 (PDT)
Received: from localhost.localdomain (c-2ec252a3-74736162.cust.telenor.se. [46.194.82.163])
        by smtp.gmail.com with ESMTPSA id f136-v6sm708782lfe.71.2018.08.08.01.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 01:33:10 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Date:   Wed,  8 Aug 2018 10:09:16 +0200
Message-Id: <20180808080917.2427-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180808080917.2427-1-marcus.folkesson@gmail.com>
References: <20180808080917.2427-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP3911 is a dual channel Analog Front End (AFE) containing two
synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).

Co-Developed-by: Kent Gustavsson <kent@minoris.se>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v4:
    	- remove reference to Documentation/.../interrupts.txt
    	- add Kent as co-developer
    v3:
    	- add bindings for interrupt
    	- prefix device-addr with `microchip`
    	- drop `clock-names`
    v2:
    	- drop channel width
    	- drop `external_vref`
    	- replace `external-clock` with proper clock bindings

 .../devicetree/bindings/iio/adc/mcp3911.txt        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
new file mode 100644
index 000000000000..3071f48fb30b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
@@ -0,0 +1,30 @@
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
+ - clocks: Phandle and clock identifier for sampling clock
+ - interrupt-parent: Phandle to the parent interrupt controller
+ - interrupts: IRQ line for the ADC
+ - microchip,device-addr: Device address when multiple MCP3911 chips are present on the
+	same SPI bus. Valid values are 0-3. Defaults to 0.
+ - vref-supply: Phandle to the external reference voltage supply.
+
+Example:
+adc@0 {
+	compatible = "microchip,mcp3911";
+	reg = <0>;
+	interrupt-parent = <&gpio5>;
+	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+	spi-max-frequency = <20000000>;
+	microchip,device-addr = <0>;
+	vref-supply = <&vref_reg>;
+	clocks = <&xtal>;
+};
-- 
2.11.0.rc2

