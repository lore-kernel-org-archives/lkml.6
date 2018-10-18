Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3647C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E6C2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBZo7hFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E6C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeJSA2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:28:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJSA2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:28:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so14426611pgm.7;
        Thu, 18 Oct 2018 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qow+btamVg2OjyXBN/mPuA69PAgVb9M9/11WsfNvrQ0=;
        b=JBZo7hFFlLcDjNjQ9qsGb9IID5ORZzi7Cx3aVf4sQMbkZ4zyjhl07DK2Ay909dMUbW
         987MBCyx9jyyCnuVtZPDaLfdNDCHgod1shuS5ZC0w4ZZKThpGNEmLCg2OLOjPB/V5Zla
         PoIaV+ICwKr6gC6GmJPY8QKsC/kJ0NbbPNI07/EU9iHgWo7JEvMalOdBaxwihIf+BOaj
         wUZKQvCiUwEcRWYaXhkzSSVUVdDhy9SsIpXyQlefSblqYLj9J5q6+1LziorAtg1RL+pU
         xJCFKS7ZrPvkmhIaIEeu6BkYee3JyfLvZJKjbKBMC93aSzYADNTXoU0ubYksXddfe0k8
         w4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qow+btamVg2OjyXBN/mPuA69PAgVb9M9/11WsfNvrQ0=;
        b=S2zwxbkiUdIfrNJwYk+o99MzghjjcdxMymNGi7blJbD9fbyNYx7PJsXUtAV/pYJRYq
         nAKFW5TWlFUbl901HBVO4zynb86qc4idIrb3t7MupMeBFRxgddCuoKHaZU7H0WS2deR1
         bUDG/5xDNLtfuIYDjhkzjiasnV+zuIdCaB7MXbkUpKpMgVv3rOn/YHitczaYajmCBdRR
         B4v51WdIxLHV14cppl67lta3GvRoKuQ9ErmDdO5Vzk3Q5mqK6C/N8WXRk7QiEa7I8Jet
         XE8ZmWhoabvSC4WYQRdKuzulpaaAHf/iyyqTAIjh1hRr9jqyCjjfhMCvhgLE2j4pHqhU
         IgJg==
X-Gm-Message-State: ABuFfojjGTMTCrBBigvMe0c02K0Qt95lqh5rPOJXpjQ7lbeT+2VBuSDa
        XHRwNH7UVfDUtijSVjScgys=
X-Google-Smtp-Source: ACcGV63aTkB9Z/jGEUXZStVEAN5xhexA2ayr04PfL/fVuyfDasVUGKrICBasHtCiHWrSshUoKUm/IQ==
X-Received: by 2002:a63:6c4a:: with SMTP id h71-v6mr28829004pgc.326.1539879975557;
        Thu, 18 Oct 2018 09:26:15 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id 5-v6sm27813420pgt.83.2018.10.18.09.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 09:26:14 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 1/4] x86/mm: surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif
Date:   Thu, 18 Oct 2018 16:25:45 +0000
Message-Id: <20181018162548.6399-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018162548.6399-1-changbin.du@gmail.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The level4_kernel_pgt is only defined when X86_5LEVEL is enabled. So
surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif to
make code correct.

Signed-off-by: Changbin Du <changbin.du@intel.com>
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

