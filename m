Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832697-2-458586996618154838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521832697; b=Nr4UaYGJYTPi4tidj1wmEV3ifnoWhKdlZ8hkE+vSaKZw8tq
    s5/6P6cHnC9amhUGePrCg7fJMs5wBz5kbXZzNqEopWp1A41qQvYlJv6UEvNYx+1z
    nKEodttzvYZmTU8bmArq7T6ur2GH95U/GJqkrpPKNcniE/c5gogUSv37Hk55A0A+
    Rr6esaPDjFvTKsfiCk2BDpqd0+BvVJA99CWaBmZ3hbz1fLZ6veLqrnyB6OfspwZK
    noCx3EnGAD7ufDWgloT5Gqi9hK03zZgZF3CI+TWOrH71bBq25QcnFaOKEKFveMN2
    K+QxbKTeEMxiCAed9ilxKoVWwc5zFXcxnRRhTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832697; bh=
    5HDvkvxG/Cx71Vy/nMyr1+kv1Jwv2N2auD97OYQ5ujI=; b=h2G5SRGlXqsOSn7+
    cHVg+6QZneKIEIWJ8mG9OoFUJn881c7XPr/4TQCxNDd1kaN2YeORx1x5xJ8SNKlM
    7J9o7BQR53XrfMju3goE9ecNZE0nfSUrxtX16fytV8tqXTCHQ3otEld+sJDC/CAY
    IVY2aEaq5i3q5mNWjkeX/0JRzxs3nf8XqSb+/Efi8tuxa3emE8zebYRAHE529uuP
    TZdf9nOwqm5Vf4KroN5ZonW+FJ+ib8Fr3IZG6Z4f5QhPVokjoUq8GLPgR3oKom8M
    CyIkzY+160WPwoKr8XMEQQYyJVIu+rxSV9KDfUA9oW5E0jZ1+9l8iaUSFESVoUDZ
    a9Vsbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeCWTSM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:18:12 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59025 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeCWTSJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:18:09 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 23 Mar 2018 14:16:10 -0500
Message-Id: <20180323191614.32489-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCV-00033I-Hj;;;mid=<20180323191614.32489-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19JXPAiNZwQ5vLvCDKG+VmPu7upRnlGpbY=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa08.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 190 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (1.3%), b_tie_ro: 1.74 (0.9%), parse: 0.55 (0.3%),
        extract_message_metadata: 7 (3.8%), get_uri_detail_list: 0.63 (0.3%),
        tests_pri_-1000: 4.6 (2.4%), tests_pri_-950: 1.03 (0.5%), tests_pri_-900:
        0.90 (0.5%), tests_pri_-400: 15 (8.0%), check_bayes: 14 (7.6%), b_tokenize:
        4.4 (2.3%), b_tok_get_all: 5 (2.7%), b_comp_prob: 1.19 (0.6%),
        b_tok_touch_all: 1.87 (1.0%), b_finish: 0.55 (0.3%), tests_pri_0: 152 (80.2%),
         check_dkim_signature: 0.43 (0.2%), check_dkim_adsp: 2.7 (1.4%),
        tests_pri_500: 3.3 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 07/11] ipc: Move IPCMNI from include/ipc.h into ipc/util.h
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The definition IPCMNI is only used in ipc/util.h and ipc/util.c.  So
there is no reason to keep it in a header file that the whole kernel
can see.  Move it into util.h to simplify future maintenance.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ipc.h | 2 --
 ipc/util.h          | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index 821b2f260992..6cc2df7f7ac9 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -8,8 +8,6 @@
 #include <uapi/linux/ipc.h>
 #include <linux/refcount.h>
 
-#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
-
 /* used by in-kernel data structures */
 struct kern_ipc_perm {
 	spinlock_t	lock;
diff --git a/ipc/util.h b/ipc/util.h
index 89b8ec176fc4..959c10eb9cc1 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/ipc_namespace.h>
 
+#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
 #define SEQ_MULTIPLIER	(IPCMNI)
 
 int sem_init(void);
-- 
2.14.1

