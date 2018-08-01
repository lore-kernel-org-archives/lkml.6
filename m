Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27780C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C1320851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cwaetWt7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eradndau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C1320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbeHADni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:43:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbeHADnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:43:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 406F5606CF; Wed,  1 Aug 2018 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533088830;
        bh=or7ksvsb2wE7shwieD0C04C0NlHMbvXN++IbdkraPsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwaetWt7x01dl8i9y/16aN3cXVcYE7FO/Y/cfvBTIdHjMLkPn4du0xdhz+X72gIeb
         T2JUT6jgUK8Vv/0880BHUPvJlsGv+Qi/Sil2ek6DcHz7qITYlmKeh6oDo86uN8bI4e
         i60CcKNqTWKSpYoVvoYV2AtvuxPcA3f8cFaqDaFc=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DEB660AD8;
        Wed,  1 Aug 2018 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533088829;
        bh=or7ksvsb2wE7shwieD0C04C0NlHMbvXN++IbdkraPsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EradndauZk9UTW7L1SllEUJNGoRerNLZcUEQj1BpRL8abj+ew/kyF9MLTuMyMC6oJ
         eT8l03xNVVbLmz6sZVqHsSU2mvwgRyFVSiTB36k3k3fBDVfKsgwwelv8p6pwc40Mmc
         dkE/nSz5eqL9pLskat2FGbvJhKMNpRxztaW3Phk0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DEB660AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, swboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RESEND RFC 3/4] arm64: dts: msm: add PDC device bindings for sdm845
Date:   Tue, 31 Jul 2018 20:00:20 -0600
Message-Id: <20180801020021.9782-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801020021.9782-1-ilina@codeaurora.org>
References: <20180801020021.9782-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2acc17ce1a9c..8ccce42885c1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1213,6 +1213,15 @@
 			};
 		};

+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc";
+			reg = <0xb220000 0x30000>;
+			qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		timer@17c90000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

