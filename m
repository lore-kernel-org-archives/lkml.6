Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B82C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176E2218FD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNtKfSU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBKWAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:00:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44152 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfBKWAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:00:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id v16so443525wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F0+Fcs0MkZYX4znEMfQAn1VdtYpI07PvV8ScTPU9zPg=;
        b=uNtKfSU0+K7DQuJSpKocOX08Ends+VIaoncwv193IfyXRrFVBQloeekrKLHBO18zJ+
         zgxP0BRQ7dybUbH+vvlFhWtPeIkxhDeFGx8FBjvlB1pP+wWRqrGLu2HYEJOpRkV7GgjH
         BV2TCh/BIeC6nu5Qwb5AAvBUgtIeZ1UmePHyqs0aczpO/b5xxwOtVzf2zPECxG+vAXtI
         USdX46+1WMxKTGo+3PTXad80sHiFx42Ok1No2ZWmb3msF+2NZovofxW8GFu72nSWw2a8
         a4vWaXFgyVh2aXX5PLs6hV9WY5xx9ThkNZJd+fyIYLSzO1/eNL4iNZoyP4biKgrNKM+H
         +Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F0+Fcs0MkZYX4znEMfQAn1VdtYpI07PvV8ScTPU9zPg=;
        b=Y2zF+CVMAdO5GHcS8sx4Eq007BYwYM0E/6soEQXXk9rkPbggrsgYvre+/wn9WFQxGE
         yeBnbo5N3VuPaejPwOUTWyV9LYN6kUMQdPfwp5UPGACoopX9OIs2ZaP18h2U1yHheXAs
         phsVXmZWK4AcXMd58B7HN7rIOn2s/NAfK1iPFYYgh772whrNY6MPH60Vz0XxdfVo61l1
         1TzVNFYPycZjVeDAeuaJsRqoJHLZ4ld5/i4Hs2n1G01TScVMERjltoMjrhjCFwXhJ76H
         1Fk0TmEaqULk4GvZ+kxMe3NQb4a9Tsc8LMM6ewEDMVbRvua9bSh/TrLfVTonRGG+BiAn
         sD2Q==
X-Gm-Message-State: AHQUAubKVEhlzwGIbizYWOzGCFzQuxJsMvBGunsOeTmGWtviZLLWcGyP
        oMEDlqsUf23PluyB9eeMS8WCdQ==
X-Google-Smtp-Source: AHgI3Ib27D4nBRNkQKP/Nr0Yz3dEkA16v3GKdYr81WW50n3+gRxUrezwoWqu+5gij6CSI/XqL3XXBg==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr307497wrp.164.1549922404424;
        Mon, 11 Feb 2019 14:00:04 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id c186sm762685wmf.34.2019.02.11.14.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:00:03 -0800 (PST)
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
Subject: [PATCH 3/5] kmemleak: account for tagged pointers when calculating pointer range
Date:   Mon, 11 Feb 2019 22:59:52 +0100
Message-Id: <df99854703d906040a7a898ac892167e3ffe90d9.1549921721.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <cover.1549921721.git.andreyknvl@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak keeps two global variables, min_addr and max_addr, which store
the range of valid (encountered by kmemleak) pointer values, which it
later uses to speed up pointer lookup when scanning blocks.

With tagged pointers this range will get bigger than it needs to be.
This patch makes kmemleak untag pointers before saving them to min_addr
and max_addr and when performing a lookup.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kmemleak.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index f9d9dc250428..707fa5579f66 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -574,6 +574,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
 	struct rb_node **link, *rb_parent;
+	unsigned long untagged_ptr;
 
 	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
 	if (!object) {
@@ -619,8 +620,9 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 
 	write_lock_irqsave(&kmemleak_lock, flags);
 
-	min_addr = min(min_addr, ptr);
-	max_addr = max(max_addr, ptr + size);
+	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
+	min_addr = min(min_addr, untagged_ptr);
+	max_addr = max(max_addr, untagged_ptr + size);
 	link = &object_tree_root.rb_node;
 	rb_parent = NULL;
 	while (*link) {
@@ -1333,6 +1335,7 @@ static void scan_block(void *_start, void *_end,
 	unsigned long *start = PTR_ALIGN(_start, BYTES_PER_POINTER);
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
+	unsigned long untagged_ptr;
 
 	read_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
@@ -1347,7 +1350,8 @@ static void scan_block(void *_start, void *_end,
 		pointer = *ptr;
 		kasan_enable_current();
 
-		if (pointer < min_addr || pointer >= max_addr)
+		untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
+		if (untagged_ptr < min_addr || untagged_ptr >= max_addr)
 			continue;
 
 		/*
-- 
2.20.1.791.gb4d0f1c61a-goog

