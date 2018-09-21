Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14171ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45302086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45302086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbeIUKQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:16:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeIUKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:16:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38EBB60F40; Fri, 21 Sep 2018 04:29:29 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E380D60F62;
        Fri, 21 Sep 2018 04:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E380D60F62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=quic_cang@quicinc.com
From:   Can Guo <quic_cang@quicinc.com>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     Can Guo <cang@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 7/7] dt-bindings: ufshcd-pltfrm: Add core reset string
Date:   Thu, 20 Sep 2018 21:28:00 -0700
Message-Id: <1537504081-29976-8-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537504081-29976-1-git-send-email-quic_cang@quicinc.com>
References: <1537504081-29976-1-git-send-email-quic_cang@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

Add core reset support string for UFS.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index c39dfef..6b697c4 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -11,6 +11,11 @@ Required properties:
 					  "qcom,ufshc"
 - interrupts        : <interrupt mapping for UFS host controller IRQ>
 - reg               : <registers mapping>
+- reset             : reset specifier pair consists of phandle for the reset provider
+                      and reset lines used by this controller. It is mandatory for
+		      QCOM SDM845 platform.
+- reset-names       : reset signal name strings sorted in the same order as the
+		      resets property. It is mandatory for QCOM SDM845 platform.
 
 Optional properties:
 - phys                  : phandle to UFS PHY node
@@ -64,6 +69,8 @@ Example:
 		clocks = <&core 0>, <&ref 0>, <&iface 0>;
 		clock-names = "core_clk", "ref_clk", "iface_clk";
 		freq-table-hz = <100000000 200000000>, <0 0>, <0 0>;
+		resets = <clock_gcc GCC_UFS_BCR>;
+		reset-names = "core_reset";
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

