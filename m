Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF35C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A990B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0Cow3Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A990B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeJYSAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:00:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35841 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:00:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id s15-v6so7548123lji.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=RP9WX0lcf21kEhw4xJOYo/rCCLPzKEozfMJGHBeKxJA=;
        b=n0Cow3EbQWr38gbmgHRdD/1pwb3U+WmuFRaj1fhZK+PmLYJQ0C2jUpXpt6zP3PNeqk
         NGgI/lB+MPIGEzT3uxKv2F8oehgoMvtPL/V7nIp3R1MC7ZQQ/IufpOnuCFM50DHHvPp7
         BCN0HTcCcGgJcH58+q9Bszd5ZlHnUcwgY9txWafRwAtcRWI0WtQBADewuvMdVxMyvs9m
         f2NfMNOgH7wIOgU0EqkXwqrsd4Np1XMpfMn8gCwz0dJBMchHJTrBGz2VP/ypSC660qvE
         slJ6VN9QZz1vlEIDMx9B+bh2hGz15BbLvsflffwpNSBxgD+dUlT99ISNxUnyeoI37CR+
         yBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=RP9WX0lcf21kEhw4xJOYo/rCCLPzKEozfMJGHBeKxJA=;
        b=YdwDs1AFiR0Q9e8bAjKL53Od7GNKfDJ0IlNoniD0gL0awdBXVduZOdrv0ZoLnMGyq3
         AX0gZaMOc3ZwMjKLL2XtlyKGdrxDqQg+TuOEBxsMpB2ae4iwzv606zjc+eqYOcHgW0Iy
         Tn5ngvJpAHjChpwaCMCLc1ZIBWaOkP8iR2mrsqHCZRkxCuUPL8vq5jlXEtYhnoaXKrV+
         w1n2k8A6v2m4nHVI01UNvdZGcEt/Sg4cDHjQGegkShF54nOkLm23thFz+Lt/6GFfrhx9
         xQAjgyYevyvGl5syCKFIw72bJMjnggz7UZbeNLeTkZOiLhyTYhTFMB3zRRz9tGSvkug1
         J0nQ==
X-Gm-Message-State: AGRZ1gLO1+Se8ViQA48Mf95LxHlNNlJdElahONga6tVmzN5p7sFQus/S
        f4BNLxFj+TDtXYBxN4JUePAGKJ1z
X-Google-Smtp-Source: AJdET5dJftHSGcy/IZOHtRCQ1KVaDTBtMrnpMf6kJYVAThQkGkfbYgMBvCrWg8qi7lwCgJR5b+726A==
X-Received: by 2002:a2e:9a93:: with SMTP id p19-v6mr682232lji.87.1540459703591;
        Thu, 25 Oct 2018 02:28:23 -0700 (PDT)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id n195-v6sm1170285lfb.26.2018.10.25.02.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 02:28:22 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:28:21 +0200
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] z3fold: encode object length in the handle
Message-Id: <20181025112821.0924423fb9ecc7918896ec2b@gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reclaim and free can race on an object (which is basically ok) but
in order for reclaim to be able to  map "freed" object we need to
encode object length in the handle. handle_to_chunks() is thus
introduced to extract object length from a handle and use it during
mapping of the last object we couldn't correctly map before.

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
---
 mm/z3fold.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 4b366d181f35..86359b565d45 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -99,6 +99,7 @@ struct z3fold_header {
 #define NCHUNKS		((PAGE_SIZE - ZHDR_SIZE_ALIGNED) >> CHUNK_SHIFT)
 
 #define BUDDY_MASK	(0x3)
+#define BUDDY_SHIFT	2
 
 /**
  * struct z3fold_pool - stores metadata for each z3fold pool
@@ -223,8 +224,17 @@ static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
 	unsigned long handle;
 
 	handle = (unsigned long)zhdr;
-	if (bud != HEADLESS)
-		handle += (bud + zhdr->first_num) & BUDDY_MASK;
+	if (bud != HEADLESS) {
+		unsigned short num_chunks = zhdr->first_chunks;
+
+		if (bud == MIDDLE)
+			num_chunks = zhdr->middle_chunks;
+		if (bud == LAST)
+			num_chunks = zhdr->last_chunks;
+
+		handle |= (bud + zhdr->first_num) & BUDDY_MASK;
+		handle |= (num_chunks << BUDDY_SHIFT);
+	}
 	return handle;
 }
 
@@ -234,6 +244,11 @@ static struct z3fold_header *handle_to_z3fold_header(unsigned long handle)
 	return (struct z3fold_header *)(handle & PAGE_MASK);
 }
 
+static unsigned short handle_to_chunks(unsigned long handle)
+{
+	return (handle & ~PAGE_MASK) >> BUDDY_SHIFT;
+}
+
 /*
  * (handle & BUDDY_MASK) < zhdr->first_num is possible in encode_handle
  *  but that doesn't matter. because the masking will result in the
@@ -732,7 +747,6 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 			break;
 		case MIDDLE:
 			zhdr->middle_chunks = 0;
-			zhdr->start_middle = 0;
 			break;
 		case LAST:
 			zhdr->last_chunks = 0;
@@ -746,11 +760,14 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	}
 
 	if (bud == HEADLESS) {
-		spin_lock(&pool->lock);
-		list_del(&page->lru);
-		spin_unlock(&pool->lock);
-		free_z3fold_page(page);
-		atomic64_dec(&pool->pages_nr);
+		/* if a headless page is under reclaim, just leave */
+		if (!test_bit(UNDER_RECLAIM, &page->private)) {
+			spin_lock(&pool->lock);
+			list_del(&page->lru);
+			spin_unlock(&pool->lock);
+			free_z3fold_page(page);
+			atomic64_dec(&pool->pages_nr);
+		}
 		return;
 	}
 
@@ -836,20 +853,24 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		}
 		list_for_each_prev(pos, &pool->lru) {
 			page = list_entry(pos, struct page, lru);
+			zhdr = page_address(page);
 			if (test_bit(PAGE_HEADLESS, &page->private))
-				/* candidate found */
 				break;
 
-			zhdr = page_address(page);
-			if (!z3fold_page_trylock(zhdr))
+			if (!z3fold_page_trylock(zhdr)) {
+				zhdr = NULL;
 				continue; /* can't evict at this point */
+			}
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
-			set_bit(UNDER_RECLAIM, &page->private);
 			break;
 		}
 
+		if (!zhdr)
+			break;
+
+		set_bit(UNDER_RECLAIM, &page->private);
 		list_del_init(&page->lru);
 		spin_unlock(&pool->lock);
 
@@ -898,6 +919,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
 			if (ret == 0) {
 				free_z3fold_page(page);
+				atomic64_dec(&pool->pages_nr);
 				return 0;
 			}
 			spin_lock(&pool->lock);
@@ -964,7 +986,7 @@ static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
 		set_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 		break;
 	case LAST:
-		addr += PAGE_SIZE - (zhdr->last_chunks << CHUNK_SHIFT);
+		addr += PAGE_SIZE - (handle_to_chunks(handle) << CHUNK_SHIFT);
 		break;
 	default:
 		pr_err("unknown buddy id %d\n", buddy);
-- 
2.11.0
