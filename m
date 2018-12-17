Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F516C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C11720874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GG0waB/y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X23ZcCfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeLQKHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:07:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLQKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:07:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 505EB60132; Mon, 17 Dec 2018 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041271;
        bh=NFwpxzfZJ12M7MHLF2I2RZTbqnHK7zJgjHjKS+Invqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GG0waB/yWdjBCQ+FjEtLN7sYjsUMBYop8BJG1GrZAPPd6Bw8qJsG2a1hAgJnXzE58
         t7mq1MwJbhJ5SDYcm3HylPPHQTpAp/KBUwhOh1HMGU/RPepZzo16MaqRFFkWHZaEyX
         NgELM88/5n4rvvWCenVdNIdklqp+DhN80gscIEpo=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16E8B606FC;
        Mon, 17 Dec 2018 10:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041270;
        bh=NFwpxzfZJ12M7MHLF2I2RZTbqnHK7zJgjHjKS+Invqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X23ZcCfVGRir0pqXexpOKUbBL+sZA9HeVmbxAXyjtCCg+/EGauCa4sohX3fR6gTmN
         LIlmd+i5EKgcp6Fs7CijJzBHbGDss5fRV3+UBFwB6lEyIAobqZstuqQhAGLSS4N1uw
         V6Z8SDPafN1QjZbPOBf/MbhITgyvw/AT6v7m/tR4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16E8B606FC
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
Subject: [PATCH v2 2/7] dt-bindings: remoteproc: qcom: Add clock bindings for Q6V5
Date:   Mon, 17 Dec 2018 15:37:19 +0530
Message-Id: <20181217100724.4593-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217100724.4593-1-sibis@codeaurora.org>
References: <20181217100724.4593-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt       | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 9ff5b0309417..780adc043b37 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -39,13 +39,17 @@ on the Qualcomm Hexagon core.
 - clocks:
 	Usage: required
 	Value type: <phandle>
-	Definition: reference to the iface, bus and mem clocks to be held on
-		    behalf of the booting of the Hexagon core
+	Definition: reference to the list of 4 clocks for the modem sub-system
+		    reference to the list of 8 clocks for the modem sub-system
+		    on SDM845 SoCs
 
 - clock-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "iface", "bus", "mem"
+	Definition: must be "iface", "bus", "mem", "xo" for the modem sub-system
+		    must be "iface", "bus", "mem", "gpll0_mss", "snoc_axi",
+		    "mnoc_axi", "prng", "xo" for the modem sub-system on SDM845
+		    SoCs
 
 - resets:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

