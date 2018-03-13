Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-14183-1520981442-2-10764052610461201263
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
    t=1520981441; b=tMjTh1vWyw3IoGuQeqO/UFKZM0Fj8ErePhZ9J54B+6Lv44p
    hoSziJwxfFAAWJ7hsNWVtDhvY5q3gA71N5B3ykimYCHaqRx0TGxxI10KoEAgaEDL
    68Z8BqGdGTGoXRs+pNgcIH6BCNEIN2LlC+bIvxMgtXuO/gmK8PmsPu5BbB+E4nej
    YI1P7DyHWbJyI+6Exlrb26N5d5X+XhChoP12vnz1wVUlHjCpjFn12msK5v0Xm/ie
    spBD26smBep3tvT6xqJtvmA0NxT3rEeFN3M5SN8S96gnr/7Kk2vGi8LyQcafCkGE
    nCGmiKQBkEQqQJCSnZbn6lI9WlBpoDS5a2j8Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520981441; bh=R4k4egAqTwC8CdwTR9zyerp5KPvTYYdOwplToeTsDQU=; b=r
    TEkW8SVlgEttIXJe1aALd/noaSFcakz9KlR0s5Kf1GKEF4jg2nbnZj8VK857QH3v
    STCt7lFgJp2HwARTCF8VHAiFkfhrJGREiNQEppHyYWkkG1OJ4zc+CA0U8LdLGIvQ
    NVOSI0VVpA0twg/MwN4PvlkVS9sH8HMz3O4p/GtW66H3N156JKGSfbQw0EdRMnLi
    6Slw8vePIQBqMZEyEnpeZU0T2DmCR6XU6kGY2VXYKgTy4X7W0sFilrQT1M0VgZVj
    pEERwKJWeXN4ZRBDbx+CGhF3VUVLLJeZf5hInJgyAdG3bOOVefWFXJcKSboa9h31
    qNVisFHO76dH2XLi+2eZw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=koLWchFm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=koLWchFm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbeCMWu2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 18:50:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55334 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbeCMWu1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 18:50:27 -0400
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
 <69f13674-7f84-5dc7-0bd7-e5e65e9cb3b0@oracle.com>
 <CAG48ez3v5rTSUg4VDTYknuOBHnv+FF9=ghZJAsknCXREU+juOg@mail.gmail.com>
 <1a8cac8b-22cc-e194-4244-b20428c8a9c2@oracle.com>
 <CAG48ez05MDH7Wf1_j3qgbrqjEh-GXPLQHfx-Va_pyzvT5hP=gw@mail.gmail.com>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <df6ad381-db14-3ded-c724-a80565b549b2@oracle.com>
