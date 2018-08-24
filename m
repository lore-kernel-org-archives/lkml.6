Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A33C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B06721564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cxkfF9MV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fEuDP8DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B06721564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeHXQyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:54:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:54:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F139D60540; Fri, 24 Aug 2018 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535116772;
        bh=ND5io7WlNPAxAeHVhookpLQXpvsAxZ71neE8ELPfd5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxkfF9MV0JiAgMH4wGkNlbPP37RUTtdO3pgAeI+DVeUZkAjsiiznH6CHiVWqnNO+q
         JsY0cSjuWs5zZF7e7AT+jhEDahzi1D27HI2WtWoi01OdBQD6BpfEd7Nap8tAaBRVTi
         v6nqGBYl/fD/rKmrCnpgosYvLf4jrvhZooxZhxhk=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1BC306053C;
        Fri, 24 Aug 2018 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535116771;
        bh=ND5io7WlNPAxAeHVhookpLQXpvsAxZ71neE8ELPfd5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEuDP8DLOr39A2oOMXpyklP3uQHVHdF2RE/6NliayCUQVXfU4PrBNiVIQ7l3JG9lD
         OtbkSSLmdQlFzGlPJlTazyqia6f4+O1/xpD2Leh38p3V0ltdczRyWJ3rRO8x7jx0Xk
         EF2XzfxdmUDyopZcxylU3v39/zuRmWM5oK5d7YPo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BC306053C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 3/6] dt-bindings: remoteproc: Remove additional definition tag
Date:   Fri, 24 Aug 2018 18:48:57 +0530
Message-Id: <20180824131900.5353-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180824131900.5353-1-sibis@codeaurora.org>
References: <20180824131900.5353-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the additional definition tag declared for WCSS sub-system
under reset-names.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 601dd9f389aa..c45e4c131fa2 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -58,7 +58,7 @@ on the Qualcomm Hexagon core.
 	Usage: required
 	Value type: <stringlist>
 	Definition: must be "mss_restart" for the modem sub-system
-	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
+		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
 		    for the wcss syb-system
 
 - cx-supply:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

