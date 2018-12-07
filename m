Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D813DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8620838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544172156;
	bh=dMytBWSY8uTEtGMYbS5zbRZmosiGSC+KgKHttSscplQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rO8PMa6m3TZVaUzFbTZrWM9XctWqms10GKZdZv2bbXz1YPAMI2jtoWO1W+m8cSSVg
	 /+uu0nZnfLBdz0KmruEIb2hvbjMOeDzWGbWVNr/IXvSMZTcO0h45++kEVPzfVBZVnO
	 1nY/Nqhdrk+jzQyDCIcDNYcLXcZKSv2i9kapnL5g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE8620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGImf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeLGImf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:42:35 -0500
Received: from localhost.localdomain (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B109220838;
        Fri,  7 Dec 2018 08:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544172154;
        bh=dMytBWSY8uTEtGMYbS5zbRZmosiGSC+KgKHttSscplQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pwoDanbIDy0reoJkBmwMewYUgPca3v0HsD/HBUTuaz6lm7l+MoWwm7ArYCZZMGtzW
         mBy71E+Poi/RWW0iREGO6E5y05Owlw2DLSRZmPv3Nr6kD34WLXv/6bZ+qOKpwIAHp7
         XzZKl4+zJppaVrCwsXzpNhQrVIfr32cKUFcZQDKQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2] clk: qcom: qcs404: Fix gpll0_out_main parent
Date:   Fri,  7 Dec 2018 14:11:49 +0530
Message-Id: <20181207084149.26470-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

gpll0_out_main parent is cxo so fix it.

Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller driver for QCS404")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

v2: add qc404 in title and review tag by Bjorn

 drivers/clk/qcom/gcc-qcs404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index ef1b267cb058..64da032bb9ed 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -297,7 +297,7 @@ static struct clk_alpha_pll gpll0_out_main = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gpll0_out_main",
 			.parent_names = (const char *[])
-					{ "gpll0_sleep_clk_src" },
+					{ "cxo" },
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_ops,
 		},
-- 
2.19.2

