Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520452162-2-3337868980959597135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452161; b=DBvPm0YQQlvQM/0GwAQ/2astxyOL/iME4HtLqln2c8clmoX
    mfbNBqY86SSYgJP4OhH9hhqfFh5QqxbnDemESZMs9kkEnnFAkCXRyZcGbiYYST4I
    Z5AZ3fg9DndvkiYjxwoAG+ksfGDQOdU8A9VOM1v97dzpKOBwRQOuIWOitZ9zyZ4f
    kcFoK8colX2D53BRFDTGuJs5JIfZV2h4LFiIXXYrzPyosUExULOXFwh+3aH4Q4bN
    zngDv8r4tOKxrUCxWYJ62lUENmVv7LHGY7mVDUGxvbBL1IC1sJUDgNinSMZydnjn
    eOzoTFC4vVqu6+0pU9Tmuio1Ivv0k5GfJAs6LqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452161; bh=5duhG4hFlOoBBQrFeSm4bhG1pS
    YLy9G2Ouw390nAaGs=; b=mAut3muJMoOfhzVQVOgdrx7EOy8Wyu8Kf78JCmoKLs
    kDlLVHWNJ+fpCq2zlgkTswf1IoqrMtA6pvXL5r+iy3e6o0Tj28vsEplABQkI9JqN
    /0uEiw83o5i6vL04Iqec7OdgEouGbON5xIl8V4IDdVzJeaZ8ow8aGwW7kWhNrjYY
    rdR9ucHT10+fFtkKlKZefyvNjJSiUONWgeJ+OJjNaq5vTPsXJrl9SszQPbjxfa3U
    Hx/xo+UKtwiRqSmI+URbRrzOrP8/Hg5k6zo6yvYIiuz6Hs0mp3Wt94hnhVNFWT4R
    tOgQy+FUa/U9B57ah7pNY6ATjlJSg4PMRuBxSfS2JBPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935068AbeCGTsd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:48:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965910AbeCGTsa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:48:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Backlund <tmb@mageia.org>
Subject: [PATCH 4.14 096/110] KVM: x86: extend usage of RET_MMIO_PF_* constants
Date: Wed,  7 Mar 2018 11:39:19 -0800
Message-Id: <20180307191052.144322273@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 9b8ebbdb74b5ad76b9dfd8b101af17839174b126 upstream.

The x86 MMU if full of code that returns 0 and 1 for retry/emulate.  Use
the existing RET_MMIO_PF_RETRY/RET_MMIO_PF_EMULATE enum, renaming it to
drop the MMIO part.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Backlund <tmb@mageia.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c         |   95 +++++++++++++++++++++------------------------
 arch/x86/kvm/paging_tmpl.h |   18 ++++----
 2 files changed, 55 insertions(+), 58 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -150,6 +150,20 @@ module_param(dbg, bool, 0644);
 /* make pte_list_desc fit well in cache line */
 #define PTE_LIST_EXT 3
 
+/*
+ * Return values of handle_mmio_page_fault and mmu.page_fault:
+ * RET_PF_RETRY: let CPU fault again on the address.
+ * RET_PF_EMULATE: mmio page fault, emulate the instruction directly.
+ *
+ * For handle_mmio_page_fault only:
+ * RET_PF_INVALID: the spte is invalid, let the real page fault path update it.
+ */
+enum {
+	RET_PF_RETRY = 0,
+	RET_PF_EMULATE = 1,
+	RET_PF_INVALID = 2,
+};
+
 struct pte_list_desc {
 	u64 *sptes[PTE_LIST_EXT];
 	struct pte_list_desc *more;
@@ -2794,13 +2808,13 @@ done:
 	return ret;
 }
 
-static bool mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
-			 int write_fault, int level, gfn_t gfn, kvm_pfn_t pfn,
-			 bool speculative, bool host_writable)
+static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
+			int write_fault, int level, gfn_t gfn, kvm_pfn_t pfn,
+		       	bool speculative, bool host_writable)
 {
 	int was_rmapped = 0;
 	int rmap_count;
-	bool emulate = false;
+	int ret = RET_PF_RETRY;
 
 	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
 		 *sptep, write_fault, gfn);
