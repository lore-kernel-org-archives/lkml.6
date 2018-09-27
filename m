Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C33C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C54F216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtiKl/PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C54F216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeI0TZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:25:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43195 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0TZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:25:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id z14-v6so2517374wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNjo57d9FwBVh5nb9Zg8J/24nH2FEt/6+d3R0LK5y5I=;
        b=EtiKl/PZVmN0v9z4Dwqe0q2Xko7xXqpZg3gfKNmpwiVLS65h8ZWvlKr6rUkWRH99DE
         031hjscZ+4e03o6WGnbk4uw8Bei3HJm2yW0yYRBYxdVi6Gef/JypEFzmPo77TUbevvXM
         AXthcdhr0BmCNt8eOGMGsu26+CeTFX3M1xEn3qzD5SoVs63k3cn0OIozhF/ACXMhc0H+
         U1qT7iKr3LEBBcmswco4CeUOEKwpBhcy0UlxE9vK6NlUPPbGfpbdQp4PWZpp99Td+dRD
         wC+ooh0LPrY1O31ZGP2+QP1zpQ6j4+dcY/fgvWGzkxmGhmReul5JflgdrcMSEl+Pbb1L
         J+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNjo57d9FwBVh5nb9Zg8J/24nH2FEt/6+d3R0LK5y5I=;
        b=Wb4xXWrHTHlMIMqUyBu6PIRgNmj6ZyjeXetq260CA+q75OnIUO0EeHvkDkFn8+pDBP
         ZbwGLFCN3MBQUoAg1j65XsBYxQYWGUj1qj1WfmtU7KkltPvpCxDC8nZcM5hZecIfoDJD
         B5Q9OczENMhwJqhbawPxMUhpyeQIqy+ApS7GfonSxQhFjR5rF3Uq8E/vCmw3jZ6yRR6D
         Vcxl/fPrf1q5kAyd2A8AYQjuoMs7B+SjJH85m68j/eAlx9+2vyxeIbjB75HZfzsHZaMf
         1rC1misWWNzlVFy/3ZMzHmIU5mVMf6lmmAiclGYZ9yohNI1p/G/4h4DMWsDiXhgtwmYz
         uLPA==
X-Gm-Message-State: ABuFfojf+kSsCMPsWKgMoWL3RSDAFleXn+2SN0D1HM4T8+tLtUIT6xPG
        +GKC09uqnSLbc+GfwyeC210=
X-Google-Smtp-Source: ACcGV60xter3apYW+OrQwWkGeFfao5/S0UdhJ76xUqfIBXqaWAncSkIZs7r8FDtRjE1BkehbBtilgw==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr8578557wrx.271.1538053630992;
        Thu, 27 Sep 2018 06:07:10 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([2a00:79e0:15:10:8971:4ae9:dd1c:10e])
        by smtp.gmail.com with ESMTPSA id b124-v6sm1602760wmg.47.2018.09.27.06.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 06:07:09 -0700 (PDT)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     cl@linux.com, penberg@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: don't warn about large allocations for slab
Date:   Thu, 27 Sep 2018 15:07:07 +0200
Message-Id: <20180927130707.151239-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

This warning does not seem to be useful. Most of the time it fires when
allocation size depends on syscall arguments. We could add __GFP_NOWARN
to these allocation sites, but having a warning only to suppress it
does not make lots of sense. Moreover, this warnings never fires for
constant-size allocations and never for slub, because there are
additional checks and fallback to kmalloc_large() for large allocations
and kmalloc_large() does not warn. So the warning only fires for
non-constant allocations and only with slab, which is odd to begin with.
The warning leads to episodic unuseful syzbot reports. Remote it.

While we are here also fix the check. We should check against
KMALLOC_MAX_CACHE_SIZE rather than KMALLOC_MAX_SIZE. It all kinda
worked because for slab the constants are the same, and slub always
checks the size against KMALLOC_MAX_CACHE_SIZE before kmalloc_slab().
But if we get there with size > KMALLOC_MAX_CACHE_SIZE anyhow
bad things will happen.

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
 mm/slab_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1f903589980f9..2733bddcfdc0c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1023,10 +1023,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 {
 	unsigned int index;
 
-	if (unlikely(size > KMALLOC_MAX_SIZE)) {
-		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
 		return NULL;
-	}
 
 	if (size <= 192) {
 		if (!size)
-- 
2.19.0.605.g01d371f741-goog

