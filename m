Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C604C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6F6224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULHvcoQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6F6224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeKMFRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:17:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36039 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:17:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so15355117qkf.3;
        Mon, 12 Nov 2018 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vor4rwES4wcJ4m7V7eE7f89lAffn18z0WIz6HWSWOc8=;
        b=ULHvcoQ8kPHSOoiEz/WXOrBCp6OTOpqkOPEFBfygZzAxPaEg7JIZ+ccthSHQVyspPA
         O+g49XctgxDEKmhZvJl/kYPw9I8A/KSzRZGiTAjZD868Aqww+DHpf7zrIYeJ/Ba0+cm8
         mkm8WCGYa/NR2dbYQ7uNuWeGL3cNrfhlKt+tnMkXzRTlfELS7IHDmLP9mMT7nXUaWOJc
         KnT0TH5yjLMI21o27cOJF8OV74pRbFFHq9EU9sqPddmRbviSRscDcsJzXL+mzLEkpoHB
         BfSKVAcG60VYyexBk4j3RZLwgrmZvgx1/T39U/dPgLFC+spa0Zea/ffyxdsstCXRUVgb
         XuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vor4rwES4wcJ4m7V7eE7f89lAffn18z0WIz6HWSWOc8=;
        b=ZtiMHqUdlH6VjxtD8285rpUDwalc5AHO1Q1OZbhwbwJIhAhOQFwgnuhLlvVUwkQw0A
         N1UpSbcUySUGOF1whyvP8ADEc3WXCSYW2m7XZyikBwCBxTJknfKICLvCkuDdTy0/I+tg
         zu2gA/jLgWQ9cOg9iqImrF5x0v9V0+MPc6Hg7fNqp6PofCNQhTd6gFsf+l4ur7RQkYGQ
         yQ/u0GWmiS1e6FkYlUYAuZOApa1tyQegtqu52qCIskEbB7wadmDt97L2Q2cv3M7jHB9g
         xJhgeu5w9kHCP2+bNYwN/URIeaLPyP7mO75BaeV+8NNhILS5hhXIukPIDyC5+WXHHWdM
         bFJw==
X-Gm-Message-State: AGRZ1gLzEMdenD2eEsPyp1cNSwdK86pphkxP5SRRSdOGpmUWLyu6uY5g
        YSlgQaCCCSdni7bZGBLu2oQ=
X-Google-Smtp-Source: AJdET5e3CvXZ7HBzUcIXOdmg7sCuxFsIGhGnWcm8iQT51TBiKxAWsshHfIuTD4AYp+YDwaanfJl9EA==
X-Received: by 2002:ad4:4312:: with SMTP id c18mr2241375qvs.59.1542050584004;
        Mon, 12 Nov 2018 11:23:04 -0800 (PST)
Received: from localhost.localdomain ([186.222.90.83])
        by smtp.gmail.com with ESMTPSA id e81sm10532740qkh.55.2018.11.12.11.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 11:23:03 -0800 (PST)
From:   Diego Viola <diego.viola@gmail.com>
To:     axboe@kernel.dk
Cc:     hdegoede@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Diego Viola <diego.viola@gmail.com>
Subject: [PATCH RESEND] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
Date:   Mon, 12 Nov 2018 17:22:52 -0200
Message-Id: <20181112192252.3911-1-diego.viola@gmail.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

