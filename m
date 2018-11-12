Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8109AC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FF622504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3hM71ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FF622504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeKMFdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:33:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:33:22 -0500
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12C422506;
        Mon, 12 Nov 2018 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542051522;
        bh=FIv9mvIAVFpEAUNmxtOtw51BmAjllxlaw4sDmux0eZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3hM71adAT/RAUSMMZ10Ud2LKSYxjNnkQaWkOwTrqEd+OX6gWO93+PVdlNUbsooah
         lgyNss98OkUeIVLRTxG3BH6siB9Mlcvzzo2NJOoKcnIMZxDljcDIDjfisWLKrfl0jm
         VATMYa6rPesh1/3uKM6M8aYnFAM//PafkJNZHoes=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [RESEND 2/2] fpga: dfl-fme-region: Use platform_get_drvdata()
Date:   Mon, 12 Nov 2018 13:38:34 -0600
Message-Id: <1542051514-5205-3-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542051514-5205-1-git-send-email-atull@kernel.org>
References: <1542051514-5205-1-git-send-email-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Use platform_get_drvdata() in remove() function of
the platform driver rather than dev_get_drvdata()
to match the platform_set_drvdata in the probe().

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-fme-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index ec134ec..1eeb42a 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -64,7 +64,7 @@ static int fme_region_probe(struct platform_device *pdev)
 
 static int fme_region_remove(struct platform_device *pdev)
 {
-	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_region *region = platform_get_drvdata(pdev);
 	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
-- 
2.7.4

