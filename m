Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2578C41536
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C04220878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HYcrFsJk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kGGaPcoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C04220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeKUKjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:39:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeKUKjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:39:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B1D260C4C; Wed, 21 Nov 2018 00:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542758843;
        bh=dI/YF/YLgNGAhMIFdHF3+jTzVJx1RL6JwVJbhbfEis0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYcrFsJkzO2FQv5kxoGrJ6GIKWnRNuzrpC7nSSErLdnt0Q/KUEecDrZUdFs82mvT0
         CQ0/IRZ/hD3hq7TvE3vR3WCRF2ge83f1fBnqp8pZDHGYEXGx8XunjNjfPf5oEMUb0Q
         vkkQxf2OS7pKHbGLHku5+CaujIe73VbSFKy7cFhw=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8E5C60B19;
        Wed, 21 Nov 2018 00:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542758842;
        bh=dI/YF/YLgNGAhMIFdHF3+jTzVJx1RL6JwVJbhbfEis0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGGaPcoKjUtH8Nn3DzFfPYOtjeGHcrj68YFvjVebnSxM6CaDl5EMBwI6pvSROjtow
         CkTQUqXLskajnGAZqq0yZPMOqZClo2Um8yD5Wx2pHwWYonGOeLqHXP6H84aOwdRKsZ
         ZT+KgfJ6MVxV3Gt3y0uHfRTV/61MylOfIf6aWFqI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8E5C60B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, Lina Iyer <ilina@codeaurora.org>
Subject: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
Date:   Tue, 20 Nov 2018 17:06:47 -0700
Message-Id: <20181121000648.29262-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121000648.29262-1-ilina@codeaurora.org>
References: <20181121000648.29262-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
routed to the PDC as interrupts that can be used to wake the system up
from deep low power modes and suspend.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
index 665aadb5ea28..bedfa0b57fa6 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
@@ -29,6 +29,17 @@ SDM845 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/interrupt-controller/irq.h>
 
+- wakeup-parent:
+	Usage: optional
+	Value type: <phandle>
+	Definition: A phandle to the wakeup interrupt controller for the SoC.
+
+- wakeup-irq:
+	Usage: optional:
+	Value type: <u32 array>
+	Definition: Specifies the map of the gpio and the corresponding PDC
+	            output port.
+
 - gpio-controller:
 	Usage: required
 	Value type: <none>
@@ -53,7 +64,6 @@ pin, a group, or a list of pins or groups. This configuration can include the
 mux function to select on those pin(s)/group(s), and various pin configuration
 parameters, such as pull-up, drive strength, etc.
 
-
 PIN CONFIGURATION NODES:
 
 The name of each subnode is not important; all subnodes should be enumerated
@@ -160,6 +170,25 @@ Example:
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		wake-parent = <&pdc>;
+		wake-irq =
+			<1 30>, <3 31>, <5 32>, <10 33>, <11 34>,
+			<20 35>, <22 36>, <24 37>, <26 38>, <30 39>,
+			<31 117>, <32 41>, <34 42>, <36 43>, <37 44>,
+			<38 45>, <39 46>, <40 47>, <41 115>, <43 49>,
+			<44 50>, <46 51>, <48 52>, <49 118>, <52 54>,
+			<53 55>, <54 56>, <56 57>, <57 58>, <58 59>,
+			<59 60>, <60 61>, <61 62>, <62 63>, <63 64>,
+			<64 65>, <66 66>, <68 67>, <71 68>, <73 69>,
+			<77 70>, <78 71>, <79 72>, <80 73>, <84 74>,
+			<85 75>, <86 76>, <88 77>, <89 116>, <91 79>,
+			<92 80>, <95 81>, <96 82>, <97 83>, <101 84>,
+			<103 85>, <104 86>, <115 90>, <116 91>,
+			<117 92>, <118 93>, <119 94>, <120 95>,
+			<121 96>, <122 97>, <123 98>, <124 99>,
+			<125 100>, <127 102>, <128 103>, <129 104>,
+			<130 105>, <132 106>, <133 107>, <145 108>;
+
 
 		qup9_active: qup9-active {
 			mux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

