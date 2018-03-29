Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-387209-1522313284-2-9271598040804626665
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
    1522313284; b=pEyEi3lFpY1UlqlZ+EN65JDqen5TBRibia1ZHv9yCMFRubxx5Q
    9ao4/2znftgV8z5Zu1shvim9uH3VBA7cTrmwGgfR1EiRBq/zLaa2idjzcQXZ8Ymm
    iaIs5x83S9a5+PQNXvsJr+Y6goCvzlMv2T3wDVAySZggrA5414+EPDgjSvDa/TDH
    ZUaKd7k2OAYPGhXF85GSP4q27sQG6gMmEdSKg2nvCr7qHZgeYiv3mVY2zPNpjZgH
    Rh+WkKcLpqj2R5J3KyL/yD7d1AFReMIrFp/69nGsyZS7UzkIsUn2X+u2ZFNhjmCe
    GWhFR2WOHqRoPPxCNvLQ7tb/4jSryhcytSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522313284;
    bh=zUMVp3+c/yA1QqZOo8TX2AGtayUqXC/ZeyhQV40yFjI=; b=KJOB4RB8GJOa
    VsQ1r/NSHBjyFkNC32sx7i8BuqaoMqRJ+BWwM0T8ANIkCfBtnH03/PPn/AOZaEza
    keiWVPYa8UWRtaQ0CYGDphyYSABbkHuRHdABTTYmE+XckHtSyes++sJP+u8OSagC
    IRBdYhHTvjpWX5UKaLO0AlFzFG4dbrXqClfl5SsZnps/JtVW2TGWfJiLiLxekyL0
    slHqdxdouDwij5/TCU0AB0Y8P/R17MZfHHJoViFPooa5O2SoO0fpS71+ls8I1P9l
    AGREqThU8df/BZoTtTUjmIZwdEs8hBWhyTUOe0tRyALAalMu4EleY8YphUZ+BuLQ
    obdZ5jgUBw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b=oA3cfs1L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=colorfullife.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SlGEqGL+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=colorfullife.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b=oA3cfs1L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=colorfullife.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SlGEqGL+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=colorfullife.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHY4czNKePjMnqkI1yIpFszVI+xZHVmq2NSbFmKVY8z/2jTyqLuuUL7GV7ykeR1qQ/di8nOeQmA68/wJOPnszbO5B11olDx5y6TJimiZ++OYmqHl79GD
    fuYCB/RTi4/RaxqHw+6EJy/uFItYhuPN4DjC2DcfTsWL/gGJ/HRJOvoLEAVrZruuVw+fZlFd8r7CoUJlryYUCRAp76Yuz64E9a0PIpj/PU3IEt38GdnDVbQZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=v2DPQv5-lfwA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=YxEMfy78hPN1QayaFTwA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeC2Iru (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 04:47:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39447 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeC2Irt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 04:47:49 -0400
X-Google-Smtp-Source: AIpwx49ZCAe5F0y56Y5PZNVdfX4ed6RQDoXHTbizPyycZ9/8W0XzojxT45vRPEp8ovLUP5IU19wPzg==
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
To: Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-5-git-send-email-longman@redhat.com>
 <87woyfyh57.fsf@xmission.com>
 <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
 <87o9jru3bf.fsf@xmission.com>
 <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
 <87woyego2u.fsf_-_@xmission.com>
 <047c6ed6-6581-b543-ba3d-cadc543d3d25@redhat.com>
 <87h8ph6u67.fsf@xmission.com>
 <7d3a1f93-f8e5-5325-f9a7-0079f7777b6f@redhat.com>
 <20180329021409.gcjjrmviw2lckbfk@linux-n805>
From: Manfred Spraul <manfred@colorfullife.com>
Message-ID: <3e201de2-bed2-6f7d-0783-700d095142e0@colorfullife.com>
Date: Thu, 29 Mar 2018 10:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329021409.gcjjrmviw2lckbfk@linux-n805>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello together,

On 03/29/2018 04:14 AM, Davidlohr Bueso wrote:
> Cc'ing mtk, Manfred and linux-api.
>
> See below.
>
> On Thu, 15 Mar 2018, Waiman Long wrote:
>
>> On 03/15/2018 03:00 PM, Eric W. Biederman wrote:
>>> Waiman Long <longman@redhat.com> writes:
>>>
>>>> On 03/14/2018 08:49 PM, Eric W. Biederman wrote:
>>>>> The define IPCMNI was originally the size of a statically sized 
>>>>> array in
>>>>> the kernel and that has long since been removed. Therefore there 
>>>>> is no
>>>>> fundamental reason for IPCMNI.
>>>>>
>>>>> The only remaining use IPCMNI serves is as a convoluted way to format
>>>>> the ipc id to userspace.  It does not appear that anything except for
>>>>> the CHECKPOINT_RESTORE code even cares about this variety of 
>>>>> assignment
>>>>> and the CHECKPOINT_RESTORE code only cares about this weirdness 
>>>>> because
>>>>> it has to restore these peculiar ids.
>>>>>
My assumption is that if an array is recreated, it should get a 
different id.
     a=semget(1234,,);
     semctl(a,,IPC_RMID);
     b=semget(1234,,);
now a!=b.

Rational: semop() calls only refer to the array by the id.
If there is a stale process in the system that tries to access the "old" 
array and the new array has the same id, then the locking gets corrupted.
>>>>> Therefore make the assignment of ipc ids match the description in
>>>>> Advanced Programming in the Unix Environment and assign the next id
>>>>> until INT_MAX is hit then loop around to the lower ids.
>>>>>
Ok, sounds good.
That way we really cycle through INT_MAX, right now a==b would happen 
after 128k RMID calls.
>>>>> This can be implemented trivially with the current code using 
>>>>> idr_alloc_cyclic.
>>>>>
Is there a performance impact?
Right now, the idr tree is only large if there are lots of objects.
What happens if we have only 1 object, with id=INT_MAX-1?

semop() that do not sleep are fairly fast.
The same applies for msgsnd/msgrcv, if the message is small enough.

@Davidlohr:
Do you know if there are application that frequently call semop() and it 
doesn't have to sleep?
 From the scalability that was pushed into the kernel, I assume that 
this exists.

I have myself only checked postgresql, and postgresql always sleeps.
(and this was long ago)
>>>>> To make it possible to keep checkpoint/restore working I have renamed
>>>>> the sysctls from xxx_next_id to xxx_nextid.  That is enough change 
>>>>> that
>>>>> a smart CRIU implementation can see that what is exported has 
>>>>> changed,
>>>>> and act accordingly.  New kernels will be able to restore the old 
>>>>> id's.
>>>>>
>>>>> This code still needs some real world testing to verify my 
>>>>> assumptions.
>>>>> And some work with the CRIU implementations to actually add the code
>>>>> that deals with the new for of id assignment.
>>>>>
It means that all existing checkpoint/restore application will not work 
with a new kernel.
Everyone must first update the checkpoint/restore application, then 
update the kernel.

Is this acceptable?

--
     Manfred
