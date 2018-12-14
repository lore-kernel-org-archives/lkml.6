Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F099C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1457D20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M0JZI8UO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gT0HVELc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1457D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeLNMaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:30:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731804AbeLNMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:30:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2D23160735; Fri, 14 Dec 2018 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790600;
        bh=oAt2l3/uMsplEFDI9IfdXN1XzC2mYZ+lMBjEqfNfhMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0JZI8UOi/hO2jltEZlKFuOZqVcCCpI9fwe1Mql1Ohfm1rzwLOHev/zZB5A7MsVEo
         Wwjg1S/c0tSnM7yyXdTsDDxy0WMbNBNOwxjgoi/oZOTYxoREKxR7LMnvnEgJ1Jrz7M
         T8dB+7jAlgDPsNKBGizPixcc8qNHD2ufEM3VnoWY=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B33DC606DD;
        Fri, 14 Dec 2018 12:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790599;
        bh=oAt2l3/uMsplEFDI9IfdXN1XzC2mYZ+lMBjEqfNfhMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gT0HVELcoi/ovV28h7AGtPZXRXIvcXy3cnsyHOA+9culRFp4oyvEVvNnIh0GApIjj
         5Sg69PsX5Er1PPlI9xBo1c22chLbkMt69pEsZDMZcg86cdEX02v+5PkjgDef/HV0SL
         753KWTp+kRiVDCqqycSq8N9X2NhzQDKRiqGewRIg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B33DC606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org,
        asishb@codeaurora.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 1/4] ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding
Date:   Fri, 14 Dec 2018 17:59:26 +0530
Message-Id: <1544790569-10608-2-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
References: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings required for DISPLAY_PORT_RX
port on AFE.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 include/dt-bindings/sound/qcom,q6afe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index e2d3892..1df06f8 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -106,6 +106,7 @@
 #define QUINARY_TDM_TX_6	101
 #define QUINARY_TDM_RX_7	102
 #define QUINARY_TDM_TX_7	103
+#define DISPLAY_PORT_RX		104
 
 #endif /* __DT_BINDINGS_Q6_AFE_H__ */
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

