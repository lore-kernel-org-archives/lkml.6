Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7D3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523EB2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScxbsACd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523EB2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeKAIrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbeKAIHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF5B20821;
        Wed, 31 Oct 2018 23:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027217;
        bh=K4avevg0oG8TjR/hr6vZIrprcQlMtSFVDcLBjvcaRNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScxbsACdvUCJF11jm0Ygsz/Mr5l0e8L/UGr4D4wzuVb/039yRQxmahh/P+pae0kKs
         3CYJ41AE3zaCk8YOyqtWqQ1A50ul1UZZB0wHGGTOv/Opws574WzOYQ3nfPFh2RAS/O
         /NGqCNMC9QdDvp3hCqQkm1nHuW/IgWqGazgi8bU0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Diego Viola <diego.viola@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 082/146] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
Date:   Wed, 31 Oct 2018 19:04:37 -0400
Message-Id: <20181031230541.28822-82-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diego Viola <diego.viola@gmail.com>

[ Upstream commit a435ab4f80f983c53b4ca4f8c12b3ddd3ca17670 ]

med_power_with_dipm causes my T450 to freeze with a SAMSUNG
MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).

Switching the LPM to max_performance fixes this issue.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Diego Viola <diego.viola@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a9dd4ea7467d..6e594644cb1d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4553,6 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", "DXT02L5Q", ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.17.1

