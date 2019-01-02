Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F40218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBABedig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfABRgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:36:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38915 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfABRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:36:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so28195549wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 09:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqfuZcAjUCBtOLKWkS6SRZq/hte3EYpV7rEPQw3hkz8=;
        b=GBABedigx8sH5GFwpRqipEDZ14ymhRvEFULjEU8wLa/LptdTisVFf9skUy8ylEKwgj
         RF12pUwr344Vyvy3ZqJC4iKm1OZSWqoVLD5mJZkl91WIY/lo6o1i2e7+QvZjCRXC8gqD
         TalGJ7+keqs9g4ydv5W/68JCwOiEcJUrlW170vCsYKVKJdezXyBqilxWlN06NaZHYTDc
         QQgWpPrpqe6SqK7zrP/HpOaRELc378Wew1Pp2kpkP+K7TKwG3na64p2Wzdh2fIyKQxWR
         416+4i3iHDx7qlDktBw/RgIj4tv1H8OekGka2BVVugetEBDgCsmpkgmw/g7V3gWXuDyc
         OjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqfuZcAjUCBtOLKWkS6SRZq/hte3EYpV7rEPQw3hkz8=;
        b=YfSxDKJezHXLtg8bwd4Uyu3iGQVWDcMz1tUTpWLVifoLUaHyM85Jyn9Nl/3ygabELL
         de2YVTEPMB7K45cs2xhyBfduASHtkUST8URm2mm1DexZWeS2KSmxqrqrgIezXjceeIEw
         zB+0V0iUhFXBUqqNe9c0Yz0xYu0OuDKicsOIgeToaFGUN0zDgdY+ge0wP4/BUqahngx6
         0gLZQYYV57wsyO5knLWnkjD422vIPq8728qF5fqWfgNqqSxgNd7P1CIWiE5tN+igWHhX
         GgPPR6WNPwmkYcHYga+aMJeOABDTxkAcFCY3OOnXZlIUDHRt55Yt3oYjfwlMuV5YWoNT
         +pAA==
X-Gm-Message-State: AA+aEWYv74ncejW9RXDkaGCut7pmMIjWwz2nxsG4NjgYLXiqeOOTK7zb
        WelUPflLjCLG2fAijZJkNH45/A==
X-Google-Smtp-Source: AFSGD/W97uWDkFBwjy9qVKlmOmTQCuBOdfdQInnihelGax0GIIIDp5gYRmDwwP96Pfhda8t/d8RaVw==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr34987293wma.91.1546450576552;
        Wed, 02 Jan 2019 09:36:16 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id t4sm45987076wrm.6.2019.01.02.09.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 09:36:15 -0800 (PST)
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
Subject: [PATCH v2 2/3] kasan: make tag based mode work with CONFIG_HARDENED_USERCOPY
Date:   Wed,  2 Jan 2019 18:36:07 +0100
Message-Id: <21de3c171438760a232d51cea56792c886bc9160.1546450432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546450432.git.andreyknvl@google.com>
References: <cover.1546450432.git.andreyknvl@google.com>
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

