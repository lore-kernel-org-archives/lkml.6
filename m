Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839385-2-1879006993973992056
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
    t=1519839384; b=RjdCrWUjUsKlEgUApBpLXkNDNh15y2Y6Gos8qn34Q5TpU9u
    Y9dYJ092CNrNZCP/O5bSJW2K2whuYCpO+aurX0TGwHYrLCnAEN9WyLB2/MTPWQzs
    nHURDTJJpLyiY9VCcz++/Ns+XU0cTHsOZesaNrCgc3BS/+7FSI51C9Ya99rzUupr
    ewpMGr2DNsYPkQhcfbWJqrbVnAxbuxgR4iKVtlMLgrbsII3rXOfIdm4vB/gPSTZ9
    R37w1zuZ5Zaqhe5NRQ/rFBRINmbXZ82oCUAjjApjJuvXDzv5CrPWz5Fx5rnwA+f9
    0RYbVT2qNz868nVdid7fV8criQE5COkfwNmZ9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839384; bh=4dVRTo8UUAzfD5edEFo
    QKQOl4jlFahlNqVYqZCo+Mo0=; b=CgQpJpLBHlUJ25kecAldX+BpkxZhi/ZMb4a
    PZ2KZxgelVYegc129Fj82p7f3dRwlk8aeZoOEL0toENJcz0HX/NFJwkO1KYo262H
    PPyCYvD9j+1CW5+N3QCAcfASUcUvkclbLLt2sUXzo71siy16UippQsd3soC01Y4j
    6v33jlTxVp4Y9KByPY3TNK31+bzwS6fZe5cunMiLLEZDe60GU/yGOBFYntL9paCK
    8jmSZFFZAXaKmTSVIe/C1lhEXDDzjOOyyVhDuFfaS48/oQvzv/QsooLL2Daz0OsZ
    rS3CSVvh/XBam2pgSBe+pU19FGmAFwZSJsECYBM/WlTN0xYngJw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeB1Rfo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:35:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33205 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932554AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Jeremi Piotrowski" <jeremi.piotrowski@gmail.com>,
        "Tianyu Lan" <lantianyu1986@gmail.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Tianyu Lan" <Tianyu.Lan@microsoft.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.278830417@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 104/140] KVM/x86: Fix wrong macro references of
 X86_CR0_PG_BIT and X86_CR4_PAE_BIT in kvm_valid_sregs()
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -6174,13 +6174,13 @@ EXPORT_SYMBOL_GPL(kvm_task_switch);
 
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
