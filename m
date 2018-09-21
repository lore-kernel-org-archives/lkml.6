Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D4BECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30AC21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLE1rsoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30AC21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391049AbeIUVDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:03:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33841 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390783AbeIUVD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:03:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so5312960wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vP7c768qnCzMOxVQ3loi78vrT7BMbKGxJOBnuhTzi5A=;
        b=RLE1rsozSV0zZ0sOdztgxYnq2Tug9v/n8R1sOEFvbh9GcH/MGsLOsDgt9HjYx+oyvh
         zfPs40puTwCQKCzPmSYjvtiGjJ2q3aiQvCVQEP6VTWXLmlVaEma8hlLfst73Peo5eRfY
         ZA/N/WdN7PXmdj+Cimt2jW3x7vxdaTqVU7z3ZaZfH/zthxecXN9c24SqSkGUDQrOjwZT
         DyxBJokdab+lSvQ6ty/N60UryhF3VIyRtRwxpjr+yQDySQ1dHAiPdnkCaK1Z5CqHhU2c
         ijfMHIArKRoyTAPwQjUJWykxdjrdQOqHpTDKFNd/ODybrDvxkRHAAbNGxrPJzAS8oCR5
         ZYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vP7c768qnCzMOxVQ3loi78vrT7BMbKGxJOBnuhTzi5A=;
        b=RdmozswfthtAKzEGk5zn+WvUEdwfsIGQ2CWedwPK6qmKUCWAZFfgv5dDMfrBGgucaA
         2fQd/8RaS/KofLyJIAH+rRHTD9rF/5Lj1yHDQqLc/demtI8oFDYSC/2zM+p+h6tHmKbx
         HVuLij3Bguz3cnHT/RHbeOmjAiAUKVqlZ4UZgkPCat0Uc5yafGmnIskAEuUcOF583Nh/
         e/zQNKA9OUihHFevertQZsJUPR1NPbIVMWgO+z+gH5XZGMRMKbJhE96ggYIjhI42pHKj
         jeMy/27TPhN4w2zzYwwKWPhChQL8PsLw+oo0v8IOqgDdc/ULhwlvu1uTLgjjk+Q6OSai
         Br7w==
X-Gm-Message-State: APzg51ACvYsO2445rH+dzXY/VJVI4hmxgcyEAXdFLEJihFb8nD1tcnnc
        8p4buEXWpNq+H0d1iEIYaM2rTg==
X-Google-Smtp-Source: ANB0VdbH3LzUVKRrjYmGt7AbNi6fGfWTpEst1ryidFlZ6Ot+wwm5EVh2XYgPZ77DuIFyB/oTqIzyYQ==
X-Received: by 2002:adf:bc44:: with SMTP id a4-v6mr40096556wrh.255.1537542849011;
        Fri, 21 Sep 2018 08:14:09 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id e7-v6sm27990271wru.46.2018.09.21.08.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:14:08 -0700 (PDT)
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
Subject: [PATCH v9 13/20] kasan, mm: perform untagged pointers comparison in krealloc
Date:   Fri, 21 Sep 2018 17:13:35 +0200
Message-Id: <77d6321d5117c8b8e2267a707b693a6eb67ea17c.1537542735.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <cover.1537542735.git.andreyknvl@google.com>
References: <cover.1537542735.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The krealloc function checks where the same buffer was reused or a new one
allocated by comparing kernel pointers. Tag-based KASAN changes memory tag
on the krealloc'ed chunk of memory and therefore also changes the pointer
tag of the returned pointer. Therefore we need to perform comparison on
untagged (with tags reset) pointers to check whether it's the same memory
region or not.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3abfa0f86118..221c1be3f45f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1513,7 +1513,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 	}
 
 	ret = __do_krealloc(p, new_size, flags);
-	if (ret && p != ret)
+	if (ret && kasan_reset_tag(p) != kasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
-- 
2.19.0.444.g18242da7ef-goog

