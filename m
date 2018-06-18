Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C810CC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622822075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edited-us.20150623.gappssmtp.com header.i=@edited-us.20150623.gappssmtp.com header.b="hYaySvc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622822075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=edited.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935732AbeFRSIr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:08:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38655 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935531AbeFRSIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:08:44 -0400
Received: by mail-it0-f67.google.com with SMTP id v83-v6so13320346itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edited-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VTWgioTwpJ6Q98WBflL6Kr/JAAPMvWiMlHX6AjbwHQQ=;
        b=hYaySvc2DfdFY9bZqbMtqRrcYQECAoRTp61jo80eA9D1GveZd04IVi7nRNwMgJn/1+
         SobBfSN0zALOpFOJrMib0NDw/vK+PWkypzCwV49nlDPh4IG/bnJ98zl00WCjZOPmk2DE
         /49y+7zGaHCYLy3hI6zraecBZufyqx0HlOm2BoNALAa9vcpBJjxSvTEO0KjBNQzx4HIy
         8LbPV7+1Ww0wAhVKvJ+dwzIEaO04kE8B9ilQHiDRfMiTA5pdmc0XDynvGJybX4PZuj6A
         Aos2fJ9d8HboKhtt2l9mR1uH9XQuvGe4tLsGJ4wZy1QpTXoOK2OFRi+PJkZsge9Sgecw
         pFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VTWgioTwpJ6Q98WBflL6Kr/JAAPMvWiMlHX6AjbwHQQ=;
        b=pTkL0OlEM5ktV3OcntAIPpRmixwi35RpJOOLC1dFr49C+Px38sjJW4mx8Y8K6DUpdN
         sS/hiZ1FPfTbSf7BMI3/MPb2gVRU7mlzrrTM6E1g+v21I1BQSVi0proPLERt4E6dTV0Z
         H50hhPU3yFfERgTgXU8i3LS+Y0f8YkxEHofKTk9GjVnlW50S+QJ+j63hJdSpU5AlpqlF
         JyBeAEFlKgn3qqGt1Zn+el2COOHSFzOsRXur2vwVhhrI3MwMAnLXkeCUoWjzn1a8JiUX
         DW8CyBWWYyBIfBzKcPunOIizwoBRS41ABpKsOO0L31/GrK2CCVfa02mi4Nm9SpYzbSMO
         5mFg==
X-Gm-Message-State: APt69E0AtZPl3M7hIrT1qSVqMmaht1fEwaqmOEi1jn3xlQlyhj1xaSFq
        jphew4C2x2rp1R2lpzc72eRstA==
X-Google-Smtp-Source: ADUXVKJWPWV++AigfOIhUWTteumjeHr86hISpCoqkGai2xntTRLmb/v4NkX3wSKAu5Kk1Y+0+Dze1g==
X-Received: by 2002:a24:dbd6:: with SMTP id c205-v6mr11095386itg.118.1529345324249;
        Mon, 18 Jun 2018 11:08:44 -0700 (PDT)
Received: from localhost.localdomain (ip-21-240-239-173.midwest.us.northamericancoax.com. [173.239.240.21])
        by smtp.gmail.com with ESMTPSA id d202-v6sm4359820itc.30.2018.06.18.11.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 11:08:43 -0700 (PDT)
From:   Ryan Grachek <ryan@edited.us>
Cc:     john.stultz@linaro.org, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hikey960: Remove deprecated MMC properties
Date:   Mon, 18 Jun 2018 13:08:25 -0500
Message-Id: <20180618180825.21497-1-ryan@edited.us>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 1 -
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c706f70ce9f2..abc991619c75 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -611,7 +611,6 @@
 	broken-cd;
 	/* WL_EN */
 	vmmc-supply = <&wlan_en>;
-	ti,non-removable;
 	non-removable;
 	cap-power-off-card;
 	keep-power-in-suspend;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 484b837757f3..74c0509f99e9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1121,7 +1121,6 @@
 			bus-width = <0x4>;
 			disable-wp;
 			cap-sd-highspeed;
-			supports-highspeed;
 			card-detect-delay = <200>;
 			reg = <0x0 0xff37f000 0x0 0x1000>;
 			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
@@ -1142,12 +1141,6 @@
 			sd-uhs-sdr50;
 			sd-uhs-sdr104;
 			status = "disabled";
-
-			slot@0 {
-				reg = <0x0>;
-				bus-width = <4>;
-				disable-wp;
-			};
 		};
 
 		/* SDIO */
@@ -1162,7 +1155,6 @@
 			reset-names = "reset";
 			card-detect-delay = <200>;
 			cap-sd-highspeed;
-			supports-highspeed;
 			keep-power-in-suspend;
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdio_pmx_func
-- 
2.11.0

