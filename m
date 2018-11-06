Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50439C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1655C20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9ZEIgIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1655C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbeKGHfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33539 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeKGHfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so10069294lfc.0;
        Tue, 06 Nov 2018 14:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=npOx/LMkPQ3PNJ2NXY26xlFMl3IN2qanur1SDOr8eOM=;
        b=L9ZEIgIhy5w009PYAvbdCyG21QBz0S7ZcxtY6DgyY0ELzrc6SjQJPMNylfqaRqnk3s
         RVL+IDSSAglcVNkP6MG3A+zCp20kR7me4s4g/l5w7p06GCD+h8QJ12sNZOupiIhp6kKM
         RuRcUhTvIrXO1TIYhi8eVLVvGRd51LMX+xQ2/HAB25KkYW4W8cdWoqAqILKJJFjIQ0yr
         3dZy8T2hEqWLN1s/X6DI2aEYuDLrc8yoG20Nx8bBpAOcM2lPvVoNedvwlKyVv2wKiPbH
         Pqx70pfXP7FXo7w2YC+NsYe6cRMh9UBlUniYwDLaeiKNG+PpRyDKczHD0s8vBr5lYj+A
         UD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=npOx/LMkPQ3PNJ2NXY26xlFMl3IN2qanur1SDOr8eOM=;
        b=ESs18kIKRUlw/GTsFh60gaz5eXGK40Dx38rri3FNR+ha5syP0eAC/jJ0JDAFCbgHV/
         2MR5n1L+1Qji/Qn1kfs0MPEiKnIAFvOo4un4Z/4CAXQvmna2FKL2xSLiqfeOb24Y6ZPU
         l+RKZkBBRaxuQ2oBNOYPuT0Z+wpX5MvIgRr9OMAkdw3z+lgWXnk4/NdA8iEr0hjWit1y
         IQWlTGNpPnFO0UbrlX7XQ2QVg8eaIl2mB6i1ySo5dJj6uvAhr+jqNnHm/1Zhf66OnqMe
         Q84hidDJUaV4sVrbUITBh6+1U9+fvdqYolCh3zJsEnvfoOCdgJehbfUNdhEcWfAjGMJv
         /N6w==
X-Gm-Message-State: AGRZ1gJdBTIKaZ5yfLJOjvAU5PELYcwxJe2xL+jItVZbNAXXhSNWDFQz
        jsDPzS2p7DIuM0TJV3JrvG+SCg2zmjo=
X-Google-Smtp-Source: AJdET5cy+ukoz21j0yJ90uVRZz6xN2usdTfq4YUSL16x3gP75lP5ipbjBxBSuWccUZK2Clf2/DIdpA==
X-Received: by 2002:a19:54d7:: with SMTP id b84mr15337767lfl.131.1541542098371;
        Tue, 06 Nov 2018 14:08:18 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:17 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 19/24] dt-bindings: as3645a: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:27 +0100
Message-Id: <1541542052-10081-20-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Also, fix malformed syntax of address-cells and size-cells
in the example.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../devicetree/bindings/leds/ams,as3645a.txt       | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/ams,as3645a.txt b/Documentation/devicetree/bindings/leds/ams,as3645a.txt
index fdc40e3..a259850 100644
--- a/Documentation/devicetree/bindings/leds/ams,as3645a.txt
+++ b/Documentation/devicetree/bindings/leds/ams,as3645a.txt
@@ -39,7 +39,9 @@ ams,input-max-microamp: Maximum flash controller input current. The
 Optional properties of the flash child node
 ===========================================
 
-label		: The label of the flash LED.
+function	:  See Documentation/devicetree/bindings/leds/common.txt.
+color		:  See Documentation/devicetree/bindings/leds/common.txt.
+label		:  See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 
 Required properties of the indicator child node (1)
@@ -52,28 +54,32 @@ led-max-microamp: Maximum indicator current. The allowed values are
 Optional properties of the indicator child node
 ===============================================
 
-label		: The label of the indicator LED.
+function	:  See Documentation/devicetree/bindings/leds/common.txt.
+color		:  See Documentation/devicetree/bindings/leds/common.txt.
+label		:  See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 
 Example
 =======
 
+#include <dt-bindings/leds/functions.h>
+
 	as3645a@30 {
-		#address-cells: 1
-		#size-cells: 0
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x30>;
 		compatible = "ams,as3645a";
-		flash@0 {
+		led@0 {
 			reg = <0x0>;
 			flash-timeout-us = <150000>;
 			flash-max-microamp = <320000>;
 			led-max-microamp = <60000>;
 			ams,input-max-microamp = <1750000>;
-			label = "as3645a:flash";
+			function = LED_FUNCTION_FLASH;
 		};
-		indicator@1 {
+		led@1 {
 			reg = <0x1>;
 			led-max-microamp = <10000>;
-			label = "as3645a:indicator";
+			function = LED_FUNCTION_INDICATOR;
 		};
 	};
-- 
2.1.4

