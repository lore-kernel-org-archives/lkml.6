Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2180492-1521840124-2-4217351312437513509
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521840123; b=CrAFm+V90Pi1Iz/CWH9+Z58yxI6ZQ7lOmUz7OK6ajL/3CG6
    JxFW6eQ2+iraT9pV7VOyVlWb6IuGN6fx2naBS5M/hAXRqBVL82e0EP7DHrqk4rol
    ZRxZirRxRtCj0CP48Dx25wfowXUc5eCcCZU1Nkox08/BNk8+NevK+GltZNQ8i5Lg
    8lWp4tMXv4qfYYseimBz5maOiDpHYWETVtKW53JLZMLHGGBQM+EEhhlG3Y1BmtUP
    Z664Lm24twN7zIIjaWToRlXdC07o72omjL14akQtjE2BMg6OlNRofTu0sJJQBgEo
    S7cT7xUVxZMcVbPeGDQN3PNRGoK0iTzMHTjbU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521840123; bh=Mmwu6Z1+OUdqt0vrWZfiEIQPYLoaXGl6VFxjlx53DJs=; b=Z
    iXXymg3S28v368thB/aL+REpwdhnnPRhU7zvlW7xBFSLuRbdpUaOLiipNP24C2lT
    Er/F5y9ITqzl4aMBq4USea+2SlFLT6lT92VdVzhGwI8Gts/CEc6b64mObcceK0Oe
    i0quCz9YqH1LVTBN8aknQdhe/OUJILWg52VyCVxqFm4j41/qYUA4lG0MH2pnk+Ec
    ZThAAKi7iSotvg1xjBLq1qmRWCupj0AoUBdhA9kwmWB8aTb36k4VJESdYPlYkUyI
    d6arGjwQ88d3yVPRhbDoQfXL7ZbacsBwb70H9oiq8KE6Yn2ga9Ntuyp8n8Ad618Q
    Wk1QGiw4S9C/WYfPCFHyA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Zj+1E4Th x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Zj+1E4Th x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeCWVWA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 17:22:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48416 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeCWVV7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 17:21:59 -0400
Subject: Re: [REVIEW][PATCH 10/11] ipc/msg: Fix msgctl(..., IPC_STAT, ...)
 between pid namespaces
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-10-ebiederm@xmission.com>
From: NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
Organization: Oracle Corporation
Message-ID: <c3524b20-38a0-4105-6b87-715ef94882b0@oracle.com>
Date: Fri, 23 Mar 2018 14:21:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180323191614.32489-10-ebiederm@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8841 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803230239
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/23/2018 12:16 PM, Eric W. Biederman wrote:
> Today msg_lspid and msg_lrpid are remembered in the pid namespace of
> the creator and the processes that last send or received a sysvipc
> message.  If you have processes in multiple pid namespaces that is
> just wrong.  The process ids reported will not make the least bit of
> sense.
>
> This fix is slightly more susceptible to a performance problem than
> the related fix for System V shared memory.  By definition the pids
> are updated by msgsnd and msgrcv, the fast path of System V message
> queues.  The only concern over the previous implementation is the
> incrementing and decrementing of the pid reference count.  As that is
> the only difference and multiple updates by of the task_tgid by
> threads in the same process have been shown in af_unix sockets to
> create a cache line ping-pong between cpus of the same processor.
>
> In this case I don't expect cache lines holding pid reference counts
> to ping pong between cpus.  As senders and receivers update different
> pids there is a natural separation there.  Further if multiple threads
> of the same process either send or receive messages the pid will be
> updated to the same value and ipc_update_pid will avoid the reference
> count update.
>
> Which means in the common case I expect msg_lspid and msg_lrpid to
> remain constant, and reference counts not to be updated when messages
> are sent.
>
> In rare cases it may be possible to trigger the issue which was
> observed for af_unix sockets, but it will require multiple processes
> with multiple threads to be either sending or receiving messages.  It
> just does not feel likely that anyone would do that in practice.
>
> This change updates msgctl(..., IPC_STAT, ...) to return msg_lspid and
> msg_lrpid in the pid namespace of the process calling stat.
>
> This change also updates cat /proc/sysvipc/msg to return print msg_lspid
> and msg_lrpid in the pid namespace of the process that opened the proc
> file.
>
> Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks!

Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>

