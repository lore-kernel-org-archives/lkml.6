Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC3FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344DA2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="njblqrpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344DA2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935575AbeFRRuh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:50:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41037 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbeFRRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:50:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so7920527ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Waj6nveM4ax2F8JqJ2yA8+qMPkX7UNuuZ03siNXK1YQ=;
        b=njblqrpq24n2U75s0pge/zJn4sigdI890Aqf5REkzvrYPRW+E5Pf+BCsd3K471fCX3
         0Hg1vpPTXzwp5Ta2Hdj6652U/urw6WW98wMMLWEN+ahoUFiUCb/0M7NQmDHNtbaHOLyJ
         fTK06Oqd/FP+W3qwVQFmD01WOVTDJZLSc3HVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Waj6nveM4ax2F8JqJ2yA8+qMPkX7UNuuZ03siNXK1YQ=;
        b=Rbs+PegKJMYe8jJ4rc0c/U3gAkz+DJyyV0dQz3erF8XUK3UMRqwLQGDi30yaUqDlyf
         pzwwI+3zesYUzZXILjo6tWm0KC7kkhh0TV625ylxjuLtVoUPiorrm0vMHmLe2wWOhg4I
         5nuNOri+j/BMhceIQ2RoVLyhiTUqF+rCANYJyQZADDr1wgxMSRVGJxsiQVwudlPcfDjd
         GXbgmJvq9nXADrKmH1EP/UGaZu8ljFngqf1rZz168+X7ZBvymqROzeePCOgVwq5Nk9jy
         g/V5oS4Jp3vWummZkg1RehFie5DRv0/1IIzDhl2RXRFfI4DzMeEc6mFdW5yyXPoe6rB6
         7SiA==
X-Gm-Message-State: APt69E28n3O1FdDLc1gblyGYJf2+/MakFZmtIIFmftNUhRe1Rw7YIU74
        fLAJS5c3+CPaxGN09fgzxCLEfA==
X-Google-Smtp-Source: ADUXVKKicXduDcwtsvT+Qoob/NwqZEyjd8KAEU3Hb5kYo0E18IISH3YNeCKHgxWC2gtNim/9j2vQUA==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3-v6mr14955507plb.211.1529344235575;
        Mon, 18 Jun 2018 10:50:35 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s14-v6sm22653870pfh.116.2018.06.18.10.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 10:50:34 -0700 (PDT)
Date:   Mon, 18 Jun 2018 10:50:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: [PATCH] dm: writecache: Use 2-factor allocator arguments
Message-ID: <20180618175033.GA2627@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adjusts the allocator calls to use the 2-factor argument style, as
already done treewide for better defense against allocator overflows.
Additionally adjusts style nit to avoid assignments in test expressions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-writecache.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5961c7794ef3..7773f4c75701 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -259,7 +259,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 	if (da != p) {
 		long i;
 		wc->memory_map = NULL;
-		pages = kvmalloc(p * sizeof(struct page *), GFP_KERNEL);
+		pages = kvmalloc_array(p, sizeof(struct page *), GFP_KERNEL);
 		if (!pages) {
 			r = -ENOMEM;
 			goto err2;
@@ -859,7 +859,8 @@ static int writecache_alloc_entries(struct dm_writecache *wc)
 
 	if (wc->entries)
 		return 0;
-	wc->entries = vmalloc(sizeof(struct wc_entry) * wc->n_blocks);
+	wc->entries = vmalloc(array_size(sizeof(struct wc_entry),
+					 wc->n_blocks));
 	if (!wc->entries)
 		return -ENOMEM;
 	for (b = 0; b < wc->n_blocks; b++) {
@@ -1480,10 +1481,13 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 		bio_set_dev(&wb->bio, wc->dev->bdev);
 		wb->bio.bi_iter.bi_sector = read_original_sector(wc, e);
 		wb->page_offset = PAGE_SIZE;
-		if (max_pages <= WB_LIST_INLINE ||
-		    unlikely(!(wb->wc_list = kmalloc(max_pages * sizeof(struct wc_entry *),
-						     GFP_NOIO | __GFP_NORETRY |
-						     __GFP_NOMEMALLOC | __GFP_NOWARN)))) {
+		if (max_pages > WB_LIST_INLINE)
+			wb->wc_list = kmalloc_array(max_pages,
+						    sizeof(struct wc_entry *),
+						    GFP_NOIO | __GFP_NORETRY |
+						    __GFP_NOMEMALLOC |
+						    __GFP_NOWARN);
+		if (max_pages <= WB_LIST_INLINE || !wb->wc_list) {
 			wb->wc_list = wb->wc_list_inline;
 			max_pages = WB_LIST_INLINE;
 		}
-- 
2.17.0


-- 
Kees Cook
Pixel Security
