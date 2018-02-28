Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837210-2-15384028288073543927
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
    t=1519837210; b=Z6uG8Kvw8F8oLVujB8yE+PjkdRJlrVHJzLKGSh1F8vFjuo/
    TXMMaW93rIhcFEJZdercobJ0z9k02gT9ctldC8mXGnq5e2jys6lJ9c9y+272FooC
    hI5gYxNxyOkLbn//pxH9as42bwDZMGXjCr7+gehKDuGwlJNL+xqjOAJeoVgk3UJ0
    gb5iqDdUF2JefOBbXrNnx+FDfFf5jkh/+bEAje/81x9RIb05E5Hv+/Krb5ovUonu
    XgtmCHJynLxXYeGsgN0UwwMJATGOuTm0tMcU9GBNv+DMVn55EGfWe1rcmU18kg6V
    1Cg5WrkC+aXUt72mdUf83xz05+p2dUw4qb8saHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837210; bh=X+BNMbUy4DJf7w97klE
    0j1KDxTBhr3T589zt5kfnDuQ=; b=ep9fzz5eYl0l3B8TXP09rL7SeWvSSudd/M/
    kGcXAztJR31cVMaluE9oIjFVcLkNeJ9yuCTk3+TPWl4bQ99aQEZ5K6CUdT/rl+N/
    y8YVdcDPS3ITKKyYO9ZrH88YmFFghK8P9m6FFmRKIEUTcJJKtewjujYc/NYvqWHW
    ETqlutLN6UBLSVBXRlrHpeLU1zGIVAGhW9SyZUYb4XVgIhr0MHP6ttiOWG18Z/rc
    8ILZENYCBBUot7xyPXjo4Ofsz23U4Tl/RivtnRfjGAj3qMG54yZhMsZG1EdRXAeD
    ck0wYbGhswIAhMrsSZ6gVGNSsxMvnIbUFeXXVTJOZwgMwCLRYVQ==
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
        id S933586AbeB1PwX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:52:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34391 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeB1PwV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:21 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tianyu Lan" <lantianyu1986@gmail.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Jeremi Piotrowski" <jeremi.piotrowski@gmail.com>,
        "Tianyu Lan" <Tianyu.Lan@microsoft.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.483435444@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 213/254] KVM/x86: Fix wrong macro references of
 X86_CR0_PG_BIT and X86_CR4_PAE_BIT in kvm_valid_sregs()
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

From: Tianyu Lan <lantianyu1986@gmail.com>

commit 37b95951c58fdf08dc10afa9d02066ed9f176fb5 upstream.

kvm_valid_sregs() should use X86_CR0_PG and X86_CR4_PAE to check bit
status rather than X86_CR0_PG_BIT and X86_CR4_PAE_BIT. This patch is
to fix it.

Fixes: f29810335965a(KVM/x86: Check input paging mode when cs.l is set)
Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6581,13 +6581,13 @@ EXPORT_SYMBOL_GPL(kvm_task_switch);
 
 int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
-	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG_BIT)) {
+	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG)) {
 		/*
 		 * When EFER.LME and CR0.PG are set, the processor is in
 		 * 64-bit mode (though maybe in a 32-bit code segment).
 		 * CR4.PAE and EFER.LMA must be set.
 		 */
-		if (!(sregs->cr4 & X86_CR4_PAE_BIT)
+		if (!(sregs->cr4 & X86_CR4_PAE)
 		    || !(sregs->efer & EFER_LMA))
 			return -EINVAL;
 	} else {
