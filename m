Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE52C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D55620869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pKkDc2BC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pKkDc2BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbeL1Sxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:53:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbeL1Sxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:53:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA6C460928; Fri, 28 Dec 2018 18:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023212;
        bh=trK+FuE3Vv1F+Jmo4DamEkK3zfr/Io5WNEeixDkEk6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKkDc2BCIWi7JIo/3BBlU2XatpDaw4T24FB3Bx5mgwNnSneaD+nwrU5GIX0TvzXVi
         zXXsKTaLUKdRampob3MZfCHarD4UlgM/8ZrY3PnEXnnZ8HQ609sW1hrD7JEOsZbxQp
         oWEu5enaaIsHsL6jOYdodIIGdocuuM9lqISBSqAM=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2D6F60854;
        Fri, 28 Dec 2018 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023212;
        bh=trK+FuE3Vv1F+Jmo4DamEkK3zfr/Io5WNEeixDkEk6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKkDc2BCIWi7JIo/3BBlU2XatpDaw4T24FB3Bx5mgwNnSneaD+nwrU5GIX0TvzXVi
         zXXsKTaLUKdRampob3MZfCHarD4UlgM/8ZrY3PnEXnnZ8HQ609sW1hrD7JEOsZbxQp
         oWEu5enaaIsHsL6jOYdodIIGdocuuM9lqISBSqAM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2D6F60854
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        sricharan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 3/8] dt-bindings: remoteproc: qcom: Add missing clocks for MSM8996
Date:   Sat, 29 Dec 2018 00:23:02 +0530
Message-Id: <20181228185307.25645-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228185307.25645-1-sibis@codeaurora.org>
References: <20181228185307.25645-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clock bindings for Q6V5 MSS on MSM8996 SoCs.

Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
on msm8996")

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v4:
  * Re-order clocks for consistency as suggested by Rob

v3:
  * Fixup dt-binding documentation as suggested by Doug

 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index d645c8db29fd..bba3d6be71c0 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -51,6 +51,9 @@ on the Qualcomm Hexagon core.
 	qcom,msm8916-mss-pil:
 	qcom,msm8974-mss-pil:
 		    must be "iface", "bus", "mem", "xo"
+	qcom,msm8996-mss-pil:
+		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
+		    "snoc_axi", "mnoc_axi", "pnoc", "qdss"
 	qcom,sdm845-mss-pil:
 		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
 		    "snoc_axi", "mnoc_axi", "prng"
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

