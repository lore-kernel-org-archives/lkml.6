Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ECEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8BB223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoOOy+py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8BB223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeHJFt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHJFt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so3815926pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNmYLqAxTb3jeW0Q6N6Ne0QZTGyVHkNhmPFxBrYsNj0=;
        b=IoOOy+pypujUuhhIsSn/x4pWAF+qllGoGcP+NyGiZ8HpgQXluX8sczlKn1+EfQx+jK
         JzqxUSJ+ky5NXzxX1Y+yrw2UFPQR56BmdQRxBblGh8tas04WNP5z+rvaQuyV/9zQLX5f
         ikBR0TvI2RciKhGa6y0r3XCfv1yGDiKqkg5Tg/brPHse6gP54CDc8uRUE455v9BsXS6a
         yHMJ94qyur6SQ/e9q7FL9++ee6goJsRi2ZXa6JFhELeW2xh/o/g71EXF3QHKOALHQMTh
         N5zgiBaUjaKC3EHXkui6PlhDo9tStMymxf//EwPzPLmHAyH7HKqyxo6l8UTghl9MlH3p
         L5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNmYLqAxTb3jeW0Q6N6Ne0QZTGyVHkNhmPFxBrYsNj0=;
        b=I+GbCqwYbcny8iQdQpgDdIwGNgcEio/nZamODhgqKaTL9z5tqxAN7VchCd8Iu7DLwb
         P6Z0t1bgPWp36w+HGxkH4hXYsxQZjJ3Uw+jvBKnjGfOYTvRv0DO+9MoNiUMhcEHf4kvR
         3uE3IAQrA8Qn+lfJnCLWAjHhYvriOw2LyCn0hud23WJMoYNmGtE5UVUDhn2DybgrRd9m
         yg8Iuf3ZhUR+vXjUL8SgDetb3Zf6hS64LmTZcSqwhkQGC/uXxExywumv9LZTXoi+tXDJ
         H8medqCTNr0cBv38vP0eLFDXKTKaN47On4HbPTYOFo97Ka0lNEPaBaS90VNFE62nDiYO
         C2zw==
X-Gm-Message-State: AOUpUlFIaKuaNaQ48saK8d4Nx0H5EVyPCQuaOrk4AdJ3I+kV5lpBz0XK
        DA/NA8VpI6fa/8Qkyn8yk18=
X-Google-Smtp-Source: AA+uWPw3X73GWn/1EviGnl1E0xRg5wfXqOo7ZPb6IcAnTguhvRvVG+NeDe0Xe2YN1SwxZS9TwjBgig==
X-Received: by 2002:a62:d544:: with SMTP id d65-v6mr4995656pfg.107.1533871293181;
        Thu, 09 Aug 2018 20:21:33 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:32 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 10/16] staging: gasket: page table: remove extraneous memory barriers
Date:   Thu,  9 Aug 2018 20:21:05 -0700
Message-Id: <20180810032111.197743-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Some explicit memory barriers in the page table code are not necessary,
either because:

(a) The barrier follows a non-relaxed MMIO access that already performs
a read or write memory barrier.

(b) The barrier follows DMA API calls for which the device-visible
effects of IOMMU programming are guaranteed to be flushed to the IOMMU
prior to the call returning, and doesn't need to sync with normal memory
access.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 4d2499269499b..53492f4fad6aa 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -317,8 +317,6 @@ static void gasket_free_extended_subtable(struct gasket_page_table *pg_tbl,
 
 	/* Release the page table from the device */
 	writeq(0, slot);
-	/* Force sync around the address release. */
-	mb();
 
 	if (pte->dma_addr)
 		dma_unmap_page(pg_tbl->device, pte->dma_addr, PAGE_SIZE,
@@ -504,8 +502,6 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 					(void *)page_to_phys(page));
 				return -1;
 			}
-			/* Wait until the page is mapped. */
-			mb();
 		}
 
 		/* Make the DMA-space address available to the device. */
@@ -604,12 +600,13 @@ static void gasket_perform_unmapping(struct gasket_page_table *pg_tbl,
 	 */
 	for (i = 0; i < num_pages; i++) {
 		/* release the address from the device, */
-		if (is_simple_mapping || ptes[i].status == PTE_INUSE)
+		if (is_simple_mapping || ptes[i].status == PTE_INUSE) {
 			writeq(0, &slots[i]);
-		else
+		} else {
 			((u64 __force *)slots)[i] = 0;
-		/* Force sync around the address release. */
-		mb();
+			/* sync above PTE update before updating mappings */
+			wmb();
+		}
 
 		/* release the address from the driver, */
 		if (ptes[i].status == PTE_INUSE) {
@@ -898,8 +895,6 @@ static int gasket_alloc_extended_subtable(struct gasket_page_table *pg_tbl,
 	/* Map the page into DMA space. */
 	pte->dma_addr = dma_map_page(pg_tbl->device, pte->page, 0, PAGE_SIZE,
 				     DMA_BIDIRECTIONAL);
-	/* Wait until the page is mapped. */
-	mb();
 
 	/* make the addresses available to the device */
 	dma_addr = (pte->dma_addr + pte->offset) | GASKET_VALID_SLOT_FLAG;
-- 
2.18.0.597.ga71716f1ad-goog

