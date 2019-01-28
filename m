Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B97C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1090321741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azGyiivK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbfA1RFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:05:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45673 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731037AbfA1QNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so18654318wrr.12;
        Mon, 28 Jan 2019 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+sJQfhRPX6mgylgaohdp6BE3uFottGVMdhI97In/E4=;
        b=azGyiivKbCzx3Bvy+KIIjB2yZfo2+rITf8W3lChR2G2ZxvIivU9DclhzliIDCRkNfB
         3djqkW/od2EwAeDq9yMKepogcPGIWr1DaxqWrI4Pv9yQ+ko1njFBmzzy5L4wgUQjVoAm
         JHFDXHCJl/5Hkc1OMgCyL+wOT/1YX7h1yV945cZIeTeRfd0ZHOcTzzNKHNwzSnWhBvrj
         mF/M6vmE1ZpZC0sLSOnNFDQGKvvkDVQJkXzj5M6jSXejrq7wGKDnDe9gApJUm3OThOcv
         OKR1+e0PCq3M/dC7ylXRN3bZJ1VY3ZpVM/Zy/knYQRDxSnw/gp62yZ23FC1Bcb7prF7s
         6AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2+sJQfhRPX6mgylgaohdp6BE3uFottGVMdhI97In/E4=;
        b=DlegejmrDMIsqJAEsdQJU8MrFUXHmVaWIIB8aGbrQqpkvUauaLwOjFS43q10BohhVU
         KRUbYrXHFp8I8ZRnYIE/pL0IvkiY0MzCOLKxjaO0s5kV0XAWHywQm8iscS1yluf84ktI
         spIdletnmbUE9wv9ejVJyNXSjP6uVQabjWHNpVTBtLv/9u1fdX9u/jPTeeNQhn65iwpM
         V/RZfBiK/PWNrIyqvAdAYH5J2QHkRHuJwROhYxhx7cd4T8a/5BLX08HbpyLk1z21m7/1
         g5KE24Ny+5i5QgZ6SB89hqWpB4TVKxkllYwZWIsjqkJSQkX/W5Y7YchMDfpSHSjkogCR
         zZOw==
X-Gm-Message-State: AJcUukdc4nGmtsmzOAQGDW5zjOj1ZeTSajERI1FH2PtS3hbtlP1JJxKo
        KO4D5c92ffqbzH8c7cDpbkQ=
X-Google-Smtp-Source: ALg8bN5uddej6N91AE+Kg95AktnFUdX/H201nmBnlH0aAKU35B6K35IvD0280V1sLCyRuC5f1taG5Q==
X-Received: by 2002:adf:900f:: with SMTP id h15mr22393334wrh.18.1548692026370;
        Mon, 28 Jan 2019 08:13:46 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:45 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 01/11] dt-bindings: net: lora: sx130x: add power lut binding
Date:   Mon, 28 Jan 2019 16:12:55 +0000
Message-Id: <20190128161306.27805-2-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

Adding power lookup table for the concentrator specified in DT.

These values are calibrated for the hardware and are unique to hardware
designs and certifications.

First byte is signed power in dBm measured at the rf connector.
Second byte is unsigned value for DIGITAL gain.
Third byte is unsigned value for PA gain, 2 bits only.
Fourth byte is unsigned value for DAC gain, 2 bits only.
Fifth byte is unsigned value for MIXER gain, 4 bits only.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 .../bindings/net/lora/semtech,sx130x.yaml           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
index 24fad1218735..187fa2090a0b 100644
--- a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
@@ -37,6 +37,15 @@ properties:
     maxItems: 1
     description: A connection of the reset gpio line.
 
+  power-lut:
+    description: Power lookup table for the concentrator.
+      Consisting of maximum 16 entries, each entry having the following format;
+      First byte is signed power in dBm measured at the rf connector.
+      Second byte is unsigned value for DIGITAL gain.
+      Third byte is unsigned value for PA gain, 2 bits only.
+      Fourth byte is unsigned value for DAC gain, 2 bits only.
+      Fifth byte is unsigned value for MIXER gain, 4 bits only.
+
   radio-spi:
     type: object
     description: The concentrator can have two radios connected which are
@@ -83,6 +92,10 @@ examples:
         reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
         spi-max-frequency = <8000000>;
 
+	power-lut =   [	00 00 00 03 09
+			03 00 00 03 0C
+			04 00 00 03 0D ];
+
         radio-spi {
           #address-cells = <1>;
           #size-cells = <0>;
-- 
2.17.1

