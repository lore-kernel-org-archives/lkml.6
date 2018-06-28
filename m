Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FBDC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEBF208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dyqx0rZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEBF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbeF1EYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:24:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40505 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeF1EYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:24:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so1975127pfe.7;
        Wed, 27 Jun 2018 21:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=faEWPA7M4lPYuQ6kPDsTX8oB4fK1m6atytDylz/EAt0=;
        b=Dyqx0rZ7KlIWBSpbyzFirPygWr3sNx3HiK1pkf7BlQTRuFJ7lj9IlzaQBDTCVCSvnA
         YzBryS/+W3BoQmFHvRP/W3nGy05h+FhYR4IPsrpe0eboTR2KeeU2uk/f6Y1txcGzVpiw
         7c8AkABrEAW9clpB7ZYiVaKF/MH0K2PoUI/f5K9sKy5byhVd1yHW2C2+15sDV41H6qyJ
         tH97BzeY/4uJiphcnwUK2hoq5sLUmpKaU5L5WqPr0ebm6fgLNcO46cN/7m0HXNHFgJ4O
         MHT0LtRL2hL5AyhT9cwBdGFoXqQdntMlitQkysM9LOBozxFc0Jm5ORaje8TIPCkFzDRv
         8EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=faEWPA7M4lPYuQ6kPDsTX8oB4fK1m6atytDylz/EAt0=;
        b=AIN6m8jgtAuE4U3I8OvFtHBxLS+asCCeQx5sI0LGlr5Qh5t0XIRO9RFdoxmZS24I6k
         IS+QGFC1faM/Ww79tTOkquQRsh7FIJj/vk1jqauRuUsNpObhvKEav+Pd9rwr+kl6fiAJ
         Tn/0BlH7/vz7vH+gnARlL3N4Ex7NE//G/10F2qIwdTehMbHQswFazmmIhSpEaKdXZAon
         WbF+X9xtHVF/3NHXfwhyQZ60kDeKP3JblyBMgVoe6ALRJ6Pny4EIsVXc5V0fKuKBS3cS
         bvpNp2TwIUZShyDMmcJMt6dktFNqQBCgLx7fm6jcn6oX9J/BkpYBDCcM7a35xKth/TIn
         rCww==
X-Gm-Message-State: APt69E0ezfnX7r218TysIAsW2HvhdVD3bLwyQgDfrhEWdimoTq6y+CO2
        pf8bYk3NGtPOTxvg8tr5kJ8=
X-Google-Smtp-Source: AAOMgpezN6a17e+aGYcfscO3gPQPx8sGhV4fnCFEHVGgPANUfHGqP7TVk/SU/FuwvQOs26qXWXrang==
X-Received: by 2002:a63:b047:: with SMTP id z7-v6mr7157222pgo.335.1530159890332;
        Wed, 27 Jun 2018 21:24:50 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t19-v6sm12328577pfj.169.2018.06.27.21.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 21:24:49 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP EEPROM nodes
Date:   Wed, 27 Jun 2018 21:24:22 -0700
Message-Id: <20180628042424.12664-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628042424.12664-1-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZII's RDU1s come with two EEPROMs attached to RAVE SP. Add
corresponding nodes to make them availible.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy@gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 19a075aee19e..e4630481d951 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -320,10 +320,28 @@
 	rave-sp {
 		compatible = "zii,rave-sp-rdu2";
 		current-speed = <1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
 		watchdog {
 			compatible = "zii,rave-sp-watchdog";
 		};
+
+		eeprom@a3 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa3 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "dds-eeprom";
+		};
+
+		eeprom@a4 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa4 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "main-eeprom";
+		};
 	};
 };
 
-- 
2.17.1

