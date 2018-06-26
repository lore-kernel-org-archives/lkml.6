Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9E921772
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5BA1fb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9E921772
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935580AbeFZNSf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:18:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54331 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935520AbeFZNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:15:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so1881849wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yBPRwBaWYUVSArjumBa6fauS/4DSRyKow4zS0UL3/uQ=;
        b=F5BA1fb9nMc2llPcpCY45+Govd2NK97f8DeANvLf6/pO+8ZmySSwPGT1QB8mjbGwcm
         +jBy/JwaDlvGaXBjCxqHRVmaDgiCAUY96hiv/hM8YaY32atVyychrCmE+3/BVRMOsNwp
         Kn6aKoO5sB6cWxGvwtuGwgOI2aVvPPfsY2sj0pFhyoLksQSZPx/tBv8y5N6P6ypfZ1YE
         SV/LxGr4VV24bnWuBuEtAb4tit0Eq2C6vck2Um3KnGgDCw+f7W46c4Ntra9VSYDZR6Zh
         tdwZkPQDXYh/YEwXFnAlSQdYMSz6tay2i7Pj/cLpfnfV29yEN7Nd+naOl15nnSAyJlP9
         Iy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yBPRwBaWYUVSArjumBa6fauS/4DSRyKow4zS0UL3/uQ=;
        b=eEojwjNjfE8RNtmruR9MP/pWnsvBwqLtDwIMeu4fZTR9fgASuoqQ5C/Hxl60B2onMI
         7EYJnh0I0VXSE6UEV5oMQOy5qQzmVMChuSEHTiq8JIMaexEiM0BXcTrxJQdbUQRKg09Q
         +2wU1i84Mx/4ddFJfx0cvyDZ8TZxl9XWd6UOmtV43FWR9mtd36umP241X8+zWvGHmdHr
         9Yq/Z0IwwIsbNUMtxWBcxiiVQ79MFkSKLi4o5Lmr6S2T1SqbPkB5ZQFRYyP+53FZrEY8
         pcJBqrWOLeElcYG6i0Z+ATxfrdeP9+3onvHrOCOe9/fNtT3yAjSx/KcN3cJZtCZB+E7X
         WZ1Q==
X-Gm-Message-State: APt69E1CWnW6OCTyuEcPYTlZNA8O6W7susMZxzcgeCLLiRwXzvXLylFE
        Cd1dDRHLeGxQqMd9KE/W9dgghA==
X-Google-Smtp-Source: AAOMgpcIZGN8/Izw0CfyPMZx5yvgYHVOM/4GCivZrU5323uijnvw+HedN5vD/6BGwQOLFt2SEUXnAg==
X-Received: by 2002:a1c:3504:: with SMTP id c4-v6mr1531279wma.59.1530018952054;
        Tue, 26 Jun 2018 06:15:52 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id w15-v6sm2162639wrn.25.2018.06.26.06.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 06:15:51 -0700 (PDT)
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
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 10/17] khwasan, mm: perform untagged pointers comparison in krealloc
Date:   Tue, 26 Jun 2018 15:15:20 +0200
Message-Id: <be2d28030622fa8201844cf438654568ae1808e0.1530018818.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <cover.1530018818.git.andreyknvl@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The krealloc function checks where the same buffer was reused or a new one
allocated by comparing kernel pointers. KHWASAN changes memory tag on the
krealloc'ed chunk of memory and therefore also changes the pointer tag of
the returned pointer. Therefore we need to perform comparison on untagged
(with tags reset) pointers to check whether it's the same memory region or
not.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index c279b52c7565..7746d2ef5d45 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1509,7 +1509,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 	}
 
 	ret = __do_krealloc(p, new_size, flags);
-	if (ret && p != ret)
+	if (ret && khwasan_reset_tag(p) != khwasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
-- 
2.18.0.rc2.346.g013aa6912e-goog

