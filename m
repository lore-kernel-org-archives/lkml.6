Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E994FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B664F218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KswQH5j7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vac2hGx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbeLUI5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:57:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36410 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbeLUI5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:57:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2ADD60907; Fri, 21 Dec 2018 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382639;
        bh=nuHWGcWUUThB6j8DcysQBCA4+Kh2aUc8emNk//sFmdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KswQH5j7aN8fEWHAqsj8TanoehnyrRTdDhfrbbBWBVP4fgC00y+GK3kxMJrT3a7H9
         RqyS+jLvfXv8BU6TDQw/LXo/UMr09/DKB4zAjyLRCKIxgz+/BFuFbS42NrzNJ5AQDi
         x/YmsSID6FXtxAtJourFxssCo8rVH2K9Rjwb48+Q=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3E8260854;
        Fri, 21 Dec 2018 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382632;
        bh=nuHWGcWUUThB6j8DcysQBCA4+Kh2aUc8emNk//sFmdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vac2hGx2i+748nA4OHzFJltxO1Wy9HTSbTnRWP/GsTE2ThMpniPrwJYbA3ZJ9F1fW
         GCrqf+sFxhi5fWRUHS5KHofL9MD2e/n2SiJqdX5auqr2mqGDouLSGoci+2Els7zWMF
         fth08QOwzpXmVXgtnb+Ctr4fXFpJrMaA+WNW/dxo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3E8260854
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
Date:   Fri, 21 Dec 2018 14:26:22 +0530
Message-Id: <20181221085622.25573-11-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221085622.25573-1-rnayak@codeaurora.org>
References: <20181221085622.25573-1-rnayak@codeaurora.org>
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
---
 drivers/soc/qcom/rpmhpd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index f7fbe57f31ae..71d693c31e3b 100644
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

