Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-74658-1524634619-2-5427606779458391747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ru',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524634618; b=bSIaeRKF7cn0dvz16HtGVLC6lma+98amxTYKe3MO1JWKD2K+B3
    NJvqmCimpJpRaKpHnjinj+XZSEK5YUzHVMWFXFO4ruwE/FIULpPTGFgJrw0UNHSK
    2wEcwBEnBivbuWqphM1t+kJRGYeBh22Z/jtFINqnhs9/tjA8KZ1vs1hgS4M2KP+L
    n2BFaZFeRs6WHBg1uIbgPIOtppRHoVxoRR1cWBf6wN5Xo3vtAdxnfjklcZTWBITv
    R1hzmwAjJitUkiuFhUDEduCsOJLLjIorShHKtbhrFHUBySbVa9yIRnEBsdoNKkX3
    wN49ujrwCUeWDZWGqnR2mpz7Tn+WI8gGK3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524634618;
    bh=AjNcBC8qyc3ytPLElRz/QWlRHaxN6RhO+LcEI0xs5XE=; b=VVUCnETjzlWA
    tCmIFy4m9LYLdrlSLmGO0fZ5MOZgawoRLdZ3ctnapPPjfdxb5FJ9TsBKF35WJ9mp
    2UXp6HMxFdB758P0RsNodws9TUbXZBQKoaxkPnwvshlTMmYtaGz7bIO+VAdc1uEY
    EKu9jtxrvV/aB+RT8SeovaykjuSHTMhNREypOJIThtkW4nMsYao8J8T+IA8vkTya
    Kl8o1CT5LTgbzr5DuGEvmqRTTPQ7WLZAl1WFVNFb6Wp5X4yDZixjEDjbQjQAsb3j
    7yj7gzsBuk39lxY0kiFSY0hpBxk8NQleBph17dOZoz0z5edJP0M7HSCyUGHtCwbs
    MroBq5E3FQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from yandex-team.ru);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=oDcyy/RI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=yandex-team.ru;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=yandex-team.ru header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from yandex-team.ru);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=oDcyy/RI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=yandex-team.ru;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=yandex-team.ru header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK69sc1hvA6oQfp3YBIMTXGfHL24p6lMHvzakeMmdmijVaoeLroCfXOCFLBGz3OTQNRIHUOhlvBJIIZnfmbLp2CYG5R4YMyQxyrDyAZHgT4gHYoRsoQ4
    ygg2/fZYR6AnfWbJ3cfzkUkV/rmvUHMa8q4vLSOUnxE09BjXaeZLau3cIbThqVhL28jNGC6OIO4W8ZnflQofWZ8poaAAsYXa5zSGo+i987YWvicVh3BAiuiv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8 a=D19gQVrFAAAA:8 a=NEAV23lmAAAA:8
    a=VwQbUJbxAAAA:8 a=t7H8OMKij7ZNLSx-6J0A:9 a=XRaPVF0vhe3dRJfr:21
    a=YzvGgDPCmXa8cs0P:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeDYFgz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 01:36:55 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:36816 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750929AbeDYFgy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 01:36:54 -0400
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
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
 <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
 <e1402871-77a5-6a0f-a75c-ccad77b93f49@oracle.com>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <778ab3d0-b6bc-fdb5-669a-40222e5020d4@yandex-team.ru>
Date: Wed, 25 Apr 2018 08:36:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e1402871-77a5-6a0f-a75c-ccad77b93f49@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23.04.2018 20:37, Nagarathnam Muthusamy wrote:
> 
> 
> On 04/05/2018 12:02 AM, Konstantin Khlebnikov wrote:
>> On 05.04.2018 01:29, Eric W. Biederman wrote:
>>> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>>>
>>>> On 04/04/2018 12:11 PM, Konstantin Khlebnikov wrote:
>>>>> Each process have different pids, one for each pid namespace it belongs.
>>>>> When interaction happens within single pid-ns translation isn't required.
>>>>> More complicated scenarios needs special handling.
>>>>>
>>>>> For example:
>>>>> - reading pid-files or logs written inside container with pid namespace
>>>>> - attaching with ptrace to tasks from different pid namespace
>>>>> - passing pids across pid namespaces in any kind of API
>>>>>
>>>>> Currently there are several interfaces that could be used here:
>>>>>
>>>>> Pid namespaces are identified by inode number of /proc/[pid]/ns/pid.
>>>
>>> Using the inode number in interfaces is not an option. Especially not
>>> withou referencing the device number for the filesystem as well.
>>
>> This is supposed to be single-instance fs,
>> not part of proc but referenced but its magic "symlinks".
>>
>> Device numbers are not mentioned in "man namespaces".
>>
>>>
>>>>> Pids for nested Pid namespaces are shown in file /proc/[pid]/status.
>>>>> In some cases conversion pid -> vpid could be easily done using this
>>>>> information, but backward translation requires scanning all tasks.
>>>>>
>>>>> Unix socket automatically translates pid attached to SCM_CREDENTIALS.
>>>>> This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
>>>>> into pid namespace, this expose process and could be insecure.
>>>>>
>>>>> This patch adds new syscall for converting pids between pid namespaces:
>>>>>
>>>>> pid_t translate_pid(pid_t pid, int source_type, int source,
>>>>>                                  int target_type, int target);
>>>>>
>>>>> @source_type and @target_type defines type of following arguments:
>>>>>
>>>>> TRANSLATE_PID_CURRENT_PIDNS  - current pid namespace, argument is unused
>>>>> TRANSLATE_PID_TASK_PIDNS     - task pid-ns, argument is task pid
>>>>
>>>> I believe using pid to represent the namespace has been already
>>>> discussed in V1 of this patch in https://lkml.org/lkml/2015/9/22/1087
>>>> after which we moved on to fd based version of this interface.
>>>
>>> Or in short why is the case of pids important?
>>>
>>> You Konstantin you almost said why they were important in your message
>>> saying you were going to send this one.  However you don't explain in
>>> your description why you want to identify pid namespaces by pid.
>>>
>>
>> Open of /proc/[pid]/ns/pid requires same permissions as ptrace,
>> pid based variant doesn't have such restrictions.
> 
> Can you provide more information on usecase requiring PID translation but not used for tracing related purposes?

Any introspection for [nested] containers. It's easier to work when you have all information when you don't have any.
For example our CMS https://github.com/yandex/porto allows to start nested sub-container (or even deeper) by request from any container and 
have to tell back which pid task is have. And it could translate any pid inside into accessible by client and vice versa.

> On a side note, can we have the types TRANSLATE_PID_CURRENT_PIDNS and TRANSLATE_PID_FD_PIDNS integrated first and then possibly extend the 
> interface to include TRANSLATE_PID_TASK_PIDNS in future?

I don't see reason for this separation.
Pids and pid namespaces are part of the API for a long time.

> 
> Thanks,
> Nagarathnam.
>> Most pid-based syscalls are racy in some cases but they are
>> here for decades and everybody knowns how to deal with it.
>> So, I've decided to merge both worlds in one interface which clearly tells what to expect.
> 
