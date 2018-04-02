Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791776-1522667534-2-11105536339980214997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522667534; b=o1Lohr+FEiuT4dSmsR/TkDta0+rf7vZd6TxiwWzK6czlNhKLnb
    VSlSQ6E1hNP2V3uFvSqHSi9+soLk9p9xDnL7a+VTdH2EdEU1U5A1Emi9pGyzNBGr
    WIjbVVvpK7tD1pJgbS0LL9jSx/qTwEzPKBp7QgGPgKyvDASnd8lb2eYhJLxVwbGR
    h/hsS6LSBW7ZtvtQjsw+b8tcnu+BZRfcJnCFulo6Y48B1iHYTqJFFAU1PVqxAd2/
    6XloUcZA9mF2nq+Qf+QK4i4hwyxiLbZ4sysMunUk7slQCO/9M9EHx3yZyMYJNvg0
    YfPORULIR9D/QxUHqD3lJZ21Pzya3ovaJWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522667534;
    bh=VkVrB4vJSCZ8cCjInOgndCT4Uj0J9V4AAeYt/GgriIw=; b=L+7brcfXNVWE
    aIFwJwdZQwVbvR7KxNyYudo9L2BQh9/5hWDBHI/EYhDjXFQrQDgNxLINl6kU6ggH
    GuXEGXjH/SjYL7BUiClUNhBJI9dTJIE5uX/D9Qqzpx/6GKExcp/4gkjwWBXQI3jU
    PRUfxBTUTJPJkwa85XEW3ETbpHmQC7gKnApHiwd8Xai91S6upeNuLQNIcN6MYfO4
    7hCsfyHBzyb0H/WXiErzBUKvFhGIeFFIIKX3xP1COFiWLk9GXGzddXwZvAhEVOb3
    qdJ9iPKIBw1dmvA+TjvGWxaQrp0uWZh+V+J5AaVpnwaiGR/9YYEyNGmZ54pS/jyH
    Cxzbnwb88w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b=xDo/rXAB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=colorfullife.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RSKNYpfy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=colorfullife.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b=xDo/rXAB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=colorfullife.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RSKNYpfy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=colorfullife.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNnidSV8Gcw3hXJty4hbCjGV4/dPPS4d2QbmV1OC+NNWoZZqqro4686nxann37R3U3IjSvn8ah7nw7vEj75wEKcCzA/p8sgRacGGtsLErIihTNnvaf+k
    7NvN0B6TPo/Fo3qGUj3bYbRnJwvsquZD8hETkbCiR4X3beTzdKv+ZMRXtLIUL1+EmsIBQcGy8h9V+hmugphszM6xsiR3EIo+6T6Ej1NwGReUbljpOShY+Hor
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=0VibQREvBrf1WtGel6IA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeDBLMA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 07:12:00 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50746 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754440AbeDBLL6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Apr 2018 07:11:58 -0400
X-Google-Smtp-Source: AIpwx48RHxpTItGvEvERfYmn8s2EBtkLBwqq/KdCmcoDxnm09iZAYAKsalIk/iZkIOpPzJHglSD8Fw==
Subject: Re: [REVIEW][PATCH 11/11] ipc/sem: Fix semctl(..., GETPID, ...)
 between pid namespaces
To: Davidlohr Bueso <dave@stgolabs.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-11-ebiederm@xmission.com>
 <20180329005209.fnzr3hzvyr4oy3wi@linux-n805>
 <20180330190951.nfcdwuzp42bl2lfy@linux-n805>
From: Manfred Spraul <manfred@colorfullife.com>
Message-ID: <334d0390-88e9-b950-b07e-ad69c0516e5b@colorfullife.com>
Date: Mon, 2 Apr 2018 13:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180330190951.nfcdwuzp42bl2lfy@linux-n805>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 03/30/2018 09:09 PM, Davidlohr Bueso wrote:
> On Wed, 28 Mar 2018, Davidlohr Bueso wrote:
>
>> On Fri, 23 Mar 2018, Eric W. Biederman wrote:
>>
>>> Today the last process to update a semaphore is remembered and
>>> reported in the pid namespace of that process.  If there are processes
>>> in any other pid namespace querying that process id with GETPID the
>>> result will be unusable nonsense as it does not make any
>>> sense in your own pid namespace.
>>
>> Yeah that sounds pretty wrong.
>>
>>>
>>> Due to ipc_update_pid I don't think you will be able to get System V
>>> ipc semaphores into a troublesome cache line ping-pong.  Using struct
>>> pids from separate process are not a problem because they do not share
>>> a cache line.  Using struct pid from different threads of the same
>>> process are unlikely to be a problem as the reference count update
>>> can be avoided.
>>>
>>> Further linux futexes are a much better tool for the job of mutual
>>> exclusion between processes than System V semaphores.  So I expect
>>> programs that  are performance limited by their interprocess mutual
>>> exclusion primitive will be using futexes.
>>
The performance of sysv sem and futexes for the contended case is more 
or less identical, it depends on the CONFIG_ options what is faster.

And this is obvious, both primitives must do the same tasks:
sleep:
- lookup a kernel pointer from a user space reference
- acquire a lock, do some housekeeping, unlock and sleep
wakeup:
- lookup a kernel pointer from a user space reference
- acquire a lock, do some housekeeping, especially unlink the to be 
woken up task, unlock and wakeup

The woken up task has nothing to do, it returns immediately to user space.

IIRC for the uncontended case, sysvsem was at ~300 cpu cycles, but that 
number is a few years old, and I don't know what is the impact of spectre.
The futex code is obviously faster.
But I don't know which real-world applications do their own 
optimizations for the uncontended case before using sysvsem.

Thus the only "real" challenge is to minimize cache line trashing.

>> You would be wrong. There are plenty of real workloads out there
>> that do not use futexes and are care about performance; in the end
>> futexes are only good for the uncontended cases, it can also
>> destroy numa boxes if you consider the global hash table. Experience
>> as shown me that sysvipc sems are quite still used.
>>
>>>
>>> So while it is possible that enhancing the storage of the last
>>> rocess of a System V semaphore from an integer to a struct pid
>>> will cause a performance regression because of the effect
>>> of frequently updating the pid reference count.  I don't expect
>>> that to happen in practice.
>>
>> How's that? Now thanks to ipc_update_pid() for each semop the user
>> passes, perform_atomic_semop() will do two atomic updates for the
>> cases where there are multiple processes updating the sem. This is
>> not uncommon.
>>
>> Could you please provide some numbers.
>
[...]
> So at least for a large box this patch hurts the cases where there is low
> to medium cpu usage (no more than ~8 processes on a 40 core box) in a non
> trivial way. For more processes it doesn't matter. We can confirm that 
> the
> case for threads is irrelevant. While I'm not happy about the 30% 
> regression
> I guess we can live with this.
>
> Manfred, any thoughts?
>
Bugfixing has always first priority, and a 30% regression in one 
microbenchmark doesn't seem to be that bad.

Thus I would propose that we fix SEMPID first, and _if_ someone notices 
a noticeable regression, then we must improve the code.

--
     Manfred
