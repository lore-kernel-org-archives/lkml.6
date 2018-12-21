Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762A1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436E9218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SYptSWyG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VLQ6a+m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbeLUMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:00:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39786 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbeLUMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:00:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EEF7E608FF; Fri, 21 Dec 2018 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393651;
        bh=CkDdgRmS1HHJL7SV/HFC2wSaUMuRXE6vNsAOzcLl9p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYptSWyGkit+nMVV73RYyI/DUm9aYVSjtwSuNxxEuLeb1PNSC8sCvTbyL0bjyqrum
         4BKoHg7je7vPGP5OXEWV5FBwlQyvvja5vvMUTmKiwwtvCBgLxsbqtQq5fVSlgHedUW
         ih6Tj8+eXxndb235/2iUnAgTnuVUIH4pikKKffH0=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EA0E60928;
        Fri, 21 Dec 2018 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393648;
        bh=CkDdgRmS1HHJL7SV/HFC2wSaUMuRXE6vNsAOzcLl9p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLQ6a+m0KCTtIZKhnysfZIXFbx45uIZqlbfqtjznx+YdPDc1mklkWNEb0PJWUS7qG
         8M+J03CquX/aPABwnHHR4kRDvpZKI89A7Jz1jASiG8Mx/IasAUYZhLLEMKsLQAJUU/
         jpdPtN8E++WmU8LJdpJwu6TEO9Y6RN4a3OGHswu4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EA0E60928
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 5/5] arm64: dts: msm: add PDC timer for apps_rsc for SDM845
Date:   Fri, 21 Dec 2018 17:29:46 +0530
Message-Id: <20181221115946.10095-6-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221115946.10095-1-rplsssn@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC timer node for apps_rsc to program next wake-up
timer value.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b256357e4db1..c73b717ed8ea 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1372,6 +1372,9 @@
 			      <0x179d0000 0x10000>,
 			      <0x179e0000 0x10000>;
 			reg-names = "drv-0", "drv-1", "drv-2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -1382,6 +1385,12 @@
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
 
+			pdc_timer@38 {
+				compatible = "qcom,pdc-timer";
+				reg = <0x38 0x1>,
+				      <0x40 0x1>;
+			};
+
 			rpmhcc: clock-controller {
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

