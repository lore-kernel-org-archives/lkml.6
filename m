Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B676CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846CE20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846CE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeLBVSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:18:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39626 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeLBVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:18:45 -0500
Received: by mail-qk1-f196.google.com with SMTP id q70so6221893qkh.6;
        Sun, 02 Dec 2018 13:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=kMmCdcHh817VaRsjdnnuJ2NzdFpse3gt0nZG9kO//8k=;
        b=AO/zA+EHmVA2jBj6bcr9/Fu0Zwop8WmL3B2P8ETyr/s5L0INmLYWRYhOCd1AEIWAf4
         U3QTCyzxcs9OFBphx9Gv6VpY3amjq3QDjqAhId6xMYtBfPKtrnmzq5sDQHbCQZEx+VC5
         kN2+C4lTqIA83yIaqYgE9U5rXcH0GSyytlYpaSh/eQuFK55NVqz1iHi0/thHr6Tr/1I6
         H/uACJ6+KnJpbn6g2dCCCqSCumIIQkFQ/2zTu++XQlzwhy+VHyXaxoPegPAvhhQKLvs9
         HBlBJdUXp0z0ZJ8Se3qBOejoTe9I8krJpflalzUCa533STEHj8Oud+15NQsio7wr2EBZ
         5SRg==
X-Gm-Message-State: AA+aEWalJSwBA3mwjSANmHUkJ4rc31Sum55iVDk7+GX5DvKLDHS72qlN
        m6e7Pze04qBYCD2qlupR7qc=
X-Google-Smtp-Source: AFSGD/VUdFF9ST2bE1mVu/A1aHDJAuATO2XuJ3SVegrszEr2sMBgvEacIDdqLoHXEk6c83BT73s7Aw==
X-Received: by 2002:a37:6749:: with SMTP id b70mr12652812qkc.41.1543785523843;
        Sun, 02 Dec 2018 13:18:43 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id m1sm9610025qkh.15.2018.12.02.13.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:18:43 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:18:36 -0200
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
Subject: [PATCH 3/5] ARM: dts: imx6ul-pico-hobbit: Make the child led nodes standard
Date:   Sun,  2 Dec 2018 19:18:07 -0200
Message-Id: <20181202211809.11621-4-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202211809.11621-1-otavio@ossystems.com.br>
References: <20181202211809.11621-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Use the same child led node and label name as used in the
imx7d-pico-hobbit board.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 3cc04dd6f341..8656ccbb5a06 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -15,8 +15,8 @@
 	leds {
 		compatible = "gpio-leds";
 
-		hobbitled {
-			label = "hobbitled";
+		led {
+			label = "gpio-led";
 			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
 		};
 	};
-- 
2.19.2

