Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35720ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41CC2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unsz2m7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41CC2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeIQSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:07:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46735 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeIQSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:06:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id t19-v6so7352679ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r34qhpxH0RxIu1rEYSTvWFRwfUNJzSPXBr4F6XIkLQI=;
        b=Unsz2m7eokziLqosprLV+63pmy6Z2RtzDh56i49GvLOOqxDRQpyqxnuDtihq5bbpKB
         HBlHDkggsBxTEf921p3Wa5bARDaseIfv8+uIUcFUGfPUdYENuzhE4NvdmDDu8Kc/pP1t
         2U7Fyh/j7WLVTadUBCuUFvpoUzGKTJrv38AH8y8XISaQX+SGLCvkDVhnWRIG5elmJYfp
         Uiq4/ijylBYnchAC0uGMcTFqbOmr9eJ2TI7X2dJBkZIfGvXQNONjk9wMI3q6oreKy1xW
         hIctI9P9soeCVOGGuBb5kJRGLC7PykvWZfF38n7CZYuOU3fBwJjtGsFioCquIUsvEHDS
         D7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r34qhpxH0RxIu1rEYSTvWFRwfUNJzSPXBr4F6XIkLQI=;
        b=swZ9qLpncXkcQSusDnEhYfyiwS5ykpiNC9OQXFzviXDoMKum6StdmVlM/MGPD4AgtR
         r2cLqNI7WdQCsJ2VXaOgHedAcJYEEwG6h2BpuXbitmNymGfHbCkvTU2FkDY11lWc/Eww
         d0BD8xa9tSYqVareiLJgBfrPZ0ZVFd8MMr5jIXAglSSs+575w1SEPNBF3GUNx56Jxj17
         7QLGzku1KW86DsKnQlL+JiHW4fH6U+uZQAX/63KZmpTT++FJ7lceN9e8A9rbKSuWLpmi
         Eo1xUvKdPPMyhlwjk6u6SNJuwSV9lmngB+y90DrIbXd/PTA9nKlk/Ky2Rtp1LOK+Nbvw
         tjOQ==
X-Gm-Message-State: APzg51DhFZaHJi+uAY0M5H4MJAkJUpA6HhMbl/MZQX+zFga8jRQbBWKi
        eg/vhC7sQWN6EILI3+Divtk=
X-Google-Smtp-Source: ANB0VdYXl5nLWzWEc00TVy2AAJFrmMmgrUDGpIBj+VuKnhW3XDCl9eCXWtsEvFH0VMcwnZaI7pZ/ew==
X-Received: by 2002:a17:902:8a90:: with SMTP id p16-v6mr25030215plo.106.1537187989383;
        Mon, 17 Sep 2018 05:39:49 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:48 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/10] staging: gasket: fix data page unmap DMA direction
Date:   Mon, 17 Sep 2018 05:39:00 -0700
Message-Id: <20180917123905.213639-6-toddpoynor@gmail.com>
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

The DMA direction supplied to dma_unmap_page should match the
corresponding dma_map_page call, which is mapped bi-directional.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index e86bdc5fc79d2..8fe27e7d1b53c 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -612,7 +612,7 @@ static void gasket_perform_unmapping(struct gasket_page_table *pg_tbl,
 		if (ptes[i].status == PTE_INUSE) {
 			if (ptes[i].dma_addr) {
 				dma_unmap_page(pg_tbl->device, ptes[i].dma_addr,
-					       PAGE_SIZE, DMA_FROM_DEVICE);
+					       PAGE_SIZE, DMA_BIDIRECTIONAL);
 			}
 			if (gasket_release_page(ptes[i].page))
 				--pg_tbl->num_active_pages;
-- 
2.19.0.397.gdd90340f6a-goog

