Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F2FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B9B218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecNB/AWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBKWAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:00:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50896 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBKWAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:00:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so848751wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btZJYBzt9vwgeXYpITL7uF1uBvgohSdy08HPUQnLqO0=;
        b=ecNB/AWi4z4l8AQ/we8wnm6SjWCcMGvpTpyc2v3pJeyC298tLkxxD+qZ+Dc4FG3rj9
         Is7o1YdjBZrw6wO7CC7sUPKmkF79J3SHPlM3cJuQIw3hapgPTfRqb3QmGNoHjpGNjd2a
         E5VB0Rr0IZCVZaefBRWqvksJUlJXSXnPTRrusgyT3iE0cM+0VImSK8Lo0JsnRB3OamDC
         DDWqXeWHiRXE+x+w+BJtw0Q7swK1uB+cQ0Z7KgYBnMNv8POPkCjGRZ7w+YzkfIllkThW
         hppiMFeEeGWSNvgHGToS/XafOlG4jTCytop5hi0mhlxw4WfxKE/YotFjBPiUY7IJJiXe
         2DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btZJYBzt9vwgeXYpITL7uF1uBvgohSdy08HPUQnLqO0=;
        b=NNbuYNmivJVjsG4wD72dTZzdMhzoE5Gvs/D90yhGprcHtpBSR/BYh0oI32AnwUo1hU
         u/42XBrPIx+rX7EpNGfG9MglR3vWBGuqeaHWXIbiOKXla8qex8LrxeFoGwedIJ016as8
         xzp3ojYonOb958GFyNsosTctqo/oEp9hP4rx7adZfkSVjnu+t9BAsmJTDH4i1Bq/bQGV
         EDdOAtpLBFA2TPMusmekEIPwNu6ia0/FsCUFSuQRctX+sdS4DctWWPHofAMBNNhzukXW
         hUUeIE1PX2xPFRI592OnR1eJaN/yjqVlVZ23jWnSiAPf3uxwgnyyWgKeeSLQO2eNpTnA
         Dw7A==
X-Gm-Message-State: AHQUAuZUbQWp1nG1u8RHkoyWXEsfRqSFC7mkmxDheG1Flfy+AiNv2nVT
        b/DNb1YU6CQlNTxm4CitORRsXg==
X-Google-Smtp-Source: AHgI3Ibt/OjbLqwefA76DBGGG/kA1FhuGgmWovyjKZmYdbeOvuJB1FGXQZ8bX9M3I7w4XDLhekXwKw==
X-Received: by 2002:a1c:ce8a:: with SMTP id e132mr302513wmg.12.1549922406276;
        Mon, 11 Feb 2019 14:00:06 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id c186sm762685wmf.34.2019.02.11.14.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:00:05 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 4/5] kasan, slub: move kasan_poison_slab hook before page_address
Date:   Mon, 11 Feb 2019 22:59:53 +0100
Message-Id: <cd895d627465a3f1c712647072d17f10883be2a1.1549921721.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <cover.1549921721.git.andreyknvl@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With tag based KASAN page_address() looks at the page flags to see
whether the resulting pointer needs to have a tag set. Since we don't
want to set a tag when page_address() is called on SLAB pages, we call
page_kasan_tag_reset() in kasan_poison_slab(). However in allocate_slab()
page_address() is called before kasan_poison_slab(). Fix it by changing
the order.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4a3d7686902f..ce874a5c9ee7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1642,12 +1642,15 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (page_is_pfmemalloc(page))
 		SetPageSlabPfmemalloc(page);
 
+	kasan_poison_slab(page);
+
 	start = page_address(page);
 
-	if (unlikely(s->flags & SLAB_POISON))
+	if (unlikely(s->flags & SLAB_POISON)) {
+		metadata_access_enable();
 		memset(start, POISON_INUSE, PAGE_SIZE << order);
-
-	kasan_poison_slab(page);
+		metadata_access_disable();
+	}
 
 	shuffle = shuffle_freelist(s, page);
 
-- 
2.20.1.791.gb4d0f1c61a-goog

