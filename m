Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9EDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5520880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ge0pXFSN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FnrWP3LZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B5520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbeISLr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:47:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59838 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeISLr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:47:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96672606FA; Wed, 19 Sep 2018 06:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537337496;
        bh=FyHZxYXaFk4XNWd0997vZApS7+m5PI2lUdsGV+PVkP4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ge0pXFSNqf6I1skfwXE/RkERT2x4dji7UVJuo7vuFGs3Bjgdckxwe41Ei03SDC1DE
         OWQa5fZh6NwYJnOdl45w7xaWhhpegYCvWykda/NAexYl4riqS7OOrNh8zKIaKYZ0WV
         mLIQhTTvJDs4IY1atiP0z/BeV4YTrAogDKzpm7+A=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E42B76031A;
        Wed, 19 Sep 2018 06:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537337495;
        bh=FyHZxYXaFk4XNWd0997vZApS7+m5PI2lUdsGV+PVkP4=;
        h=From:To:Cc:Subject:Date:From;
        b=FnrWP3LZ5u3aTK2W87GbxRtJMqe4RzOnUDQX8dMRGDIoN9MlVM8gHXzTUH75a37vM
         7arRKGJtsxkFVVYvhXScPJggvuVySASi7oj6FJFDNCX8gMqOXoWcHQyqZDW/ajwvqc
         DeXzj0D4/6f+VQnJU/8Dy4qO98XDxkwngCEGPMhQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E42B76031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: q6afe: dt-bindings: Update input range for qcom,sd-lines
Date:   Wed, 19 Sep 2018 11:41:21 +0530
Message-Id: <1537337481-2123-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Input to qcom,sd-lines should be between 0 and 3 instead of
1 to 4 as 0 corresponds to BIT(0) which is MI2S_SD0 line.
Bit 1 to 3 corresponds to SD1 to SD3 lines respectively.
Updated documentation for the same.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index a817940..d74888b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -49,7 +49,7 @@ configuration of each dai. Must contain the following properties.
 	Usage: required for mi2s interface
 	Value type: <prop-encoded-array>
 	Definition: Must be list of serial data lines used by this dai.
-	should be one or more of the 1-4 sd lines.
+	should be one or more of the 0-3 sd lines.
 
  - qcom,tdm-sync-mode:
 	Usage: required for tdm interface
@@ -137,42 +137,42 @@ q6afe@4 {
 
 		prim-mi2s-rx@16 {
 			reg = <16>;
-			qcom,sd-lines = <1 3>;
+			qcom,sd-lines = <0 2>;
 		};
 
 		prim-mi2s-tx@17 {
 			reg = <17>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 
 		sec-mi2s-rx@18 {
 			reg = <18>;
-			qcom,sd-lines = <1 4>;
+			qcom,sd-lines = <0 3>;
 		};
 
 		sec-mi2s-tx@19 {
 			reg = <19>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 
 		tert-mi2s-rx@20 {
 			reg = <20>;
-			qcom,sd-lines = <2 4>;
+			qcom,sd-lines = <1 3>;
 		};
 
 		tert-mi2s-tx@21 {
 			reg = <21>;
-			qcom,sd-lines = <1>;
+			qcom,sd-lines = <0>;
 		};
 
 		quat-mi2s-rx@22 {
 			reg = <22>;
-			qcom,sd-lines = <1>;
+			qcom,sd-lines = <0>;
 		};
 
 		quat-mi2s-tx@23 {
 			reg = <23>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 	};
 };
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

