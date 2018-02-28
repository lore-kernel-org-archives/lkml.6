Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835565-2-6965343406891787990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835565; b=TKObXcGczg/BJuGiNqtJ+4KFxTfBY93OM7QpV23J7WCerg9
    70NBUvYhEdWDFWWUlIYUi0lLXl2JEZ7ddth0H7LdzP/FnLnPOeqLF9HCC34d59IS
    Tgr3uXRzAxO5dNSKkZoEBfVbFWXUQvgonYsAfi3rrkzBqt8TUl/Zj2NFd6/iKPHY
    A3+RWjpINu+TNEcf60/zqy5FX7DiT6XFpzpb7/5MUQaBh9XlGd3Bawj0MJPdpdwC
    2YJfDlo3JBZLFcDSlLU7G71lgqFYHHwP9sGQhrhGozM7kYBaWuLxGC73Ybyt43MP
    KTlyj4SneZ1rsFlxaP4tuGKMAcupGsq1CLydFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835565; bh=vjcLJ4WwDJcLUtVUosh
    pz8+GnTFrJNI8A002V0peKrE=; b=XiSRmUZXdBKAg1hOtWtucYtQ7Had08l8Cac
    G+KFZJpGQeEEvCg32D94/DlkRh5AvgJCbLhGTLRsL/VJRv0HTQ3fMiqCOLCvSRWQ
    oWonrgHYIOjKuipcLKlsQkYSlpZ/NcK2XlP/4oFclwzuwPADnB2FdFlKH7r6/cjA
    ACNGFoOEnd2GOCXjjikcXNr5geuC2US7FmeaEmFx6xzZuTCK+j8c5H95i0IYIjTE
    KAxaMuIrIiyHpyYckTnNxAeRn/B2Fjbg8y23Wmjv+dKRKcFl8ufkpAphxz1SiHkI
    C0sx0EDc0bK7ga5SYaNAwmCP/wiylIlYNBhja6XtT6wPcBmGNoQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbeB1Qc3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:32:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35109 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753277AbeB1QOX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:23 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, "Maciej W. Rozycki" <macro@imgtec.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.721276832@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 102/254] MIPS: ptrace: Fix FP context restoration
 FCSR regression
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

From: "Maciej W. Rozycki" <macro@imgtec.com>

commit 4249548454f7ba4581aeee26bd83f42b48a14d15 upstream.

Fix a floating-point context restoration regression introduced with
commit 9b26616c8d9d ("MIPS: Respect the ISA level in FCSR handling")
that causes a Floating Point exception and consequently a kernel oops
with hard float configurations when one or more FCSR Enable and their
corresponding Cause bits are set both at a time via a ptrace(2) call.

To do so reinstate Cause bit masking originally introduced with commit
b1442d39fac2 ("MIPS: Prevent user from setting FCSR cause bits") to
address this exact problem and then inadvertently removed from the
PTRACE_SETFPREGS request with the commit referred above.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13238/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -176,6 +176,7 @@ int ptrace_setfpregs(struct task_struct
 	}
 
 	__get_user(value, data + 64);
+	value &= ~FPU_CSR_ALL_X;
 	fcr31 = child->thread.fpu.fcr31;
 	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
