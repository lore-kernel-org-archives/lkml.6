Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE79C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5926620879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675612;
	bh=69VBcovPVuuN0G+oR4GAVi5/exfkWIDVdTuiDPQfKzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSy3+Erma/WGSnOU1R+ghkSAifLDYv4j7VvYhgNkhwBw8xyDhb/6Zva4vQw086eMT
	 gcPIhYHtlsu8B+SnFme/aCb+444d/PxxOEg/yC2vWuS7GcH3STPCxGu3oyK/j4TArA
	 pWWB9C8Gabhk1DPz3HHFurm0Zxouzenw6YGW3G3w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5926620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeLMEdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbeLMEd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E1820873;
        Thu, 13 Dec 2018 04:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675608;
        bh=69VBcovPVuuN0G+oR4GAVi5/exfkWIDVdTuiDPQfKzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdA8gdj8YavDlhrywWXmFqs9tY8eKsJoNWZUUQMM+XzmTWoz/i9onR72esMW3nahp
         f4ZzU+pqZbotcIqpuqMDKWn9AOcr5LiOU4QYI683huxDdqF6Ayn9hyaw50PnKgoU3v
         IZ0vEglaHFWbqNdG3XAO3hOeW8W9MrVAs59BbceY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 16/23] libata: whitelist all SAMSUNG MZ7KM* solid-state disks
Date:   Wed, 12 Dec 2018 23:32:52 -0500
Message-Id: <20181213043259.76643-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043259.76643-1-sashal@kernel.org>
References: <20181213043259.76643-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>

[ Upstream commit fd6f32f78645db32b6b95a42e45da2ddd6de0e67 ]

These devices support read zero after trim (RZAT), as they advertise to
the OS. However, the OS doesn't believe the SSDs unless they are
explicitly whitelisted.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ba514fa733de..d543172b20b3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4297,6 +4297,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "SAMSUNG*MZ7KM*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
 	/*
-- 
2.19.1

