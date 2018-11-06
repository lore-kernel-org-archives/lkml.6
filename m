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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FAFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6012086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6UEGBWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6012086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbeKGHfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45076 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeKGHff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so12920981ljc.12;
        Tue, 06 Nov 2018 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j4wYfQac1eSCAS/c8KUS5KNLhBiOt8tDdOWjxqlLhWA=;
        b=p6UEGBWxBQc6s/+QwuYRiK9de9UBM+Tj+bK5lu8g2oahV7mjNnS9Q1Hh3mduX8dXzb
         EL4pA82hGEaDC3u0k7rKCv6pxo1kIeq4aZooxdyySm+kHyS8pYUYyPvn52qhwh+hSqCm
         38GqdfNSWNTuuuCibsfIFWpfO0qRxdudv+QF8+5cpYh6NH207etWqh3euJopj5DenRWJ
         BgiAQFwXtV57GNTfCc78ExM1Vmc9+sVby6kSrjuDbiRj6A4JbRCkDjTQaYLlqVzMtNcN
         THBTLYD2QfUqOOfBOIoucKBivI+WguW6iVUxB6fQ7CZ8n7uBh38abUH7v8WTJ8+GsggT
         MWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j4wYfQac1eSCAS/c8KUS5KNLhBiOt8tDdOWjxqlLhWA=;
        b=IT60emh/hpAvtqfal1GFZ2aFwmd/huMKk3j7YHvQv1hrzyxwcwsGuEsseuQ14hnseV
         pu7dqD2wsoWLaGddA53l3QtwkzifbUarIombdD1ErwM8wY0LxDD9psE/sHyAnhT6pGxf
         C6Ev1Ql3k9+h6Y4lRylFuna7KNoMmMKBHZutqWhX9EQqWibjkWoMf3KXme2pspnonTi1
         9OP8xRwojEYjrsBNvnwXosV6nO38tWoHkZVZHFNCPR4o0QUSk5oe/zGCumbea6QezsO5
         ObNFGT1/ec7cCUKaAO7bXxOiFXWkM9XUPtlo/Wb03dUes+54cOSke6a7ZUSTZoDUvYJO
         0QGQ==
X-Gm-Message-State: AGRZ1gKECcFd9JGQcgAr/iQDPiDOC1dyahkEbtevbGL5uwfuQfRTUzPC
        IvKXYm4n9pkEhO3xOCeqI8duL37UHoU=
X-Google-Smtp-Source: AJdET5ddqV3KmQ4zm18Sj0Gu+QeMS/UR7upJTeRvPjBBfTUdOL6qoNjMjI4sZCtejPbuzDFcHdOzVg==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr2271020ljr.91.1541542091833;
        Tue, 06 Nov 2018 14:08:11 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:11 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH 15/24] dt-bindings: cr0014114: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:23 +0100
Message-Id: <1541542052-10081-16-git-send-email-jacek.anaszewski@gmail.com>
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
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 .../devicetree/bindings/leds/leds-cr0014114.txt    | 26 ++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-cr0014114.txt b/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
index 4255b19..4c65c56 100644
--- a/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
+++ b/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
@@ -11,14 +11,20 @@ Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
 apply. In particular, "reg" and "spi-max-frequency" properties must be given.
 
 LED sub-node properties:
-- label :
+- function :
+	see Documentation/devicetree/bindings/leds/common.txt
+- color :
 	see Documentation/devicetree/bindings/leds/common.txt
+- label :
+	see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 - linux,default-trigger : (optional)
 	see Documentation/devicetree/bindings/leds/common.txt
 
 Example
 -------
 
+#include <dt-bindings/leds/functions.h>
+
 led-controller@0 {
 	compatible = "crane,cr0014114";
 	reg = <0>;
@@ -28,27 +34,33 @@ led-controller@0 {
 
 	led@0 {
 		reg = <0>;
-		label = "red:coin";
+		function = "coin";
+		color = "red";
 	};
 	led@1 {
 		reg = <1>;
-		label = "green:coin";
+		function = "coin";
+		color = "green";
 	};
 	led@2 {
 		reg = <2>;
-		label = "blue:coin";
+		function = "coin";
+		color = "blue";
 	};
 	led@3 {
 		reg = <3>;
-		label = "red:bill";
+		function = "bill";
+		color = "red";
 	};
 	led@4 {
 		reg = <4>;
-		label = "green:bill";
+		function = "bill";
+		color = "green";
 	};
 	led@5 {
 		reg = <5>;
-		label = "blue:bill";
+		function = "bill";
+		color = "blue";
 	};
 	...
 };
-- 
2.1.4

