Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833122-2-17053860543260947455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833122; b=Ev79uqBN5JuqOCz659xmMxW1yl43M3xAVsHE08kVY9RFv9J
    zqCrzBHh1UFmKjFpzb1/zw1ejgV4g8C3m2bRnseX86mp5q0hAWbNl8YNCCfD3VzU
    DLgVa4wccC0QZCm13xaptNTflmpByqqf+bVKIQf2ukjQK61lLp6h6+bB5LcErSx1
    dsqcCSPM2RxfdKSYppI5iXavk5ckEb4AjEJOxZ/523cpBgwU8hq7mcqlJIO5F/Nw
    PR8xBbIS1w+4MGyMCQG4KOxtyiSLdXWI0SyxAcczps6JfYuCzPH71CnT+yP9ZXjB
    MPOufyuKxN5jFRlO3Lm016Zs+TCjOD8w5GV5n5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833122; bh=0KNh+9ynCrlfDR5pc9Q
    hL9RE3vtrH7JhChnW9L8wyh0=; b=wMKqn2b2P5n+FUU/e2EUBK6KZsokLrmKr4I
    pZfc6TUMLWBOtE6oeD+Tmw5imBEbvA7QAhSW9fPLa54nR9moNGphx3cDnkmkVMPB
    pZgt/j5HcGeSCczxWiXopkyhAj3GlO6uSD9csAiqBnDjAjTHZzvcVEnFKkPGvcX2
    tpPNs0yuoQKzfAzpZwx+YZFO0ZLxYZpQ9qx2XbU2sbtKihK+lItnZjfUoieABfBr
    j9RZ/fG5flfbc3fDUe8Kk84yVnpCwzgDeC4JujEJXsiQmNIbEezd+gY5pQlAw4go
    B7ZlxGvNsGZstcXPrLEDj0S8NuhenICsGvbDig66CWRd6HiG7cw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933736AbeB1Pv7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:51:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34360 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933379AbeB1Pvx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:51:53 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Wanpeng Li" <wanpeng.li@hotmail.com>,
        "Liran Alon" <liran.alon@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Nikita Leshenko" <nikita.leshchenko@oracle.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.504012612@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 003/254] KVM: x86: Exit to user-mode on #UD intercept
 when emulator requires
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>

commit 61cb57c9ed631c95b54f8e9090c89d18b3695b3c upstream.

Instruction emulation after trapping a #UD exception can result in an
MMIO access, for example when emulating a MOVBE on a processor that
doesn't support the instruction.  In this case, the #UD vmexit handler
must exit to user mode, but there wasn't any code to do so.  Add it for
both VMX and SVM.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/svm.c | 2 ++
 arch/x86/kvm/vmx.c | 2 ++
 2 files changed, 4 insertions(+)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1776,6 +1776,8 @@ static int ud_interception(struct vcpu_s
 	int er;
 
 	er = emulate_instruction(&svm->vcpu, EMULTYPE_TRAP_UD);
+	if (er == EMULATE_USER_EXIT)
+		return 0;
 	if (er != EMULATE_DONE)
 		kvm_queue_exception(&svm->vcpu, UD_VECTOR);
 	return 1;
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4853,6 +4853,8 @@ static int handle_exception(struct kvm_v
 
 	if (is_invalid_opcode(intr_info)) {
 		er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
+		if (er == EMULATE_USER_EXIT)
+			return 0;
 		if (er != EMULATE_DONE)
 			kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
