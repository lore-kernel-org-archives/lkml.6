Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F02C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97832075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97832075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJaASB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:18:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54207 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeJaASB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:18:01 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gHVsC-0003XJ-II
        for linux-kernel@vger.kernel.org; Tue, 30 Oct 2018 15:24:04 +0000
Received: by mail-pl1-f200.google.com with SMTP id j1-v6so9527479pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7X5OM6eM05JKcwiLbw/BtEAqd6PLa8zPq/ba9q3jBjA=;
        b=B4IxU9BhKy57rkwMPAMO+aeKBkeSfVvu1izg1VRP12Fd54NqV/bR2hBWcqrwGzfW/m
         wMqkchITpv2r5qdN96v/3korTYSUmxh+SV+zzjEZZLw74JZH/F2/ARmOfV/XhBMNkKG6
         DT06FdyLmgO6GFJ9NGgIkYKdba+PbgPe1ax9u84r2IWPo+Gg02KbnoPfi4hMCDQT6OQD
         q/lE17fyrWtTK+QVOCuHX9Yxilin0dCqjMQbMSB5iqfmmzyy7/vm4SLq8AnR+ga/nqjr
         0oWezr+QxsOZcaLPApsXtlzoyJXQdwT7ValIiFoUXREiQU768sE0XTD+jx0X5rHaiUCu
         Uw8w==
X-Gm-Message-State: AGRZ1gLioeUiXaqhA4ecgApmw4Vw3mijFpjUr4lJJD5JC7XhBiLv6Guk
        x77FtsQkspdQSkHzJpcorsiJLGBxivgMWGzkZ4P05jp0yjO4cQ8nWdVTzwnzyyHno+Fy0cdx+r+
        Xh/iKVDZEowrK8UMvfWDZRSEsXCXKHavx9bfQQgqAsA==
X-Received: by 2002:a63:2c5:: with SMTP id 188mr1355669pgc.400.1540913043179;
        Tue, 30 Oct 2018 08:24:03 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dvK2Jxn/UbPbaA70IPYuFIsE6M/uQV2rDEf4An4Te7nlm+RxG8qDW+ez9glR7UGWbJk45VWg==
X-Received: by 2002:a63:2c5:: with SMTP id 188mr1355651pgc.400.1540913042733;
        Tue, 30 Oct 2018 08:24:02 -0700 (PDT)
Received: from 2001-b011-380f-1f39-25e6-f27b-5378-368e.dynamic-ip6.hinet.net (2001-b011-380f-1f39-25e6-f27b-5378-368e.dynamic-ip6.hinet.net. [2001:b011:380f:1f39:25e6:f27b:5378:368e])
        by smtp.gmail.com with ESMTPSA id r81-v6sm56623112pfa.110.2018.10.30.08.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 08:24:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 2/4 v5] memstick: Prevent memstick host from getting
 runtime suspended during card detection
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAPDyKFrNBH5jrfF9M_BcTr9JfzAxj0doaQU7V4o5sJRp1=7P4w@mail.gmail.com>
Date:   Tue, 30 Oct 2018 23:23:59 +0800
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3881A95A-CDDE-4C69-859F-C1F92F0C5724@canonical.com>
References: <20181024084958.4627-1-kai.heng.feng@canonical.com>
 <20181024084958.4627-3-kai.heng.feng@canonical.com>
 <CAPDyKFrtQeDUK0Dxu9Z3-eyyMbChHHb2He1AFq2My_7-cTY2FA@mail.gmail.com>
 <E8BC3191-E48C-423C-B704-929F7FAC4930@canonical.com>
 <CAPDyKFrNBH5jrfF9M_BcTr9JfzAxj0doaQU7V4o5sJRp1=7P4w@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 30, 2018, at 21:03, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> On 29 October 2018 at 17:31, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>>> On Oct 29, 2018, at 20:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> 
>>> On 24 October 2018 at 10:49, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>> We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
>>>> helpers to let memstick host support runtime pm.
>>>> 
>>>> There's a small window between memstick_detect_change() and its queued
>>>> work, memstick_check(). In this window the rpm count may go down to zero
>>>> before the memstick host powers on, so the host can be inadvertently
>>>> suspended.
>>>> 
>>>> Increment rpm count before calling memstick_check(), and decrement rpm
>>>> count afterward, as now we are sure the memstick host should be
>>>> suspended or not.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/memstick/core/memstick.c | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>> 
>>>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
>>>> index 76382c858c35..5f16a8826401 100644
>>>> --- a/drivers/memstick/core/memstick.c
>>>> +++ b/drivers/memstick/core/memstick.c
>>>> @@ -18,6 +18,7 @@
>>>> #include <linux/delay.h>
>>>> #include <linux/slab.h>
>>>> #include <linux/module.h>
>>>> +#include <linux/pm_runtime.h>
>>>> 
>>>> #define DRIVER_NAME "memstick"
>>>> 
>>>> @@ -209,6 +210,7 @@ static int memstick_dummy_check(struct memstick_dev *card)
>>>> */
>>>> void memstick_detect_change(struct memstick_host *host)
>>>> {
>>>> +       pm_runtime_get_noresume(host->dev.parent);
>>>>       queue_work(workqueue, &host->media_checker);
>>>> }
>>>> EXPORT_SYMBOL(memstick_detect_change);
>>>> @@ -479,6 +481,8 @@ static void memstick_check(struct work_struct *work)
>>>>               host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
>>>> 
>>>>       mutex_unlock(&host->lock);
>>>> +
>>>> +       pm_runtime_put(host->dev.parent);
>>>>       dev_dbg(&host->dev, "memstick_check finished\n");
>>>> }
>>>> 
>>> 
>>> I am not sure this works, sorry.
>>> 
>>> More precisely, I don't think there is a guarantee that the calls to
>>> pm_runtime_get|put*() becomes properly balanced. In principle
>>> memstick_detect_change() could be called, without actually causing a
>>> new work to be scheduled if there is already such a work in the queue
>>> (depends on the workqueue configuration). Isn't it so?
>> 
>> You are right.
>> 
>> We can use test_and_set_bit() or alike to properly balance pm_runtime
>> helpers, but the most straightforward solution in my mind is to merge
>> memstick_detect_change() and memstick_check() as one function.
>> 
>> memstick_detect_change() it’s the only user of memstick_check() anyway.
> 
> I suspect memstick_detect_change() is supposed to be called by host
> drivers, when they receive some kind of notification due to a card
> being inserted or removed. I guess that happen (at least
> hypothetically) also from atomic (IRQ) context.
> 
> As memstick_check() is doing hole bunch of operations, I am not sure
> bypassing the work-queue is a good idea, if that is what you are
> proposing.

Okay, it’s better to keep it that way.

> 
>> 
>> Or is there a better way in your mind?
> 
> I don't know.
> 
> Well, I am not sure I understand why you need to call
> pm_runtime_get_noresume() from memstick_detect_change() in the first
> place. Could you explain that in more detail?

I guess it didn’t explain it well enough in the log, let me add some detail:
There's a small window between memstick_detect_change() and its queued
work, memstick_check(). In this window the rpm count may go down to zero
before the memstick host powers on, where I use
pm_runtime_get_noresume() to increment the rpm count.

memstick_check() uses some functions in rtsx_usb_ms that have
pm_runtime_put*() so the rpm count may go down to zero, before the
memstick host powers on.

Kai-Heng

> 
> Kind regards
> Uffe

