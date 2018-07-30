Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01304FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA56620881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M46J4KiH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k4rLTCXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA56620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeG3Lpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:45:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeG3Lpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:45:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 655E2619B1; Mon, 30 Jul 2018 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945476;
        bh=jDu6Bef2hBkODnZBNuxhJOy4ebKSZ3O96nPopUZQizs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M46J4KiHO0OBaUGDEqKVjcs2/NeSMlx98bV/k4hjBoPHwNZ/lsF6+ggMbF/Qg+MmB
         3IRzJVaALBDcBE+cuyoT72XhoEMmE2ZpyS16FgFB6L0vGy35bKsf1Gu0i1n0NaNS9D
         3issVmPdY5IPTG9G0b9YfeDLAb/H5eIVVYXcpwIs=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47DA961996;
        Mon, 30 Jul 2018 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945475;
        bh=jDu6Bef2hBkODnZBNuxhJOy4ebKSZ3O96nPopUZQizs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4rLTCXS1r7HDPrmaQxDeoTXdRNm+yj0GQ3Edbx9wwfuAKWnGrId/z5wrxgoWJ55d
         S+DRO0iXoPKqhrSaC0nFyea54TvVXAfW1sSfy+vGJhCoYpIeTw5LLxwkOOy7yKD2N+
         rQZ/3mc1QHdKvUvDuj8r5H6YZI8lkaCzZE1czxps=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47DA961996
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v4 1/4] ASoC: qcom: dt-bindings: Add sdm845 machine bindings
Date:   Mon, 30 Jul 2018 15:40:51 +0530
Message-Id: <1532945454-10437-2-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
References: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation file for SDM845 sound card.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,sdm845.txt      | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
new file mode 100644
index 0000000..408c483
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
@@ -0,0 +1,80 @@
+* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
+
+This binding describes the SDM845 sound card, which uses qdsp for audio.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,sdm845-sndcard"
+
+- audio-routing:
+	Usage: Optional
+	Value type: <stringlist>
+	Definition:  A list of the connections between audio components.
+		  Each entry is a pair of strings, the first being the
+		  connection's sink, the second being the connection's
+		  source. Valid names could be power supplies, MicBias
+		  of codec and the jacks on the board.
+
+- model:
+	Usage: required
+	Value type: <stringlist>
+	Definition: The user-visible name of this sound card.
+
+= dailinks
+Each subnode of sndcard represents either a dailink, and subnodes of each
+dailinks would be cpu/codec/platform dais.
+
+- link-name:
+	Usage: required
+	Value type: <string>
+	Definition: User friendly name for dai link
+
+= CPU, PLATFORM, CODEC dais subnodes
+- cpu:
+	Usage: required
+	Value type: <subnode>
+	Definition: cpu dai sub-node
+
+- codec:
+	Usage: required
+	Value type: <subnode>
+	Definition: codec dai sub-node
+
+- platform:
+	Usage: Optional
+	Value type: <subnode>
+	Definition: platform dai sub-node
+
+- sound-dai:
+	Usage: required
+	Value type: <phandle>
+	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
+
+Example:
+
+audio {
+	compatible = "qcom,sdm845-sndcard";
+	model = "sdm845-snd-card";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
+	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	pri-mi2s-dai-link {
+		link-name = "PRI MI2S Playback";
+		cpu {
+			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+	};
+};
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

