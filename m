Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2989EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E3820865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HV1a59iO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JfkhIswR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E3820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393402AbeKVTp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:45:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVTp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:45:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50F2760C4B; Thu, 22 Nov 2018 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542877641;
        bh=j8YHZdY0q7Y+gH+2J15/fIphu1d7kXx4aeDMlvlxq9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HV1a59iOS1dZzzFArfVS5lgj4hOckoFIHZvCRr3fKgEVX3qqLPhT7s041nubTBUxn
         1ED6PjrTOsuxCGts6PVMb0n79v27PGjHeftDjxwHxVOxcCHqqMz6+QIh3SngU19fIH
         eHgAuE1Swd/O8ns/DnhSKAkoXPSMi4oBnIXHe6ts=
Received: from skolluku-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skolluku@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3712F60C4C;
        Thu, 22 Nov 2018 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542877639;
        bh=j8YHZdY0q7Y+gH+2J15/fIphu1d7kXx4aeDMlvlxq9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfkhIswRK/qERRhK7PTqkOe/zoX/UMMlP0XfVUyUzMWgrVN9gYM3PgLoaFhDhrx4b
         tyM6K+HNWqJCssx9e41thyaki9NCcTWGDJ28FQoaK9wtkCHmG1bz6SSXHV8ox8AtMu
         IypkDQewmDzuaImoCagqNtIuVn4SQmEtr9OlXAKY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3712F60C4C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skolluku@codeaurora.org
From:   Sravanthi Kollukuduru <skolluku@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, sean@poorly.run
Subject: [PATCH v3 3/3] dt-bindings: msm/disp: Introduce interconnect bindings for MDSS on SDM845
Date:   Thu, 22 Nov 2018 14:36:53 +0530
Message-Id: <20181122090653.3523-4-skolluku@codeaurora.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181122090653.3523-1-skolluku@codeaurora.org>
References: <20181122090653.3523-1-skolluku@codeaurora.org>
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

Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
---
 Documentation/devicetree/bindings/display/msm/dpu.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu.txt b/Documentation/devicetree/bindings/display/msm/dpu.txt
index ad2e8830324e..d75b4360a4be 100644
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
@@ -86,6 +91,10 @@ Example:
 		interrupt-controller;
 		#interrupt-cells = <1>;
 
+		interconnects = <&qnoc 38 &qnoc 512>,
+				<&qnoc 39 &qnoc 512>;
+		interconnect-names = "port0", "port1";
+
 		iommus = <&apps_iommu 0>;
 
 		#address-cells = <2>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

