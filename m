Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E3C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2262620892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eYQmn9Ne";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jTo4/7qD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2262620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeLNMaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:30:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60312 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbeLNMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:30:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 386C860312; Fri, 14 Dec 2018 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790612;
        bh=pDSXThTYeBiJ7VTAL+iPApn7cSKfLXEx4Rqigw28+rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYQmn9Neo+pdRRUSErFglTes3Syn4edg6iGCHo8xmHv43SfZOG7w8kahxSHqG8iAp
         JKN1PKxNcvjLHG2su1DxzDPfSiitoza+0nPnQvQqG7IJVBWbpg7Hl/U0eWm09r6E1e
         6yFM/2Bxq6QPY8V2sb+sWfxQp9lq8ERGAQSktU2I=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64EA860312;
        Fri, 14 Dec 2018 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790610;
        bh=pDSXThTYeBiJ7VTAL+iPApn7cSKfLXEx4Rqigw28+rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTo4/7qDZtH9alG1Jxy8ZvZbRopHX+y+fiPVBRKNtOFzYaGPmDzLHn0Y+YOrw32x5
         sA1KdB+rc7R2qdlg+0x5w+EqEF3O03G23duvT7pEWlZ7ESb3Uk0Il5Osi4mnzIU8/j
         9AuMwGypT1ePr0YFafyqTMV1AVTMZ2YXuIitLy2M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64EA860312
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
Subject: [PATCH 2/4] ASoC: qdsp6: qdafe: add support for display_port_rx
Date:   Fri, 14 Dec 2018 17:59:27 +0530
Message-Id: <1544790569-10608-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
References: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for Display_Port_Rx
port in AFE.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 829b5e987..e0945f7a 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -71,6 +71,7 @@
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
+#define AFE_PORT_ID_HDMI_OVER_DP_RX	0x6020
 
 #define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
 /* Clock set API version */
@@ -704,6 +705,8 @@ struct afe_port_map {
 				QUINARY_TDM_RX_7, 1, 1},
 	[QUINARY_TDM_TX_7] =  { AFE_PORT_ID_QUINARY_TDM_TX_7,
 				QUINARY_TDM_TX_7, 0, 1},
+	[DISPLAY_PORT_RX] = { AFE_PORT_ID_HDMI_OVER_DP_RX,
+				DISPLAY_PORT_RX, 1, 1},
 };
 
 static void q6afe_port_free(struct kref *ref)
@@ -1384,6 +1387,7 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 
 	switch (port_id) {
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
+	case AFE_PORT_ID_HDMI_OVER_DP_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX:
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

