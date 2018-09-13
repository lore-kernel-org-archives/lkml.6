Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28677C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF76C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lggR7lJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF76C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeIMSIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:08:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38811 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeIMSIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:08:37 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so7577070ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4A6pDmlKxrgMDP2s5Ov4bc7c9IZm+JGR5i2PqyAw0d8=;
        b=lggR7lJMd5lxSACNq/tICLcAPnH99Q2Vf2kriy+sXmlTNTUvAnjGGlcrW1DBHY3S7O
         6OQo+9XMC3kZqHqdOHdIP8rH+3C8P1caVlUx5ftMuwetT38Yi6ACq3QqeZ8MQvvL7tpv
         Ah5oqpSkkJtXYS8k21aFTo0SbThcgFHDOwV6ZiWPuAGXY/ZlasfJN6G8YM2VYian8tf+
         5eiJCtbYI+to/dK8lEo7LMmpKoIrtXhnt4+btXU5sXIcT5nGXXoBs7l49gLUVBDR2TBv
         AhUD6ACIFLeFrajA0girNX3a8CofBukAYeDqs3O9dj6k43rZuRf0Lih2eCrNkVTpCehy
         Xeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4A6pDmlKxrgMDP2s5Ov4bc7c9IZm+JGR5i2PqyAw0d8=;
        b=WRl6fFZ9FbaKypYgG7+ijs1YaAou1VvMO4ohJ1IaiGE4Zsl4GVJuHXolbgqvmp35Lb
         qR5KxUPHWpsxx1fS4/LCdYCcNjHkvJp1WLO83N9sQg/hjuSWp1bDolVgZa1nXexZvZOI
         c9pxGOhOk/acWiyZmB3Rcy4c1oUEMjlFRY2V6EB0a+tfr4xrZhecd4KacK7l7/Esaz+S
         x3h5cZTFiEpGa9gYZaeybQvu/YylKFewsemMs+7hr5Feaf7Nq103QJqeWjRrRmDtazqM
         A32s+BGQ4gB29KzTRyAXOLqwm8Otaaj7mRUI9ubGvKzkDRU6R0UIxRTkJd8InlCdUgt8
         Wdig==
X-Gm-Message-State: APzg51Ads5u2Joq4iw4rhCuMuGCJ8fECdbWRAtfCSyfz4iE5McPt+a9W
        13qJEfPVKKA+fvYcT2SQ/xrGjdSXDZjAZkyLfG2ruw==
X-Google-Smtp-Source: ANB0Vdapfwgprh99w+eiz/pw8FZn/L0wPS0xVr33FR0E86ayQrfPTaK+epXSzfMddqYy7zrgoeZyOeTGLqisNde8I6M=
X-Received: by 2002:a24:ef43:: with SMTP id i64-v6mr6073537ith.47.1536843555232;
 Thu, 13 Sep 2018 05:59:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 05:58:54
 -0700 (PDT)
In-Reply-To: <CACT4Y+ZaYFt70NrPaib7KFmLe1xQciMnEzWpUDzP6vQJmyctoA@mail.gmail.com>
References: <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
 <20171105201834.GA8126@zzz.localdomain> <201804162302.GBI43737.OLFSOFQHVJMFtO@I-love.SAKURA.ne.jp>
 <201804202306.FGC05220.OOJFMFOSFHtLQV@I-love.SAKURA.ne.jp>
 <CACT4Y+Y3M2kB0YWhwD04NkL1-iNHPuDfDDf9BLoPD3GZ6Gg-Yw@mail.gmail.com>
 <201805021930.CBE82399.QFHtOOJFMVFOSL@I-love.SAKURA.ne.jp> <CACT4Y+ZaYFt70NrPaib7KFmLe1xQciMnEzWpUDzP6vQJmyctoA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Sep 2018 14:58:54 +0200
Message-ID: <CACT4Y+YVf_68vmx8f570NS3SQiKDeJTuEgEOGjQzwVT4hMDbUw@mail.gmail.com>
Subject: Re: possible deadlock in blkdev_reread_part
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 1:23 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, May 2, 2018 at 12:30 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Dmitry Vyukov wrote:
>>> > syzbot is reporting various bugs which involve /dev/loopX.
>>> > Two of them
>>> >
>>> >   INFO: rcu detected stall in lo_ioctl
>>> >   https://syzkaller.appspot.com/bug?id=7b49fb610af9cca78c24e9f796f2e8b0d5573997
>>> >
>>> >   general protection fault in lo_ioctl (2)
>>> >   https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
>>>
>>> /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
>>>
>>> Now there is a repro for this one. I've pushed it to kernel mailing lists:
>>>
>>> https://groups.google.com/d/msg/syzkaller-bugs/c8KUcTAzTvA/3o_7g6-tAwAJ
>>
>> OK, thanks. But among loop related reports, this will be a dup of
>> "INFO: rcu detected stall in blkdev_ioctl" which already has C reproducer.
>> Should we merge them?
>
> Yes, sure, I will take care of it.

1. I forgot to take care of it.

2. "INFO: rcu detected stall in blkdev_ioctl" was fixed 3 months ago:
https://syzkaller.appspot.com/bug?id=1f7b710f4110f225aed1f4263ec2b98b8dbd472e

but this bug still happens up until now:
https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889

So this is a different bug.



>>   INFO: rcu detected stall in blkdev_ioctl
>>   https://syzkaller.appspot.com/bug?id=1f7b710f4110f225aed1f4263ec2b98b8dbd472e
>>
>>   general protection fault in lo_ioctl (2)
>>   https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
>>   #syz dup: INFO: rcu detected stall in blkdev_ioctl
>>
>>   INFO: rcu detected stall in lo_compat_ioctl
>>   https://syzkaller.appspot.com/bug?id=6299555c4e252b53f7a2ae2b8216cc9456c56ac0
>>   #syz dup: INFO: rcu detected stall in blkdev_ioctl
>>
>>   INFO: rcu detected stall in lo_ioctl
>>   https://syzkaller.appspot.com/bug?id=7b49fb610af9cca78c24e9f796f2e8b0d5573997
>>   #syz dup: INFO: rcu detected stall in blkdev_ioctl
>>
>>   INFO: task hung in lo_ioctl
>>   https://syzkaller.appspot.com/bug?id=608144371e7fc2cb6285b9ed871fb1eb817a61ce
>>
>>   INFO: task hung in lo_open (2)
>>   https://syzkaller.appspot.com/bug?id=1f93b57f496d969efb9fb24167f6f9de5ee068fd
>>
>>   possible deadlock in blkdev_reread_part
>>   https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
>>
>>   INFO: task hung in loop_control_ioctl
>>   https://syzkaller.appspot.com/bug?id=61fe32c77ea00412c5149bd34649a65b7f672b5e
>>
>>   WARNING in sysfs_remove_group
>>   https://syzkaller.appspot.com/bug?id=3f86c0edf75c86d2633aeb9dd69eccc70bc7e90b
>>
>>>
>>> > suggest that loop module is not thread safe. The former suggests that
>>> > l->lo_backing_file is forming circular loop and the latter suggests that
>>> > l->lo_backing_file became NULL.
