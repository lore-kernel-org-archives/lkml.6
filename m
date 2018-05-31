Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733878-1527785783-2-11481930474486177635
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527785782; b=TB/MYZYAaqToFE97giM5HzVjejSvR3LpwixUm9flggSVjTIVaK
    GGnPtyCCA2CVy2D4osNY3VooWeRuWMaKvbSFk+zhPdCUNMcM1ajkzLrO62MAT2dJ
    ak5d+EDghpY2vLXuVOzI9wtM4gm3qT4SELWIVEOfcyEnTbXhPNvnCUuGwj64oeNq
    SAORcbAjJJjdK9JhIiFMYUpiaAJj1Cr52cDCEmetarSzdPx0rbRSkEt6kYeKswZ4
    a5bPW7L6EwDdOPcSgP4UN/ezAlbGwMsRieGdv86KgTEmKuSPBRXWE4kxGAkb6pFF
    9xvBZXu2cLO4oAA9nbaIY1HZyYpPbxdvuhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527785782;
    bh=DqnXiovQ842QAx8AQywUyOOPRvhb9cksphisLV+q4IU=; b=nobsh9OEgrVN
    G564i9Psbg0Q3knUc+dX/7UEVKDKMfc3cko90G+2LZTz9h3RkONr14uWnC+1k+Oc
    0HCROMJrqHgpS9k4TwyTzQx6m+bQgOAacHr54yZf4N4o6NI1lDL5T04liKe01YFt
    9MEURrEHQcIwZkeAUU5AcKneYbW4cH4irjNBcS2+osd9D3zxO+gfLEQTy0Ki0r+9
    iJY+uoX8qu6mswarNSLMTFRPXMQudKkMhyiryJ5eLhDQG5+m6ke26Wf3J6i8IjP5
    z0eU9+bcGL67KDOf4Eqpn8vtSiDIw5PYURiWMEdF0HWXuEalHQYSu2cQtw56rssd
    e0uP2DsFpw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=kernel-dk.20150623.gappssmtp.com
    header.i=@kernel-dk.20150623.gappssmtp.com header.b=AxtJ6UTt
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=hqEGCieu;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=kernel-dk.20150623.gappssmtp.com
      header.i=@kernel-dk.20150623.gappssmtp.com header.b=AxtJ6UTt
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=hqEGCieu;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBC6yWtXyIWoIagGG0CoDe1hEvCxn6BvKSL+S26ZXVh9R+usb154auITV5No91gH8CrhXYw5F3FS+vMn8VBlaLT4U0oJpMRHjfTZCEpLjsfn9aYNnWE4
    xXX0oXM991cy2z+VUER4e7w9YmR0kxvpo3cCrTth1Guni8zbuA/v1z4HdYR4DXul720KEreBus5PVEfb77LrXb6xQ07batErWLIftzW5mYz58wMHD443Cjj+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=edf1wS77AAAA:8 a=jdovhPHy8xZ1We_r0i8A:9 a=QEXdDO2ut3YA:10
    a=DcSpbTIhAlouE1Uv7lRv:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755739AbeEaQ4T (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 12:56:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40808 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755630AbeEaQ4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 12:56:16 -0400
X-Google-Smtp-Source: ADUXVKKlENofySbnzlwLKQeqEIXC9f8O3JVpA8Bap2ML0F0YJF8LgL0noan+4CiDf1WjKUA9huvz0w==
Subject: Re: general protection fault in wb_workfn (2)
To: Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        tj@kernel.org, david@fromorbit.com, linux-block@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
 <20180528133503.awomzj6djozbo5bv@quack2.suse.cz>
 <2dda7a11-3f6b-bdba-a68a-7c0694806cc4@I-love.SAKURA.ne.jp>
 <20180531114228.6zx27xxurmz27pke@quack2.suse.cz>
 <c0fc1c47-0efb-5ded-7f6c-79074ad4deac@i-love.sakura.ne.jp>
 <20180531134212.oo4ra4ypuruab3xp@quack2.suse.cz>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eacb3cbe-3768-82cd-02c1-c8d1b549673f@kernel.dk>
Date: Thu, 31 May 2018 10:56:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180531134212.oo4ra4ypuruab3xp@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/31/18 7:42 AM, Jan Kara wrote:
> On Thu 31-05-18 22:19:44, Tetsuo Handa wrote:
>> On 2018/05/31 20:42, Jan Kara wrote:
>>> On Thu 31-05-18 01:00:08, Tetsuo Handa wrote:
>>>> So, we have no idea what is happening...
>>>> Then, what about starting from temporary debug printk() patch shown below?
>>>>
>>>> >From 4f70f72ad3c9ae6ce1678024ef740aca4958e5b0 Mon Sep 17 00:00:00 2001
>>>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>> Date: Wed, 30 May 2018 09:57:10 +0900
>>>> Subject: [PATCH] bdi: Add temporary config for debugging wb_workfn() versus
>>>>  bdi_unregister() race bug.
>>>>
>>>> syzbot is hitting NULL pointer dereference at wb_workfn() [1]. But due to
>>>> limitations that syzbot cannot find reproducer for this bug (frequency is
>>>> once or twice per a day) nor we can't capture vmcore in the environment
>>>> which syzbot is using, for now we need to rely on printk() debugging.
>>>>
>>>> [1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206
>>>>
>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>
>>> Hum a bit ugly solution but if others are fine with this, I can live with
>>> it for a while as well. Or would it be possible for syzkaller to just test
>>> some git tree where this patch is included? Then we would not even have to
>>> have the extra config option...
>>
>> If syzbot can reproduce this bug that way. While it is possible to add/remove
>> git trees syzbot tests, frequently adding/removing trees is bothering.
>>
>> syzbot can enable extra config option. Maybe the config name should be
>> something like CONFIG_DEBUG_FOR_SYZBOT rather than individual topic.
>>
>> I think that syzbot is using many VM instances. I don't know how many
>> instances will be needed for reproducing this bug within reasonable period.
>> More git trees syzbot tests, (I assume that) longer period will be needed
>> for reproducing this bug. The most reliable way is to use the shared part
>> of all trees (i.e. linux.git).
> 
> I understand this, I'd be just a bit reluctant to merge temporary debug
> patches like this to Linus' tree only to revert them later just because
> syzkaller... What do others think?

I guess I don't understand why having it in Linus's tree would make
a difference to syzkaller?

If there is a compelling reason why that absolutely has to be done,
I don't think it should be accompanied by a special Kconfig option
for it. It should just be on unconditionally, with the intent to
remove it before release.

-- 
Jens Axboe
