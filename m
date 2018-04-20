Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524186743-2-16465056202320178636
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, SUSPICIOUS_RECIPS 2.51,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186742; b=ef1zpKYzMEVT9lvLh3FVWO4/YHjXfIVPrLYfm2fvir+G+D29P7
    DLw1LlJ34ZAEL4bNv4KAfCbO4K4uhDa3etSmxfxhx2I/2F683sHU7NUjvZkBtsn0
    yleM9EGdkZgSvo7KEXaCKcHDDP6YQ6m9soMANUdRBkEs9DuUAmCEOxC2uK1DnToJ
    X3E3yyOyU21MvXEXFF22WRKmoy5DY/rsrpa3ktymUZ+IejaYamrdZfHj+U0PH22C
    eU9aR4BjCjraXH14y+3Nav0rqXP4TfNgxbRubqSlxcfktHSf9JmsecmnNH8VqAau
    IXboKQevOhPUCMN8yIuEnL97VM8P30HCfGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186742; bh=gQGU
    l8pue1gkWyjVVXiIuR9KUXJPrEUy+ccK3d5Wu5I=; b=fJXiWtkY3+QOBPKvKuX6
    TMIl/tebJAWsYRcRG/MoXe/TcyPeaAaFwrLClgxHT9Q8AIDq1M6phkDOPXFJYYJb
    lT5lYeM4TcS8SBBKGQiVziiav/rGVX4iFCufFLfJAp5qjrG1IE3ovyxcMvnK5rUO
    wma+HtSu0EIgzBX2wj1hJbVEZboKR2iBKfNVA5HUR3u/rrVME7tk6tBQrSet+6Wj
    1ASPIRG2oESAdoRavoWI/fYwCuILihXWIlLWXYYuIecuQqROwHcAnhY7Z/Rfw+z6
    Cn9oLm/r3LeHgXKcKPtJmI1kL7n7wwTh03AaIihZntCbYtPNdzs4yIXfboNF2mK0
    ig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA703agStMJOdgOINeF8tuF18hd4zb0VuKLlc+eBOs9F9H1FzaNUzM+EpfchGWi2A6tHSEiRK+IbxkPnhnkVZ05/8yfOY7uIx20ycMGxuhaZVUlzIHQK
    GAJRJGIByPH0eEwm1Ib6/Ie/FKTY19e4LCwADywUSeMjEfREt4TZL6wY3qyf6ia1wcChPL5X0Qa1j4AkFK/O7Fe4NM7bVRjedRXrvbEXDqv8mPvmP8boeT9S
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=voM4FWlXAAAA:8 a=PtDNVHqPAAAA:8 a=8-S3HH8l9cNCP_YP4SAA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=IC2XNlieTeVoXbcui8wp:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeDTBMU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:12:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36120 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753862AbeDTBMJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:12:09 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 19 Apr 2018 20:04:06 -0500
Message-Id: <20180420010408.24438-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KXJ-00014u-FW;;;mid=<20180420010408.24438-15-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Eueji5jcUQvxdobsmkfkhKP9mKJZa87Y=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa04.xmission.com
X-Remote-Spam-Level: ******
X-Remote-Spam-Status: No, score=6.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,SUSPICIOUS_RECIPS,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  2.5 SUSPICIOUS_RECIPS Similar addresses in recipient list
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ******;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 196 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.5 (1.3%), b_tie_ro: 1.75 (0.9%), parse: 0.76 (0.4%),
        extract_message_metadata: 12 (6.3%), get_uri_detail_list: 1.61 (0.8%),
        tests_pri_-1000: 7 (3.8%), tests_pri_-950: 1.14 (0.6%), tests_pri_-900: 0.94
        (0.5%), tests_pri_-400: 18 (9.0%), check_bayes: 17 (8.6%), b_tokenize: 6
        (3.1%), b_tok_get_all: 5 (2.8%), b_comp_prob: 1.55 (0.8%), b_tok_touch_all:
        2.1 (1.1%), b_finish: 0.52 (0.3%), tests_pri_0: 144 (73.6%),
        check_dkim_signature: 0.47 (0.2%), check_dkim_adsp: 2.8 (1.4%),
        tests_pri_500: 6 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 15/17] signal: Add TRAP_UNK si_code for undiagnosted trap exceptions
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both powerpc and alpha have cases where they wronly set si_code to 0
in combination with SIGTRAP and don't mean SI_USER.

About half the time this is because the architecture can not report
accurately what kind of trap exception triggered the trap exception.
The other half the time it looks like no one has bothered to
figure out an appropriate si_code.

For the cases where the architecture does not have enough information
or is too lazy to figure out exactly what kind of trap exception
it is define TRAP_UNK.

Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 14c057f29979..9ccbf0576cd0 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -29,7 +29,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGFPE  != 15);
 	BUILD_BUG_ON(NSIGSEGV != 7);
 	BUILD_BUG_ON(NSIGBUS  != 5);
-	BUILD_BUG_ON(NSIGTRAP != 4);
+	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);
 	BUILD_BUG_ON(NSIGSYS  != 1);
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 558b902f18d4..80e2a7227205 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -249,7 +249,8 @@ typedef struct siginfo {
 #define TRAP_TRACE	2	/* process trace trap */
 #define TRAP_BRANCH     3	/* process taken branch trap */
 #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
-#define NSIGTRAP	4
+#define TRAP_UNK	5	/* undiagnosed trap */
+#define NSIGTRAP	5
 
 /*
  * There is an additional set of SIGTRAP si_codes used by ptrace
-- 
2.14.1

