Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11504C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11F721873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfA2Tyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:54:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33167 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfA2Tyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:54:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so23739871qtp.0;
        Tue, 29 Jan 2019 11:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=yU/l/jTl/eNiEQmSpnEZVJnKEnv8Qcm2lq32UeL1WGo=;
        b=YtWbb+z4LfwVtg+JrXM3so2UFIgsAfffSS+ydeqxfu9pzJjCcPsRqGdwAZzlVp+fC2
         a3X0cpv1AL+nmEjxZF1VSjluy1pKnIScawxLGr2CbQtolV/7YzhzLX47fhtJhPFWyk6k
         TGxo8bYWVhjAwfSFC74a7diOFdvCqvAHjGh8KtwcHbVUeL1G7l9RrAd+D1kgYikxGoDa
         vh7JtoYA5bGKRx8FbNZhAwuaMajN7wQOiNCDISlokc1kg2Rb+xFoTUcd//+XdFpH5nop
         BvPqBcFSeMJPXjiVV/tnTmjplHSuyBKKXcx55UKVjfpz5S3StrptrBOO4WpfwrDHKP1x
         BJ5w==
X-Gm-Message-State: AJcUukcxheuioYXRO2hzIfeGj/tf+CqQ3Fw2nl5G5cUsOvIorpzC4lbs
        jDc5UJVj9zPnzDA8goM6vQYcTig8
X-Google-Smtp-Source: ALg8bN4apAK6pUzvdKnKaeKeyigw/VkyI+ls3fsvsE6MEefwMPzgTee1a1AYpx4TDFLrstG9KDBPcw==
X-Received: by 2002:ac8:1414:: with SMTP id k20mr27311508qtj.298.1548791682323;
        Tue, 29 Jan 2019 11:54:42 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
        by smtp.gmail.com with ESMTPSA id d85sm45389942qkb.89.2019.01.29.11.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 11:54:41 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Tue, 29 Jan 2019 17:54:34 -0200
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
Subject: [PATCH 2/4] ARM: dts: rockchip: rv1108-elgin: Fix vcc5/6-supply representation
Date:   Tue, 29 Jan 2019 17:54:22 -0200
Message-Id: <20190129195424.10161-2-otavio@ossystems.com.br>
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

On rv1108-elgin-r1 board the RK805 VCC5 and VCC6 supplies come from
the BUCK2 regulator at 2.2V, so fix the representation in the
device tree.

While at it, rename it from vdd_cam to vdd_buck2, which is a better
name for the regulator label.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108-elgin-r1.dts | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 7b24558f13e0..dc2ae1731ae2 100644
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

