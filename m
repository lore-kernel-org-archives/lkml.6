Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835862-2-9563012745196501104
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
    t=1519835861; b=qbHrHcrUkB+qFKtLUoS52BopVSfT+8YtoMaqS7+TyXblg3+
    2Fq73oCFMQVSBfS6TKGbJ+8AI8i/3Xvw+IbaiZQ4ohSebwJGRfCA9ipzznArqwaP
    DGZBaj9c2e6Uc9NDAkpUfK7hyG1OZuEV/uFRENLSi2saJu1Wo4rP2dFP79ZUIOUW
    qaDe2HpRFeSCyxmcxeTzOE+NX5jeks/96B1+BckCC2RvvzjZWiIlSIcvhDYxDtda
    7ec/AbIuTRMx4u9cNUm+kYDI1avW91/+6X+DO2Lt7LVNRewMyrxCnA6Jwq405zoe
    dOk4Lcws4fWbLW4h7MGLi+9vwaxwku05zcX3uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835861; bh=v8v7pTkx0uhO1i+ds7O
    O8/t8MIz5BNuXvfpYXR4YJfE=; b=CNPiT0AcI/PQ40e0x8q5TIDL0lZPnf0bMIN
    9XAAunZuas69UhHZN3GhQyo0S0V4TlUce+VBswyaVTCzVgqk/bUL8/IWVkjEI19E
    7lIv4EqFKXrrSBkVviVzCbDs+kcQlFhuI8dvy1NzmjADmK4cFt1jnG1sWqHPW1tx
    0kwc49HP5XEebdPkHB9u6rl81EvayUoe5StD6pfMQwUDi+604vtiir4efGTAXHd3
    Hfw6lYfdRH8WZDW9tljtY1FvzFB+qAJDyGy1lZqb6ECctE+sESyrLzROBVzHGFfr
    RV9QNA9WIpW7IoyspG5Ne6bK4AoYfWQN97Y+WCGeRSQsOENu7eA==
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
        id S1752748AbeB1QEa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:04:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34825 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753230AbeB1QE2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:28 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.836975220@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 092/254] MIPS: clear MSACSR cause bits when handling
 MSA FP exception
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

From: Paul Burton <paul.burton@imgtec.com>

commit 091be550a70a086c3b4420c6155e733dc410f190 upstream.

Much like for traditional scalar FP exceptions, the cause bits in the
MSACSR register need to be cleared following an MSA FP exception.
Without doing so the exception will simply be raised again whenever
the kernel restores MSACSR from a tasks saved context, leading to
undesirable spurious exceptions. Clear the cause bits from the
handle_msa_fpe function, mirroring the way handle_fpe clears the
cause bits in FCSR.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9164/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/genex.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -368,6 +368,15 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	STI
 	.endm
 
+	.macro	__build_clear_msa_fpe
+	_cfcmsa	a1, MSA_CSR
+	li	a2, ~(0x3f << 12)
+	and	a1, a1, a2
+	_ctcmsa	MSA_CSR, a1
+	TRACE_IRQS_ON
+	STI
+	.endm
+
 	.macro	__build_clear_ade
 	MFC0	t0, CP0_BADVADDR
 	PTR_S	t0, PT_BVADDR(sp)
@@ -426,7 +435,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER cpu cpu sti silent		/* #11 */
 	BUILD_HANDLER ov ov sti silent			/* #12 */
 	BUILD_HANDLER tr tr sti silent			/* #13 */
-	BUILD_HANDLER msa_fpe msa_fpe sti silent	/* #14 */
+	BUILD_HANDLER msa_fpe msa_fpe msa_fpe silent	/* #14 */
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
 	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
 	BUILD_HANDLER msa msa sti silent		/* #21 */
