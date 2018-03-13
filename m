Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4106523-1520976315-2-15585675079933580518
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
    t=1520976313; b=HWnjXQlUWa5MmMu+Fg3kvVpmMT7phMHM+9XWnivhap7zcvS
    kMsAKVmN2n5vx8XATr28yn7mKkx3AnNGJWBmPUUnzLcH2/PsO+uxLZ46qRWmF8YJ
    mHFdWBoNpr4j3BAYKUfWGyOiFe33MxOnMXY/cExRxx8GAQi+MlFjYGEjlTFiss0C
    uYzzmQWeQWoSF002zbHzkcUMDcpprkSveemPJATG2bAk2ZCViali9nLOHH71BCOp
    N4/Rna2p+G0Bxppk9zR05/GgTE5saAnhyzHxmdnOzO6hYecYr1A4TEsGSylcyme1
    KtF282EMgJTYlU8sVk8uniXByxGbMlzQrcCDDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520976313; bh=9B6xJwGEAdAPIKsiwr2qphPL2k9uh+YKprA+Gns966g=; b=D
    NoyekT8oISNREhFrXcA5Rvqh7UPcLesRoZYE+Q0ykvztsc5/HBGGONIOU2onkpa8
    GkxsDr21zecg2SnJvamKKnpvTL9SC2zinwFk/AVg8UrrSEFb2qO9FjdHuU2R9Ruj
    XuYM8IFc6FwCzywdLk51OV/X8m10wxkEz0iSDOuWYhBQKWIXxGbcx58nOf5ZDnR8
    BDkmCESfKQeoFQVjfGJa6cbRzud5wHk4GP+8vyHh8kTR/HraEJw3xMSFzuPpkzMs
    EgHjMUwHYM60TTwtyuhprkhfruSj9xZjHdIhCKdSP/xLd8lOLHSrb5seIiX1xCoL
    m0Qgu6ah6K3EFvBAmGwSQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=qMc09WBH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=qMc09WBH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCMVZL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 17:25:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56318 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCMVZK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 17:25:10 -0400
