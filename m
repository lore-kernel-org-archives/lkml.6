Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5CCC32788
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5531821479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ac8yI8+5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BvG9Mh6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5531821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKUKjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:39:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeKUKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:39:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E8E660C5F; Wed, 21 Nov 2018 00:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542758844;
        bh=IRxTA9sQsYkgX7BsHzxqdGvBVyLH+bq2ClrtpjtF+tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ac8yI8+5lHTXSMhs1KdDVamV8sa8Q7her/WZQerSXjMuupKPaRTzQYHnIwrXCMk3j
         hZjYrQxY9/TiHoLdSZyYDtS2TEktccja5mdcntQuYANGhQ5yjyec0g5TF2P2UE4bAe
         8OEzK/5IR1qcGQa1+IS3Xfvnc6oxxEDmmlPP2LUo=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04AA360BE8;
        Wed, 21 Nov 2018 00:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542758843;
        bh=IRxTA9sQsYkgX7BsHzxqdGvBVyLH+bq2ClrtpjtF+tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvG9Mh6Xsj3oRJKQMgDVzDA2kQiWBwD4K8beHYv+qMR0/tIHafVhPbSp+Yo2YuRno
         Fsb0CrQJs+OVBYQgaq7UVc0SNti8Vnty8EcCqHHDfwlDzlxImvNuOhfthgoAZ9a98w
         /DMgVqR6mf7ZmGSW8/etFfsFJn2xjDDtvgCrEIPY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04AA360BE8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, Lina Iyer <ilina@codeaurora.org>
Subject: [RFC v3 3/3] arm64: dts: msm: add PDC wake irq maps for GPIOs for SDM845
Date:   Tue, 20 Nov 2018 17:06:48 -0700
Message-Id: <20181121000648.29262-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121000648.29262-1-ilina@codeaurora.org>
References: <20181121000648.29262-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC wakeup irq for GPIOs and the wakeup parent for TLMM.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8e15392a6f64..79835310933b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -821,6 +821,24 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			wake-parent = <&pdc>;
+			wake-irq =
+				<1 30>, <3 31>, <5 32>, <10 33>, <11 34>,
+				<20 35>, <22 36>, <24 37>, <26 38>, <30 39>,
+				<31 117>, <32 41>, <34 42>, <36 43>, <37 44>,
+				<38 45>, <39 46>, <40 47>, <41 115>, <43 49>,
+				<44 50>, <46 51>, <48 52>, <49 118>, <52 54>,
+				<53 55>, <54 56>, <56 57>, <57 58>, <58 59>,
+				<59 60>, <60 61>, <61 62>, <62 63>, <63 64>,
+				<64 65>, <66 66>, <68 67>, <71 68>, <73 69>,
+				<77 70>, <78 71>, <79 72>, <80 73>, <84 74>,
+				<85 75>, <86 76>, <88 77>, <89 116>, <91 79>,
+				<92 80>, <95 81>, <96 82>, <97 83>, <101 84>,
+				<103 85>, <104 86>, <115 90>, <116 91>,
+				<117 92>, <118 93>, <119 94>, <120 95>,
+				<121 96>, <122 97>, <123 98>, <124 99>,
+				<125 100>, <127 102>, <128 103>, <129 104>,
+				<130 105>, <132 106>, <133 107>, <145 108>;
 
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

