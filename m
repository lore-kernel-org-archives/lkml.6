Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D911ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E0E20896
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzZBW3iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E0E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJ1VzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:55:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42512 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1VzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:55:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id t6-v6so2522519plo.9;
        Sun, 28 Oct 2018 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kpqpa9BZU+OQvUZEt5EjgcpLDGJ7LYzg33W/0iJP1IU=;
        b=GzZBW3iQRzy1++L2+rMly7s+XGO5sCf2vm2L80QHemKPNXtqraC4vZZ78TMuSVzlmV
         EK9B4sQzrNxqG7VfdNIWBFWkVWe/YiE0MrGGSuMAZX2LdWFOCfQVy06ZLXD+LQG2w81n
         BqDeA1KNTRBenQCn1rsGJm3nQHDvPzcY4osxub8JEa5qgqe3MkswskHz1DL0vEAAL1Fa
         rEOp850CBTZClZ15ATK3l0PFz/AnpNlygwcDe//XCybQ9AgP3OX1ZnPhYya17m8JCTEF
         CM+JPtT32FzyNpTawHK/WQ+nBQFYWyd+8hQT0xDOPix/EJ0kl+9x4qGk0EYSd1zjq09d
         oWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kpqpa9BZU+OQvUZEt5EjgcpLDGJ7LYzg33W/0iJP1IU=;
        b=QyabcIT4bdiAlYN1K+B1tK2iJxThgnOjPPEDAdHuQGv+Ii72T4fS9rZ+uOrIYVH/lQ
         ADESQSDg06F8C3gu6Lt1/rLg+ig7d+jBItj5G4oH3EpbNeEaI2zAHyKvujQZmFtSQRhE
         XLgRK5soRoWE8Y7KcpuFYjyJyeZ7mvdKoBgaZaiE7HYfNg3LsrIrMHRSXhPWzaTkzHbZ
         zMm1QrCBC7By/EM5qG3BdA1r3jXtiPiLwjUkRHJa6IrPymvmTsIHXhJErBHOMC0K4AZ+
         8CX07UenqET/7CuvsBodDn50i05Nk7nMBHeoKIIwK8rBvm9vrzb4P/QE4F0ugtjs5XTC
         L6sw==
X-Gm-Message-State: AGRZ1gJ4f9ORrdF0f1f7FguQUYMGPH+TSvjJmwBKSbpTTvE1BLBywa7i
        2SPTJqnIhncTXk/c+mTNoKQ=
X-Google-Smtp-Source: AJdET5cpZ64yhtGBXP9CJqPAYJ3I+V+dhlwUfEuT7gKrAtWFQu4MGKpcSsX18AOmD+ciiU5xq6IHLQ==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7-v6mr10240898plp.14.1540732233035;
        Sun, 28 Oct 2018 06:10:33 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id e3-v6sm24520585pgc.71.2018.10.28.06.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 06:10:32 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 3/4] ARM: mm: fix build error in fix_to_virt with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
Date:   Sun, 28 Oct 2018 13:09:44 +0000
Message-Id: <20181028130945.23581-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181028130945.23581-1-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With '-Og' optimization level, GCC would not optimize a count for a loop
as a constant value. But BUILD_BUG_ON() only accept compile-time constant
values. Let's use __fix_to_virt() to avoid the error.

arch/arm/mm/mmu.o: In function `fix_to_virt':
/home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
Makefile:1051: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e46a6a446cdd..c08d74e76714 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1599,7 +1599,7 @@ static void __init early_fixmap_shutdown(void)
 		pte_t *pte;
 		struct map_desc map;
 
-		map.virtual = fix_to_virt(i);
+		map.virtual = __fix_to_virt(i);
 		pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);
 
 		/* Only i/o device mappings are supported ATM */
-- 
2.17.1

