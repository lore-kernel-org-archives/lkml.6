Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519840103-2-5688563332346060692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519840103; b=S8SERq2izdpj1c4kvX3kUkjlIkp4TRkLQ2V68Zz1s0NOH1i
    03b5nNm2oKLiyuW5XDVuopVeG8N6exjYrNDrvWt+MVnfAOam2HJia2nxGUTb4F7R
    WUuNc5DQ8H7XeRWyF3UHypmsgpdEPFbhMKZ0T5a34snisSHWy2dj4BpHXHLKg3HE
    MrcGIcyRTCCPN+YSroMQpaDwQnUDB/LA4vl1uv1vRY1ljAFmWIuLa84ujmWeuxLk
    t9cTmaPaKs0Eb2lCsgH0nmY/+//RMkDwhq4mUuKAw1rhVcDCNNG59dFQzaFHYdUs
    q+AMoBFhfKdCcjwp+ogKuDkvEumOCZwXbL4c/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519840103; bh=yrpemdKL8PE4wIfkkYD
    cfaNVdcewSoJXzdoCWpiP0Wg=; b=J/8QV7nPwcc1Y0PQFwHYXUWWKOCrK1DfhKf
    G8hOXyAXrOTKsWBikpyYNczKu7soULtBRQAlD0zVP4Tvnx7wNsiWvCX9/0U+VNoL
    x0jtz+2FyfqfJTqe+JkemwUPP/uSJtc2B8CCk4q0ks/OMlY72M8ALOWlccbYQmBg
    St9gFPxR5T1ttT0XfRwX7c43FvAS8TQHTO8NQNHuopmBq+FoEjsr/+WupeIQrVCT
    +Ld+hxqwPWLIy8RFShpSLDII+FKeJe8+UQGvz6Lxzk3Z0xZ/29dQ+Mf+OVZlHgnI
    KKy2xu8fZmdmtLnlagyNg66U9LkrUSD1MKtsDmzOiKMqrwXy+Fg==
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
        id S934202AbeB1Rpn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:45:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33106 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932476AbeB1PWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Chegu Vinod" <chegu_vinod@hp.com>,
        "Gleb Natapov" <gleb@redhat.com>, "Avi Kivity" <avi@redhat.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.890860338@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 012/140] KVM: apic: fix LDR calculation in x2apic mode
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

From: Gleb Natapov <gleb@redhat.com>

commit 7f46ddbd487e0d0528d89534fdfb31d885977804 upstream.

Signed-off-by: Gleb Natapov <gleb@redhat.com>
Reviewed-by: Chegu Vinod  <chegu_vinod@hp.com>
Tested-by: Chegu Vinod <chegu_vinod@hp.com>
Signed-off-by: Avi Kivity <avi@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1022,7 +1022,7 @@ void kvm_lapic_set_base(struct kvm_vcpu
 	vcpu->arch.apic_base = value;
 	if (apic_x2apic_mode(apic)) {
 		u32 id = kvm_apic_id(apic);
-		u32 ldr = ((id & ~0xf) << 16) | (1 << (id & 0xf));
+		u32 ldr = ((id >> 4) << 16) | (1 << (id & 0xf));
 		apic_set_reg(apic, APIC_LDR, ldr);
 	}
 	apic->base_address = apic->vcpu->arch.apic_base &
