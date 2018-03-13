Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955109-3-13837031895003584882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955108; b=g8dTa9yhuWLGrWkLcg5sU0fd7RoA/+Af4F68mfARHCXsBIw
    18ELzBZeZrf4RDu9nsWShgbNLUryRA+sLkg7nv10VVHQAWrwiipp7nNF0BrdedBC
    1iZ1B6b7vTVweZykNErT5IY6g9lgOsDfgnYOCGEnQZ2WT3MAmNEFTkh8fbkVg11h
    WrOucCipjN6R6l7ukHlDK2txHegNS1vZL8K7zg8ARCA2e0mYuoguOwX7ET2DSX8T
    jRNU17rqr/1PLi12fkK4Bg+HdGZ511GzfPhfbAeYr5MFIJtAOUc3/xrBL7akZiT5
    F8hwaL9XvUcEOob/CNG9XuDKnKz9qt43bjTB8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955108; bh=qLvpK0rYEw1a6AJ6Gur3ogPTbM
    vHOT+o2IksyWMiuIM=; b=v1g2nttTGbtNi7v/iEeA++faeYedbHbkGv0h7kOtvg
    Tn+kT3CxgLvp2mj31nMj29ntn8VQD9SGYmIF3sl3A/qGbt6n20+VnKnrGjT8Qhfv
    rqxrJIeUHIS9ezZ0CGiYKHl0wd3d6frfYbevSH10WN68rxkt7/kIOqj5v3PZxqhL
    E2mDFpQts61WpSiwJbEDahlXjpXxnTaa5QrP8uBFI0PaZTBnN7iHRVcw9z99GGPs
    MT75glkTdMEUMz1LpHQWdmiGC+dM8X0n88pifbjs/6tgl2tOyyPUO9vO5cu5weKd
    TkXDeuVRbqr5fqf3csAW7l5+Wt4SKLUGq5Q4uhUv155Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933384AbeCMPbl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:31:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59376 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933380AbeCMPbk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:31:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 088/146] x86-64/realmode: Add instruction suffix
Date: Tue, 13 Mar 2018 16:24:15 +0100
Message-Id: <20180313152327.534551008@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit 8554004a0231dedf44d4d62147fb3d6a6db489aa upstream.

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream GAS in the
future (mine does already). Add the single missing suffix here.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5A8AF5F602000078001A9230@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/realmode/rm/trampoline_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -102,7 +102,7 @@ ENTRY(startup_32)
 	 * don't we'll eventually crash trying to execute encrypted
 	 * instructions.
 	 */
-	bt	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
+	btl	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
 	jnc	.Ldone
 	movl	$MSR_K8_SYSCFG, %ecx
 	rdmsr
