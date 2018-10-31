Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DDDECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7201120880
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hvJlC36f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hXmKWuPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7201120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeJaPGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:06:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeJaPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:06:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40BDE6072E; Wed, 31 Oct 2018 06:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540966178;
        bh=ax5CFkg0q2RWn69xmo0SojWiYSUi5r57YeY8Z2UJgrs=;
        h=From:To:Cc:Subject:Date:From;
        b=hvJlC36fNcgO8JhiMFfZD4sEZ3xEZeFOSKAGGE8wHATlpmnR9gji3Th9qppO67zmi
         7V4CNwbgqoGffcxEE95bHbMCxJVbKS/FiLoJnDNNqRjwMko6mOYUXL1I5l/WFqr8zn
         Qx5s2tMpx8uA/+FkuLmulfj3LDfSYRTKeapmD1j4=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40334601B4;
        Wed, 31 Oct 2018 06:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540966177;
        bh=ax5CFkg0q2RWn69xmo0SojWiYSUi5r57YeY8Z2UJgrs=;
        h=From:To:Cc:Subject:Date:From;
        b=hXmKWuPAKbFt/5gszv4is1ySZ2S2D6YbD9SmaYIl2gB7hhgALG4M1u9v1KnQBeSjX
         6OYkZOEjDYN1rpmNMA5LBTb7kPFjyMvymEZZwGL20tQSfoaDSrMkpGLlp7H/pyrpxl
         I6hpqNBFnqDMf/0g59ZUVMFhNsby6IcFi3tC5t7k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40334601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, dianders@chromium.org,
        evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2] arm64: dts: qcom: sdm845: Add reserve-memory nodes
Date:   Wed, 31 Oct 2018 11:39:21 +0530
Message-Id: <20181031060921.5890-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reserve-memory nodes for mpss and mba required for
remoteproc mss pil.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d3fe012ad84e..636c739b2981 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -88,6 +88,16 @@
 			reg = <0 0x86200000 0 0x2d00000>;
 			no-map;
 		};
+
+		mpss_region: memory@8e000000 {
+			reg = <0 0x8e000000 0 0x7800000>;
+			no-map;
+		};
+
+		mba_region: memory@96500000 {
+			reg = <0 0x96500000 0 0x200000>;
+			no-map;
+		};
 	};
 
 	cpus {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

