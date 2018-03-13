Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4133783-1520976554-2-2792102131268659315
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
    t=1520976553; b=E/b4t8isKzxfe+XSpeoLBLd8H5wWGIpgscHqt0USG5WPYry
    m19YZwvbNV0XBU4zs44uoB4edoigTRPvkEZKPVJho6Auo4+/IrGUvFH23/EvoL1L
    fNX4aSEYAOQsCcZ8ZjlBWpwbqOvQ3lt2xj3bM19PtGiXDtXlaiOaYMe9PFSxTaPc
    BlYRWK14z0x5oNfnxJ++pKJ+yCgsPR5llFi9PQI9wSNxst2NiL4NbJ2WC1sCX8Gf
    sA1yljcrXK5XPdtISdn34QmYKlEgsqVMOeaFoTrurUpTz8isScnZI29Mwghcu7er
    zyYPVa1+7tJThsCXrZR20zVvPenU9Y/pfbuoURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520976553; bh=nXwhUN9PnSYLPu3z+hZzgPjcOjfbSV/Y74NWsJ
    Weyes=; b=Jw4gg8PqS2DAAHE/rCEsyy0GS0BsdlBeTEspm2U7Xpg7macCQD5yY+
    HNLtjtMjZfxJ3fCH3Ep+ISh6zHJaVM/O8f4aSlZbMLhy0wyG0dzlnHJUrMcuNG+V
    5dH3AuL0hcuzR1bZIwrFdEp5Z0LXW7sS2BKh//IniqbnWtRNHTPJWcg0krjE3Ftp
    48znIUIHzryMiHvuJ9J3gwT9YbOc/7R/3vhjEUFqRm0bJtwHbI9hx1HmB77eyex9
    LE8Jeq8S+/x5x++hRYLBdizmWblUF3+2Oo010nn+7I/CgC4sGax7I3mKDDqBgjfX
    ztvYjV9Zww4JFF8BwLIy02cpQNfAWCVg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=HTRR25Da x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PRy+v3k2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=HTRR25Da x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PRy+v3k2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeCMV27 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 17:28:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39287 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbeCMV25 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 17:28:57 -0400
X-Google-Smtp-Source: AG47ELsfiKAOWhkUDoEbt6RoFaTzMg4+1zAKmJf+x7l2I5GOe9CFEqAfJ8c8AC+5VzO2lrSaOsjZ3N8lBZ+CxJxq91M=
MIME-Version: 1.0
In-Reply-To: <69f13674-7f84-5dc7-0bd7-e5e65e9cb3b0@oracle.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <CAG48ez1ww-pVQ9R+d+P+smRR3eaEkJ-=9GW-O-QOvH-YZoFG8A@mail.gmail.com> <69f13674-7f84-5dc7-0bd7-e5e65e9cb3b0@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Mar 2018 14:28:35 -0700
Message-ID: <CAG48ez3v5rTSUg4VDTYknuOBHnv+FF9=ghZJAsknCXREU+juOg@mail.gmail.com>
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

On Tue, Mar 13, 2018 at 2:20 PM, Nagarathnam Muthusamy
<nagarathnam.muthusamy@oracle.com> wrote:
> On 03/13/2018 01:47 PM, Jann Horn wrote:
>> On Mon, Mar 12, 2018 at 10:18 AM,  <nagarathnam.muthusamy@oracle.com>
>> wrote:
>>>
>>> Resending the RFC with participants of previous discussions
>>> in the list.
>>>
>>> Following patch which is a variation of a solution discussed
>>> in https://lwn.net/Articles/736330/ provides the users of
>>> pid namespace, the functionality of pid translation between
>>> namespaces using a namespace identifier. The topic of
>>> pid translation has been discussed in the community few times
>>> but there has always been a resistance to adding new solution
>>> for this problem.
>>> I will outline the planned usecase of pid namespace by oracle
>>> database and explain why any of the existing solution cannot
>>> be used to solve their problem.
>>>
>>> Consider a system in which several PID namespaces with multiple
>>> nested levels exists in parallel with monitor processes managing
>>> all the namespaces. PID translation is required for controlling
>>> and accessing information about the processes by the monitors
>>> and other processes down the hierarchy of namespaces. Controlling
>>> primarily involves sending signals or using ptrace by a process in
>>> parent namespace on any of the processes in its child namespace.
>>> Accessing information deals with the reading /proc/<pid>/* files
>>> of processes in child namespace. None of the processes have
>>> root/CAP_SYS_ADMIN privileges.
>>
>> How are you dealing with PID reuse?
>
>
> We have a monitor process which keeps track of the aliveness of
> important processes. When a process dies, monitor makes a note of
> it and hence detects if pid is reused.

How do you do that in a race-free manner?


>>> + */
>>> +SYSCALL_DEFINE3(translate_pid, pid_t, pid, u64, source,
>>> +               u64, target)
>>> +{
>>> +       struct pid_namespace *source_ns = NULL, *target_ns = NULL;
>>> +       struct pid *struct_pid;
>>> +       struct pid_namespace *ph;
>>> +       struct hlist_bl_head *shead = NULL;
>>> +       struct hlist_bl_head *thead = NULL;
>>> +       struct hlist_bl_node *dup_node;
>>> +       pid_t result;
>>> +
>>> +       if (!source) {
>>> +               source_ns = &init_pid_ns;
>>> +       } else {
>>> +               shead = pid_ns_hash_head(pid_ns_hash, source);
>>> +               hlist_bl_lock(shead);
>>> +               hlist_bl_for_each_entry(ph, dup_node, shead, node) {
>>> +                       if (source == ph->ns.ns_id) {
>>> +                               source_ns = ph;
>>> +                               break;
>>> +                       }
>>> +               }
>>> +               if (!source_ns) {
>>> +                       hlist_bl_unlock(shead);
>>> +                       return -EINVAL;
>>> +               }
>>> +       }
>>> +       if (!ptrace_may_access(source_ns->child_reaper,
>>> +                              PTRACE_MODE_READ_FSCREDS)) {
>>
>> AFAICS this proposal breaks the visibility restrictions that
>> namespaces normally create. If there are two namespaces-based
>> containers that use the same UID range, I don't think they should be
>> able to learn information about each other, such as which PIDs are in
>> use in the other container; but as far as I can tell, your proposal
>> makes it possible to do that (unless an LSM or so is interfering). I
>> would prefer it if this API required visibility of the targeted PID
>> namespaces in the caller's PID namespace.
>
>
> I am trying to simulate the same access restrictions allowed
> on a process's /proc/<pid>/ns/pid file. If the translator has
> access to /proc/<pid>/ns/pid file of both source and destination
> namespaces, shouldn't it be allowed to translate the pid between
> them?

But the translator doesn't actually need to have access to those
procfs files, right?
