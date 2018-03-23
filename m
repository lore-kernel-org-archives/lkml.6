Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832732-2-1230971468636165953
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
    t=1521832732; b=swvLLz7+/3PMCGK4Uh7quqW0KA3zuJqXVfflle8TVJ/h12f
    zVVxnFZWw1yi763F5O2IlZDGoRjuWtcB5ftfYWYTBltxQC1nTaGHtia68EKtErQq
    eKikFb9JfKBUQDaiD9S5vlI3CUiXr5bMbbbV5/BJcvFTOwLQ8+ODMSIY0iaIciEd
    Ftd57cX2bfGzSwUX/JPceIq+UfmUGdiVLeuJpmtcXPeN+oBZk5vDhre9NH74Izaj
    qtZyfLqhhKEnW4B+nsEoXjDyo2ARucXKQG6AqiwEb2EYDs0AbQbi/dvvjYA6lX5J
    QT3tSi9mEYe/Z9PG/Fsd+QYiTPP2UH4jCTzibgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832732; bh=
    DrJEqmi3HJPz4w+GQ9m1e80SkYH/LbZ4dPeH97frJVc=; b=XjKhjCi4550evAo+
    MEW//A83b7RblEX9PMLBv/neywc7aL2uxMthAe1rENp02eMslUYLd9wJNmlXUgAL
    MGhrTRPdoL+o1yqJGTqHT17H6CTLJSSTU/AVehk2aNvh/furK4nsoC5Pmmqjq8WF
    5rZQnlSdXe/IEIJNSr7FZmeAcSHyoox/tg09wpIgLy5UjCZ3XteDjGin/PYUDAnI
    KBpjrk0QYF8qk8qh7C6VOnLscDdsg/gzcp9gDiAuVHhYxJ/7brMY2u9byeh5K/of
    f0TaMogCbmxwx7MT9+hxEpnGzBzIukqD9YrK3aeB8jpwW6AXPZHeWTPtyKGzC5Am
    PLAtIQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1752203AbeCWTST (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:18:19 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50659 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbeCWTSQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:18:16 -0400
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
Date: Fri, 23 Mar 2018 14:16:12 -0500
Message-Id: <20180323191614.32489-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCb-00033I-9j;;;mid=<20180323191614.32489-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX192ZiLC1dxNPwnqTYlSAuXBcQEBMPPKK6s=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        T_TooManySym_05,XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 360 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (1.1%), b_tie_ro: 3.0 (0.8%), parse: 0.83 (0.2%),
        extract_message_metadata: 11 (3.2%), get_uri_detail_list: 2.4 (0.7%),
        tests_pri_-1000: 6 (1.7%), tests_pri_-950: 1.22 (0.3%), tests_pri_-900: 1.07
        (0.3%), tests_pri_-400: 32 (8.9%), check_bayes: 31 (8.6%), b_tokenize: 10
        (2.9%), b_tok_get_all: 12 (3.2%), b_comp_prob: 2.8 (0.8%), b_tok_touch_all:
        3.8 (1.1%), b_finish: 0.54 (0.1%), tests_pri_0: 297 (82.3%),
        check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 2.7 (0.7%),
        tests_pri_500: 4.3 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 09/11] ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Today shm_cpid and shm_lpid are remembered in the pid namespace of the
creator and the processes that last touched a sysvipc shared memory
segment.   If you have processes in multiple pid namespaces that
is just wrong, and I don't know how this has been over-looked for
so long.

As only creation and shared memory attach and shared memory detach
update the pids I do not expect there to be a repeat of the issues
when struct pid was attached to each af_unix skb, which in some
notable cases cut the performance in half.  The problem was threads of
the same process updating same struct pid from different cpus causing
the cache line to be highly contended and bounce between cpus.

As creation, attach, and detach are expected to be rare operations for
sysvipc shared memory segments I do not expect that kind of cache line
ping pong to cause probems.  In addition because the pid is at a fixed
location in the structure instead of being dynamic on a skb, the
reference count of the pid does not need to be updated on each
operation if the pid is the same.  This ability to simply skip the pid
reference count changes if the pid is unchanging further reduces the
likelihood of the a cache line holding a pid reference count
ping-ponging between cpus.

Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 ipc/shm.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 0565669ebe5c..932b7e411c6c 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -57,8 +57,8 @@ struct shmid_kernel /* private to the kernel */
 	time64_t		shm_atim;
 	time64_t		shm_dtim;
 	time64_t		shm_ctim;
