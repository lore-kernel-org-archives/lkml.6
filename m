Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A90C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F1C217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LdLk5fCF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fNtJwnTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbeLTRat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:30:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbeLTRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:30:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 365736095F; Thu, 20 Dec 2018 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545327039;
        bh=Z8K6feG33hiEOW6ZOGAVNj2MC3HhQpWnV41UvvJrmSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdLk5fCFr05vrG9dX4gSRURtUlK/QCCY2fnkWUrfhiFHAj2cpAPl1sTdb78zmH8Ij
         GfW0K4XDt4NwRUBwZvd+UE8WluKJdWOS/1IGfmLr7tj3i6gOoGvo5iqyK8ZcWBQF4q
         czZ54eTQulSROTCcHoFPqs0Q5+ZkESkqRSLQGBEs=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 274EB60918;
        Thu, 20 Dec 2018 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545327038;
        bh=Z8K6feG33hiEOW6ZOGAVNj2MC3HhQpWnV41UvvJrmSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNtJwnTXB9hcS8KI8VT1CR8/l/aykng54jTu2ZSwSENQWx6yawdIuOtYA7nJD7eG6
         C7tLo+q3rzMf9L8mx/b7hi1sn70oXjJzcMPofNbqOn8EmMCsoX9VsB96WG/x7IOnfs
         tFAK5Qk+CS/ApjdGqnO340ljV1So0YBxrxs2AFZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 274EB60918
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: sdm845: Add interconnect for GPU
Date:   Thu, 20 Dec 2018 10:30:26 -0700
Message-Id: <20181220173026.3857-4-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181220173026.3857-1-jcrouse@codeaurora.org>
References: <20181220173026.3857-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define an interconnect port for the GPU to set bus
capabilities.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1005f1eb1920..155e4ba74c96 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1369,6 +1369,8 @@
 
 			operating-points-v2 = <&gpu_opp_table>;
 
+			interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
+
 			qcom,gmu = <&gmu>;
 
 			gpu_opp_table: opp-table {
-- 
2.18.0

