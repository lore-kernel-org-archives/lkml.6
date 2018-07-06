Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC1CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B7E2145B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D+UiIgCu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UdaO2KLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B7E2145B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeGFJo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:44:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753615AbeGFJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:43:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 099D060B26; Fri,  6 Jul 2018 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530870238;
        bh=Jyh4UzjqgYP9PvddNsIFcbEtZCbFp37Yz11YD2RQ/GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+UiIgCu985JKG/pxkvIW1f63xtvtxIYzIyatsGuIVBEONEb8kLwzzfYpnybPopB+
         7vwynAH1VbLqlDrdTcCXvQzThqqb6QTRdxtfqjUsT7aOM4Ho0/NGy1Io6/C9LsEYL0
         fPezHUke2DGCx/Mr4XBpfHLrhDonkjjw3uwcXtNI=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96D7A60B3C;
        Fri,  6 Jul 2018 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530870237;
        bh=Jyh4UzjqgYP9PvddNsIFcbEtZCbFp37Yz11YD2RQ/GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdaO2KLGg1cFStnNBp6vM7h6QKJPGYOUubNdCT7FkFHuI3vgpn8vPp0iODAcFBw2o
         1f1KIaMg2rmZmF2LlUoanu+7lBWZskKAHvtluBbUxqNIn1LJ4kiDdTwsdpJmBcEO3S
         ycJ/ZEVYeaZgutF/+myvwqCAVrsnOY55ws4Jxjjg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96D7A60B3C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 4/5] ASoC: dt-bindings: Update dt binding name for apq8096
Date:   Fri,  6 Jul 2018 15:13:14 +0530
Message-Id: <1530870195-13576-5-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove qcom prefix from machine driver dt bindings of
apq8096 SoC.

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

