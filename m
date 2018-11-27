Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBD2C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4552820817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ip5ogpaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4552820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbeK1Dyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:54:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34515 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731498AbeK1Dys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:54:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so23474017wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdKIYS87jEKsGaVGv0J/kyzmIxkse0BLBOe4/s6kF2g=;
        b=Ip5ogpaHKgzTpQygvmjooBMBVAtgRQRl+qgkAzJ7PDkUUpZM+3enXRCKJyUfAgUpE2
         KN4RrLzeJzOlxK/NsObxYkCP+bixblO+FW6Kw8UNmAe67lAywwzxntNPQRi2tWP/U1Nv
         LDacTNsQuT1QzFPoYQfPMDS7CAGKpR6YYaA9G48zPxMzb8HczWqI6KI9Jw5GL5v4+IIF
         bjmifMvo2LAjKTHeBt10/F+/nr5I2kCBQsXpc0Va3VG3isKuzUhCiZMtkIYhODra3bQw
         lH/pUxLW+O25D3hQXEqFG11Y2SK/POzwZxDFO/ZXGOESU2l6kT/8Hbc/gMs22CZbK1Gu
         AlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdKIYS87jEKsGaVGv0J/kyzmIxkse0BLBOe4/s6kF2g=;
        b=DEECtBmUS1bTFD3XVqL4GPZd6G8UEZ8xxy182vqWyHFVkQ7G42SDxW2/AGuUcwCXCV
         5lq2Zu9IvrUFA3fFyxeC96RTvtNtKhLWCjz/FVy8tUKBusYJ0dr+nHxtjMzIn0aHd9dz
         RjuiYozugCfpGuo/Zgkdes8TOX3Bx/V29srP15aRM5+haz3J70WbxQsCBtSUqajbuFdS
         tfOyftPYkpZztgVWwrQTF8bt9TsC3tgTYEdiBbkIGvPvhzQFE/R/hTKCcyVVEzbdIE/A
         qy4N8bvy0/Yv0Qtlur/KpsxtkslnYnY5lqiHnv0hNTh1TjuhF40DhVGMhtsN+jfez6gx
         J8sg==
X-Gm-Message-State: AA+aEWZ2ojJUV0wCCgjeyMdit6YtyKP3TKdQz1u56CFshR2UvhAeBVVi
        Q+wT5QBXnWF3o/vYdx20ZDUdbA==
X-Google-Smtp-Source: AFSGD/Va46vaty03/ntt8AicD2YvJXz8QAHtsdGhxXNOFGp6Fe24s3POR4AZg6sU6IkJKiYDLbbUeg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr27062120wrr.74.1543337776184;
        Tue, 27 Nov 2018 08:56:16 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id k73sm6383099wmd.36.2018.11.27.08.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:56:15 -0800 (PST)
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
Subject: [PATCH v12 15/25] kasan, mm: perform untagged pointers comparison in krealloc
Date:   Tue, 27 Nov 2018 17:55:33 +0100
Message-Id: <5045db8a8e249a1eda3199b952120035eacb3bd4.1543337629.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
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

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5f3504e26d4c..5aabcbd32d82 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1534,7 +1534,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 	}
 
 	ret = __do_krealloc(p, new_size, flags);
-	if (ret && p != ret)
+	if (ret && kasan_reset_tag(p) != kasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

