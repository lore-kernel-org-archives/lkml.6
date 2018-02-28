Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519835105-2-1020882370054217120
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
    t=1519835104; b=s/4+RMQJkBj7ze4xtlxmR6vdLhWpfbFxHPQJeae4Wip/ko7
    EQEC90RRAHllTwSeAEIBCssP6p1dhcWxpDwF6bRgx0aXhB5LjFfqKqvK6Frto34Z
    ugfvVZprKRRfX76uuuCKgSNbadKO76YmX0k1GPsTcM5ap5QM80HkeNsTOpKRq1p0
    YyPQtBsc2y7cn35f2ihsy36Q9ufho5QCIwUNg4tFeQLHHxvE2R9/yQ7r5psHoF6e
    16woAvAor/iiIBWHi1s613w/1B++xn1br+I+I5fZ05+9B6APc5mEV1eB5mly+hdA
    MftfTRDoMR7bLLw4ztRzB05jIIn2a7fS4idNizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835104; bh=GGjMI1Po8hVdqcF++wp
    EqH7somvIVxjWAogVlJEzIyk=; b=k4Fos8aRcNzcTgP3WjViG5Yakoe5XqF8m6v
    PpDwasQvHF2Y/VPQ7I4zafNrr3thrPKMzYZSQoVGAcEz7IwBwF8dWUwELUy80D9i
    aGsI/NMGRavbUeWu6VgaTz9p4dt13V68u0U/6DS6FOAbkWx2f0d51NPqK0woaRSq
    OOhMH1fa1toO5VKJu8KUrOv28iM0G7r+2nJ9X2j1CjGLAATfrx/lg7FXub+7wVzh
    QakkOLNpkixjqaR3tzMGFiDpbrvlW3alzknIORVRf0hfh6s2TJxaJ4L3/90S0N/y
    tXqKAdILIXFRmsdMb5hy+CCoKfX/8RgGmu2ekeVkWVKkaX9YE9A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935156AbeB1QUe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:20:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35359 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935146AbeB1QUc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:32 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Nikita Leshenko" <nikita.leshchenko@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Liran Alon" <liran.alon@oracle.com>,
        "Wanpeng Li" <wanpeng.li@hotmail.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.454718217@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 005/254] KVM: x86: Don't re-execute instruction when
 not passing CR2 value
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

commit 9b8ae63798cb97e785a667ff27e43fa6220cb734 upstream.

In case of instruction-decode failure or emulation failure,
x86_emulate_instruction() will call reexecute_instruction() which will
attempt to use the cr2 value passed to x86_emulate_instruction().
However, when x86_emulate_instruction() is called from
emulate_instruction(), cr2 is not passed (passed as 0) and therefore
it doesn't make sense to execute reexecute_instruction() logic at all.

Fixes: 51d8b66199e9 ("KVM: cleanup emulate_instruction")

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/kvm/vmx.c              | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -847,7 +847,8 @@ int x86_emulate_instruction(struct kvm_v
 static inline int emulate_instruction(struct kvm_vcpu *vcpu,
 			int emulation_type)
 {
-	return x86_emulate_instruction(vcpu, 0, emulation_type, NULL, 0);
+	return x86_emulate_instruction(vcpu, 0,
+			emulation_type | EMULTYPE_NO_REEXECUTE, NULL, 0);
 }
 
 void kvm_enable_efer_bits(u64);
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5659,7 +5659,7 @@ static int handle_invalid_guest_state(st
 		if (test_bit(KVM_REQ_EVENT, &vcpu->requests))
 			return 1;
 
-		err = emulate_instruction(vcpu, EMULTYPE_NO_REEXECUTE);
+		err = emulate_instruction(vcpu, 0);
 
 		if (err == EMULATE_USER_EXIT) {
 			++vcpu->stat.mmio_exits;
