Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23755C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D040020B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RqhO1xDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D040020B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbeGJSqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:46:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51597 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732386AbeGJSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:46:08 -0400
Received: by mail-it0-f67.google.com with SMTP id g4-v6so119852iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=771ERV0PGNR2a0rLchz/sT9UbhE7A2XRM0u2JZ5Jy0g=;
        b=RqhO1xDFbkeS5iJzHAm4O777/1Iv/HWYD3cB5aO7eEe8dEfELs0AWAyr7lFNkC/ssF
         YOXYOcpO9ADuGs7PE48/RSp+bvcl3jQVEE0/U0Hhfg6aRQjLzTno8/zW2GctZYoNyflS
         hlSjc8Ek+9W/53tozulASPFa7+OOCG/h1mTP7dRlovPAUJoWmdM3EU35NACj2YQi7321
         cc/ED6pMp6oAXBqQRtaUoxpLzm/m5NamG6rbcBmvmCsaa5+R9wDYDEWTiredxVh+Rg2f
         LZ+CBQXhr9P0MCC0df1xez6psAmQyqv1aV3QAtDr8GSe9RP2N+kgbrtusMEL32QfVBMM
         o/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=771ERV0PGNR2a0rLchz/sT9UbhE7A2XRM0u2JZ5Jy0g=;
        b=f/Om24mLgTtiYOlYmcFKBy3uoHaHmH08IS5OchNGI7y+xXIfWv0rIxvXnIVhBQlvsX
         diU9AoKWQZx8BfXGMWrDlbSM3Cbq/tUh7S7BUmwfQSEb/v7Nf7wCWiJbi3y7onPy6KXm
         mcyszv+3isDEz0cE33hmGjIiA67MqMi4N6nmRLWa0zfIjaYON9ZFRkTqD0qObxQWT7O3
         pg1HUWGmhuMKe5jkdQTNfPUzFerEkYGMMf5TMPHqOQZ2aIDZ0VxtAwSXjG6b8h068cYx
         M9xpDaRK5lXSFWu+Je9h3Wkf79johkFoLxLlIGOSwqTbYssgGeQeXZIDSXsDjr8GHfz8
         Dq8Q==
X-Gm-Message-State: APt69E0fH4qyZiptCF/GQdq7oTwwuoP3PFHL/2esGdAja30e58sGPYE3
        +JQVuNpdNZyUId2JDwHjGr20OA==
X-Google-Smtp-Source: AAOMgpe0xIlyk49aBifTJcEGqJuDsIYO6CQ5oHM1zXfdPEy6UInQX0ox3jZE4SqDES/5npJTRiwTBA==
X-Received: by 2002:a02:6a1f:: with SMTP id l31-v6mr22168717jac.7.1531248351123;
        Tue, 10 Jul 2018 11:45:51 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id s125-v6sm8379693iod.18.2018.07.10.11.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 11:45:49 -0700 (PDT)
Subject: Re: [PATCH 0/2] null_blk: zone support
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "loberman@redhat.com" <loberman@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
 <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
 <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
 <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
 <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
Date:   Tue, 10 Jul 2018 12:45:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/18 10:47 AM, Bart Van Assche wrote:
> On Tue, 2018-07-10 at 08:46 -0600, Jens Axboe wrote:
>> On 7/9/18 6:05 PM, Bart Van Assche wrote:
>>> On Mon, 2018-07-09 at 10:34 -0600, Jens Axboe wrote:
>>>> In the spirit of making some progress on this, I just don't like how
>>>> it's done. For example, it should not be necessary to adjust what
>>>> comes out of the block generator, instead the block generator should
>>>> be told to do what we need on zbc. This is a key concept. The workload
>>>> should be defined as such that it works for zoned devices.
>>>
>>> How would you like to see block generation work? I don't see an
>>> alternative for random I/O other starting from the output of a random
>>> generator and translating that output into something that is
>>> appropriate for a zoned block device. Random reads must happen below
>>> the zone pointer if fio is configured to read below the zone pointer.
>>> Random writes must happen at the write pointer. The only way I see to
>>> implement such an I/O pattern is to start from the output of a random
>>> generator and to adjust the output of that random generator. However,
>>> I don't have a strong opinion whether adjusting the output of a random
>>> generator should happen by the caller of get_next_buflen() or inside
>>> get_next_buflen(). Or is your concern perhaps that the current
>>> approach interferes with fio job options like bs_unaligned?
>>
>> The main issue I have with that approach is that the core of fio is
>> generating the IO patterns, and then you are just changing them as you
>> see fit. This means that the workload definition and the resulting IO
>> operations are no longer matched up, since they now also depend on what
>> you are running on. If I take one workload and run it on a zoned drive,
>> and then run it on a non-zoned drive, I can't compare the results at
>> all. This is a showstopper.
>>
>> There should be no adjusting of the output, rather it should be possible
>> to write zoned friendly job definitions. It should be possible to run
>> the same job on a non-zoned drive, and vice versa, and the resulting IO
>> patterns must be the same.
>>
>> Fio already has some notion of zones. Maybe that could be extended to
>> hard zones, and some control of open zones, and patterns within those
>> zones?
> 
> Hello Jens,
> 
> How about adding a job option that makes it possible to use the zoned
> block device (ZBD) I/O pattern on non-ZBD devices, requiring that the
> zone size is set explicitly for non-ZBD devices and maintaining a write
> pointer not only when performing I/O to a ZBD device but also if a
> ZBD-style I/O pattern is applied to a non-ZBD disk? This should allow to
> apply exactly the same workload to a non-ZBD disk as to a ZBD disk.

It just doesn't make any sense to me. The source of truth is the
generator of the IO, which does exactly what it is told by the job
definition. You're proposing to mangle that somehow, to fit some
restrictions that the underlying device has. That very concept is
foreign, and adding an option to be able to do the same on some other
device is misleading. The difference between the job file and the
workload run can be huge. Consider something really basic:

[randwrites]
bs=4k
rw=randwrite

which would be 100% random 4k writes. If I run this on a zoned device,
then that'd turn into 100% sequential writes. That makes no sense at
all. And if I run it on a different devices, I'd get 100% random writes.
Except if I set some magic option. Sorry, but that concept is just too
ugly to live, it makes zero sense. Put down your zoned hat for a bit and
think about it.

> What I derived from the fio source code is as follows (please correct me
> if I got anything wrong):
> * The purpose of the zonesize, zonerange and zoneskip job options is to
>   limit the I/O range to a single zone with size "zonesize". The I/O
>   pattern for zoned block devices is different: I/O happens in multiple
>   zones simultaneously. The number of zones to which I/O happens is
>   called the number of open zones.

The only difference is that fio currently only has one zone active. When
it finishes one, it goes to the next. See my above suggestion on adding
the notion of open zones, which would extend this to more than 1.

> * The purpose of the random_distribution=zoned{_abs} job option is to
>   allow the user to skew a uniform random distribution. This is another
>   workload pattern than the typical pattern for ZBD drives.

Fio's zones were never intended to be for zoned devices. Don't get hung
up on current use cases, think about what kind of definitions would make
sense for zoned devices.

-- 
Jens Axboe

