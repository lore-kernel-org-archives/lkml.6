Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AF8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2958920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VXtg/xPy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yvh08xPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbeLQKIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:08:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbeLQKIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:08:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C9B8D602FA; Mon, 17 Dec 2018 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041310;
        bh=KE7PYNefk9N6+yjB6233SbInKxGLIlikXtbtg1jYK3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXtg/xPybcTF0uS+OhyMbBqQ0ix5TUAH1P7TtYdK5G/uhlcw6q/NRp2dEg3J2euol
         XGgfwuiYchXPv3NJcdqwPrIvmNH6XCiw+3LhPQ5cFovAipw8cwRBLAaumTuAsSWWvj
         TLAAU/CstIWV1AGvgwW4iAayQEkbf+IcUomvtIF4=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F5D3608C5;
        Mon, 17 Dec 2018 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041306;
        bh=KE7PYNefk9N6+yjB6233SbInKxGLIlikXtbtg1jYK3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yvh08xPzCUBo2Vgx9TpMMrXXT6tCcuDOsGDiH74n8XZvpTuCugPs6ZQuJrJa1z5c9
         vlUF1OGSWiaXe05B+iGCyJPMv21jPmPDtxYzTR1E3bGzahfVQZHtMAAb4QVsoT47Xi
         F+BlACu4T3mF4OaHlegx9TysSTvTk4DjRYaiMJO4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F5D3608C5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 7/7] arm64: dts: qcom: sdm845: Add shutdown-ack for Q6V5 MSS node
Date:   Mon, 17 Dec 2018 15:37:24 +0530
Message-Id: <20181217100724.4593-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217100724.4593-1-sibis@codeaurora.org>
References: <20181217100724.4593-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown-ack smp2p interrupt for Q6V5 MSS node.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

This patch depends on:
https://patchwork.kernel.org/patch/10691213/ - shutdown-ack dt bindings

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 56f5f55db9e2..db17216a5bce 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1376,9 +1376,11 @@
 				<&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
 				<&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
 				<&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-				<&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+				<&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready",
-					  "handover", "stop-ack";
+					  "handover", "stop-ack",
+					  "shutdown-ack";
 
 			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
 				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

