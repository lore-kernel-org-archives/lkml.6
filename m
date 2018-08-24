Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B70EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CCE2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J4uQBeLN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aZlP6P1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CCE2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeHXXnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:43:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:43:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC03B605A4; Fri, 24 Aug 2018 20:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141234;
        bh=LgJG3k90wDm+T9oL8OpZ8qUFfYVfRDWGfnQIOfWoG1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4uQBeLNt/jbNwIScfTJ0OeC3KJeE9HoOrdaYL0kACl1UURzWuITMkSzByafOFveG
         sBqEMKeW8RMjK+zP8we7uHR40B+YpSG6CDk+Au5ERssRjfq8GxLeF0oUdaf/jAFZbK
         8FAG+loFvP0YLR0M6VaPAGCxIJ9rM+aWrgvWJ2mw=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75CB2605A2;
        Fri, 24 Aug 2018 20:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141230;
        bh=LgJG3k90wDm+T9oL8OpZ8qUFfYVfRDWGfnQIOfWoG1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZlP6P1K8ojCK0iGKG0PTfqPQIHXYv6msMtblbuvhQ4t5o1Oxdc7aQeeefju4Vpp7
         evRxpfzbZ6Sduzeg7TtPmKWoTDtxkYjGfUAvju3RLKDIx49gEO3T5uNctYgSBp3rp9
         /4bHvxroLdnfBSJ72yvW+Uzt3r7kBsClrNhmE70E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75CB2605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH RFC 2/6] dt-bindings: introduce System PM bindings for Qualcomm SoCs
Date:   Sat, 25 Aug 2018 01:36:24 +0530
Message-Id: <1535141188-29731-3-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device binding documentation for Qualcomm Technology Inc's System PM
driver. The driver is used for managing system sleep activities that are
required when application processor is going to deepest low power mode.

Cc: devicetree@vger.kernel.org
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/system_pm.txt     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/system_pm.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/system_pm.txt b/Documentation/devicetree/bindings/soc/qcom/system_pm.txt
new file mode 100644
index 0000000..0915760
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/system_pm.txt
@@ -0,0 +1,28 @@
+System PM
+---------
+
+System PM device handles the tasks that need to be performed during application
+processor deeper low power mode entry for QCOM SoCs which have hardened IP blocks
+combinedly called as RPMH (Resource Power Manager Hardened) for shared resource
+management. System PM is a client of APPS_RSC. Flushing the buffered requests to
+TCSs in RSC and programming the wakeup timer in PDC for timer based wakeup are
+handled by this device.
+
+The bindings for System PM is specified in the RSC section in devicetree.
+
+Properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,system-pm".
+
+Example:
+
+	apps_rsc: rsc@179c0000 {
+		[...]
+		system_pm {
+			compatible = "qcom,system-pm";
+		};
+	};
+
+
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

