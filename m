Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832726-2-13312368041467545165
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
    t=1521832725; b=d4yEZH3OuW7cukqN0nEVoYiJdHOtiQtpzY8p30oIuc4ETsV
    7TcGRWrt+ual3v1ZKiiIaLNsmNc1t/jpST6AiSFZf+JQCwk5vZ2WqLv68n62KnXf
    M/dl5K49s42TDn5jB+xgvBJ0S2INWQlRWB01phx2+WIzBukE77Rd9ITFcXldLrRD
    JzXoB1SO9RBd5bCq5Rds12MowMjXDvHxlJzM8iRCpQ3KLh5SPn1QwpUheUMHf31f
    aID1JxRtZf+PXR4cB2iL7cU9kNNdUi140NIRLo/Ph2GLI2msfJLB6uyX/I6F7wK0
    LN23rfnX8yiQPfF19jSopnZ9vgGVq9rBnopeGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832725; bh=
    5PxKkfcH0+xbL21hoF8+R0pxZ/SYchXI+6hChVuECtM=; b=eFK2oTfdGFy7x2vT
    swV0/MsM0211gA3MvEztt4KM6bglGtUKvVQbxYm2D/c+PqlMIqUKGyf2f1kT4NeK
    8GbqgYSHKMHHReYYZnJZKM05avv3BTzZ/WkWNlNsCm6M82R2ReUv6cynaAzOzvt4
    x+x9+lp45+DOqP5mL78DLDdLP1vKQuTdg3qPR5C/wWnF8wvC2jWHj8Tyw+/cKqp+
    Kr4O2aFGso4BB0DfAKIXBBIYXZwGEP9/DQCCFcmYlme65/o3i0j7uv5gdT+S/uat
    wh+VC/PLl5X0kMrtrm9IXWaIqtvFZMdbicnou1NaKg3KxHuntOhEg+mZWdSzq9yQ
    IhnKSg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1752206AbeCWTSb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:18:31 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50688 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeCWTS2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:18:28 -0400
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
Date: Fri, 23 Mar 2018 14:16:13 -0500
Message-Id: <20180323191614.32489-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCe-00033I-Um;;;mid=<20180323191614.32489-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188cbNSCC2nSs018HyuvWCZnmzUc3rUE0Y=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa04.xmission.com
X-Remote-Spam-Level: ****
X-Remote-Spam-Status: No, score=4.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_Symld_Words,TVD_RCVD_IP,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        T_TooManySym_04,T_TooManySym_05,XMNoVowels,XMSolicitRefs_0,XMSubLong
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ****;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 10346 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 4.4 (0.0%), b_tie_ro: 3.3 (0.0%), parse: 1.21 (0.0%),
        extract_message_metadata: 15 (0.1%), get_uri_detail_list: 3.7 (0.0%),
        tests_pri_-1000: 6 (0.1%), tests_pri_-950: 1.48 (0.0%), tests_pri_-900: 1.24
        (0.0%), tests_pri_-400: 37 (0.4%), check_bayes: 36 (0.3%), b_tokenize: 13
        (0.1%), b_tok_get_all: 13 (0.1%), b_comp_prob: 3.0 (0.0%), b_tok_touch_all:
        4.5 (0.0%), b_finish: 0.62 (0.0%), tests_pri_0: 614 (5.9%),
        check_dkim_signature: 1.25 (0.0%), check_dkim_adsp: 4.9 (0.0%),
        tests_pri_500: 9662 (93.4%), poll_dns_idle: 9652 (93.3%), rewrite_mail: 0.00
        (0.0%)
Subject: [REVIEW][PATCH 10/11] ipc/msg: Fix msgctl(..., IPC_STAT, ...) between pid namespaces
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Today msg_lspid and msg_lrpid are remembered in the pid namespace of
the creator and the processes that last send or received a sysvipc
message.  If you have processes in multiple pid namespaces that is
just wrong.  The process ids reported will not make the least bit of
sense.

This fix is slightly more susceptible to a performance problem than
the related fix for System V shared memory.  By definition the pids
are updated by msgsnd and msgrcv, the fast path of System V message
queues.  The only concern over the previous implementation is the
incrementing and decrementing of the pid reference count.  As that is
the only difference and multiple updates by of the task_tgid by
threads in the same process have been shown in af_unix sockets to
create a cache line ping-pong between cpus of the same processor.

In this case I don't expect cache lines holding pid reference counts
to ping pong between cpus.  As senders and receivers update different
pids there is a natural separation there.  Further if multiple threads
of the same process either send or receive messages the pid will be
updated to the same value and ipc_update_pid will avoid the reference
count update.

