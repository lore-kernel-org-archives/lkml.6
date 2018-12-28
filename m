Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABFEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F7920869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A72jnZ9L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A72jnZ9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbeL1Sxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:53:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbeL1Sxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:53:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC1CF6090F; Fri, 28 Dec 2018 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023217;
        bh=Q7v+I1gWGliGjE+4TGw2e1iqjmJbt9o/vo0veKtibts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A72jnZ9LjVD+9MFHLIRUgmGNcH4FRHXWRUGe7CJQhAxWE9n2QVUkcfUX02hCevfgO
         Pf4Uj6FJthrUE8O/eR9RwBUNUCwheTl2UqAsVudVSdC6CxE+YKGt5yQdg7gCihlTsz
         KfYyDfLjnG+CuWrMQABeE+k6aXLzGkSghOmwXZjk=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9187D6090F;
        Fri, 28 Dec 2018 18:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546023217;
        bh=Q7v+I1gWGliGjE+4TGw2e1iqjmJbt9o/vo0veKtibts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A72jnZ9LjVD+9MFHLIRUgmGNcH4FRHXWRUGe7CJQhAxWE9n2QVUkcfUX02hCevfgO
         Pf4Uj6FJthrUE8O/eR9RwBUNUCwheTl2UqAsVudVSdC6CxE+YKGt5yQdg7gCihlTsz
         KfYyDfLjnG+CuWrMQABeE+k6aXLzGkSghOmwXZjk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9187D6090F
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
Subject: [PATCH v4 4/8] remoteproc: qcom: q6v5-mss: Add missing clocks for MSM8996
Date:   Sat, 29 Dec 2018 00:23:03 +0530
Message-Id: <20181228185307.25645-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228185307.25645-1-sibis@codeaurora.org>
References: <20181228185307.25645-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proxy vote for QDSS clock and remove vote on handover interrupt
to provide MSS PBL with access to STM hardware registers during
boot. Add "snoc_axi" and "mnoc_axi" to the active clock list.
Rename "gpll0_mss_clk" to "gpll0_mss" for consistency across SoCs.

Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
on msm8996")

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v4:
  * Rename "gpll0_mss_clk" to "gpll0_mss" for consistency across
    SoCs

 drivers/remoteproc/qcom_q6v5_mss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 01be7314e176..cb5f0d3ac6a3 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1398,13 +1398,16 @@ static const struct rproc_hexagon_res msm8996_mss = {
 	.proxy_clk_names = (char*[]){
 			"xo",
 			"pnoc",
+			"qdss",
 			NULL
 	},
 	.active_clk_names = (char*[]){
 			"iface",
 			"bus",
 			"mem",
-			"gpll0_mss_clk",
+			"gpll0_mss",
+			"snoc_axi",
+			"mnoc_axi",
 			NULL
 	},
 	.need_mem_protection = true,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

