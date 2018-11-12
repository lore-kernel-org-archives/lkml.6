Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CEBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ED522419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZx3yksl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ED522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeKMFdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:33:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:33:20 -0500
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E8C22507;
        Mon, 12 Nov 2018 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542051521;
        bh=Yd1MKvAWLBm0iVvwdMldqrwFUSswW2kPvTjV1ShiIvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZx3ykslzwR0sS/QwRuEFfr6XgNC40Qew/e92iCBDIylVkbvL1c4B0mFY8hDhqL+Z
         eoxsZk0peAd4hu2MbC7AOd5LFV1jFWCvwAGMJz8iHEF3mbrtjVWlhgLJtfikk4lad6
         q6voPFqcE6XSIkb+3dRUnq+7yoR8cUE7JZoUYcNM=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [RESEND 1/2] fpga: of-fpga-region: Use platform_set_drvdata
Date:   Mon, 12 Nov 2018 13:38:33 -0600
Message-Id: <1542051514-5205-2-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542051514-5205-1-git-send-email-atull@kernel.org>
References: <1542051514-5205-1-git-send-email-atull@kernel.org>
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
index 122286f..75f64ab 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
-	dev_set_drvdata(dev, region);
+	platform_set_drvdata(pdev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.7.4

