Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2627FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE972147D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NLy27Cy9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NLy27Cy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE972147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbeKUHjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:39:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeKUHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:39:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D91CE60452; Tue, 20 Nov 2018 21:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542748126;
        bh=MMvXjBbCV2Jmhxa2z0GtbT/gJ3mLzVEzYeUQSCqranA=;
        h=From:To:Cc:Subject:Date:From;
        b=NLy27Cy9uRuF3SwYxg0fs2qWFH5rjSO2IdHiftlyfv+ff+kG6GgqXzj9n/WzsZBCg
         8b8byS3MrmEbKfDV68QEObM6PLrx2hI3OAV6LBxvbuMnvzE2BSvK0BbaILRB6IqfUj
         nz2mBCFhBsgnQPNqz61yEtaAE4apeSfUcNFpmOYA=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB08D60452;
        Tue, 20 Nov 2018 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542748126;
        bh=MMvXjBbCV2Jmhxa2z0GtbT/gJ3mLzVEzYeUQSCqranA=;
        h=From:To:Cc:Subject:Date:From;
        b=NLy27Cy9uRuF3SwYxg0fs2qWFH5rjSO2IdHiftlyfv+ff+kG6GgqXzj9n/WzsZBCg
         8b8byS3MrmEbKfDV68QEObM6PLrx2hI3OAV6LBxvbuMnvzE2BSvK0BbaILRB6IqfUj
         nz2mBCFhBsgnQPNqz61yEtaAE4apeSfUcNFpmOYA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB08D60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] dt-bindings: remoteproc: qcom: Add power-domain bindings for Q6V5
Date:   Wed, 21 Nov 2018 02:38:28 +0530
Message-Id: <20181120210828.12590-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power-domain bindings for Q6V5 MSS on SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

Add dt-binding corresponding to https://patchwork.kernel.org/patch/10586893/
(remoteproc: q6v5: Add support to vote for rpmh power domains)

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 14947562bc67..bd9f4882fcf0 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -75,6 +75,17 @@ on the Qualcomm Hexagon core.
 	Definition: reference to the regulators to be held on behalf of the
 		    booting of the Hexagon core
 
+- power-domains:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the cx, mx and mss power-domains to be held on
+		    behalf of the booting the Hexagon core
+
+- power-domain-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "cx", "mx", "mss"
+
 - qcom,smem-states:
 	Usage: required
 	Value type: <phandle>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

