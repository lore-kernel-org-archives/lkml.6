Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F77C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E0620879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E0VIbXN0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XcGmZgTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfAJEDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:03:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51484 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfAJEDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:03:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E9FF460863; Thu, 10 Jan 2019 04:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547093027;
        bh=k7h4Nj3eE1w2pHAkkY8rkkg8BMUZ14GVlA3NP4XjNnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0VIbXN0GfF2eMPPHX0bqs5ako8QpBfI0iBWpI40x9zdC0My+//pdqCpFVofCY0I8
         sAE6i+veIkA58dtWpchmm2fXZCXDF4IG6a/SJDkv48aMH+jYSLGzyhx5MR3oA59X6g
         bRfmS/PcgvhnrPh00lBe2Pb1/StZlKAhFrPIul98=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93B5360986;
        Thu, 10 Jan 2019 04:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547093024;
        bh=k7h4Nj3eE1w2pHAkkY8rkkg8BMUZ14GVlA3NP4XjNnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XcGmZgTjEOlwJwtO2Buom3/0RWuZEADaHlC9IdP1JngqGLpMzXprM8+h7PeT6E+Ql
         SDqw218IhLthxr+bcLyHEMSy5l+BggLTFLf6LfDGsRG6A/HgWnaKlyhtcxQKG9PROw
         dnOPfEJdv9ayITsOo1s282PE91RJ9gjEsPs5xHgI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93B5360986
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v11 9/9] soc: qcom: rpmhpd: Mark mx as a parent for cx
Date:   Thu, 10 Jan 2019 09:32:09 +0530
Message-Id: <20190110040209.6028-10-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110040209.6028-1-rnayak@codeaurora.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the active + sleep and active-only MX power domains as
the parents of the corresponding CX power domains. This will ensure that
performance state requests on CX automatically generate equivalent requests
on MX power domains.

This is used to enforce a requirement that exists for various
hardware blocks on SDM845 that MX performance state >= CX performance
state for a given operating frequency.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index e45628694f09..4aadece0ac5a 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -97,12 +97,14 @@ static struct rpmhpd sdm845_cx_ao;
 static struct rpmhpd sdm845_cx = {
 	.pd = { .name = "cx", },
 	.peer = &sdm845_cx_ao,
+	.parent = &sdm845_mx.pd,
 	.res_name = "cx.lvl",
 };
 
 static struct rpmhpd sdm845_cx_ao = {
 	.pd = { .name = "cx_ao", },
 	.peer = &sdm845_cx,
+	.parent = &sdm845_mx_ao.pd,
 	.res_name = "cx.lvl",
 };
 
@@ -372,6 +374,15 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		data->domains[i] = &rpmhpds[i]->pd;
 	}
 
+	/* Add subdomains */
+	for (i = 0; i < num_pds; i++) {
+		if (!rpmhpds[i])
+			continue;
+		if (rpmhpds[i]->parent)
+			pm_genpd_add_subdomain(rpmhpds[i]->parent,
+					       &rpmhpds[i]->pd);
+	}
+
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

