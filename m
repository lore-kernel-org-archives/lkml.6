Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BCAC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEDA20868
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/EGvrw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEDA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeKEC2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:28:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54925 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbeKEC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:28:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so6045020wma.4;
        Sun, 04 Nov 2018 09:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=TGhpIguxZKqGE+GdUaatDC/UNPrNnEL4NBgLd2GI3no=;
        b=t/EGvrw1MpSeR5jsmJkKVZg/m5oUFjSYOS8yLE8qz4cIL3Gcbn6/iPRjhO5O+lnmSU
         nyZzJwr3j5F7HdkUS6YNQf1+53OZg5+8kIC+4SL8JQzJZDitH1DCBzYlDFMQbnfFDUNc
         UP9aMK5MBCWXWGBkPIToeWyYPU2b58sCramhc7ZshzaAVB3gW5qS75TqutCV0qVJwjxr
         m8FqotY01NXAfi4AFJHJVrZ7YOawRuIEdVDNfuRpyI1evVjJqVxYoxaUkmF5nT6SDB+o
         dFc7PskmcOKqsW1RHd3pQL2cdhDUSEqwVyFUPKsl8g3oGQGC1x99w7QWqO4Ye0zsKEk+
         zqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=TGhpIguxZKqGE+GdUaatDC/UNPrNnEL4NBgLd2GI3no=;
        b=dIxrx5YfJ8hA2WzJ6rMSCZsSHmRzKTKlqgQsGErnoY7gCt6pWNKxZzsKRn1O69I69u
         UuMJHXZ+3tn4Foh/60hdZpsqZNv+gs+kPc6tSqnx0P7QoD54b9hjGpH7I9URXLmvRitz
         HRmeGpi1Er8Lw0ejnFFecNzJVcik45FLQpX+nsKvui03dDHTje3dSY39x7p8uFNXzFkp
         2uTDbZQrKOY86dNrstX9ewAjHpwsU1An4gPeeLgdhwHu6izwCNUOOmEjb9Vsi7bYqxup
         bOZKb4oSgbIe0Uzz17X3aktnQv6ttcBHay7P4qI0JLpuA6+nIg5b9v/iKFON8OjhA7iP
         /4MQ==
X-Gm-Message-State: AGRZ1gIPfiCd0NLXBE4padr0dBp9XIHH5E7yHZsPWXllV4zbN2l0ycEB
        Rgz56VqtC74g4rhkHxaAzgw=
X-Google-Smtp-Source: AJdET5ejay/sWk71bozJheRrobQzLIg9jrGDQJAiR0ikmiurOlkCuZvlKrsGOAnug1qWJDWykMx8gA==
X-Received: by 2002:a1c:578c:: with SMTP id l134-v6mr3895086wmb.135.1541351555736;
        Sun, 04 Nov 2018 09:12:35 -0800 (PST)
Received: from localhost.localdomain ([41.35.162.9])
        by smtp.gmail.com with ESMTPSA id r2-v6sm23707749wrq.1.2018.11.04.09.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 09:12:35 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        "Ahmed Lotfy igor . stoppa @ gmail . com" <A7med.lotfey@gmail.com>
Subject: [PATCH V6 8/8] KVM: Log ROE violations in system log
Date:   Sun,  4 Nov 2018 19:11:24 +0200
Message-Id: <20181104171124.5717-9-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
References: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 virt/kvm/kvm_main.c    |  7 +++++++
 virt/kvm/roe.c         | 14 ++++++++++++++
 virt/kvm/roe_generic.h |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 48c5d9d9474e..d625db7f5350 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -63,6 +63,8 @@
 #include "vfio.h"
 #include "roe_generic.h"
 
+#include <kvm/roe.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/kvm.h>
 
@@ -1867,6 +1869,7 @@ static u64 roe_gfn_to_hva(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
 	addr = __gfn_to_hva_many(slot, gfn, NULL, false);
 	return addr;
 }
+
 static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
@@ -1874,6 +1877,10 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 	unsigned long addr;
 
 	addr = roe_gfn_to_hva(memslot, gfn, offset, len);
+	if (gfn_is_full_roe(memslot, gfn) ||
+			kvm_roe_check_range(memslot, gfn, offset, len))
+		kvm_warning_roe_violation((gfn << PAGE_SHIFT) + offset, data,
+				len);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 	r = __copy_to_user((void __user *)addr + offset, data, len);
diff --git a/virt/kvm/roe.c b/virt/kvm/roe.c
index e94314fed3a3..c30c6b028638 100644
--- a/virt/kvm/roe.c
+++ b/virt/kvm/roe.c
@@ -76,6 +76,20 @@ void kvm_roe_free(struct kvm_memory_slot *slot)
 	kvfree(slot->prot_list);
 }
 
+void kvm_warning_roe_violation(u64 addr, const void *data, int len)
+{
+	int i;
+	const char *d = data;
+	char *buf = kvmalloc(len * 3 + 1, GFP_KERNEL);
+
+	for (i = 0; i < len; i++)
+		sprintf(buf+3*i, " %02x", d[i]);
+	pr_warn("ROE violation:\n");
+	pr_warn("\tAttempt to write %d bytes at address 0x%08llx\n", len, addr);
+	pr_warn("\tData: %s\n", buf);
+	kvfree(buf);
+}
+
 static void kvm_roe_protect_slot(struct kvm *kvm, struct kvm_memory_slot *slot,
 		gfn_t gfn, u64 npages, bool partial)
 {
diff --git a/virt/kvm/roe_generic.h b/virt/kvm/roe_generic.h
index 006fc7b52bba..bce426441468 100644
--- a/virt/kvm/roe_generic.h
+++ b/virt/kvm/roe_generic.h
@@ -11,6 +11,7 @@
  */
 #ifdef CONFIG_KVM_ROE
 
+void kvm_warning_roe_violation(u64 addr, const void *data, int len);
 void kvm_roe_free(struct kvm_memory_slot *slot);
 int kvm_roe_init(struct kvm_memory_slot *slot);
 bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
@@ -39,6 +40,7 @@ static bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn,
 {
 	return false;
 }
+static void kvm_warning_roe_violation(u64 addr, const void *data, int len) {}
 #endif
 
 #endif
-- 
2.18.1

