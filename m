Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477278-2-17250378917302443203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477277; b=t1uBsWkSrXOVaUbnMsHKVIe26pI9n9rv8sQoDTDr6az1bbF96q
    33G1krdlgZefGeV8Exza5hVT7nSNhR/JSIO/uD32Lb/g8wO421Xj8qTFFoT585Ct
    rBSGFOeFyoG6J+gkegzBMu3zS/RSUq2TeAUmvHI/OlUfpjauCfSb1gVBfP4ZIpU+
    ALDLP17h+ysM8zqy0yo1q8jQVF5UnQdQINViI1fVe6SLrl1SobvG88hxVPEOu8LM
    LY0H70HXW+B+Fv6XtHMmj72FU0Aqn1X3oSbKpmpFsPsnt27xuRdFz6/qKObzA2PC
    ANhP4q4qZDnGrCTua/6IK2uj1iU/thcDvByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477277; bh=y2C6/aPzQDzE6GLVj6+3t0Mctf4i0d
    9K+JCL4tEz0ck=; b=kU3JEAV39m/Bv2LMOt39pruF6a95YDw3cgC3jdVSss5OOc
    b5uOvaK/rHuUNtQaIcBaENHZBS2Y95TpF0nqUvnIVXGdvpcBysN2xt/gcthUPAzD
    pIM3GVK5dNNq8EPnYqpRnZEUhQK/2pZQR3i22djpioQ6fJvP3evL1BMxW+tB3mYl
    +DjprUPTXyDum7QhC8SOXGMz9C5TT4VOKnyv1INXuihaqjebYorv6de3DGZIx+zS
    Qc8uVukjUyA4xtEGTTeMa/DNJ/VyizkfKH9J7rxUfGi2FhQk5AAPn9gyq2ua0ce7
    zj/JjM3ztudYBhP2tn3tVG2c/sT6tukgSYDVUAtA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG6wC0jzdnJf8mx68hKLu9eXqU0tbnMGAblTpROQPPA6VcaRLAkXYfJhVl1ChsBbyux2bKR8cPF22Hd7EFNs+s7Vsp00l8OPLy4M9A8TWIbib18+xw4m
    V07vfbrm1KCaM96+jEDnv+60vDg7iidQkQyDypTsEqD3S8nb1NrdP9Ft5u2lvI0rspUc6+m1cop+OLWI7LADP6kX6xZb65T8rGsQXAfgdvd47jzq+Jk65ko+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=7TL7T-IUxOeFTEAhxx8A:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933627AbeDKSzD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933614AbeDKSy6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 056/310] KVM: arm64: Restore host physical timer access on hyp_panic()
Date: Wed, 11 Apr 2018 20:33:15 +0200
Message-Id: <20180411183624.652896675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>


[ Upstream commit e8ec032b182cd4841605de4fc297a8edffe55972 ]

When KVM panics, it hurridly restores the host context and parachutes
into the host's panic() code. At some point panic() touches the physical
timer/counter. Unless we are an arm64 system with VHE, this traps back
to EL2. If we're lucky, we panic again.

Add a __timer_save_state() call to KVMs hyp_panic() path, this saves the
guest registers and disables the traps for the host.

Fixes: 53fd5b6487e4 ("arm64: KVM: Add panic handling")
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp/switch.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -404,6 +404,7 @@ void __hyp_text __noreturn __hyp_panic(v
 
 		vcpu = (struct kvm_vcpu *)read_sysreg(tpidr_el2);
 		host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
+		__timer_save_state(vcpu);
 		__deactivate_traps(vcpu);
 		__deactivate_vm(vcpu);
 		__sysreg_restore_host_state(host_ctxt);
