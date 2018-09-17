Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3623ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AD82088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmGHghQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AD82088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeIQTZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:25:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35664 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeIQTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:25:04 -0400
Received: by mail-io1-f67.google.com with SMTP id w11-v6so11548369iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A5C9JpUcMs/XUMMSgha4x4VhucxLO0j6N+3DZxHJQEI=;
        b=QmGHghQfKWxKVdHGzcd6xi+ve9xC9Zk/Zy2dkyd7U6OGI6FRtEs8CZRy5CFMZUFgIp
         K20U6b9jY43qLXX3si9HtkI+HzjixxeMHHv6pVfWHSGVoCcuFY2u3UHIZaERk8a4aFy1
         7mOLO2YQNcKqFN7IT/2vaaqdWZNfjpUYn7T9C5p0NdJRRbsZWBXLmPa6ClLK/rMVJyT5
         Hv/hiBTlw7p2TGY+RMLbwfsHek22tMCCtMn8AO++RADA3VfAVRaS2hgCctPJmx9qXlrb
         PoaIY+CQs/lNXozUfdrmIDfdyCXxCTy6FpHoP6MzyNPME8TSBUMUsYeFtpaVPoQg0l71
         nn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A5C9JpUcMs/XUMMSgha4x4VhucxLO0j6N+3DZxHJQEI=;
        b=OSUSKiFjQKaCjAzAUGaIPgg0hI1J73zzEm8RN6PBbudGlxbbZsMuDL4/xMdpRB5lOf
         Kl9tIUl8c9AryDxIXQSvNslnHl4yf4VQTjqIpGDE3HeA+pXckPmBkfupNp+gFgG1MpuS
         gU0/7zc71kTWVKNLrTMaulQBW6Jsb0IR/8M8HQnUMkHVXQxn5J3Hd6STBhAxvUadGcCo
         lJnxGvmLLcFLnmLwivEpCbVCON0YEVH3WOFSOTRth/U7pORGoIIfjVQd7giXPhQs+3yM
         3xYspmLHUp5+8wZeYA8/ov8mEmHsx0siR796+m8TUyfoHfowd/zLzCcZ+OY5EV2+NwSg
         Nq7A==
X-Gm-Message-State: APzg51CDJ0LnWBGrwzdGC3Z6smhWTJ+ymyYGRC/Afc5hprldSQUKn8VF
        pF7EGvA1LCaawJsUsnun7mnphXG5ZnzqZmk7DcMBVQ==
X-Google-Smtp-Source: ANB0VdYhjv6H690no4Zk2FvIkx50KilOQ2aXkO73zvawRwRNApq6DJr0ZYFbddi2gSzO8Dy78R30LbcojfQYk73pxcw=
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr19665917ioh.271.1537192656060;
 Mon, 17 Sep 2018 06:57:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 06:57:15
 -0700 (PDT)
In-Reply-To: <c6b184f4-5487-b7ba-a332-1437180e7705@i-love.sakura.ne.jp>
References: <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
 <20171105201834.GA8126@zzz.localdomain> <201804162302.GBI43737.OLFSOFQHVJMFtO@I-love.SAKURA.ne.jp>
 <201804202306.FGC05220.OOJFMFOSFHtLQV@I-love.SAKURA.ne.jp>
 <CACT4Y+Y3M2kB0YWhwD04NkL1-iNHPuDfDDf9BLoPD3GZ6Gg-Yw@mail.gmail.com>
 <201805021930.CBE82399.QFHtOOJFMVFOSL@I-love.SAKURA.ne.jp>
 <CACT4Y+ZaYFt70NrPaib7KFmLe1xQciMnEzWpUDzP6vQJmyctoA@mail.gmail.com>
 <CACT4Y+YVf_68vmx8f570NS3SQiKDeJTuEgEOGjQzwVT4hMDbUw@mail.gmail.com> <c6b184f4-5487-b7ba-a332-1437180e7705@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Sep 2018 15:57:15 +0200
Message-ID: <CACT4Y+YdVYbZwMAWGkQ=K6KhG+VV_zr1h2VHGGzdhXvGQK17-Q@mail.gmail.com>
Subject: Re: possible deadlock in blkdev_reread_part
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers3@gmail.com>,
        syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:43 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/09/13 21:58, Dmitry Vyukov wrote:
>> On Wed, May 2, 2018 at 1:23 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Wed, May 2, 2018 at 12:30 PM, Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> Dmitry Vyukov wrote:
>>>>>> syzbot is reporting various bugs which involve /dev/loopX.
>>>>>> Two of them
>>>>>>
>>>>>>   INFO: rcu detected stall in lo_ioctl
>>>>>>   https://syzkaller.appspot.com/bug?id=7b49fb610af9cca78c24e9f796f2e8b0d5573997
>>>>>>
>>>>>>   general protection fault in lo_ioctl (2)
>>>>>>   https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
>>>>>
>>>>> /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
>>>>>
>>>>> Now there is a repro for this one. I've pushed it to kernel mailing lists:
>>>>>
>>>>> https://groups.google.com/d/msg/syzkaller-bugs/c8KUcTAzTvA/3o_7g6-tAwAJ
>>>>
>>>> OK, thanks. But among loop related reports, this will be a dup of
>>>> "INFO: rcu detected stall in blkdev_ioctl" which already has C reproducer.
>>>> Should we merge them?
>>>
>>> Yes, sure, I will take care of it.
>>
>> 1. I forgot to take care of it.
>>
>> 2. "INFO: rcu detected stall in blkdev_ioctl" was fixed 3 months ago:
>> https://syzkaller.appspot.com/bug?id=1f7b710f4110f225aed1f4263ec2b98b8dbd472e
>>
>> but this bug still happens up until now:
>> https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
>>
>> So this is a different bug.
>
> I'm not sure what you are talking about.
> RCU stall and lockdep warning are obviously different bugs.

Ah, OK, I misinterpreted your "But among loop related reports, this
will be a dup of "INFO: rcu detected stall in blkdev_ioctl"".
So this is just an independent bug that still happens.

> Regarding lockdep warning on loop module, we are still waiting for Jens to
> come up a better alternative than
> http://lkml.kernel.org/r/1527297408-4428-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp .
> Since no alternative was proposed, I think we should start testing my patch.
>
