Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711C2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B7B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfANIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:16:50 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:61217 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbfANIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:16:46 -0500
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id 7C/C6-14930-A654C3C5; Mon, 14 Jan 2019 08:16:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRWlGSWpSXmKPExsVy8+3OTbqZrjY
  xBu+3WltMffiEzWL+kXOsFqe2NzFZ3P96lNHi25UOJovLu+awWcxe0s9isfT6RSaL1r1H2C32
  X/Fy4PJYM28No8e3r5NYPHbOusvusWlVJ5vHnWt72DyO39jO5PF5k1wAexRrZl5SfkUCa0Zr9
  2nGghmCFZ9XfWdvYLzL18XIxSEksJpRYv7uHSwQzlNGie9zpjF3MXICORUSS389ZgWx2QSsJH
  avWcwCYosIyElM+TodrIFZYCuTxI2/F9m6GDk4hAU8JDZfqQWpYRFQlVi79yFYPa+Ar8Sa3RO
  ZQGwJoN6b5zrB5nMK+Eg8aJ7CBrHLW+LT9sdsEPWCEidnPgHrZRaQkDj44gXUPVoSV/8dZIeY
  oyCx88cxZgg7TuLQqWOsELamRMOybVC77CWmv78KVWMo8X3WNxYI21zi3Y1dUHNsJA79bWWDs
  E0lXv2YzARjH2+fxTyBUWIWkpNmITlpASPTKkaLpKLM9IyS3MTMHF1DAwNdQ0NjXVNdEzO9xC
  rdJL3UUt3k1LySokSgpF5iebFecWVuck6KXl5qySZGYOynFLLq7WCctTz9EKMkB5OSKO9nJ5s
  YIb6k/JTKjMTijPii0pzU4kOMMhwcShK8RS5AOcGi1PTUirTMHGASgklLcPAoifDGg6R5iwsS
  c4sz0yFSpxgVpcR5v4EkBEASGaV5cG2wxHeJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvP
  JApPJl5JXDTXwEtZgJazPbGGmRxSSJCSqqB0dlU+1WcUF2q9IQAi4MGPDM2zCv/11JgdFHrtp
  Dpi4frkwtYbmpwnBRb9fsZd8aORb/fWZWa6Rzq+piys2nFuhtC/v++5V+u2H1dsWxRVfmTZ7N
  vJJp6xbyZxWppqV7iYBjNqv+xK89jXcuvw6wXf05dqN759N5b95tLVTdNVOB2irJSnTM1QIml
  OCPRUIu5qDgRALrPNbZ3AwAA
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-29.tower-246.messagelabs.com!1547453801!262537!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26064 invoked from network); 14 Jan 2019 08:16:41 -0000
Received: from unknown (HELO SVEX01006.wago.local) (217.237.185.178)
  by server-29.tower-246.messagelabs.com with AES128-SHA encrypted SMTP; 14 Jan 2019 08:16:41 -0000
Received: from SVEX01009.wago.local (10.1.103.227) by SVEX01006.wago.local
 (10.1.101.122) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 14 Jan
 2019 09:16:40 +0100
Received: from lc010965.wago.local (10.1.101.139) by SVEX01009.wago.local
 (10.1.103.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 14 Jan
 2019 09:16:40 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)        id
 3635E17029DB; Mon, 14 Jan 2019 09:16:40 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: regulator: extend tps65218 bindings
Date:   Mon, 14 Jan 2019 09:16:33 +0100
Message-ID: <1547453794-18770-2-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.139]
X-ClientProxiedBy: SVEX01012.wago.local (10.1.103.230) To SVEX01009.wago.local
 (10.1.103.227)
X-KSE-ServerInfo: SVEX01009.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 14.01.2019 07:23:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 81a9f692-418a-4f33-bb70-032f75efc73b
X-PP-Proceessed: 76874689-fff8-43e0-8f1a-01f8fc6dac97
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add input voltage configuration options

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

