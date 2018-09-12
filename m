Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A2C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D9F20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ5fSsZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D9F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeILTsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbeILTsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:48:24 -0400
Received: from localhost.localdomain (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF4520866;
        Wed, 12 Sep 2018 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536763415;
        bh=yFDq3gNJ0hc98aJKWqK6WwpK5PXmEqtuFNi9c/xujoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQ5fSsZr1H87BJlA4Wr6lqoIiip4NYOhIrOfZ8iRwc/yR0NtrQBEX6IDIe6JXIKx5
         ujlXrS1UjkCEjbZJIHSuhUI8VSDkg87EnoCZ8AwY78Q0ObucyfPYQ99Loe8OzjxwO3
         f9Sl6qTdHyk9WuuiBEb9k5PMID84MRlNjM0MJuNA=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 4/5] fpga: of-fpga-region: Use platform_set_drvdata
Date:   Wed, 12 Sep 2018 09:43:26 -0500
Message-Id: <20180912144327.3130-5-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180912144327.3130-1-atull@kernel.org>
References: <20180912144327.3130-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Use platform_set_drvdata rather than dev_set_drvdata
to match the platform_get_drvdata in the _remove()
function of the platform driver.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/of-fpga-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 052a134..d6a70e4 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_free;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
-	dev_set_drvdata(dev, region);
+	platform_set_drvdata(pdev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.7.4

