Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488377-1519314250-2-4145247653148471794
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519314250; b=Ke6FJ5AwavhcphoI+X4RiKlJpKRw0dtwSej/ccqxlP19py6
    J2oHvgBAb1rMU+K9VeZQxJWdG9SlxFPyXn2JDxlGLjmDEUil23dGTpK7Ns6jUPa5
    CBMDSKHs4PDSwhat0dUH2/ePTO2pqscCgifmbRnU44nZKPrUjEW13iCaFM94AxiT
    96L99BCRgucq+tB22bnh0fyNbiZr+2pTVYE6wlXbgg+0+Aw8MNtsJJj36larO88T
    eL/QaBUggdjJZyp7/Nlm7gmR1QdI2bUspCNa/bAGo0jybTcNyTp7wyYy6+l0bcEt
    KefYHfpMrA9LWylbU+j3KrjQuPMliCS6VOFYnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519314250; bh=u4BMxa9OSxs590gjqNLkdwPEmW4xj2RVOKtTKUsjYP4=; b=V
    dwx7oRJ/ua1yNYV1OjAXTLD4rZwlQjyd+CzD/S20EiwCMoRVs0yKL7kGI09yiLAu
    2sTbWE88ZTmP45++qVJJOBFtjWSPsuiGO0Io9f+MWdcQGwbzG7azgo4pxxtZeogf
    SKk89bKZnhO7O4O4FF/hARdIJ39xKnVrEIA1vp9Rs+IafrxYYxlrgHxtbALb6Yc8
    iel59MQwJMghoqF7FeLws00SOYy5Dsy8fyWCloDPrb8HswinA6RoodqZoo9DeUFf
    uJQUnvH3zuePuKPHMiozSdJw311GTihZzXmsrvkBAUPRS7xDsX/LfVD3V4fNuZFi
    rbZv7vuKJcipdfmAujKWg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D+piePGZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uhme24uH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D+piePGZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uhme24uH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932919AbeBVPnr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 10:43:47 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55195 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932902AbeBVPn1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 10:43:27 -0500
X-Google-Smtp-Source: AH8x224cFSKbjqNPMszmEvkxn/eEx8x3I3NXwdNIWjix3Mf8XqbJ4bIxAYVOYrwaqm5xYvYrYvxYgQ==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: x86@kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: VMX: mark RDMSR path as unlikely
Date: Thu, 22 Feb 2018 16:43:18 +0100
Message-Id: <20180222154318.20361-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222154318.20361-1-pbonzini@redhat.com>
References: <20180222154318.20361-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

vmx_vcpu_run and svm_vcpu_run are large functions, and this can actually
make a substantial cycle difference by keeping the fast path contiguous
in memory.  Without it, the retpoline guest/retpoline host case is about
50 cycles slower.

Cc: x86@kernel.org
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Jim Mattson <jmattson@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm.c | 2 +-
 arch/x86/kvm/vmx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1598beeda11c..24c9521ebc24 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5465,7 +5465,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index af89d377681d..e13fd2a833c4 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9589,7 +9589,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
-- 
1.8.3.1
