Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520B3C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BF22054F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="z1TUJhC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BF22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeLGQX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:23:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32813 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeLGQX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:23:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so4391650wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ZLMRK1sa14ZeWEcMpGckEyj8BI4tsg92VSqXi44f2k=;
        b=z1TUJhC/ICXd7VUEA7Zc9hLkfQ9RfS+KHHrmxIjly7beF6KVxTS+6rzLEs2J2ur9MT
         coAAwfSGk1MfNZxQItV0Rs4baXK/aFwLaaSEyCCF6J7S15hMOLm+GOhMp+7apzqVxgwM
         bnJxdcRXzUNcbo9uCcR2I9VowdftyuzVRjmpU5hQCltb5ofH48xrbHUVDK4TDYl9Y0Cy
         uO3pQ7tR4tqtSSw3Sa+zF+Fg3YrvFFuTOlwhKh3xxlXBvBpF+PJ82xi5rjuKCf5eRrB9
         N8aWEjzoqw7tLtcNW0f1yqj2FEHkAYuC7zvnjjvGsnxvpQYEUwaW5ULomgRSbLR8ZoMH
         /JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZLMRK1sa14ZeWEcMpGckEyj8BI4tsg92VSqXi44f2k=;
        b=L1fSsuU/hb9S+jx4pn3mQqx2+JTSf1zJsXD6mqeFzE4AH5gW3YMWRH7AXBNrixYULZ
         abRJeD2WECD9e6S6P6jSblLh79ITKWKOn1dcirXxVDCWDr1wmC79oHa+wxnLpMW6aG8v
         uap0bXMK/KT2VGiOOm/zkRE/3dA+TVsCG4sqC7Z6sHE0WNJvIF8MRqbBnCklz0aGESS2
         zFp3DXQpXoAcGeAuSEzRb175HoEzlwRFmuCPatWEryPOgeTh8uEL6aaBljHTtAadCDDn
         af1R6FoIqQZJRpCZCSgcfBXDiOwJj2ufoabEy11hpiYfloxryXogFrIWH82dwjOHUeyK
         1mzQ==
X-Gm-Message-State: AA+aEWYgF48UnZtiBiwo9NHuBZMx8X819At6vozhZNXjge0AjVc1Konp
        QP16kXTdP+UmvoR5rcPs4fXDUQ==
X-Google-Smtp-Source: AFSGD/UkT9Ta/PzidJmaQ+Am56ke5yurCQxQ2pToh570695xGXOPEh8uXHqsdnU0qD0vzyXjJMdsrA==
X-Received: by 2002:adf:8228:: with SMTP id 37mr2289815wrb.160.1544199837389;
        Fri, 07 Dec 2018 08:23:57 -0800 (PST)
Received: from localhost.localdomain ([156.213.98.90])
        by smtp.gmail.com with ESMTPSA id a1sm2378073wrw.76.2018.12.07.08.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 08:23:56 -0800 (PST)
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
Subject: RESEND [PATCH 10/10] KVM: Log ROE violations in system log
Date:   Fri,  7 Dec 2018 18:23:15 +0200
Message-Id: <20181207162315.6004-1-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am absolutely sorry, I had some modifications that I forgot to commit
before I send. so please use this one patch 10/10 instead of the last
one.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 virt/kvm/kvm_main.c    |  3 ++-
 virt/kvm/roe.c         | 26 ++++++++++++++++++++++++++
 virt/kvm/roe_generic.h |  3 ++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c3a21d3bc8..761cb7561a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1870,13 +1870,14 @@ static u64 roe_gfn_to_hva(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
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
index 6555838f0c..01362f0fca 100644
--- a/virt/kvm/roe.c
+++ b/virt/kvm/roe.c
@@ -76,6 +76,32 @@ void kvm_roe_free(struct kvm_memory_slot *slot)
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
+	if (!gfn_is_full_roe(memslot, gfn))
+		return;
+	if (!kvm_roe_check_range(memslot, gfn, offset, len))
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

