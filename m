Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2547981-1528206401-2-18169352226731657483
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528206401; b=Mx1SyZWxtZjaEzV6kzrKbj0QxzzGKMSBfgXsnsqxauNbEawgtY
    p2/dL4SdESM11Gxz8XQLhy59oXpWRmY1J5iFnEX4F+tqgiSUTODfI20pjpruekdx
    QZcYqGGlUFDL/DGVzf1zTW6KnaItfmx/1y3pQ3UJ6makJ12pWCncN+gsIV4L8D9W
    PKQv59K0U4IhCbCtJSZVISInkAkHhyK1nxBfUaTbQdAGFvt5LTOEKo5uZ9IyCIBY
    KYl9VcM867CzHEdinVfJ++4Q8zMpiyuilHNFXnsJXUjUNoLsEMuj+hsCuxjtPKfv
    oyg4QelxqommfR4aglvPXC+eaTyVO1xBOc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528206401;
    bh=MqbJLmRMgL0beKnsbCp/JpkJTX3qLytisBvgTgZ+icQ=; b=L1R6ya50+p0O
    oXWoCGYdKXuqC2fupCZ0qb30YAg5Z1+JefpKHHTyqbk297FZqIjvTrn9j9DRfD2A
    BYQfl4AP+xsOoK4MiajJsat1+F4bnG8CdIG7gR5NY7oDFd+JTm8TAHNZL9wDHXnR
    lGFXqjW8m8LWXtstVxvTk7CKHkB3vQwRKOMuoeoSCVhorZNxQzuXjtDHY0HIjti5
    9VrB31o2NCOQypz85QjtAzBYfshHKvpfipup1esFk6JlCfqfeji+WikA8u3GyZgn
    GztyKUZ40eesqQs+jUdd7cfFf3JtnMHVKA3EPZkgkHmpfqutgmGR7ZZrWrBm0i0g
    waAI1/PF1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=i-love.sakura.ne.jp header.result=pass
    header_org.domain=sakura.ne.jp header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=i-love.sakura.ne.jp header.result=pass
      header_org.domain=sakura.ne.jp header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBEdaBzCOaF9ukilpvWTTZFyWIUCu908FVTpv6o35Aqk/6DgrRG9jLAUny+MFjBxAwSuW0iOB7j3HF0djUktthEcVqLP5ihHePgIkCK+2xQ+vf81Aehk
    O3EJjI6MDvb+xxAcIe6BgCwcKF2u7TFc+80c/lDJHW3hUCMU3AC0ZBHaXTMvz+RadE8hLd7Ji5bsHzvyJmrFJy/uy9S18W6Vb9zZjwj8hxuiPfCpfR8BLcaJ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=NEAV23lmAAAA:8 a=edf1wS77AAAA:8 a=1IlkirHppI-bwTfCaDIA:9 a=QEXdDO2ut3YA:10
    a=DcSpbTIhAlouE1Uv7lRv:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeFENqh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 09:46:37 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56485 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeFENqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:46:35 -0400
Subject: Re: general protection fault in wb_workfn (2)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        tj@kernel.org, david@fromorbit.com, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
 <20180528133503.awomzj6djozbo5bv@quack2.suse.cz>
 <2dda7a11-3f6b-bdba-a68a-7c0694806cc4@I-love.SAKURA.ne.jp>
 <20180531114228.6zx27xxurmz27pke@quack2.suse.cz>
 <c0fc1c47-0efb-5ded-7f6c-79074ad4deac@i-love.sakura.ne.jp>
 <20180531134212.oo4ra4ypuruab3xp@quack2.suse.cz>
 <eacb3cbe-3768-82cd-02c1-c8d1b549673f@kernel.dk>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
Date: Tue, 5 Jun 2018 22:45:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <eacb3cbe-3768-82cd-02c1-c8d1b549673f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dmitry, can you assign VM resources for a git tree for this bug? This bug wants to fight
against https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches ...

On 2018/06/01 1:56, Jens Axboe wrote:
> On 5/31/18 7:42 AM, Jan Kara wrote:
>> On Thu 31-05-18 22:19:44, Tetsuo Handa wrote:
>>> On 2018/05/31 20:42, Jan Kara wrote:
>>>> On Thu 31-05-18 01:00:08, Tetsuo Handa wrote:
>>>>> So, we have no idea what is happening...
>>>>> Then, what about starting from temporary debug printk() patch shown below?
>>>>>
>>>>> >From 4f70f72ad3c9ae6ce1678024ef740aca4958e5b0 Mon Sep 17 00:00:00 2001
>>>>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>>> Date: Wed, 30 May 2018 09:57:10 +0900
>>>>> Subject: [PATCH] bdi: Add temporary config for debugging wb_workfn() versus
>>>>>  bdi_unregister() race bug.
>>>>>
>>>>> syzbot is hitting NULL pointer dereference at wb_workfn() [1]. But due to
>>>>> limitations that syzbot cannot find reproducer for this bug (frequency is
>>>>> once or twice per a day) nor we can't capture vmcore in the environment
>>>>> which syzbot is using, for now we need to rely on printk() debugging.
>>>>>
>>>>> [1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206
>>>>>
>>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>>
>>>> Hum a bit ugly solution but if others are fine with this, I can live with
>>>> it for a while as well. Or would it be possible for syzkaller to just test
>>>> some git tree where this patch is included? Then we would not even have to
>>>> have the extra config option...
>>>
>>> If syzbot can reproduce this bug that way. While it is possible to add/remove
>>> git trees syzbot tests, frequently adding/removing trees is bothering.
>>>
>>> syzbot can enable extra config option. Maybe the config name should be
>>> something like CONFIG_DEBUG_FOR_SYZBOT rather than individual topic.
>>>
>>> I think that syzbot is using many VM instances. I don't know how many
>>> instances will be needed for reproducing this bug within reasonable period.
>>> More git trees syzbot tests, (I assume that) longer period will be needed
>>> for reproducing this bug. The most reliable way is to use the shared part
>>> of all trees (i.e. linux.git).
>>
>> I understand this, I'd be just a bit reluctant to merge temporary debug
>> patches like this to Linus' tree only to revert them later just because
>> syzkaller... What do others think?
> 
> I guess I don't understand why having it in Linus's tree would make
> a difference to syzkaller?
> 
> If there is a compelling reason why that absolutely has to be done,
> I don't think it should be accompanied by a special Kconfig option
> for it. It should just be on unconditionally, with the intent to
> remove it before release.
> 
