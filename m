Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF814C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F54F20854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DuJNZtkh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CuD221II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfAGKLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:11:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfAGKK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:10:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D5DD160AFE; Mon,  7 Jan 2019 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855858;
        bh=xna8L3pKpKLpH51OsITmCIR3bGTRCkEom404zCmxtHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuJNZtkhn4qfjh66kNYiOPmK0MMBzxwr7om8E91jbs8ZaqyH+qc4V0506JIVRSYOS
         knxKoLBPLPGbTEivp8iS0HTaIw9izRTSwDurWr15zpBt0EOjHihoAXdakcmISwmEha
         ZNrPE7IXEzRMzfal9Rt1+P1k5e6nR+FFpqTKMeJw=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1083A60AD6;
        Mon,  7 Jan 2019 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855854;
        bh=xna8L3pKpKLpH51OsITmCIR3bGTRCkEom404zCmxtHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuD221IIzfN0F1SHJPhoHNurEm2NsCMxpLcYpw488u9UqlYeAEJjM1pemlseDvKUO
         GLiU7etJ+HNo4AfLSmJRPgg74dpDhinZIPOpYyUePQBaHHZVfJGBcbvbGgf6/RKTeH
         c85csxoKfsBP+Ukcg44PMS2mjXSLZ9WDHV1p5Ecw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1083A60AD6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v9 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
Date:   Mon,  7 Jan 2019 15:39:59 +0530
Message-Id: <20190107100959.14528-11-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107100959.14528-1-rnayak@codeaurora.org>
References: <20190107100959.14528-1-rnayak@codeaurora.org>
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
index 38c8a11c92c8..edf67de65f6a 100644
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

