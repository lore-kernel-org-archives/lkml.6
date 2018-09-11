Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F05C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BE1206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJX78q9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BE1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeILCpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:45:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50349 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeILCpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:45:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so202467wmc.0;
        Tue, 11 Sep 2018 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JM0R5+gVjcypQAjDUwg1l1B5eVwb7FNurOGLrcF74h4=;
        b=QJX78q9z2lSXrtM+OQL2xLhPmn0EWcH1aaIcjVlpRkGGxP7k4xy9Gqe4rt4atuWRQO
         H0058xXhyPeIaeQORmOcaYpkEa9in2HjhRy0vQRN2qtzSq/QUhujCmYdI8Y6elDZIvMr
         K74yr+vm5UMPeAtkFX+rdCf8W5o88YfKwqrjoGlpTtfNz9x5rbCR7z2wKM42BGMemAkx
         GZZ4ErH7IF07gct2vTnwOjsjwvZYC/ef8BFPu+kcpG9oP3CffO3CQnBSbfo0FMIwNxfy
         V6QSqmm+i5Q2fCQVW2k3RQPHpUl7O29/BICSVARGE8BolpkOJSjmc9Gcdc35QXIHp3Dq
         J9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JM0R5+gVjcypQAjDUwg1l1B5eVwb7FNurOGLrcF74h4=;
        b=WASaJPzqZnl4RmLFqGZ5d3v3/ejG3JWASuFAlyCCzoBgmAE8aIDFOV09wjwCxI/n1r
         D+L3V3/6YGxD9G/h87oXS3EXWyrHoTrJ4c4wTNGpcmid3NxcvyxT+IqtINMXCNdwOvNL
         28mwGSjzBAsEWAUbQrYpydU3+KEdQl90EDs1sSO2Le2cBdLsMgP6JVn9KPOeQnse0hwM
         F+BT6pxfriSNJtnsi/btMfP5F49Omqy28bCYOYUAfR6/KfsAiIEDIhQXRDyhZJ3vHP4I
         g1K/tiE0G7fQa9H6Mv9Dcc2TmKnhMoMdva0nhn0r1XHc30++hEIDIciXtlFXaGThvrZ8
         v/OA==
X-Gm-Message-State: APzg51DZR31IycoyzSu+2OMxX4AEpGfWgJAnUi1wt8gVqUqV2kwyYFDX
        ZAFndLmxDCscOFnZY3gJ4FU=
X-Google-Smtp-Source: ANB0VdZovxB65LsXDSFiGwU8ku+3RKBbpKzQOVpTMuWLUqfdTJzBqyMSYnnF8uiQauMRCAADxCRQlA==
X-Received: by 2002:a1c:68f:: with SMTP id 137-v6mr2704110wmg.82.1536702228105;
        Tue, 11 Sep 2018 14:43:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c9-v6sm18496967wrt.77.2018.09.11.14.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 14:43:47 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pata_atiixp: Remove unnecessary parentheses
Date:   Tue, 11 Sep 2018 14:43:38 -0700
Message-Id: <20180911214338.1109-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when more than one set of parentheses is used for a
single conditional statement:

drivers/ata/pata_atiixp.c:282:19: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
        if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
            ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/ata/pata_atiixp.c:282:19: note: remove extraneous parentheses
around the comparison to silence this warning
        if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
           ~             ^                              ~
drivers/ata/pata_atiixp.c:282:19: note: use '=' to turn this equality
comparison into an assignment
        if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
                         ^~
                         =
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/ata/pata_atiixp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 4d49fd3c927b..843bb200a1ee 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -279,7 +279,7 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	const struct ata_port_info *ppi[] = { &info, &info };
 
 	/* SB600 doesn't have secondary port wired */
-	if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
+	if (pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE)
 		ppi[1] = &ata_dummy_port_info;
 
 	return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
-- 
2.18.0

