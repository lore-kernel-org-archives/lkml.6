Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27A120862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7g106US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27A120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbeKGHf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44092 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeKGHfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so12916296lji.11;
        Tue, 06 Nov 2018 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B0KLXEyqmLg123dAWY78PbKgAxUWJlHH/gWCJGv3Ue4=;
        b=P7g106USWfKeh2kT4fDl03R5PBDzoSporaNDQSeszGvLx3alcBKmK7GijLDwmWrKyu
         YIzx3E7L3xuMsS3AWww2TPeRRInW2DrAUY2qAkkR8s8Sji7tw/7h7u2eKzb0ODDWQC00
         qj0N3FkFtF7O2hJguJZyAZs/777g0Rcs6+lmsyZAZE0+U2OKiQHDxPlVz+LJuyXMxndm
         05ijXxtYfsKrA+G7bLwX9ST9IQedwoMNZs4oTSn7AjA+Hhs7DdDplh33N/u1V7fKpxsu
         GoA/+VWFNQbCwUV7shQSdi1IYHdQyvoWsRteDuYyER0Qs8cR3NMrVCoRfS3J1bNQGp8y
         2U8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B0KLXEyqmLg123dAWY78PbKgAxUWJlHH/gWCJGv3Ue4=;
        b=h6y1GUwXmF35G3WXT6z07myvdjW87tKRqa1wJT3InLpGdYcwZyVyakD3jAIX7GzMCp
         dQ6w20euFfNjCDGKg4oM3QYdMzRqHh5QsWlxgf9pp9sK6bGV8lJXhfEIFMPxe+QDpsVQ
         bdY7+Jw9uPxP0DksRryoZUUwaNrNOsebgRuiPEFSUqmAhjO131EBV5wFluIF6F+5CA+3
         1UDskJxipJwgpdTPSMqGXQB4wHb2rTeYfVX70fyryWYJM6FngUsT/L6YQhcYp4ZCv4AR
         lDVBWHezFpiNtXmE6aLrct9NkZpMceHzYDJlkI8Kbl9F8n4GF1MeQLp+a6rwXu+jVKkH
         fxCg==
X-Gm-Message-State: AGRZ1gLdOlSivM+ULRDas1+Nj4symwO8dvMlSKOJuHUXAQXHDYd7lrGs
        kQm/xmEYydlXO71m5Brw7b8NvyoTBD8=
X-Google-Smtp-Source: AJdET5dZ8GtrefnFaTH/JubIo8Ry9VfEGVRPDauXNg9mkEkK5KqevyHbo6zXaYYr/1nWGiMPGvEZPA==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr17628119lje.117.1541542080745;
        Tue, 06 Nov 2018 14:08:00 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:00 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 09/24] dt-bindings: lp8860: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:17 +0100
Message-Id: <1541542052-10081-10-git-send-email-jacek.anaszewski@gmail.com>
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
 Documentation/devicetree/bindings/leds/leds-lp8860.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp8860.txt b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
index 5f0e892..c439bdd 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp8860.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
@@ -20,12 +20,16 @@ Required child properties:
 	- reg : 0
 
 Optional child properties:
-	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- function : see Documentation/devicetree/bindings/leds/common.txt
+	- color : see Documentation/devicetree/bindings/leds/common.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 	- linux,default-trigger :
 	   see Documentation/devicetree/bindings/leds/common.txt
 
 Example:
 
+#include <dt-bindings/leds/functions.h>
+
 led-controller@2d {
 	compatible = "ti,lp8860";
 	#address-cells = <1>;
@@ -36,7 +40,8 @@ led-controller@2d {
 
 	led@0 {
 		reg = <0>;
-		label = "white:backlight";
+		function = LED_FUNCTION_BACKLIGHT;
+		color = "white";
 		linux,default-trigger = "backlight";
 	};
 }
-- 
2.1.4

