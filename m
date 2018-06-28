Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AC2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15CC26AEB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhe4ukmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15CC26AEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeF1EZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:25:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41048 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeF1EYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:24:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so1974480pff.8;
        Wed, 27 Jun 2018 21:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bdK4ynP43AhULcihW/50rpf/tDG4BCKIMP413TMh16Q=;
        b=vhe4ukmMPFFxhlU8Q4oGb5Lwim6MKyDmgxmMxJkbYDc2bZ5mIJVdkZcj9uz51auSSD
         FHShnD/xC/oz3/56hwlzUoBmSnsl0NHRj7kREFwJ66kjRPwFHRSLN2g+dT45/0DjRqpd
         BD3oc8a0fF55fmnnAWmaaMYJdtZ+xAwslMU1+C4tuPPzzPxsPfu0nuCF9R1PRiCmz+tx
         JiH0TcVaA+TpAu63nFQ2T8N8hrhLEHKrM6EBcJngUaCl0QDdE6+WrNGLf1lTTr/quYj9
         WQzJGRQHn2ql85GYtzpnSoxfGqB0XlMiPaQoW+JN9zfgQuDdKyw16n2Af+E6xsqCVrVF
         lG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bdK4ynP43AhULcihW/50rpf/tDG4BCKIMP413TMh16Q=;
        b=s/6gOgg2aqzi8yQqR+NBuwZf4QnYm1MhQldMkCjl+0LQGQ15V1eaTlSb54I5vVGVW9
         Ee1rWTNdjPb0AC+dKQ9E2zvgjI4Hmj8bZr5DaDA4MrM/8R23AosTYSheAQr06/iyXn3N
         fkh6030vqEnVwrmO8K6alaC5hXy04yxwojOX4aFEg/6fOiqUxLZtfoGfI5nFmD1k6RtZ
         1RVAyThHN/1/amjVbR7nYBJCmUc20iKVMVVeoPOVkNK9gwbQou3M6oTtfzA0WVEo9eh3
         uYS8Epb77QrBaNaTeLrUN2mUwjhK+1axvmA7bExxPUT2BDpSroT2U2KZ444oUWOv5ROI
         QBaw==
X-Gm-Message-State: APt69E09Wzwl74RuvXQAFY3BM/qcl88psbs2FFeew7efartgepUe+seQ
        mcabrO/Oqzq+uzzxRsQF5yM=
X-Google-Smtp-Source: ADUXVKKheTL+PhlKx3yFPrqltTXYPl6U6HRVkVkIiEekfTMkEhj2gZPYB99TZHS+fbzIf+sIGTiXqw==
X-Received: by 2002:a65:6094:: with SMTP id t20-v6mr7614819pgu.264.1530159888984;
        Wed, 27 Jun 2018 21:24:48 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t19-v6sm12328577pfj.169.2018.06.27.21.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 21:24:48 -0700 (PDT)
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
Subject: [PATCH 1/4] ARM: dts: imx51-zii-rdu1: Populate RAVE SP EEPROM nodes
Date:   Wed, 27 Jun 2018 21:24:21 -0700
Message-Id: <20180628042424.12664-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628042424.12664-1-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZII's RDU1s come with up to 3 EEPROMs attached to RAVE SP. Add
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
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index ad2445dfa91d..c6da263cf210 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -578,6 +578,8 @@
 	rave-sp {
 		compatible = "zii,rave-sp-rdu1";
 		current-speed = <38400>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
 		watchdog {
 			compatible = "zii,rave-sp-watchdog";
@@ -590,6 +592,33 @@
 		pwrbutton {
 			compatible = "zii,rave-sp-pwrbutton";
 		};
+
+		eeprom@a3 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa3 0x2000>;
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
+
+		eeprom@ae {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xae 0x200>;
+			zii,eeprom-name = "switch-eeprom";
+			/*
+			 * Not all RDU1s have this functionality, so we
+			 * rely on the bootloader to enable this
+			 */
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

