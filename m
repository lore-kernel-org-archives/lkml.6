Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2EFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A541C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+sf+BPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfAVSH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:07:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53732 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfAVSH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:07:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so15126629wmb.3;
        Tue, 22 Jan 2019 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8px0zs5XB/4ChUB1gs+Hi0NzZO2T0KRcyHZEa6MOb1I=;
        b=b+sf+BPheANdPAJPuKGQ22h4pdW+44U6cQsBkQ5Rh4JCQkBW44QCcuuTgrg+FoWhek
         daghuExiiyePnXd5yhHClan6hXulZbFD9NsPLudkhWBfE+C51MPG5+Kp9f0GgqZRpLg9
         hjNkSWvUPl0e+wR6LW+jOPnjQbi7Op/1jq9hhIOujW4HCyXy0fZ1SDto+Y07UcW7RyHM
         JtuSkpRAlQ21QM0yl6JDd9Av7xWPLZta+mVjFoo5rjDvYM7NmnnkaEL4PSCDxGbSJzzj
         eWQByCY5rjTyMfUFEAOtCdjEweHNv1Z4HuH1QnHbqv4W25IfeSOJoz/oObyeDib3uEms
         fQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8px0zs5XB/4ChUB1gs+Hi0NzZO2T0KRcyHZEa6MOb1I=;
        b=AyMZVWp8RLYArVzBpldH3Ntj9UKpEiqnHfGD6j5nExZy3rNMMMrpipX+cuP36BWcWI
         TL53ddAhvCUOpTR1PRkMM8xHRtZilRbLRc8wpbsjGNrEjdUE/jdaJd+s2sON01/cLpj9
         qYbQFZzE/4MkScqNjn98Up+qohW2t+QcZWMyA3KcgclmXf7ApqWbK8qMX8bQ0Ls4OZb0
         Uk7E1AmWxl5TC4mPsCteIlcrTvOQnvSe0EiAdCfUSKrCYHd9vuKTpBGq3L9nlrfARwGY
         FdLVMWGC0kbJJucy8Qa6vQV8asCJGQ/iofdQK4FBL53WPvrDvAiMC+N55V/vP7sMP4FI
         a1tA==
X-Gm-Message-State: AJcUukfbRho2uRvHVUbElY9eB4NBoXFTkY/ps6IdswnMWiJez08zFXH4
        RzRQXN2qCxQpbh5VDEGRT/Y=
X-Google-Smtp-Source: ALg8bN5l/trBauNT6JfZl62VCJnONMeBHcIbZUCUShnainOzJuLg7nCraWl3BqSLua94kEu30hV8+Q==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr5069503wmg.42.1548180473587;
        Tue, 22 Jan 2019 10:07:53 -0800 (PST)
Received: from Sarah.lan (229.98.125.91.dyn.plus.net. [91.125.98.229])
        by smtp.gmail.com with ESMTPSA id 129sm93804220wmd.18.2019.01.22.10.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:07:52 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-lpwan@lists.infradead.org, robh@kernel.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 lora-next 3/4] dt-bindings: lora: sx125x: add clock bindings
Date:   Tue, 22 Jan 2019 18:07:28 +0000
Message-Id: <20190122180729.1834-4-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122180729.1834-1-ben.whitten@lairdtech.com>
References: <20190122180729.1834-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The SX125x consumes a clock (FXOSC) ranging from 32 to 36 MHz.
If the radio is coupled with an SX130x the radio is therefor operating in
master mode and it may also provide a gated version of this clock for the
concentrator. In this case the concentrator is expecting a 32 MHz input
clock.

In the example we connect to the "txco" clock source, represented by a
fixed clock. The radio also provides a clock output named "clk32m" for
consumption by the SX130x concentrator.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
v1 -> v2:
* Fixed incorrect usage of clock cells
* Fixed wording in commit and descriptions
* Dropped enforced clock names
---
 .../bindings/net/lora/semtech,sx125x.yaml     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
index 4a51a251d97f..8287472fd545 100644
--- a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
@@ -27,12 +27,36 @@ properties:
     description: The chip select on the SPI bus or radio number in concentrator
       , with radio A = 0 and radio B = 1.
 
+  clocks:
+    maxItems: 1
+    description: Input clock (FXOSC) provider with output ranging from 32 MHz
+      to 36 MHz.
+
+  clock-names:
+    maxItems: 1
+    description: Input clock (FXOSC) name from provider.
+
+  clock-output-names:
+    maxItems: 1
+    description: Output clock (CLK_OUT) name, clock is gated version of the
+      input (FXOSC). Used in master mode operation.
+
+  '#clock-cells':
+    const: 0
+
 required:
   - compatible
   - reg
 
 examples:
   - |
+    tcxo: dummy32m {
+      compatible = "fixed-clock";
+      clock-frequency = <32000000>;
+      clock-output-names = "tcxo";
+      #clock-cells = <0>;
+    };
+
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -40,5 +64,9 @@ examples:
       radio0: lora@0 {
         compatible = "semtech,sx1257";
         reg = <0>;
+        clocks = <&tcxo>;
+        clock-names = "tcxo";
+        clock-output-names = "clk32m";
+        #clock-cells = <0>;
       };
     };
-- 
2.17.1

