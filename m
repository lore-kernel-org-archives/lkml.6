Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A64218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GThPR1FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfAXOyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:54:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42146 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfAXOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:54:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so6770445wrx.9;
        Thu, 24 Jan 2019 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ABhmPGY5R9WbQZCOUg69Ep9sFOrMbW9Yd/Mou2MNP2s=;
        b=GThPR1FIQqveqWJUA09vyVo1B40TKnWDJelc1X15jkIVgXIXE1gJKEaHSmTf68n2EX
         bgBPbwDMA0tBtqSKMi/Vkj9rnqUkMxp+Fcqe/UtxHWe6yoEYQ8T2fjSCYB+GfIRYhc24
         /yqXBbjUgmue26ow1603+qeO74riAu7WgP/5g4KhPPqXSP0/KXGslix83Zdx+X4GBHda
         aP7jNWcENLRC2soof3WAc8Q9vy3o1RSjKb02OfYzGBWiuF4DtfR20+ONRCHrz963HeEO
         RjKVeUQs8HyJv/ymjcZh4hnDYT23fOcDClXJYDGPxm+zCyKdk5OXBen/O7LVxwmKMT25
         Is/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ABhmPGY5R9WbQZCOUg69Ep9sFOrMbW9Yd/Mou2MNP2s=;
        b=cXmUO0WYZrYOuqnkZGm1doK0wlolEkZbQ12WD1Zxh+9anI1O3NxRjUMb+Xn24FTi9P
         ipyx8PweeUvttrY3sM3TKWx2fQv978MpbZ4Cdf/Sofidcgadxx/WJAQ2dBViQGv1Udi3
         ydFkwKME71I9AYxb7CWCjS7UZw/3p1n5mBo49qoFOYsTM3PDHTi21hY2i+0Uzx/DX7RH
         Fj/5cU9D5U4l/Jvvf0yOb2tkwWg7N0baW7uIqoeg2WGcFne9CmGEU9EYbo4gXkkWh41Z
         HlmWx30/Y2laHfwibj38UGPV6+YmYVOYqMa1T4MXYFZ6DQ12UwOLRZ4m6t8tJQBqU/rw
         ziQA==
X-Gm-Message-State: AJcUukdhO2RpVo2YUuCK4VMg3EgDg2jGgeBGds8Kp9n6lJJbfFXZ1T+x
        BDpfzY0C6Rh125zzA4UYKV0=
X-Google-Smtp-Source: ALg8bN6K6h+qj5o+iMFg2vxQiMTVEdQV+aewZtWYZrXHZ4P+Eu7lcACvhc1UDvCcudihdtYKLG/jvw==
X-Received: by 2002:adf:8323:: with SMTP id 32mr7250223wrd.176.1548341640105;
        Thu, 24 Jan 2019 06:54:00 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t63sm53611538wmt.8.2019.01.24.06.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:53:59 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>
Subject: [PATCH v3 lora-next 4/4] dt-bindings: lora: sx130x: add clock bindings
Date:   Thu, 24 Jan 2019 14:53:09 +0000
Message-Id: <20190124145309.21698-5-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124145309.21698-1-ben.whitten@lairdtech.com>
References: <20190124145309.21698-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The SX130x family consumes two clocks, a 32 MHz clock provided by a
connected IQ transceiver, and a 133 MHz high speed clock.
It also provides a 32 MHz clock out to the radio in the TX path.

In the example we connect the concentrator to a fixed clock providing
the 133 MHz high speed clock, and we connect to a connected transceiver
32 MHz clock.

A radio in the TX path is also connected to the 32 MHz clock out from the
concentrator.

The connected radios are both fed from a fixed 32 MHz clock, with only
one being the clock source back to the SX130x concentrator.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
v2 -> v3:
* Name input clocks specifically
* Add output clock for radio in TX path
v1 -> v2:
* Fixed incorrect usage of clock cells
* Fixed wording in commit and descriptions
---
 .../bindings/net/lora/semtech,sx130x.yaml     | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
index 24fad1218735..5d32668d6ca9 100644
--- a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
@@ -15,7 +15,9 @@ description: |
   demodulating LoRa signals on 8 channels simultaneously.
 
   It is typically paired with two SX125x IQ radios controlled over an
-  SPI directly from the concentrator.
+  SPI directly from the concentrator. One of the radios will provide
+  a 32 MHz clock back into the concentrator.
+  The concentrator also outputs a 32 MHz clock to the radio(s) in the TX chain.
 
   The concentrator itself is controlled over SPI.
 
@@ -37,6 +39,30 @@ properties:
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
+    items:
+      - const: clk32m
+      - const: clkhs
+    description: Input clock (CLK32M) name from provider, Input clock (CLKHS)
+      name from provider.
+
+  clock-output-names:
+    items:
+      - const: sp_clk_out
+    description: Output clock (SP_CLK_OUT) typically connected to the TX radio.
+
+  '#clock-cells':
+    const: 0
+
   radio-spi:
     type: object
     description: The concentrator can have two radios connected which are
@@ -73,6 +99,20 @@ examples:
 
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
@@ -82,6 +122,10 @@ examples:
         reg = <0>;
         reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
         spi-max-frequency = <8000000>;
+        clocks = <&radio1>, <&clkhs>;
+        clock-names = "clk32m", "clkhs";
+        clock-output-names = "sp_clk_out";
+        #clock-cells = <0>;
 
         radio-spi {
           #address-cells = <1>;
@@ -90,11 +134,17 @@ examples:
           radio0: radio@0 {
             compatible = "semtech,sx1257";
             reg = <0>;
+            clocks = <&tcxo>, <&concentrator0>;
+            clock-names = "fxosc", "fclk_in";
           };
 
           radio1: radio@1 {
             compatible = "semtech,sx1257";
             reg = <1>;
+            clocks = <&tcxo>;
+            clock-names = "fxosc";
+            clock-output-names = "fclk_out";
+            #clock-cells = <0>;
           };
         };
       };
-- 
2.17.1

