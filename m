Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832778-2-6623045888186213149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521832777; b=vteZypeqWmP+oGglMgYonOykXE0ATZRWarcrw3V36VTeiE7
    lnLmgBeZAU3LCgTnlwca1Ib1IxceRRBkRUesdQPaFjEcVCEEF/QR+eKrlie+L5b9
    Jh0LjUcuFP1XA82Ev47LZhaVDbD6DCZ666cnGlOjdThVaU7Q1zC3/SSXncfKSlrj
    mwuxx/534jCmrCCiB0tyAcTnRqdZo5LKz9Z7xr1kgB84Zy1UQryIiCpwvev0NtFE
    Os1BDyxTA9OyXySnkQlyzeHzryhEU1SQP/dyEhUh7XlhglnLZjNSowUmkO1xa0Rx
    xWH29DurYk4zs40piwK0YZrMZA2ks3/PzTSh62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832777; bh=
    vdOZG73B4ETW1OS/hMnR4161BlCWTwibkZ+a5/BclH8=; b=p83wNelCKaxQpv74
    gbY8gliiDfezXNCrZDu9bXHJ9IuuP6HTI4suFQ4ztkuxVKuR6iYCd6oiMJ3rrAUH
    gwfiKo2jIMhRnbwzTLQK7nwKqtBU0JHu0OQpaU9QR63yi5boANvmP4MsVhpS+FTE
    ymy+mMq3lQUi5XFGHnfRQ5gf7EYT43RpqW9pjTBz4taX+Wiw+szCChtUvTGnO46E
    DAgF4f5EzWjQ3hOKxRJHmZr+TCiwOFMkt9Nzrd2BjfB+g+GNv1+Vh4kLpILhGOfu
    0hb6QZArK9XvY13R9sIUgi4ZChMKb2gZGfBhdclseqX8oEzExw2o7qV1TmiZp42C
    Z/S5jA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCWTTW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:19:22 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50624 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeCWTSF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:18:05 -0400
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
Date: Fri, 23 Mar 2018 14:16:09 -0500
Message-Id: <20180323191614.32489-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCR-00033I-1c;;;mid=<20180323191614.32489-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+IDXUY6D4KdQo3Axbz7XJ3JefL5TgeRQ8=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ****
X-Remote-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TooManySym_01,T_TooManySym_02,
        T_XMDrugObfuBody_04,XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ****;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 243 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (1.1%), b_tie_ro: 1.88 (0.8%), parse: 0.74 (0.3%),
        extract_message_metadata: 10 (4.0%), get_uri_detail_list: 1.42 (0.6%),
        tests_pri_-1000: 5 (2.2%), tests_pri_-950: 1.12 (0.5%), tests_pri_-900: 0.98
        (0.4%), tests_pri_-400: 19 (8.0%), check_bayes: 18 (7.6%), b_tokenize: 7
        (2.9%), b_tok_get_all: 6 (2.3%), b_comp_prob: 1.58 (0.7%), b_tok_touch_all:
        2.6 (1.1%), b_finish: 0.54 (0.2%), tests_pri_0: 197 (80.9%),
        check_dkim_signature: 0.46 (0.2%), check_dkim_adsp: 3.1 (1.3%),
        tests_pri_500: 3.9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 06/11] msg: Move struct msg_queue into ipc/msg.c
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All of the users are now in ipc/msg.c so make the definition local to
that file to make code maintenance easier.  AKA to prevent rebuilding
the entire kernel when struct msg_queue changes.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/msg.h | 18 ------------------
 ipc/msg.c           | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/msg.h b/include/linux/msg.h
index 0a7eefeee0d1..9a972a296b95 100644
--- a/include/linux/msg.h
+++ b/include/linux/msg.h
@@ -3,7 +3,6 @@
 #define _LINUX_MSG_H
 
 #include <linux/list.h>
-#include <linux/time64.h>
 #include <uapi/linux/msg.h>
 
 /* one msg_msg structure for each message */
@@ -16,21 +15,4 @@ struct msg_msg {
 	/* the actual message follows immediately */
 };
 
-/* one msq_queue structure for each present queue on the system */
-struct msg_queue {
-	struct kern_ipc_perm q_perm;
-	time64_t q_stime;		/* last msgsnd time */
-	time64_t q_rtime;		/* last msgrcv time */
-	time64_t q_ctime;		/* last change time */
-	unsigned long q_cbytes;		/* current number of bytes on queue */
-	unsigned long q_qnum;		/* number of messages in queue */
-	unsigned long q_qbytes;		/* max number of bytes on queue */
-	pid_t q_lspid;			/* pid of last msgsnd */
-	pid_t q_lrpid;			/* last receive pid */
-
-	struct list_head q_messages;
-	struct list_head q_receivers;
-	struct list_head q_senders;
-} __randomize_layout;
-
 #endif /* _LINUX_MSG_H */
diff --git a/ipc/msg.c b/ipc/msg.c
index cdfab0825fce..af5a963306c4 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -43,6 +43,23 @@
 #include <linux/uaccess.h>
 #include "util.h"
 
+/* one msq_queue structure for each present queue on the system */
+struct msg_queue {
+	struct kern_ipc_perm q_perm;
+	time64_t q_stime;		/* last msgsnd time */
+	time64_t q_rtime;		/* last msgrcv time */
+	time64_t q_ctime;		/* last change time */
+	unsigned long q_cbytes;		/* current number of bytes on queue */
+	unsigned long q_qnum;		/* number of messages in queue */
+	unsigned long q_qbytes;		/* max number of bytes on queue */
+	pid_t q_lspid;			/* pid of last msgsnd */
+	pid_t q_lrpid;			/* last receive pid */
+
+	struct list_head q_messages;
+	struct list_head q_receivers;
+	struct list_head q_senders;
+} __randomize_layout;
+
 /* one msg_receiver structure for each sleeping receiver */
 struct msg_receiver {
 	struct list_head	r_list;
-- 
2.14.1

