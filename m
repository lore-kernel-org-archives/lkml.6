Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14784C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FC92086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbfAaMri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:47:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33401 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbfAaMrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:47:37 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so3309995qtp.0;
        Thu, 31 Jan 2019 04:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=xBSoSCuZb2B8/w9VdnWvUIjsj7+NlFgkfKIRaCleZIs=;
        b=qlCKfXnpiD+gKSKQjrP0XENjOF2fkKcf841FQh+QcLWxRDejLmQTblpl1dfRcocdYh
         j4ONMRYuwFsrKB7iLgw/pS72J7Ly19wi8K5QhGMO9xP6QUUGhA/4Aob6sNDWFYIL2SIx
         YEjNaw66MPypASJYTGIjGt4VItZroDor901UkjL9S+xSNgJDA4paSqPfYLlnneJpGnAZ
         G7AUsQBllQX+EaCSRYmBYOHvg1jso0q5jsNoKWtKVB3VDox9m4Or1GFNLLTXeZJkIftN
         ForDU53mTGiwc/Po17oIKazIrzw6N+Uqqoat3MQAt61lIRyBDs0vVlcfUDlTnNJS6MBS
         0HfQ==
X-Gm-Message-State: AJcUukc4SgEwg/vSTwFTPhHl98bTSEs2oZKLCq2QTbsKE8qWD9JYjWCX
        UaCbHL8iW6rj1TwdJKYG4dk=
X-Google-Smtp-Source: ALg8bN7Vt/DN3dGcKPypW64rUyzI/Ix7TXSRmoZ2DvcnRg3hiD8bWHiztP/xiQXleq1pK3cqDCTEwQ==
X-Received: by 2002:aed:242e:: with SMTP id r43mr34659813qtc.128.1548938856744;
        Thu, 31 Jan 2019 04:47:36 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
        by smtp.gmail.com with ESMTPSA id c17sm5675052qtb.14.2019.01.31.04.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:47:35 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 31 Jan 2019 10:47:29 -0200
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
Subject: [PATCH v2 3/3] ARM: dts: rockchip: rv1108-evb: Use the correct regulator properties
Date:   Thu, 31 Jan 2019 10:47:09 -0200
Message-Id: <20190131124710.30238-3-otavio@ossystems.com.br>
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

Changes in v2:
- rebase on top of linux-next

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

