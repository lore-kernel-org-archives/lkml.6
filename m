Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93009C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5245F2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mix8fNuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5245F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbeKTDyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:54:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45911 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404375AbeKTDvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so11088294wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyRw+rMzdi1alRfDuiZVB0ZJPKSze4LAdpqwyD2ClBE=;
        b=mix8fNuo76mUcOPQpFGJWa+t7fphMwTFH0Yv/elxeFlZH0rFcGIhZSYZDdFmCW/Yc2
         gdVTJ1G8VrAf3ZTQFOBWXHTHQML1qLB4+ArqqGrvFMpu/52VezVzttvjQGeCn/ppJiAz
         2M36LqSQ0j3VewPVv18rf6O38zK9OStZG8MZbQrOrkxapZyL8dadP1feNdsZh9E4ibWH
         89x1sGZMqHA0DyrvQ1nSWJHqp+wx8b0Yhaml0yUS5oH0Mo3uo7NPWGOy5iePmASMlyX4
         Cx1OsEIjkZD2mMsnpK0cA4AcUmPsh33slFpcSzjdJFEbCyh8yVbEh6cMGs7uDR1BzfR+
         XpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyRw+rMzdi1alRfDuiZVB0ZJPKSze4LAdpqwyD2ClBE=;
        b=K/R0WgwBTPet6si/6hgLsdXDROtXvjbokXAb31++l+a9GiYrlUrUsPo7KsmOo5JtBW
         tY0y0P/O+dtEy5xyk1OPAqioK9En0yNu9hYWN6XIJOZb+AZx4bM6ePiILu6w+mElCyIy
         JHRhbvFRaQvL0biObZ2SA+sSYMFpOoRjhY2iU0lAYBAsC6RLzagD8Aw0jQJoiNImxuI5
         SDSH6Ji3nYqTyofr0UQIhrukdkTnRZuAD8H6LYRqb7wgOcr0HPSWJqRLNGuYKrt/HZO1
         PGUwD8tp0r8kCx5kbnk0DHEOQaK/XAWBeYvu3RpFtVSO7JXom7PFUA7/Q7j1RTlt4yXw
         2mWg==
X-Gm-Message-State: AGRZ1gJGGvgQijncbadZqJMfqzeTC9hmD6letVMPNlCERFXK/0r9h1ya
        vUV9FJQAFlseQyWLsOnG2qbX7w==
X-Google-Smtp-Source: AJdET5ePNjMSgad+LbaZrgUmfsb6OSab/vVHZ5XlZ7W2Ovv+StAw8FD1z8DRCPskgWhsuE36zAqtCg==
X-Received: by 2002:adf:a409:: with SMTP id d9-v6mr19710119wra.190.1542648412325;
        Mon, 19 Nov 2018 09:26:52 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:26:51 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v11 02/24] kasan, slub: handle pointer tags in early_kmem_cache_node_alloc
Date:   Mon, 19 Nov 2018 18:26:18 +0100
Message-Id: <14a68774683e15692615600c47bba53506a1c8ef.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch updated KASAN hooks signatures and their usage in SLAB
and SLUB code, except for the early_kmem_cache_node_alloc function. This
patch handles that function separately, as it requires to reorder some of
the initialization code to correctly propagate a tagged pointer in case a
tag is assigned by kasan_kmalloc.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index fdd4a86aa882..8561a32910dd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3364,16 +3364,16 @@ static void early_kmem_cache_node_alloc(int node)
 
 	n = page->freelist;
 	BUG_ON(!n);
-	page->freelist = get_freepointer(kmem_cache_node, n);
-	page->inuse = 1;
-	page->frozen = 0;
-	kmem_cache_node->node[node] = n;
 #ifdef CONFIG_SLUB_DEBUG
 	init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
 	init_tracking(kmem_cache_node, n);
 #endif
-	kasan_kmalloc(kmem_cache_node, n, sizeof(struct kmem_cache_node),
+	n = kasan_kmalloc(kmem_cache_node, n, sizeof(struct kmem_cache_node),
 		      GFP_KERNEL);
+	page->freelist = get_freepointer(kmem_cache_node, n);
+	page->inuse = 1;
+	page->frozen = 0;
+	kmem_cache_node->node[node] = n;
 	init_kmem_cache_node(n);
 	inc_slabs_node(kmem_cache_node, node, page->objects);
 
-- 
2.19.1.1215.g8438c0b245-goog

