Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D8AC6778D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185E023F7C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ymd0/rQO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MH/AJgYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185E023F7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937507AbeF2VIl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:08:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965910AbeF2VIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:08:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C3CA60B22; Fri, 29 Jun 2018 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530306516;
        bh=NrS0yGtdxxhMxw1BfqPciUa6U8w2SuQI6ffGDobxWaU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ymd0/rQOZjcrL1wuNU6L77N3n7I62LNplkKTsvDse45s5rmuuHTan0tJzwV1o2pOf
         7QXHtynTGE3oZrIm9c1rYp1erOhXNeElPNhyBD4ifbZG2P0TWKj2DHfc4juNdynYfD
         WXCdA7a3rKajW3vqfkvALS+o8ByObjHVsxxUgMUk=
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F131460452;
        Fri, 29 Jun 2018 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530306515;
        bh=NrS0yGtdxxhMxw1BfqPciUa6U8w2SuQI6ffGDobxWaU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MH/AJgYjzraXtD1jPjW1NGQAHzlrE/M4VFz70xmzc8hJD4RFqELZEKSKbk1UzPa7f
         xj8ANBHQGYs19ncj9YACZpmbpsjdoiVzuhxfhnyQo0uaXeIBAw881b8zJgC5ZAdNC+
         jWc04AuQY8E5ETZVCjDQs2UH97l3ww82DZOLBdyQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F131460452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        amit.kucheria@linaro.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com
Subject: [RFC PATCH v1 2/2] arm64: dts: sdm845: Add interconnect provider DT nodes
Date:   Fri, 29 Jun 2018 14:08:18 -0700
Message-Id: <1530306498-5181-3-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530306498-5181-1-git-send-email-daidavid1@codeaurora.org>
References: <1530306498-5181-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RSC(Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Change-Id: I58f0bfc3ed484d7b45064dceb94dcfda507e9333
Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 228d502..c2a5309 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1091,6 +1091,11 @@
 
 				pmi8998_bob: bob {};
 			};
+
+			qnoc: qnoc-rsc-hlos{
+				compatible = "qcom,sdm845-rsc-hlos";
+				status = "okay";
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

