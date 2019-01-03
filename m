Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572BEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240BC217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ba8p1LN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfACSpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:45:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32870 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfACSpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:45:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so34555906wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 10:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqfuZcAjUCBtOLKWkS6SRZq/hte3EYpV7rEPQw3hkz8=;
        b=Ba8p1LN6oK3Pi0Fl7zZMXYDUR1uRcqSUKMdpT1Q7mAQ6syoy5qLvkHGMUj6j/vGuB2
         mPO5FuGEoA96YcXVqzSpSwHEKELmv7R+EvR+inn+PIduuMt4TwXWHgaGeZc0ky7vvm86
         yH9L4u9oYTTxmMJbx5HQX1aqZm017enJlCtGAbNGdHs15wOBu7Y61tXbAM6zeVySF49T
         mmuEIvLHrEZb5taS7g9ooF90sN5EBjH7gGfduXn1VTHmhUOpSR2P22jZqk1x1eBZqFiP
         sH2YY6VeZEfqquy8gfHxRd99KsANe2ythZVkjVH7ZxaZekAiskkZhF+Vg3IKqAONrIV4
         HEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqfuZcAjUCBtOLKWkS6SRZq/hte3EYpV7rEPQw3hkz8=;
        b=SvHKu0iS64SMRYkcwpU95zeXaVLl+flKsjhK64DlN+YB6NRIHhB2qlucoqQfNKMHVX
         8Qb68BUztSgZVNS13B6TsVFQzFxfmtJ6LlZQtiIYLW3wLoQbUpn4SJsNuFRxNzC5/YMA
         pVpDei+aPPyloQwG8+kCN+L662Je71eG3t3RzMB3JNLl5dOVPMFy3YsgnAd6gdOWpsgR
         CZgBjH0T9zaGHBC1SXSXuysawFOVBGBAs5k8TaFVfExXpX5JQedQoNFhZ5rf7HsauwaG
         UI+pYgPkFPMFbaoW+lvNnhGiL6pbcxy7sz/7G8xDbaaaAevNuelgt5YyiAQef2FBwA64
         KOJQ==
X-Gm-Message-State: AJcUukfWfv68Nf1qKXlARssuYlQ+G2ayrUlmq7qTLF49oR379bc+d8vn
        wzmyQCux8i9dDYQjaMdSP0svDw==
X-Google-Smtp-Source: ALg8bN4LFcO01Vv4WTRKcuv5YTd1wsOefh/eH/jXvbvXe+jy9rGwknH3ImOWsoQ1UvdKBEe2ffL9iQ==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr40972842wrx.248.1546541128878;
        Thu, 03 Jan 2019 10:45:28 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id t12sm52236944wrr.65.2019.01.03.10.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 10:45:27 -0800 (PST)
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Subject: [PATCH v3 2/3] kasan: make tag based mode work with CONFIG_HARDENED_USERCOPY
Date:   Thu,  3 Jan 2019 19:45:20 +0100
Message-Id: <7e756a298d514c4482f52aea6151db34818d395d.1546540962.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546540962.git.andreyknvl@google.com>
References: <cover.1546540962.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_HARDENED_USERCOPY enabled __check_heap_object() compares and
then subtracts a potentially tagged pointer with a non-tagged address of
the page that this pointer belongs to, which leads to unexpected behavior.

Untag the pointer in __check_heap_object() before doing any of these
operations.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 36c0befeebd8..1e3d0ec4e200 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3846,6 +3846,8 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 	unsigned int offset;
 	size_t object_size;
 
+	ptr = kasan_reset_tag(ptr);
+
 	/* Find object and usable object size. */
 	s = page->slab_cache;
 
-- 
2.20.1.415.g653613c723-goog

