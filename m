Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FFC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCCB2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfA2Tyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:54:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45371 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2Tyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:54:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so12275545qka.12;
        Tue, 29 Jan 2019 11:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=YfdZ0pFeestCCoBpwNdQi//11yLabafdERytJZT1uSY=;
        b=MF6T+UyXWv6Sr6Ty/neg3TlMf/b4DPnMVfoIeeR1tPX4kefFrdSSZE+JI8Unel7W95
         xAJGNCNFf67DkDnJvUUb40yTX/UP9PojXtllkDAQo1/J8YfCoWavCXdn/TZ19Z8M/ce+
         YHN8U8j6bHbGvaFnClzOe/hOiUr0Ivzb3LLeuLXKm6y9Df/1tXgf6yecFWt9XPwLIuhR
         YhzFF5F3ewNVZCbCgif7AC284FXnJPYyZtiGr0Lh2nWbs+51xoYeGwnoH6jZ7Tx2NCIt
         DyuPCOqBAVYw5XdeEgiav0tkLUNtIo6Po+RzpWMaAZ0SmiuV3Ax2cJxjSoWUHrV7V5Pu
         dcIQ==
X-Gm-Message-State: AJcUukcjx0J9lM7XDSf8iQvKzzKCfbs+vhyfmR0skD/FkOnybQgsgafi
        ja6vLXKLACqLUoTZUKXbKbHwmOHW
X-Google-Smtp-Source: ALg8bN7W/xAFZJ0vpoB16xhxXNxjK6+BHsDBb+n1vGdAHPIJKPO3auQjxqlbLKm7nEIw0l6bXKxNkA==
X-Received: by 2002:a37:72c3:: with SMTP id n186mr24139391qkc.340.1548791689695;
        Tue, 29 Jan 2019 11:54:49 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
        by smtp.gmail.com with ESMTPSA id s9sm105268727qta.35.2019.01.29.11.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 11:54:49 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Tue, 29 Jan 2019 17:54:42 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Tony Xie <tony.xie@rock-chips.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/4] ARM: dts: rockchip: rv1108-elgin: Use the correct regulator properties
Date:   Tue, 29 Jan 2019 17:54:23 -0200
Message-Id: <20190129195424.10161-3-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129195424.10161-1-otavio@ossystems.com.br>
References: <20190129195424.10161-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following properties:

- regulator-state-enabled
- regulator-state-disabled
- regulator-state-uv

are not valid ones as per
Documentation/devicetree/bindings/regulator/regulator.txt

Fix it by using the correct properties as per the dt bindings.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108-elgin-r1.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index dc2ae1731ae2..ef31fee8acec 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -85,8 +85,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
-					regulator-state-uv = <900000>;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
 				};
 			};
 
@@ -97,7 +97,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -106,7 +106,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
+					regulator-on-in-suspend;
 				};
 			};
 
@@ -117,8 +117,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
-					regulator-state-uv = <3300000>;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
 				};
 			};
 
@@ -129,7 +129,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -140,7 +140,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -151,8 +151,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
-					regulator-state-uv = <1000000>;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
 				};
 			};
 		};
-- 
2.20.1

