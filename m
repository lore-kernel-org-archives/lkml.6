Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFA9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F04C20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XGkI+Ck6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lmqaH41O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F04C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeK3SiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:38:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeK3SiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:38:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1792460913; Fri, 30 Nov 2018 07:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543562980;
        bh=bhxYDHnNpXcnbhr5OnXtWfpEawJ5VI/JyIkeFUGwqBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGkI+Ck67J6VpI7wRm/ECGG+N10AG4vmQ+BeYZmh+WkG6mwQRY5JU+rnOL9vcdH92
         d+CXlZEpO3B/HXVKSGxAyRAzs6oephyDzlFmF4ahsux8Po86b9qbZaBZdUOuJRArOQ
         u2IIE3V2g08rinChbNfBrelRvNE1o6V0KW6k/JP4=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C0C660B13;
        Fri, 30 Nov 2018 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543562979;
        bh=bhxYDHnNpXcnbhr5OnXtWfpEawJ5VI/JyIkeFUGwqBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmqaH41O8zalvsjW/VHOIbclSXNRJaWrGCtk6US5GLhNnWcCdp87mL8R8IKL0N4UK
         jjLXoRzn3kAT6nEgYYLiCNyKtlWB8FTKVVWJPMkEK8aGzFlIAzvZansTjSap0VY95r
         isZTaPSbHFS1is4ZTdqsgf5YkkgA5PRdO6BcwwYM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C0C660B13
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 2/2] remoteproc: q6v5_adsp: Remove voting for lpass_aon clock
Date:   Fri, 30 Nov 2018 12:59:10 +0530
Message-Id: <1543562950-23997-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
References: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lpass_aon clock is on by default. Remove it from lpass
clock list to avoid voting for it.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 79374d1..4829173 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -48,7 +48,7 @@
 
 /* list of clocks required by ADSP PIL */
 static const char * const adsp_clk_id[] = {
-	"sway_cbcr", "lpass_aon", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
+	"sway_cbcr", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
 	"qdsp6ss_xo", "qdsp6ss_sleep", "qdsp6ss_core",
 };
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

