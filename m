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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4576820862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLZ+/9g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4576820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbeKGHfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:51 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35903 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeKGHfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:51 -0500
Received: by mail-lf1-f65.google.com with SMTP id h192so10060421lfg.3;
        Tue, 06 Nov 2018 14:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d2w20Nzhg6PwqRqYMjBmG0FB63ZStDmAp6VIKaIjxgA=;
        b=uLZ+/9g/Tbg8PAZ+mLMecfTDcWxZwv2EI9u/NzAmCViCwbgTxwjYCr5UMwPxVQ1y/c
         tggPcjK6ixdFYHFiIqWVUU+FF2o4TDowlj5hhLC1jnVscfOVlBvdXIu77YAWt6Ua1pPh
         g1nYSvIc0Cfrxognoi3+3Ra7IlWLpxnDRi3olEz8ENqsFddl6VMO3bfh8n4a47EwlpSP
         jTzqfeqeyFCbmLKagPwic3QQnSEbO9RHmtGCgAKMDcxppKDzi4PXbDUkZC82otZv2DWI
         nArV5BvpQji9zzwMFRlbM9kz67SKOVOyZ9wHp1KKFq83sRzK4pz54Ui8Lqt3jj0u5kws
         dYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d2w20Nzhg6PwqRqYMjBmG0FB63ZStDmAp6VIKaIjxgA=;
        b=E8CdmpgnwiOhC7KsIVJWjkEVFS/r+JCSDtVFF3DyAVB1K+dsEXQjPTDqKC67Z2Z9yG
         0t5DChciVfVcQz6JWy2Kv4mKduunfyDXkznWTeLO2Wo+uXvugpmhiSnkhi2ZdO3WGtnZ
         oWjNT+18/mq/Z4ovD4D4arnVVKU7h5l87LGLEX06i12hzlrRlQVwnaa4kfef1mUTV3S5
         7kRMzP5daOSBPCPhAWd/Kro+jgKcwfUvydXv/SL/ufA3xcm4CG1RQof+aScVSIkhkxJa
         Pgzafm4xqmX0sVTmXtOBRg+H5r10b1w83pfoiWHZwMkgXRPolx53Na75ocLGEWH+JLJJ
         mqhw==
X-Gm-Message-State: AGRZ1gLaWRygvvq8dERznU66Tc/YeYIRDBuwlWTXtPDF1D7wDL75IomW
        qloTr8Pup8Y4hoSt8eVwBW4iAkn3OpU=
X-Google-Smtp-Source: AJdET5cP0/4KzrknEh9XGnafzjjstVAul11G24Yzfwk/HeyyLkJ7nuoLmWH9amms3AoWgurciNHXFg==
X-Received: by 2002:a19:94d5:: with SMTP id o82mr15467008lfk.155.1541542106243;
        Tue, 06 Nov 2018 14:08:26 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:25 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH 23/24] dt-bindings: an30259a: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:31 +0100
Message-Id: <1541542052-10081-24-git-send-email-jacek.anaszewski@gmail.com>
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
Cc: Simon Shields <simon@lineageos.org>
---
 .../devicetree/bindings/leds/leds-an30259a.txt     | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-an30259a.txt b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
index 6ffb861..43da93b 100644
--- a/Documentation/devicetree/bindings/leds/leds-an30259a.txt
+++ b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
@@ -15,10 +15,19 @@ Required sub-node properties:
 	- reg: Pin that the LED is connected to. Must be 1, 2, or 3.
 
 Optional sub-node properties:
-	- label: see Documentation/devicetree/bindings/leds/common.txt
-	- linux,default-trigger: see Documentation/devicetree/bindings/leds/common.txt
+	- function :
+		see Documentation/devicetree/bindings/leds/common.txt
+	- color :
+		see Documentation/devicetree/bindings/leds/common.txt
+	- label :
+		see Documentation/devicetree/bindings/leds/common.txt (deprecated)
+	- linux,default-trigger :
+		see Documentation/devicetree/bindings/leds/common.txt
 
 Example:
+
+#include <dt-bindings/leds/functions.h>
+
 led-controller@30 {
 	compatible = "panasonic,an30259a";
 	reg = <0x30>;
@@ -28,16 +37,19 @@ led-controller@30 {
 	led@1 {
 		reg = <1>;
 		linux,default-trigger = "heartbeat";
-		label = "red:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = "red";
 	};
 
 	led@2 {
 		reg = <2>;
-		label = "green:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = "green";
 	};
 
 	led@3 {
 		reg = <3>;
-		label = "blue:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = "blue";
 	};
 };
-- 
2.1.4

