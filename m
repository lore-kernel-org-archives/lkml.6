Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653221-2-16984233454987029260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653221; b=goRgZKN8vVKTuFS8PGExr3HDSWAJ5Uq7iX6kS8c/bNG34T611p
    miAWVxfZF0UjnDJD6OI9nOYGNgju9FoXPt+oicEYbYaeoxRJJbTQ19KlpJMtH3dZ
    tgPLdeAsjugJIdwqkmWYjV9n9v0u+rAb8zPB1xyDp81b1/vj0GgpuBhvHqSwUMgZ
    K91E98wOjDvx0KBGYnRT9L6y3KAjRttz1tUlf3Agcomi9Oq5u2+OuQQJN2Ve54Bs
    o/0YakhK134DhPj/zLctUTswYLygURQv+uOazZjIKD5zwqQ+cmpGPWm+cPUnAqlF
    WcnSOImF2MyEv89Ib5/6A7Halou7l7Ll06zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653221; bh=tK5pCmL5d9Y3D3GBkLCmvdFtm48QLM
    ksrXawUdFLaMc=; b=CLxFI4x/SVFglSYzuGUTPcBlxgKoEaRsciB6UsA+D/zsi+
    W3hJnMaBMk0AsNC8Lk4qgJMz+EljPxK13HZ0Fwbx7nT7D6N/+TgjJfMkXWPlyaOp
    PjnhjDzcsIfZ0f7T+AcORZk3uV1l4CQPG5jRQDJM4MilBjnqPHrOs16Z8mGds0AS
    MsCQ5tBJyRJ4ho0Xk3jrmlG3yLCbm0a5EQ5RB5yQu6qxTugHe7oCA/gX7dm0Bium
    zCgiCgk9S5P6+jBSKBV0mtvQA4aMdf+q2Vj9/HNW7s7dHBzzAzSmDG9BHYEFibDE
    ABu13j8JHit2qC0WCRbiiRMGJN5lpCW302JElSOQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFCKmzKhgX07zvLIEdTNl4HRORM7yBN3KKfc562NjEBJ8hDr0/XKrTvizzlXRQvgr+PeBKbcysnHZQwCJgA30iSdIxLLSiFW4JOPQeMzdIiOq+UIFmNB
    9DlfD1O8r2h6ttG7SNd28bJ36rgxgXGERc74XKNz6Q1JhuFZaqurtvoUvhUcVJbKLIDrzOkrRVULDGzKo0nhP+mMy3ygauazXcbX8amOFsoYDn4Dv8p1tRKC
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8
    a=4TtXiYhEuDbnHRW8oSIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeDYKqq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:46:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbeDYKo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:44:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 182/183] Revert "KVM: X86: Fix SMRAM accessing even if VM is shutdown"
Date: Wed, 25 Apr 2018 12:36:42 +0200
Message-Id: <20180425103249.812470292@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 2c151b25441ae5c2da66472abd165af785c9ecd2 upstream.

The bug that led to commit 95e057e25892eaa48cad1e2d637b80d0f1a4fac5
was a benign warning (no adverse affects other than the warning
itself) that was detected by syzkaller.  Further inspection shows
that the WARN_ON in question, in handle_ept_misconfig(), is
unnecessary and flawed (this was also briefly discussed in the
original patch: https://patchwork.kernel.org/patch/10204649).

  * The WARN_ON is unnecessary as kvm_mmu_page_fault() will WARN
    if reserved bits are set in the SPTEs, i.e. it covers the case
    where an EPT misconfig occurred because of a KVM bug.

  * The WARN_ON is flawed because it will fire on any system error
    code that is hit while handling the fault, e.g. -ENOMEM can be
    returned by mmu_topup_memory_caches() while handling a legitmate
    MMIO EPT misconfig.

The original behavior of returning -EFAULT when userspace munmaps
an HVA without first removing the memslot is correct and desirable,
i.e. KVM is letting userspace know it has generated a bad address.
Returning RET_PF_EMULATE masks the WARN_ON in the EPT misconfig path,
but does not fix the underlying bug, i.e. the WARN_ON is bogus.

Furthermore, returning RET_PF_EMULATE has the unwanted side effect of
causing KVM to attempt to emulate an instruction on any page fault
with an invalid HVA translation, e.g. a not-present EPT violation
on a VM_PFNMAP VMA whose fault handler failed to insert a PFN.

  * There is no guarantee that the fault is directly related to the
    instruction, i.e. the fault could have been triggered by a side
    effect memory access in the guest, e.g. while vectoring a #DB or
    writing a tracing record.  This could cause KVM to effectively
    mask the fault if KVM doesn't model the behavior leading to the
    fault, i.e. emulation could succeed and resume the guest.

  * If emulation does fail, KVM will return EMULATION_FAILED instead
    of -EFAULT, which is a red herring as the user will either debug
    a bogus emulation attempt or scratch their head wondering why we
    were attempting emulation in the first place.

TL;DR: revert to returning -EFAULT and remove the bogus WARN_ON in
handle_ept_misconfig in a future patch.

This reverts commit 95e057e25892eaa48cad1e2d637b80d0f1a4fac5.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3019,7 +3019,7 @@ static int kvm_handle_bad_page(struct kv
 		return RET_PF_RETRY;
 	}
 
-	return RET_PF_EMULATE;
+	return -EFAULT;
 }
 
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
