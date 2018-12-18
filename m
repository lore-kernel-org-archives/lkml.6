Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F69C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C22133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeLRIHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:07:04 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:12427 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbeLRIGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:06:37 -0500
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 52/EB-12141-98AA81C5; Tue, 18 Dec 2018 08:06:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRWlGSWpSXmKPExsVy8+3OTbodqyR
  iDL4v5LeY+vAJm8X8I+dYLe5/Pcpo8e1KB5PF5V1z2CxmL+lnsVh6/SKTReveI+wW+694OXB6
  rJm3htHj29dJLB47Z91l99i0qpPN4861PWwenzfJBbBFsWbmJeVXJLBmTDn9l61gE1fF9IuLG
  RsYuzm7GLk4hARWM0o0PzzDAuE8ZZT48vokYxcjJ5BTITFhyi0mEJtNwEpi95rFQEUcHCICKh
  Ln3piD1DMLTGGS2Dh7GgtIjbCAq8TeuyeYQGpYBFQl7p5OBAnzCvhIXP54ihXElhCQk7h5rpM
  ZxOYU8JU4Ov0gM8QqH4n7MyazQdQLSpyc+QRsJLOAhMTBFy+garQkrv47yA4yXkJAQeLlmziI
  kXESc2ceZYIIa0p0PsiCCNtLTH9/lRnCNpT4PusbC4RtLnH842WouI3Eob+tbBC2qcSmr9Ph7
  OPts5gnMErMQnLQLCQHLWBkWsVokVSUmZ5RkpuYmaNraGCga2hopGtoaaZraGKsl1ilm6SXWq
  pbnlpcomuol1herFdcmZuck6KXl1qyiREY4SkFR/p3MD5bnn6IUZKDSUmU9/RyiRghvqT8lMq
  MxOKM+KLSnNTiQ4wyHBxKErwzVgLlBItS01Mr0jJzgKkGJi3BwaMkwlsPkuYtLkjMLc5Mh0id
  YlSUEufdBpIQAElklObBtcHS2yVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrwbQabwZOaVw
  E1/BbSYCWhxzhYmkMUliQgpqQbGVt3SBJt7LXfuvuhZd2l34PGrsZ8MxFtmhiZrTlMQcmH4mv
  5r+ooPHf1vPL/FvGcPcapf9mam3aW2I3YbeqR/Wqa4xyTHpewSbCzmN30xvf2Gxs+Q6/1Zf+4
  nl2atNZnuHuixvz84Wqn4ereGa41eel3mjKpp9xSC9cXFN80IXj1necrWmpdKLMUZiYZazEXF
  iQCF5ACdagMAAA==
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-20.tower-282.messagelabs.com!1545120391!3961610!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11595 invoked from network); 18 Dec 2018 08:06:32 -0000
Received: from unknown (HELO SVEX01006.wago.local) (217.237.185.178)
  by server-20.tower-282.messagelabs.com with AES128-SHA encrypted SMTP; 18 Dec 2018 08:06:32 -0000
Received: from SVEX01011.wago.local (10.1.103.229) by SVEX01006.wago.local
 (10.1.101.122) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 18 Dec
 2018 09:06:31 +0100
Received: from lc010965.wago.local (10.1.101.133) by SVEX01011.wago.local
 (10.1.103.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Tue, 18 Dec
 2018 09:06:30 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)        id
 B8019170069F; Tue, 18 Dec 2018 09:06:30 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: regulator: extend tps65218 bindings
Date:   Tue, 18 Dec 2018 09:05:55 +0100
Message-ID: <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.133]
X-ClientProxiedBy: SVEX01011.wago.local (10.1.103.229) To SVEX01011.wago.local
 (10.1.103.229)
X-KSE-ServerInfo: SVEX01011.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 18.12.2018 03:56:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 7aa37ed7-add0-4ed7-8916-66d632c2b0a3
X-PP-Proceessed: 76874689-fff8-43e0-8f1a-01f8fc6dac97
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add input voltage configuration options

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 Documentation/devicetree/bindings/regulator/tps65218.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index 02f0e9b..a9ee377 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -16,12 +16,22 @@ Required properties:
   regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3.
   Each regulator is defined using the standard binding for regulators.
 
+Optional properties:
+  If any of these properties is absent, the setting will not be touched.
+- strict-supply-voltage: <1|0> Set/Reset STRICT flag in CONFIG1
+- under-voltage-limit: Select 2.75, 2.95, 3.25 or 3.35V as UVLO in CONFIG1
+- under-voltage-hysteresis: Select 200mV or 400mV UVLOHYS in CONFIG2
+
 Example:
 tps65218: tps65218@24 {
 	reg = <0x24>;
 	compatible = "ti,tps65218";
 	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
 	interrupt-controller;
+	strict-supply-voltage = <1>;
+	under-voltage-hysteresis = <400000>;
+	under-voltage-limit = <3350000>;
+
 	#interrupt-cells = <2>;
 
 	dcdc1: regulator-dcdc1 {
-- 
2.7.4

