Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30729C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CC62133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bSYbHRsZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bSYbHRsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeLQKHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:07:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34576 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLQKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:07:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B39B76076A; Mon, 17 Dec 2018 10:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041264;
        bh=urdmC+5c+zRZyhEvPeOqyU+igtd3kHISA4C53YHNTXc=;
        h=From:To:Cc:Subject:Date:From;
        b=bSYbHRsZ69aAdQ/9D0FzIXZ4ZYz9Z3ZV4tUoOWJYVOYsIonMTsZ+wboz7o+8jhKgz
         6r2MaZ+PvU1PyjAn7Rsd9GShvJai9lSzyDbAxGTwMGwLhQggT87/8tb76VQPFsK+aH
         8R7D9a+QdMK9HhurD4IvFbmECr0kaZ2vGzEd+CBE=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 657A9606FC;
        Mon, 17 Dec 2018 10:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041264;
        bh=urdmC+5c+zRZyhEvPeOqyU+igtd3kHISA4C53YHNTXc=;
        h=From:To:Cc:Subject:Date:From;
        b=bSYbHRsZ69aAdQ/9D0FzIXZ4ZYz9Z3ZV4tUoOWJYVOYsIonMTsZ+wboz7o+8jhKgz
         6r2MaZ+PvU1PyjAn7Rsd9GShvJai9lSzyDbAxGTwMGwLhQggT87/8tb76VQPFsK+aH
         8R7D9a+QdMK9HhurD4IvFbmECr0kaZ2vGzEd+CBE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 657A9606FC
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
Subject: [PATCH v2 1/7] dt-bindings: soc: qcom: Add remote-pid binding for GLINK SMEM
Date:   Mon, 17 Dec 2018 15:37:18 +0530
Message-Id: <20181217100724.4593-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing qcom,remote-pid dt binding required for GLINK SMEM
which specifies the remote endpoint of the GLINK edge.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
index 0b8cc533ca83..59ae603ba520 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
@@ -21,6 +21,11 @@ edge.
 	Definition: should specify the IRQ used by the remote processor to
 		    signal this processor about communication related events
 
+- qcom,remote-pid:
+	Usage: required for glink-smem
+	Value type: <u32>
+	Definition: specifies the identfier of the remote endpoint of this edge
+
 - qcom,rpm-msg-ram:
 	Usage: required for glink-rpm
 	Value type: <prop-encoded-array>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

