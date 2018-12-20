Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D592620811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299051;
	bh=d7zuORbV7VBZkl5nixjUAUF6XdIKcUkic3HUbuiWKmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pqMzSzdHtK4HKIa0YtRxi8yS+hNS7Et3BLhYQ3MuPDogOvM0+vI2GBS7Z3iq1uzhI
	 ZgJERyCFLKFJqSSsai6AMHGiiq/GfuivNjDtsFjSumXMUBeVQfGpsPjjtkxxQHQx5H
	 WReJiydH2lDOx/s/9NhRdVaLgKXvQJ1652pUozp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbeLTJoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:44:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731246AbeLTJWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A2621720;
        Thu, 20 Dec 2018 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297722;
        bh=d7zuORbV7VBZkl5nixjUAUF6XdIKcUkic3HUbuiWKmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unCGGo79ZI7NZ/emRMzmX9HvWnGqiElCf/iWoILXLNqe59RSoY5pltxLG8UZ0oSgz
         KQPlaE9PZjMZ/8bdTC4JLhUkBbEoGOffJJ1+96lW9BIraj6VFfVxoi4SyZJh7EJdKH
         Q3B2ly86kZ4swGGqslB3XD/VPqoayUIlFAhJpmlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 32/40] libata: whitelist all SAMSUNG MZ7KM* solid-state disks
Date:   Thu, 20 Dec 2018 10:18:44 +0100
Message-Id: <20181220085827.739714754@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



