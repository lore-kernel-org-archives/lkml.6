Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924D2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346BF2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kcBLLAfp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f5oodXuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346BF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJKEp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:45:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJKEp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:45:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4A8EE60C72; Wed, 10 Oct 2018 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206515;
        bh=1p+u/PhUAyvhdhWlHurQ5EUgMfSl0SCOqlTj2A7Ldxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcBLLAfp99i9X9iBVrN1qJnIiq6qRqL1wSHfvj04wA5PJ07J61ppQRkO9E9JnlVS9
         yRfOt0nv5FpYKfqnDqiGuupBeDF/+zU4xpU1eIJkq2Gu6YPXYsCI4dzs8B9+spCheZ
         J+pExQJuui/uG4gg4wNKigFiepD+qt05vupEHh68=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A53E60C8E;
        Wed, 10 Oct 2018 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206513;
        bh=1p+u/PhUAyvhdhWlHurQ5EUgMfSl0SCOqlTj2A7Ldxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5oodXuYOrHe7YSv8maaOrKXs57b/7JRhKtG1u9u8c5nnXJ/bbaxhfYoVmihl1Pnn
         BzCU7SALVEOhZ3+xpD8tVJ2JOvt8RMGXCXmgmXDlTEK69sjag+q0u+qg6GpMh/NwFI
         r0vviTsjziT0ISvx69+FXkyletCGVkPKUubpDc2M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A53E60C8E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 5/8] dt-bindings: introduce cpu power domain bindings for Qualcomm SoCs
Date:   Thu, 11 Oct 2018 02:50:52 +0530
Message-Id: <1539206455-29342-6-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device binding documentation for Qualcomm Technology Inc's cpu
domain driver. The driver is used for managing system sleep activities
that are required when application processor is going to deepest low
power mode.

Cc: devicetree@vger.kernel.org
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 .../bindings/soc/qcom/cpu_power_domain.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
new file mode 100644
index 0000000..1c8fe69
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
@@ -0,0 +1,39 @@
+Qualcomm Technologies cpu power domain
+-----------------------------------------
+
+CPU power domain handles the tasks that need to be performed during
+application processor deeper low power mode entry for QCOM SoCs which
+have hardened IP blocks combinedly called as RPMH (Resource Power Manager
+Hardened) for shared resource management. Flushing the buffered requests
+to TCS (Triggered Command Set) in RSC (Resource State Coordinator) and
+programming the wakeup timer in PDC (Power Domain Controller) for timer
+based wakeup are handled as part of domain power down.
+
+The bindings for cpu power domain is specified in the RSC section in
+devicetree.
+
+Properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,cpu-pm-domain".
+
+- #power-domain-cells: number of cells in power domain specifier;
+    must be 0.
+
+Node of a device using power domains must have a power-domains property
+defined with a phandle to respective power domain.
+
+Example:
+
+	apps_rsc: rsc@179c0000 {
+		[...]
+		cpu_pd: power-domain-controller {
+			compatible = "qcom,cpu-pm-domain";
+			#power-domain-cells = <0>;
+		};
+	};
+
+
+See Documentation/devicetree/bindings/power/power_domain.txt for description
+of consumer-side bindings.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

