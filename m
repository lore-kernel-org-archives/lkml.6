Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C078C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0824320664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tca/aHQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0824320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJ1XTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 19:19:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46302 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1XTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 19:19:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id c16-v6so6400557qtj.13;
        Sun, 28 Oct 2018 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WRl6Xtt9WakAQ61tKvCn/mS9tfOT27fwr/WQOxrJGs=;
        b=Tca/aHQsl2cAIi/SEANYULnr8QsodCIEdYaPbHZFro7ZpBJevegc3VuYGfx9Fi8+gA
         5K30x93UQfDon2Fi5eoEDg6fnO6Go5D2WlOTEZMNLGVuTAwEiSYB0SqrzTf0yhjSxnPD
         wYxjBxriaiE5Bu+tr0xo2nXtEYdnGmfYOgkGfJEej7XfTgPvZHjkU/2xAyXN88B6oDoS
         7PJy+nMPzZxkBZoJeVFKIriAY8GXLqnd2r2ppew1dVUs8oR2Kj7FTBFlwHejWFJcOy6A
         FYt4k5ZTdMf7hqO0jiQ4W+1CCskb5689p8OFmb2+mVF5A2brLgi9O029paN3qiz/mXFA
         qIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WRl6Xtt9WakAQ61tKvCn/mS9tfOT27fwr/WQOxrJGs=;
        b=DyYUktFoxAcklsXQSNWhojFVWXV3lf+o2DnHmDC1YfxgfW+NUmLQy9T3cqOaBtS5mT
         2nIwN+USyznaekyc4fvuGcKdRxxc/gxU2nJkO5MZdqwYBvHvW+ujxJ5yNAfyJ97gPc5F
         gssz9mU5Yy/qtETB+/PAlEbN4hGXYOSiQHEQk5xX2rxdiGAbDQhWCH/Kga9m0yNTHbrM
         kA+4diBmY2E7xUJmqI/AwepoQ6WvgapxXVy8BJwkgLR35yLyZP+aXNrGXI+nzcRQ5fae
         EGwv02IuAzmGDyuknKu4GH8C+8w1RzOJcQTaEliSonOoRKyQ7+QijJ8PQ5LUeahzSVdc
         k14Q==
X-Gm-Message-State: AGRZ1gJwNui1DpZv/N4PPawOowasotVcO4ooF30/VInVY8X0zVheEjhb
        IDR7Ed5wA6eV5gAsaPpD9ZE0sXlP
X-Google-Smtp-Source: AJdET5enYJWO9XrC2b3xHGVTxF5r66I3HIsTahREzPlHVfdyfn3lmKev98p4ijizH+ICqXSW32ZCng==
X-Received: by 2002:aed:22f0:: with SMTP id q45-v6mr7924738qtc.145.1540737268391;
        Sun, 28 Oct 2018 07:34:28 -0700 (PDT)
Received: from localhost.localdomain ([186.222.90.17])
        by smtp.gmail.com with ESMTPSA id p48-v6sm11266026qtp.48.2018.10.28.07.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 07:34:28 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     hdegoede@redhat.com
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Diego Viola <diego.viola@gmail.com>
Subject: [PATCH] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
Date:   Sun, 28 Oct 2018 11:34:03 -0300
Message-Id: <20181028143403.2285-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

med_power_with_dipm still causes freezes after updating the firmware to
the latest version (DXT04L5Q).

Set model_rev to NULL and blacklist the device.

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6e594644cb1d..a7f5202a4815 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4553,7 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
-	{ "SAMSUNG MZ7TD256HAFV-000L9", "DXT02L5Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.19.1

