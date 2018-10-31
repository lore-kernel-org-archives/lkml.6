Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7712C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAAE20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAAE20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbeJaPaY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:30:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42763 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbeJaPaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:30:24 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gHk4P-0004W4-9o
        for linux-kernel@vger.kernel.org; Wed, 31 Oct 2018 06:33:37 +0000
Received: by mail-pl1-f197.google.com with SMTP id b8-v6so5311421pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 23:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Apiv5i+AJV7VrbgWF+5WZYvpAKZUycc1AftIz7iCGtk=;
        b=XJ4wRFM3PUrLyXGXxp8e9KfRtl26mWY8NJ4JcZWaIuc/DQBeVbFrbMTW+nuBxezX3C
         3KoMbC7D+IsxFy2yNkB79lafXdXdPnkBMgla+4EbTMbyC08wbgLizTzqxL1bLds8Eli9
         CIEjQKtCMVE5JWWFZ1Wf+KnZW7+pJ+mXy1xPxenIhg7M7UKXSU/N0xyAFeFR0q7MfxM6
         J2/kYbncNS1JQHkUUHO7fvv0rqA7UMxrDmtrivuFkI5MEsdXd7manU48Sz4IwzJ9qofB
         +0s0UQ8U9Ms1GMwfZS3zogsy1d5MEWIA1m0UXKgl7nnEgGcKj2KrFFhKYqx4ObXCG0rY
         V5Jg==
X-Gm-Message-State: AGRZ1gJcENeEUhG/0NY/cgFcDMk/8Cr9FLTqKDim4BYARm1ldGSRIt3z
        Pe53schA5sveLDQXcr4UgvsJJPlbSLn2tZsNtF9Zem4ABTppM0gVXraqZlHmGMEJ9xPvF5NJjHm
        yzWyuuyKJGv0eLXi4+U246WZs1Wa4lcchS+LB4njYng==
X-Received: by 2002:a63:f30d:: with SMTP id l13mr1876534pgh.399.1540967615769;
        Tue, 30 Oct 2018 23:33:35 -0700 (PDT)
X-Google-Smtp-Source: AJdET5fkClli24OaMp2blR/tSIBdKsD1i8u8ByJsQg0s1wDbm3oIrOzf8mBCher6FwVh0IiJPVHJgg==
X-Received: by 2002:a63:f30d:: with SMTP id l13mr1876513pgh.399.1540967615370;
        Tue, 30 Oct 2018 23:33:35 -0700 (PDT)
Received: from [10.101.46.95] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id a11-v6sm29561465pfn.66.2018.10.30.23.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 23:33:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 2/4 v5] memstick: Prevent memstick host from getting
 runtime suspended during card detection
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAPDyKFqQiT=mSw3yo_0nx0mpXCWC0tggxvWYMtEqatB-U=b9yQ@mail.gmail.com>
Date:   Wed, 31 Oct 2018 14:33:32 +0800
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <39EAB186-BE6B-4CB2-B9EE-88B0C267888A@canonical.com>
References: <20181024084958.4627-1-kai.heng.feng@canonical.com>
 <20181024084958.4627-3-kai.heng.feng@canonical.com>
 <CAPDyKFrtQeDUK0Dxu9Z3-eyyMbChHHb2He1AFq2My_7-cTY2FA@mail.gmail.com>
 <E8BC3191-E48C-423C-B704-929F7FAC4930@canonical.com>
 <CAPDyKFrNBH5jrfF9M_BcTr9JfzAxj0doaQU7V4o5sJRp1=7P4w@mail.gmail.com>
 <3881A95A-CDDE-4C69-859F-C1F92F0C5724@canonical.com>
 <CAPDyKFqQiT=mSw3yo_0nx0mpXCWC0tggxvWYMtEqatB-U=b9yQ@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 31, 2018, at 12:04 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> On 30 October 2018 at 16:23, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>>> On Oct 30, 2018, at 21:03, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> 
