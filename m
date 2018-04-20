Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186739-2-9699313547259038682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186739; b=DaGUnayKCevVjNbfy1eD8Xm2E0s7QUnNInBvviujBuSCvX/hVo
    +uRfX7H1frS56/08454s6gEc9mcz1w6OwdWYBHQOd5dei4FkcbjKTQ4qMeqZcv+v
    nGV1z/9ipAM5PPa7wSxvvb9P4A9pBlwGLEl/NtXXYnMEKBQP+jEbOYQ+pH/aCISw
    8Rbafusdu61k2tegVvH9L2mCcFfDvHmgcr7eeyDvEbG38SqeSmFiiRTTh0aWWnqh
    sutBi7haRSz2DvHRp6/2P/jf9BrHHGmsMbeWHfhstmCPS1GVhAonbJWvBpUZ5fib
    q6xBK9ZfkRpkfANFuE8y6g42sdQrkzkwB9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186739; bh=Vxhd
    lcAfKI3cGu01TPJXc7W9XEs09g8E87lal7HLOiE=; b=j/PEpOp7hhaKIL13cYdH
    NziF+wpG1OaWboo2lzOOLPoB884ATpTNQQe8vt/Di2DNtmohKnFeotmoBe5j9rWN
    FM3o0NCc4OoCSkVepqNE4iF/43xq2ijFLDXt6p9XUhtKMl66poCgirOZPn5jRHso
    j9yKcxanU954RM+3BBLrJWOHbDq/KgEnEjMorwW+uUb1SZ04D7iZ70D8Mg4L8Ipg
    whpKa1Wx3qqYdntlIkwc0/YH8D/7PtlDQD9+JghdLUAufhzRIsVW6bqzPLclvfaa
    dNKZIvt5EdByk0j6dFExgUdd0lMlM4PgYEobVXP1PtBOm6JtPnupnOCx5w9yQ9rC
    3Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCAb3GTA+BwzqzHOfrMF7rUaV4DvM7OhqT912mZnfee8sPT0lRVCLc+RLIsjQ68y0U2y+P7iylgNOMyGQ3kk1ufDESELgtlbf+DSf6S2SqxY+WmN5RTt
    MviHVO+qq7G6idcZkcc2kQuLjp5DBmwHgcpt9rjTvcWsisV/aaTeJAA6LgmhWFf/GFCtz7+Gu12QhJVA3DSFBymyRBJkU49fteuYvnyn5xp4h00XNUw/hlYo
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hGzw-44bAAAA:8
    a=6ohNodAXAAAA:8 a=wMNdZWldAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8
    a=PtDNVHqPAAAA:8 a=T5HBY6FBPKQUrMSdn78A:9 a=x8gzFH9gYPwA:10
    a=HvKuF1_PTVFglORKqfwH:22 a=0gLUg1G2xj6MhZ7RLP3J:22 a=FUarYpL4UH3yWsho8X8J:22
    a=IC2XNlieTeVoXbcui8wp:22 a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbeDTBMP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:12:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36103 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753826AbeDTBMJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:12:09 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Mackerras <paulus@samba.org>,
        Kumar Gala <kumar.gala@freescale.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Date: Thu, 19 Apr 2018 20:04:08 -0500
Message-Id: <20180420010408.24438-17-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KXc-00014u-LS;;;mid=<20180420010408.24438-17-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18bSq8ljw24PtGJS1uOQzJiTjnb/4GdPLA=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15037 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.98 (0.0%), parse: 0.72 (0.0%),
        extract_message_metadata: 23 (0.2%), get_uri_detail_list: 2.3 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 24 (0.2%), check_bayes: 23 (0.2%), b_tokenize: 8
        (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.1 (0.0%), b_tok_touch_all:
        3.8 (0.0%), b_finish: 0.59 (0.0%), tests_pri_0: 192 (1.3%),
        check_dkim_signature: 0.44 (0.0%), check_dkim_adsp: 3.4 (0.0%),
        tests_pri_500: 14788 (98.3%), poll_dns_idle: 14773 (98.2%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 17/17] signal/powerpc: Replace TRAP_FIXME with TRAP_UNK
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using an si_code of 0 that aliases with SI_USER is clearly the wrong
thing todo, and causes problems in interesting ways.

For use in unknown_exception the recently defined TRAP_UNK
semantically is a perfect fit.  For use in RunModeException it looks
like something more specific than TRAP_UNK could be used.  No one has
bothered to find a better fit than the broken si_code of 0 in all of
these years and I don't see an obvious better fit so TRAP_UNK is
switching RunModeException to return TRAP_UNK is clearly an
improvement.

Recent history suggests no actually cares about crazy corner
cases of the kernel behavior like this so I don't expect any
regressions from changing this.  However if something does
happen this change is easy to revert.

Though I wonder if SIGKILL might not be a better fit.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: 9bad068c24d7 ("[PATCH] ppc32: support for e500 and 85xx")
Fixes: 0ed70f6105ef ("PPC32: Provide proper siginfo information on various exceptions.")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/include/uapi/asm/siginfo.h | 8 --------
 arch/powerpc/kernel/traps.c             | 4 ++--
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/siginfo.h b/arch/powerpc/include/uapi/asm/siginfo.h
index 0437afc9ef3c..1d51d9b88221 100644
--- a/arch/powerpc/include/uapi/asm/siginfo.h
+++ b/arch/powerpc/include/uapi/asm/siginfo.h
@@ -15,12 +15,4 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGTRAP si_codes
- */
-#ifdef __KERNEL__
-#define TRAP_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
-
 #endif	/* _ASM_POWERPC_SIGINFO_H */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index fdf9400beec8..0e17dcb48720 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -969,7 +969,7 @@ void unknown_exception(struct pt_regs *regs)
 	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
 	       regs->nip, regs->msr, regs->trap);
 
-	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
+	_exception(SIGTRAP, regs, TRAP_UNK, 0);
 
 	exception_exit(prev_state);
 }
@@ -991,7 +991,7 @@ void instruction_breakpoint_exception(struct pt_regs *regs)
 
 void RunModeException(struct pt_regs *regs)
 {
-	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
+	_exception(SIGTRAP, regs, TRAP_UNK, 0);
 }
 
 void single_step_exception(struct pt_regs *regs)
-- 
2.14.1

