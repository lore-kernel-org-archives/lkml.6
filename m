Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAF1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE51921019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5NkXy7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfAVSIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:08:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56255 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfAVSH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:07:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so15024910wmc.5;
        Tue, 22 Jan 2019 10:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hZeBjCu63s+G7vddlBdkWNetlj8fXMGpFNN+/TY6MRo=;
        b=L5NkXy7aTZ8XKkEQ/JkvZbIskcmBYB+a3VnftUaqDil89m7SsIgq3oxan6rwJ8Avhl
         2GSb+9q5bBIpRP9UI6vGES+Jb6fL8G9XX0udqBOFDvAdiib2mik73HXTqJH8yx3EtEMY
         tQBLiPjLIg/7g/vaCgvW7KWDXZ6+UWJLPFwkxpRnS85dtHRswFJwShPLAVW8CddnsbjR
         9XCsOnWmoqn68FVwVypwOLAH0QK+S4/4sHQUViVeOQuEzPrl1sT5PZwIDe5lTrw/T11T
         ZUBJNS6T+MwzqorWoQd7LfNE1kKTH4BMKzf/G44KtXedniuOuLTjw9B+dBsDGGEiTl8e
         sD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=hZeBjCu63s+G7vddlBdkWNetlj8fXMGpFNN+/TY6MRo=;
        b=dKiFHC9p9meIV39Rp/ipKivAKo0L/DsZkJOhKSR1E8Fo/UTFAA0j+21asx6KsUCajW
         D6PoRomTVGSBNQo8pRgN5WksJ2lLpt/+lV5TbS4nCA3jYSjeSosfZH/Hd6cYGMO83K7p
         Kc3tiY0QH4YNmVjFurbDAzKVAfk9bQsJffR+LsqM5T+f7pbuzZ6J+rRDDH4E2wXbRfFF
         KZJWaggYYobib5+iuAiO2ZUzHu6Q5UsRr8Axn49YkLA6V7hvp4yvOFCDqjsSWS8Ml+Lw
         UbDFzZRwZHUD3gMB7a0aZ/fx1tVbHUjMiwoInlK9S12MsNcX/VL6DYkBxNi4apeBwRdE
         QocQ==
X-Gm-Message-State: AJcUukdHJXcriHfWkAlGk7F3aSTBz2ggagl3/VJ1Lz9cdXZWKxRmnPCp
        wFFfQWxDTmAyh4TdsZ9SGJc=
X-Google-Smtp-Source: ALg8bN5Zo0pemL2//iH2rmrKltZVYNT0Zjv+/EW6dVIXXeVSjLinkFlnrHqbdKr7OL/h2lXJU/Dj6g==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr4894994wmg.51.1548180474781;
        Tue, 22 Jan 2019 10:07:54 -0800 (PST)
Received: from Sarah.lan (229.98.125.91.dyn.plus.net. [91.125.98.229])
        by smtp.gmail.com with ESMTPSA id 129sm93804220wmd.18.2019.01.22.10.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:07:54 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-lpwan@lists.infradead.org, robh@kernel.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 lora-next 4/4] dt-bindings: lora: sx130x: add clock bindings
Date:   Tue, 22 Jan 2019 18:07:29 +0000
Message-Id: <20190122180729.1834-5-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122180729.1834-1-ben.whitten@lairdtech.com>
References: <20190122180729.1834-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The SX130x family consumes two clocks, a 32 MHz clock provided by a
connected IQ transceiver, and a 133 MHz high speed clock.

In the example we connect the concentrator to a fixed clock providing
the 133 MHz high speed clock, and we connect to a connected transceiver
32 MHz clock.

The connected radios are both fed from a fixed 32 MHz clock, with only
one being the clock source back to the SX130x concentrator.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
v1 -> v2:
* Fixed incorrect usage of clock cells
* Fixed wording in commit and descriptions
---
 .../bindings/net/lora/semtech,sx130x.yaml     | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
index 41919fb67ec4..6f9db3c84385 100644
--- a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
@@ -15,7 +15,8 @@ description: |
   demodulating LoRa signals on 8 channels simultaneously.
 
   It is typically paired with two SX125x IQ radios controlled over an
-  SPI directly from the concentrator.
+  SPI directly from the concentrator. One of the radios will provide
+  a 32 MHz clock back into the concentrator.
 
   The concentrator itself is controlled over SPI.
 
@@ -35,6 +36,20 @@ properties:
     maxItems: 1
     description: A connection of the reset gpio line.
 
+  clocks:
+    maxItems: 2
+    items:
+      - description: 32 MHz clock provider (CLK32M)
+      - description: 133 MHz high speed clock provider (CLKHS)
+    description: The chip requires two clock inputs; A 32MHz clock at CMOS
+      level which is provided from a connected radio.
+      And a 133MHz high speed clock at CMOS level provided by an oscillator.
+
+  clock-names:
+    maxItems: 2
+    description: Input clock (CLK32M) name from provider, Input clock (CLKHS)
+      name from provider.
+
   radio-spi:
     type: object
     description: The concentrator can have two radios connected which are
@@ -68,6 +83,20 @@ examples:
 
     #include <dt-bindings/gpio/gpio.h>
 
+    tcxo: dummy32m {
+      compatible = "fixed-clock";
+      clock-frequency = <32000000>;
+      clock-output-names = "tcxo";
+      #clock-cells = <0>;
+    };
+
+    clkhs: dummy133m {
+      compatible = "fixed-clock";
+      clock-frequency = <133000000>;
+      clock-output-names = "clkhs";
+      #clock-cells = <0>;
+    };
+
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -77,6 +106,8 @@ examples:
         reg = <0>;
         reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
         spi-max-frequency = <8000000>;
+        clocks = <&radio1>, <&clkhs>;
+        clock-names = "clk32m", "clkhs";
 
         radio-spi {
           #address-cells = <1>;
@@ -85,11 +116,17 @@ examples:
           radio0: lora@0 {
             compatible = "semtech,sx1257";
             reg = <0>;
+            clocks = <&tcxo>;
+            clock-names = "tcxo";
           };
 
           radio1: lora@1 {
             compatible = "semtech,sx1257";
             reg = <1>;
+            clocks = <&tcxo>;
+            clock-names = "tcxo";
+            clock-output-names = "clk32m";
+            #clock-cells = <0>;
           };
         };
       };
-- 
2.17.1

