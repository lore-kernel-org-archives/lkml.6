Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-9491-1520978437-9-10925651377486838843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520978437; b=CYanJJ/hfuAgPLDQA6VUNr7uMB6H8k3ta1+9IW5px6h9MM/
    /o2veb+2yo/yApgsGnvpUQFKHi9gsy61xC/KQTZtnAaXKaCWmuAQCkG9AGeAScWi
    rX83PB0zUt0xzusgySvOTwLOB+8F/iLKjmcoIoGhQdktna3wRijRkHNVfuJxXZci
    7+UiqyAEhPrWrTcP5MNcNFd2pAYaktlCwxA88JFJvgBMdECLWEfYNkbLlSZhpMEg
    at/yakyKs5g5HNVS2ZPy2ym362nWRb6dvkIjH/wl24eawQpf897Q+qwNJMhJOCh4
    Lx2CneNfxjwHv8ojwCUV4z/RIgRVTcqjbowX9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520978437; bh=SYyq5UZS6ilPNu4bAX8tb29rpQSwviw72EoClB
    fiMEw=; b=CFPZcDTr4Y7HG8l21s2AbGwvOTsCsIR5nGWcNEh+q7+mk/48sxBuxX
    r5kT4hgmWv8wuIu9jOwm9ILAgQ7ybCXxgmfzKpaOvngSp2Y6VRQlJR39dGrxCefV
    ZXo5DPmmUl26ecF2Yz4aObb9WV0fbkTu+xfp229DCtL7fyLt2SLHjklsRF1x1MU6
    AkCtFdY5euHPrnekGxZ6EGy+/xeP7Jt0l056hJuMlJmqLeGep4w+sT3RxV7OmVUb
    QooYG2ixGeHHkKeWRRbK/mB1q1hOu1CFnasvDlaXDLLfqs/C8E65EAxImL008CeY
    CDEFmSjOxQ7+3+0HnfiGfnDTfVIDvEGg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=bqzTwSCm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rG8L4tAg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=bqzTwSCm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rG8L4tAg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeCMWAe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 18:00:34 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:37568 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeCMWAd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 18:00:33 -0400
X-Google-Smtp-Source: AG47ELtjMzl528P51WjvGbX19ooF+fSMYTVGVb+5SXdBZK81nPtdzq/eagD6DpTBJKZPwsraI/3O9Z8T/xOFdyVUdFI=
MIME-Version: 1.0
In-Reply-To: <1a8cac8b-22cc-e194-4244-b20428c8a9c2@oracle.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <CAG48ez1ww-pVQ9R+d+P+smRR3eaEkJ-=9GW-O-QOvH-YZoFG8A@mail.gmail.com>
 <69f13674-7f84-5dc7-0bd7-e5e65e9cb3b0@oracle.com> <CAG48ez3v5rTSUg4VDTYknuOBHnv+FF9=ghZJAsknCXREU+juOg@mail.gmail.com>
 <1a8cac8b-22cc-e194-4244-b20428c8a9c2@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Mar 2018 15:00:11 -0700