@@ -2830,12 +2844,12 @@ static bool mmu_set_spte(struct kvm_vcpu
 	if (set_spte(vcpu, sptep, pte_access, level, gfn, pfn, speculative,
 	      true, host_writable)) {
 		if (write_fault)
-			emulate = true;
+			ret = RET_PF_EMULATE;
 		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	}
 
 	if (unlikely(is_mmio_spte(*sptep)))
-		emulate = true;
+		ret = RET_PF_EMULATE;
 
 	pgprintk("%s: setting spte %llx\n", __func__, *sptep);
 	pgprintk("instantiating %s PTE (%s) at %llx (%llx) addr %p\n",
@@ -2855,7 +2869,7 @@ static bool mmu_set_spte(struct kvm_vcpu
 
 	kvm_release_pfn_clean(pfn);
 
-	return emulate;
+	return ret;
 }
 
 static kvm_pfn_t pte_prefetch_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn,
@@ -2994,14 +3008,13 @@ static int kvm_handle_bad_page(struct kv
 	 * Do not cache the mmio info caused by writing the readonly gfn
 	 * into the spte otherwise read access on readonly gfn also can
 	 * caused mmio page fault and treat it as mmio access.
-	 * Return 1 to tell kvm to emulate it.
 	 */
 	if (pfn == KVM_PFN_ERR_RO_FAULT)
-		return 1;
+		return RET_PF_EMULATE;
 
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
 		kvm_send_hwpoison_signal(kvm_vcpu_gfn_to_hva(vcpu, gfn), current);
-		return 0;
+		return RET_PF_RETRY;
 	}
 
 	return -EFAULT;
@@ -3286,13 +3299,13 @@ static int nonpaging_map(struct kvm_vcpu
 	}
 
 	if (fast_page_fault(vcpu, v, level, error_code))
-		return 0;
+		return RET_PF_RETRY;
 
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
 	if (try_async_pf(vcpu, prefault, gfn, v, &pfn, write, &map_writable))
-		return 0;
+		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, v, gfn, pfn, ACC_ALL, &r))
 		return r;
@@ -3312,7 +3325,7 @@ static int nonpaging_map(struct kvm_vcpu
 out_unlock:
 	spin_unlock(&vcpu->kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
-	return 0;
+	return RET_PF_RETRY;
 }
 
 
@@ -3659,54 +3672,38 @@ exit:
 	return reserved;
 }
 
-/*
- * Return values of handle_mmio_page_fault:
- * RET_MMIO_PF_EMULATE: it is a real mmio page fault, emulate the instruction
- *			directly.
- * RET_MMIO_PF_INVALID: invalid spte is detected then let the real page
- *			fault path update the mmio spte.
- * RET_MMIO_PF_RETRY: let CPU fault again on the address.
- * RET_MMIO_PF_BUG: a bug was detected (and a WARN was printed).
- */
-enum {
-	RET_MMIO_PF_EMULATE = 1,
-	RET_MMIO_PF_INVALID = 2,
-	RET_MMIO_PF_RETRY = 0,
-	RET_MMIO_PF_BUG = -1
-};
-
 static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr, bool direct)
 {
 	u64 spte;
 	bool reserved;
 
 	if (mmio_info_in_cache(vcpu, addr, direct))
-		return RET_MMIO_PF_EMULATE;
+		return RET_PF_EMULATE;
 
 	reserved = walk_shadow_page_get_mmio_spte(vcpu, addr, &spte);
 	if (WARN_ON(reserved))
-		return RET_MMIO_PF_BUG;
+		return -EINVAL;
 
 	if (is_mmio_spte(spte)) {
 		gfn_t gfn = get_mmio_spte_gfn(spte);
 		unsigned access = get_mmio_spte_access(spte);
 
 		if (!check_mmio_spte(vcpu, spte))
-			return RET_MMIO_PF_INVALID;
+			return RET_PF_INVALID;
 
 		if (direct)
 			addr = 0;
 
 		trace_handle_mmio_page_fault(addr, gfn, access);
 		vcpu_cache_mmio_info(vcpu, addr, gfn, access);
-		return RET_MMIO_PF_EMULATE;
+		return RET_PF_EMULATE;
 	}
 
 	/*
 	 * If the page table is zapped by other cpus, let CPU fault again on
 	 * the address.
 	 */
-	return RET_MMIO_PF_RETRY;
+	return RET_PF_RETRY;
 }
 EXPORT_SYMBOL_GPL(handle_mmio_page_fault);
 
