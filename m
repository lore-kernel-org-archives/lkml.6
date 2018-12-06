Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA62C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC8220672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC8220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeLFKJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:09:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45937 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:09:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so25596109qtr.12;
        Thu, 06 Dec 2018 02:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=uuAA08QKScYw3fsRf3URpZe6l85kQOqeOIxl0eNvqCM=;
        b=BgIPcL0/6BSXL5mhsn8x9pbNa1JTH9deXYoen7Alk9LmRp8MCyHORvA7wGtCtZ3syp
         MMUD4kfFts5Hzn2uCeUm93uAFFNdwDzWcl2F4u5V4gVkWsubzRZBtUKJeYcOUx7MyM4q
         8zn/BGPl1KHt46vy+DQv67EdqeZSpj/Nz/1/vJWjf0hIM2yHnarcLPI+/T8FzG/lLtMz
         sZOa4vUetlMkCE5lFlUQk6MewtFRNXwKgvVHEF1oJ47nx1jCo0Ps2PV6ADVIym635jrl
         kAh2Qd7nIip3MkvYi8qJlEeDYj4BMYJUTPPaHC9Gdrb9boad0bY8mkOnJF+a6of+8gPd
         wZ6w==
X-Gm-Message-State: AA+aEWYMpdE6oGKC7sw88+97Vm5QKcIxfdF8d9vZxaSehK3jDv8I4FqJ
        0yK/Z+SI9z6LWv/BSYGUQ+U=
X-Google-Smtp-Source: AFSGD/Vy3eJG31zis4TFA88ZsW3HrTY1wKYcyWZdpxYxm+oJAp8CVDO3DBGRflPsLVQV1n4qYStglA==
X-Received: by 2002:a0c:8936:: with SMTP id 51mr27184459qvp.220.1544090985833;
        Thu, 06 Dec 2018 02:09:45 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id p31sm18136118qkh.86.2018.12.06.02.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:09:45 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 06 Dec 2018 08:09:38 -0200
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
Subject: [PATCH v2 4/9] ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
Date:   Thu,  6 Dec 2018 08:09:00 -0200
Message-Id: <20181206100905.15053-5-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
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

Changes in v2: None

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

