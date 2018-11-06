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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9BFC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603B720883
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poQHL6m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603B720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbeKGHfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45061 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeKGHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so12920501ljc.12;
        Tue, 06 Nov 2018 14:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=npoevFiPZ0Bu+vUBGGj/WOqwaFjOnNE9lPJR+Z36vME=;
        b=poQHL6m6LDuoz+XyiOwcBfQn7QdgRSjvF2srG0UAtfL62kOg07p656iSqiNlWXot5h
         fFxuW9EnO2uahlgr8p/oewCVcJ0KBu4fON8IW+AEZnGFjVuL+7cDY8vj7XQ0z2VYxmFL
         mHw3WG0ayHTrZaBi0i1Y/o4DLODVDS6BMMjJ6EV8ReAeFHmRDxO61G+p1RKNglTBU32V
         RuignncwXRINPBLalqPJ6u8Ci2h5jhf/OpNRVPIdX7iwscl40bAkv1lpkdPFY9OM0nz6
         R3/SiKfwOw9gZ5Nhw3cc4YG/SiDs5R2I9jgIxidVY59wK8U7WU+zsemxY+sLl1cBdUOH
         RD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=npoevFiPZ0Bu+vUBGGj/WOqwaFjOnNE9lPJR+Z36vME=;
        b=K4Q8Zyz77qZ5W0jfscKI2mr8WSX7vTebU1AxT7DkeZUdxXvLCR9BNtPzl30CN55rmv
         iWlTeAsmHXlWQ7KKTYqC4DFsLCs0wzxkd1WEXnxKLF/cpNKnv4J4MtgzCK5jN8ng5eEv
         PpTzDePmc2e/Kw9hmiHeOz3VRsOoky4o5kfvBO5HkGgC59V8sn/tUBKApqlsBBaGl2Ua
         5PoSl0EKuXxv5k8oguwplB6rJWAxUQlM0/GtudS32OjK1fEf9cwCZ+YfMEFcdOcdhTFR
         mW6G2HPP0N+DQXEI8Dx3ovH4074vCrgXqNSLjQ+oqrHO+vW4fluOvCdHphSEJL28ZHkP
         OBSw==
X-Gm-Message-State: AGRZ1gJtDSG2TzmokQTIZiKcGvu9NZByp1AUk79q058ihVaSqPMhTnLh
        Rhmaom6I+uzC2If7gvcIbND1QvKp
X-Google-Smtp-Source: AJdET5douq5GzKYSOqcALbZO37ACTnMTXnebMEQvwXs7HL5a2nAD2lfkhQTAD76LATCANFLTySQQqg==
X-Received: by 2002:a2e:9e53:: with SMTP id g19-v6mr4719347ljk.39.1541542077306;
        Tue, 06 Nov 2018 14:07:57 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:56 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH 07/24] dt-bindings: lt3593: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:15 +0100
Message-Id: <1541542052-10081-8-git-send-email-jacek.anaszewski@gmail.com>
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
Cc: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/leds/leds-lt3593.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lt3593.txt b/Documentation/devicetree/bindings/leds/leds-lt3593.txt
index 6b2cabc..1d87c73 100644
--- a/Documentation/devicetree/bindings/leds/leds-lt3593.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lt3593.txt
@@ -9,8 +9,10 @@ The hardware supports only one LED. The properties of this LED are
 configured in a sub-node in the device node.
 
 Optional sub-node properties:
-- label:	A label for the LED. If none is given, the LED will be
-		named "lt3595::".
+- function:		See Documentation/devicetree/bindings/leds/common.txt
+- color:		See Documentation/devicetree/bindings/leds/common.txt
+- label:		A label for the LED. If none is given, the LED will be
+			named "lt3595::" (deprecated)
 - linux,default-trigger: The default trigger for the LED.
 			See Documentation/devicetree/bindings/leds/common.txt
 - default-state:	The initial state of the LED.
@@ -21,12 +23,15 @@ be handled by its own device node.
 
 Example:
 
+#include <dt-bindings/leds/functions.h>
+
 led-controller {
 	compatible = "lltc,lt3593";
 	lltc,ctrl-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
 
 	led {
-		label = "white:backlight";
+		function = LED_FUNCTION_BACKLIGHT;
+		color = "white";
 		default-state = "on";
 	};
 };
-- 
2.1.4

