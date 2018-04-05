Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2169189-1522912221-2-10623376595687813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ru',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522912220; b=VCCMv/sXyNbV3nQvio8uTLFLzCC5leGR03rOD89crebvq10xZx
    hnqEIHErq8SPb+tyM1YOGXpc8M4LjzvUpFD9KksO9Hc77QACPq1IlbeDvedc5N9G
    QGYjEpdnXddFDpOrB3rbcG0MDdZu5ytn51QUDXI1iM5LXRwMRlCx9SLWNOIcXaeq
    43HWn74arRVM80rrwimaCOcOGrQ21yVTheNnjYHJ16asuK9oIZn1yQnc4yG0i442
    rinmV5EDk72vHzxbJDm4yxBSRQ+e40CgREM1axTMY3Y50+eFqZ4MjBDzRnLXzOQX
    KkA0atOwHYMyuhZ+6tHtck6cJLToNW+RsrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522912220;
    bh=Xh+MwcqRJ5pkMB+V6Qrpf9C+tPSyVMcD9/WZCRwPU4I=; b=rnhIwqAin4QY
    JiSXvk8LF/VxL4AOTvL9XKkhCcqJ4iM9rc0yWveANC6dkdeMGiPjAzW1U7ELFJcO
    QgqPBAn3kTBjMRiBXISrN10oZe5GowGZp1MY3GdVEiRId5dGXcl6w+hJkmuaMwrs
    gNoUkYY5rzO8TuAHYBEqaMyjZJ2xf4p3qGgU6BXcvOvv10OB4HAGKDuyxa9kjLdF
    qxOVhTldrRulGj86uOpI6CDSljQc6tARF/fErez9ofdL7fgZ+zMSilHL7l7myFgc
    a3B17rgVNt8h9e2qNJmbalF64hjUjxnPaCIa0vCIQpDZOYFxNTfFYiOKpW5IRL5B
    aBUfRBXn1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from yandex-team.ru);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=EpaVDSs8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=yandex-team.ru;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=yandex-team.ru header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from yandex-team.ru);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=EpaVDSs8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=yandex-team.ru;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=yandex-team.ru header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB46VujWLtGS0Q/FHkbiRgje7HW4HnIP7nB7z9rPiLrH3ks9I9lGlu6WnDJ3q/Z1EPKgOOXocwLU3JPtdwA3gShDefBuTmZTQlsVMhj7wzv5yeJjBwX3
    ThuIwN2gGBy9O8iOQRnD26H1P6OxDv5l8NiU23Sz4wBxZ2mH3yCSUy1Yk79Eb6LJkuMjYlrbJo6+dmqD9chBnBeH9UleFgwsiFDQwxANupsGfY8vbyP0tCKy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
    a=7lSfO2FsKBLzcS1At7AA:9 a=RvZ24WBW94SMxf4V:21 a=C-netTbrbNQc_sXX:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeDEHKT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 03:10:19 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:46767 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750853AbeDEHKS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Apr 2018 03:10:18 -0400
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
 <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
 <87h8oqhagl.fsf@xmission.com>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
Date: Thu, 5 Apr 2018 10:02:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87h8oqhagl.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05.04.2018 01:29, Eric W. Biederman wrote:
> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
> 
>> On 04/04/2018 12:11 PM, Konstantin Khlebnikov wrote:
>>> Each process have different pids, one for each pid namespace it belongs.
>>> When interaction happens within single pid-ns translation isn't required.
>>> More complicated scenarios needs special handling.
>>>
>>> For example:
>>> - reading pid-files or logs written inside container with pid namespace
>>> - attaching with ptrace to tasks from different pid namespace
>>> - passing pids across pid namespaces in any kind of API
>>>
>>> Currently there are several interfaces that could be used here:
>>>
>>> Pid namespaces are identified by inode number of /proc/[pid]/ns/pid.
> 
> Using the inode number in interfaces is not an option.  Especially not
> withou referencing the device number for the filesystem as well.

This is supposed to be single-instance fs,
not part of proc but referenced but its magic "symlinks".

Device numbers are not mentioned in "man namespaces".

> 
>>> Pids for nested Pid namespaces are shown in file /proc/[pid]/status.
>>> In some cases conversion pid -> vpid could be easily done using this
>>> information, but backward translation requires scanning all tasks.
>>>
>>> Unix socket automatically translates pid attached to SCM_CREDENTIALS.
>>> This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
>>> into pid namespace, this expose process and could be insecure.
>>>
>>> This patch adds new syscall for converting pids between pid namespaces:
>>>
>>> pid_t translate_pid(pid_t pid, int source_type, int source,
>>>                                  int target_type, int target);
>>>
>>> @source_type and @target_type defines type of following arguments:
>>>
>>> TRANSLATE_PID_CURRENT_PIDNS  - current pid namespace, argument is unused
>>> TRANSLATE_PID_TASK_PIDNS     - task pid-ns, argument is task pid
>>
>> I believe using pid to represent the namespace has been already
>> discussed in V1 of this patch in https://lkml.org/lkml/2015/9/22/1087
>> after which we moved on to fd based version of this interface.
> 
> Or in short why is the case of pids important?
> 
> You Konstantin you almost said why they were important in your message
> saying you were going to send this one.  However you don't explain in
> your description why you want to identify pid namespaces by pid.
> 

Open of /proc/[pid]/ns/pid requires same permissions as ptrace,
pid based variant doesn't have such restrictions.
Most pid-based syscalls are racy in some cases but they are
here for decades and everybody knowns how to deal with it.
So, I've decided to merge both worlds in one interface which clearly tells what to expect.
