Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF14EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865D120842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="L6UV7uhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865D120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeIZUaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:30:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53178 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeIZU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:29:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id l7-v6so2482937wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6GEgMJo7HbdKLlrJg81sd/Zf0U2XQ8tZJ/V/bTDDrzs=;
        b=L6UV7uhZAvXSHMWXKay+k1KVVcRT2PwJfMvC21hxUH9GSzMOIqPGpmYelD7opV8Yd4
         iFpy9ZQlv416kfILPV+dekfDtR9X/Hvm62tJCUWqxocVFDhi38h10jYND65t5Z0oxwkQ
         idRh58Pi9yeNigvIH3EiDSvRTsFXkEGfNEoY6bw6Tj44tRsW0bV+YXy9DwuhtB6Xnocp
         iaQJ/ZdDVhiroQKQGg55PX1uFLOHJdNVn/3MK8Hr3No0+LjRjWElIZ6zdcbFdkPrirPW
         AfZo3aky+9tIoh+9IVYrJBWkLBh2Q1m+TLDvFwv7nHwh/FhAkbKST5YpzK6paGuTf2WW
         LW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6GEgMJo7HbdKLlrJg81sd/Zf0U2XQ8tZJ/V/bTDDrzs=;
        b=Qrv+K+5KBORVI9RgpyZtnoj0zjcBMphQVsr7diGNEsRWVx6xJSFd0dmnhZhWGbY2Zo
         2ojOdON8ZAtseOOfnUs9AuenSyQqipNkXUKT0a9FC5ypb+vM9Fq7QhlUUbBxfVjihzns
         8u4Z1PJoHQsMP0ekVwHukwxrJ2zFDDYHhhoCpzo8jMbsEqNHpBfcRJqLXLLfhnUfV4V9
         VfJGtYbnF0VDq8vzpG5+ruVu7z1wI/wwved8wXHAZf9k23QgbF8pTgIuQ+9nVQfaKPAb
         tPOnEoUvA67X+imT4gcanZtSDZ51j/QBFmlbowu+BpwLSngsakYnzKCy5P04wSJ7yNF3
         +whg==
X-Gm-Message-State: ABuFfoi6TV8VYTSypozDIqcjuPlZuHHWhlX4eQxaxWwbdhMoxvgdsC+J
        s90Sat2nMqYaqf6PET1sPHZl5vrORC0=
X-Google-Smtp-Source: ACcGV62HjRXZBU6kYeR+t4zNUHWB5VCtqdFmZ9BBAD0B6y5C2eIGVk64aQcEzOdea6n4WPpCHmbxYw==
X-Received: by 2002:a1c:88a:: with SMTP id 132-v6mr4772071wmi.9.1537971397936;
        Wed, 26 Sep 2018 07:16:37 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3209974wmh.41.2018.09.26.07.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:16:37 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] lib/scatterlist: Do not leak pages when high-order allocation fails
Date:   Wed, 26 Sep 2018 15:16:23 +0100
Message-Id: <20180926141625.17727-5-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

If a higher-order allocation fails, the existing abort and cleanup path
would consider all segments allocated so far as 0-order page allocations
and would therefore leak memory.

Fix this by cleaning up using sgl_free_n_order which allows the correct
page order to be passed in.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 lib/scatterlist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 3cc01cd82242..0caed79d7291 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -481,7 +481,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 {
 	struct scatterlist *sgl, *sg;
 	struct page *page;
-	unsigned int nent, nalloc;
+	unsigned int nent, nalloc, i;
 	u32 elem_len;
 
 	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
@@ -501,17 +501,19 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 
 	sg_init_table(sgl, nalloc);
 	sg = sgl;
+	i = 0;
 	while (length) {
 		elem_len = min_t(u64, length, PAGE_SIZE << order);
 		page = alloc_pages(gfp, order);
 		if (!page) {
-			sgl_free(sgl);
+			sgl_free_n_order(sgl, i, order);
 			return NULL;
 		}
 
 		sg_set_page(sg, page, elem_len, 0);
 		length -= elem_len;
 		sg = sg_next(sg);
+		i++;
 	}
 	WARN_ONCE(length, "length = %ld\n", length);
 	if (nent_p)
-- 
2.17.1

