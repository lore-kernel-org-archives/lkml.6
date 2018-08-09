Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34CCC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A4921EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxQ591Vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A4921EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeHIVrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:47:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35358 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeHIVro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:47:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so6107079wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+04WRzIPiPgey4OPz4HFnYO/J88O5syronaT3xg5j0=;
        b=nxQ591Vhu03jnMxTYftvDNh225xeMHTn98JxuP6moeqXBbN9Wz89hlVBaEjcdTix/Q
         JRwhpBR80Gj1SHIRxBzEIJpPHE0ATKaojKZcNppqoD3eSLfSwJt62hQcbI+yB1lR5U0g
         2EctZIagziNIyXWykgBIYJMtOuzWS4CSipKmJoUvEfFlMHcj2uAwIxJ7RR5ZA4IPAUhu
         5w9rpydzp/Auhu1I81jLZccIFqUC+UGbqcwsEghtsA0vN32f/VyWRYK9wFnoNr4dHP6k
         kjHB0RKkKxr6fPi5vhpNLvGvoiUJVpk4pPHrJNama0hpw7dPu9m1uD3R+oeqfeucRXyC
         GqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+04WRzIPiPgey4OPz4HFnYO/J88O5syronaT3xg5j0=;
        b=CqofnxjReJVhknBpXbGqGT9u79fa4iS/iDH/DuC0/V2Yl83uXW7N5FVcqkEnLEbVcp
         GiGDrpr930A51p46Ai21lCQl5ATkuJxr8yDqf7utM2ouf9YgboGFwIEA/8AXkrYDNq6z
         lvEQBR6t4m1kEJK3lboCNNzwRpcoNCWRJVFWwHLPfXKMCA7IpYs/rkJ4yYFaW8HwCAdp
         OzajK7d/bleUdGetQOXMtzIotEg8P9vWfL0CZA6YqmERbOnFs0XPLlwU0W1tJCRweJ9+
         WIZ9Ml/OMgqxh191hLvHjhEIXPDo0OF7b4sFAJT8mAuMZ83MCMKxydgsIrVm+uRdiRby
         ZZmQ==
X-Gm-Message-State: AOUpUlHoLeTgNA1uXEfaQYUpu6+Za5yR84fDBK/89X/xLlLqdQx8GiJo
        jdmwo3D6yODFx/rmIYVNYx/ZgQ==
X-Google-Smtp-Source: AA+uWPwd82lZWG8HymUYNafSfNQe3iX/xSKDivVKRCbcK1qe34tzRwCCiSDAxySAScuUxsFNJYa/KA==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr2120826wrc.277.1533842489885;
        Thu, 09 Aug 2018 12:21:29 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id o14-v6sm14738797wmd.35.2018.08.09.12.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:21:29 -0700 (PDT)
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
Subject: [PATCH v5 09/18] khwasan, arm64: fix up fault handling logic
Date:   Thu,  9 Aug 2018 21:21:01 +0200
Message-Id: <ae3bce648f4d9c1793ba937613a75072ce3d0d24.1533842385.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_pte in arm64 fault handling relies on the fact that the top byte of
a kernel pointer is 0xff, which isn't always the case with KHWASAN enabled.
Reset the top byte.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7b9531..b7b152783d54 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/kasan.h>
 
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
@@ -134,6 +135,8 @@ void show_pte(unsigned long addr)
 	pgd_t *pgdp;
 	pgd_t pgd;
 
+	addr = (unsigned long)khwasan_reset_tag((void *)addr);
+
 	if (addr < TASK_SIZE) {
 		/* TTBR0 */
 		mm = current->active_mm;
-- 
2.18.0.597.ga71716f1ad-goog

