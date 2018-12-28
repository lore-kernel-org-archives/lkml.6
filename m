Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B332DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F13E20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gb0lntBU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LRP1lSJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbeL1Sx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:53:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbeL1Sx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:53:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7DD3460995; Fri, 28 Dec 2018 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023236;
        bh=Fyh26KhyuUxC3ve0+iV5fsOf+MawcTHfGm8YKfNYBZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gb0lntBU3CpwOYuzGYh4uOUFbqjQxyAaJUExekBcbsNC6M71S7YPLwhSRVMSPxjky
         cZfJF7p+nja7dWfSj4NZ78HgS/xZ/y4G31Kt+8DcoAop5+1UZ6W3v8MdYa0nAj7rAj
         NXvjwL3kXpv0+MDMCv2TrozOvVx5OOjjwaz194FQ=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C56FB6083C;
        Fri, 28 Dec 2018 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023232;
        bh=Fyh26KhyuUxC3ve0+iV5fsOf+MawcTHfGm8YKfNYBZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRP1lSJs64qfpVw4fELYzQtUk9qu1GafT+UjV6xXLkVDG1q5l22XfDw1IneNtle5I
         s9J71KcRpUgqeaLspZ1RHEWVnxeaD7vi9SY7mZ4ncH9cMLWPHDUcYzdTyVWd/f9XGZ
         Gc2GQ1bT1TEHktstyzISp72zEoIq0kJSmkR9rMTc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C56FB6083C
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
        sricharan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 7/8] dt-bindings: remoteproc: qcom: Add power-domain bindings for Q6V5
Date:   Sat, 29 Dec 2018 00:23:06 +0530
Message-Id: <20181228185307.25645-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228185307.25645-1-sibis@codeaurora.org>
References: <20181228185307.25645-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power-domain bindings for Q6V5 MSS on MSM8996 and SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v3:
  * Fixup dt-binding documentation as suggested by Doug
  * Dropping Rob's Reviewed-by due to documentation style
    change

v2:
  * Add load_state power-domain
  * List cx and mx power-domains for MSM8996

 .../bindings/remoteproc/qcom,q6v5.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 9db371da4897..36e91c9d76e0 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -106,6 +106,25 @@ For the compatible string below the following supplies are required:
 	Definition: reference to the regulators to be held on behalf of the
 		    booting of the Hexagon core
 
+- power-domains:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to power-domains that match power-domain-names
+
+- power-domain-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: The power-domains needed depend on the compatible string:
+	qcom,q6v5-pil:
+	qcom,ipq8074-wcss-pil:
+	qcom,msm8916-mss-pil:
+	qcom,msm8974-mss-pil:
+		    no power-domain names required
+	qcom,msm8996-mss-pil:
+		    must be "cx", "mx"
+	qcom,sdm845-mss-pil:
+		    must be "cx", "mx", "mss", "load_state"
+
 - qcom,smem-states:
 	Usage: required
 	Value type: <phandle>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

