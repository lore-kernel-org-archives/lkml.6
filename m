Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1934556-1521832800-2-6572115411083998850
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
    t=1521832800; b=CRzQSKc3y8daBIRl/dnVfuNxaATlQbQ4FxOXLvD30o4t5SE
    pvLYWOVdWBrHeXzxcg2+DN/btzrcT9JAFNfFEmgzmBTbvQ6RtiLR2/OilszyFkHa
    iOtDRP3gRmi9y9R0SKjuNq1fydyKAelHK92/Knx9Itc5UlUA1I8ekGHW6mbnFmMJ
    ri809udQ9Z8IHdPVIpZecQiMum+m9OBIkL36SBdQxy3gG8Z99ORS3IqFnGdJ6gQX
    4I9bhqpyO9HZjW7m5Yt+ncfcwu3UERnbM3zUDlFfTyFpY0LXCxGqCV0re0vQ5ML6
    yh8CO3VavipXz4MxaUZDIyw1Mn113ZfEs07UkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832800; bh=
    llRUAYgMWuuu43GeKnQGvAJfDbi2tRo1bEY5FUmfp2M=; b=IeFffdWf2dbwliI5
    rHZqkr7ylx2j9pA47GnR6JuJStFot++eJTEyCUESeczEmwewxGnyOC2qq7jOHXi8
    4VBhIgNgVkHuVlIUkMBANbDBQvpfun8wy17E6G2mgNwNMN2k0YhfThng2RrSdUur
    jJF2OovkGvU9YQjensqLmVV47qdQHFaqe8YfKpAcfU8tlN8M+YY2WVCqiD/2WwgM
    JaO0VTw1mmXvvg6v5eDKRERptNmVeRuOvbF01RrDIkQb6ymgcwMu3PYIJx4zmhDn
    W43RK3+iQOEB7wWb2tQdf4lTVKcDJafkYsY9T1LSS9wbDsOSDwN0HZs/yDRnPuuN
    M+kgFA==
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
        id S1752098AbeCWTTo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:19:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50598 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbeCWTR4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:17:56 -0400
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
Date: Fri, 23 Mar 2018 14:16:07 -0500
Message-Id: <20180323191614.32489-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCH-00033I-N9;;;mid=<20180323191614.32489-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18obdhlYGvB3Y3HNVelXQoqf8bObTfsqXw=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa01.xmission.com
X-Remote-Spam-Level: ****
X-Remote-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TooManySym_01,T_TooManySym_02,
        T_XMDrugObfuBody_04,XMNoVowels,XMSubLong autolearn=disabled version=3.4.0
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
X-Remote-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ****;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 869 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.0 (0.3%), b_tie_ro: 2.0 (0.2%), parse: 1.47 (0.2%),
        extract_message_metadata: 28 (3.2%), get_uri_detail_list: 4.4 (0.5%),
        tests_pri_-1000: 10 (1.2%), tests_pri_-950: 2.1 (0.2%), tests_pri_-900: 1.68
        (0.2%), tests_pri_-400: 37 (4.3%), check_bayes: 35 (4.1%), b_tokenize: 18
        (2.1%), b_tok_get_all: 8 (0.9%), b_comp_prob: 3.8 (0.4%), b_tok_touch_all:
        2.7 (0.3%), b_finish: 0.74 (0.1%), tests_pri_0: 774 (89.0%),
        check_dkim_signature: 0.91 (0.1%), check_dkim_adsp: 4.0 (0.5%),
        tests_pri_500: 7 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 04/11] sem: Move struct sem and struct sem_array into ipc/sem.c
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All of the users are now in ipc/sem.c so make the definitions
local to that file to make code maintenance easier.  AKA
to prevent rebuilding the entire kernel when one of these
files is changed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sem.h | 40 +---------------------------------------
 ipc/sem.c           | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/include/linux/sem.h b/include/linux/sem.h
