Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422553-1519831509-2-15429201298072141894
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
    t=1519831508; b=J1fB0vRLwk19RCF37ZFGPJr6UUpRUVZYuiCMVVa6nFRmg5I
    p36+7wip9CCDqjWgkkq+aS8cIYv7gZ8Qvjsya32SA0ZbImfULV7EIe/CDyE51pOT
    4k8cx7wf323aDT8iQ/knAHiSSVOaEyp8fkWDqiV/OxFeEcJjy2K/QX/h1oL8ridg
    RBixtl22PHX1Vvh20iWVEAVd47DoQ/gzBosS0UslJ8v9RN+twL/a7CnOzmD52Szy
    lG1Esn65ESdEDAdCiCRbx/Onya3iCA4oPLu+pvMm6EKuV1GQeH5TsgPImDRau+dF
    EayEDIuWJjaqh59PqUKJIE4g+aPatOhkMDn4XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831508; bh=mh0G6zUxCdpRoW0ZyfF
    aXpaJ+KcCWphg3qWbk4pmdTs=; b=QeB+puAgYmQCPdEHwqlPLDBMK4ahYf5qbD3
    cpMVKyagNP1zGRul+lkrwx/wyKvqotDtzh3JJm7PopV6/cgJLExeQTqC9G/ZnI/v
    hud8B1AQUl3rqket1M1Y/JWTB7Yck36SQSTGOiNfcNQMgDD6CkYAz9GhDqZoESqh
    QQLOeCiz3yrr1RvilR0fIk94uVix1JuFU74y4ZgpiSoU/KDN3I2hCa86dMS1+jgM
    52DIjSiO6aXkTHzvFlqAPuHZ1oCOPw1KPTNZL/sNjZAPrnxCnFq9RpmGj1xoNvY0
    b/wRhxa7V5955dYE5YBD0Ev+XtIw2GI6aZR/W5kuPVsy555SAvQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932833AbeB1PYJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:24:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33395 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752885AbeB1PWp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:45 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Hildenbrand" <david@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Wanpeng Li" <wanpeng.li@hotmail.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Quan Xu" <quan.xu0@gmail.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.500497900@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 044/140] KVM: X86: Fix load RFLAGS w/o the fixed bit
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
[bwh: Backported to 3.2: use literal integer]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6077,7 +6077,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct
 #endif
 
 	kvm_rip_write(vcpu, regs->rip);
-	kvm_set_rflags(vcpu, regs->rflags);
+	kvm_set_rflags(vcpu, regs->rflags | 0x2 /*X86_EFLAGS_FIXED*/);
 
 	vcpu->arch.exception.pending = false;
 
