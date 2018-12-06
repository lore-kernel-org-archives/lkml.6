Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C871C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7098208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVfJoDn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7098208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeLFMY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:24:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44733 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:24:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so259289wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QE+Q4nZZeBuS5Au8e+/piROKf4cgt6sP42L8SlWJEXM=;
        b=wVfJoDn2JNGToLJ7T1uR10yBYoDyUvZHDPfnc33migagJxNgK+X3SnnMPkKaXVWcF5
         v6DU0pyjTpUKWwu0GEPHwrHDIrKhpC24bXdBcz+YJcAfaB/02+ok4ph+SNNgl1+MJDM4
         2PaoZbYfH88/GrmDHUvLd2wPovhStnou6VwHZqIxFuXbq1dEWnuoMs68mCqn/3V8dT/m
         r/FsTY+w6qZiGf1nry8kOTCuRubMXKayBenfsABcza7lF8t6/ApNTC0pVXwtJVEzfn/w
         2gGTTyhI6k4TX6dIeS1j4PSmYrg9rFHuvrEsBSU5NzDgCEnyQyIViFt+X8uGtgGXYdIf
         dcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QE+Q4nZZeBuS5Au8e+/piROKf4cgt6sP42L8SlWJEXM=;
        b=op+JNDhojwF6m+j+3PdFM6ZOcyiYEjXsyP7OU5AGuNqOoCDuwMeETDWUX74CLFjG5x
         atGGbtxisi+S3Sm1nfPQCqzfPhrO6FMH4kYOVQvPtxR70YXyREYckGT0UTy1S0zh44vf
         ww/uGSwR2oaCf0kBl7T0NYCIAI+tqSJSv0gKmYhV7iojA3d8Fprf2TwdhBiszRpEg62J
         ssUBFbCFKqcjFphBZrConR+wDsVOB/hdm2AigKGRIc2RKBN7YCoBIcOE3TI0memJF37h
         IJ2BndKIbhRA0WS9hyjtdaNmwMyIliROpMWMl1E5XECmsoUg6/yhEtFSLQiYSEY6x0w0
         Bzwg==
X-Gm-Message-State: AA+aEWbTj9YX0rY0uDvBEoLOyIRwjNZ70P4aN1qAKydYySFapNN23CsJ
        KtCshVztx4SdxSxI5OjKpygmqA==
X-Google-Smtp-Source: AFSGD/UAxL1TxZ6RYc2RrvhCYipZjB8cIoKC8RPAEZ0NrTXPhYFAwqyGlH1xcwr5wkyHaLQL8hqwWw==
X-Received: by 2002:adf:f091:: with SMTP id n17mr9677058wro.292.1544099090436;
        Thu, 06 Dec 2018 04:24:50 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:24:49 -0800 (PST)
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
Subject: [PATCH v13 02/25] kasan, slub: handle pointer tags in early_kmem_cache_node_alloc
Date:   Thu,  6 Dec 2018 13:24:20 +0100
Message-Id: <fc8d0fdcf733a7a52e8d0daaa650f4736a57de8c.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
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
2.20.0.rc1.387.gf8505762e3-goog

