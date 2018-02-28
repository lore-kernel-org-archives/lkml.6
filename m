Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835417-2-14412990368578377379
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
    t=1519835415; b=Zk+bwCT0Adjsb6NNl6dtJVhVJCVknThlnz5loRlKiEbtDnE
    pi0WECLVzL7nUOknysIjkrSo+oARt4/XNYoIoa/VyqKz4pwilSewp7uL0jprg08M
    D1bZBrvvAzPDMC7dd3Et1TeOMXP20DXWg34M27Btlkuyagr/Gf11FLc2jSO9DWd0
    hAHM5c4aGDgAadFMoTQ7Xzsp4dgC5HxQFZOsaSCopPiMbFc6ejrTGHmyhnvJCCob
    SrQAMXpN+RM6JfP/0YXqggbJ/aO7yb+Pvndr2f3hlaIGbIyPK0LmaLzizlFX6W4V
    ZxIOlV1HhY53eSKc+agvTDjg+wz6oz8z2Ac7sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835415; bh=ud4XTHsc1Juhg2zrvLW
    H1oE6lWQaH1fhpiSgS08ehoo=; b=mWeqURVE/K8VpCRgYn4TvAGkXmz8RYOlUFK
    ZtqbD9Xc2VJDeGKhVbDs/hzdp51nbfOyeTy5EoTuxaBBDmT7IElBfZlN7ynJJtJF
    TOVnL/+E4pcrXpUcSwAGAt2fBHXA1U1jA6qV738bbOeXDcKlGk/gmLc1OAvCPA+q
    w7LmQSXZmS9cG4+/p0F0YiwPlVTHme6kyul0QpR287+NFGIsfuhIPbarcv7ijuk0
    TouCSerZwft/3WtqZBJ6sRXeuJFHkGw04EgTnYA90cZIEcxqpcUyJkqwLsM1IF79
    boYlpE3S1nHezwg65bZVcNpO2zy3dIntkD45dWEWdjxuccyU7xA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934785AbeB1QPQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:15:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35163 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934530AbeB1QPN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.799017230@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 097/254] MIPS: Always clear FCSR cause bits after
 emulation
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

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 443c44032a54f9acf027a8e688380fddc809bc19 upstream.

Clear any FCSR cause bits recorded in the saved FPU context after
emulation in all cases rather than in `do_fpe' only, so that any
unmasked IEEE 754 exception left from emulation does not cause a fatal
kernel-mode FPE hardware exception with the CTC1 instruction used by the
kernel to subsequently restore FCSR hardware from the saved FPU context.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9704/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: drop changes in mips-r2-to-r6-emul and simulate_fp()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -775,7 +775,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
-		 * the cause bit set in $fcr31.
+		 * the cause bits set in $fcr31.
 		 */
 		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
 
@@ -1292,6 +1292,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 			sig = fpu_emulator_cop1Handler(regs,
 						       &current->thread.fpu,
 						       0, &fault_addr);
+
+			/*
+			 * We can't allow the emulated instruction to leave
+			 * any of the cause bits set in $fcr31.
+			 */
+			current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
 			if (!process_fpemu_return(sig, fault_addr) && !err)
 				mt_ase_fp_affinity();
 		}
