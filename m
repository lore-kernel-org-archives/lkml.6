Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D9CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C056727AF4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vN9ycXl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C056727AF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030680AbeF2CbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:31:12 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39996 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030522AbeF2CbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:31:10 -0400
Received: by mail-qk0-f196.google.com with SMTP id b129-v6so4177649qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 19:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ANjZSVV6/FyPAnL6DgFx6fAokkehXedgEm1vEVKqb5Q=;
        b=vN9ycXl286nY/2K+lgChPocmWSDFrhtmMiDEQv9FC7mLuogqARnTsteWxWBhLRPmo1
         6cOScxrrSa9tebr3VOj5rPmL5F42O+sxJP2LSM/VpQwtc/eNbPRRQIugABLUEUzAMHNf
         dv0UK0SLyVxqrIRPvyKC/BoDw+zl83vBsKLzBvV3g3YbA54Z0UgXtsv8imoTak+am3hA
         i81x+u8H53LiEs+dMovYfbr3F0+C0/7G/IKCJ5LbAlZ6TQB+bBxJbMi+/C7LUWV5ZH/g
         8YsogGNnZIdo32UEMHX2cJM/oOqpKf5iQRgebPxQJ6Ynpt51U0rPOSQ4y71mvxsmaymF
         9TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ANjZSVV6/FyPAnL6DgFx6fAokkehXedgEm1vEVKqb5Q=;
        b=fadYOBjOzL6EqHYxGr9oZJJ/RJZkBa+0KQyENDBz/x2FvDvY/4XmRBAK3E0kk2Ogju
         MTZYDiCBvq6q/0Z1NsZGgIGkzLjAAo1PH7raCn3tNeCjJY+IQrFzm6AZdhCpSMTf9kH3
         mLYrO0q+259vh2rV7J6EvmK/OMhOOKoIV9dicPkkOBuYdeJoUoEQ0wR6Vpwv2xFcSnKA
         iN0sCTBwgAtnnpA5/Sxw3SQWeGDSnM9IobO5LHJfnwXSmOSmcmcBAcw8AD/jExHB25bI
         HR9sG5ejpBb9U8MIwrGovkz5u8LhFGS77R+D92M2+KqHjyvRcgcNoGLPzi4Dy2BaTbmf
         iZ8g==
X-Gm-Message-State: APt69E2IywSw29JC9On1ABJnlRwNO5OQdGFqxZ6GflYAQgX8S8JqDJd3
        KRPGewBTTbYQm5yrVUlFHgc=
X-Google-Smtp-Source: AAOMgpfJCiGO8W5evQ545apAUKCPxpTYPKw0zAlJvN5wwtaoI18P3088z5Ca5uhYVEShMMCTZf8KtA==
X-Received: by 2002:a37:cf43:: with SMTP id e64-v6mr6247099qkj.68.1530239469971;
        Thu, 28 Jun 2018 19:31:09 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id y25-v6sm6390186qtc.48.2018.06.28.19.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 19:31:09 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>, richard.weiyang@gmail.com,
        Jia He <hejianet@gmail.com>, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v9 6/6] mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()
Date:   Fri, 29 Jun 2018 10:29:23 +0800
Message-Id: <1530239363-2356-7-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), if pfn and
pfn+1 are in the same memblock region, we can record the last returned
memblock region index and check whether pfn++ is still in the same
region.

Currently it only improve the performance on arm/arm64 and will have no
impact on other arches.

For the performance improvement, after this set, I can see the time
overhead of memmap_init() is reduced from 27956us to 13537us in my
armv8a server(QDF2400 with 96G memory, pagesize 64k).

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/mmzone.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 57cdc42..ac34238 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1267,11 +1267,16 @@ static inline int pfn_present(unsigned long pfn)
 #define pfn_to_nid(pfn)		(0)
 #endif
 
-#define early_pfn_valid(pfn)	pfn_valid(pfn)
 #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
 extern ulong memblock_next_valid_pfn(ulong pfn);
 #define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
-#endif
+
+extern int pfn_valid_region(ulong pfn);
+#define early_pfn_valid(pfn)	pfn_valid_region(pfn)
+#else
+#define early_pfn_valid(pfn)    pfn_valid(pfn)
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
+
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
-- 
1.8.3.1

