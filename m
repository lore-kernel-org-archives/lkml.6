Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9702146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxIEoLBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9702146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391121AbeKTDxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:53:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35199 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404759AbeKTDvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so16061882wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7KSm+jFXQkCQXEc5rnrCA4r7eJPDm1tJhN4hvjkMsI=;
        b=pxIEoLBVS/155thk/jlirYN+v21XOcVr2GW9d9IBt1OVBarBjRyqIHbmLLhe8psyyq
         5Ug5UTJ5X7VrMdCeKBD9K2dkVd+nc0AzF32lJLmucUFRU/GgpdqaUcMhykaBbosPF6dk
         KIu1FcKLwylt2oS/TycDYqUiERABjULH2Gwy1yv1Mw7ZhgGAthWgeAmCkVzYSlPWpzD8
         5Aa+fhgB4AEe7eG4R0/QPBHYc+/htnw7UG7ePdKyWf6uffMpCJytw1h3Wnkeg1RRvRGs
         9OTHbUPdKOxvcS/eCi6mPSgOtTdigpIKY3SU9AHkvrAMtJbrq82+to13FudtfZ995L4C
         EmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7KSm+jFXQkCQXEc5rnrCA4r7eJPDm1tJhN4hvjkMsI=;
        b=eQFjFKjHhMhU/DJ5w+uVB8G75WhTUIJzV3NF6xiUwyfIQLb9IM0ynCIGTMRWZnvhJp
         FdyfdH2KQVwQd7Jogmd0ewSAQC62uBMk6lSejkys9HL7SOEi9tMMCH7ysViDmy09ceJG
         OPrg8Alle+pgRSF7uOsNXHS2eW9UiGjs9zw1na/X7DBgsjQRCd87QcvYLowTYojum9N3
         xPiPvWOpi6+F25xaGBcfhCbEOTAphmD0Ubgtq6Cgra929srUwRZ8vadlPqsclHpiNPu8
         xsASWdGjFixrV8yiPZco2PvLpfJFuRA38ReZvRtkTkKjc1sGqJBC4+VWex24/EOlBIL2
         NqQA==
X-Gm-Message-State: AA+aEWYkpL8+0Kj7whNDDuuQWRZuQPgPC+ktcMphRQZWpcMr8tJll7a5
        ImqR+gd/qVkcAnLBWalKFqkx7g==
X-Google-Smtp-Source: AFSGD/XZpgLAg7rezu/mjkHy6lW0RJIb0uV/wXKhtOG3pV2Pb/tXon7urXALPBJFf4VkMPoh4EQ6nA==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr2727742wrw.215.1542648439441;
        Mon, 19 Nov 2018 09:27:19 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:27:18 -0800 (PST)
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
Subject: [PATCH v11 15/24] kasan, mm: perform untagged pointers comparison in krealloc
Date:   Mon, 19 Nov 2018 18:26:31 +0100
Message-Id: <bd2e180afd1cc5ebc0aebc0cbbfe5cca16ba35c3.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
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
2.19.1.1215.g8438c0b245-goog

