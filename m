Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524186803-2-14863830980481428727
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186802; b=gsY9n2Fdx/yMYuYIvqeBerVa34BXReCm0gkZ7lHC7qVHSWVgmS
    u8YC6ygs1CXHafiPG7uYVVEQjib+CEK+1dvT47gqrxVZ4zfCdPxKXIbKiH8QWZaM
    9JH/wSpjLjCRGpXb36Ta4bcGrcAmAPm17xvmf1uBh4K8quTSLR+UdIrJ4I3cvrtC
    6FuOG1XIGyiN5ttI9XosXM1MN1sBSgT/QIGr6+6lYbKtBiDwCgJlvSE2B6P2iLBC
    iwhfn4W/M1r86G5GkTTdkf7Q+mEeJ6/P5NF1+puIMy4h2zrJvTwAqZPwbFBLcYCT
    azotCGVuirfXb8qFLMqBKw94lN/uisENU3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186802; bh=jZuJ
    vqbRtA5wQxZSopbK1T8ITJUB2U1i6QBcgSX3j7U=; b=YuSPWMXLjoIATWy++oBQ
    JcTyE1hoSTRPBluVMCLKvz83HnhyJ6RtAsGkR7qnaQCeXIglnHx4pUsdIex/Nk52
    6Pk5XHO0oqc69JkSqN/GbOtU1BP7NOqPqLU8FDb9j/Z3t80MOZ7R2zqCHsO10c4O
    ahMRjN2bdqxAXf91R3c+8sj/Po8gl0beM+TNlC2ebQWPmAmXYOrR+t04mpoxX/5C
    unhXkvaboiwuMMIAMt2o0bre+4yruGjIH+QWVKrqHkgMFVOVJLuC4FUI03440Thq
    AMTbdvJjV+ENGUZtsx8EcpF8DnxAa75CD793UxwWPT0+eJGgYYKRhaBBuW3gtXS1
    lw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfKNMsYh/3EPD0YCGdk3YCPP2kK8pv/U8F3lUaP9CPH552MVA5uyHKdiC2W21xw2MDWpkkUFQOCqMyrxbcHy3OvywTcXrad7dH4ee1Y1YaMjkis5zKonF
    +GzEFh2+2HcrZnftiUynJtRwGRdIqqXdsM1bX6qF8ZIDP3v12qnaOZx6Nc/XtADvurm9TclutPLH4g9QrVsKouh+1l/3N4KELYzWsariBMolkXn3cS1+iX5n
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hGzw-44bAAAA:8
    a=6ohNodAXAAAA:8 a=wMNdZWldAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8
    a=PtDNVHqPAAAA:8 a=YozW3BgHpDp9_8hvpbEA:9 a=x8gzFH9gYPwA:10
    a=HvKuF1_PTVFglORKqfwH:22 a=0gLUg1G2xj6MhZ7RLP3J:22 a=FUarYpL4UH3yWsho8X8J:22
    a=IC2XNlieTeVoXbcui8wp:22 a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeDTBMR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:12:17 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50412 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753848AbeDTBMJ (ORCPT
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
Date: Thu, 19 Apr 2018 20:04:04 -0500
Message-Id: <20180420010408.24438-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KXE-00014u-Dj;;;mid=<20180420010408.24438-13-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+wcIh/BhNB0MFkZltxNsXEEhiWF+UgdDM=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa04.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 1104 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 4.9 (0.4%), b_tie_ro: 3.1 (0.3%), parse: 1.69 (0.2%),
        extract_message_metadata: 39 (3.5%), get_uri_detail_list: 3.9 (0.3%),
        tests_pri_-1000: 17 (1.6%), tests_pri_-950: 1.68 (0.2%), tests_pri_-900: 1.24
        (0.1%), tests_pri_-400: 27 (2.4%), check_bayes: 26 (2.3%), b_tokenize: 10
        (0.9%), b_tok_get_all: 8 (0.7%), b_comp_prob: 2.4 (0.2%), b_tok_touch_all:
        3.7 (0.3%), b_finish: 0.73 (0.1%), tests_pri_0: 186 (16.8%),
        check_dkim_signature: 0.61 (0.1%), check_dkim_adsp: 4.3 (0.4%),
        tests_pri_500: 821 (74.4%), poll_dns_idle: 808 (73.2%), rewrite_mail: 0.00
        (0.0%)
Subject: [REVIEW][PATCH 13/17] signal/powerpc: Replace FPE_FIXME with FPE_FLTUNK
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using an si_code of 0 that aliases with SI_USER is clearly the
wrong thing todo, and causes problems in interesting ways.

The newly defined FPE_FLTUNK semantically appears to fit the
bill so use it instead.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:  linuxppc-dev@lists.ozlabs.org
Fixes: 9bad068c24d7 ("[PATCH] ppc32: support for e500 and 85xx")
Fixes: 0ed70f6105ef ("PPC32: Provide proper siginfo information on various exceptions.")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/include/uapi/asm/siginfo.h | 7 -------
 arch/powerpc/kernel/traps.c             | 6 +++---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/siginfo.h b/arch/powerpc/include/uapi/asm/siginfo.h
index 9f142451a01f..0437afc9ef3c 100644
--- a/arch/powerpc/include/uapi/asm/siginfo.h
+++ b/arch/powerpc/include/uapi/asm/siginfo.h
@@ -15,13 +15,6 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGFPE si_codes
- */
-#ifdef __KERNEL__
-#define FPE_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
 /*
  * SIGTRAP si_codes
  */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 087855caf6a9..fdf9400beec8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1031,7 +1031,7 @@ static void emulate_single_step(struct pt_regs *regs)
 
 static inline int __parse_fpscr(unsigned long fpscr)
 {
-	int ret = FPE_FIXME;
+	int ret = FPE_FLTUNK;
 
 	/* Invalid operation */
 	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
@@ -1972,7 +1972,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	extern int do_spe_mathemu(struct pt_regs *regs);
 	unsigned long spefscr;
 	int fpexc_mode;
-	int code = FPE_FIXME;
+	int code = FPE_FLTUNK;
 	int err;
 
 	flush_spe_to_thread(current);
@@ -2041,7 +2041,7 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
 		printk(KERN_ERR "unrecognized spe instruction "
 		       "in %s at %lx\n", current->comm, regs->nip);
 	} else {
-		_exception(SIGFPE, regs, FPE_FIXME, regs->nip);
+		_exception(SIGFPE, regs, FPE_FLTUNK, regs->nip);
 		return;
 	}
 }
-- 
2.14.1

