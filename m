Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2204151-1521839884-2-2406414361786901025
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
    t=1521839883; b=tozRyGi1ztARLAqu7Q+8z8zyf6msONgeQeTtjUJL4/SXy+L
    smC6svUIvUUmslExUSGrAkoL5UfaOh0da5WrbLpjf3q+Sg3RpdvPuKhltWSbUfI8
    KaMzxydcUeR2+JG840PS/1N6Tso52HVoIjsait5QvQPXZopJfmJIoZBols2bEkgo
    +eZderbjWTmzl5eQbxAORR24X/ghNfYCZn6nihDVRyn+y8XrUyY3NAuyBUQY4XMM
    bWfqrOU+LtMqM2yTT8MYVM6F6Hypgioq82tw3UtwF5gb0MCQCOicqq2EPDLXTaZr
    RheiL6n6Ms79l6w3PF+AWUYvAvvGM8WY4WfnHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521839883; bh=lU+/yjzLOmnx6L9bJfAEH1wYFvrUiyw4iBcxAN09Tkk=; b=r
    tUxu5ZzvqhimMG3/FvBfDsj+kpMQnXdGy7OZyQgFM6sJzHIyj7CoxOi4HKTBFHUN
    M5nrxvP9YnAWK57ssDbNlTnFe0+TIQOMc0jZRbK41YVgwCe7qesIZHm2yZRWjR/M
    RDHvvlVrprahJ54qKU2MOILDmBRF74pz5gpXLjudwRl9nGGhSecH1QlusptuCZW1
    6VOK7Y7PzV3RS5UtLLA44Ras2kl/UV+Tz8Nna9Ah5r+n93M0kjk6SLKnajyq9doS
    fBlvCz6YT9gJsjjMUqu2XtKDaM2879Gk7/CLri+7lZybaYn3H9xDK1AoFUdXkEyw
    3QBIZsmMDN6XlbrdGGMTg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=oIkH4NBN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=oIkH4NBN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbeCWVSA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 17:18:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42972 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeCWVR7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 17:17:59 -0400
Subject: Re: [REVIEW][PATCH 09/11] ipc/shm: Fix shmctl(..., IPC_STAT, ...)
 between pid namespaces.
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-9-ebiederm@xmission.com>
From: NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
Organization: Oracle Corporation
Message-ID: <7df62190-2407-bfd4-d144-7304a8ea8ae3@oracle.com>
Date: Fri, 23 Mar 2018 14:17:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180323191614.32489-9-ebiederm@xmission.com>
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
> Today shm_cpid and shm_lpid are remembered in the pid namespace of the
> creator and the processes that last touched a sysvipc shared memory
> segment.   If you have processes in multiple pid namespaces that
> is just wrong, and I don't know how this has been over-looked for
> so long.
>
> As only creation and shared memory attach and shared memory detach
> update the pids I do not expect there to be a repeat of the issues
> when struct pid was attached to each af_unix skb, which in some
> notable cases cut the performance in half.  The problem was threads of
> the same process updating same struct pid from different cpus causing
> the cache line to be highly contended and bounce between cpus.
>
> As creation, attach, and detach are expected to be rare operations for
> sysvipc shared memory segments I do not expect that kind of cache line
> ping pong to cause probems.  In addition because the pid is at a fixed
> location in the structure instead of being dynamic on a skb, the
> reference count of the pid does not need to be updated on each
> operation if the pid is the same.  This ability to simply skip the pid
> reference count changes if the pid is unchanging further reduces the
> likelihood of the a cache line holding a pid reference count
> ping-ponging between cpus.
>
> Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Thanks!

Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>

