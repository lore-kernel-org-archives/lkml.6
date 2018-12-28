Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD84620869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aJi0mP9q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aJi0mP9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbeL1Sx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:53:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbeL1Sx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:53:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA1886089D; Fri, 28 Dec 2018 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023207;
        bh=Z99cb797szcBohEz/E/I94UChw52QC1xSm71ao79i6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJi0mP9qUZb5rL+4OeU10DMFia42DvE1tKrgyqxAp5EJnPRNd1F66MeFBGA4UtO1y
         NG3jE7Htt9oiii+OJEI2jAMYnlkdOyWv90HIAxSyV4tEmkVSBOMfuSyquAjzzyP7ZA
         OLNcWb/Gv0mKmP3/lzWCBn3knBKamzYhBxfkUBdc=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE6766076A;
        Fri, 28 Dec 2018 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023207;
        bh=Z99cb797szcBohEz/E/I94UChw52QC1xSm71ao79i6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJi0mP9qUZb5rL+4OeU10DMFia42DvE1tKrgyqxAp5EJnPRNd1F66MeFBGA4UtO1y
         NG3jE7Htt9oiii+OJEI2jAMYnlkdOyWv90HIAxSyV4tEmkVSBOMfuSyquAjzzyP7ZA
         OLNcWb/Gv0mKmP3/lzWCBn3knBKamzYhBxfkUBdc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE6766076A
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
Subject: [PATCH v4 2/8] dt-bindings: remoteproc: qcom: Add missing clocks for SDM845
Date:   Sat, 29 Dec 2018 00:23:01 +0530
Message-Id: <20181228185307.25645-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228185307.25645-1-sibis@codeaurora.org>
References: <20181228185307.25645-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.

Fixes: fb22022ff63d ("dt-bindings: remoteproc: Add Q6v5 Modem PIL
binding for SDM845")

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v4:
  * Re-order clocks for consistency as suggested by Rob

v3:
  * Fixup dt-binding documentation as suggested by Doug

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 9ff5b0309417..d645c8db29fd 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -39,13 +39,21 @@ on the Qualcomm Hexagon core.
 - clocks:
 	Usage: required
 	Value type: <phandle>
-	Definition: reference to the iface, bus and mem clocks to be held on
-		    behalf of the booting of the Hexagon core
+	Definition: reference to the clocks that match clock-names
 
 - clock-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "iface", "bus", "mem"
+	Definition: The clocks needed depend on the compatible string:
+	qcom,ipq8074-wcss-pil:
+		    no clock names required
+	qcom,q6v5-pil:
+	qcom,msm8916-mss-pil:
+	qcom,msm8974-mss-pil:
+		    must be "iface", "bus", "mem", "xo"
+	qcom,sdm845-mss-pil:
+		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
+		    "snoc_axi", "mnoc_axi", "prng"
 
 - resets:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

