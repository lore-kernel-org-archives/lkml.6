Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA3BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740572145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQFp0Cqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740572145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJSUze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:55:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41575 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJSUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:55:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so16442043pfi.8;
        Fri, 19 Oct 2018 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m3s0ND8Y5PaLjIt9gK0grLpTrPnu+YvRB4PruCgvKtg=;
        b=gQFp0CqvxWiGub/3+O3ZZ6O/D5OH99SVufaPys1gFursted1s37+Qi5A5luk6w+DR5
         jG80g4ehbf50BF9Wr9UOdv/dTtfKTpX94O8NkpQKnptPEZ3IyLG3rx//UrPpfVxb0zOd
         oBYNm9uYKARVMVgX1b95H9RZOPlJ2dS9rezEu2+jvVi4re3IvhMWXz0ZKY6PnDpiJgHR
         /Pb4aw/+qUmFDoX9kPlNxIT+ntn5dyGjGFHyXrYOMioomQl8D9srr7+aniYnysnG+kUs
         zBy8B6rZijhiG4haLJdGNlmGg+zQUqSQR7an/AR7HINF4Vtjn+HNWeiYVjKeShoLDiXV
         70MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m3s0ND8Y5PaLjIt9gK0grLpTrPnu+YvRB4PruCgvKtg=;
        b=B8XfnpqSmspOvmdWTXSAnDnTwA/0kKyyQhf2dQlpTerY9zg2fWMXLS0nNIVJbecZT+
         9y+M77RuY0ZL/1CiO4772/Y581ACsnD6sBdAsa8te3Fc6znL1yDYKt/RumI0KAvxKcJG
         VpSW2mV4ccuSxdyQngvtdhDuew2rC9Mu5RDH3tUtORkTNKiF75Vcr63bbQcnyEbbTSto
         2PzNpQPONQZ2WRkDMpnqtKTRS+bLFBkd2dbDtPGQUwY3G4wyxBLbvmnxn18fEEBYOwGm
         ouX3nSiGDoQgVIdMPFx9I+6F+KJJZDv3FKsAT1SweKh1qBW5EpU4nmvn1+/VZExc2SnS
         AfBg==
X-Gm-Message-State: ABuFfogC7qVbpIeEUgV+8K0aCjFKqciTNy6A0u1SORUa7S7aURahhW3B
        U9EPM9lRCxwKefzPUL4XI1g=
X-Google-Smtp-Source: ACcGV63ugIg0pvNshNengjIlldBfTze5yoqmHvVJZ48xpDQ0i/6Z3TjEvP8N79/Ffta8CPIodQ5afw==
X-Received: by 2002:a63:1806:: with SMTP id y6-v6mr32886939pgl.187.1539953374792;
        Fri, 19 Oct 2018 05:49:34 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id o131-v6sm33640679pgo.53.2018.10.19.05.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:49:34 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Du Changbin <changbin.du@gmail.com>
Subject: [PATCH v2 1/4] x86/mm: surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif
Date:   Fri, 19 Oct 2018 12:49:18 +0000
Message-Id: <20181019124921.13780-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181019124921.13780-1-changbin.du@gmail.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The level4_kernel_pgt is only defined when X86_5LEVEL is enabled. So
surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif to
make code correct.

Signed-off-by: Du Changbin <changbin.du@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/pgtable_64.h |  2 ++
 arch/x86/kernel/head64.c          | 13 ++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 9c85b54bf03c..9333f7fa5bdb 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -16,7 +16,9 @@
 #include <linux/threads.h>
 #include <asm/fixmap.h>
 
+#ifdef CONFIG_X86_5LEVEL
 extern p4d_t level4_kernel_pgt[512];
+#endif
 extern p4d_t level4_ident_pgt[512];
 extern pud_t level3_kernel_pgt[512];
 extern pud_t level3_ident_pgt[512];
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index ddee1f0870c4..4a59ef93c258 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -151,16 +151,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pgd = fixup_pointer(&early_top_pgt, physaddr);
 	p = pgd + pgd_index(__START_KERNEL_map);
-	if (la57)
-		*p = (unsigned long)level4_kernel_pgt;
-	else
-		*p = (unsigned long)level3_kernel_pgt;
-	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
-
+#ifdef CONFIG_X86_5LEVEL
 	if (la57) {
+		*p = (unsigned long)level4_kernel_pgt;
 		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
 		p4d[511] += load_delta;
-	}
+	} else
+#endif
+		*p = (unsigned long)level3_kernel_pgt;
+	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
 
 	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
 	pud[510] += load_delta;
-- 
2.17.1

