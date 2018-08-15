Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602B8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302932150A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="NLlGFKQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302932150A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeHOWrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:47:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43168 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeHOWrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:47:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so904993plv.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1svywvHXHC+/3YSygBgMl8aZ6Dw9DjsoXW1z7O9jlBA=;
        b=NLlGFKQz3j/zWusta5ednPTzRb3NfIEtFqzNYY6uzt5prVvgFGUA5Sfe1G1SsgU8NY
         AO+VJuMIMgMUGN/deVzA/BXQ6uAeUuAqLqO6EelNOJ2dnxn/i0o0FOw+s10BZ2i8DR6m
         MKSXfpKcNIbo731rstZvsspM6z92gmf1hjbjkQce5XqzUjazMSZVIH9pRy/KqJDvKguF
         ZXtkfjDzgLI1TNhYYE1YtR41qXj0WU9EFU9/X3wDacLQZi1VYKFr5GumQlM1+hC1/e8P
         /r84vbVyNXH/v0wHv+4OTg/+9XJEBbjB3akWJ/1Wyuq2L+SqkI744/YJQd0dPSs2iGN1
         f4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1svywvHXHC+/3YSygBgMl8aZ6Dw9DjsoXW1z7O9jlBA=;
        b=KGSaq5vrFJ3+6jsNBrBDUWesF1q7agUXFSI1GLHJ1AsOTHGO1u+iGz95lVUiDhwXyP
         bfcdAcXIEwxDxImsDRYCwNSnPTbXZzI0ZBBPOBbmS5eLWXhOBRA1sgU8bQVV4Zf3n1ED
         3VeLVj6g0SQ+xldwRr4zQ8tnXzTSqLAx28vTqtj7YzEqo8lguddsGn18Kj/mD2WE0oQd
         FCa//Q9expQjqZpqbvvRi7adcudsSWFhkSAmX1bSATrOAqCgjDGlrgRYQZ481KCC9cQB
         tVumTumeNi5BKOZ2YvpShj2mtv17M6pc/LWkpgNQyvyPASffaN5p4GzX2hLCHfpdKAU4
         qZ1w==
X-Gm-Message-State: AOUpUlGAs9lloUoV6ffqz484tq6h+DeOwQkyIvwP6B1/13fPB0bZ7faH
        wvyfTikwQ/tHUP58s5oiyplZ1w==
X-Google-Smtp-Source: AA+uWPzzcuZTBdrphhymtLjZc2iCy8Pmu7c+I0xNV9jRYINXSfFJpZjenR/ajjGGuiYV1nzzH6s2Eg==
X-Received: by 2002:a17:902:7793:: with SMTP id o19-v6mr26193653pll.306.1534362811154;
        Wed, 15 Aug 2018 12:53:31 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id r23-v6sm72514617pfd.144.2018.08.15.12.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:53:30 -0700 (PDT)
From:   Greg Hackmann <ghackmann@android.com>
X-Google-Original-From: Greg Hackmann <ghackmann@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Greg Hackmann <ghackmann@google.com>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        Steve Capper <steve.capper@arm.com>,
        Stefan Agner <stefan@agner.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
Date:   Wed, 15 Aug 2018 12:51:21 -0700
Message-Id: <20180815195123.187373-1-ghackmann@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64's pfn_valid() shifts away the upper PAGE_SHIFT bits of the input
before seeing if the PFN is valid.  This leads to false positives when
some of the upper bits are set, but the lower bits match a valid PFN.

For example, the following userspace code looks up a bogus entry in
/proc/kpageflags:

    int pagemap = open("/proc/self/pagemap", O_RDONLY);
    int pageflags = open("/proc/kpageflags", O_RDONLY);
    uint64_t pfn, val;

    lseek64(pagemap, [...], SEEK_SET);
    read(pagemap, &pfn, sizeof(pfn));
    if (pfn & (1UL << 63)) {        /* valid PFN */
        pfn &= ((1UL << 55) - 1);   /* clear flag bits */
        pfn |= (1UL << 55);
        lseek64(pageflags, pfn * sizeof(uint64_t), SEEK_SET);
        read(pageflags, &val, sizeof(val));
    }

On ARM64 this causes the userspace process to crash with SIGSEGV rather
than reading (1 << KPF_NOPAGE).  kpageflags_read() treats the offset as
valid, and stable_page_flags() will try to access an address between the
user and kernel address ranges.

Fixes: c1cc1552616d ("arm64: MMU initialisation")
Cc: stable@vger.kernel.org
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 arch/arm64/mm/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9abf8a1e7b25..787e27964ab9 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -287,7 +287,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_map_memory(pfn << PAGE_SHIFT);
+	phys_addr_t addr = pfn << PAGE_SHIFT;
+
+	if ((addr >> PAGE_SHIFT) != pfn)
+		return 0;
+	return memblock_is_map_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
-- 
2.18.0.865.gffc8e1a3cd6-goog

