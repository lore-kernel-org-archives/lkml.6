Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1336C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975B8208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="XgJFjDXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975B8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeLGMtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:49:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42893 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLGMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:49:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so3675301wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8WR3nfZ+UXawr7R//GnRUy/7E5Oz6Kr5I5N3ItmtOwA=;
        b=XgJFjDXXpxuO5DPzmfvD7ouX2XxqdC6F4pcGXKK0R2tvBXJyw+Nw5D38eOQKsUv1yJ
         w/DIegcnPPPWksE8FPD5ium12Lvwj6kPzCoek9IsWuK7gwEDoMt7dR9zTdkS+T9s9bvq
         ZLAsnkr91HoIltBgUbHteWWnl1Hh3XhHRQDYlhY+rzJLRRT/L9mYY5J5R4Iy5LXlvi9j
         z7ch89Mf2xau8p8XP7PJzWvQ6/wUrjKuz3VZPvW+Zo28sQNrFswQiwGz4XzlxcPy2dlz
         oSY3/koIjjyHIri9oT4KDnieBCua/yB8JxnS69UUKcxzElquzW2ljPTlPoFBqAKpXBJu
         7aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WR3nfZ+UXawr7R//GnRUy/7E5Oz6Kr5I5N3ItmtOwA=;
        b=SeMsELy3lFE/b6lAQ8nNnUbx6e8ZJnxu71eXi9LILnROd+C0N1ruTMLko9JXtGupVS
         5WWzu6t05/2Uew0S0Mcy8iyUP96osQYOeMVyQjZbLzSAPE1rSS61HHNRcgPhrGIYS1Hw
         Er+ymEsKbeLCZlU50RqyGgLbOzNfF2gCgpNtTplSWHInx/9FGu750qSkPsGScPvrN3DP
         3JB83s1V4XVEiD9r9HRw+bvtPJxL+zvsFjcTNGk1e4URuT4wUsUXmY1r5YE9XOvIVicl
         Ajw91OB6pMroNCtvBwESOrQe0IGooVfGF1euyjdlrechnub2HIKyaAYYU+XpPV8J/w3z
         yzGQ==
X-Gm-Message-State: AA+aEWaaPB52jv1vRms/0HrPwzysGv9R8Fka/GV41WU23RL7W+CeWpIF
        agLcfDcbcAAnAe+4Njnis55h2w==
X-Google-Smtp-Source: AFSGD/Uvbb9zxQ6Le59/z2g9FbUPsfQ3vtkpDzJJRcigKi93yPTIA3dAjUHEfENdbeVJt5hQt2tGqA==
X-Received: by 2002:adf:e707:: with SMTP id c7mr1616063wrm.196.1544186975504;
        Fri, 07 Dec 2018 04:49:35 -0800 (PST)
Received: from localhost.localdomain ([156.213.98.90])
        by smtp.gmail.com with ESMTPSA id i192sm4362949wmg.7.2018.12.07.04.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:49:35 -0800 (PST)
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
Subject: [PATCH 10/10] KVM: Log ROE violations in system log
Date:   Fri,  7 Dec 2018 14:48:03 +0200
Message-Id: <20181207124803.10828-11-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 virt/kvm/kvm_main.c    |  5 +++++
 virt/kvm/roe.c         | 14 ++++++++++++++
 virt/kvm/roe_generic.h |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c3a21d3bc8..661933053f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1870,6 +1870,7 @@ static u64 roe_gfn_to_hva(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
 	addr = __gfn_to_hva_many(slot, gfn, NULL, false);
 	return addr;
 }
+
 static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
@@ -1877,6 +1878,10 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
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
index 6555838f0c..36b85fb303 100644
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
index f1ce4a8aec..8c191362cd 100644
--- a/virt/kvm/roe_generic.h
+++ b/virt/kvm/roe_generic.h
@@ -14,5 +14,5 @@ void kvm_roe_free(struct kvm_memory_slot *slot);
 int kvm_roe_init(struct kvm_memory_slot *slot);
 bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
 		int len);
-
+void kvm_warning_roe_violation(u64 addr, const void *data, int len);
 #endif
-- 
2.19.2

