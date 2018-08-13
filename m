Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207FAC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB70521779
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="DUUqrLmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB70521779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbeHMWOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:14:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40377 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbeHMWOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:14:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so7978207pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AlhGfESb74txnepXozmi3KiRV4LT2aMLstlLTq8o0M8=;
        b=DUUqrLmqQ3lhpge/UGuSXBIwInmfyAo8b9x6BBAy7DHBiFEqrQgFnirQn5XNZo5k4o
         G0yBGBAhzpNCrpceBJ/9plW8gkOoXQTg996jj+iSpmaUtljNSNV8GyqtqPT3YqItGcHY
         slrbRG8WfwPLL8XSXDAtIDVy/XLYHbt0rHcMkihVlx5E5C6qlEH5VtqizaoEx+kUa5KQ
         lRxtV44prrT3pLZfLwDHqYfnZEiLofzerhXD9IztlP0PvhqKT3ij2ufl5+1Pe0LYxjMz
         2fJ2agGjbRGKqcOw+OUOEzH8lTry235+6m6wqRtS8n1Cc0kFWE2tQ0epWlGQWu0fndrt
         6H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AlhGfESb74txnepXozmi3KiRV4LT2aMLstlLTq8o0M8=;
        b=a60iPD657IlK8ucYkCF4cc60voZraPGEzsuNQYpB1XGxP2yfWKpvIpChH6trqgVUlX
         P53ufA8eQ5h0Hn56meGkOX/H6mM+bSh8lAGicR6duspN9vAIrRIWeNi23ZlA0bkDVPXU
         d4b6hG7MqoTR69a9CmxbHFAO5gj7lYB8WH2k3KMVqsLwb/L5sn+WJPSOYPXxCZSlKbps
         mZk/RkoluAG1kCAn1+wDx2oK930UYHlLEX2VwxMmmQDNBL/EjXImyWyebrTQjOCe49ti
         xPFwxgIymTCaJv9Vqeu9mVPzL4A2iREo2aHJwvOmGzWJi9qo4IlVwRVyaypWvCJ3WlAj
         uADg==
X-Gm-Message-State: AOUpUlHGPjZkB51pWat9kMHf+/4mefiZ2SGuK4aKBuqczww4JdAL+mc4
        JRcdm5bigrl0b27AFzECEAUJIA==
X-Google-Smtp-Source: AA+uWPzhhTvOZif+IxsYqu2a0r1BEWQfElxrZoljZf37J75umG5322s5km9Z2nGSwTdKiMCOxDf+Mw==
X-Received: by 2002:aa7:8591:: with SMTP id w17-v6mr20338767pfn.77.1534188661882;
        Mon, 13 Aug 2018 12:31:01 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id h132-v6sm27460706pfc.100.2018.08.13.12.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:31:01 -0700 (PDT)
From:   Greg Hackmann <ghackmann@android.com>
X-Google-Original-From: Greg Hackmann <ghackmann@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Greg Hackmann <ghackmann@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Steve Capper <steve.capper@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        CHANDAN VN <chandan.vn@samsung.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
Date:   Mon, 13 Aug 2018 12:30:11 -0700
Message-Id: <20180813193013.236362-1-ghackmann@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
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
2.18.0.597.ga71716f1ad-goog