-	pid_t			shm_cprid;
-	pid_t			shm_lprid;
+	struct pid		*shm_cprid;
+	struct pid		*shm_lprid;
 	struct user_struct	*mlock_user;
 
 	/* The task created the shm object.  NULL if the task is dead. */
@@ -226,7 +226,7 @@ static int __shm_open(struct vm_area_struct *vma)
 		return PTR_ERR(shp);
 
 	shp->shm_atim = ktime_get_real_seconds();
-	shp->shm_lprid = task_tgid_vnr(current);
+	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
 	shp->shm_nattch++;
 	shm_unlock(shp);
 	return 0;
@@ -267,6 +267,8 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
 		user_shm_unlock(i_size_read(file_inode(shm_file)),
 				shp->mlock_user);
 	fput(shm_file);
+	ipc_update_pid(&shp->shm_cprid, NULL);
+	ipc_update_pid(&shp->shm_lprid, NULL);
 	ipc_rcu_putref(&shp->shm_perm, shm_rcu_free);
 }
 
@@ -311,7 +313,7 @@ static void shm_close(struct vm_area_struct *vma)
 	if (WARN_ON_ONCE(IS_ERR(shp)))
 		goto done; /* no-op */
 
-	shp->shm_lprid = task_tgid_vnr(current);
+	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
 	shp->shm_dtim = ktime_get_real_seconds();
 	shp->shm_nattch--;
 	if (shm_may_destroy(ns, shp))
@@ -614,8 +616,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	if (IS_ERR(file))
 		goto no_file;
 
-	shp->shm_cprid = task_tgid_vnr(current);
-	shp->shm_lprid = 0;
+	shp->shm_cprid = get_pid(task_tgid(current));
+	shp->shm_lprid = NULL;
 	shp->shm_atim = shp->shm_dtim = 0;
 	shp->shm_ctim = ktime_get_real_seconds();
 	shp->shm_segsz = size;
@@ -648,6 +650,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		user_shm_unlock(size, shp->mlock_user);
 	fput(file);
 no_file:
+	ipc_update_pid(&shp->shm_cprid, NULL);
+	ipc_update_pid(&shp->shm_lprid, NULL);
 	call_rcu(&shp->shm_perm.rcu, shm_rcu_free);
 	return error;
 }
@@ -970,8 +974,8 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	tbuf->shm_atime	= shp->shm_atim;
 	tbuf->shm_dtime	= shp->shm_dtim;
 	tbuf->shm_ctime	= shp->shm_ctim;
-	tbuf->shm_cpid	= shp->shm_cprid;
-	tbuf->shm_lpid	= shp->shm_lprid;
+	tbuf->shm_cpid	= pid_vnr(shp->shm_cprid);
+	tbuf->shm_lpid	= pid_vnr(shp->shm_lprid);
 	tbuf->shm_nattch = shp->shm_nattch;
 
 	ipc_unlock_object(&shp->shm_perm);
@@ -1605,6 +1609,7 @@ SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
 {
+	struct pid_namespace *pid_ns = ipc_seq_pid_ns(s);
 	struct user_namespace *user_ns = seq_user_ns(s);
 	struct kern_ipc_perm *ipcp = it;
 	struct shmid_kernel *shp;
@@ -1627,8 +1632,8 @@ static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
 		   shp->shm_perm.id,
 		   shp->shm_perm.mode,
 		   shp->shm_segsz,
-		   shp->shm_cprid,
-		   shp->shm_lprid,
+		   pid_nr_ns(shp->shm_cprid, pid_ns),
+		   pid_nr_ns(shp->shm_lprid, pid_ns),
 		   shp->shm_nattch,
 		   from_kuid_munged(user_ns, shp->shm_perm.uid),
 		   from_kgid_munged(user_ns, shp->shm_perm.gid),
-- 
2.14.1

