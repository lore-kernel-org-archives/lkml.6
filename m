Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09422C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2E820863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ehBVtdup";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ehBVtdup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2E820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeK3Sh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:37:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3Sh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:37:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E91846086B; Fri, 30 Nov 2018 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543562974;
        bh=KNIqpJ5pMM2r2tm4vvTUPqI5e7p8eX95OPROOZhaySg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehBVtdupYncB6g7lu7L2q2EHW+SHpKFN2tue/OdFQDwhd9rNqFUldMJAqCKy3r+cE
         h7BYXEpIeFdlz3MLBk2UpPzG3ZnEJF+jcd1T/q+cdiloHyixjI5+z++v3UfF+ocTpX
         CsyyfbA6F09BHey7cuU0qpmnucGLZkIAhP/oK66Q=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 073ED60B62;
        Fri, 30 Nov 2018 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543562974;
        bh=KNIqpJ5pMM2r2tm4vvTUPqI5e7p8eX95OPROOZhaySg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehBVtdupYncB6g7lu7L2q2EHW+SHpKFN2tue/OdFQDwhd9rNqFUldMJAqCKy3r+cE
         h7BYXEpIeFdlz3MLBk2UpPzG3ZnEJF+jcd1T/q+cdiloHyixjI5+z++v3UfF+ocTpX
         CsyyfbA6F09BHey7cuU0qpmnucGLZkIAhP/oK66Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 073ED60B62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 1/2] dt-binding: remoteproc: Remove lpass_aon clock from adsp pil clock list
Date:   Fri, 30 Nov 2018 12:59:09 +0530
Message-Id: <1543562950-23997-2-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
References: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPASS_Audio_Wrapper_AON clock is on by default. Remove
it from lpass clock list to avoid voting for it.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
index a842a78..66af2c3 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
@@ -35,7 +35,7 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
 	Value type: <stringlist>
 	Definition: List of clock input name strings sorted in the same
 		    order as the clocks property. Definition must have
-		    "xo", "sway_cbcr", "lpass_aon", "lpass_ahbs_aon_cbcr",
+		    "xo", "sway_cbcr", "lpass_ahbs_aon_cbcr",
 		    "lpass_ahbm_aon_cbcr", "qdsp6ss_xo", "qdsp6ss_sleep"
 		    and "qdsp6ss_core".
 
@@ -100,13 +100,12 @@ ADSP, as it is found on SDM845 boards.
 
 		clocks = <&rpmhcc RPMH_CXO_CLK>,
 			<&gcc GCC_LPASS_SWAY_CLK>,
-			<&lpasscc LPASS_AUDIO_WRAPPER_AON_CLK>,
 			<&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
 			<&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
 			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
 			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
 			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
-		clock-names = "xo", "sway_cbcr", "lpass_aon",
+		clock-names = "xo", "sway_cbcr",
 			"lpass_ahbs_aon_cbcr",
 			"lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
 			"qdsp6ss_sleep", "qdsp6ss_core";
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

