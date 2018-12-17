Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14960C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D935F20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f4yzHeMV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XWpLFfM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbeLQKI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:08:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbeLQKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:08:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 11749608D2; Mon, 17 Dec 2018 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041305;
        bh=TsVA5WibB5CFfJrB2Rl0xy2bQO623ROMD6HUw5kTpo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4yzHeMV0Mx1WJHQOs2MQLDHn4W3RWHjMjgIMmKGOkdy03AnesweL8HmKiVRsqPMU
         4Uk75J7aNTCYWDI52IJo87svy7JI8LBI4F6+zsfatjpYF8J53DjSMDxYtsgFB+c+tl
         T4tv5+rd1zF+EbMA5anJ88RCY+6zByvw9MK7Wd2I=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 586586092B;
        Mon, 17 Dec 2018 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041299;
        bh=TsVA5WibB5CFfJrB2Rl0xy2bQO623ROMD6HUw5kTpo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWpLFfM4/KFEiMCNy6UK4QVWJOB8JyUuKCxMkCCQfdX3QDxn5KooBHyMCHgAFYN9E
         Wn3M63ralA/0Xyl6ytXHT6y8jWnw8Fh3oai+usmTldtTe9Xv0wPrr5W3kl3riAZbcl
         4EMq//fJ09aif9MmFlLc9/ZPYXON03gkCGCfX6eM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 586586092B
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
Subject: [PATCH v2 6/7] arm64: dts: qcom: sdm845: Add power-domain for Q6V5 MSS node
Date:   Mon, 17 Dec 2018 15:37:23 +0530
Message-Id: <20181217100724.4593-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217100724.4593-1-sibis@codeaurora.org>
References: <20181217100724.4593-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power-domains cx, mx, mss and load_state for Q6V5 MSS node.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

This patch depends on the following bindings:
https://patchwork.kernel.org/patch/10725801/ - rpmhpd dt bindings
https://patchwork.kernel.org/patch/10725793/ - rpmhpd dt node
https://patchwork.kernel.org/patch/10678301/ - AOP QMP dt bindings

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 33ff8668828f..56f5f55db9e2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1401,6 +1401,12 @@
 			qcom,halt-regs = <&tcsr_mutex_regs
 						0x23000 0x25000 0x24000>;
 
+			power-domains = <&aoss_qmp_pd AOSS_QMP_LS_MODEM>,
+					<&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_MX>,
+					<&rpmhpd SDM845_MSS>;
+			power-domain-names = "load_state", "cx", "mx", "mss";
+
 			mba {
 				memory-region = <&mba_region>;
 			};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

