Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338CCC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCE620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676001;
	bh=xYKZTlivoHMvuG3FDDpYNyHwBtp6xlVP49sKxHZsUCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vyjBXkdP6A7Q8nlMLT0Ni4/DjZsYeIVhRiCmo27G9nB6XkRe1dESO78uSPcN0b5Cv
	 KZ2OFzYkOC79Yq3O/cSJSSF8Dv1+7oi1oExZ+hCBZqQAuqlIVzA39RU3LIoJmEq7zV
	 EJ3V608/jhDUa8W+8/JEU6HBUQIlj1WDIra/mG9c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCE620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeLMEj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbeLMEcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C5720873;
        Thu, 13 Dec 2018 04:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675552;
        bh=xYKZTlivoHMvuG3FDDpYNyHwBtp6xlVP49sKxHZsUCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OukXHj/BPBxeqUMRYkXuMY2fwJVSS860v6D7q2iZ9cBDtj5c+D1of0OVscCjlMqvQ
         J8hNiA11PCksFJxcfxKNbD7ISlSGYcMJvAWz829JXymwfuqQr8VlA5Dk80IHT2l9J6
         tvTQaRFkSke4MxsVM+0dyDMKyigKKv46YfsB4qOk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 18/34] libata: whitelist all SAMSUNG MZ7KM* solid-state disks
Date:   Wed, 12 Dec 2018 23:31:44 -0500
Message-Id: <20181213043200.76295-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
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
index a166359ad5d4..35be49f5791d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4476,6 +4476,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "SAMSUNG*MZ7KM*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
 	/*
-- 
2.19.1

