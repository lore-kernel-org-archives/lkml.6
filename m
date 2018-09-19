Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D6ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B053420858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPuyihbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B053420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbeITAek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:34:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40842 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbeITAeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:34:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so3225078wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtJgUAWOXZXX0dAHUptbPqpenfy7NgkmLyignEvLyTk=;
        b=vPuyihblvxcn0sLFem62r23wIGYYYskYXdS/f0UduHxfmXZcYhZa+1inXCT+EVC71b
         xR9esBpfVNjAw5O1xd94Y0Ta9SiVI5dJ17z93VEQu3KYeWrfq33uQUDvbvmcGV6iZTUb
         b+9TkA37Wz+GEuxDBV724TGKdy1T52jCVQWAgTPE79jxFsVOoaSYOixroijjzYzATXJ1
         jj4LdW4Md3upKR14f85br611JPh1UrMa8LADi2b3KZ1rAmXkL7gTDaLh1qx5/UUIf96h
         Ykig492trKfPPYXL59tNXdfV/Ll/v7d93Di9WJRRygDSUcHJLfMTsoWN2l6fYWF3kink
         jUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtJgUAWOXZXX0dAHUptbPqpenfy7NgkmLyignEvLyTk=;
        b=AebdjTS1gc7ZOvvlSXMV6wS0oEaGeyTQAuc/pa6s3qNax6MXP/a+TumZ7G+/zKztwq
         /QrBS92XmHsWCb8bBVYfD4XLMvBElyP1qzxc5bP1NyaxaTamzl4Nd5z2YOX7KpgZeEsB
         y1PUWtpzPmIn+IuSfoElJg0OXMdHWeiYCIX35PU/Q3Sjx/WQXQduLeF2Lqz0t80Q3TRW
         EqVohTlWAP7RLcTg1Pkkux9gW6kdJDeQXtmaj3OlxqKePiNzScxizKqvZtK5HqVHsKXD
         RMpHjRINJfX5LXpkDCM1sGZhifzuKhLFPKLyllkknDHJc3eSK4ywjveDMKruInjjvHxw
         c5Cw==
X-Gm-Message-State: APzg51Dz3YuPdyP/nD4EP3iZocRHSUp06vOLFhPGq8YoWIOClS6HWDrM
        Cw6UDXYNNG9vKRH4qKpZk76IRA==
X-Google-Smtp-Source: ANB0VdblUI7MFFp8hCfvF9UePgtJJWb/kUMM90uaKcYDdSH4MK9TlKqZCLxx5yQlpghBFlT3+9tF4A==
X-Received: by 2002:adf:9464:: with SMTP id 91-v6mr30486547wrq.231.1537383321264;
        Wed, 19 Sep 2018 11:55:21 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id b10-v6sm8510065wmc.28.2018.09.19.11.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:55:20 -0700 (PDT)
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
Subject: [PATCH v8 11/20] kasan, arm64: fix up fault handling logic
Date:   Wed, 19 Sep 2018 20:54:50 +0200
Message-Id: <ca97a9434ecb703456cc06d9f17fd45e2e0b46ce.1537383101.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <cover.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com>
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
2.19.0.397.gdd90340f6a-goog

