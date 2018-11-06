Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F34C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA99220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl13HKrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA99220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbeKGHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40987 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388627AbeKGHfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so10045252lfj.8;
        Tue, 06 Nov 2018 14:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a5/XatnvJgk+qLor8+MD8ZHsRQrQHpLnOnNg0BE/dvY=;
        b=Fl13HKrZ/Ss4vHwZlB72atL3TNOUefOpJXhCG38AASgxt9l1U75betHPYRUGva0NGc
         uzZKnEfvhFUvJdmNDtc6SIs/NdAoRCVCOgQCE0ZmLkJNPWPGEjKoCVzqzLmeRamrnvNS
         gBWX6zrXvyNvIRKpZIknVNRR1UBtHmxP4oTSN8di1J0abJ8OWx5U2H3MBw/2ON31toTf
         4H5xYyeWi7s51HSvXgxVJGj+9x+5TuC7D4GvzonEXS75/u+UG26Yhtv7Zur01PHZHBdy
         oGpgCrX2B1Ct3e3r4TZ8tMQb1KzFA5C9xCPprcjXwukrNeoRKmasgazJPRMuctJxzCWN
         sJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a5/XatnvJgk+qLor8+MD8ZHsRQrQHpLnOnNg0BE/dvY=;
        b=sQRfSZ5AxF3ly4GTNRa0oUhS1yHD2R4Fz0lE2xuSpI4FnYF8fQbSPtqddz5OPJiG+Y
         86e3s0bWDbpgYhAqQzDWZHmG/2cWI37SRslYwCLbtenVaUj8wJlIDlJYSKYBeSQUyZSd
         YATxiVF47Eg46wh5zOWXwHNZ6pv9ZaKS71oo656VKxi8izm5/Q1hZOMewfJWyLHHzWp0
         0IRMw2T3vHmWq++aNI1U6SFYuj5YPcxIo7SnoFbr+YtHypJqlmWaS4RP4qRoY8Z2MHWm
         3F1udC12GS0VQ/BjY3+EtuHRDVoGZoFeaAtj2jRJSbNhx+yd2hFCVZ0xtCp0/ConRoLE
         OhDg==
X-Gm-Message-State: AGRZ1gJPd0LnPhsjg+AHOm5+NlbdCg1IxSjIy/7I85C3TnSeWAtgI39D
        206pdt51MTD66mzOp3vqMzbrEqiaMds=
X-Google-Smtp-Source: AJdET5eMCLcZ58fGRPXKIdPsBD5GmdR0xE1EjGpb8QaepQ1EJo3VdtD945eaaf9yzDx9Z86JvA1AAA==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr16934158lfa.32.1541542088002;
        Tue, 06 Nov 2018 14:08:08 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:07 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 13/24] dt-bindings: lm36010: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:21 +0100
Message-Id: <1541542052-10081-14-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lm3601x.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
index a88b2c4..aaffc68 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
@@ -22,9 +22,14 @@ Required properties for flash LED child nodes:
 	- led-max-microamp : Range from 2.4mA - 376mA
 
 Optional child properties:
-	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- function : see Documentation/devicetree/bindings/leds/common.txt
+	- color : see Documentation/devicetree/bindings/leds/common.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 
 Example:
+
+#include <dt-bindings/leds/functions.h>
+
 led-controller@64 {
 	compatible = "ti,lm36010";
 	#address-cells = <1>;
@@ -33,7 +38,8 @@ led-controller@64 {
 
 	led@0 {
 		reg = <1>;
-		label = "white:torch";
+		function = LED_FUNCTION_TORCH;
+		color = "white";
 		led-max-microamp = <376000>;
 		flash-max-microamp = <1500000>;
 		flash-max-timeout-us = <1600000>;
-- 
2.1.4

