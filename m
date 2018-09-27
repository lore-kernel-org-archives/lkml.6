Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF04EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872DF2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeQx/uVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872DF2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeI0Xea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:34:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39452 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeI0Xe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:34:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so3459908wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCgBSKSsIa//JdAe43K3SdSgLAs8nAIxIpDtbL584wM=;
        b=OeQx/uVD3E7x6LfLTd1Scvz0DQjZite+7lJJZu5H6ICJ1j0yG+BCL3r47Vk+jzo55H
         urX8IfXPifTJfSsnCDDny+6lI9eDHmqvC8IiEDyOxK+plPWAiauL+Qsy2cimWQhWjdbE
         cVAFdJ2pnB18yxFlGI8vQ47OKYw/qhIX5POCJwBRdDuYKaOOq1gfuW1+qo1H21NLL3/I
         TntgejgpyGvginBXruzLz5j+pTnzpaKbOuakTDTGk0hsEieBJmWURgvHgJgYhrSiDU2w
         S0GYMo9a0F6/wo/7sLV6eqZNz8QYRSBgMt9eDdWaRnr8+nFng69q6l80nMhE20xYg8n1
         pfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCgBSKSsIa//JdAe43K3SdSgLAs8nAIxIpDtbL584wM=;
        b=KAtwo4fVkJ7dw9Cv3+VY7L0kOlkfC5NTufZtCwDiQPSRnQ+7LR99M1WqT3hDfRTxaF
         gGuHFrakuX2LpnTbtNxlnv2a53CmuIXKQ7CvF7jrXDwi2wA33kTehfbEcAexUb7U5+MH
         AGuVh2M8Bjz50RRbqJVAQxKXJqQ7uVkFiKeew/Rxyxn/XBPot0Q+lSVCwpyOkbn7mapr
         TUtGCe+xayKQNtuZBF0MwdSekEKUkNzjUmon5QcVlm9HEBt2JuavMGUDaKBzwL1fLWk8
         /kdASt9wYFNiR7VDvR/2u+jcOZq3g0288cplgkwZl8x9BPwmd9yGcs0qJaaoTVZtoq9c
         e91Q==
X-Gm-Message-State: ABuFfoiXL0Ie7BUiBYCZ7C9AfpZIWiI0h5ISTW/uLGHbSmGdRRpMHpmU
        yyq1e/m2vxF6M1FiZwJQJf0=
X-Google-Smtp-Source: ACcGV623OVAhbK3CCUABvgcFX6BuzpSUKSeneJlkVcehYtIEQMbjfFT2XTpYDs+HfssVn+nr05oQkA==
X-Received: by 2002:adf:8024:: with SMTP id 33-v6mr9552998wrk.16.1538068512162;
        Thu, 27 Sep 2018 10:15:12 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([2a00:79e0:15:10:8971:4ae9:dd1c:10e])
        by smtp.gmail.com with ESMTPSA id p9-v6sm1648812wmc.37.2018.09.27.10.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:15:11 -0700 (PDT)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     cl@linux.com, penberg@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: don't warn about large allocations for slab
Date:   Thu, 27 Sep 2018 19:15:02 +0200
Message-Id: <20180927171502.226522-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

Slub does not call kmalloc_slab() for sizes > KMALLOC_MAX_CACHE_SIZE,
instead it falls back to kmalloc_large().
For slab KMALLOC_MAX_CACHE_SIZE == KMALLOC_MAX_SIZE and it calls
kmalloc_slab() for all allocations relying on NULL return value
for over-sized allocations.
This inconsistency leads to unwanted warnings from kmalloc_slab()
for over-sized allocations for slab. Returning NULL for failed
allocations is the expected behavior.

Make slub and slab code consistent by checking size >
KMALLOC_MAX_CACHE_SIZE in slab before calling kmalloc_slab().

While we are here also fix the check in kmalloc_slab().
We should check against KMALLOC_MAX_CACHE_SIZE rather than
KMALLOC_MAX_SIZE. It all kinda worked because for slab the
constants are the same, and slub always checks the size against
KMALLOC_MAX_CACHE_SIZE before kmalloc_slab().
But if we get there with size > KMALLOC_MAX_CACHE_SIZE anyhow
bad things will happen. For example, in case of a newly introduced
bug in slub code.

Also move the check in kmalloc_slab() from function entry
to the size > 192 case. This partially compensates for the additional
check in slab code and makes slub code a bit faster
(at least theoretically).

Also drop __GFP_NOWARN in the warning check.
This warning means a bug in slab code itself,
user-passed flags have nothing to do with it.

Nothing of this affects slob.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reported-by: syzbot+87829a10073277282ad1@syzkaller.appspotmail.com
Reported-by: syzbot+ef4e8fc3a06e9019bb40@syzkaller.appspotmail.com
Reported-by: syzbot+6e438f4036df52cbb863@syzkaller.appspotmail.com
Reported-by: syzbot+8574471d8734457d98aa@syzkaller.appspotmail.com
Reported-by: syzbot+af1504df0807a083dbd9@syzkaller.appspotmail.com

---

Changes since v1:
 - everything has changed, re-review
---
 mm/slab.c        |  4 ++++
 mm/slab_common.c | 12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 9515798f37b2d..2a5654bb3b3ff 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3675,6 +3675,8 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 	struct kmem_cache *cachep;
 	void *ret;
 
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return NULL;
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
@@ -3710,6 +3712,8 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 	struct kmem_cache *cachep;
 	void *ret;
 
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return NULL;
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1f903589980f9..7eb8dc136c1cb 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1023,18 +1023,18 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 {
 	unsigned int index;
 
-	if (unlikely(size > KMALLOC_MAX_SIZE)) {
-		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
-		return NULL;
-	}
-
 	if (size <= 192) {
 		if (!size)
 			return ZERO_SIZE_PTR;
 
 		index = size_index[size_index_elem(size)];
-	} else
+	} else {
+		if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
+			WARN_ON(1);
+			return NULL;
+		}
 		index = fls(size - 1);
+	}
 
 	return kmalloc_caches[kmalloc_type(flags)][index];
 }
-- 
2.19.0.605.g01d371f741-goog

