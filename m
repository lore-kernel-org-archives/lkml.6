Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37813ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54A521568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFyuXUUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54A521568
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390484AbeIUVE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:04:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56265 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391010AbeIUVD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:03:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id f21-v6so3429620wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OMivlQBlkMR+OIo97sD6sFFaZkiu9rVW9+qGQSiUP4=;
        b=OFyuXUUZFiBmXAWubLMx8YU2l5NLejkfxGTmVmIjjN+VgNs9mtzWo980BQQpct6WLd
         rDAhvuAdk6qF3cbQTSFRXn0PcT1IzpAfxR+sFpJOJe2IJbwSj59PMSyBpUxLuVggrsvP
         hrti4DOQKgnAED9gVJ5snFxmuK+mluxPyAQnTA3dQ7NAfuUFASCgQMSB3mp5/xfQ27xS
         75qVKCQIrZCgnWJtYLaPFDtHEGJ538o1f4PLXaKvfU2khl7Q/i2PkvPvdY0aTeENetoK
         2nbVWFbN03/CT+bvoF56qjyq9biCpx6HnnKmrSy5A+VKYDB3tV63Bch01C/sd+Kv4Qzw
         1BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OMivlQBlkMR+OIo97sD6sFFaZkiu9rVW9+qGQSiUP4=;
        b=q3Rw458XYVgUXxeMrc9cgl6ES1QvaWAiju6Np0Jp8eRTMtjJP3w/P+bBYQ9F/D/ZaU
         PC9OqfNHlTnYHeCyUMbKu81awo4274fqWm9GbvW7bO/abJk8pyTnzV04M03LoZ5kzpwl
         RN2JvDBIwXqwaA1es0wcPI72AIdTgCK6iedEgvLjg6fxpcnRh3ICN5YTAhlEf/ga1jbL
         XYDYgnA41G1ljlUqrwNg68U3fus1DoDPbNYtIhDxtdLnuYfoVBTTtwfyuFEGrZNjQ73X
         7fYr9upyr4Xo8v1XNZJeY2MWF7Gz2D+mTaulvpMRwT6BnTgemiDB0d2F8PZDSHPRx2g8
         jhZw==
X-Gm-Message-State: APzg51BbbFxe3+U4L3LywDX/eGoIEYyu/3X+ZVWkpLbljj39q0+oxHnV
        9FQVHatJdY3JIpT35vG8qfbA9Q==
X-Google-Smtp-Source: ANB0VdZLgoo9U70xaziY+cHCD1by/PdgBIs7OJ1vqc5f/YS1n5hIWdaF6Wpvq4bFhZ/LeGhK+ftS8A==
X-Received: by 2002:a1c:40d5:: with SMTP id n204-v6mr7794413wma.44.1537542845659;
        Fri, 21 Sep 2018 08:14:05 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id e7-v6sm27990271wru.46.2018.09.21.08.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:14:04 -0700 (PDT)
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
Subject: [PATCH v9 11/20] kasan, arm64: fix up fault handling logic
Date:   Fri, 21 Sep 2018 17:13:33 +0200
Message-Id: <a8169b3802dda203e717ecd9cdc40cc3fa86e7e5.1537542735.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <cover.1537542735.git.andreyknvl@google.com>
References: <cover.1537542735.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_pte in arm64 fault handling relies on the fact that the top byte of
a kernel pointer is 0xff, which isn't always the case with tag-based
KASAN.

This patch resets the top byte in show_pte.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 50b30ff30de4..78328c864d01 100644
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
 
+	addr = (unsigned long)kasan_reset_tag((void *)addr);
+
 	if (addr < TASK_SIZE) {
 		/* TTBR0 */
 		mm = current->active_mm;
-- 
2.19.0.444.g18242da7ef-goog

