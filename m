Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FBDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7746A208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UJEl19t/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UJEl19t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7746A208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeGaLtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:49:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732045AbeGaLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:49:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7B17F60714; Tue, 31 Jul 2018 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533031784;
        bh=rTEGC+iSrndGS2iVfqP5OSHCCYmWoO57iyS8vbGdkIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJEl19t/2akcCVlU92QQlTb4E5PX+Bz9GeNlOT+bDSIZhU2p81X8SeymfxaBeAtPY
         K9nxwacIAWRxYbsDorQQ2u3zoUCg92EGH2+9HcoEY3l1J0lA1YAGCLyEXR3nqV/BC4
         6VZSbdDweyPnaSrKyzITwWQeI2Wu69A3j3xH279A=
Received: from CANG02.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D882760264;
        Tue, 31 Jul 2018 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533031784;
        bh=rTEGC+iSrndGS2iVfqP5OSHCCYmWoO57iyS8vbGdkIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJEl19t/2akcCVlU92QQlTb4E5PX+Bz9GeNlOT+bDSIZhU2p81X8SeymfxaBeAtPY
         K9nxwacIAWRxYbsDorQQ2u3zoUCg92EGH2+9HcoEY3l1J0lA1YAGCLyEXR3nqV/BC4
         6VZSbdDweyPnaSrKyzITwWQeI2Wu69A3j3xH279A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D882760264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v8 5/5] dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845
Date:   Tue, 31 Jul 2018 18:09:14 +0800
Message-Id: <20180731100914.19856-6-cang@codeaurora.org>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20180731100914.19856-1-cang@codeaurora.org>
References: <20180731100914.19856-1-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the compatible string for UFS QMP PHY on SDM845.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index cef8765..930d94c 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -11,7 +11,8 @@ Required properties:
 	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
 	       "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy,
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
-	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
+	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
+	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
 
  - reg: offset and length of register set for PHY's common serdes block.
 
@@ -29,6 +30,7 @@ Required properties:
 		"aux" for phy aux clock,
 		"ref" for 19.2 MHz ref clk,
 		"com_aux" for phy common block aux clock,
+		"ref_aux" for phy reference aux clock,
 		For "qcom,msm8996-qmp-pcie-phy" must contain:
 			"aux", "cfg_ahb", "ref".
 		For "qcom,msm8996-qmp-usb3-phy" must contain:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

