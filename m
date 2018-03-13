Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-126535-1520982659-2-11392609271886426685
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
    t=1520982658; b=ms5COzriAdu2BXaQaSBw9j+4IUyxrzRGXkX8aKIlv3L6xwW
    mNBEVqMp396N+n+jCLj12CfVJkC52KkEbx8cHh0jRwCwbtfq8DBK5rpegOpwbjw+
    qAAbxC2REhJXsaR+47wHHDrYTY7GRNpfP1FzLeZB/8hQocuZTzO95zEQIS7BR+yW
    hNNDyVUDo2cpO7sPTufPsBmjVIb38HI9qx0n+m3G3XYYepYpSLatqraSlVDF2tM9
    VlTZbqzMf/1KSgeXhCEMqqHskYzhIUdaB5QdN6OqPemVTQtvE0LPlR+1i4ZEEmDL
    /ZMZNt2SBX2Ro9aPAkaE6wfszZegJ976Dgkjpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520982658; bh=wNmvW67XW/Mj+QkR/QRh/CQYPRiafCjBD+n+N0
    LbOEU=; b=u0E0PyfGA7Xf4ZnUw3S9bIbPV1VIZIGSegPDLRRM0S43WE/MuryS2i
    6Ahb4FYyqETuKESuBYrtOiW6VxKnDNyeECQc+1VY/O+IBUGUi/JvCUJfAnHoOdIp
    7XLEn2KOMFFQ5pKNE+MzHm8z9gcIwjHId2p844tFBaBYy9GVVxNSlNmvwa+og45q
    ZLJRK82aTJSa+sT9y0iHScSkSnugoXGOIfhYssk1hYZHNXnjEu0O9smNY7mxPkJ0
    dmeRsRLIXMIFvgVxo3+SJA02Moj/Dnrcq/LofOFbQoPinDtUM+dzVJnhnFmFFzLM
    f07g3Srk4gVc5B5x24k9Tx02/pfTLzZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=fM/6nIJW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ifn+ELT7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=fM/6nIJW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ifn+ELT7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeCMXK4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 19:10:56 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:46460 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932360AbeCMXKz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 19:10:55 -0400
X-Google-Smtp-Source: AG47ELs7+trFql2UzBKRNaZKWkmu5oIQupPxSMrxBdq6hM6WGEEmSbZFhTCIgz+SalvG/fYu2JlOkQHA/MNY820yWWI=
MIME-Version: 1.0
In-Reply-To: <df6ad381-db14-3ded-c724-a80565b549b2@oracle.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <CAG48ez1ww-pVQ9R+d+P+smRR3eaEkJ-=9GW-O-QOvH-YZoFG8A@mail.gmail.com>
 <69f13674-7f84-5dc7-0bd7-e5e65e9cb3b0@oracle.com> <CAG48ez3v5rTSUg4VDTYknuOBHnv+FF9=ghZJAsknCXREU+juOg@mail.gmail.com>
 <1a8cac8b-22cc-e194-4244-b20428c8a9c2@oracle.com> <CAG48ez05MDH7Wf1_j3qgbrqjEh-GXPLQHfx-Va_pyzvT5hP=gw@mail.gmail.com>
 <df6ad381-db14-3ded-c724-a80565b549b2@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Mar 2018 16:10:33 -0700
Message-ID: <CAG48ez0FD747Vth=VQBNeJnFVKRxmd71Xu4atU650t0WxqOuFg@mail.gmail.com>
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

