Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2548C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61D320652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoU11oLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61D320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJOMnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34175 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeJOMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so3270246pfe.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2KqGyo/mOZMyrX13adrsdQv5fqYOxgftTRTZklnxnA=;
        b=AoU11oLAObPA6U/KGjiPBg1n1xuhZ95vwthJW35/Jw9hPA0jaKReuEsOv9dW8GDjsO
         8wfHghV+wm3aIhWudhLf57ON5KWIVL81HXzcbk/LlXP2XpMYQw+XrjhnAkGGncouPcIY
         WznsSrUfJbsWif4KXBatQcpw4wHuwCaP0q0vjRPdMODL8t5a2OhB7qxcj8bpG09kAm/H
         EXIzSmVxAg31pgkzVxHc+dZiGXbgZ4++n1K6J08gGC5KoUcGibMYGoXhe3k7s4PuMWYq
         b6Qfba2dnmpNddQJfA+yHjZ6dWrA9P2amhrzL3MXzbZN1FP74PqaUYfrFjslUQSEXkWm
         jpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2KqGyo/mOZMyrX13adrsdQv5fqYOxgftTRTZklnxnA=;
        b=aKlJiQySx1Gx5I3WxF8JjOB+8tGXHn7oFE7mKLMgDAvmHhi1Iq3HOUGWCKzJGouJ9r
         ddjqUXJvt3/3kbaruKNkqYT6MNdlJO4EHCjbHZc2g2rzYParRaXb09relYkj6p+V9He7
         tA5tL0Ui7y0erDlT1Za+u20d7Q+Ybv3R1a2SYCiOhIP2QuE6eCjXzGMHiXG45EcdqCZY
         ZwAQVnWT9ESA/yxr3pMKWA4k3A57LtSOxEGrHQ227E54h9swVerSColVzHd8p3FuJvEx
         ARtBt61oUDE5yFvSIBw9iZqfRTUkAqpQIE4vC6Ze1GZTWw0M+QK1xRJrp5ZAonTe0mAl
         Fxvg==
X-Gm-Message-State: ABuFfojjPMTxI/JL9X6gjSoI5rmXk9l3yl9sLAzIkaov7PxnBcXmCBQ6
        9ncWPu01AJ9qw1QPwZ3KP4E=
X-Google-Smtp-Source: ACcGV61EzetHVbiEolFrv66vyeEUjWaWZZuFG60hGoC/muh5sTNJniKH1ppYph/L4SkabmF8Gpmrrw==
X-Received: by 2002:a62:85cb:: with SMTP id m72-v6mr15966455pfk.173.1539579598318;
        Sun, 14 Oct 2018 21:59:58 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.21.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 21:59:57 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/11] staging: gasket: page table: remove dead code in coherent mem alloc
Date:   Sun, 14 Oct 2018 21:59:19 -0700
Message-Id: <20181015045927.156790-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_alloc_coherent_memory() has some unnecessary code related to out
of memory checking that will never hit the condition checked, remove.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 2e1de8ad4a2c6..985a3a93499d5 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1316,7 +1316,6 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 			GFP_KERNEL);
 	if (!gasket_dev->page_table[index]->coherent_pages)
 		goto nomem;
-	*dma_address = 0;
 
 	gasket_dev->coherent_buffer.length_bytes =
 		PAGE_SIZE * (num_pages);
@@ -1331,15 +1330,12 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 			(u64)mem + j * PAGE_SIZE;
 	}
 
-	if (*dma_address == 0)
-		goto nomem;
 	return 0;
 
 nomem:
-	if (mem) {
+	if (mem)
 		dma_free_coherent(gasket_get_device(gasket_dev),
 				  num_pages * PAGE_SIZE, mem, handle);
-	}
 
 	kfree(gasket_dev->page_table[index]->coherent_pages);
 	gasket_dev->page_table[index]->coherent_pages = NULL;
-- 
2.19.0.605.g01d371f741-goog

