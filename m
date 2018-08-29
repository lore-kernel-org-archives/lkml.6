Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E6AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D489205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Tc7RUJR7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EPgcrjNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D489205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeH2XLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:11:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34184 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2XLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:11:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A2375606DB; Wed, 29 Aug 2018 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569973;
        bh=HabIm/RYZ7cq30Zkse7Kc2g0RbONoVgS0AzMmdw/54Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tc7RUJR75N54WzYTFP6DJlPt4xUWJvDC18QmLfVEFKjsJVA5oTWSNbuv+fRRed3u6
         UbrpywFNo6w1HDV7uK4rOV6D8SBVoNO0z2Ka8wZ5iOJ8PUZqpsb1NYoXckrMrub7m/
         /TRC6Ix/tIK5lCw70Jfao0p7hyLZ7qnt9Fw33JNk=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A03160541;
        Wed, 29 Aug 2018 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569971;
        bh=HabIm/RYZ7cq30Zkse7Kc2g0RbONoVgS0AzMmdw/54Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPgcrjNH6VeLNTWqZblyuPnaLASFiCyZfOXVasu2MDKCc5ybXTRPOlmXjWfI6B86S
         4PbXEOf+7+6FpDbBMXChFP//5fgJ5zNALhowv0HmUgeqM736zHPF5xctqpFi0sUOvN
         sdYraXHXbe86RwtHvaNu4grB9vwEDlbdCOEqksYU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A03160541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        mka@chromium.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 3/6] dt-bindings: remoteproc: qcom: Remove additional definition tag
Date:   Thu, 30 Aug 2018 00:42:12 +0530
Message-Id: <20180829191215.10071-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180829191215.10071-1-sibis@codeaurora.org>
References: <20180829191215.10071-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the additional definition tag declared for WCSS sub-system
under reset-names.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 601dd9f389aa..3a66cde5895a 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -58,8 +58,8 @@ on the Qualcomm Hexagon core.
 	Usage: required
 	Value type: <stringlist>
 	Definition: must be "mss_restart" for the modem sub-system
-	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
-		    for the wcss syb-system
+		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
+		    for the wcss sub-system
 
 - cx-supply:
 - mss-supply:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

