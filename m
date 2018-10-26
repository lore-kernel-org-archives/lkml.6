Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDE7C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA152083E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbL1NW6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA152083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeJZKdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:33:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45612 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeJZKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:33:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so12319421qtj.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1i8FKlcXM12ySn3Gi520JeWFdon3evJTB/5n7AtTxeE=;
        b=PbL1NW6nlIVrulM03NRmtUmw965Cj83XpnQu0fmHWzuoCSUHw7FRWDNr2wJzWsZql7
         cGvmocUJI4M87iHzVklfYFwFW/8EvfvMHl5vMiRXwqsU7wmviPbbGjFMyXvf8Ah5gZXM
         kHtWQykTcUKcQQLFimW214ownDbSatEvP3fKk4RLGEpRkyuCdQrMycMdPT4XG1Ow0KDe
         PkjZxtuTRk88Czmqgo2PGD381sFn+WsqX++dx2uV3DhdRqxkt6HkmCgkYPQ5ki2WMd9C
         rBUCbz8IHES2uIXOZQsmYxuADLR4F9xXA8EXwGZT9TZeyGQyxj4fZeHsHVfrboXNjFtG
         JXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1i8FKlcXM12ySn3Gi520JeWFdon3evJTB/5n7AtTxeE=;
        b=D4aN2fJ2DpwuCLA3OmQIPtsStX4U+Kpaiky9UgSBh0zQ75NJpS3/BzsRcylXGhiBYe
         IYU9eXmTqSDmcEDYRY33/vrPHdekNjcMWFMPaZ/PpsCx9CzJVfqpNBUduGvb421O9fJE
         3BJsPlLSbdeL3diEoXsy3wGQWSQwSjUBk9mxlq0rnpx0faiLvzOlq7Dnt5IYlxMckqKj
         WJ9TSWjIy2SNxWWofkn/boQCgtxU8DCVgwls8J52j356TItwOKhYHSv2O+8iGZlObMsp
         8zigSuqwAyBj1SjNlYD/zpxyzX9pwO8IfwPYZS04Q2mvhbj963V9Msbw39IwkrXj6d0E
         MMNg==
X-Gm-Message-State: AGRZ1gJ4VAo8FgXPRay9KOibfi2Cj4j0zsXv7jnzE33vrZigZNIho6Pe
        Fs1USGNvHXza8ccNDqjreiM=
X-Google-Smtp-Source: AJdET5e1DcvG++mOSK9P4YUDAG1DJCOoGVucNvsMt9xyYYCds3pdJq5ueGUdh8fZqkUcfzTBjYkTlA==
X-Received: by 2002:ac8:5191:: with SMTP id c17-v6mr1502818qtn.250.1540519101490;
        Thu, 25 Oct 2018 18:58:21 -0700 (PDT)
Received: from localhost.localdomain ([186.222.90.17])
        by smtp.gmail.com with ESMTPSA id c21-v6sm4950290qtn.82.2018.10.25.18.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 18:58:21 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     hdegoede@redhat.com
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH v2] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
Date:   Thu, 25 Oct 2018 22:58:04 -0300
Message-Id: <20181026015804.4120-1-diego.viola@gmail.com>
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
index a9dd4ea7467d..a7f5202a4815 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4553,6 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.19.1

