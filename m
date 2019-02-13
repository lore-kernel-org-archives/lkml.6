Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF582C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA29B21901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391576AbfBMKuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:50:55 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47899 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391545AbfBMKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:50:51 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DAkvNf020737;
        Wed, 13 Feb 2019 11:50:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qjfy6akcj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Feb 2019 11:50:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71B6A38;
        Wed, 13 Feb 2019 10:50:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E8E9F4EE5;
        Wed, 13 Feb 2019 10:50:36 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Feb 2019 11:50:36
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC:     <u.kleine-koenig@pengutronix.de>, <tduszyns@gmail.com>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 1/3] dt-bindings: pwm-stm32-lp: document pinctrl sleep state
Date:   Wed, 13 Feb 2019 11:50:10 +0100
Message-ID: <1550055012-23348-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for pinctrl sleep state on STM32 LPTimer PWM.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
index bd23302..6521bc4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -11,8 +11,10 @@ Required parameters:
 			bindings defined in pwm.txt.
 
 Optional properties:
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		Phandle pointing to pin configuration node for PWM.
+- pinctrl-names: 	Set to "default". An additional "sleep" state can be
+			defined to set pins in sleep state when in low power.
+- pinctrl-n: 		Phandle(s) pointing to pin configuration node for PWM,
+			respectively for "default" and "sleep" states.
 
 Example:
 	timer@40002400 {
@@ -21,7 +23,8 @@ Example:
 		pwm {
 			compatible = "st,stm32-pwm-lp";
 			#pwm-cells = <3>;
-			pinctrl-names = "default";
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&lppwm1_pins>;
+			pinctrl-1 = <&lppwm1_sleep_pins>;
 		};
 	};
-- 
1.9.1

