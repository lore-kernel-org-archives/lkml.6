Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181E0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58B02086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfAaMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:47:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40187 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbfAaMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:47:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so1748294qki.7;
        Thu, 31 Jan 2019 04:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=HQswkCzqG31A9o+Cr/uokIq8kA6vxCiTIvuOp30FHCM=;
        b=LVuILAbXrXzmxLzn0uQKnh79T0+D9IbqY1G1FOlEgymy6LIFmNzILmvnYuEPpbVnbh
         wtZGRPJX2oVTj/AQ7fiMDi3UVp6oSQBE7/haAynwnrdtx/lby5LwXppl+ada6i7IquS5
         +cpw3p0JVdTd3x1bYLcVAWu9c3+aBbUR3XCykfxxs0CFegA45zfTtDHQ0wjBQotT8JIy
         Hu3yrjv8UH49Qj6BIJvGSfrFKCxGe66VL5JbwaKY8Vto4WdY7gjidY9HXmi5rNW1GA8S
         NxpxEu/Ub7F7HJObBRTr33pzyNfObdsHcaqus7NX3gAca1+6i1yi2pAHzBw2ufW9mD5o
         2zTA==
X-Gm-Message-State: AJcUukdpqQ3kEJjOwLJHwYzMD4s7pktJu8PafzVoPbkYXeL0FUgjbAhl
        ZRbwZvleQ2up7kH9/RigpcY=
X-Google-Smtp-Source: ALg8bN5D4iYg9xlqNIE0ppsqyfPMKXpHpCs7SVzfT0yjmXvVJO0j2uhjcPZTSnci+TeXn4QOaJYFCw==
X-Received: by 2002:a37:62d3:: with SMTP id w202mr30651678qkb.357.1548938840744;
        Thu, 31 Jan 2019 04:47:20 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
        by smtp.gmail.com with ESMTPSA id o21sm3706286qto.18.2019.01.31.04.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:47:20 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 31 Jan 2019 10:47:11 -0200
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
Subject: [PATCH v2 1/3] ARM: dts: rockchip: rv1108-elgin: Fix vcc5/6-supply representation
Date:   Thu, 31 Jan 2019 10:47:07 -0200
Message-Id: <20190131124710.30238-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On rv1108-elgin-r1 board the RK805 VCC5 and VCC6 supplies come from
the BUCK2 regulator at 2.2V, so fix the representation in the
device tree.

While at it, rename it from vdd_cam to vdd_buck2, which is a better
name for the regulator label.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/rv1108-elgin-r1.dts | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 658057d871af..66688fdf4fd8 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -74,8 +74,8 @@
 		vcc2-supply = <&vcc_sys>;
 		vcc3-supply = <&vcc_sys>;
 		vcc4-supply = <&vcc_sys>;
-		vcc5-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
+		vcc5-supply = <&vdd_buck2>;
+		vcc6-supply = <&vdd_buck2>;
 
 		regulators {
 			vdd_core: DCDC_REG1 {
@@ -90,10 +90,12 @@
 				};
 			};
 
-			vdd_cam: DCDC_REG2 {
-				regulator-name= "vdd_cam";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <2000000>;
+			vdd_buck2: DCDC_REG2 {
+				regulator-name= "vdd_buck2";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-always-on;
+				regulator-boot-on;
 				regulator-state-mem {
 					regulator-state-disabled;
 				};
-- 
2.20.1

