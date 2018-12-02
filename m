Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0387DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50322082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50322082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLBV0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:26:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35367 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:26:01 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so11674513qtc.2;
        Sun, 02 Dec 2018 13:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=Ucrg0FmBQWhPhP3EvzOr0Lyei3/PizNO0LDkOiMRUHU=;
        b=qzaC0mOurbSL8ZVHe/CoPJwg/eHzcDkH07OeKfTsuLNU5xiBP018DQe2Jd0IxfRwyx
         Xnv92JtYTkAoeMm5AFhWTKjpnOYbv1mWDnFhoXL6E6v91n4eBU+MUAmLd0dbN1R7+kl4
         vJfaQwk42atctlYEftsjA8/Fg0asN2HEbCUJhajQdGVF6JOevWHKbn3KrAXL9WvytQ1w
         6sV7NYBnqcpcr3tR9nDf0e3mOYAz8zhGV7z3qpmgVKVCaw9a8NBYGxHK5gcweBHX/7td
         7BtWAPK6LG3rOqBUGX7qLltyYNkH1KCVpsAbpz1L9caqITordf7bEDchNRAPgPqlOKfU
         gf8g==
X-Gm-Message-State: AA+aEWYTpjlMbrt4RAbVyge2LMH650bdvFocbNjw++1rx+dAzEFQB0RM
        Xei1U45WNUipGHjPfhabvrI=
X-Google-Smtp-Source: AFSGD/WyXdn17bQ1wucLDBQKF0jVrb+UGwZ7yQbXQrqTGjkDGmhSymaNJvu4lGSnXg5h9lyMaWu0Bg==
X-Received: by 2002:a0c:b919:: with SMTP id u25mr13566244qvf.104.1543785958509;
        Sun, 02 Dec 2018 13:25:58 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id e26sm6077085qtg.69.2018.12.02.13.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:25:57 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:25:51 -0200
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
Subject: [PATCH 4/9] ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
Date:   Sun,  2 Dec 2018 19:25:15 -0200
Message-Id: <20181202212520.16650-5-otavio@ossystems.com.br>
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

Pass the USBOTG1_PWR pinctrl description in the USBOTG GPIO
controlled regulator.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 7319e2ecec5c..cb30bded1e4a 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -41,6 +41,8 @@
 	};
 
 	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg1_pwr>;
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
 		regulator-min-microvolt = <5000000>;
-- 
2.19.2

