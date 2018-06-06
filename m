Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BSB3meC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E92C605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeFFSVu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:21:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41612 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeFFSVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:21:48 -0400
X-Google-Smtp-Source: ADUXVKJNHF1tKwbRFJWkrvqCOcneHGPGxdVe1GUywgAPjm+r2keKPbuSPJbbVu4c8xkid4hsNoDRSA==
From: Scott Branden <scott.branden@broadcom.com>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Clement Peron <peron.clem@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mohamed Ismail Abdul Packir Mohamed
        <mohamed-ismail.abdul@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 1/1] ARM: dts: cygnus: enable iproc-hwrng
Date: Wed,  6 Jun 2018 11:21:31 -0700
Message-Id: <1528309291-25579-1-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>

Enable the HW rng driver "iproc-rng200" for all cygnus platforms.

Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 9fe4f5a..b0e38fa 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -417,6 +417,11 @@
 			status = "disabled";
 		};
 
+		rng: rng@18032000 {
+			compatible = "brcm,iproc-rng200";
+			reg = <0x18032000 0x28>;
+		};
+
 		sdhci0: sdhci@18041000 {
 			compatible = "brcm,sdhci-iproc-cygnus";
 			reg = <0x18041000 0x100>;
-- 
2.5.0
