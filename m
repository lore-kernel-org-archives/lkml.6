Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49935C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CE1207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XbWsPkcd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Io+hEYN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CE1207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJWM6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:58:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeJWM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:58:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C307A61325; Tue, 23 Oct 2018 04:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269385;
        bh=rTEGC+iSrndGS2iVfqP5OSHCCYmWoO57iyS8vbGdkIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbWsPkcdDSgQQFXLWbOGR7ub8Jj08d+1hkLOUZ+Vhpqbj3K2p1OXwGio43izkWfk4
         /8uI8UJRloVmOga58me69OuyjGvNGJ/rEp3I74g7E8uXN3iLxmWGPVjfuHgAX1CHop
         EaT1HWu72fQRhTtthMyMUK684tJW5sCrbi3p1n7c=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CE4B61325;
        Tue, 23 Oct 2018 04:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269384;
        bh=rTEGC+iSrndGS2iVfqP5OSHCCYmWoO57iyS8vbGdkIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Io+hEYN14hYyg4Q1GzrIS6prFMzXXhr0LxWNgnzMOyT1aCktEMjDyT+8jyuHqOiHM
         yHHGUCvIIVDYsrFeR3+6i8aoMyYlYLJm1d+HpF0P3uVJXiEfIo3fLhWzXLyQPKGGBW
         eSOm7VTsBZRy7a8ghoJxDGmU5IJ/AB0qMS1YUwx0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CE4B61325
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v10 6/6] dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845
Date:   Mon, 22 Oct 2018 21:36:01 -0700
Message-Id: <1540269361-28185-7-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
References: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
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

