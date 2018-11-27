Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80935C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C8220828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKhKOY0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C8220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbeK1DyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:54:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51748 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeK1DyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:54:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id j207so15503770wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oli7mrp3g3rho/Q8+rQCYCaCVtzysg9eZI+aaASr7k=;
        b=aKhKOY0OenSL2Quk581daGUh2I4SrPb/lcGdloHjtGv3j0n+5niFdy9ol4BcCBQ7ks
         62cBb14ijs9os54D4xWD8JNgz79PmXwjxifzFhWrEpNSlggyZ5NU2DESqPbG4cUfrzZK
         +7Wp5K21Hs+NeLhTYqsmNPpDvO2OCfjxPuncqcytdoDMYnVJn5y5jI8t2/rZUVjVp9ls
         LbG/My2qhXCzylS+TNZHQ5emt4LmdEcjeI1SmnN3HnBF6cHDho2vC4Tnn4KpNxa+PKT8
         9UfKSfQcm+YNGouv2+PZMimvKBXCp9DADxnrFIFJy7bVnUX4aWQFUZfh9p133A9kQ4MT
         c0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oli7mrp3g3rho/Q8+rQCYCaCVtzysg9eZI+aaASr7k=;
        b=klNX4WQ43qJ4mZeCzrMkG1YYNslaxAFV2aLjrMSz97L2A/k/oNj6pAT1c+/S4W1p7t
         wMcY9ZWohGcicbnYZhOgT1qsnp4D3bpnUOhmcY0NjrBu7OF83humVKbF7KbYh+ieRL5+
         DQLQmmckhJHuh5eR2pRTV975roYGppruBQk3tuunH7qUgehJgyV4ttdKDRqiGGiTC4ox
         GR1KR64XqFxHJ+LsPZps4ye3SW7XDHbi9k+wROfmL1BU/XSwwX+ZQwr3Q5PxZqCqXkWm
         pUh2P1a8fsFrSiqr+03OhZb+dV8SckIFXEcc61BVGaiHZf9M8998r775V4KlO+IKMIxp
         R6FA==
X-Gm-Message-State: AGRZ1gI2sIV2EOpk8+/SCl9idVCNYatOUkvQQ1rniEnJ7MnHZ2X4oGzN
        O93MXAVlVdlY1xNoXfuXKjBVGg==
X-Google-Smtp-Source: AJdET5fEpG3BRcVasfBfKMtW8R7+Lp6qKg2+6JWWzRf/Y3iyg9IKemH7sTOMfTXBIo1huXU/BZYsIQ==
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr27114136wmj.48.1543337751557;
        Tue, 27 Nov 2018 08:55:51 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id k73sm6383099wmd.36.2018.11.27.08.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:55:50 -0800 (PST)
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
Subject: [PATCH v12 02/25] kasan, slub: handle pointer tags in early_kmem_cache_node_alloc
Date:   Tue, 27 Nov 2018 17:55:20 +0100
Message-Id: <3459b9f5d4daf96668d9579da2cf15eb5523284b.1543337629.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
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
2.20.0.rc0.387.gc7a69e6b6c-goog

