Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC36C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A5620855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1jB5+j8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A5620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeLJNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:46:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36118 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeLJNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:46:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so10562460wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=LFHGUH5RL5VtstgU5CqFLDysnl26jqPDQZbv8asa4nE=;
        b=1jB5+j8szRiUzGd+ahnvQ9cfNNjM0JhHHy685Zow2FyoqqiGEUj4QTi06pFBJs/gX8
         E4/Cw9OGsVNdYs/iFWm6f+kIAO2AxgEi/hNhf4vpSKwbFX8STxnC9dORnodBmSRxRYx1
         mmm0wsfycCp5HRPeORZ4xVH7umh5Os+KGZUb8UShQjo0dRaAuP/XQT7OdBK2C2scTC0z
         Zzb0rdW5PR352YvxX6ByiZy//RArsuPzaNQLjHUhvq++qpGCF1yr/xmIlQUrm5lXHHXQ
         qla3fN5aqqvA8e9+9KqvJbCjl6uS39OdazXy1wiBXZP0LWngNK2K5GuOP8+5KQkOAxq5
         JayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LFHGUH5RL5VtstgU5CqFLDysnl26jqPDQZbv8asa4nE=;
        b=aP+BwS4+Q8+dV8Ny6Id0HdHCON24P45Ta20Y7SkUKQ0qgHyoxQ4UFpi6wM8a8Ndcry
         ha2TGvXb26CudNBd3IHaVEa78XuKS80Fb3pJR+waHaE1Y6oyLnpDFPNf56Ldp9COK0O0
         hIIQnX45e5veTW25ZorsSchcmwPpntE/4sYDBTbqB6065COnvPFfv5aFfW9vO7XxAFUA
         Jpqw+bMz8zGMEO5Mr76XlLltRDcis4IA0L5LopgBtHt+78N4AIy96ClQHgGAEddxBYCS
         Pkzm4rCDRInpTF/dQ9xY7j1gHa9feDoEqtYTIK6Gv547gUi1Wp9HYvtRwoZlow/APIgI
         mXXA==
X-Gm-Message-State: AA+aEWatn0Dv3SLmoFeWu4ThoP7WZYkxrJQq4cpiAuilTXn/4+1RyZ6+
        L0MNCWZeyYIlGGyyJ9CyI3QLXQ==
X-Google-Smtp-Source: AFSGD/WQiVirw47t/dQgyBXS2JV7tDr3ov9Mc7wsfpYU+vGuE++QIuOYDtylcDToQDee1s6lslMK7g==
X-Received: by 2002:adf:f091:: with SMTP id n17mr9844496wro.292.1544449570380;
        Mon, 10 Dec 2018 05:46:10 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t4sm13169517wrm.6.2018.12.10.05.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 05:46:09 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     axboe@kernel.dk, b.zolnierkie@samsung.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ata: pata_oldpiix: Add missing device ID for INTEL_82371AB
Date:   Mon, 10 Dec 2018 13:46:04 +0000
Message-Id: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When playing with a virtual SPARC machine with qemu, I found that the
IDE emulated device was not probing with the ata/pata_oldpiix driver.
But with the old ide/piix, it was probed.

This is due to this PCI devid was not migrated from the old ide/piix.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/pata_oldpiix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index b9bf78b7d48d..63a964062865 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -249,6 +249,7 @@ static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 
 static const struct pci_device_id oldpiix_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1230), },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82371AB), },
 
 	{ }	/* terminate list */
 };
-- 
2.19.2

