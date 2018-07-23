Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B401FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E48720874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHIRFn2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E48720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbeGWHKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:10:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41910 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbeGWHKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:10:51 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so7794585ply.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eLh+RCGI7jFU97vFKRaGVHWFxDScjVDx/ObeOqcYMEs=;
        b=IHIRFn2cNf+IdHPbtqzBxrOkghdQMjgCcMFDyQ2SqAoeLVMNQbqV4/jOmDX8TfNhv3
         FnmBi/5YIsFynIqQEXerR/Worv1d6XgDr6AhpWjR00mJZdcHWxCaBYxWcdrThc16I3bH
         dorOU+Y++hgH1nzIGKDixKsqG1SLC1E0qkC9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eLh+RCGI7jFU97vFKRaGVHWFxDScjVDx/ObeOqcYMEs=;
        b=Dn2PWnq70Dc+YXL4l4Ly3zcQfiv0Pny0YlQtPBSYeGH1y0OgBFjdR3lbqATW4hyCv2
         Lx9+875mVPxpdRSWLO6W4HBTICo7KFV7aegxx0eMX76qMebzZq+0tjslkhjggzxGG9zN
         PwDo8X0o3DIx1CMac/QWG6WwVWE5km13l+cGP464e5osXyn2rFwj5MCXSm8fDX8+JndD
         WQWlJ9NLc24AqA5SIJU23KGFvfDyDMFYvt02n9OPB7igZwVm46UpSezSFqyIDitIyElA
         dp+cFvmo1ald71dt0dwsoxY00XG2YglZTM1ofpMwwo2UWKun+e/LEA+Lg5TAKOV1VGR7
         kYjA==
X-Gm-Message-State: AOUpUlEFqmu3wLFfiUexsSuZZoE1Lt6M5HkvBC4bsuLOaDMp0npBKPuv
        7Cqe1GlsYcn2mwRFpWW9I2eDUA==
X-Google-Smtp-Source: AAOMgpcuEHWO/mR8LrSOEK9nKHUqqLmZI634oyefC9pZ4i1rSoie5GrjYEp/kqMwMIQ9cHBoUIoYYg==
X-Received: by 2002:a17:902:968c:: with SMTP id n12-v6mr11574828plp.15.1532326277673;
        Sun, 22 Jul 2018 23:11:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 8-v6sm11972303pfk.132.2018.07.22.23.11.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:11:17 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/5] arm64: dts: sprd: Add SC27XX breathing light controller device
Date:   Mon, 23 Jul 2018 14:10:16 +0800
Message-Id: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC27xx breathing light controller can support 3 outputs:
red LED, green LED and blue LED.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 98d3b4f..7d53ca6 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -17,6 +17,28 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		led-controller@200 {
+			compatible = "sprd,sc27xx-bltc", "sprd,sc2731-bltc";
+			reg = <0x200>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				label = "red";
+				reg = <0x0>;
+			};
+
+			led@1 {
+				label = "green";
+				reg = <0x1>;
+			};
+
+			led@2 {
+				label = "blue";
+				reg = <0x2>;
+			};
+		};
+
 		rtc@280 {
 			compatible = "sprd,sc27xx-rtc", "sprd,sc2731-rtc";
 			reg = <0x280>;
-- 
1.7.9.5

