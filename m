Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F90C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C88208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wdLh+C71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C88208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeJEXZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeJEXOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3513A21473;
        Fri,  5 Oct 2018 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756082;
        bh=08hvT2nqjY8SX0j1pL72bkZTcTCZcJ2SI5/0A13HTd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wdLh+C71ihgZLxDOdfrve+gIs1o6tieDWi3EvQ5v5H1nX4mf1KpS+YNvy+lbNH+ug
         f94F5ZW4Mr9ADOElOBvhnBndWQQVs2NLrNOi9muIxpmQnnD9GxNixQ75gUDlGbcFkn
         hfIrrv9jH3z1vUk6c37NAtW/gTqZv3VWcdk39Pzs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 19/48] drm/pl111: Make sure of_device_id tables are NULL terminated
Date:   Fri,  5 Oct 2018 12:13:55 -0400
Message-Id: <20181005161424.20521-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

[ Upstream commit 7eb33224572636248d5b6cfa1a6b2472207be5c4 ]

We prefer to of_device_id tables are NULL terminated. So make
vexpress_muxfpga_match is NULL terminated.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/1533379767-15629-1-git-send-email-zhongjiang@huawei.com
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/pl111/pl111_vexpress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.c b/drivers/gpu/drm/pl111/pl111_vexpress.c
index a534b225e31b..5fa0441bb6df 100644
--- a/drivers/gpu/drm/pl111/pl111_vexpress.c
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.c
@@ -111,7 +111,8 @@ static int vexpress_muxfpga_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id vexpress_muxfpga_match[] = {
-	{ .compatible = "arm,vexpress-muxfpga", }
+	{ .compatible = "arm,vexpress-muxfpga", },
+	{}
 };
 
 static struct platform_driver vexpress_muxfpga_driver = {
-- 
2.17.1

