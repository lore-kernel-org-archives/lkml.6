Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ABDC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD08520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ujk3SHMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD08520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbeLFM0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:26:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34677 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeLFMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so326676wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fxqgizsGn0AaIQnRQ33dQkRGCaY8UuAWu0B6VsH5hUQ=;
        b=Ujk3SHMZqV7n0tte5Uw8nokkp/oH0FlKFLsFxzElZe9Z0slbPJEAJExlirmXwEUB/j
         qeFI1DE4ncGLA0+FkTusmS35oYv/U8UXI/jfcSKa3QRtSlDZ5L5lHaiWfjgmPd4nFF/+
         vGwiweNbXNO50gJDPLGhzJri8t+wJQe4o/ND+9KUuI2L26oBYQ8hULSaxQMaAnF/iqDX
         Hpv9wpz9cBx90ytQ87K72yusvxoLQs9ZuSGL0uO4fMjRQ9fR2bvdzrwnlroIA0fQeMGW
         0wXe8PTBJ4EYtsNFcnsc8WZUW2aYYzJizcPd8EFhPQh0QD0nyqeteBzhl8XYpy7aMdWS
         egGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxqgizsGn0AaIQnRQ33dQkRGCaY8UuAWu0B6VsH5hUQ=;
        b=tuvm05xoja2S/Ukmx3ktwjwUcdO9w+jIJuR/gZrb9aZkFDzaKdwxbCNvdUiiF1FEpb
         F4re3iJe9QwAJkw/IM8ZBTigM2V/17juf/NV6XLa6F0TJRg8d6Iq3ddejakyzHkzzMLd
         OXwBFh3tUdvqSzSf9vcEKOWDb34Fs89w0TRjdyCk1o6mviV04rXniJ3PZ11MVnG9Yv5F
         fxxnmgij/UcW1gxDiNAkuGfTdvTC43yZBE4Ilbi/KTunkkj44WOG+G1jzckGwNuJtCS1
         4dYqfxOT8S7IsBMNUKvhITZXCAyee0/ZzlZyqdvXiol7tSgoZEt+Yc8VMt6NopF4+M21
         VkFw==
X-Gm-Message-State: AA+aEWas6mo6SSXirN8/vLX9YxCZocn5XBayb2Uvmv1d2JcMcyXECPOj
        ICkGih4cbbjS/k3x1ncWj6pODQ==
X-Google-Smtp-Source: AFSGD/X/KL+bObt1e53j+RE7+vhNT1qCIPw5uSMB1tFkwSYT/Sx24y8tmABr3/CaYm5nM5Ne2TIj5Q==
X-Received: by 2002:adf:b783:: with SMTP id s3mr26257791wre.274.1544099113048;
        Thu, 06 Dec 2018 04:25:13 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:12 -0800 (PST)
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
Subject: [PATCH v13 15/25] kasan, mm: perform untagged pointers comparison in krealloc
Date:   Thu,  6 Dec 2018 13:24:33 +0100
Message-Id: <14f6190d7846186a3506cd66d82446646fe65090.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
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
2.20.0.rc1.387.gf8505762e3-goog

