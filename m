Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E6CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C561D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697150;
	bh=d8NQelI1qeWpeapaE2TsbNeW8vhwLBiZWw0CmO1w5x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cjETHDFnzirfBBLTlpTw5wqv7mOHxA7V5bA1leG4BL6x62yusVI4UKoF6SSUyCKKp
	 jMTeJv2vtVTdrLcroF/fva4ioK+zvvU76qwS7tevGcz0/pJ3FwCYFKqZDst6Kz6IgB
	 qmsMgHqWK5nQUrxgmwRAPwyjkzbzTYBpV5lr+rSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfA1Pxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbfA1Pxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C194D21741;
        Mon, 28 Jan 2019 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690820;
        bh=d8NQelI1qeWpeapaE2TsbNeW8vhwLBiZWw0CmO1w5x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qg9OFG87sPiI0Vuu0ArZekPTZEqI5X+yof/KvVoYoPgbXfP8XsRvP5nuGuevsbmv3
         J5scvFO2uWplsPmpjXO1NCyw9Ls0hthclzxRsohyHW+trx/4D9HuNXK8DNMAX9cQMO
         aK/6zanTioKuhjTd64e2SX6JFPyC2WMNFbJ3jwqg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 202/304] i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
Date:   Mon, 28 Jan 2019 10:41:59 -0500
Message-Id: <20190128154341.47195-202-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

[ Upstream commit 51243b73455f2d12cb82abffa7bc9028aec656e0 ]

Similarly to R-Car E3, RZ/G2E doesn't come with automatic
transmission registers, as such it is not considered compatible
with the existing fallback bindings.

Add SoC specific binding compatibility to allow for later
support for automatic transmission.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 28db6b59c4ca..a64f2ff3cb49 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -800,6 +800,7 @@ static const struct sh_mobile_dt_config r8a7740_dt_config = {
 static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,iic-r8a73a4", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7740", .data = &r8a7740_dt_config },
+	{ .compatible = "renesas,iic-r8a774c0", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7790", .data = &v2_freq_calc_dt_config },
 	{ .compatible = "renesas,iic-r8a7791", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
-- 
2.19.1