index 9badd322dcee..5608a500c43e 100644
--- a/include/linux/sem.h
+++ b/include/linux/sem.h
@@ -2,48 +2,10 @@
 #ifndef _LINUX_SEM_H
 #define _LINUX_SEM_H
 
-#include <linux/atomic.h>
-#include <linux/rcupdate.h>
-#include <linux/cache.h>
-#include <linux/time64.h>
 #include <uapi/linux/sem.h>
 
 struct task_struct;
-
-/* One semaphore structure for each semaphore in the system. */
-struct sem {
-	int	semval;		/* current value */
-	/*
-	 * PID of the process that last modified the semaphore. For
-	 * Linux, specifically these are:
-	 *  - semop
-	 *  - semctl, via SETVAL and SETALL.
-	 *  - at task exit when performing undo adjustments (see exit_sem).
-	 */
-	int	sempid;
-	spinlock_t	lock;	/* spinlock for fine-grained semtimedop */
-	struct list_head pending_alter; /* pending single-sop operations */
-					/* that alter the semaphore */
-	struct list_head pending_const; /* pending single-sop operations */
-					/* that do not alter the semaphore*/
-	time_t	sem_otime;	/* candidate for sem_otime */
-} ____cacheline_aligned_in_smp;
-
-/* One sem_array data structure for each set of semaphores in the system. */
-struct sem_array {
-	struct kern_ipc_perm	sem_perm;	/* permissions .. see ipc.h */
-	time64_t		sem_ctime;	/* create/last semctl() time */
-	struct list_head	pending_alter;	/* pending operations */
-						/* that alter the array */
-	struct list_head	pending_const;	/* pending complex operations */
-						/* that do not alter semvals */
-	struct list_head	list_id;	/* undo requests on this array */
-	int			sem_nsems;	/* no. of semaphores in array */
-	int			complex_count;	/* pending complex operations */
-	unsigned int		use_global_lock;/* >0: global lock required */
-
-	struct sem		sems[];
-} __randomize_layout;
+struct sem_undo_list;
 
 #ifdef CONFIG_SYSVIPC
 
diff --git a/ipc/sem.c b/ipc/sem.c
index 01f5c63670ae..d661c491b0a5 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -88,6 +88,40 @@
 #include <linux/uaccess.h>
 #include "util.h"
 
+/* One semaphore structure for each semaphore in the system. */
+struct sem {
+	int	semval;		/* current value */
+	/*
+	 * PID of the process that last modified the semaphore. For
+	 * Linux, specifically these are:
+	 *  - semop
+	 *  - semctl, via SETVAL and SETALL.
+	 *  - at task exit when performing undo adjustments (see exit_sem).
+	 */
+	int	sempid;
+	spinlock_t	lock;	/* spinlock for fine-grained semtimedop */
+	struct list_head pending_alter; /* pending single-sop operations */
+					/* that alter the semaphore */
+	struct list_head pending_const; /* pending single-sop operations */
+					/* that do not alter the semaphore*/
+	time_t	sem_otime;	/* candidate for sem_otime */
+} ____cacheline_aligned_in_smp;
+
+/* One sem_array data structure for each set of semaphores in the system. */
+struct sem_array {
+	struct kern_ipc_perm	sem_perm;	/* permissions .. see ipc.h */
+	time64_t		sem_ctime;	/* create/last semctl() time */
+	struct list_head	pending_alter;	/* pending operations */
+						/* that alter the array */
+	struct list_head	pending_const;	/* pending complex operations */
+						/* that do not alter semvals */
+	struct list_head	list_id;	/* undo requests on this array */
+	int			sem_nsems;	/* no. of semaphores in array */
+	int			complex_count;	/* pending complex operations */
+	unsigned int		use_global_lock;/* >0: global lock required */
+
+	struct sem		sems[];
+} __randomize_layout;
 
 /* One queue for each sleeping process in the system. */
 struct sem_queue {
-- 
2.14.1

