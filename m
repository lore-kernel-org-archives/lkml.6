Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720887-2-12182824482148881227
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
    t=1518720886; b=SxsPybNvokyPVsetl5EORfKI2um5EzSPMD8RqfY1FmwZxVn
    KIcZk5bX2h/r33UM/m0qCh/1ns+Sow1Bpgkz4NlO3qpy66pspXh+mZLi0YM+B9x4
    46sFmySqsyVfY/IagEP1zH4y2NIaHNjf26y64aAOcvXbB0Q9XvVRJdP81L5ljbSD
    xxfRmH22ykZmpw9/pylWK4kIKMWF8ApbtBx6A9pDCuZpjlX7sXxwJ/B7o6zuEKke
    Vcq64nAnndevvf4h/ktSCkpfmHd9bV6mmTrz5cAdBgAXfgBjTINQKEsmdwz6q9Xt
    cZA+UKA8JR+rgC4h+d57+UnnxElMS3oCAnFVGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720886; bh=HkjYRVjkeKLfGwk1DvN1DwXRGD
    x3EPOYMvctoIqYNh8=; b=J3GhX5afXawCOUWYvxGCFXi4ocicLN3dmIkUE8ex9p
    pA0Ti2HM+lBI4wujdOVV+M6B/CcV4vzI4ypVff/Jy7WKM9h4oTGo3Q3BnaBnNVz3
    R9VZ6tYnuTYvvsTY4v58AWWJEFCUUqiKqTPwWGsqOtjs6I8n3cHuUXG/u8TV1QK/
    HpcwYOH/v7UIyImoD4HkohqPrn7Pbg5ysHes1sfIHgQc/v5h2K3GWrrrITdR9noY
    bhO1rSG6jsZGqudODxcU37QNypWC/as4bFkRiQKV10hTtmRmbIaOdDub2wlQ99Zj
    Nl3ZieTGEqCBBwCaFQeBxYH52BYcHlE4LcjHjs8+aI5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161872AbeBOSyo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:54:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161840AbeBOPUo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:20:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 001/108] powerpc/bpf/jit: Disable classic BPF JIT on ppc64le
Date: Thu, 15 Feb 2018 16:15:58 +0100
Message-Id: <20180215151222.474703252@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

commit 844e3be47693f92a108cb1fb3b0606bf25e9c7a6 upstream.

Classic BPF JIT was never ported completely to work on little endian
powerpc. However, it can be enabled and will crash the system when used.
As such, disable use of BPF JIT on ppc64le.

Fixes: 7c105b63bd98 ("powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config option.")
Reported-by: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -129,7 +129,7 @@ config PPC
 	select IRQ_FORCED_THREADING
 	select HAVE_RCU_TABLE_FREE if SMP
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_BPF_JIT
+	select HAVE_BPF_JIT if CPU_BIG_ENDIAN
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAS_GCOV_PROFILE_ALL
