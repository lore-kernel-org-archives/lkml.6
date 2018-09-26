Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE2AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138CC20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="1NsT40MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138CC20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIZU3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:29:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51429 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbeIZU3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:29:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id y25-v6so2479465wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1+bo5O8T40FfJUYsURod6BioWaVULXwsUyWLXWcB9k=;
        b=1NsT40MSTmFt1TYps7FaFSQMxNTC+F86Q9q8r4PBEmQKpT1WZMmLR8ibsE9OPM40fm
         eAZjgCzgirPgjpMuXbfrBzIpFZx8Ywcu/RCA5q2TGEpVcy/NJawtHkxp/qIdiKew/u2r
         S1gczJF4W0ssFwTzsAw7U/fqCrvks+WB8b6FehHqLqvsQRyRfwpEtW3xdI0zriprpmD8
         e2OCd57pTZ14GDQVbVljpZV9EASeb2Mcq7kw+5On7yorH2Bc6hoYWbUByFY1Y8jnbGT7
         F4hqCyLoWHN9e+OZ6mji1a4qDtlyn3NqhCWec3RlHrQbTveJi5eTJRwL/9AHTnovayBp
         QL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1+bo5O8T40FfJUYsURod6BioWaVULXwsUyWLXWcB9k=;
        b=AJhjqyViVJ/sw/1o9try6o3IBgAugq+R9jCSJsaonzmPUynZlKnpK3PzPRZF4tpLQl
         ZM6YSUMq2/7xfRBp0GfUzggRbQxB4Mj0PZKZmC4oTYDoukYU7isRa3sGhM15ZJViNaRo
         2kfi/P3Gqn6hCc1n1+qng1amaKEatIIBMrljUzhJRQP2ZmBzC0Wglcx9IQhratkhgaDL
         B0bKEBuem6LgmqswObEAJ3bHxQhmtLWBnixcHn2SKpicubGEgw8aaXQGC7pgCZLZrzpi
         lMbY0gSSh7qqFKjjQiQMH47tgiThIflRXAgI5NPz1d6dRrqIhqJlWI47H/NvSXFkLeh2
         ezeQ==
X-Gm-Message-State: ABuFfojreR6wY0xCAq//jOIAPAuLm6x0J7jf8DydlZWRVCwaHF43SbYn
        L3+5oq5LZr9hCpAI4xvh7Lm/I6YXITk=
X-Google-Smtp-Source: ACcGV623AzCzSylvCtYlfcSCl33GR7VBiFm/xWCXVNnBo6UPda9DOu2bDOKLTz4S8IxK2zhRmyLhow==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr4323845wmf.114.1537971398888;
        Wed, 26 Sep 2018 07:16:38 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3209974wmh.41.2018.09.26.07.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:16:38 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] lib/scatterlist: Use appropriate type for elem_len in sgl_alloc_order
Date:   Wed, 26 Sep 2018 15:16:24 +0100
Message-Id: <20180926141625.17727-6-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

We should not use an explicit width u32 for elem_len but unsinged int to
match the underlying type in struct scatterlist.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 lib/scatterlist.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 0caed79d7291..581a2e91e515 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -481,8 +481,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 {
 	struct scatterlist *sgl, *sg;
 	struct page *page;
-	unsigned int nent, nalloc, i;
-	u32 elem_len;
+	unsigned int nent, nalloc, elem_len, i;
 
 	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
 	/* Check for integer overflow */
@@ -503,7 +502,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 	sg = sgl;
 	i = 0;
 	while (length) {
-		elem_len = min_t(u64, length, PAGE_SIZE << order);
+		elem_len = min_t(unsigned long, length, PAGE_SIZE << order);
 		page = alloc_pages(gfp, order);
 		if (!page) {
 			sgl_free_n_order(sgl, i, order);
-- 
2.17.1

