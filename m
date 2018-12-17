Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA48C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198A620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gPZhR0sq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gPZhR0sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeLQKIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:08:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLQKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:07:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E9966607F1; Mon, 17 Dec 2018 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041278;
        bh=IIv9hC8caYAYfScHAxzGiohAA48fkx0Ex7TsbJF0/Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPZhR0sqY98FgY4MC07jdi3qoUze15IDqLPPu2JBtfyMZPrElBmL/l+pNgFZ8jQPb
         s/zGsbUcB9CHQqgybuINxiA6ha9tfnna5v+r0uws2UmrtOZbapPyx9NY/+ti9gH6rf
         VKh5fNGCwJQjRLiOag1SE8xtcKJUpsyWWMECcz8g=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C55216076A;
        Mon, 17 Dec 2018 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041278;
        bh=IIv9hC8caYAYfScHAxzGiohAA48fkx0Ex7TsbJF0/Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPZhR0sqY98FgY4MC07jdi3qoUze15IDqLPPu2JBtfyMZPrElBmL/l+pNgFZ8jQPb
         s/zGsbUcB9CHQqgybuINxiA6ha9tfnna5v+r0uws2UmrtOZbapPyx9NY/+ti9gH6rf
         VKh5fNGCwJQjRLiOag1SE8xtcKJUpsyWWMECcz8g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C55216076A
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
Subject: [PATCH v2 3/7] dt-bindings: remoteproc: qcom: Fixup regulator dependencies
Date:   Mon, 17 Dec 2018 15:37:20 +0530
Message-Id: <20181217100724.4593-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217100724.4593-1-sibis@codeaurora.org>
References: <20181217100724.4593-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup regulator supply dependencies for Q6V5 MSS on MSM996 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 780adc043b37..98894e6ad456 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -76,7 +76,9 @@ on the Qualcomm Hexagon core.
 	Usage: required
 	Value type: <phandle>
 	Definition: reference to the regulators to be held on behalf of the
-		    booting of the Hexagon core
+		    booting of the Hexagon core on MSM8916 SoCs
+		    reference to the pll-supply regulator to be held on behalf
+		    of the booting of the Hexagon core on MSM8996 SoCs
 
 - qcom,smem-states:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

