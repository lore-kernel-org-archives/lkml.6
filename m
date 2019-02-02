Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CCDC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3767C2075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcBSvhg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfBBBj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:39:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41582 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfBBBjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:39:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so3750147pgq.8;
        Fri, 01 Feb 2019 17:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rByqLCOGvQ8nC7iVvwCr6DlPApr36fgfZWbbNDw3cPc=;
        b=JcBSvhg6DtXatbgMnyQPHGvUT0KXMV+vsEQvkE+bwnES3r8FwaD6AuXKWbGneMDz3s
         aEP9gz3gTzw9afwA1Vn2/whKrqSfJnjlvkxH/60fVrq78G65y2YhzxhMqoSMw/VRwiZC
         dgP1qtfqZasGPDUNv4b3GGuTWfjRYD5EqS8hLpq/97GVas2CizzxVgexa58vT7e4WITd
         azMgVpqULEKmZfeGFvw+m2BQka6NAtIoGdwOu76ZznsaS+VBDxpRT71E0Mc1h19Q5OlU
         d1sJPU2mHk8QHI42wWDvTqlVz6u7A3UgRLvity26FGTvlrRKwNuldw6wMGzlTElyz/zh
         iOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rByqLCOGvQ8nC7iVvwCr6DlPApr36fgfZWbbNDw3cPc=;
        b=MzdOJBpMBqpKcfZH3WkjaYzOTXAOlIYpJ4TWRv1PkuCHnn2m3Vnz6ZEgEHLBXAuI6S
         IsOPU6qDmhlhzeIGFF+n+w1TndaLg7h/LU0gcRLx9zaDvwybnacnz/3b+kOzlIyhAbOC
         c07Z6vkZRNuumdBF/npSFzjShlBV8wV4/6lQGfxbCWEvGxQNYDOBS/85GUwzpZaxPrkl
         IvHqtChiAy/97sgxsNIT47gBC/wne8BbjGG4PKuR+QTA+3DOtKPKKRLfROX2WdcyfnF8
         LOZPcTA6J2zmkvWB+TwbiDLeXVSHVNbucOPm1qdOyIyhWsJ8B5dobZNZcjq9eCF2tLxU
         vsng==
X-Gm-Message-State: AHQUAuY8OJvRnfVMs0VHzMP6MK40wLYF1yy4GIMIKHBUCU0YBYdi3s2S
        ZGx/0GLcIlCOuvFP31VgBNM=
X-Google-Smtp-Source: AHgI3IY4pbsGdSsiplWwzuSajzIs74vE3bWXmAl9AhEm/chKi5rYt5/pCLZhODFUahdG52LiNoncsw==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr4247053pgo.369.1549071565234;
        Fri, 01 Feb 2019 17:39:25 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:39:24 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V2 5/10] KVM/MMU: Flush tlb with range list in sync_page()
Date:   Sat,  2 Feb 2019 09:38:21 +0800
Message-Id: <20190202013825.51261-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb via flush list function. Put
page into flush list when return value of set_spte()
includes flag SET_SPTE_NEED_REMOTE_TLB_FLUSH. kvm_flush_remote_
tlbs_with_list() checks whether the flush list is empty
or not. It also checks whether range tlb flush is available
and go back to tradiion flush if not.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Use check of list_empty in the kvm_flush_remote_tlbs_with_list()
       to determine flush or not instead of checking set_spte_ret.
 
arch/x86/kvm/paging_tmpl.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39829bc..d84486e75345 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -970,7 +970,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	int i, nr_present = 0;
 	bool host_writable;
 	gpa_t first_pte_gpa;
-	int set_spte_ret = 0;
+	HLIST_HEAD(flush_list);
 
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -978,6 +978,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
+		int set_spte_ret = 0;
 		unsigned pte_access;
 		pt_element_t gpte;
 		gpa_t pte_gpa;
@@ -1027,14 +1028,20 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 
 		host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
 
-		set_spte_ret |= set_spte(vcpu, &sp->spt[i],
+		set_spte_ret = set_spte(vcpu, &sp->spt[i],
 					 pte_access, PT_PAGE_TABLE_LEVEL,
 					 gfn, spte_to_pfn(sp->spt[i]),
 					 true, false, host_writable);
+
+		if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH) {
+			struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
+					& PT64_BASE_ADDR_MASK);
+			hlist_add_head(&leaf_sp->flush_link, &flush_list);
+		}
+
 	}
 
-	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+	kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
 
 	return nr_present;
 }
-- 
2.14.4

