Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B7C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03262084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfA2Ty7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:54:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41554 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfA2Ty6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:54:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so12288711qkj.8;
        Tue, 29 Jan 2019 11:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=H2zEvdVTOJICHXPBMAI1W22X3IkRf9LxQWOWo6ZMP3Q=;
        b=Z4bE5uoHMNbqY5sdMOdW2mnA4FLcCTAuHOPoJ+qHnr/Vk7PDNUxQsLjRwjjlsfNW6Q
         8ynu3d1lcgxLkRMmeUyqsiBpus1ClD23rB2V/Uj/X2SHOb5vJmsZr/0laoqPlyfYsjgr
         uEvY8qLMXaRtKCRmihPbgymDaF7fdmtZbd14DQNnp7SEyxBQzrkavm89K2xHN9fVK15o
         z7oiMnV7+mIyBkjhDJqEZJsc5+9owN0lV+hu03VZUR3N/PxBtzHOW8ChXDAYjQoLrVpL
         pTiFXF9YRGt9MTP/+mFlxyjVwXdPmwPh6bSbtptQmzERkK7zvZNLlQ+4F58LSbEhna/I
         TPjg==
X-Gm-Message-State: AJcUukeSQJkL5OpIgnVA9WuUzGf8gYqPKpdFlrqYW0cRn7AXDjKp+g8Q
        vFcjOULkDEyrqpVYRFS/LQ4=
X-Google-Smtp-Source: ALg8bN5c/9oPbcZ7NQS6kBvonzoKu1QLMDpvt5AACYpcDDUgg8r3PXrLzJZtDfH4sDyAFWAxF80gaA==
X-Received: by 2002:a37:7003:: with SMTP id l3mr25512071qkc.80.1548791697221;
        Tue, 29 Jan 2019 11:54:57 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
        by smtp.gmail.com with ESMTPSA id y12sm104050456qta.13.2019.01.29.11.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 11:54:56 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Tue, 29 Jan 2019 17:54:50 -0200
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
Subject: [PATCH 4/4] ARM: dts: rockchip: rv1108-evb: Use the correct regulator properties
Date:   Tue, 29 Jan 2019 17:54:24 -0200
Message-Id: <20190129195424.10161-4-otavio@ossystems.com.br>
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

 arch/arm/boot/dts/rv1108-evb.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 203d83e3bbf5..30f3d0470ad9 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -97,8 +97,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
-					regulator-state-uv = <900000>;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
 				};
 			};
 
@@ -107,7 +107,7 @@
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <2000000>;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -116,7 +116,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
+					regulator-on-in-suspend;
 				};
 			};
 
@@ -127,8 +127,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-enabled;
-					regulator-state-uv = <3300000>;
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
 				};
 			};
 
@@ -139,7 +139,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -150,7 +150,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
-					regulator-state-disabled;
+					regulator-off-in-suspend;
 				};
 			};
 
@@ -161,8 +161,8 @@
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

