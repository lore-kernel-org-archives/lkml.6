Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E902C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C860208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CsLPRizk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X35p2oBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C860208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbeG0NkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:40:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbeG0Nj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:39:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 55EA260B7A; Fri, 27 Jul 2018 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693899;
        bh=5FCC/tSqbFiWCwdfdm3rxP2znqlVaTi97Gj5xIu+aUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsLPRizkeAioQ1su++5fhs2mwmLvLrG+HTtxjCYEx0lDTOOaixNb7pna0vBnzsVed
         iovoq5xMkxkOV1c6G57HwdIA7K+b/LW3zkZhUvboz5hke0xgdYWxcS2iLXJ8lOfxSp
         3lUVQ7a3YCz8sjVLchUOHmVuXa/RxDW/bWqvr+YA=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B02D607B9;
        Fri, 27 Jul 2018 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693898;
        bh=5FCC/tSqbFiWCwdfdm3rxP2znqlVaTi97Gj5xIu+aUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X35p2oBJ9G2k6enCh/AVkji9Ttac+xShEbzcXr+cur8G7CxmTk67wWDIuwrVLdaLE
         Q+oJ/KnFfyyl5EXrwKQ9ZmkviGoFGQy9S0J5LHQr8Ak0NhKdBEnC9wUl8l4wq2TfJ7
         J1ExKCi2WNI2LgWaVHNotq+jX7HEQBIDtwgedx8s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B02D607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        robh+dt@kernel.org, arnaud.pouliquen@st.com, andy.gross@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH V4 1/9] dt-bindings: soc: qcom: Add label for GLINK bindings
Date:   Fri, 27 Jul 2018 17:47:21 +0530
Message-Id: <1532693849-7037-2-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
References: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

There are GLINK clients who open the same channel on multiple GLINK
links. These clients need a way to distinguish which remoteproc they
are communicating to. Add a label property to identify the edge this
node represents.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
index 9663cab..0b8cc53 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
@@ -10,6 +10,11 @@ edge.
 	Value type: <stringlist>
 	Definition: must be "qcom,glink-rpm"
 
+- label:
+	Usage: optional
+	Value type: <string>
+	Definition: should specify the subsystem name this edge corresponds to.
+
 - interrupts:
 	Usage: required
 	Value type: <prop-encoded-array>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

