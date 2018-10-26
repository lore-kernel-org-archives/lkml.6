Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB1FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B6820869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL4rejp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B6820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeJZWWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:22:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33867 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJZWWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:22:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so670757qkg.1;
        Fri, 26 Oct 2018 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zn0jIUuixIig8TjC2w+f4g5JGcSndwq1Dm9y0W80I5w=;
        b=aL4rejp+0HJNsIQIbqYfBWXD7j9IIx6nUCLbry5n+hDjR1uXe84Ldu/yMzPnphnnb2
         vZqFVm0AM7hTx4mEN1kwDE0/6FhEmIgf0i8ossxQXmAXb7cRCERMml5CqIorM6CHNOfM
         lvbhDdaSHozW40J7kKMZJPEN1bW0WGEYno6T/Q9StWhB7e8nwMY6Akvq9pA4dSM5e3BG
         2Xdoz5wNpZApWhWro29/2cydCovVvlRLbYGrCM3+5sTOaFp5usgdIkAokxQ3dsUZvFo8
         VsXsqbEt9Wyn+OWdbw+dPxKkEFhLMA68HAWBS36rb59ZU4ToeDO/VsjaNhAn8bKq6qIc
         29Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zn0jIUuixIig8TjC2w+f4g5JGcSndwq1Dm9y0W80I5w=;
        b=kf2xJHzh6/kMb4U9Fbs/GXFKsmvaasG1gq/1GjQeE9iHBYW+vd4QbOSEcTnKZMSb5N
         PoA5bQJ6IVOrZk1KYjbaxCANYWQM7PPOnIyZaq477zkThDxx+pGKQiRc4ygUUUjTYMBq
         MgZuoiuGFw6Ff3qTzlul9a7vJqV6C2pSjAyFFeYIJ8BiO+0exV4JVNOZ+XMxV9Q/dav0
         O5oprlfMgkFNtkMkloqN8M4cQFDJOqxMATxhjOFp1Ndoy4G0bsbgD9RWmdwQsoo2xrgF
         cyUvbbT/vtJoGW5wRp4dFvSeY5T1vYfG7bZjb2re3lRibRtE8QW754Dj//vqCtrMldnv
         nZLQ==
X-Gm-Message-State: AGRZ1gIEdxiRHysMwW4hdq1HplEn5JOPY/52JUR0TiSxg9PHKiEy1PQg
        WUKH3l6DyYSWYAE04Z1RrPM=
X-Google-Smtp-Source: AJdET5celZFvfUQERRPjgwm824WGnTdryWO7a9giZtAXZXOlTQtZ3K8zoBnlkDtkHjMBhAwXmc+1QQ==
X-Received: by 2002:a37:16cf:: with SMTP id 76mr3093620qkw.3.1540561527579;
        Fri, 26 Oct 2018 06:45:27 -0700 (PDT)
Received: from localhost.localdomain ([186.222.90.17])
        by smtp.gmail.com with ESMTPSA id b16-v6sm5077087qtq.72.2018.10.26.06.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 06:45:27 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     hdegoede@redhat.com
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Diego Viola <diego.viola@gmail.com>
Subject: [PATCH v3] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
Date:   Fri, 26 Oct 2018 10:45:16 -0300
Message-Id: <20181026134516.1234-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

med_power_with_dipm causes my T450 to freeze with a SAMSUNG
MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).

Switching the LPM to max_performance fixes this issue.

Signed-off-by: Diego Viola <diego.viola@gmail.com>
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
2.19.1

