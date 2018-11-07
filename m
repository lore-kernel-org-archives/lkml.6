Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C14C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBD220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFTUkmt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBD220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeKHDXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731551AbeKHDX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:23:26 -0500
Received: from localhost.localdomain (rrcs-67-79-197-43.sw.biz.rr.com [67.79.197.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6468920892;
        Wed,  7 Nov 2018 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541613119;
        bh=FswMzj2KFf8bx3AS6v6fcTeUq9BkBPjAdKkbrO9rUZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFTUkmt/baFdB8dI1mK70l8auPIoXY0b6rKSO/RWy3M3ErwHJmZ2GJKaAf4qo7TPG
         CA6JYJ7Sc/Z0i+KxTuHGfbaXXCDlCmU5cgWfRXx5JDVgbscOe/npl8ORM6Q/uOSGB+
         RKjt+cn8CVQN2I+/ZenBvsfcnX8z8mtBFUtctIcQ=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 2/4] fpga: dfl: fme: remove set but not used variable 'priv'
Date:   Wed,  7 Nov 2018 11:51:46 -0600
Message-Id: <1541613108-29660-3-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541613108-29660-1-git-send-email-atull@kernel.org>
References: <1541613108-29660-1-git-send-email-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-fme-pr.c: In function 'pr_mgmt_uinit':
drivers/fpga/dfl-fme-pr.c:447:18: warning:
 variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-fme-pr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index 0b84053..fe5a557 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -444,10 +444,8 @@ static void pr_mgmt_uinit(struct platform_device *pdev,
 			  struct dfl_feature *feature)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dfl_fme *priv;
 
 	mutex_lock(&pdata->lock);
-	priv = dfl_fpga_pdata_get_private(pdata);
 
 	dfl_fme_destroy_regions(pdata);
 	dfl_fme_destroy_bridges(pdata);
-- 
2.7.4

