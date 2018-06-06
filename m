Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv6h9Kyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A681460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbeFFJew (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:34:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37778 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932543AbeFFJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:34:49 -0400
X-Google-Smtp-Source: ADUXVKLZLAEErciD03TDfHalSP3M2eLVnAGzKrFCSfzf14qG6S/zDqv+05I/IgIeQkZB8ARgBJ8DbQ==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH] ARM: dts: cygnus: Add HWRNG node
Date: Wed,  6 Jun 2018 11:34:41 +0200
Message-Id: <20180606093441.16483-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

There is a HWRNG in Broadcom Cygnus SoC, so enable it.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 1cee40ac4613..b7178e84d56d 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -452,6 +452,11 @@
 			status = "disabled";
 		};
 
+		hwrng: hwrng@18032000 {
+			compatible = "brcm,iproc-rng200";
+			reg = <0x18032000 0x28>;
+		};
+
 		sdhci0: sdhci@18041000 {
 			compatible = "brcm,sdhci-iproc-cygnus";
 			reg = <0x18041000 0x100>;
-- 
2.17.1
