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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69319C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C61320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLCDjvJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C61320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbeKGHfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:32 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45050 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeKGHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:29 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so47943lfe.11;
        Tue, 06 Nov 2018 14:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcEBeFn++VHxoUCbcVgPLiFLzW1/27zspx1+gAZ6bs4=;
        b=VLCDjvJ8JYfHA1+EdtDtrMioBU1qXiVyuwlLhGUu1ZN46HGbPgKI7RG7gMglOgTPqO
         8K9hkoZUqyX371zGgyLcM+SxoPWzAyr5nzrYTLGB+kl34rK2WRpubwdbp6QcG361Ug6P
         8+zdGql5owY6Olg+waKK93NPCpfZSOtOX+YnpaQxlyTWXRAsV5o1OAfqR/gmFLO9YvWa
         w0ary76oQhporq8/CUbE62jbA9i1JyKVKeU8plx8kEd/ZVT5qiQYdmV7C3UTzneE1cdE
         tCMJhBkgfOndi3c1SW2v1QoSN4Z5MMjT0CsA2sbjTsSKFm5OB0pj8T6HWiT2z0l/s9OD
         XuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xcEBeFn++VHxoUCbcVgPLiFLzW1/27zspx1+gAZ6bs4=;
        b=itSnFtTrQ0q7+4qaXHfPQ1Jcyel6/0C/6PeCpn7MQYnMWLEllDpYWD8flEXxYK23Dr
         wZeJU8ojM/iZB2O6fR0xKsO27GGVaIDWC4hYKloiNv9+U+aAZqjht4tzkiNa48fi+EH8
         xb4g0dWsGputV+SnRm8jLX1PBwq4yPYPOYUtaZdVUWw9FHAH8yYRp6Xekb0x8Q9gKmPi
         mHGxJt7CRYOof6+k2rhMKCveqXHAhuDxeTi8/E42LVjYIC7xoD/ESzEcMoOwyF/9Ynqe
         bEkOKhkYrzT1m9oamS4iYaXNwcqG9V58Gki+l4YKVwvHjhwxpPf2WHw+bAOLBiEu0I9d
         EemA==
X-Gm-Message-State: AGRZ1gKKzAZVquzodKcjtqMW8NaJrnJMZIBREMXGmvLXb2Bux2Xnwa+c
        lZ0EXbpjDX56QbXu5cU65yStRyCy0S8=
X-Google-Smtp-Source: AJdET5dZDjGST2rS43BftMS7QhvPysJ2pikDJ4M4+gfK7ZOYyJlylYx3KfgiL6x4ij0zd8PrD+PBLw==
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr2716755lfi.57.1541542084493;
        Tue, 06 Nov 2018 14:08:04 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:03 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 11/24] dt-bindings: lm3692x: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:19 +0100
Message-Id: <1541542052-10081-12-git-send-email-jacek.anaszewski@gmail.com>
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
 Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
index 08b3528..62c8fe5 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
@@ -26,12 +26,16 @@ Required child properties:
 		3 - Will enable the LED3 sync (LM36923 only)
 
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
 led-controller@36 {
 	compatible = "ti,lm3692x";
 	reg = <0x36>;
@@ -43,7 +47,8 @@ led-controller@36 {
 
 	led@0 {
 		reg = <0>;
-		label = "white:backlight_cluster";
+		function = LED_BACKLIGHT_CLUSTER;
+		color = "white";
 		linux,default-trigger = "backlight";
 	};
 }
-- 
2.1.4

