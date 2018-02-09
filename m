Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185532-2-153494017242362907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185532; b=hw2lNzKqclbh+2jNBnv2kyJIfJ8vyiYVLQn3tv5FK7dZy9F
    Ss51j9eQuEpj+vX9I9FnWbAL+AVpz2gH84PRhVTx+KPIdIWbJgvK4TscDTy22MnU
    iVwIYBK5F47Vn3uu+VG6m+OWqNuMe0DE0NvCfl9zs9Rc+6Gou3yLAcYN6qGf9iCF
    IQ9/A+/ymtSw91505MdaWG9O6P1yXC1s2y7MZu494SFpwkRERtqUO4kpc7qsxyR9
    TOOIB29QZi8sr1/4fX2Sfj4BI6bGQ5yT740b8+fU7pzdtbfAIuQTI+TnOtNd2hGw
    pXpcvliA71kdCqb4ow1DU8bWo3R31CDs1ctP+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185532; bh=TRi62T4Llrb3yFDFugpeHZMV2W
    UyG/UOrTFWsI9fbm0=; b=m2T2EGyp/RWbXrZkZRkELuxiB4yuT8MWLHG6pGjKIq
    EmlO9n3oEd3c7RE8ogeM6YKKY88WqG0fmC0QFaNw1sNBNC0Gr0fEKoOannz8t7C3
    u7Y1FxhdW7PxuWTTlQnM0lqYxfYCCKq1t8eW7QlEhqAz+PNf9lEANMBW6+G/kGjD
    +4nrgTPHkmqejaJT6xEEZ6K56wUcZN/INt9NUvfSsACq4G/AfvYnLcZ+sLvR74t0
    4ce9QrfmanchDxUE0W53csi5l4OE7fS1rWjfbs+rFSUj4SWSoiuvmQledyp0hboX
    dJBLPoUc/+PJDUoClN/dnV8cwUzrwaEXXPuDq62mIHGw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeBINl6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:41:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbeBINl4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, rga@amazon.de,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 4.9 37/92] KVM: VMX: Make indirect call speculation safe
Date: Fri,  9 Feb 2018 14:39:06 +0100
Message-Id: <20180209133933.830689825@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

(cherry picked from commit c940a3fb1e2e9b7d03228ab28f375fb5a47ff699)

Replace indirect call with CALL_NOSPEC.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rga@amazon.de
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lkml.kernel.org/r/20180125095843.645776917@infradead.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8676,14 +8676,14 @@ static void vmx_handle_external_intr(str
 #endif
 			"pushf\n\t"
 			__ASM_SIZE(push) " $%c[cs]\n\t"
-			"call *%[entry]\n\t"
+			CALL_NOSPEC
 			:
 #ifdef CONFIG_X86_64
 			[sp]"=&r"(tmp),
 #endif
 			"+r"(__sp)
 			:
-			[entry]"r"(entry),
+			THUNK_TARGET(entry),
 			[ss]"i"(__KERNEL_DS),
 			[cs]"i"(__KERNEL_CS)
 			);
