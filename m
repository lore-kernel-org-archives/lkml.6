Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19061C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08FF20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="D+3a8+d+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfARQcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:32:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46906 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfARQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:32:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so6559639ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BsYwI4MGKscqtd4fapjUVq4zzWRiadQNZwYTiXxWLI=;
        b=D+3a8+d+1MT0h2pdwphXLRMdk+66om07H04tXs+3CLjVZU5A/QqhvuGH2u2cPnResn
         gR05lHVX9lO5yh4MbmYCbxoc2huvjEh9leunG39Xo7y9wF/5DU+Aa+FloS0CqVC2OhG5
         6rhGOm5aYKv+RBykV4dAm7LPJDVHQPtyIavZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BsYwI4MGKscqtd4fapjUVq4zzWRiadQNZwYTiXxWLI=;
        b=keh+R4HjHGWgzjx4mnvBOkTOeaScdt8giYcpjqMkK9778T+vIWJlVcM6neXMqBXcl+
         bJcuRLuRXKYomzVJlETEqFDFZMic03fVgoUaCY/P2vY13hGht4LZoR+iS26q9hgICqrs
         DGmc6Sh7IbvdooLHw0EmS2x/PGM5A5CAAKuUpjJeukplBPtCLLX3E2RtlETvrLnTN8/E
         JuUWhZ/13NUXXguZn4ujjEbD0XEanu0Lm/BIB+YmQNJ/KjlCEhSBgA4bN2ruwiqpIhHV
         sEnbYUEeI6SnbPH+nf+dXxBKknMErDRAXAsR5VHaBJSbYhHVb64+/tWXRyP7V1HN4SYm
         HKlg==
X-Gm-Message-State: AJcUukd2n3C/qpYVVONjKUTp1Mbk9naNeKqI+U2fSV1oe3RS4JLDwMJY
        e2hwmZwaZ4B2EN7ILbTmTbuKHw==
X-Google-Smtp-Source: ALg8bN6mvpQp3YAX6GkW1M5KsfZsri3zQjDYciQGsdE6EzPzxtCuG2Y1UzZFFrJWaw+8/+vUvRXvkg==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr19680460pld.258.1547829150371;
        Fri, 18 Jan 2019 08:32:30 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
        by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:32:29 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 5/6] arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
Date:   Fri, 18 Jan 2019 22:01:57 +0530
Message-Id: <20190118163158.21418-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some camera modules have the SoC feeding a master clock to the sensor
instead of having a standalone crystal. This clock signal is generated
from the clock control unit and output from the CSI MCLK function of
pin PE1.

Add a pinmux setting for it for camera sensors to reference.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 89a0deb3fe6a..dd5740bc3fc9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -538,6 +538,11 @@
 				function = "csi0";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3