@@ -3756,7 +3753,7 @@ static int nonpaging_page_fault(struct k
 	pgprintk("%s: gva %lx error %x\n", __func__, gva, error_code);
 
 	if (page_fault_handle_page_track(vcpu, error_code, gfn))
-		return 1;
+		return RET_PF_EMULATE;
 
 	r = mmu_topup_memory_caches(vcpu);
 	if (r)
@@ -3877,7 +3874,7 @@ static int tdp_page_fault(struct kvm_vcp
 	MMU_WARN_ON(!VALID_PAGE(vcpu->arch.mmu.root_hpa));
 
 	if (page_fault_handle_page_track(vcpu, error_code, gfn))
-		return 1;
+		return RET_PF_EMULATE;
 
 	r = mmu_topup_memory_caches(vcpu);
 	if (r)
@@ -3894,13 +3891,13 @@ static int tdp_page_fault(struct kvm_vcp
 	}
 
 	if (fast_page_fault(vcpu, gpa, level, error_code))
-		return 0;
+		return RET_PF_RETRY;
 
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
 	if (try_async_pf(vcpu, prefault, gfn, gpa, &pfn, write, &map_writable))
-		return 0;
+		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, 0, gfn, pfn, ACC_ALL, &r))
 		return r;
@@ -3920,7 +3917,7 @@ static int tdp_page_fault(struct kvm_vcp
 out_unlock:
 	spin_unlock(&vcpu->kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
-	return 0;
+	return RET_PF_RETRY;
 }
 
 static void nonpaging_init_context(struct kvm_vcpu *vcpu,
@@ -4919,25 +4916,25 @@ int kvm_mmu_page_fault(struct kvm_vcpu *
 		vcpu->arch.gpa_val = cr2;
 	}
 
+	r = RET_PF_INVALID;
 	if (unlikely(error_code & PFERR_RSVD_MASK)) {
 		r = handle_mmio_page_fault(vcpu, cr2, direct);
-		if (r == RET_MMIO_PF_EMULATE) {
+		if (r == RET_PF_EMULATE) {
 			emulation_type = 0;
 			goto emulate;
 		}
-		if (r == RET_MMIO_PF_RETRY)
-			return 1;
-		if (r < 0)
-			return r;
-		/* Must be RET_MMIO_PF_INVALID.  */
 	}
 
-	r = vcpu->arch.mmu.page_fault(vcpu, cr2, lower_32_bits(error_code),
-				      false);
+	if (r == RET_PF_INVALID) {
+		r = vcpu->arch.mmu.page_fault(vcpu, cr2, lower_32_bits(error_code),
+					      false);
+		WARN_ON(r == RET_PF_INVALID);
+	}
+
+	if (r == RET_PF_RETRY)
+		return 1;
 	if (r < 0)
 		return r;
-	if (!r)
-		return 1;
 
 	/*
 	 * Before emulating the instruction, check if the error code
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -593,7 +593,7 @@ static int FNAME(fetch)(struct kvm_vcpu
 	struct kvm_mmu_page *sp = NULL;
 	struct kvm_shadow_walk_iterator it;
 	unsigned direct_access, access = gw->pt_access;
-	int top_level, emulate;
+	int top_level, ret;
 
 	direct_access = gw->pte_access;
 
@@ -659,15 +659,15 @@ static int FNAME(fetch)(struct kvm_vcpu
 	}
 
 	clear_sp_write_flooding_count(it.sptep);
-	emulate = mmu_set_spte(vcpu, it.sptep, gw->pte_access, write_fault,
-			       it.level, gw->gfn, pfn, prefault, map_writable);
+	ret = mmu_set_spte(vcpu, it.sptep, gw->pte_access, write_fault,
+			   it.level, gw->gfn, pfn, prefault, map_writable);
 	FNAME(pte_prefetch)(vcpu, gw, it.sptep);
 
-	return emulate;
+	return ret;
 
 out_gpte_changed:
 	kvm_release_pfn_clean(pfn);
-	return 0;
+	return RET_PF_RETRY;
 }
 
  /*
@@ -762,12 +762,12 @@ static int FNAME(page_fault)(struct kvm_
 		if (!prefault)
 			inject_page_fault(vcpu, &walker.fault);
 
-		return 0;
+		return RET_PF_RETRY;
 	}
 
 	if (page_fault_handle_page_track(vcpu, error_code, walker.gfn)) {
 		shadow_page_table_clear_flood(vcpu, addr);
-		return 1;
+		return RET_PF_EMULATE;
 	}
 
 	vcpu->arch.write_fault_to_shadow_pgtable = false;
@@ -789,7 +789,7 @@ static int FNAME(page_fault)(struct kvm_
 
 	if (try_async_pf(vcpu, prefault, walker.gfn, addr, &pfn, write_fault,
 			 &map_writable))
-		return 0;
+		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, addr, walker.gfn, pfn, walker.pte_access, &r))
 		return r;
@@ -834,7 +834,7 @@ static int FNAME(page_fault)(struct kvm_
 out_unlock:
 	spin_unlock(&vcpu->kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
-	return 0;
+	return RET_PF_RETRY;
 }
 
 static gpa_t FNAME(get_level1_sp_gpa)(struct kvm_mmu_page *sp)
