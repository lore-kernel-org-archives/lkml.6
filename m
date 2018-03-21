Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2726072-1521592504-2-12467291347302167255
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521592503; b=n/XYFXs7B+oWNgWYgNSmBKxZAOnnKZdVJXRydutDXUUfUrz
    SYkTESJkXx+RyvvHTGAKikZxkcDNldDgi1/bD4IIm+X/bLJDnz5idNHshLT0Yofc
    ZazQTxb4N8zLJS8lVwqVD0Hoe+HEf2AptWaX1D+UdKfVxbxGiWV8BpDPoslq5ftE
    ZG61aZvseBarfn9puGBO7URHikcTus1pGcjEYYnU/jBMNzzFSov+Y1gQ8IFuIlHf
    pglbOZVaAlRI7rPiX/LBwau07Vz0ZxGOcsldIVFCO+KW/NKyl+T5Y7AmtKcrrYdJ
    2w1UQUlDKHUQxNDgzm5qbQI1hV5McOKeZcL0BKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:content-transfer-encoding
    :subject:sender:list-id; s=arctest; t=1521592503; bh=a+0OWQAprFN
    bcCGjKmA9PjtsLFxDFmJ/vlMC7mRLWRU=; b=NofLtBaP4Wln2QQyju7IAq4rV3a
    K6J28nkLOuanYK46tKF7UEnQtndrApHUKqtFLL/5h92SllWYvWbHjnzEaSt3vQaF
    5mLFNAWtX5TAiuj90zh/cwJTbN5TDCdqXdOegpsaSDhyhhDOdG323i77U9kFUwYb
    8Mo3PGY3Vr57bnt9reukyRQTR9HB2tsV9ErzAB43oANYN7VrvHf7n0ibbRRAaAId
    Ol2nJdwQ/AavuJ2sUMdOYqMYwEp84N0GXssrX4CjxotHA/Ot/RN4TCsseXYeKIBx
    FYP1UlwIPjiZpHt3MDPnI55WWnEVvktwtw7gt9CjGFEinwBxbUyhG4mKACg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1751343AbeCUAfB convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 20 Mar 2018 20:35:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41572 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCUAfA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Mar 2018 20:35:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
        <87vadzqqq6.fsf@xmission.com>
        <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
        <877eqejowd.fsf@xmission.com>
        <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
