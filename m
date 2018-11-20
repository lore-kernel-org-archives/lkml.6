Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D205C520D3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93435214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H727aQID";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H727aQID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93435214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeKUHd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:33:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeKUHd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:33:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7797F60A98; Tue, 20 Nov 2018 21:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542747743;
        bh=vpCe+qDKmHLQstiaQD+RyJ0UqS515TxF5XvadJurUnA=;
        h=From:To:Cc:Subject:Date:From;
        b=H727aQIDK31KEvAw5D9gTMCCfKxKC0H1lEN8FfkNqV/agUpfgkHkurgLIRioFVw0y
         bfiqLat9d5eEXe9A1I1N+PA6d3o5G2WeHahVI0Apa9juWKmPnDnN2O8MwC1WUTaal/
         r9MUeyrhfzHmLdXvzO7LnE9laXJjfRnCCpcV1MOI=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 475CA60452;
        Tue, 20 Nov 2018 21:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542747743;
        bh=vpCe+qDKmHLQstiaQD+RyJ0UqS515TxF5XvadJurUnA=;
        h=From:To:Cc:Subject:Date:From;
        b=H727aQIDK31KEvAw5D9gTMCCfKxKC0H1lEN8FfkNqV/agUpfgkHkurgLIRioFVw0y
         bfiqLat9d5eEXe9A1I1N+PA6d3o5G2WeHahVI0Apa9juWKmPnDnN2O8MwC1WUTaal/
         r9MUeyrhfzHmLdXvzO7LnE9laXJjfRnCCpcV1MOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 475CA60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: remoteproc: qcom: Add shutdown-ack irq for Q6v5
Date:   Wed, 21 Nov 2018 02:32:07 +0530
Message-Id: <20181120210209.9029-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional shutdown-irq binding required for sysmon shutdown on
SDM845/MSM8996/QCS404 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 9ff5b0309417..14947562bc67 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -29,12 +29,13 @@ on the Qualcomm Hexagon core.
 	Usage: required
 	Value type: <prop-encoded-array>
 	Definition: must list the watchdog, fatal IRQs ready, handover and
-		    stop-ack IRQs
+		    stop-ack IRQs and may optionally list shutdown-ack IRQ
 
 - interrupt-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
+	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack",
+		    "shutdown-ack"
 
 - clocks:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

