Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755339AbeDTOl5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:41:57 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44238 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDTOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:40:43 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Simek <monstr@monstr.eu>
Date: Fri, 20 Apr 2018 09:37:55 -0500
Message-Id: <20180420143811.9994-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XDO-0006Ha-8t;;;mid=<20180420143811.9994-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Hyx9ICHN8PIGMd+4W7xawfPRAC8wOmR8=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 129 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (3.3%), b_tie_ro: 3.1 (2.4%), parse: 0.98 (0.8%),
        extract_message_metadata: 13 (10.0%), get_uri_detail_list: 1.31 (1.0%),
        tests_pri_-1000: 6 (4.4%), tests_pri_-950: 1.04 (0.8%), tests_pri_-900: 0.89
        (0.7%), tests_pri_-400: 16 (12.1%), check_bayes: 15 (11.4%), b_tokenize: 3.2
        (2.5%), b_tok_get_all: 4.4 (3.4%), b_comp_prob: 1.05 (0.8%), b_tok_touch_all:
        3.8 (3.0%), b_finish: 0.73 (0.6%), tests_pri_0: 81 (62.6%),
        check_dkim_signature: 0.35 (0.3%), check_dkim_adsp: 2.9 (2.3%),
        tests_pri_500: 4.5 (3.5%), poll_dns_idle: 0.41 (0.3%), rewrite_mail: 0.00
        (0.0%)
Subject: [REVIEW][PATCH 06/22] signal/microblaze: Remove the commented out force_sig_info in do_page_fault
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the commented out call to force_sig_info right after a call to
_exception in do_page_fault.  The function _exception does exactly the
work the commented out code does so there is no reason for the
commented out code.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/microblaze/mm/fault.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 43d92167012a..1251d380df47 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -268,11 +268,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	/* User mode accesses cause a SIGSEGV */
 	if (user_mode(regs)) {
 		_exception(SIGSEGV, regs, code, address);
-/*		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code = code;
-		info.si_addr = (void *) address;
-		force_sig_info(SIGSEGV, &info, current);*/
 		return;
 	}
 
-- 
2.14.1
