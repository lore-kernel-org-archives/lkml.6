Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B168A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D3520881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="niYop/Xv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l8nU2Tk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D3520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeG3Lpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:45:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42460 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeG3Lpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:45:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63680619B1; Mon, 30 Jul 2018 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945482;
        bh=NyHS+u1ePAKdU4jsels5mJ/54VsOdPIRfaUpqiiLg+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niYop/XvIH8TgneTE5nk0+8GbMernwHL1H1R0b6JNRD6PmsjwX8OYmvoe518dFusX
         JIan6Y0TH9cMPQuWrwSKFU1DEqFKwHe5n6NaTse/aywYEBmXaACAIRMhTOJ38oGsM8
         /jwB63a4hnPDmunb4r5dlUxG/9bom6+svYVRMx8k=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D3B2619B0;
        Mon, 30 Jul 2018 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945481;
        bh=NyHS+u1ePAKdU4jsels5mJ/54VsOdPIRfaUpqiiLg+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8nU2Tk994YogNWW6YMIIxQ9AGV7epF5282N3edSkHfYYVI+J8A0R6l4+S3YXHg5k
         A01xIvPu2aEL928PrEiinzoyFwMBTt1L+iQ9/mkjGVIkKYGHFUpiiGZJB1eX08A1DZ
         olmWCt3Wk1OeRM5NrUmFPlv1GEzXK2DYoayAsW3w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D3B2619B0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v4 2/4] ASoC: dt-bindings: Update dt binding name for apq8096
Date:   Mon, 30 Jul 2018 15:40:52 +0530
Message-Id: <1532945454-10437-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
References: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove qcom prefix from machine driver dt bindings of
apq8096 SoC.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 Documentation/devicetree/bindings/sound/qcom,apq8096.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
index c7600a9..c814e86 100644
--- a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -7,7 +7,7 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
 	Value type: <stringlist>
 	Definition: must be "qcom,apq8096-sndcard"
 
-- qcom,audio-routing:
+- audio-routing:
 	Usage: Optional
 	Value type: <stringlist>
 	Definition:  A list of the connections between audio components.
@@ -49,6 +49,12 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
 			"DMIC1"
 			"DMIC2"
 			"DMIC3"
+
+- model:
+	Usage: required
+	Value type: <stringlist>
+	Definition: The user-visible name of this sound card.
+
 = dailinks
 Each subnode of sndcard represents either a dailink, and subnodes of each
 dailinks would be cpu/codec/platform dais.
@@ -79,11 +85,16 @@ dailinks would be cpu/codec/platform dais.
 	Value type: <phandle with arguments>
 	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
 
+Obsolete:
+	qcom,model: String for soundcard name (Use model instead)
+	qcom,audio-routing: A list of the connections between audio components.
+			    (Use audio-routing instead)
+
 Example:
 
 audio {
 	compatible = "qcom,apq8096-sndcard";
-	qcom,model = "DB820c";
+	model = "DB820c";
 
 	mm1-dai-link {
 		link-name = "MultiMedia1";
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

