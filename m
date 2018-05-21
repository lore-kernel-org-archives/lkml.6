Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938376-2-7309181727352334693
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938376; b=GZ+mG85x+94OuWNLtfighNxXBuJ84xcWzhOmvxMz65h4DdLtnk
    vJyc5xACXlbJb3r4oh3TUnZi/vwpateA63aCqHp0NTJ850Oxl27CAoJt2oZf7fT8
    jpya0fR7ZBuDNw0rYcwavtmjv1MDcBxdFuTqm9vUth9fJKs+vKT0HhcWjHNQFkDo
    f/gnxZEq+5zhUYs8kLUA/7/o9kcWCwFUnWCWArHfmeQrz+VoZEmH9P3XMEeouQWp
    9bPaiSAIpfuTT7mTEgQaOZZ5GBbxrLgFVsDvc5AWgta3i1vejKTN+3u3WzXfO/tO
    snK0upqIuaEzjky9M5wEfaVnXXkMj8mHqYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938376; bh=i+OTPdjxIx40Hw8/rkycCcXFhZ4CL9
    /v9vTD8Gl/zEI=; b=TH6FlMrgq2DypF2YXXfZd9G8D1yv5FPizAyQcLthhS4Mqi
    4KEzMmKAKiSQNqmTAbRdc1Xw7EsfyVbsVZ+v561CxbTQxuJdwODN0lXX31K8bcdC
    diI61//tVdfS7/znjVJuYz6j1mY+28kjdrAc2qJ1PMmorFagQrskKGIhtP9L5UHd
    k7Agkmjx984FMSU6DDYn++mCFHrj6D7DZRl07pdQsFMeANC69nbC7FL5sw+mAApj
    J2bMqWVEkln5gmyrVpwQw2q4sSTEdtPrBy/gJs2dsOBzaYhco89A+Win1Zu+FAG1
    n0PZNlDB8jy3WV1zU4oQio8U5WRQ5H2uloXvRsXQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jhMxocmY x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jhMxocmY x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJGrBuicCG88YEyF95rjXeZe3f/AAsCrA9i0vsHuF+Fnna6yLu7I1Tqg62sjFuQd03B9xaK7J9tNqnQeZ5IC6BF3SaV28R76c3aNcmGUhTGvuvn/ZD2
    fSl9yXon9KIi/GJh8u7+9nY0uhFJzDANpAVq9+yRFTDRSan0ik1hCsiP/J6CPTIlMQU2OCrvdFkKDMJKIpUYYxCDMLuHM1KwsWMAChMBBOeAtc2ElPmt/GOr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=L9XS_5gxDmCoNTYsC6QA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeEUV0V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932536AbeEUV0S (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.16 094/110] KVM: SVM: Move spec control call after restore of GS
Date: Mon, 21 May 2018 23:12:31 +0200
Message-Id: <20180521210514.147497996@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 15e6c22fd8e5a42c5ed6d487b7c9fe44c2517765 upstream

svm_vcpu_run() invokes x86_spec_ctrl_restore_host() after VMEXIT, but
before the host GS is restored. x86_spec_ctrl_restore_host() uses 'current'
to determine the host SSBD state of the thread. 'current' is GS based, but
host GS is not yet restored and the access causes a triple fault.

Move the call after the host GS restore.

Fixes: 885f82bfbc6f x86/process: Allow runtime control of Speculative Store Bypass
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5495,6 +5495,18 @@ static void svm_vcpu_run(struct kvm_vcpu
 #endif
 		);
 
+	/* Eliminate branch target predictions from guest mode */
+	vmexit_fill_RSB();
+
+#ifdef CONFIG_X86_64
+	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
+#else
+	loadsegment(fs, svm->host.fs);
+#ifndef CONFIG_X86_32_LAZY_GS
+	loadsegment(gs, svm->host.gs);
+#endif
+#endif
+
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
@@ -5515,18 +5527,6 @@ static void svm_vcpu_run(struct kvm_vcpu
 
 	x86_spec_ctrl_restore_host(svm->spec_ctrl);
 
-	/* Eliminate branch target predictions from guest mode */
-	vmexit_fill_RSB();
-
-#ifdef CONFIG_X86_64
-	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
-#else
-	loadsegment(fs, svm->host.fs);
-#ifndef CONFIG_X86_32_LAZY_GS
-	loadsegment(gs, svm->host.gs);
-#endif
-#endif
-
 	reload_tss(vcpu);
 
 	local_irq_disable();