Message-ID: <CAG48ez05MDH7Wf1_j3qgbrqjEh-GXPLQHfx-Va_pyzvT5hP=gw@mail.gmail.com>
Subject: Re: [RESEND RFC] translate_pid API
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 2:44 PM, Nagarathnam Muthusamy
<nagarathnam.muthusamy@oracle.com> wrote:
>
>
> On 03/13/2018 02:28 PM, Jann Horn wrote:
>>
>> On Tue, Mar 13, 2018 at 2:20 PM, Nagarathnam Muthusamy
>> <nagarathnam.muthusamy@oracle.com> wrote:
>>>
>>> On 03/13/2018 01:47 PM, Jann Horn wrote:
>>>>
>>>> On Mon, Mar 12, 2018 at 10:18 AM,  <nagarathnam.muthusamy@oracle.com>
>>>> wrote:
>>>>>
>>>>> Resending the RFC with participants of previous discussions
>>>>> in the list.
>>>>>
>>>>> Following patch which is a variation of a solution discussed
>>>>> in https://lwn.net/Articles/736330/ provides the users of
>>>>> pid namespace, the functionality of pid translation between
>>>>> namespaces using a namespace identifier. The topic of
>>>>> pid translation has been discussed in the community few times
>>>>> but there has always been a resistance to adding new solution
>>>>> for this problem.
>>>>> I will outline the planned usecase of pid namespace by oracle
>>>>> database and explain why any of the existing solution cannot
>>>>> be used to solve their problem.
>>>>>
>>>>> Consider a system in which several PID namespaces with multiple
>>>>> nested levels exists in parallel with monitor processes managing
>>>>> all the namespaces. PID translation is required for controlling
>>>>> and accessing information about the processes by the monitors
>>>>> and other processes down the hierarchy of namespaces. Controlling
>>>>> primarily involves sending signals or using ptrace by a process in
>>>>> parent namespace on any of the processes in its child namespace.
>>>>> Accessing information deals with the reading /proc/<pid>/* files
>>>>> of processes in child namespace. None of the processes have
>>>>> root/CAP_SYS_ADMIN privileges.
>>>>
>>>> How are you dealing with PID reuse?
>>>
>>>
>>> We have a monitor process which keeps track of the aliveness of
>>> important processes. When a process dies, monitor makes a note of
>>> it and hence detects if pid is reused.
>>
>> How do you do that in a race-free manner?
>
>
> AFAIK, the monitor runs periodically to check the aliveness of the processes
> and this period is too short for pids to recycle. I will get back with more
> information
> on this if any other mechanisms are in place.
>
>
>>
>>
>>>>> + */
>>>>> +SYSCALL_DEFINE3(translate_pid, pid_t, pid, u64, source,
>>>>> +               u64, target)
>>>>> +{
>>>>> +       struct pid_namespace *source_ns = NULL, *target_ns = NULL;
>>>>> +       struct pid *struct_pid;
>>>>> +       struct pid_namespace *ph;
>>>>> +       struct hlist_bl_head *shead = NULL;
>>>>> +       struct hlist_bl_head *thead = NULL;
>>>>> +       struct hlist_bl_node *dup_node;
>>>>> +       pid_t result;
>>>>> +
>>>>> +       if (!source) {
>>>>> +               source_ns = &init_pid_ns;
>>>>> +       } else {
>>>>> +               shead = pid_ns_hash_head(pid_ns_hash, source);
>>>>> +               hlist_bl_lock(shead);
>>>>> +               hlist_bl_for_each_entry(ph, dup_node, shead, node) {
>>>>> +                       if (source == ph->ns.ns_id) {
>>>>> +                               source_ns = ph;
>>>>> +                               break;
>>>>> +                       }
>>>>> +               }
>>>>> +               if (!source_ns) {
>>>>> +                       hlist_bl_unlock(shead);
>>>>> +                       return -EINVAL;
>>>>> +               }
>>>>> +       }
>>>>> +       if (!ptrace_may_access(source_ns->child_reaper,
>>>>> +                              PTRACE_MODE_READ_FSCREDS)) {
>>>>
>>>> AFAICS this proposal breaks the visibility restrictions that
>>>> namespaces normally create. If there are two namespaces-based
>>>> containers that use the same UID range, I don't think they should be
>>>> able to learn information about each other, such as which PIDs are in
>>>> use in the other container; but as far as I can tell, your proposal
>>>> makes it possible to do that (unless an LSM or so is interfering). I
>>>> would prefer it if this API required visibility of the targeted PID
>>>> namespaces in the caller's PID namespace.
>>>
>>>
>>> I am trying to simulate the same access restrictions allowed
>>> on a process's /proc/<pid>/ns/pid file. If the translator has
>>> access to /proc/<pid>/ns/pid file of both source and destination
>>> namespaces, shouldn't it be allowed to translate the pid between
>>> them?
>>
>> But the translator doesn't actually need to have access to those
>> procfs files, right?
>
> I thought it should have access to those procfs files to satisfy the
> visibility constraint that targeted PID namespaces should be visible
> in caller's PID namespace and ptrace_may_access checks that
> constraint.

If there are two containers that use the same UID range,
ptrace_may_access() checks from a process in one container on a
process in another container can pass. Normally, you just can't even
reach the ptrace_may_access() checks because you can't reference
processes in another container in any way.

By the way, a related concern: The use of global identifiers will
probably also negatively affect Checkpoint/Restore In Userspace?
