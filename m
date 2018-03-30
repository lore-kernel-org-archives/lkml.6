Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeC3QLq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:11:46 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41107 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeC3QLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:11:44 -0400
X-Google-Smtp-Source: AG47ELvO+41bxfwvgc+G9uuQJbu5Otp/9ZYSGAAUBSincCEfp6g3yexqyevZesCmoQiwO4zblAK0UA==
From: Ryan Grachek <ryan@edited.us>
Cc: Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hikey: Enable SDIO high-speed mode on WL1835 module
Date: Fri, 30 Mar 2018 11:11:18 -0500
Message-Id: <20180330161118.5751-1-ryan@edited.us>
X-Mailer: git-send-email 2.11.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to hardware documentation, the WL1835MOD WiFi chip
supports SDIO high-speed mode, which increases the clock to
50 MHz. This results in a modest increase in throughput.

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 5d5aa4f4a235..a5e0cc4370e1 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -322,6 +322,7 @@
 
 		dwmmc_2: dwmmc2@f723f000 {
 			bus-width = <0x4>;
+			cap-sd-highspeed;
 			non-removable;
 			vmmc-supply = <&reg_vdd_3v3>;
 			mmc-pwrseq = <&wl1835_pwrseq>;
-- 
2.11.0