> ---
>   ipc/msg.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/ipc/msg.c b/ipc/msg.c
> index af5a963306c4..825ad585a6ff 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -52,8 +52,8 @@ struct msg_queue {
>   	unsigned long q_cbytes;		/* current number of bytes on queue */
>   	unsigned long q_qnum;		/* number of messages in queue */
>   	unsigned long q_qbytes;		/* max number of bytes on queue */
> -	pid_t q_lspid;			/* pid of last msgsnd */
> -	pid_t q_lrpid;			/* last receive pid */
> +	struct pid *q_lspid;		/* pid of last msgsnd */
> +	struct pid *q_lrpid;		/* last receive pid */
>   
>   	struct list_head q_messages;
>   	struct list_head q_receivers;
> @@ -154,7 +154,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
>   	msq->q_ctime = ktime_get_real_seconds();
>   	msq->q_cbytes = msq->q_qnum = 0;
>   	msq->q_qbytes = ns->msg_ctlmnb;
> -	msq->q_lspid = msq->q_lrpid = 0;
> +	msq->q_lspid = msq->q_lrpid = NULL;
>   	INIT_LIST_HEAD(&msq->q_messages);
>   	INIT_LIST_HEAD(&msq->q_receivers);
>   	INIT_LIST_HEAD(&msq->q_senders);
> @@ -267,6 +267,8 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
>   		free_msg(msg);
>   	}
>   	atomic_sub(msq->q_cbytes, &ns->msg_bytes);
> +	ipc_update_pid(&msq->q_lspid, NULL);
> +	ipc_update_pid(&msq->q_lrpid, NULL);
>   	ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
>   }
>   
> @@ -536,8 +538,8 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
>   	p->msg_cbytes = msq->q_cbytes;
>   	p->msg_qnum   = msq->q_qnum;
>   	p->msg_qbytes = msq->q_qbytes;
> -	p->msg_lspid  = msq->q_lspid;
> -	p->msg_lrpid  = msq->q_lrpid;
> +	p->msg_lspid  = pid_vnr(msq->q_lspid);
> +	p->msg_lrpid  = pid_vnr(msq->q_lrpid);
>   
>   	ipc_unlock_object(&msq->q_perm);
>   	rcu_read_unlock();
> @@ -741,7 +743,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
>   				wake_q_add(wake_q, msr->r_tsk);
>   				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
>   			} else {
> -				msq->q_lrpid = task_pid_vnr(msr->r_tsk);
> +				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
>   				msq->q_rtime = get_seconds();
>   
>   				wake_q_add(wake_q, msr->r_tsk);
> @@ -842,7 +844,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>   
>   	}
>   
> -	msq->q_lspid = task_tgid_vnr(current);
> +	ipc_update_pid(&msq->q_lspid, task_tgid(current));
>   	msq->q_stime = get_seconds();
>   
>   	if (!pipelined_send(msq, msg, &wake_q)) {
> @@ -1060,7 +1062,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
>   			list_del(&msg->m_list);
>   			msq->q_qnum--;
>   			msq->q_rtime = get_seconds();
> -			msq->q_lrpid = task_tgid_vnr(current);
> +			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
>   			msq->q_cbytes -= msg->m_ts;
>   			atomic_sub(msg->m_ts, &ns->msg_bytes);
>   			atomic_dec(&ns->msg_hdrs);
> @@ -1202,6 +1204,7 @@ void msg_exit_ns(struct ipc_namespace *ns)
>   #ifdef CONFIG_PROC_FS
>   static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
>   {
> +	struct pid_namespace *pid_ns = ipc_seq_pid_ns(s);
>   	struct user_namespace *user_ns = seq_user_ns(s);
>   	struct kern_ipc_perm *ipcp = it;
>   	struct msg_queue *msq = container_of(ipcp, struct msg_queue, q_perm);
> @@ -1213,8 +1216,8 @@ static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
>   		   msq->q_perm.mode,
>   		   msq->q_cbytes,
>   		   msq->q_qnum,
> -		   msq->q_lspid,
> -		   msq->q_lrpid,
> +		   pid_nr_ns(msq->q_lspid, pid_ns),
> +		   pid_nr_ns(msq->q_lrpid, pid_ns),
>   		   from_kuid_munged(user_ns, msq->q_perm.uid),
>   		   from_kgid_munged(user_ns, msq->q_perm.gid),
>   		   from_kuid_munged(user_ns, msq->q_perm.cuid),

