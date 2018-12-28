Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D6320869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FICDzroG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FICDzroG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeL1SxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:53:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeL1SxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:53:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7A7A607C6; Fri, 28 Dec 2018 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023202;
        bh=I0YOiRYPU9cMm9CE7tw0dqP156rQwU3Y4aa5AvbNQzk=;
        h=From:To:Cc:Subject:Date:From;
        b=FICDzroG6jl9vFD2ZrDWNrfPV5enCpCYkM3fB6gjywlTuaraCBsph3V+MhkfW4gt4
         esvP8kKuFJc2MHsY3+X/V5+cmHGYnHoqQXmpa2RKcByzXySAzKzuDNT4taJM4d8tJT
         sl+a1nRhnlvgy3zfXvioeZ3xnS8NOZJmzPOPTix8=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BADFC60452;
        Fri, 28 Dec 2018 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023202;
        bh=I0YOiRYPU9cMm9CE7tw0dqP156rQwU3Y4aa5AvbNQzk=;
        h=From:To:Cc:Subject:Date:From;
        b=FICDzroG6jl9vFD2ZrDWNrfPV5enCpCYkM3fB6gjywlTuaraCBsph3V+MhkfW4gt4
         esvP8kKuFJc2MHsY3+X/V5+cmHGYnHoqQXmpa2RKcByzXySAzKzuDNT4taJM4d8tJT
         sl+a1nRhnlvgy3zfXvioeZ3xnS8NOZJmzPOPTix8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BADFC60452
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
Subject: [PATCH v4 1/8] dt-bindings: soc: qcom: Add remote-pid binding for GLINK SMEM
Date:   Sat, 29 Dec 2018 00:23:00 +0530
Message-Id: <20181228185307.25645-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing qcom,remote-pid dt binding required for GLINK SMEM
which specifies the remote endpoint of the GLINK edge.

Fixes: 2b41d6c8e696 ("dt-bindings: soc: qcom: Extend GLINK to cover
SMEM")

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v3:
  * Fixed typo

 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
index 0b8cc533ca83..587bb1ddc8cc 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
@@ -21,6 +21,11 @@ edge.
 	Definition: should specify the IRQ used by the remote processor to
 		    signal this processor about communication related events
 
+- qcom,remote-pid:
+	Usage: required for glink-smem
+	Value type: <u32>
+	Definition: specifies the identifier of the remote endpoint of this edge
+
 - qcom,rpm-msg-ram:
 	Usage: required for glink-rpm
 	Value type: <prop-encoded-array>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