>>> On 29 October 2018 at 17:31, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> 
>>>>> On Oct 29, 2018, at 20:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>> 
>>>>> On 24 October 2018 at 10:49, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>>>> We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
>>>>>> helpers to let memstick host support runtime pm.
>>>>>> 
>>>>>> There's a small window between memstick_detect_change() and its queued
>>>>>> work, memstick_check(). In this window the rpm count may go down to zero
>>>>>> before the memstick host powers on, so the host can be inadvertently
>>>>>> suspended.
>>>>>> 
>>>>>> Increment rpm count before calling memstick_check(), and decrement rpm
>>>>>> count afterward, as now we are sure the memstick host should be
>>>>>> suspended or not.
>>>>>> 
>>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>> ---
>>>>>> drivers/memstick/core/memstick.c | 4 ++++
>>>>>> 1 file changed, 4 insertions(+)
>>>>>> 
>>>>>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
>>>>>> index 76382c858c35..5f16a8826401 100644
>>>>>> --- a/drivers/memstick/core/memstick.c
>>>>>> +++ b/drivers/memstick/core/memstick.c
>>>>>> @@ -18,6 +18,7 @@
>>>>>> #include <linux/delay.h>
>>>>>> #include <linux/slab.h>
>>>>>> #include <linux/module.h>
>>>>>> +#include <linux/pm_runtime.h>
>>>>>> 
>>>>>> #define DRIVER_NAME "memstick"
>>>>>> 
>>>>>> @@ -209,6 +210,7 @@ static int memstick_dummy_check(struct memstick_dev *card)
>>>>>> */
>>>>>> void memstick_detect_change(struct memstick_host *host)
>>>>>> {
>>>>>> +       pm_runtime_get_noresume(host->dev.parent);
>>>>>>      queue_work(workqueue, &host->media_checker);
>>>>>> }
>>>>>> EXPORT_SYMBOL(memstick_detect_change);
>>>>>> @@ -479,6 +481,8 @@ static void memstick_check(struct work_struct *work)
>>>>>>              host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
>>>>>> 
>>>>>>      mutex_unlock(&host->lock);
>>>>>> +
>>>>>> +       pm_runtime_put(host->dev.parent);
>>>>>>      dev_dbg(&host->dev, "memstick_check finished\n");
>>>>>> }
>>>>>> 
>>>>> 
>>>>> I am not sure this works, sorry.
>>>>> 
>>>>> More precisely, I don't think there is a guarantee that the calls to
>>>>> pm_runtime_get|put*() becomes properly balanced. In principle
>>>>> memstick_detect_change() could be called, without actually causing a
>>>>> new work to be scheduled if there is already such a work in the queue
>>>>> (depends on the workqueue configuration). Isn't it so?
>>>> 
>>>> You are right.
>>>> 
>>>> We can use test_and_set_bit() or alike to properly balance pm_runtime
>>>> helpers, but the most straightforward solution in my mind is to merge
>>>> memstick_detect_change() and memstick_check() as one function.
>>>> 
>>>> memstick_detect_change() it’s the only user of memstick_check() anyway.
>>> 
>>> I suspect memstick_detect_change() is supposed to be called by host
>>> drivers, when they receive some kind of notification due to a card
>>> being inserted or removed. I guess that happen (at least
>>> hypothetically) also from atomic (IRQ) context.
>>> 
>>> As memstick_check() is doing hole bunch of operations, I am not sure
>>> bypassing the work-queue is a good idea, if that is what you are
>>> proposing.
>> 
>> Okay, it’s better to keep it that way.
>> 
>>> 
>>>> 
>>>> Or is there a better way in your mind?
>>> 
>>> I don't know.
>>> 
>>> Well, I am not sure I understand why you need to call
>>> pm_runtime_get_noresume() from memstick_detect_change() in the first
>>> place. Could you explain that in more detail?
>> 
>> I guess it didn’t explain it well enough in the log, let me add some detail:
>> There's a small window between memstick_detect_change() and its queued
>> work, memstick_check(). In this window the rpm count may go down to zero
>> before the memstick host powers on, where I use
>> pm_runtime_get_noresume() to increment the rpm count.
>> 
>> memstick_check() uses some functions in rtsx_usb_ms that have
>> pm_runtime_put*() so the rpm count may go down to zero, before the
>> memstick host powers on.
> 
> So then, why doesn't memstick_check() early on calls
> pm_runtime_get_sync() and when it has finished with probing for a
> card, balance that with a call pm_runtime_put()?

This will do, not sure what I was thinking. Thanks for pointing out.

Kai-Heng

> 
> Kind regards
> Uffe

