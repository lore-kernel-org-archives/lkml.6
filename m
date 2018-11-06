Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D7CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA6D2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCUfaaky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA6D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbeKGC5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:57:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33321 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389795AbeKGC5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:57:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id f19-v6so9479952wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQItUgY2gYwGKzTfMCUdpYoluo1ZEefUN3xekUmwX5I=;
        b=NCUfaakydyP1mEvjAcq8JqZWWvdcWMF4TaNfXTuOsryR1QLHPetRjJptGyLqia1LZ+
         Ez1ekzw0lIFJ5zjJ3XMv0NGNc/pM04k26s037zRcMLaiQu2rwvOojgssKOv9bj3TUkKH
         j4LlZXbpr2MmixQik019u26VRZ068PYuvDqTRX00emE+RaLbDhlG9S3rqgy+rfR84VN8
         vHzyWrq2sL6WmXv0GqN3HiTlTzotv9mWtuiirsp2rfxQyxAocP1ytm9By7vHNEzCp7pn
         UCA1eM2qOccn1KI00dbkHUrGtgR+uj1A6jGQc30kzEZb/2SowEoFdUPv7lcsBaxlqWRD
         26Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQItUgY2gYwGKzTfMCUdpYoluo1ZEefUN3xekUmwX5I=;
        b=KvC5g59o+W5wnwuGrfQ7UEReI727F8nU0H9a3s753yyMnNwiTyPVUy3BYOmqH5R9aE
         viB2SYJaWCHkvHufVD6/hDuv3bJ5iIiuB5EHJnDgSxEt9FBRjQxBuGuNo7rVoH0VG0e6
         91FF35/g48LQgchV/qcByMa7fqoWFcs/bPNt7T0WaKAe8+LkDE+LaoGvwxwxjTdNSRUr
         Q58P6AM9duHUaWxa773hLwuQlerKqH3xyQ9Bq3+l0b7KybqoJh/8jR2lUWxdYSpYH5yK
         BeGlrKbuePXE8m4Mw9xGNbEBkQLpbx9wjk1UDrWVyjnbAYroiWbFbgfbz02BRAVLYhFC
         ddxg==
X-Gm-Message-State: AGRZ1gKliW7JEg0/nxiQOFoprPfJTWcns7DMPcEsYevCzHhdR4PPR1p6
        Vj+ekOF/L2y7cC/blaUk/oiFpg==
X-Google-Smtp-Source: AJdET5ewibFtIOBChjomp4ASbXPo7qin6bueX7L2jOoKAZ7ADOmOLeDKrR8tezhA6WYSL8tTi7qH3A==
X-Received: by 2002:a1c:b8d:: with SMTP id 135-v6mr2659929wml.128.1541525461350;
        Tue, 06 Nov 2018 09:31:01 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z17-v6sm16328416wrm.65.2018.11.06.09.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:31:00 -0800 (PST)
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
Subject: [PATCH v10 12/22] kasan, arm64: fix up fault handling logic
Date:   Tue,  6 Nov 2018 18:30:27 +0100
Message-Id: <4891a504adf61c0daf1e83642b6f7519328dfd5f.1541525354.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
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

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7d9571f4ae3d..d9a84d6f3343 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/kasan.h>
 
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
@@ -141,6 +142,8 @@ void show_pte(unsigned long addr)
 	pgd_t *pgdp;
 	pgd_t pgd;
 
+	addr = (unsigned long)kasan_reset_tag((void *)addr);
+
 	if (addr < TASK_SIZE) {
 		/* TTBR0 */
 		mm = current->active_mm;
-- 
2.19.1.930.g4563a0d9d0-goog

