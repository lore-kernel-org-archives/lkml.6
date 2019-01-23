Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE4C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11FE217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PgHZxNf0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PgHZxNf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfAWDcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:32:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfAWDcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:32:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8EBA6086B; Wed, 23 Jan 2019 03:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548214334;
        bh=iKEWbSzpw/TwebmWiPP19lBDO//2yjjrpEouaDD6Vag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgHZxNf0TMfOKeXLYX232MZslkJcEbw2Tb1SN+5Ac5kKCuPHd1S9ufk7ckAdfp4is
         X7FoQwHzPiNA8QavlMvP7007HgiXLTukwwLkNvtrVQhbsmXYmKMQNbCexWKDL4yloO
         sk1J4cl14ngCLErPdY0crv6NCpYtpOwGVT42fJ4g=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1716E60850;
        Wed, 23 Jan 2019 03:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548214334;
        bh=iKEWbSzpw/TwebmWiPP19lBDO//2yjjrpEouaDD6Vag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgHZxNf0TMfOKeXLYX232MZslkJcEbw2Tb1SN+5Ac5kKCuPHd1S9ufk7ckAdfp4is
         X7FoQwHzPiNA8QavlMvP7007HgiXLTukwwLkNvtrVQhbsmXYmKMQNbCexWKDL4yloO
         sk1J4cl14ngCLErPdY0crv6NCpYtpOwGVT42fJ4g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1716E60850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
Subject: [v6 3/3] dt-bindings: msm/disp: Introduce interconnect bindings for MDSS on SDM845
Date:   Wed, 23 Jan 2019 09:01:37 +0530
Message-Id: <1548214297-17697-4-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548214297-17697-1-git-send-email-jshekhar@codeaurora.org>
References: <1548214297-17697-1-git-send-email-jshekhar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect properties such as interconnect provider specifier
, the edge source and destination ports which are required by the
interconnect API to configure interconnect path for MDSS.

Changes in v2:
	- none

Changes in v3:
	- Remove common property definitions (Rob Herring)

Changes in v4:
	- Use port macros and change port string names (Georgi Djakov)

Changes in v5:
  	- None

Changes in v6:
	-None

Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 Documentation/devicetree/bindings/display/msm/dpu.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu.txt b/Documentation/devicetree/bindings/display/msm/dpu.txt
index ad2e883..a61dd40 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/dpu.txt
@@ -28,6 +28,11 @@ Required properties:
 - #address-cells: number of address cells for the MDSS children. Should be 1.
 - #size-cells: Should be 1.
 - ranges: parent bus address space is the same as the child bus address space.
+- interconnects : interconnect path specifier for MDSS according to
+  Documentation/devicetree/bindings/interconnect/interconnect.txt. Should be
+  2 paths corresponding to 2 AXI ports.
+- interconnect-names : MDSS will have 2 port names to differentiate between the
+  2 interconnect paths defined with interconnect specifier.
 
 Optional properties:
 - assigned-clocks: list of clock specifiers for clocks needing rate assignment
@@ -86,6 +91,11 @@ Example:
 		interrupt-controller;
 		#interrupt-cells = <1>;
 
+		interconnects = <&rsc_hlos MASTER_MDP0 &rsc_hlos SLAVE_EBI1>,
+				<&rsc_hlos MASTER_MDP1 &rsc_hlos SLAVE_EBI1>;
+
+		interconnect-names = "mdp0-mem", "mdp1-mem";
+
 		iommus = <&apps_iommu 0>;
 
 		#address-cells = <2>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

