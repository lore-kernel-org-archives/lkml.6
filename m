Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC71C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B9720824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UiixlWt0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fZE/EYRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B9720824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJZVEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:04:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeJZVEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:04:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3410E602D7; Fri, 26 Oct 2018 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540556879;
        bh=PIpLKlARrDehF6xeFbtNNTrDwnY9oz4/qXjT7jcQBm4=;
        h=From:To:Cc:Subject:Date:From;
        b=UiixlWt088XlaoHKPBJvMnqMMPAGb9ziST68dbe5Hl1NPu4TYVt5pxNXD8B1OwZq9
         dpkp18Cwl8AcuhZr91y46nLf2ASlfl30Ts/x9dESH4Mok5m2OOXIC2akDtzNZaP6RJ
         QOPNbau7tK/spFi2qG0wmSMDF6GoUMOGMj8FvbVQ=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6821F60F39;
        Fri, 26 Oct 2018 12:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540556878;
        bh=PIpLKlARrDehF6xeFbtNNTrDwnY9oz4/qXjT7jcQBm4=;
        h=From:To:Cc:Subject:Date:From;
        b=fZE/EYRKyQTg1m1zDqVtwsDOYRbddJZU7du66bEt3hWyR8HLhCqJRVu48xyyVP/ek
         auZHaIMVre+A6p1dBHoUgSTzRiOhey/Pz7AL+3WszEQHA3mmkiW3+N7gJaqF59krDW
         bJlmwzlC2nepF4JnKvTTWb80cNZOFxNInrxvu4Z8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6821F60F39
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, dianders@chromium.org,
        evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Add reserve-memory nodes
Date:   Fri, 26 Oct 2018 17:57:45 +0530
Message-Id: <20181026122745.5094-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reserve-memory nodes for mpss and mba required for
remoteproc mss pil.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d3fe012ad84e..f74892e447f9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -88,6 +88,16 @@
 			reg = <0 0x86200000 0 0x2d00000>;
 			no-map;
 		};
+
+		mpss_region: reserved-memory@8e000000 {
+			no-map;
+			reg = <0 0x8e000000 0 0x7800000>;
+		};
+
+		mba_region: reserved-memory@96500000 {
+			no-map;
+			reg = <0 0x96500000 0 0x200000>;
+		};
 	};
 
 	cpus {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

