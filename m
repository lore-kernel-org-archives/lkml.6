Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1934556-1521832910-2-12636911007946667395
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
    t=1521832909; b=Vnga1RejhJHwO9zFIGqkeUY24k8QzB7jwCaA9eW4HkyMavY
    5YzrbE5Ro8ubCDYWzRZUYfp4XONEWmz2SuDWiPzKH4xcNFlHlCW8yNKDmrQhkDlc
    zQZyWWd2B5JkIh3oBAQz7wimjVmwqpAXNCih8LYfcR8KD8RiRn0ipA9CHoKHxrBi
    e7oz6H+uW7M9QqWke5F2HKuujBBoSO/fg6HpgC7H2p7AUYggFMZL3Ssw+j8rHwHU
    jvq9ZcX48P0Jj0gBrqmrnqZZg9yt0/YfBXXWaT4QyV0eRB2aeApcAQui3Y4yEtp0
    xtjiB50yUk7BuYIEZi72logRBD0qOzwze+nUnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832909; bh=
    I8XNc9aYkYoUEiRhNqkniE4lZdrFDzEdOUzhXV7mKE8=; b=IV+uHz93CdQpblk/
    6bF7Sw0r7c1Z1/HZn8fy3uPsuRW9PLXt/nqZ0wBAtMb9X0egXFPPfKMfVtN2B/hN
    KSCpEBgYUgcpoEUFs+oionjVL+hNdnjOF8y4rY8k5+uBag1lSW8d+vF2/JxXlTSn
    tTVjrwMuuNpgSo2Oh3xIPRXSD2Kz9J7KJvQqQW4j+xqg5O6I7nlsShS/iGNXSzFt
    uGluoAzfjYjR97A4BFJoLfVjlgby1prIhIRj7TprOBbbCa2+Lc2/bNIhsU7dK2dy
    TkJsduaCCqkfJVN2CpncDVDCwrc6T8j2+ChmcignU1dNjROq3MokQxFq79KlkKd/
    e1znPQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeCWTVs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:21:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59462 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeCWTVp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:21:45 -0400
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
Date: Fri, 23 Mar 2018 14:16:14 -0500
Message-Id: <20180323191614.32489-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCr-00033I-LJ;;;mid=<20180323191614.32489-11-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18jfMYCTvQEchlVOiXnfr4kjCa0s3RxgWw=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMNoVowels,
        XMSolicitRefs_0,XMSubLong autolearn=disabled version=3.4.1
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
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 411 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (0.6%), b_tie_ro: 1.88 (0.5%), parse: 0.86 (0.2%),
        extract_message_metadata: 11 (2.8%), get_uri_detail_list: 2.8 (0.7%),
        tests_pri_-1000: 6 (1.4%), tests_pri_-950: 1.18 (0.3%), tests_pri_-900: 1.01
        (0.2%), tests_pri_-400: 32 (7.7%), check_bayes: 30 (7.4%), b_tokenize: 11
        (2.7%), b_tok_get_all: 9 (2.3%), b_comp_prob: 3.6 (0.9%), b_tok_touch_all:
        3.6 (0.9%), b_finish: 0.63 (0.2%), tests_pri_0: 348 (84.6%),
        check_dkim_signature: 0.52 (0.1%), check_dkim_adsp: 2.7 (0.7%),
        tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 11/11] ipc/sem: Fix semctl(..., GETPID, ...) between pid namespaces
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Today the last process to update a semaphore is remembered and
reported in the pid namespace of that process.  If there are processes
in any other pid namespace querying that process id with GETPID the
result will be unusable nonsense as it does not make any
sense in your own pid namespace.

Due to ipc_update_pid I don't think you will be able to get System V
ipc semaphores into a troublesome cache line ping-pong.  Using struct
pids from separate process are not a problem because they do not share
a cache line.  Using struct pid from different threads of the same
process are unlikely to be a problem as the reference count update
can be avoided.

Further linux futexes are a much better tool for the job of mutual
exclusion between processes than System V semaphores.  So I expect
programs that  are performance limited by their interprocess mutual
exclusion primitive will be using futexes.

So while it is possible that enhancing the storage of the last
rocess of a System V semaphore from an integer to a struct pid
will cause a performance regression because of the effect
of frequently updating the pid reference count.  I don't expect
that to happen in practice.

