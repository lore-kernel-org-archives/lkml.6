Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F362C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B52086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbfAaMra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:47:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37645 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbfAaMr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:47:29 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so3264703qtt.4;
        Thu, 31 Jan 2019 04:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=DOY0na8Wg7iyK4mJ/SZnMyCR5yw4bav4pLPRTRGmFrg=;
        b=CrOdzKAlBnGfSyfuqi2xci1QoT5uT5VicRXYzBpyZxfXHkKtRwG91FVENOTqTMSa2v
         KCYBjkd1p7/eHyuS+0+/KFtBfa44qTVjmQCwAn+tmobKOVlrE1Thu8xKSb+YI72bco6X
         2gAJ1GxjDMLAPLxFiYXzUvmmQ3fgDJ5jVrJnPSmcSHVwIB+ChdQJaq/8QRxaA7RbznBQ
         cqmsL59CYl5bKBIdaRS/w8oC5lq+8krXI2/ptFKugBNMH0NWIQvZOD7zpRk9VYWpQ/2C
         61Q7wE2/Hah4x6QvzAcHpR8xwAy/YECHf7TI/iKuWqVZUqXw6XXnBjOPZPxx0tbjSMKj
         mXoA==
X-Gm-Message-State: AJcUukdSdByyLqLx5HZJelXQr7VafR5YwQXuaJnYKuFBx/HhXqOWrgZ/
        3iExG+cKdcaSBo42MBu6Ll7btUCU
X-Google-Smtp-Source: ALg8bN6ZFd7Wi+q3Xu4AZh7PdCMFxAFu+vydlguUiIFOCGI22nIgqT5+2P09Nq3yMWONZazJQ6WA7Q==
X-Received: by 2002:a0c:d065:: with SMTP id d34mr31290726qvh.209.1548938848924;
        Thu, 31 Jan 2019 04:47:28 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
        by smtp.gmail.com with ESMTPSA id y68sm2886835qkd.49.2019.01.31.04.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:47:27 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 31 Jan 2019 10:47:21 -0200
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
Subject: [PATCH v2 2/3] ARM: dts: rockchip: rv1108-elgin: Use the correct regulator properties
Date:   Thu, 31 Jan 2019 10:47:08 -0200
Message-Id: <20190131124710.30238-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131124710.30238-1-otavio@ossystems.com.br>
References: <20190131124710.30238-1-otavio@ossystems.com.br>
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

Changes in v2: None

 arch/arm/boot/dts/rv1108-elgin-r1.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 66688fdf4fd8..1c4507b66fdd 100644
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

