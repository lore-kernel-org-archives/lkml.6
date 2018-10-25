Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D1DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286FE20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iuGzgzz1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d6Jjn/CM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286FE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJZB5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:57:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeJZB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:57:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A53E3606DC; Thu, 25 Oct 2018 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540488212;
        bh=qhomB+1N/qzkk6MLiI8mt3FoRJenSzS6lPRKzBhnAfw=;
        h=From:To:Cc:Subject:Date:From;
        b=iuGzgzz1fzVdD8zXji+5mm8pLpDnrGZCRwVONWd8ghNz3/Vde6CNkmWpm5F+UAhiV
         knw0ezFB7egt8djRJmeC1mzE4KlE4c147dvd6CrUc8pbsAae577XfLl6z7YY6rzeuI
         qS/EssA/boIDzBH2BxpqDo92I5qik0pm3GERweAA=
Received: from mgautam-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8A2A606DC;
        Thu, 25 Oct 2018 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540488211;
        bh=qhomB+1N/qzkk6MLiI8mt3FoRJenSzS6lPRKzBhnAfw=;
        h=From:To:Cc:Subject:Date:From;
        b=d6Jjn/CMhf3Xh0E1jXXQ82uO4nKfj+Yyy3FaU8Q0fwQFjL+3xxqRpcCImz8SDK6Ib
         w99TZYErHhpe2nF6jafgUV5GMaDtGmOncEXWkiLW6qD9D7SVn3egYwRH0ai3b6OAax
         Ch6LHDJmzSIwXC0DCvu2j2v8fKVodkTmzXuP4rQU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8A2A606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From:   Manu Gautam <mgautam@codeaurora.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] arm64: dts: qcom: sdm845: Fix pcs_misc region address for UNI PHY
Date:   Thu, 25 Oct 2018 22:53:17 +0530
Message-Id: <20181025172318.31353-1-mgautam@codeaurora.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct address for pcs_misc register region of USB3 QMP UNI PHY.
These registers are used during runtime-suspend/resume routines
of phy.

Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..84bee81562a5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1156,7 +1156,7 @@
 				reg = <0x88eb200 0x128>,
 				      <0x88eb400 0x1fc>,
 				      <0x88eb800 0x218>,
-				      <0x88e9600 0x70>;
+				      <0x88eb600 0x70>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