Subject: Re: [RESEND RFC] translate_pid API
To: Jann Horn <jannh@google.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Nagarajan.Muthukrishnan@oracle.com,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, xemul@parallels.com
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <CAG48ez1ww-pVQ9R+d+P+smRR3eaEkJ-=9GW-O-QOvH-YZoFG8A@mail.gmail.com>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <69f13674-7f84-5dc7-0bd7-e5e65e9cb3b0@oracle.com>
Date: Tue, 13 Mar 2018 14:20:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAG48ez1ww-pVQ9R+d+P+smRR3eaEkJ-=9GW-O-QOvH-YZoFG8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130238
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/13/2018 01:47 PM, Jann Horn wrote:
> On Mon, Mar 12, 2018 at 10:18 AM,  <nagarathnam.muthusamy@oracle.com> wrote:
>> Resending the RFC with participants of previous discussions
>> in the list.
>>
>> Following patch which is a variation of a solution discussed
>> in https://lwn.net/Articles/736330/ provides the users of
>> pid namespace, the functionality of pid translation between
>> namespaces using a namespace identifier. The topic of
>> pid translation has been discussed in the community few times
>> but there has always been a resistance to adding new solution
>> for this problem.
>> I will outline the planned usecase of pid namespace by oracle
>> database and explain why any of the existing solution cannot
>> be used to solve their problem.
>>
>> Consider a system in which several PID namespaces with multiple
>> nested levels exists in parallel with monitor processes managing
>> all the namespaces. PID translation is required for controlling
>> and accessing information about the processes by the monitors
>> and other processes down the hierarchy of namespaces. Controlling
>> primarily involves sending signals or using ptrace by a process in
>> parent namespace on any of the processes in its child namespace.
>> Accessing information deals with the reading /proc/<pid>/* files
>> of processes in child namespace. None of the processes have
>> root/CAP_SYS_ADMIN privileges.
> How are you dealing with PID reuse?

We have a monitor process which keeps track of the aliveness of
important processes. When a process dies, monitor makes a note of
it and hence detects if pid is reused.

>
> [...]
>> diff --git a/fs/nsfs.c b/fs/nsfs.c
>> index 36b0772..c635465 100644
>> --- a/fs/nsfs.c
>> +++ b/fs/nsfs.c
>> @@ -222,8 +222,13 @@ int ns_get_name(char *buf, size_t size, struct task_struct *task,
>>          const char *name;
>>          ns = ns_ops->get(task);
>>          if (ns) {
>> -               name = ns_ops->real_ns_name ? : ns_ops->name;
>> -               res = snprintf(buf, size, "%s:[%u]", name, ns->inum);
>> +               if (!strcmp(ns_ops->name, "pidns_id")) {
> Wouldn't it be cleaner to check for "ns_ops==&pidns_id_operations"?

Yup. Will fix it.

>
>> +                       res = snprintf(buf, size, "[%llu]",
>> +                                      (unsigned long long)ns->ns_id);
>> +               } else {
>> +                       name = ns_ops->real_ns_name ? : ns_ops->name;
>> +                       res = snprintf(buf, size, "%s:[%u]", name, ns->inum);
>> +               }
>>                  ns_ops->put(ns);
>>          }
>>          return res;
> [...]
>> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
>> index 49538b1..11d1d57 100644
>> --- a/include/linux/pid_namespace.h
>> +++ b/include/linux/pid_namespace.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/kref.h>
>>   #include <linux/ns_common.h>
>>   #include <linux/idr.h>
>> +#include <linux/list_bl.h>
>>
>>
>>   struct fs_pin;
>> @@ -44,6 +45,8 @@ struct pid_namespace {
>>          kgid_t pid_gid;
>>          int hide_pid;
>>          int reboot;     /* group exit code if this pidns was rebooted */
>> +       struct hlist_bl_node node;
>> +       atomic_t lookups_pending;
>>          struct ns_common ns;
>>   } __randomize_layout;
>>
> [...]
>> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
>> index 0b53eef..ff83aa8 100644
>> --- a/kernel/pid_namespace.c
>> +++ b/kernel/pid_namespace.c
> [...]
>> @@ -159,6 +201,30 @@ static void delayed_free_pidns(struct rcu_head *p)
>>
>>   static void destroy_pid_namespace(struct pid_namespace *ns)
>>   {
>> +       struct pid_namespace *ph;
>> +       struct hlist_bl_head *head;
>> +       struct hlist_bl_node *dup_node;
>> +
>> +       /*
>> +        * Remove the namespace structure from hash table so
>> +        * now new lookups can start on it.
> s/now new/no new/

Will fix it.

>
> [...]
>> @@ -474,9 +551,116 @@ static struct user_namespace *pidns_owner(struct ns_common *ns)
>>          .get_parent     = pidns_get_parent,
>>   };
>>
>> +/*
>> + * translate_pid - convert pid in source pid-ns into target pid-ns.
>> + * @pid: pid for translation
>> + * @source: pid-ns id
>> + * @target: pid-ns id
>> + *
>> + * Return pid in @target pid-ns, zero if task have no pid there,
>> + * or -ESRCH of task with @pid is not found in @source pid-ns.
> s/of/if/

Will fix it.

>
>> + */
>> +SYSCALL_DEFINE3(translate_pid, pid_t, pid, u64, source,
>> +               u64, target)
>> +{
>> +       struct pid_namespace *source_ns = NULL, *target_ns = NULL;
>> +       struct pid *struct_pid;
>> +       struct pid_namespace *ph;
>> +       struct hlist_bl_head *shead = NULL;
>> +       struct hlist_bl_head *thead = NULL;
>> +       struct hlist_bl_node *dup_node;
>> +       pid_t result;
>> +
>> +       if (!source) {
>> +               source_ns = &init_pid_ns;
>> +       } else {
>> +               shead = pid_ns_hash_head(pid_ns_hash, source);
>> +               hlist_bl_lock(shead);
>> +               hlist_bl_for_each_entry(ph, dup_node, shead, node) {
>> +                       if (source == ph->ns.ns_id) {
>> +                               source_ns = ph;
>> +                               break;
>> +                       }
>> +               }
>> +               if (!source_ns) {
>> +                       hlist_bl_unlock(shead);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +       if (!ptrace_may_access(source_ns->child_reaper,
>> +                              PTRACE_MODE_READ_FSCREDS)) {
> AFAICS this proposal breaks the visibility restrictions that
> namespaces normally create. If there are two namespaces-based
> containers that use the same UID range, I don't think they should be
> able to learn information about each other, such as which PIDs are in
> use in the other container; but as far as I can tell, your proposal
> makes it possible to do that (unless an LSM or so is interfering). I
> would prefer it if this API required visibility of the targeted PID
> namespaces in the caller's PID namespace.

I am trying to simulate the same access restrictions allowed
on a process's /proc/<pid>/ns/pid file. If the translator has
access to /proc/<pid>/ns/pid file of both source and destination
namespaces, shouldn't it be allowed to translate the pid between
them?

>
> When doing ptrace access checks, please use the real creds in syscalls
> like this one, not the fs creds. The fs creds are for filesystem
> syscalls (in particular sys_open()), not for specialized syscalls like
> ptrace() or this one.
Will fix this.

Thanks,
Nagarathnam.