Date: Tue, 20 Mar 2018 19:33:49 -0500
In-Reply-To: <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com> (Nagarathnam
        Muthusamy's message of "Tue, 20 Mar 2018 13:14:14 -0700")
Message-ID: <87a7v2z2qa.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1eyRiE-0003TP-V2;;;mid=<87a7v2z2qa.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jxacNaOoGKMgtAnKes40pceJBsEZP5f0=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,XMSolicitRefs_0
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15028 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (0.0%), b_tie_ro: 3.5 (0.0%), parse: 0.90 (0.0%),
        extract_message_metadata: 14 (0.1%), get_uri_detail_list: 3.3 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
        0.98 (0.0%), tests_pri_-400: 35 (0.2%), check_bayes: 34 (0.2%), b_tokenize:
        14 (0.1%), b_tok_get_all: 12 (0.1%), b_comp_prob: 3.0 (0.0%),
        b_tok_touch_all: 2.9 (0.0%), b_finish: 0.54 (0.0%), tests_pri_0: 319 (2.1%),
        check_dkim_signature: 0.66 (0.0%), check_dkim_adsp: 3.1 (0.0%),
        tests_pri_500: 14647 (97.5%), poll_dns_idle: 14638 (97.4%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RESEND RFC] translate_pid API
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:

> (Resending the reply as there was a reject due to HTML in email)
>
> On 03/14/2018 03:03 PM, ebiederm@xmission.com wrote:
>> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>>
>>> On 03/13/2018 08:29 PM, ebiederm@xmission.com wrote:
>>>> The cost of that ``cheaper'' u64 that is not in any namespace is that
>>>> you now have to go and implement a namespace of namespaces.  You haven't
>>>> even attempted it.  So just no.    Anything that brings us to needing
>>>> a namespace of namespaces is a bad design.
>>> I am not trying to implement a namespace of namespaces.
>> No you are using a design that will require a namespace of namespaces
>> to be implemented to support CRIU (checkpoint/restart in userspace).
>>
>> So when I see your patch I see a patch that only implements the easy
>> half of the work that needs to be done.
>>
>>>>> Following patch uses a 64-bit ID for namespace exported by procfs
>>>>> for pid translation through a new file /proc/<pid>/ns/pidns_id.
>>>> And this design detail is what brings the automatic nack.
>>>>
>>>> Use file descriptros and it sounds like your use case justifies what you
>>>> are trying to do.
>>> File descriptors are problematic for following reasons.
>>> 1) I need to open a couple of file descriptors for every pid
>>> translation request.
>> You can cache descriptors across requests.  I suspect simply
>> by tracking the origin of the shared memory segment you can figure
>> out it's pid namespace.
>>
>>> 2) In case of nested PID namespaces, say a new pid namespace is
>>> created at level 20,
>>>      with unique ID, I could just record this ID in a shared memory for
>>> interested process
>>>      to use. In case of file descriptors, every level has to figure out
>>> the process ID of the
>>>      newly created namespace's init process and open a file descriptor
>>> to track it.
>> Toss in a bind mount of the file in some filesystem if that helps.
>>
>> But if I understand what you are talking about you are talking about
>> having a shared memory segment shared between processes in different
>> pid namespaces.
>>
>> In that shared memory segment for a processes in different namespaces
>> you are talking about having the conversation structured as having
>> information structured as pid-namespace pid.
>>
>> And crucuially you want anyone in any pid namespace to be able to read
>> that shared memory segment and to make sense of what is going on,
>> by just reading the pid namespace id.
>
> This captures the usecase. Adding to that, every level is made up of
> a combination of User, pid and mount namespace.

You must be using sysvipc shared memory segments not posix shared memory
segments if you are sharing them in that scenario.

>> Namespaces are all about making identifiers relative to their namespace.
>>
>> The only way I can see you gain an advantage with your shared memory
>> design is by making identifiers that are not relative to their pid
>> namespace.   As such identifiers will completely defeat the ability
>> to implement CRIU support.
>>
>> The closest I have to such identifiers today are bind mounts of the
>> namespace files.  So if you also have a common mount namespace you could
>> use that.
>
> We don't have common mount namespace. Each nested level will have
> a new mount namespace. When a new nested level (User + pid + mnt) is
> created, init process of new level cannot bind mount the namespace directory,
> as the effects wont be visible to the other levels.

Do you have a ipc shared memory segment.

I just looked and realized there is a rather significant bug in ipc
shared memory segments when shared between pid namespaces, and I believe
fixing that bug will resolve your issue.

shmctl(IPC_STAT, ...) will return a struct shmid_ds.
The struct shmid_ds has a field shm_cpid.

That field is currently reported as the pid in the pid namespace that
created the segment.  Which is nonsense if you are not in the pid
namespace.

However if we were to fix that to properly return the pid in the
pid namespace of the caller of IPC_STAT.  You could find the
pid of the creator of the ipc shared memory segment by just
calling shmctl(IPC_STAT, ...).

> On other hand, the new init process could send SCM_CREDENTIALS message
> to a centralized listener running outside of the whole setup which does only
> bind mounts. Here, we have a single point of failure for the whole system and
> this listener has to run as root to be able to do bind mounts. Apart from these,
> I am not able to see the bind mount by listener being propagated to child
> namespaces in my setup. Not sure if I am missing anything or this is the
> expected behavior.

It depends on how mount propgation is configured.  You can configure
mount propgation so that these bind mounts propagate to every mount
namespace.  Which would definitely be a possible solution.

> Is it possible to have application provide the ID to be associated with
> the namespace? During dump, we can save the ID and during restore,
> we can assign the ID using the same API. There is a possibility of
> collision during restore. Is it ok to fail the restore during such
> scenario?

No. It is absolutely not ok to fail the restore during such a scenario.
For CRIU that is the entire point of having namespaces.  Not having
to worry about an id not being available during restore.

Eric
