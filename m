Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326183-2-4216289836714122205
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
    t=1518326183; b=YQZI6FGaWORY3zHKO2GHPPXiPDt0obSp17acnLQsWEVc2kD
    JjAxgx48MJe9dPrKnWkGzffZhkprysZvmXu0sMpDYyhhzYja8ias/jl7HUqeCZDh
    V5fbADi8AqbtrTS9UWMQvceMKLrprMrLRRCxOQlfS5mWtaUnNpnARhQniLA+3lpJ
    mV9bNLJNalmwWxf6gs5FhM6N17F1aUOe91jO9rKpGOuVgZBXMy2GVG14hGEunLpe
    yYGY7jPFmLkChB/p/LF+bnT9wuw+lGVOkCYy6JhIMS9gOHKf7zhXk919h90X90WL
    kkH1UswDdWeIiSl2gSNWJU/KlM9kcPG4nwnuZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326183; bh=eYTjqpoLHhHoVugAzEp
    YWF7H15TcfuKFcNxxcOmM54Q=; b=l1jG3fS1H0yty1+C7tWoNuuDIb8g5M+d7Na
    iTacw/qVYFHWm8kdH8BmsF+eTbx6q4Duzji9mMcsvo/RmdFtE8fegoGMvbyhyKj4
    DmrNBCUrX0Tuo49G0Km8zDKRKNdxavrv5rJKLOlGgGNiiuqy2CaUsfH/X4YPTKCB
    Msryzh0TmIgY7uWO+f0yDbntINZPpnMzs8k26k4X5B2dqAJKUL4PbMBtAvqEwcjy
    9mMzFivYbtUEbkp8YiDxCrVtQV1EP75dNTmGFZGzMO1dZ31SYIVMDZywKqmD5IoA
    AzTlLkBcfJ7h+58fQg4qKAs/U/D0E5zisNe4ElF6CedfUC3VudQ==
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
        id S1753936AbeBKFOU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:14:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41373 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752589AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Nick Sarnie" <commendsarnex@gmail.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.785493443@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 47/79] KVM: SVM: obey guest PAT
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -3040,6 +3040,13 @@ static int svm_set_msr(struct kvm_vcpu *
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	switch (ecx) {
+	case MSR_IA32_CR_PAT:
+		if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+			return 1;
+		vcpu->arch.pat = data;
+		svm->vmcb->save.g_pat = data;
+		mark_dirty(svm->vmcb, VMCB_NPT);
+		break;
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, data);
 		break;
