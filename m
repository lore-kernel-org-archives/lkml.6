Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DA5C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128192082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128192082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbeLBVZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:25:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43169 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBVZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:25:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so11632633qtj.10;
        Sun, 02 Dec 2018 13:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=5VimbIFi7OVHRFMwGgep9oeo2PRq364OcB5EGIt48LQ=;
        b=dsry+cRXyxlc+69H/DdYtP5aCPUFv12aTbecsRZQHhhWH64A0qA5iBi9NdB8Ns4jpf
         rozp6qqOB21/oCciMDJCcF4WnYHYOwZewwYq6O/zytym5HPfC/3/zRrDCMFXMDWiS0PL
         RfPWdjQeqiQ7/i8F0S0ebkc05zDYuc7ApcN8yxphvzboPF4loYAXHE/vJjjuTZn0AnpU
         gzN2SPjzSx5/tqDbDly5w3w9DWZBxWdQ0RK45cn9QogbraTopreZa9pyK+2JXjw4pRBP
         E/JiHHHjhR549bUyZwM6Rb7irwrFon9E3EJjniDxA5lOoG3GTQRGlTMdOUfmS+eepAkW
         U9ig==
X-Gm-Message-State: AA+aEWZpwlS/C3PlKox1vc1RnMbLNyhwm+kq1ETWbv7a7UXR2Tv5cI9c
        Skfn9HmYosm3x0dxSBquEyE=
X-Google-Smtp-Source: AFSGD/WwshqPF6vSiDOimMrXQUpAYuHlpaXN17LQKoM8pHiOFoif/9z6cep3DLDm/FCD8kD0Bb+4Ew==
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr13379304qta.178.1543785936648;
        Sun, 02 Dec 2018 13:25:36 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id w34sm6900294qtj.27.2018.12.02.13.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:25:35 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:25:29 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 1/9] ARM: dts: imx7d-pico: Do not harcode the memory size
Date:   Sun,  2 Dec 2018 19:25:12 -0200
Message-Id: <20181202212520.16650-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Currently the memory size described in dts is 2GB, which is incorrect.

There are 512MB and 1GB versions of imx7d-pico boards, so remove
the hardcoded memory size and let the bootloader pass the correct
value to the kernel.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 934a019f341e..0df68e53e9fa 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -48,9 +48,10 @@
 	model = "Technexion Pico i.MX7D Board";
 	compatible = "technexion,imx7d-pico", "fsl,imx7d";
 
+	/* Will be filled by the bootloader */
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x80000000 0x80000000>;
+		reg = <0x80000000 0>;
 	};
 
 	reg_ap6212: regulator-ap6212 {
-- 
2.19.2