> ---
>   ipc/shm.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 0565669ebe5c..932b7e411c6c 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -57,8 +57,8 @@ struct shmid_kernel /* private to the kernel */
>   	time64_t		shm_atim;
>   	time64_t		shm_dtim;
>   	time64_t		shm_ctim;
> -	pid_t			shm_cprid;
> -	pid_t			shm_lprid;
> +	struct pid		*shm_cprid;
> +	struct pid		*shm_lprid;
>   	struct user_struct	*mlock_user;
>   
>   	/* The task created the shm object.  NULL if the task is dead. */
> @@ -226,7 +226,7 @@ static int __shm_open(struct vm_area_struct *vma)
>   		return PTR_ERR(shp);
>   
>   	shp->shm_atim = ktime_get_real_seconds();
> -	shp->shm_lprid = task_tgid_vnr(current);
> +	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
>   	shp->shm_nattch++;
>   	shm_unlock(shp);
>   	return 0;
> @@ -267,6 +267,8 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
>   		user_shm_unlock(i_size_read(file_inode(shm_file)),
>   				shp->mlock_user);
>   	fput(shm_file);
> +	ipc_update_pid(&shp->shm_cprid, NULL);
> +	ipc_update_pid(&shp->shm_lprid, NULL);
>   	ipc_rcu_putref(&shp->shm_perm, shm_rcu_free);
>   }
>   
> @@ -311,7 +313,7 @@ static void shm_close(struct vm_area_struct *vma)
>   	if (WARN_ON_ONCE(IS_ERR(shp)))
>   		goto done; /* no-op */
>   
> -	shp->shm_lprid = task_tgid_vnr(current);
> +	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
>   	shp->shm_dtim = ktime_get_real_seconds();
>   	shp->shm_nattch--;
>   	if (shm_may_destroy(ns, shp))
> @@ -614,8 +616,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>   	if (IS_ERR(file))
>   		goto no_file;
>   
> -	shp->shm_cprid = task_tgid_vnr(current);
> -	shp->shm_lprid = 0;
> +	shp->shm_cprid = get_pid(task_tgid(current));
> +	shp->shm_lprid = NULL;
>   	shp->shm_atim = shp->shm_dtim = 0;
>   	shp->shm_ctim = ktime_get_real_seconds();
>   	shp->shm_segsz = size;
> @@ -648,6 +650,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>   		user_shm_unlock(size, shp->mlock_user);
>   	fput(file);
>   no_file:
> +	ipc_update_pid(&shp->shm_cprid, NULL);
> +	ipc_update_pid(&shp->shm_lprid, NULL);
>   	call_rcu(&shp->shm_perm.rcu, shm_rcu_free);
>   	return error;
>   }
> @@ -970,8 +974,8 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
>   	tbuf->shm_atime	= shp->shm_atim;
>   	tbuf->shm_dtime	= shp->shm_dtim;
>   	tbuf->shm_ctime	= shp->shm_ctim;
> -	tbuf->shm_cpid	= shp->shm_cprid;
> -	tbuf->shm_lpid	= shp->shm_lprid;
> +	tbuf->shm_cpid	= pid_vnr(shp->shm_cprid);
> +	tbuf->shm_lpid	= pid_vnr(shp->shm_lprid);
>   	tbuf->shm_nattch = shp->shm_nattch;
>   
>   	ipc_unlock_object(&shp->shm_perm);
> @@ -1605,6 +1609,7 @@ SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
>   #ifdef CONFIG_PROC_FS
>   static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
>   {
> +	struct pid_namespace *pid_ns = ipc_seq_pid_ns(s);
>   	struct user_namespace *user_ns = seq_user_ns(s);
>   	struct kern_ipc_perm *ipcp = it;
>   	struct shmid_kernel *shp;
> @@ -1627,8 +1632,8 @@ static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
>   		   shp->shm_perm.id,
>   		   shp->shm_perm.mode,
>   		   shp->shm_segsz,
> -		   shp->shm_cprid,
> -		   shp->shm_lprid,
> +		   pid_nr_ns(shp->shm_cprid, pid_ns),
> +		   pid_nr_ns(shp->shm_lprid, pid_ns),
>   		   shp->shm_nattch,
>   		   from_kuid_munged(user_ns, shp->shm_perm.uid),
>   		   from_kgid_munged(user_ns, shp->shm_perm.gid),

