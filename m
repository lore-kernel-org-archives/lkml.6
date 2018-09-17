Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7123ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AFA2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua5w4r0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AFA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeIQSG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:06:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33862 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeIQSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:06:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so7380208plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCzvlTeMdOd2LbkbLZDk7mXymXVKm6+U8sq0Lup2Wnk=;
        b=Ua5w4r0tdz+7YE7DRS1OQdZXCqSwKBndq0wei6q74nc2Rb9ip+3XXglXWCxM8veuhy
         M1jJftaucqsRwY3DLmusTx4zo1ILmKYtfAyNvqTw1DuqHJJyLdHdW536yda6YmGuMue4
         hTVo/jFFwDvydgkymiLfnAyTAguACZu10BbCIKz9LIGvoC5a61+005tML2LcVJPutPXQ
         6ATnp1OZ8FbcW40vIISN0fhhugzJm/UTlL/O2lVANbAxWN+WAOOQUV8U4jmgkm1xZQlK
         KAY3F7BXD/UqHLD4wrDiHsh7MXn3VFp5gvfzW0/9GNJhEWlcW1z+Rxtnf2oS8tdIVtHn
         Hrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCzvlTeMdOd2LbkbLZDk7mXymXVKm6+U8sq0Lup2Wnk=;
        b=uY1b3vn4G3t4T+/lUWv/gbJs6lNkfXD4ogugwwtqak30fZcv2VEUQr7f7Zz9e/0EXX
         1wjyvz2Bi5ogZs2cAE6HBrpqSvOP9cSWOVgl79R+zgqCGnQxO+2mM5fpFRP0FxcBTFB1
         vgi19FqSS5v5J0nmYW+ucVfzVOBRRj3Y6OYrLVh/RzWij9GL6ufUGfp9yPIVUk5LnDTv
         bFWGLlE+0QDUkx7nKDONiqpbbor3ea7AIbmO80s/OnJMMG4ExMiLGAug3jD+U/z6gaLC
         STbb1PGOYipgEzYWPWx9YgmhQ8bMWr2+QPlukKs6XTUPb3ByTCCWiTCmKAnAmnVFqb0g
         lg7w==
X-Gm-Message-State: APzg51BDVPr304CWz3E3qR/e4SmLt1T/pgKTpb+c8A2zbsuERMvZI2zw
        RUFuBCm4P4358jPltosLvQQ=
X-Google-Smtp-Source: ANB0VdaLcSXgjB2v5wLttnSsDczFsbf9XxUP74LCg2X1buohq0823UXOKgA4f6O69q+BjYCebFxwnA==
X-Received: by 2002:a17:902:1c5:: with SMTP id b63-v6mr25002735plb.82.1537187988198;
        Mon, 17 Sep 2018 05:39:48 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:47 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/10] staging: gasket: fix DMA direction for extended page tables
Date:   Mon, 17 Sep 2018 05:38:59 -0700
Message-Id: <20180917123905.213639-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917123905.213639-1-toddpoynor@gmail.com>
References: <20180917123905.213639-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Extended page tables should be mapped as DMA_TO_DEVICE, not
bi-directional.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 71b77da2e18ca..e86bdc5fc79d2 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -320,7 +320,7 @@ static void gasket_free_extended_subtable(struct gasket_page_table *pg_tbl,
 
 	if (pte->dma_addr)
 		dma_unmap_page(pg_tbl->device, pte->dma_addr, PAGE_SIZE,
-			       DMA_BIDIRECTIONAL);
+			       DMA_TO_DEVICE);
 
 	vfree(pte->sublevel);
 
@@ -894,7 +894,7 @@ static int gasket_alloc_extended_subtable(struct gasket_page_table *pg_tbl,
 
 	/* Map the page into DMA space. */
 	pte->dma_addr = dma_map_page(pg_tbl->device, pte->page, 0, PAGE_SIZE,
-				     DMA_BIDIRECTIONAL);
+				     DMA_TO_DEVICE);
 
 	/* make the addresses available to the device */
 	dma_addr = (pte->dma_addr + pte->offset) | GASKET_VALID_SLOT_FLAG;
-- 
2.19.0.397.gdd90340f6a-goog

