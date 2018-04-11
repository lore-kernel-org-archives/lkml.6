Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477288-2-8987487410414113090
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
    1523477288; b=p5hTrWetvn1gBdE1VU6Tzk0x7qlTJPSQ09NdBDbNvgKmf563ig
    8YY4/mlZ4tChBXpoGmau/AeDyRlh8K1OCpnC9CjVdc9/ncey3vpZNruSOcc+k3Tj
    qqZbHb3Bc8QyVT8EVuN4YguC/2tE6sxnode02THak6csqLGE4+Tzrl133lUZttn5
    MBWK+TqgG56+1kBeIZCsPrlsczS4V4CrBqTwM0LrqKqgDCqyyq5CswiEGCPjHfsO
    9vnxkVaYvytRT7ICHYkDuqQVUD8oIFUZ83f0wxzYG1HZD1zgup62BT1uxLzce17h
    pkB6wclXfYCnntEpXtaNWwjyvEFbA34x0hsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477288; bh=H3hav84K5rZggnLpYuDHS7WgZjvrSE
    q0VHEceV7ikwg=; b=IGCennSUK9eWSm25mJHBFESQxqUQcw/6gdHjuIxA6qcGhh
    WuL8nIr5o82cG7dwL3xlCK7J6RYxCUz9qZmtPb1MM5sPLyKvjJNYKGWCjjVNieXA
    RmbUtlgSomUj6LG6Q9gS6tkdO/8+/Pufy7QLJChJ7xlRvwEL/lX6qAi+WmMWKV3+
    bC+M2XA3LypBTwdEYZo6PwPJQU6VMUJmNmI4VVHxINDZWjwvooL4SUzSOlC6IJ5n
    7W2f1HJgC21txFLRZ39d73jdrXmVwIBpbqgDjKrQhCmqfuMJ4pmqc9mHPC+6N2Dv
    Xx707a2mv4/kkG1eyi+e6Jf3FYfyv0+KKYNPau3Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfMcWWclk7HmBfEUYijZSJxQP4xwg91F6XPiJkHmRJkIKJS1E5P9cZaIrIIfcrBy/R1aUZa3vAzn04apfjyWi9gnkbS4r0ZqvIddhuozIml3M6qed6gT+
    D1atl+N4hg1oTreNzHiRmgi6w3Nnjj0GsPJRKXczpIvJL685CElwL3LqTQlxj2IgzuwoCIdnjymOXEHb91Tz7NFU5Xo/jWg0a4itiesksSTsgbCBstipwar3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=r5d3RvBpJZ8c8hwF9-MA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933607AbeDKSy5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933556AbeDKSyz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 055/310] KVM: arm: Restore banked registers and physical timer access on hyp_panic()
Date: Wed, 11 Apr 2018 20:33:14 +0200
Message-Id: <20180411183624.614135856@linuxfoundation.org>
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


[ Upstream commit d2e19368848ce6065daa785efca26faed54732b6 ]

When KVM panics, it hurridly restores the host context and parachutes
into the host's panic() code. This looks like it was copied from arm64,
the 32bit KVM panic code needs to restore the host's banked registers
too.

At some point panic() touches the physical timer/counter, this will
trap back to HYP. If we're lucky, we panic again.

Add a __timer_save_state() call to KVMs hyp_panic() path, this saves the
guest registers and disables the traps for the host.

Fixes: c36b6db5f3e4 ("ARM: KVM: Add panic handling code")
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/hyp/switch.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -237,8 +237,10 @@ void __hyp_text __noreturn __hyp_panic(i
 
 		vcpu = (struct kvm_vcpu *)read_sysreg(HTPIDR);
 		host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
+		__timer_save_state(vcpu);
 		__deactivate_traps(vcpu);
 		__deactivate_vm(vcpu);
+		__banked_restore_state(host_ctxt);
 		__sysreg_restore_state(host_ctxt);
 	}
 
