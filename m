Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00261C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FF9206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM10repy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfADIzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:55:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37689 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfADIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:55:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so17999622pfb.4;
        Fri, 04 Jan 2019 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bFhTxRoojn12l2v/yr4tpMYZ43n7CONVzFkfmruJPC4=;
        b=rM10repyD4Y8kcaAjETDg1X0Bu+JhXLQo7cbDWx1hrA5ucTIzCisQdDHXPXEW3YmC6
         Dy/1/PYVjvwOG3yOmAmghVexXTkBXomdTbwfMEKLdoeeqxbADR+1XxYbZaLPz9sV/2zP
         vAyRxQSq338vFtvyc64w5EJxUPHWh5PyII0oOi1UqvjX1OV76erQvJtnIu1iX2qXzR0z
         4hWxsOGZ1df656/DeY6cw8iLEU5qHIXTLLthKxvVEQSIGqmJu0mug0SAZcWBpZBy/vmw
         qJKb21fNaCA2jjoesZ8A+Ms898MgN7NXyWh8Hnaw81sTt9FZeGbAiKK0rhudGJM3bpEc
         cmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bFhTxRoojn12l2v/yr4tpMYZ43n7CONVzFkfmruJPC4=;
        b=JlKZ1qhIbyy7XfBdvo5gKBjrsc441qReDQOWn+IpVrY7/shlOnghT4Wv2q84zlGbqB
         h1luAwAyyhjI0dEzulr1lkj2HNFYwAL/q0CJM70otFCdXf4Sjy36lriBmB5ppI2x9uyL
         zMrQdRSlEPcnL1ieDykn2xtLHwiJV0quZ5MnIc71Abu/cFxHOcI9X/JTTEP2NON3RtbZ
         3ESkq+euUebcvSJiMHspwl2fFjaIGcTcCaYUTmGnbHYCZ8H/Pfeky7R3i6JdZAhO4EU+
         0MKolqE+Pr1wUMCe+QkQO1cBDNODQi+7H5Z6uQwCWfIT42WfR/ipVRPdC1k2JL7lxOd0
         v13w==
X-Gm-Message-State: AA+aEWZp9I4soD+9iu7h7JFdRUO9Mm7UTJIk3wR0FII2TTeSkQTdaIti
        dwUP+DKukA17mSUoDjD/ZsM=
X-Google-Smtp-Source: AFSGD/WLbcK/sBL1vUFtY+st3cDiVTDCkscYZofl5pg01nGixnT8QCsj2JBsXfbZXiFRU4LU4JyZ2g==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr51896451pfb.55.1546592139149;
        Fri, 04 Jan 2019 00:55:39 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:55:38 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [PATCH 11/11] KVM/MMU: Flush tlb in the kvm_age_rmapp()
Date:   Fri,  4 Jan 2019 16:54:05 +0800
Message-Id: <20190104085405.40356-12-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb in the kvm_age_rmapp() when tlb range flush
is available and flush request is true.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index a5728f51bf7d..bc402a72956a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1958,10 +1958,17 @@ static int kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 	u64 *sptep;
 	struct rmap_iterator uninitialized_var(iter);
 	int young = 0;
+	bool flush = (bool)data;
 
 	for_each_rmap_spte(rmap_head, &iter, sptep)
 		young |= mmu_spte_age(sptep);
 
+	if (young && flush) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn,
+				KVM_PAGES_PER_HPAGE(level));
+		young = 0;
+	}
+
 	trace_kvm_age_page(gfn, level, slot, young);
 	return young;
 }
-- 
2.14.4

