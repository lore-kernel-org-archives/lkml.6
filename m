Return-Path: <kernel-hardening-return-11965-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227T0/7ndNyZlH1Jn956oyyhvR12ZzJb7HrhnqP04DpQHhFxRHEQ3nbERqw2CfeOFgnX8uo/
ARC-Seal: i=1; a=rsa-sha256; t=1519669980; cv=none;
        d=google.com; s=arc-20160816;
        b=dojd2al7Iit8Ahe16La4k8Z7P354w/jv0Ak+YV153ZfEJed1zzSw0XfqrmPzAdAtSh
         USHPQumD8Ov5zvc8BVTLTl9jeJxKLiSJD44nEfdley1wzCWYP9cTz+KixyXHY5xUgwm/
         Z1LzQ46HUznBtbeVRL5DnNcnhL6H461xkBK6X/Aiju/Nc/6zDHxmK+efjbPE0f1DEZVi
         3yCSixVRO8qHv+KAwpdTyHDwkfIs5agmNEP2QZ4qDvtXQbYmaNLEVy35Fgl1SekYGj0z
         2pdfnZqH1bf80esd2e0Vb4N+biaB5iAdMwHjW1GU8KJTA5qQ4DOO8k5IokzkW57+CFzA
         pHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=ptsh6kMVqBFcNZW3W7ULcui9OJKh3wrLfF31xHEWSMY=;
        b=cxY9/3u55tEaI/7musUy1MbVlfp4WrfO/1W4AbHyzo30rlWdnt+GbxZBUqspaTMViw
         tEQGbYOggc5AVUh1bWpnG4q6aVHcVgJzotufJncpOQebPjUD6heUMKoNIiPIo8M0DexD
         UV3rT/ENf7c6LuXWSgeiv4nHTQ+ZnMQCgmqJEclb8pSzjYvEckKvpstUsUDPSvebJQDc
         JJ70G5NS2T47uD8zcqQbxWcCuZrIajExiNRS6Cb6d8GPODz8UExZh/FI1IOXogslAPm5
         0kjOLIeTKRgPZJIJ20g6A2+18mmbp07EBDxPThAMDnSjgIE5/Q9sUhPdXh70g+cTeGio
         jJug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CmpOSMFK;
       spf=pass (google.com: domain of kernel-hardening-return-11965-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11965-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CmpOSMFK;
       spf=pass (google.com: domain of kernel-hardening-return-11965-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11965-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/7] Documentation for Pmalloc
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-8-igor.stoppa@huawei.com>
 <98b2fecf-c1b3-aa5e-ba70-2770940bb965@gmail.com>
 <181b20bb-b0ae-c337-d4bd-03b6ddfed749@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <79cfdcc9-9073-3270-25cc-4835675386b0@gmail.com>
Date: Mon, 26 Feb 2018 10:32:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <181b20bb-b0ae-c337-d4bd-03b6ddfed749@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203869384416371?=
X-GMAIL-MSGID: =?utf-8?q?1593489469478008244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[...]

On 2/26/18 7:39 AM, Igor Stoppa wrote:
>
> On 24/02/18 02:26, J Freyensee wrote:
>>
>> On 2/23/18 6:48 AM, Igor Stoppa wrote:
> [...]
>
>>> +- Before destroying a pool, all the memory allocated from it must be
>>> +  released.
>> Is that true?  pmalloc_destroy_pool() has:
>>
>> .
>> .
>> +    pmalloc_pool_set_protection(pool, false);
>> +    gen_pool_for_each_chunk(pool, pmalloc_chunk_free, NULL);
>> +    gen_pool_destroy(pool);
>> +    kfree(data);
>>
>> which to me looks like is the opposite, the data (ie, "memory") is being
>> released first, then the pool is destroyed.
> well, this is embarrassing ... yes I had this prototype code, because I
> was wondering if it wouldn't make more sense to tear down the pool as
> fast as possible. It slipped in, apparently.
>
> I'm actually tempted to leave it in and fix the comment.

Sure, one or the other.

>
> [...]
>
>>> +
>>> +- pmalloc does not provide locking support with respect to allocating vs
>>> +  protecting an individual pool, for performance reasons.
>> What is the recommendation to using locks then, as the computing
>> real-world mainly operates in multi-threaded/process world?
> How common are multi-threaded allocations of write-once memory?
> Here we are talking exclusively about the part of the memory life-cycle
> where it is allocated (from pmalloc).

Yah, that's true, good point.

>
>> Maybe show
>> an example of an issue that occur if locks aren't used and give a coding
>> example.
> An example of how to use a mutex to access a shared resource? :-O
>
> This part below, under your question, was supposed to be the answer :-(
>
>>> +  It is recommended not to share the same pool between unrelated functions.
>>> +  Should sharing be a necessity, the user of the shared pool is expected
>>> +  to implement locking for that pool.

My bad, I was suggesting a code sample, if there was a simple code 
sample to provide (like 5-10 lines?).  If it's a lot of code to write, 
no bother.

> [...]
>
>>> +- pmalloc uses genalloc to optimize the use of the space it allocates
>>> +  through vmalloc. Some more TLB entries will be used, however less than
>>> +  in the case of using vmalloc directly. The exact number depends on the
>>> +  size of each allocation request and possible slack.
>>> +
>>> +- Considering that not much data is supposed to be dynamically allocated
>>> +  and then marked as read-only, it shouldn't be an issue that the address
>>> +  range for pmalloc is limited, on 32-bit systems.
>> Why is 32-bit systems mentioned and not 64-bit?
> Because, as written, on 32 bit system the vmalloc range is relatively
> small, so one might wonder if there are enough addresses.
>
>>    Is there a problem with 64-bit here?
> Quite the opposite.
> I thought it was clear, but obviously it isn't, I'll reword this.

Sounds good, thank you,
Jay

>
> -igor
>
>
