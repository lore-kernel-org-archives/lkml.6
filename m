Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE5C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586082089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aH6sUiQt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BsJ0YYBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfAUVdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:33:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfAUVdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:33:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C19260850; Mon, 21 Jan 2019 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548106382;
        bh=NTPM9YYB+L6rBy2BerPK3IqGuy6W0EGVEPdmoOQLtsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aH6sUiQt6MW6GtJmj2O3yRw4MVZKeEORc4PrVQDO7Lw4cbHK557M/L1W1GceAsSsk
         Zs84xNMVTpcULfnuNcP9I2MeUv4+QjmD+pkboLUE5clEC3G5b8+BxiXBkC8krVpXfq
         mprie9zXpEXMCmaIZo+cz2f3qxal2exddnXR9GvE=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8653F6030B;
        Mon, 21 Jan 2019 21:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548106381;
        bh=NTPM9YYB+L6rBy2BerPK3IqGuy6W0EGVEPdmoOQLtsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsJ0YYBDBaovJ/nCeFxhFwGdbKLVYK3dRTa3/3zz610lkOr2HkNJejsWyKa6qFY7U
         jiJPIh3bcsw/CrfyoliISdLnexEvIBFvj4kl0SbJ+5Q+5B8M+y0iystij5jxlFWHge
         VXsbo6bbqtDrbad/IkiBQgzC+Q89Pn5S4qq/+gfQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8653F6030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, balbi@kernel.org
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v3 1/3] dt-bindings: usb: Add support for msm8998
Date:   Mon, 21 Jan 2019 14:32:46 -0700
Message-Id: <1548106366-5042-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
References: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8998 USB has a dwc3 controller just like the existing sdm845 support.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
index 95afdcf..cb695aa 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible:		Compatible list, contains
 			"qcom,dwc3"
 			"qcom,msm8996-dwc3" for msm8996 SOC.
+			"qcom,msm8998-dwc3" for msm8998 SOC.
 			"qcom,sdm845-dwc3" for sdm845 SOC.
 - reg:			Offset and length of register set for QSCRATCH wrapper
 - power-domains:	specifies a phandle to PM domain provider node
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

