Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3101265FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTWVDMMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3101265FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeFZH2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:28:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38588 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeFZH2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:28:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so592072wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DJ0/iuCMie+JzyNJtxREjILaeS5JU9AmHUysAerB58A=;
        b=tTWVDMMWvc2BwjJRI3ii58XbK9G7OiflXjmkgWyawfdXN3pxzoLvNPJpB8hh+pdpyJ
         GedXdPifgU55if/wq76lbwHBJ+jE7tPfdleDTkpSjfwaYttktxBk3aQE9Pq7WIN9nwxe
         ws/pv9+G2TD8OhnDpXPWBlSBSwYBSKzFIWKlQ+tpWjo/7bcrVPcIeKb110cJ0cQAcbhI
         jkzXFPl8nKE+l1IP1ia04FGJ6bkzy+z4AY3JGZefoPU0V1p+8H5wfHTvKHLR4ZMIV7b0
         Ez5j9it951FhP8TmaDD8DjqTnHMBk/CWkOx4Efo4brE1fN7d0i3sPE3LgugakPbDkACP
         t92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DJ0/iuCMie+JzyNJtxREjILaeS5JU9AmHUysAerB58A=;
        b=hCj/+B/5+a0kQ6i7XByFnv31PnkiR7biTNTjtxa6ARmBAIgLDf8kW9WWZ9hY4nT8lq
         W1yZkROTnywf/PPKEomKKn4wlNRWUpjb/TwpeqUMhG8woF5j8RmZNwDDqRv7UAmEB65W
         tQlM3j2uxHfhLCCG04YD087BHyd4j6HQRPxcK9Y1a0+D1W3pMgJzpNhqfrWGMwPbihQQ
         f48h2GLeJYlJ9wApO1FoB1xgtfjxEANKoSsZlkzaKdn1UjwyX4buYAsUwPGdUmTWR0x7
         r/HkXx3kd4mnzZwKHg9jxLEgMqr4HBjnfCFgf/AgjTm7TWh87XqVffZdu6mnru00y00o
         dbdw==
X-Gm-Message-State: APt69E1Imu5OvswHefLcmibnpWv69tdR8eKKdDYqzv8o2qZ2EwxYAb37
        4wEktmR3j0W8cNIE4zKanTs=
X-Google-Smtp-Source: AAOMgpcpAx6UJe22P2KhZ8xjvYtG5DMLe00jpROcUdXVt1Yxsrb8D5rebBGrlV7GiauFP0H/F1DCxg==
X-Received: by 2002:a1c:e546:: with SMTP id c67-v6mr592315wmh.108.1529998127513;
        Tue, 26 Jun 2018 00:28:47 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([2a00:79e0:15:10:8971:4ae9:dd1c:10e])
        by smtp.gmail.com with ESMTPSA id q14-v6sm1778416wmd.20.2018.06.26.00.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 00:28:46 -0700 (PDT)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, sergey.senozhatsky.work@gmail.com,
        andy.shevchenko@gmail.com
Cc:     Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v3] arch/x86: get rid of KERN_CONT in show_fault_oops()
Date:   Tue, 26 Jun 2018 09:28:43 +0200
Message-Id: <20180626072843.158906-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

KERN_CONT leads to split lines in kernel output
and complicates useful changes to printk like
printing context before each line.

Only acceptable use of continuations is basically
boot-time testing.

Get rid of it.

Also tidy up code around as asked by reviewers.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

---

Changes since v1:
 - use pr_alert() instead of printk(KERN_ALERT)

Changes since v2:
 - drop unnecessary parenthesis
 - remove once used nx_warning and smep_warning
---
 arch/x86/mm/fault.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9a84a0d08727..a73575cacfd9 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -641,11 +641,6 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
 	return 0;
 }
 
-static const char nx_warning[] = KERN_CRIT
-"kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n";
-static const char smep_warning[] = KERN_CRIT
-"unable to execute userspace code (SMEP?) (uid: %d)\n";
-
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
@@ -664,20 +659,18 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		pte = lookup_address_in_pgd(pgd, address, &level);
 
 		if (pte && pte_present(*pte) && !pte_exec(*pte))
-			printk(nx_warning, from_kuid(&init_user_ns, current_uid()));
+			pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
+				from_kuid(&init_user_ns, current_uid()));
 		if (pte && pte_present(*pte) && pte_exec(*pte) &&
 				(pgd_flags(*pgd) & _PAGE_USER) &&
 				(__read_cr4() & X86_CR4_SMEP))
-			printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
+			pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",
+				from_kuid(&init_user_ns, current_uid()));
 	}
 
-	printk(KERN_ALERT "BUG: unable to handle kernel ");
-	if (address < PAGE_SIZE)
-		printk(KERN_CONT "NULL pointer dereference");
-	else
-		printk(KERN_CONT "paging request");
-
-	printk(KERN_CONT " at %px\n", (void *) address);
+	pr_alert("BUG: unable to handle kernel %s at %px\n",
+		address < PAGE_SIZE ? "NULL pointer dereference" :
+		"paging request", (void *) address);
 
 	dump_pagetable(address);
 }
-- 
2.18.0.rc2.346.g013aa6912e-goog

