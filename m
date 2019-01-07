Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B40C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260D22085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="QxhnLywW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfAGSFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:05:00 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39371 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfAGSE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:04:59 -0500
Received: by mail-wm1-f45.google.com with SMTP id f81so1806387wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pgjTbpN8FXb/wpLhdTDoqFmKQswH6IxZ3RsZ1XGqquI=;
        b=QxhnLywWeAsUYy/r4SAmQoEVzNylXKYIxsTbSyxOtu/04DI3jWmA9PG8HhADdyNtaW
         phteKAR72d21OPP4WIuFrWxCB1HzzFS4xI1JFCnitsCm/Y6/VBIrUTFrd7WdUoeG6Rcb
         +K/C1jq/5AzOEqldUqE1Q7165IeOAwnYOaKqBqDZJevuqGcJkN3Sfa/2i6sgKCl0EtQQ
         +WHF7RH2mTR11+PP3cmHwEdUMQwuU/yaP3SLnSN1vZUuW42l29naARfIcDzBgPAlyTdq
         8TwaAKi+BMUK4PfKGwcO5Q8PdXQh57xmLNQu/SfgO1B/rSBhW0utraUsrKh5ho0eB2Jl
         lGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pgjTbpN8FXb/wpLhdTDoqFmKQswH6IxZ3RsZ1XGqquI=;
        b=EP9J3Gq/0bDcM0qD9eVxlgL7j3YXOZJMdQOnmoO0xXRF4q8KQiHefeeLkkpGXy9q0/
         hh+nMbymlh7b9lyap8XMHupKamV0s5Cl7Ai98PXpsliFbya60hbBJr2zZHMVwodF7Rap
         VbH8Defp3JEIJrGabAOfRvM3iIzJePcOwXkVE82BUsySCWw9Eb8dhKs/58l1tAdKJ7aU
         AdVfazAVdZdaQ6FYTB4IW6BiM7+xzRcv/xs1cnTYPeO5AhM/9UbzzfuL4jXAFCS4XjOe
         7CgO+vhtp3qJUvacgpP3oTjxJRWUWXs7vlAc4qOyhTcQIRUxhDktvIDvUyy7dtYf2hCh
         Z4EQ==
X-Gm-Message-State: AJcUukcrMbzXFB4I2awo0RBteA+LNVmb8hHit29jx+fTRbm30/PfRYsc
        O2wkAV+tUZiVzfbjefcXy8yLNg==
X-Google-Smtp-Source: ALg8bN5377PnsFcd7JkBU1RMF5RAhLIVoDg/xG08TpliYdpC5YjznehGH7GES/VuWFMdz9xezhuITA==
X-Received: by 2002:a1c:cf82:: with SMTP id f124mr9855146wmg.95.1546884297341;
        Mon, 07 Jan 2019 10:04:57 -0800 (PST)
Received: from linux-2.fritz.box (p200300D993C59900F26698422463201C.dip0.t-ipconnect.de. [2003:d9:93c5:9900:f266:9842:2463:201c])
        by smtp.googlemail.com with ESMTPSA id h131sm11636528wmd.17.2019.01.07.10.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:04:56 -0800 (PST)
Subject: Re: general protection fault in put_pid
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <00000000000051ee78057cc4d98f@google.com>
 <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com>
 <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
 <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com>
 <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
 <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com>
 <cc088b05-7bc9-778e-30b9-4b8720314001@colorfullife.com>
 <CALvZod7RtD7zcN48S+duFtjLUsSJrmXUqQawh6=ziw62gvOQjg@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <ef0fe093-6fae-6c54-024b-fdec9c056af3@colorfullife.com>
Date:   Mon, 7 Jan 2019 19:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CALvZod7RtD7zcN48S+duFtjLUsSJrmXUqQawh6=ziw62gvOQjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 11:18 PM, Shakeel Butt wrote:
> Hi Manfred,
>
> On Sun, Dec 23, 2018 at 4:26 AM Manfred Spraul <manfred@colorfullife.com> wrote:
>> Hello Dmitry,
>>
>> On 12/23/18 10:57 AM, Dmitry Vyukov wrote:
>>> I can reproduce this infinite memory consumption with the C program:
>>> https://gist.githubusercontent.com/dvyukov/03ec54b3429ade16fa07bf8b2379aff3/raw/ae4f654e279810de2505e8fa41b73dc1d77778e6/gistfile1.txt
>>>
>>> But this is working as intended, right? It just creates infinite
>>> number of large semaphore sets, which reasonably consumes infinite
>>> amount of memory.
>>> Except that it also violates the memcg bound and a process can have
>>> effectively unlimited amount of such "drum memory" in semaphores.
>> Yes, this is as intended:
>>
>> If you call semget(), then you can use memory, up to the limits in
>> /proc/sys/kernel/sem.
>>
>> Memcg is not taken into account, an admin must set /proc/sys/kernel/sem.
>>
>> The default are "infinite amount of memory allowed", as this is the most
>> sane default: We had a logic that tried to autotune (i.e.: a new
>> namespace "inherits" a fraction of the parent namespaces memory limits),
>> but this we more or less always wrong.
>>
>>
> What's the disadvantage of setting the limits in /proc/sys/kernel/sem
> high and let the task's memcg limits the number of semaphore a process
> can create? Please note that the memory underlying shmget and msgget
> is already accounted to memcg.

Nothing, it it just a question of implementing it.

I'll try to look at it.

--

     Manfred

