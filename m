Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68174C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5A520859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="lCl9IyjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfAFTZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:25:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41564 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfAFTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:25:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so29265534edc.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhG1ga+e4jMCr/1icaT0qzsbDovza4q20X40VnRy5Mw=;
        b=lCl9IyjMglES4cIfn8gPTV+/rkcu1w8CQpTU2F6v9KSW/PGPay9juxpdYv2tvQPc0R
         H9Vaq9c9kVnGf9rac+Dv/xeQqPFXNWmVJtqYXZ3yDKg712+InHT9JMMhLcIFkbPlviwK
         A6FgDvGWUMvl8dK+O3Ww+7FkfXKJMvXhoXvU1YVc97ucz+BAmuIs3UZe5mGZH/AhEOuM
         bzo/KBcAx1gJmPFvEIvOCNxxd0sMA8mbR9goOt4RmdhJwgYBvFlS3WuCFnqFZ9skkf3T
         P/lb5NhrH3R/DSbDWORSjFsefZ4HUPg1Pd0ctox+LlKaGgCbD5HSA9pIfWDBziOLFv4S
         fgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhG1ga+e4jMCr/1icaT0qzsbDovza4q20X40VnRy5Mw=;
        b=UQUcumzH9W6PG2yG82D4ISXgeKeR1N+4p2xffPrCZFCvIRIsug65BDgKAJYQw9s9j+
         yDaNwOscaM2XGgNRbVSNgS7ECMeymKJkKcaoHoQH4URYNvOLzhGp+ZItyJSBpkvbwScl
         kRxFpvimEDSEShbXO+QRcOdgHLfE+Y5GShveQyLTOFlkZSyHIzXO6IadT7qyo0PtFrbo
         NsIgzMF94g306LNLtjqnaaNrK3ZR/3YkOrc0nOOAobvJ7NT1F/dADx6z9IL1i7NSUogf
         RzeylfMaObWFKdj9y9iaTNcW+ZrJsZiPD5v5ORdFKklALEOybBfKspDPZtNWYuy/Y5DV
         16FA==
X-Gm-Message-State: AA+aEWbVdNE4ePOajz9vKTU/LeXn6vu7Qpy8LTIGIqrj2bOob6Od5eIF
        a8ImMGZ9WySQNpSZMAKRM+y89Q==
X-Google-Smtp-Source: AFSGD/Vnaq+2h7rtM9sf3o4XRBNoHEGHN4J0XOQA2T3TH7NRYXYEVkR2rHRWz8pPDSe+8LVaqgyruA==
X-Received: by 2002:a17:906:6a9b:: with SMTP id p27-v6mr45497776ejr.235.1546802750477;
        Sun, 06 Jan 2019 11:25:50 -0800 (PST)
Received: from localhost.localdomain ([156.212.65.252])
        by smtp.gmail.com with ESMTPSA id b46sm29994035edd.94.2019.01.06.11.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:25:49 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [PATCH V8 10/11] KVM: Log ROE violations in system log
Date:   Sun,  6 Jan 2019 21:23:44 +0200
Message-Id: <20190106192345.13578-11-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
References: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 virt/kvm/kvm_main.c    |  3 ++-
 virt/kvm/roe.c         | 25 +++++++++++++++++++++++++
 virt/kvm/roe_generic.h |  3 ++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d92d300539..b3dc7255b0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1945,13 +1945,14 @@ static u64 roe_gfn_to_hva(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
 	addr = __gfn_to_hva_many(slot, gfn, NULL, false);
 	return addr;
 }
+
 static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
 	int r;
 	unsigned long addr;
-
 	addr = roe_gfn_to_hva(memslot, gfn, offset, len);
+	kvm_roe_check_and_log(memslot, gfn, data, offset, len);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 	r = __copy_to_user((void __user *)addr + offset, data, len);
diff --git a/virt/kvm/roe.c b/virt/kvm/roe.c
index 9540473f89..e424b45e1c 100644
--- a/virt/kvm/roe.c
+++ b/virt/kvm/roe.c
@@ -76,6 +76,31 @@ void kvm_roe_free(struct kvm_memory_slot *slot)
 	kvfree(slot->prot_list);
 }
 
+static void kvm_warning_roe_violation(u64 addr, const void *data, int len)
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
+void kvm_roe_check_and_log(struct kvm_memory_slot *memslot, gfn_t gfn,
+		const void *data, int offset, int len)
+{
+	if (!memslot)
+		return;
+	if (!gfn_is_full_roe(memslot, gfn) &&
+		!kvm_roe_check_range(memslot, gfn, offset, len))
+		return;
+	kvm_warning_roe_violation((gfn << PAGE_SHIFT) + offset, data, len);
+}
+
 static void kvm_roe_protect_slot(struct kvm *kvm, struct kvm_memory_slot *slot,
 		gfn_t gfn, u64 npages, bool partial)
 {
diff --git a/virt/kvm/roe_generic.h b/virt/kvm/roe_generic.h
index f1ce4a8aec..6c5f0cf381 100644
--- a/virt/kvm/roe_generic.h
+++ b/virt/kvm/roe_generic.h
@@ -14,5 +14,6 @@ void kvm_roe_free(struct kvm_memory_slot *slot);
 int kvm_roe_init(struct kvm_memory_slot *slot);
 bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
 		int len);
-
+void kvm_roe_check_and_log(struct kvm_memory_slot *memslot, gfn_t gfn,
+		const void *data, int offset, int len);
 #endif
-- 
2.19.2

