Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39427C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ABA20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="taLWSUCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ABA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbeKGEDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:03:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388472AbeKGECp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:02:45 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C040D20869;
        Tue,  6 Nov 2018 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541529372;
        bh=m2D/prEYBrhF0OH5OtMLAaYkwsXTQSW4K5o4XvfP7l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=taLWSUCJdbjNfDn6z8uCzZn6o+aEzelkHa1J51ulobd+QXy4/izDsmcfrIdz/4yc1
         5x6I4v9bpeZ6Xm9gD4T2gn8tps1kZuG307p2VC9fh4jd0ly3/fj30ltEwEXM6VIQqF
         kJyc/X5S4Aj19uCXSrwQOBEeWO56r3Qu1SB4KKm4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/4] clk: mediatek: Drop THIS_MODULE from platform_driver
Date:   Tue,  6 Nov 2018 10:36:08 -0800
Message-Id: <20181106183609.207702-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181106183609.207702-1-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already set by platform_driver_register(), so we can remove it
here.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt2712.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 17c031d110ff..55f81f9bfdb5 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1445,7 +1445,6 @@ static struct platform_driver clk_mt2712_drv = {
 	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt2712",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_clk_mt2712,
 	},
 };
-- 
Sent by a computer through tubes