On Tue, Mar 13, 2018 at 3:45 PM, Nagarathnam Muthusamy
<nagarathnam.muthusamy@oracle.com> wrote:
> On 03/13/2018 03:00 PM, Jann Horn wrote:
>> On Tue, Mar 13, 2018 at 2:44 PM, Nagarathnam Muthusamy
>> <nagarathnam.muthusamy@oracle.com> wrote:
>>> On 03/13/2018 02:28 PM, Jann Horn wrote:
>>>> On Tue, Mar 13, 2018 at 2:20 PM, Nagarathnam Muthusamy
>>>> <nagarathnam.muthusamy@oracle.com> wrote:
>>>>> On 03/13/2018 01:47 PM, Jann Horn wrote:
>>>>>> On Mon, Mar 12, 2018 at 10:18 AM,  <nagarathnam.muthusamy@oracle.com>
>>>>>> wrote:
[...]
>>>>>>> + */
>>>>>>> +SYSCALL_DEFINE3(translate_pid, pid_t, pid, u64, source,
>>>>>>> +               u64, target)
>>>>>>> +{
>>>>>>> +       struct pid_namespace *source_ns = NULL, *target_ns = NULL;
>>>>>>> +       struct pid *struct_pid;
>>>>>>> +       struct pid_namespace *ph;
>>>>>>> +       struct hlist_bl_head *shead = NULL;
>>>>>>> +       struct hlist_bl_head *thead = NULL;
>>>>>>> +       struct hlist_bl_node *dup_node;
>>>>>>> +       pid_t result;
>>>>>>> +
>>>>>>> +       if (!source) {
>>>>>>> +               source_ns = &init_pid_ns;
>>>>>>> +       } else {
>>>>>>> +               shead = pid_ns_hash_head(pid_ns_hash, source);
>>>>>>> +               hlist_bl_lock(shead);
>>>>>>> +               hlist_bl_for_each_entry(ph, dup_node, shead, node) {
>>>>>>> +                       if (source == ph->ns.ns_id) {
>>>>>>> +                               source_ns = ph;
>>>>>>> +                               break;
>>>>>>> +                       }
>>>>>>> +               }
>>>>>>> +               if (!source_ns) {
>>>>>>> +                       hlist_bl_unlock(shead);
>>>>>>> +                       return -EINVAL;
>>>>>>> +               }
>>>>>>> +       }
>>>>>>> +       if (!ptrace_may_access(source_ns->child_reaper,
>>>>>>> +                              PTRACE_MODE_READ_FSCREDS)) {
>>>>>>
>>>>>> AFAICS this proposal breaks the visibility restrictions that
>>>>>> namespaces normally create. If there are two namespaces-based
>>>>>> containers that use the same UID range, I don't think they should be
>>>>>> able to learn information about each other, such as which PIDs are in
>>>>>> use in the other container; but as far as I can tell, your proposal
>>>>>> makes it possible to do that (unless an LSM or so is interfering). I
>>>>>> would prefer it if this API required visibility of the targeted PID
>>>>>> namespaces in the caller's PID namespace.
>>>>>
>>>>>
>>>>> I am trying to simulate the same access restrictions allowed
>>>>> on a process's /proc/<pid>/ns/pid file. If the translator has
>>>>> access to /proc/<pid>/ns/pid file of both source and destination
>>>>> namespaces, shouldn't it be allowed to translate the pid between
>>>>> them?
>>>>
>>>> But the translator doesn't actually need to have access to those
>>>> procfs files, right?
>>>
>>> I thought it should have access to those procfs files to satisfy the
>>> visibility constraint that targeted PID namespaces should be visible
>>> in caller's PID namespace and ptrace_may_access checks that
>>> constraint.
>>
>> If there are two containers that use the same UID range,
>> ptrace_may_access() checks from a process in one container on a
>> process in another container can pass. Normally, you just can't even
>> reach the ptrace_may_access() checks because you can't reference
>> processes in another container in any way.
>
>
> If there is no way to reference the process in another container,
> there is no way to get to the /proc/<pid>/ns/pidns_id file which
> exports the ID of that container right? So, a translator has to
> first guess the container ID then try translate. Even after translation,
> unless the translator has proper privileges, I believe it cant do
> anything with just the pid right?

Well, yes to both. You'd have to guess the ID of the container, and
you wouldn't be able to do much with it, apart from finding valid PIDs
and their mapping between namespaces.

>> By the way, a related concern: The use of global identifiers will
>> probably also negatively affect Checkpoint/Restore In Userspace?
>
> Will look into this. Can you point me to the specifics of the
> usecase which could be negatively affected?

AFAICS you won't be able to reliably recreate namespace IDs when a
process is checkpointed and resumed, meaning that checkpoint/resume
won't work on processes that use these namespace IDs.