This change updates semctl(..., GETPID, ...) to return the
process id of the last process to update a semphore inthe
pid namespace of the calling process.

Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 ipc/sem.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index d661c491b0a5..47b263960524 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -98,7 +98,7 @@ struct sem {
 	 *  - semctl, via SETVAL and SETALL.
 	 *  - at task exit when performing undo adjustments (see exit_sem).
 	 */
-	int	sempid;
+	struct pid *sempid;
 	spinlock_t	lock;	/* spinlock for fine-grained semtimedop */
 	struct list_head pending_alter; /* pending single-sop operations */
 					/* that alter the semaphore */
@@ -128,7 +128,7 @@ struct sem_queue {
 	struct list_head	list;	 /* queue of pending operations */
 	struct task_struct	*sleeper; /* this process */
 	struct sem_undo		*undo;	 /* undo structure */
-	int			pid;	 /* process id of requesting process */
+	struct pid		*pid;	 /* process id of requesting process */
 	int			status;	 /* completion status of operation */
 	struct sembuf		*sops;	 /* array of pending operations */
 	struct sembuf		*blocking; /* the operation that blocked */
@@ -628,7 +628,8 @@ SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, semflg)
  */
 static int perform_atomic_semop_slow(struct sem_array *sma, struct sem_queue *q)
 {
-	int result, sem_op, nsops, pid;
+	int result, sem_op, nsops;
+	struct pid *pid;
 	struct sembuf *sop;
 	struct sem *curr;
 	struct sembuf *sops;
@@ -666,7 +667,7 @@ static int perform_atomic_semop_slow(struct sem_array *sma, struct sem_queue *q)
 	sop--;
 	pid = q->pid;
 	while (sop >= sops) {
-		sma->sems[sop->sem_num].sempid = pid;
+		ipc_update_pid(&sma->sems[sop->sem_num].sempid, pid);
 		sop--;
 	}
 
@@ -753,7 +754,7 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 			un->semadj[sop->sem_num] = undo;
 		}
 		curr->semval += sem_op;
-		curr->sempid = q->pid;
+		ipc_update_pid(&curr->sempid, q->pid);
 	}
 
 	return 0;
@@ -1160,6 +1161,7 @@ static void freeary(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 			unlink_queue(sma, q);
 			wake_up_sem_queue_prepare(q, -EIDRM, &wake_q);
 		}
+		ipc_update_pid(&sem->sempid, NULL);
 	}
 
 	/* Remove the semaphore set from the IDR */
@@ -1352,7 +1354,7 @@ static int semctl_setval(struct ipc_namespace *ns, int semid, int semnum,
 		un->semadj[semnum] = 0;
 
 	curr->semval = val;
-	curr->sempid = task_tgid_vnr(current);
+	ipc_update_pid(&curr->sempid, task_tgid(current));
 	sma->sem_ctime = ktime_get_real_seconds();
 	/* maybe some queued-up processes were waiting for this */
 	do_smart_update(sma, NULL, 0, 0, &wake_q);
@@ -1473,7 +1475,7 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
 
 		for (i = 0; i < nsems; i++) {
 			sma->sems[i].semval = sem_io[i];
-			sma->sems[i].sempid = task_tgid_vnr(current);
+			ipc_update_pid(&sma->sems[i].sempid, task_tgid(current));
 		}
 
 		ipc_assert_locked_object(&sma->sem_perm);
@@ -1505,7 +1507,7 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
 		err = curr->semval;
 		goto out_unlock;
 	case GETPID:
-		err = curr->sempid;
+		err = pid_vnr(curr->sempid);
 		goto out_unlock;
 	case GETNCNT:
 		err = count_semcnt(sma, semnum, 0);
@@ -2024,7 +2026,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	queue.sops = sops;
 	queue.nsops = nsops;
 	queue.undo = un;
-	queue.pid = task_tgid_vnr(current);
+	queue.pid = task_tgid(current);
 	queue.alter = alter;
 	queue.dupsop = dupsop;
 
@@ -2318,7 +2320,7 @@ void exit_sem(struct task_struct *tsk)
 					semaphore->semval = 0;
 				if (semaphore->semval > SEMVMX)
 					semaphore->semval = SEMVMX;
-				semaphore->sempid = task_tgid_vnr(current);
+				ipc_update_pid(&semaphore->sempid, task_tgid(current));
 			}
 		}
 		/* maybe some queued-up processes were waiting for this */
-- 
2.14.1

