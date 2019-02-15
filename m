Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3316C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3EE222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNuDOMtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404521AbfBOWoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:44:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38102 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfBOWoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:44:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so5501899pfi.5;
        Fri, 15 Feb 2019 14:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fS5mmi3aRfTJ9ZPKh6Kon1+z1mp8jA2r8sJju4C3jM0=;
        b=vNuDOMtkrRDcjIvM34cWSAhjWi7DaxwrterHweE+q54fWc02gttbQplAgtkMGyNr6v
         I5pndMGUmeOkbofpoyaC97EwN9KzR1zRBpflpPCI4ARgg0U/hKqTN5fW/AAaVda5cPfZ
         b84zF7FusWmjRjReR0vFfP4DUVPL+NOQrm11mSwHc0lMmzzBlO5rVR3JbrZBzQYP4z9Z
         pSnur8hx54zXmmXBWSlybPJts2l7U/YLOxfeYgjVP7MN/Z3tg0kQXzf12oKaS5gBGVfi
         5dHYwYCUulJb8mFugGLJFCLbloov8VTOs3L5D93afRafxF7f6CmjDrdfK1wGeEMjcNL0
         7o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fS5mmi3aRfTJ9ZPKh6Kon1+z1mp8jA2r8sJju4C3jM0=;
        b=JENf4tWcDx6RyleXtkKJMFWp5P41lJvUtuuVrq+PI+wE76DaIoIFQRG2U1djDmez8m
         ftUnxvCZNCWGvsFwY5/+a9G5GVjhae79omD1vghgwbMFe9avM3IpAo5zcjkYrKTRjDk3
         MeW/V7qv8nSKAfACeTGv2dD7fHGNrKcB8mA+BKzfi2lm3VVKFYig9dlYtOm5A8tGt/e9
         8y3xaV2RQjBVS+tR7WK2tvupG8JDGZc54GJeyDgum55wW5tRmi9xJAFtjD64BTz+7wFp
         C6Bb+mYkXlBVGRKOmU8jRHnMZnzQAsnNQkZR//RJnoL5qJLyxm0vjclJs0sgCSEMeccw
         15Hg==
X-Gm-Message-State: AHQUAuYJCJRvNzIZKblr1lW/a9u8iY2qM2nA4a/34HlqVoW1fw3EIHmR
        61RihBkRRm7V6q4SmL3Xbcm2Bi7z
X-Google-Smtp-Source: AHgI3IYkBCGWWOk/DvbdZfHFtmtakVD4J0yB5p0EAn9j1LbuYjzDRQBwv3wF7ASJB+gqPc/s6VK9MA==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr7720172pgv.438.1550270653333;
        Fri, 15 Feb 2019 14:44:13 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 10sm11721400pfq.146.2019.02.15.14.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:44:12 -0800 (PST)
Subject: [net PATCH 1/2] mm: Use fixed constant in page_frag_alloc instead
 of size + 1
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, jannh@google.com
Date:   Fri, 15 Feb 2019 14:44:12 -0800
Message-ID: <20190215224412.16881.89296.stgit@localhost.localdomain>
In-Reply-To: <20190215223741.16881.84864.stgit@localhost.localdomain>
References: <20190215223741.16881.84864.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

This patch replaces the size + 1 value introduced with the recent fix for 1
byte allocs with a constant value.

The idea here is to reduce code overhead as the previous logic would have
to read size into a register, then increment it, and write it back to
whatever field was being used. By using a constant we can avoid those
memory reads and arithmetic operations in favor of just encoding the
maximum value into the operation itself.

Fixes: 2c2ade81741c ("mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/page_alloc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ebb35e4d0d90..37ed14ad0b59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4857,11 +4857,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
-		page_ref_add(page, size);
+		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = size + 1;
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = size;
 	}
 
@@ -4877,10 +4877,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		size = nc->size;
 #endif
 		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, size + 1);
+		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = size + 1;
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		offset = size - fragsz;
 	}
 

