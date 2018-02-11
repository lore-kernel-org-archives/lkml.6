Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324554-2-415304867367568087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324554; b=QtLcH+FVBrCMX2bhQ/DssR/5JWBVP6veTlSzHu5qDVdTRTR
    jQAsmaeyirKfGeIUNj7JmXbMJsBppJOciqdDmR2HD5k2SGVtw6NyuC2+F4q+t0fe
    FdXIPSNiBkjCsCff0RFjBI+G6xpkGrzOXYVnQ7tQl1tevmwQ5oHeZUCuGqvQ0hPX
    o5YW5kJFTrJ+n6uJbPjS9XwZa6EWNosqQWcJd91bCdABngL67doSg1Q1f8QSz9aC
    +9C78CxGMh34+ECU0TmpdKs1DoV6DUStMY+OULuRohkwZxvyPin6TBd6vK72noYe
    6kFvNPu5HaWaOhmRTiokwXF2z/tUxnRDUrOt67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324554; bh=gwo2YePGMhVJASC2iAw
    HZnmMzlSIjGzMW0Dld4r5gGI=; b=h0rU/UOmXzmeZFiGyl5ixF6joj2qnIPYgtU
    VRyGWFGoGQQVxHxnZCxwenugRZjck3Op42lz83u7YVzGdNTMQxzhcsSgnNG0UsKZ
    b676hveNfFO7LfeFQ+VU0SaZPEw4+HWhOD4dMzO/1EGK8jReaYr8aHR89dFU0mR7
    epF09xj0kPPvmy4eyMUH+v2qjtn+G7gdgTBUJGQdYNLeFVKZ4vq2mRKlcEQmY17N
    qvAJRXETqN7jP9f9n5ulYBXFpPqlpRFzxwhD4ch78UG7QvqneYJ9xvEPTcvxvKBV
    ZqcxxWYOLwZTm4zwEQCmeLuge6M5ZTbWRN2AkPpDvCQ4zoaMo3w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeBKErw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41816 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752840AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Hildenbrand" <david@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Nick Sarnie" <commendsarnex@gmail.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.984410134@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 089/136] KVM: SVM: obey guest PAT
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 15038e14724799b8c205beb5f20f9e54896013c3 upstream.

For many years some users of assigned devices have reported worse
performance on AMD processors with NPT than on AMD without NPT,
Intel or bare metal.

The reason turned out to be that SVM is discarding the guest PAT
setting and uses the default (PA0=PA4=WB, PA1=PA5=WT, PA2=PA6=UC-,
PA3=UC).  The guest might be using a different setting, and
especially might want write combining but isn't getting it
(instead getting slow UC or UC- accesses).

Thanks a lot to geoff@hostfission.com for noticing the relation
to the g_pat setting.  The patch has been tested also by a bunch
of people on VFIO users forums.

Fixes: 709ddebf81cb40e3c36c6109a7892e8b93a09464
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=196409
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: Nick Sarnie <commendsarnex@gmail.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3157,6 +3157,13 @@ static int svm_set_msr(struct kvm_vcpu *
 	u32 ecx = msr->index;
 	u64 data = msr->data;
 	switch (ecx) {
+	case MSR_IA32_CR_PAT:
+		if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+			return 1;
+		vcpu->arch.pat = data;
+		svm->vmcb->save.g_pat = data;
+		mark_dirty(svm->vmcb, VMCB_NPT);
+		break;
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr);
 		break;
