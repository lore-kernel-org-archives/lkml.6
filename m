Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D298C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48F920811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cjYEpoTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48F920811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbeLMTxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:53:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727707AbeLMTxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:53:42 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBDJoA9U026122
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:53:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=6xPDv9eZuGzy18l8+m8l21alMMgLY5002Osi37fXirM=;
 b=cjYEpoTxWLNSelJAd2nOvr86y39f34QNlK1PU2rTXxTRuM+RRFtLGtWeEqRQqPaAGe+v
 8BloczqzjvaLAf0mRYJiDL581aeBQ/XTtAGMmzgNQWUds+TAgB0Rrptce8AybhJNxg/O
 FwFfeAIkDI8iPig28rbpWA86dzf5eOPqmvU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2pbv9t8dn3-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:53:40 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 13 Dec 2018 11:53:24 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 830714EBD9B4; Thu, 13 Dec 2018 11:53:22 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
Date:   Thu, 13 Dec 2018 11:53:16 -0800
Message-ID: <20181213195319.1333402-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added ADC and other sensor devices in Facebook Tiogapass device tree.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 .../dts/aspeed-bmc-facebook-tiogapass.dts     | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index f8e7b71af7e6..58bbe08d3ba7 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -21,6 +21,25 @@
 	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		oemname0 = "MB_P3V3";
+		oemname1 = "MB_P5V";
+		oemname2 = "MB_P12V";
+		oemname3 = "MB_P1V05";
+		oemname4 = "MB_PVNN_PCH_STBY";
+		oemname5 = "MB_P3V3_STBY";
+		oemname6 = "MB_P5V_STBY";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+					<&adc 4>, <&adc 5>, <&adc 6>;
+	};
+
+	iio-hwmon-battery {
+		oemname0 = "MB_P3V_BAT";
+		compatible = "iio-hwmon";
+		io-channels = <&adc 7>;
+	};
 };
 
 &fmc {
@@ -64,6 +83,10 @@
 	use-ncsi;
 };
 
+&adc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 	//Airmax Conn B, CPU0 PIROM, CPU1 PIROM
@@ -122,6 +145,10 @@
 
 &i2c8 {
 	status = "okay";
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
 	//Mezz Sensor SMBus
 };
 
@@ -134,13 +161,15 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	oemname0 = "System_Fan_Connector_1";
+	oemname1 = "System_Fan_Connector_3";
 	fan@0 {
 		reg = <0x00>;
 		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
 	};
 
 	fan@1 {
-		reg = <0x00>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
 	};
 };
-- 
2.17.1

