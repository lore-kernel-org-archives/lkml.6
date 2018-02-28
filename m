Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839294-2-3231072965314736760
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
    t=1519839294; b=PByBuvJW00m8EPKQ8boI+JRtX8bK2srj6rJvr4pt80gDHy5
    E0b3OG7nSC7QTDTmf6avuJomai50INPMUEWt/CyRUlTsJVtF9nC8k+Tisg3/dyIJ
    lkObRvwmnQLgMvzK6G+wxikRotwz0FV5iu7p+Lp6QKj/3PJM8eljV2w++rW7IBtS
    FNfxdsaD7mI6oE2Ih5QhlkkB2eHiIEaA3Bje6FHyN7YHsWgmZLulMGGFI1JVciRc
    j5VO8eiKZHOYWAgAmLb4nw2YWeS3crUbKWVEzF/Yj4zMytcjNtS2KWywDFLzdk5B
    cpqmwtqtGx7gzHWy+HH5e3CibJVyrGmFQqNrq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839294; bh=fgp9vK28o+/DtH8lozi
    mWioprvcWkFMVQWoX8h02WSk=; b=tujrKTr9csEkugQLf8ZMo0dD0jazN9E5vv3
    rPhOL9G7m8ZQMyB1OHmJNfZR8tGOZzyoTMYsiJzqWY5sgckdBEXe93KV0cQiZ9Iz
    gkrfS/dCTNjbA4wyjNKZxOl8W+Y+zVluUxFLSfHar6UEqpFrQvxH19eRnnH9YoFx
    kqUmnyqtN/GuvBUTT5VoI+OPlhBee5PuicpKlg6c56p8hSDTARR1hgJ+2Es7c9GO
    9WRbOZB5a1TZ+OJvClvubbk8YJgs/4gEodHVgNO08oaLwGErk8csSQQRtm2AiziM
    kXLGor3rps0Z3BSqd3SxpOeB8XvPk/wLGx7dRfgu62PDmmjvmsA==
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
        id S932348AbeB1Reu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:34:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33213 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932565AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Lan Tianyu" <tianyu.lan@intel.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.298118821@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 103/140] KVM/x86: Check input paging mode when cs.l is set
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

From: Lan Tianyu <tianyu.lan@intel.com>

commit f29810335965ac1f7bcb501ee2af5f039f792416 upstream.

Reported by syzkaller:
    WARNING: CPU: 0 PID: 27962 at arch/x86/kvm/emulate.c:5631 x86_emulate_insn+0x557/0x15f0 [kvm]
    Modules linked in: kvm_intel kvm [last unloaded: kvm]
    CPU: 0 PID: 27962 Comm: syz-executor Tainted: G    B   W        4.15.0-rc2-next-20171208+ #32
    Hardware name: Intel Corporation S1200SP/S1200SP, BIOS S1200SP.86B.01.03.0006.040720161253 04/07/2016
    RIP: 0010:x86_emulate_insn+0x557/0x15f0 [kvm]
    RSP: 0018:ffff8807234476d0 EFLAGS: 00010282
    RAX: 0000000000000000 RBX: ffff88072d0237a0 RCX: ffffffffa0065c4d
    RDX: 1ffff100e5a046f9 RSI: 0000000000000003 RDI: ffff88072d0237c8
    RBP: ffff880723447728 R08: ffff88072d020000 R09: ffffffffa008d240
    R10: 0000000000000002 R11: ffffed00e7d87db3 R12: ffff88072d0237c8
    R13: ffff88072d023870 R14: ffff88072d0238c2 R15: ffffffffa008d080
    FS:  00007f8a68666700(0000) GS:ffff880802200000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000000002009506c CR3: 000000071fec4005 CR4: 00000000003626f0
    Call Trace:
     x86_emulate_instruction+0x3bc/0xb70 [kvm]
     ? reexecute_instruction.part.162+0x130/0x130 [kvm]
     vmx_handle_exit+0x46d/0x14f0 [kvm_intel]
     ? trace_event_raw_event_kvm_entry+0xe7/0x150 [kvm]
     ? handle_vmfunc+0x2f0/0x2f0 [kvm_intel]
     ? wait_lapic_expire+0x25/0x270 [kvm]
     vcpu_enter_guest+0x720/0x1ef0 [kvm]
     ...

When CS.L is set, vcpu should run in the 64 bit paging mode.
Current kvm set_sregs function doesn't have such check when
userspace inputs sreg values. This will lead unexpected behavior.
This patch is to add checks for CS.L, EFER.LME, EFER.LMA and
CR4.PAE when get SREG inputs from userspace in order to avoid
unexpected behavior.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Tianyu Lan <tianyu.lan@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6172,6 +6172,29 @@ int kvm_task_switch(struct kvm_vcpu *vcp
 }
 EXPORT_SYMBOL_GPL(kvm_task_switch);
 
+int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+{
+	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG_BIT)) {
+		/*
+		 * When EFER.LME and CR0.PG are set, the processor is in
+		 * 64-bit mode (though maybe in a 32-bit code segment).
+		 * CR4.PAE and EFER.LMA must be set.
+		 */
+		if (!(sregs->cr4 & X86_CR4_PAE_BIT)
+		    || !(sregs->efer & EFER_LMA))
+			return -EINVAL;
+	} else {
+		/*
+		 * Not in 64-bit mode: EFER.LMA is clear and the code
+		 * segment cannot be 64-bit.
+		 */
+		if (sregs->efer & EFER_LMA || sregs->cs.l)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
@@ -6182,6 +6205,9 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct
 	if (!guest_cpuid_has_xsave(vcpu) && (sregs->cr4 & X86_CR4_OSXSAVE))
 		return -EINVAL;
 
+	if (kvm_valid_sregs(vcpu, sregs))
+		return -EINVAL;
+
 	dt.size = sregs->idt.limit;
 	dt.address = sregs->idt.base;
 	kvm_x86_ops->set_idt(vcpu, &dt);