Date: Tue, 13 Mar 2018 15:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAG48ez05MDH7Wf1_j3qgbrqjEh-GXPLQHfx-Va_pyzvT5hP=gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130251
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/13/2018 03:00 PM, Jann Horn wrote:
> On Tue, Mar 13, 2018 at 2:44 PM, Nagarathnam Muthusamy
> <nagarathnam.muthusamy@oracle.com> wrote:
>>
>> On 03/13/2018 02:28 PM, Jann Horn wrote:
>>> On Tue, Mar 13, 2018 at 2:20 PM, Nagarathnam Muthusamy
>>> <nagarathnam.muthusamy@oracle.com> wrote:
>>>> On 03/13/2018 01:47 PM, Jann Horn wrote:
>>>>> On Mon, Mar 12, 2018 at 10:18 AM,  <nagarathnam.muthusamy@oracle.com>
>>>>> wrote:
>>>>>> Resending the RFC with participants of previous discussions
>>>>>> in the list.
>>>>>>
>>>>>> Following patch which is a variation of a solution discussed
>>>>>> in https://lwn.net/Articles/736330/ provides the users of
>>>>>> pid namespace, the functionality of pid translation between
>>>>>> namespaces using a namespace identifier. The topic of
>>>>>> pid translation has been discussed in the community few times
>>>>>> but there has always been a resistance to adding new solution
>>>>>> for this problem.
>>>>>> I will outline the planned usecase of pid namespace by oracle
>>>>>> database and explain why any of the existing solution cannot
>>>>>> be used to solve their problem.
>>>>>>
>>>>>> Consider a system in which several PID namespaces with multiple
>>>>>> nested levels exists in parallel with monitor processes managing
>>>>>> all the namespaces. PID translation is required for controlling
>>>>>> and accessing information about the processes by the monitors
>>>>>> and other processes down the hierarchy of namespaces. Controlling
>>>>>> primarily involves sending signals or using ptrace by a process in
>>>>>> parent namespace on any of the processes in its child namespace.
>>>>>> Accessing information deals with the reading /proc/<pid>/* files
>>>>>> of processes in child namespace. None of the processes have
>>>>>> root/CAP_SYS_ADMIN privileges.
>>>>> How are you dealing with PID reuse?
>>>>
>>>> We have a monitor process which keeps track of the aliveness of
>>>> important processes. When a process dies, monitor makes a note of
>>>> it and hence detects if pid is reused.
>>> How do you do that in a race-free manner?
>>
>> AFAIK, the monitor runs periodically to check the aliveness of the processes
>> and this period is too short for pids to recycle. I will get back with more
>> information
>> on this if any other mechanisms are in place.
>>
>>
>>>
>>>>>> + */
>>>>>> +SYSCALL_DEFINE3(translate_pid, pid_t, pid, u64, source,
>>>>>> +               u64, target)
>>>>>> +{
>>>>>> +       struct pid_namespace *source_ns = NULL, *target_ns = NULL;
>>>>>> +       struct pid *struct_pid;
>>>>>> +       struct pid_namespace *ph;
>>>>>> +       struct hlist_bl_head *shead = NULL;
>>>>>> +       struct hlist_bl_head *thead = NULL;
>>>>>> +       struct hlist_bl_node *dup_node;
>>>>>> +       pid_t result;
>>>>>> +
>>>>>> +       if (!source) {
>>>>>> +               source_ns = &init_pid_ns;
>>>>>> +       } else {
>>>>>> +               shead = pid_ns_hash_head(pid_ns_hash, source);
>>>>>> +               hlist_bl_lock(shead);
>>>>>> +               hlist_bl_for_each_entry(ph, dup_node, shead, node) {
>>>>>> +                       if (source == ph->ns.ns_id) {
>>>>>> +                               source_ns = ph;
>>>>>> +                               break;
>>>>>> +                       }
>>>>>> +               }
>>>>>> +               if (!source_ns) {
>>>>>> +                       hlist_bl_unlock(shead);
>>>>>> +                       return -EINVAL;
>>>>>> +               }
>>>>>> +       }
>>>>>> +       if (!ptrace_may_access(source_ns->child_reaper,
>>>>>> +                              PTRACE_MODE_READ_FSCREDS)) {
>>>>> AFAICS this proposal breaks the visibility restrictions that
>>>>> namespaces normally create. If there are two namespaces-based
>>>>> containers that use the same UID range, I don't think they should be
>>>>> able to learn information about each other, such as which PIDs are in
>>>>> use in the other container; but as far as I can tell, your proposal
>>>>> makes it possible to do that (unless an LSM or so is interfering). I
>>>>> would prefer it if this API required visibility of the targeted PID
>>>>> namespaces in the caller's PID namespace.
>>>>
>>>> I am trying to simulate the same access restrictions allowed
>>>> on a process's /proc/<pid>/ns/pid file. If the translator has
>>>> access to /proc/<pid>/ns/pid file of both source and destination
>>>> namespaces, shouldn't it be allowed to translate the pid between
>>>> them?
>>> But the translator doesn't actually need to have access to those
>>> procfs files, right?
>> I thought it should have access to those procfs files to satisfy the
>> visibility constraint that targeted PID namespaces should be visible
>> in caller's PID namespace and ptrace_may_access checks that
>> constraint.
> If there are two containers that use the same UID range,
> ptrace_may_access() checks from a process in one container on a
> process in another container can pass. Normally, you just can't even
> reach the ptrace_may_access() checks because you can't reference
> processes in another container in any way.

If there is no way to reference the process in another container,
there is no way to get to the /proc/<pid>/ns/pidns_id file which
exports the ID of that container right? So, a translator has to
first guess the container ID then try translate. Even after translation,
unless the translator has proper privileges, I believe it cant do
anything with just the pid right?

>
> By the way, a related concern: The use of global identifiers will
> probably also negatively affect Checkpoint/Restore In Userspace?
Will look into this. Can you point me to the specifics of the
usecase which could be negatively affected?

Thanks,
Nagarathnam.

