Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519836835-2-7097698595458452845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836834; b=Wwn3HOPXaHLz6kma7D/CxoBArMM2/qTzv6TVBjWLyDbA0oj
    2CScOYYRyyuwjCUZtPPgJR6UUDA9dmhLkkM92qqKcQWEvT7SFjaq2XXC1z6dA6JB
    +sTJd89ECLjZEXpaAHPdvSws+1yYqL5rcr9xlCj+Xvs2P8ffYVFOTBjl7wyKLy59
    AqnU/sJTFfBRKiiC9kC76TLmVRTK68ho29rV0HpZSMhFR13mF4qbe7aVLCtRoMg7
    KIRDwIPuFWPG7L68ETB3LFdRJWp90d8mAoOKAJf5jDVTWW9p30POezxVEgce+Db5
    X4CHqJT4HoPtRBUAgIY8Lle/a353TMCiWYKQqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836834; bh=g+ug6HtKSgdbdy7B324
    B560Qdm9vjYpgv9+aQEagm/E=; b=vOgtOqELB2yH4Kgpe32E+rO0v/u9EgCNwqB
    yJdQkTSBbsl55VYf41DuD+VnGmSHEJdgIJcI1oTI1SVleGmNlTF0gbFfHCj/W3Fn
    knre86NTtCOZ8EJ75+QVtzZzJYsSUuo+IZvF4I6yHQj5mbbfG/qsYyboyvuHJJam
    hZ+nZ7fEVTNZOlC8GhOfFuH8/0ilREdl2IcFL0cGkwcNyY2hEuZ/cMpuwe40XzMm
    QMJrWYXxuuqNgWWBEZnW4kDQoJw1C32Ce36Lg/cy1xSYiu1ajr63YVEb/s5jKi/X
    jAnklcNV+OrQntflNC1/fQ/tiB9IbLQEeCYUylmyuTRoKdH7QWQ==
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
        id S932230AbeB1Qxj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:53:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34537 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933746AbeB1P57 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:57:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Wanpeng Li" <wanpeng.li@hotmail.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Quan Xu" <quan.xu0@gmail.com>, "Jim Mattson" <jmattson@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.690452039@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 112/254] KVM: X86: Fix load RFLAGS w/o the fixed bit
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

From: Wanpeng Li <wanpeng.li@hotmail.com>

commit d73235d17ba63b53dc0e1051dbc10a1f1be91b71 upstream.

 *** Guest State ***
 CR0: actual=0x0000000000000030, shadow=0x0000000060000010, gh_mask=fffffffffffffff7
 CR4: actual=0x0000000000002050, shadow=0x0000000000000000, gh_mask=ffffffffffffe871
 CR3 = 0x00000000fffbc000
 RSP = 0x0000000000000000  RIP = 0x0000000000000000
 RFLAGS=0x00000000         DR7 = 0x0000000000000400
        ^^^^^^^^^^

The failed vmentry is triggered by the following testcase when ept=Y:

    #include <unistd.h>
    #include <sys/syscall.h>
    #include <string.h>
    #include <stdint.h>
    #include <linux/kvm.h>
    #include <fcntl.h>
    #include <sys/ioctl.h>

    long r[5];
    int main()
    {
    	r[2] = open("/dev/kvm", O_RDONLY);
    	r[3] = ioctl(r[2], KVM_CREATE_VM, 0);
    	r[4] = ioctl(r[3], KVM_CREATE_VCPU, 7);
    	struct kvm_regs regs = {
    		.rflags = 0,
    	};
    	ioctl(r[4], KVM_SET_REGS, &regs);
    	ioctl(r[4], KVM_RUN, 0);
    }

X86 RFLAGS bit 1 is fixed set, userspace can simply clearing bit 1
of RFLAGS with KVM_SET_REGS ioctl which results in vmentry fails.
This patch fixes it by oring X86_EFLAGS_FIXED during ioctl.

Suggested-by: Jim Mattson <jmattson@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Quan Xu <quan.xu0@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6471,7 +6471,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct
 #endif
 
 	kvm_rip_write(vcpu, regs->rip);
-	kvm_set_rflags(vcpu, regs->rflags);
+	kvm_set_rflags(vcpu, regs->rflags | X86_EFLAGS_FIXED);
 
 	vcpu->arch.exception.pending = false;
 
