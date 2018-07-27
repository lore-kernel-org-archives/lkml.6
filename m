Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D21C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA042088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM6G0+fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA042088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbeG0RJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:09:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39199 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbeG0RJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:09:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so5921718wmb.4;
        Fri, 27 Jul 2018 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=mQ3EOMlXmgGJImXGALkAoE89kpKdu7PqCmjrO/dQkLk=;
        b=IM6G0+fSD1BIVS41N+3Xk0bSnx8KJprm7gVkefE+1Inbn0pUGahds/XOD4KAiX6hGw
         IButCK4v5w5svsWzwsrZ2cUsV246GHIwpz1KOybas5XzTeh0yp1lWdnDXR5fKW05CVym
         6Xhoc7wvGoF5JUoIyNB9BZKu+yZLMZrIh4qHFLUMjYIyHcmXwmZ7Y7H6v80eRZzo/kI3
         oUpKQui1maNzbAH/QIZhVgYAYNH9/bvmWRAw8vNWM2j/RWeHRBaqWUvSQzcJeMgeJq3T
         BJ4w6SuJ9Fy+oAnA0Q0bLDeAR+5NPQBwpxKHCSIYArlxp9v6Y+6lXMIgYTFD4ZvRXyuf
         Tk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=mQ3EOMlXmgGJImXGALkAoE89kpKdu7PqCmjrO/dQkLk=;
        b=Xtu/F9qh7WGyyWiApXv/GFeryYr6ZGV02IFZSyBC9ZoG3xnvvMkyRRFeZk8B34WNrg
         Cm47+MdsVSFtarwd/G9Tm/w3W4SSNcAg3wdNqEBPQd+YZ8RWmC7mdjT4I7JR0pspUfqH
         pE36hXMov9J4FHSz9jdeMl0DO2jIClPuGBN3cAnzAJJHKxgTwP6q2yFK7c+4AntgoShh
         njDkFyDsgXlJFrTNRRcxKBpZMMF0lm3p2bkv+d2Vz8E0NTMIRLBr9jOSGWPbzoVkgKN7
         Es5FhhhMc01gf/eUSKdVAGftnsvHmgmm+wfbOEBBtvL1CBMFA5aPcrWnfARQAErVENnZ
         9nSA==
X-Gm-Message-State: AOUpUlHNdOz21czp4i/EjvqBZUdW+N7fcBuE3rYXTFZwfbWzT/69yN9w
        b5ruW+QDOLHxIU63sUWA80X2d9lL
X-Google-Smtp-Source: AAOMgpeiX/j2No7qR2H3P8dVswJ6VZ9d6Iku+646ym6nVphkEZUtl6PEcaqXw6dKA+mDD6CqDvVieQ==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr4959270wmd.51.1532706410457;
        Fri, 27 Jul 2018 08:46:50 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id s9-v6sm4489343wmc.34.2018.07.27.08.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 08:46:49 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        Xiao Guangrong <xiaoguangrong@tencent.com>
Subject: [PATCH] KVM: try __get_user_pages_fast even if not in atomic context
Date:   Fri, 27 Jul 2018 17:46:47 +0200
Message-Id: <1532706407-11380-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently cutting hva_to_pfn_fast short if we do not want an
immediate exit, which is represented by !async && !atomic.  However,
this is unnecessary, and __get_user_pages_fast is *much* faster
because the regular get_user_pages takes pmd_lock/pte_lock.
In fact, when many CPUs take a nested vmexit at the same time
the contention on those locks is visible, and this patch removes
about 25% (compared to 4.18) from vmexit.flat on a 16 vCPU
nested guest.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 861bb20e8451..0f26ff7ddedb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1343,18 +1343,16 @@ static inline int check_user_page_hwpoison(unsigned long addr)
 }
 
 /*
- * The atomic path to get the writable pfn which will be stored in @pfn,
- * true indicates success, otherwise false is returned.
+ * The fast path to get the writable pfn which will be stored in @pfn,
+ * true indicates success, otherwise false is returned.  It's also the
+ * only part that runs if we can are in atomic context.
  */
-static bool hva_to_pfn_fast(unsigned long addr, bool atomic, bool *async,
-			    bool write_fault, bool *writable, kvm_pfn_t *pfn)
+static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
+			    bool *writable, kvm_pfn_t *pfn)
 {
 	struct page *page[1];
 	int npages;
 
-	if (!(async || atomic))
-		return false;
-
 	/*
 	 * Fast pin a writable pfn only if it is a write fault request
 	 * or the caller allows to map a writable pfn for a read fault
@@ -1498,7 +1496,7 @@ static kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
 	/* we can do it either atomically or asynchronously, not both */
 	BUG_ON(atomic && async);
 
-	if (hva_to_pfn_fast(addr, atomic, async, write_fault, writable, &pfn))
+	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn))
 		return pfn;
 
 	if (atomic)
-- 
1.8.3.1