Which means in the common case I expect msg_lspid and msg_lrpid to
remain constant, and reference counts not to be updated when messages
are sent.

In rare cases it may be possible to trigger the issue which was
observed for af_unix sockets, but it will require multiple processes
with multiple threads to be either sending or receiving messages.  It
just does not feel likely that anyone would do that in practice.

This change updates msgctl(..., IPC_STAT, ...) to return msg_lspid and
msg_lrpid in the pid namespace of the process calling stat.

This change also updates cat /proc/sysvipc/msg to return print msg_lspid
and msg_lrpid in the pid namespace of the process that opened the proc
file.

Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 ipc/msg.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index af5a963306c4..825ad585a6ff 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -52,8 +52,8 @@ struct msg_queue {
 	unsigned long q_cbytes;		/* current number of bytes on queue */
 	unsigned long q_qnum;		/* number of messages in queue */
 	unsigned long q_qbytes;		/* max number of bytes on queue */
-	pid_t q_lspid;			/* pid of last msgsnd */
-	pid_t q_lrpid;			/* last receive pid */
+	struct pid *q_lspid;		/* pid of last msgsnd */
+	struct pid *q_lrpid;		/* last receive pid */
 
 	struct list_head q_messages;
 	struct list_head q_receivers;
@@ -154,7 +154,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	msq->q_ctime = ktime_get_real_seconds();
 	msq->q_cbytes = msq->q_qnum = 0;
 	msq->q_qbytes = ns->msg_ctlmnb;
-	msq->q_lspid = msq->q_lrpid = 0;
+	msq->q_lspid = msq->q_lrpid = NULL;
 	INIT_LIST_HEAD(&msq->q_messages);
 	INIT_LIST_HEAD(&msq->q_receivers);
 	INIT_LIST_HEAD(&msq->q_senders);
@@ -267,6 +267,8 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 		free_msg(msg);
 	}
 	atomic_sub(msq->q_cbytes, &ns->msg_bytes);
+	ipc_update_pid(&msq->q_lspid, NULL);
+	ipc_update_pid(&msq->q_lrpid, NULL);
 	ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
 }
 
@@ -536,8 +538,8 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	p->msg_cbytes = msq->q_cbytes;
 	p->msg_qnum   = msq->q_qnum;
 	p->msg_qbytes = msq->q_qbytes;
-	p->msg_lspid  = msq->q_lspid;
-	p->msg_lrpid  = msq->q_lrpid;
+	p->msg_lspid  = pid_vnr(msq->q_lspid);
+	p->msg_lrpid  = pid_vnr(msq->q_lrpid);
 
 	ipc_unlock_object(&msq->q_perm);
 	rcu_read_unlock();
@@ -741,7 +743,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 				wake_q_add(wake_q, msr->r_tsk);
 				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
 			} else {
-				msq->q_lrpid = task_pid_vnr(msr->r_tsk);
+				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
 				msq->q_rtime = get_seconds();
 
 				wake_q_add(wake_q, msr->r_tsk);
@@ -842,7 +844,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 
 	}
 
-	msq->q_lspid = task_tgid_vnr(current);
+	ipc_update_pid(&msq->q_lspid, task_tgid(current));
 	msq->q_stime = get_seconds();
 
 	if (!pipelined_send(msq, msg, &wake_q)) {
@@ -1060,7 +1062,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 			list_del(&msg->m_list);
 			msq->q_qnum--;
 			msq->q_rtime = get_seconds();
-			msq->q_lrpid = task_tgid_vnr(current);
+			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts, &ns->msg_bytes);
 			atomic_dec(&ns->msg_hdrs);
@@ -1202,6 +1204,7 @@ void msg_exit_ns(struct ipc_namespace *ns)
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
 {
+	struct pid_namespace *pid_ns = ipc_seq_pid_ns(s);
 	struct user_namespace *user_ns = seq_user_ns(s);
 	struct kern_ipc_perm *ipcp = it;
 	struct msg_queue *msq = container_of(ipcp, struct msg_queue, q_perm);
@@ -1213,8 +1216,8 @@ static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
 		   msq->q_perm.mode,
 		   msq->q_cbytes,
 		   msq->q_qnum,
-		   msq->q_lspid,
-		   msq->q_lrpid,
+		   pid_nr_ns(msq->q_lspid, pid_ns),
+		   pid_nr_ns(msq->q_lrpid, pid_ns),
 		   from_kuid_munged(user_ns, msq->q_perm.uid),
 		   from_kgid_munged(user_ns, msq->q_perm.gid),
 		   from_kuid_munged(user_ns, msq->q_perm.cuid),
-- 
2.14.1

