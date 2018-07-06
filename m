Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F8CC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42AD20871
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbFIknlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42AD20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbeGFJCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:02:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40823 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeGFJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:02:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so7897514pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KBVWoCjiNTgx3OnopaUozpRLlK9tc1muAL6uwtd7eM8=;
        b=IbFIknlzuOISLCW8QKOsl5arhgHqijw8hpls1tZ1X+eWQ7jhUs8YYMVvpTUe96mQgs
         c5BadDGHadOZTEpcs0d+OW9Djn2+iOQn5CPoOu7rH5PbjOajTBTx+km3HuEowOUvWtA1
         mT4LeAvRFZMZ1A4+82xcFcZlUt35NYarma/5+iFgFKVw2E9rBmAIhOlFqRrU1qMS+9N/
         JRBA97ag1mhrTwPbWVL78n+ZIiOpYQyK5YmJoSpoLIKATZ5x5Tka3MyEEzbd6ehPPQTh
         UTjMrdmmhB2YhHaqDmvn5P0ITpSIWrWBkpKAJwgqCAgSlHgCsMZqbpnXUYG2FDhIf4SJ
         q5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KBVWoCjiNTgx3OnopaUozpRLlK9tc1muAL6uwtd7eM8=;
        b=VAS+miJxRkOMRCI+A0geifpHNZdgJlL8edvg5suYIiBfYbVpr1M54C4uDl64gGHSS4
         6b47tw2oer4BY7hj+2n05/SgLiIQDA2+jP484TvexL7f0HucMcoxQWOwBuvP+DB9Nk+W
         QaUnpsRr+URRlkS/61F1pSsSxAywziwxmW4Fr50XUGX7DBRCymIDC5uA9BGR1lBZZJ2d
         iHrxvOlDx4n9/TCj/myKVUwNR3MMCAZDr1Vg8TP87ThzMOO26ZyN71mb0jRJsHUYWJ7B
         fllyqilOBqi67e1r7HcQ5R6rwNNyGERQb1tUVNPmG895OMQrV3rYuwzy68/9aGEG2Dvb
         SLzQ==
X-Gm-Message-State: APt69E2xbVK8u4yNVtlpjmyayvqNyMU8wZM5X9LWVPWbpwPWC+l0D0y8
        zxuy5fCm+tR5TG/Vkf5MfeI=
X-Google-Smtp-Source: AAOMgpefuXMcTQs2ilg4Vf5rhEn7GIqsVV4ZnoIougF0qHKQtfUKqIuKE1cIao7BmKJF8VuQODSvtA==
X-Received: by 2002:a62:ec41:: with SMTP id k62-v6mr9771859pfh.206.1530867772937;
        Fri, 06 Jul 2018 02:02:52 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id e5-v6sm10837092pgs.59.2018.07.06.02.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 02:02:52 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <hejianet@gmail.com>,
        Jia He <jia.he@hxt-semitech.com>
Subject: [RESEND PATCH v10 6/6] mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()
Date:   Fri,  6 Jul 2018 17:01:15 +0800
Message-Id: <1530867675-9018-7-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
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
index 57cdc42..83b1d11 100644
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
+#define early_pfn_valid(pfn)	pfn_valid(pfn)
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
+
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
-- 
1.8.3.1

