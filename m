Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3056699-1521870139-2-16687019979817525188
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
    t=1521870138; b=MGQdaxa1QTOuOGPnbhP7vXmP/FUllHZSRVW9B5/2ELYyaPh
    ilbcj9pg4Iq2l1IaKqVDS0o99nh19enGrFVhflGhYYONsdEbt56DyRtzpyMxpuFL
    XWb6d/S0s2EmhxjLiCPREkY8BOVc4GTXVYroQ923TJ3y+kiP11pmQMX5d5J6pTfF
    k78LL1zoW+Wxux1a1h81JytIRnjm76rdqL6Lp5w2ct9/IY86r1hHXGLRdjsjwkhM
    LV6+91M1l2hLuXa6y/yTwV7nVQLi/CHtY0dnTi2JAKCGkCVcDYKUP2+SH7bg65b5
    ExyC62yElp1lBIbd/eB+zENR5f2vIIILIjoXa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    arctest; t=1521870138; bh=EfWzKdnEfq2tQHRHHpA7Jx6Pf/MYlv/eb+eoi6
    B9tCk=; b=ax6nOGcxQbonwkWamvvalWEtO4q6MIoia37+l580+EE74tN2pRc1H6
    Uqn6fCjf3M9JPR1QpqypjrYj6YzT3RmUtRy52bhca3Li4OBlk3L6wKVXVwsoJtaG
    fvU99GkwI3Ji+LMbP/g6MMYOOTcQTHXSlbgwNZVo1VgJwbhewTqQa5UvfnZ85opc
    Z7syjHPgjAQ3IWAP/YciqGH1R0Ch76ux9p08HhDvYikx95Y+bVGMsbbCtvuMvbB2
    syl1xGsIVhU6Vc4pZkQWlZcYXf+v7fK1cP/YcDq0vn4KkWP2WFpPsqZ2EnwAwMAj
    l2NO3YxJ8aRUOwDxloFd2Ri3c063Gh0g==
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
        id S1750819AbeCXFmQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 01:42:16 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56456 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCXFmO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 24 Mar 2018 01:42:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: esyr@redhat.com, jannh@google.com, khlebnikov@yandex-team.ru,
        linux-api@vger.kernel.org, serge.hallyn@ubuntu.com,
        linux-kernel@vger.kernel.org, prakash.sangappa@oracle.com,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        oleg@redhat.com, akpm@linux-foundation.org,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Pavel Emelyanov <xemul@openvz.org>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
        <87vadzqqq6.fsf@xmission.com>
        <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
        <877eqejowd.fsf@xmission.com>
        <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
        <87a7v2z2qa.fsf@xmission.com> <87vadmobdw.fsf_-_@xmission.com>
Date: Sat, 24 Mar 2018 00:40:36 -0500
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 23 Mar 2018 14:11:23 -0500")
Message-ID: <877eq2m3or.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezbvp-0002Ur-DC;;;mid=<877eq2m3or.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19LsWhkGARHkMZnkpNheHNw7Vk+a/gCXgw=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TooManySym_01,T_TooManySym_02,
        XMNoVowels,XMSolicitRefs_0,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 263 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.4 (1.3%), b_tie_ro: 2.5 (0.9%), parse: 1.08 (0.4%),
        extract_message_metadata: 12 (4.6%), get_uri_detail_list: 2.2 (0.8%),
        tests_pri_-1000: 6 (2.2%), tests_pri_-950: 1.13 (0.4%), tests_pri_-900: 0.98
        (0.4%), tests_pri_-400: 22 (8.2%), check_bayes: 21 (7.9%), b_tokenize: 8
        (2.9%), b_tok_get_all: 7 (2.6%), b_comp_prob: 1.56 (0.6%), b_tok_touch_all:
        2.8 (1.1%), b_finish: 0.64 (0.2%), tests_pri_0: 207 (79.0%),
        check_dkim_signature: 0.47 (0.2%), check_dkim_adsp: 2.6 (1.0%),
        tests_pri_500: 6 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 12/11] ipc: Directly call the security hook in ipc_ops.associate
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


After the last round of cleanups the shm, sem, and msg associate
operations just became trivial wrappers around the appropriate security
method.  Simplify things further by just calling the security method
directly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 ipc/msg.c | 10 +---------
 ipc/sem.c | 10 +---------
 ipc/shm.c | 10 +---------
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 825ad585a6ff..d667dd8e97ab 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -272,20 +272,12 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 	ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
 }
 
-/*
- * Called with msg_ids.rwsem and ipcp locked.
- */
-static inline int msg_security(struct kern_ipc_perm *ipcp, int msgflg)
-{
-	return security_msg_queue_associate(ipcp, msgflg);
-}
-
 SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
 {
 	struct ipc_namespace *ns;
 	static const struct ipc_ops msg_ops = {
 		.getnew = newque,
-		.associate = msg_security,
+		.associate = security_msg_queue_associate,
 	};
 	struct ipc_params msg_params;
 
diff --git a/ipc/sem.c b/ipc/sem.c
index 47b263960524..09d54af076a4 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -564,14 +564,6 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 }
 
 
-/*
- * Called with sem_ids.rwsem and ipcp locked.
- */
-static inline int sem_security(struct kern_ipc_perm *ipcp, int semflg)
-{
-	return security_sem_associate(ipcp, semflg);
-}
-
 /*
  * Called with sem_ids.rwsem and ipcp locked.
  */
@@ -592,7 +584,7 @@ SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, semflg)
 	struct ipc_namespace *ns;
 	static const struct ipc_ops sem_ops = {
 		.getnew = newary,
-		.associate = sem_security,
+		.associate = security_sem_associate,
 		.more_checks = sem_more_checks,
 	};
 	struct ipc_params sem_params;
diff --git a/ipc/shm.c b/ipc/shm.c
index 932b7e411c6c..018db3d0e70e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -656,14 +656,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	return error;
 }
 
-/*
- * Called with shm_ids.rwsem and ipcp locked.
- */
-static inline int shm_security(struct kern_ipc_perm *ipcp, int shmflg)
-{
-	return security_shm_associate(ipcp, shmflg);
-}
-
 /*
  * Called with shm_ids.rwsem and ipcp locked.
  */
@@ -684,7 +676,7 @@ SYSCALL_DEFINE3(shmget, key_t, key, size_t, size, int, shmflg)
 	struct ipc_namespace *ns;
 	static const struct ipc_ops shm_ops = {
 		.getnew = newseg,
-		.associate = shm_security,
+		.associate = security_shm_associate,
 		.more_checks = shm_more_checks,
 	};
 	struct ipc_params shm_params;
-- 
2.14.1

