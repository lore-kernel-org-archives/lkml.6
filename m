Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359032-1525295234-2-7245387419931727404
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295232; b=JLXZIHUcHQLp7xnK+Npkzg92SyRljjsKKdDJsMiGXHyHikXgxy
    1dJfoh92srIynB5QRPK9c3G71qzMMV90LYV1AQCVLW5pFQLQQYFa7PomETtc/cic
    8pNAVMHC6jGk3aaIN1hoKKu7WM8quEW0C20MJZ4Sr8J35xSzAB01HN9J1jMipRPh
    Rgdj0rVSkHgXIymlzdfG+hPAHI953GrRzOysi/92Wr8T8ay+HQuI4Vr9yErVg9G2
    pRi3wAiYLAPuBkBhNfJUQQaaRZ4kHdEtrSURbX2ibZsNeYqE1/d+6YIvTH0iK1dF
    0lIsVcW0RI1ArMYVGuQtIfVE3NHyMJjox/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295232; bh=
    ipHC3TNdt0wp/yQQ0YZgTItqU9fxAVrwY4OtzDTemEg=; b=XwNfryVMF9+djwsd
    LFX1eqOR6o9X/tMcQwTYPPRMGMv6SjYssoOneK/9ZH1j2sJtmhTA75a4yw4B3sUP
    Ay426ma4Aot+eJ5xFqmBCmBxbsNRIeErRFfhMiH21/p4QX0DKuxDQYobAND22FGM
    aeVHIHLB5tUuvc0hrlbFIJ09aA+ClG3jZezMTSibCIjj5aj1jAm7jcOpTHLTBKWq
    0VSzN6d7PfXqSTM9bY51+aR1AcviiD/xUaX2vQ2Mb3gQkpCqGWbwY0R9vpbfYkbE
    V/z6T+RP5a9t7XbPxncxh5HVIV8BzkXfeBcPyo+d81ily27AnuXwGXm1FBZMokh/
    0B3pIw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=be2z1guk
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=hIAvsSjs
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=be2z1guk
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=hIAvsSjs
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNYRk+V9w/CxIaj6EQd9RIKRKU8n2YsVOmISMZnEmA6UooyKmJrYyPuBC5mciW6w+cOCoRuaWNYtPdthoqllwQh6uFffH850T9+s5AjBlG+09GHDqvKy
    HAw4+PkGtf5CN/1C/25Gk6tFpox0h1wLKWb5DROf9veo3i1fPZqiaoQQts0DhAG6ukIH38tT6RsXY/FE3xcf/HW3YONvyNtLCcozkqy9sU37Et6aonW5A4MI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=bFz3XOI1nxBtEX3BfOcA:9 a=x8gzFH9gYPwA:10
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeEBVHF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:07:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeEBVG6 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 17:06:58 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AD3360310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v5 6/7] dt-bindings: phy-qcom-usb2: Add support to override tuning values
Date: Thu,  3 May 2018 02:36:13 +0530
Message-Id: <1525295174-15995-7-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To improve eye diagram for PHYs on different boards of same SOC,
some parameters may need to be changed. Provide device tree
properties to override these from board specific device tree
files. While at it, replace "qcom,qusb2-v2-phy" with compatible
string for USB2 PHY on sdm845 which was earlier added for
sdm845 only.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     | 23 +++++++++++++-
 include/dt-bindings/phy/phy-qcom-qusb2.h           | 37 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h

diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
index 42c9742..03025d9 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
@@ -6,7 +6,7 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
 Required properties:
  - compatible: compatible list, contains
 	       "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
-	       "qcom,qusb2-v2-phy" for QUSB2 V2 PHY.
+	       "qcom,sdm845-qusb2-phy" for 10nm PHY on sdm845.
 
  - reg: offset and length of the PHY register set.
  - #phy-cells: must be 0.
@@ -27,6 +27,27 @@ Optional properties:
 		tuning parameter value for qusb2 phy.
 
  - qcom,tcsr-syscon: Phandle to TCSR syscon register region.
+ - qcom,imp-res-offset-value: It is a 6 bit value that specifies offset to be
+		added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
+		tuning parameter that may vary for different boards of same SOC.
+		This property is applicable to only QUSB2 v2 PHY (sdm845).
+ - qcom,hstx-trim-value: It is a 4 bit value that specifies tuning for HSTX
+		output current.
+		Possible range is - 15mA to 24mA (stepsize of 600 uA).
+		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
+		This property is applicable to only QUSB2 v2 PHY (sdm845).
+		Default value is 22.2mA for sdm845.
+ - qcom,preemphasis-level: It is a 2 bit value that specifies pre-emphasis level.
+		Possible range is 0 to 15% (stepsize of 5%).
+		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
+		This property is applicable to only QUSB2 v2 PHY (sdm845).
+		Default value is 10% for sdm845.
+- qcom,preemphasis-width: It is a 1 bit value that specifies how long the HSTX
+		pre-emphasis (specified using qcom,preemphasis-level) must be in
+		effect. Duration could be half-bit of full-bit.
+		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
+		This property is applicable to only QUSB2 v2 PHY (sdm845).
+		Default value is full-bit width for sdm845.
 
 Example:
 	hsusb_phy: phy@7411000 {
diff --git a/include/dt-bindings/phy/phy-qcom-qusb2.h b/include/dt-bindings/phy/phy-qcom-qusb2.h
new file mode 100644
index 0000000..aea814a
--- /dev/null
+++ b/include/dt-bindings/phy/phy-qcom-qusb2.h
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_PHY_QUSB2_H_
+#define _DT_BINDINGS_QCOM_PHY_QUSB2_H_
+
+/* PHY HSTX TRIM bit values (24mA to 15mA) */
+#define QUSB2_V2_HSTX_TRIM_24_0_MA		0x0
+#define QUSB2_V2_HSTX_TRIM_23_4_MA		0x1
+#define QUSB2_V2_HSTX_TRIM_22_8_MA		0x2
+#define QUSB2_V2_HSTX_TRIM_22_2_MA		0x3
+#define QUSB2_V2_HSTX_TRIM_21_6_MA		0x4
+#define QUSB2_V2_HSTX_TRIM_21_0_MA		0x5
+#define QUSB2_V2_HSTX_TRIM_20_4_MA		0x6
+#define QUSB2_V2_HSTX_TRIM_19_8_MA		0x7
+#define QUSB2_V2_HSTX_TRIM_19_2_MA		0x8
+#define QUSB2_V2_HSTX_TRIM_18_6_MA		0x9
+#define QUSB2_V2_HSTX_TRIM_18_0_MA		0xa
+#define QUSB2_V2_HSTX_TRIM_17_4_MA		0xb
+#define QUSB2_V2_HSTX_TRIM_16_8_MA		0xc
+#define QUSB2_V2_HSTX_TRIM_16_2_MA		0xd
+#define QUSB2_V2_HSTX_TRIM_15_6_MA		0xe
+#define QUSB2_V2_HSTX_TRIM_15_0_MA		0xf
+
+/* PHY PREEMPHASIS bit values */
+#define QUSB2_V2_PREEMPHASIS_NONE		0
+#define QUSB2_V2_PREEMPHASIS_5_PERCENT		1
+#define QUSB2_V2_PREEMPHASIS_10_PERCENT		2
+#define QUSB2_V2_PREEMPHASIS_15_PERCENT		3
+
+/* PHY PREEMPHASIS-WIDTH bit values */
+#define QUSB2_V2_PREEMPHASIS_WIDTH_FULL_BIT	0
+#define QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT	1
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

