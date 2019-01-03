Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD01CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AD2218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfACNut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:50:49 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:4694 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728233AbfACNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:50:46 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 9D/48-18993-2331E2C5; Thu, 03 Jan 2019 13:50:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRWlGSWpSXmKPExsVy8+3OTbpGwno
  xBr2T1SymPnzCZjH/yDlWi1Pbm5gs7n89ymjx7UoHk8XlXXPYLGYv6WexWHr9IpNF694j7Bb7
  r3g5cHmsmbeG0ePb10ksHjtn3WX32LSqk83jzrU9bB7Hb2xn8vi8SS6APYo1My8pvyKBNePEv
  IdsBW8FKt5PnszcwLiNr4uRi0NIYBWjxPyrixkhnCeMEtNXX4ByVjJKtO1tAHI4OdgErCR2r1
  nMAmKLCChLPFjawApSxCywlUnixt+LbF2MHBzCAh4Sk5pYQWpYBFQkDjzZARbmFfCWuPc+GSQ
  sISAncfNcJzOIzSngK3F0+kEwW0jAR+L+jMlsIDavgKDEyZlPwFYxC0hIHHzxAqpGS+Lqv4Ps
  EHMUJM7v3cwGYcdJPHnwixFklYSApkTngyyIsL3E9PdXmSFsQ4nvs76xQNjmEncOdzFC2DYSh
  /62Qo0xldj0dTqcPWF+M8sERolZSC6aheSiBYxMqxgtkooy0zNKchMzc3QNDQx0DQ2NdA0tzX
  QNTU30Eqt0k/RSS3XLU4tLdA31EsuL9Yorc5NzUvTyUks2MQIjP6XgyKwdjL+70g8xSnIwKYn
  ymtzQjRHiS8pPqcxILM6ILyrNSS0+xCjDwaEkwRssqBcjJFiUmp5akZaZA0xBMGkJDh4lEV4+
  IaA0b3FBYm5xZjpE6hSjopQ4rw5InwBIIqM0D64NlvYuMcpKCfMyMjAwCPEUpBblZpagyr9iF
  OdgVBLmrQCZwpOZVwI3/RXQYiagxSYSOiCLSxIRUlINjO3soUzs/q+N2MrM81a1W08xlLziap
  +btDXl3SbHat9P1wRvb3ixRj6hrOmidZlt9Vm3Ou0v6tvE+fmFFgjuWPs65ba2nzDbEcskz8z
  f+/OWiHVz5KX95Tn4V2vB7iNdD7hCr3joXO4L2RUQttd6/4+1zS6CfhN2fTE2mcH18/3fKQtU
  eTSqlFiKMxINtZiLihMBGCG2fnYDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-26.tower-288.messagelabs.com!1546523441!5183639!4
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18576 invoked from network); 3 Jan 2019 13:50:42 -0000
Received: from unknown (HELO SVEX01005.wago.local) (217.237.185.178)
  by server-26.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 3 Jan 2019 13:50:42 -0000
Received: from SVEX01011.wago.local (10.1.103.229) by SVEX01005.wago.local
 (10.1.101.121) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 3 Jan
 2019 14:47:48 +0100
Received: from lc010965.wago.local (10.1.103.197) by SVEX01011.wago.local
 (10.1.103.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Thu, 3 Jan 2019
 14:47:47 +0100
Received: from LC010965.wago.local (lc010965.wago.local [127.0.0.1])    by
 lc010965.wago.local (Postfix) with ESMTP id D17C517016D9;      Thu,  3 Jan 2019
 14:47:47 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: regulator: extend tps65218 bindings
Date:   Thu, 3 Jan 2019 14:47:05 +0100
Message-ID: <1546523226-358-2-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.103.197]
X-ClientProxiedBy: SVEX01014.wago.local (10.1.103.232) To SVEX01011.wago.local
 (10.1.103.229)
X-KSE-ServerInfo: SVEX01011.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 03.01.2019 11:05:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 7aa37ed7-add0-4ed7-8916-66d632c2b0a3
X-PP-Proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add input voltage configuration options

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 .../devicetree/bindings/regulator/tps65218.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index 02f0e9b..982597d 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -16,12 +16,34 @@ Required properties:
   regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3.
   Each regulator is defined using the standard binding for regulators.
 
+Optional properties:
+  If any of these properties is absent then the corresponding setting will be
+  untouched.
+- ti,strict-supply-voltage-supervision: Set/Reset STRICT flag in CONFIG1.
+  The supervisor has two modes of operation, controlled by the STRICT bit.
+  With the STRICT bit set to 0, all five rails are monitored for under-voltage
+  only with relaxed thresholds and deglitch times.
+  With the STRCT bit set to 1, all five rails are monitored for under-voltage
+  and over-voltage with tight limits and short deglitch times.
+- ti,under-voltage-limit-microvolt: Configures UVLO in CONFIG1.
+  Valid values are: 2750000, 2950000, 3250000, 3350000
+- ti,under-voltage-hyst-microvolt: Select 200mV or 400mV UVLOHYS in CONFIG2
+  Power rails are only enabled if the input voltage measured at the IN_BIAS pin
+  is greater than the under-voltage lockout threshold plus hysteresis
+  (UVLO + UVLOHYS). Once the input voltage rises above this level,
+  the input voltage may drop to the UVLO level before the PMIC shuts down.
+  UVLO is deglitched by 5 ms on rising and falling edge.
+
 Example:
 tps65218: tps65218@24 {
 	reg = <0x24>;
 	compatible = "ti,tps65218";
 	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
 	interrupt-controller;
+	ti,strict-supply-voltage-supervision = <1>;
+	ti,under-voltage-hyst-microvolt = <400000>;
+	ti,under-voltage-limit-microvolt = <3350000>;
+
 	#interrupt-cells = <2>;
 
 	dcdc1: regulator-dcdc1 {
-- 
2.7.4

