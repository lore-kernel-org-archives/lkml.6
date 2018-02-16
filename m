Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758574AbeBPQjH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:39:07 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34677 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeBPQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:39:05 -0500
X-Google-Smtp-Source: AH8x226hY7onqTUQ9oj6LF9qQJsCTNmaW0+3CmPs5YwK1/LmxPUOcpB1aijROyS4RVR6lJRQW+YzLjezjZn8ABrHZFQ=
MIME-Version: 1.0
In-Reply-To: <5bfec26e-b09c-2fa0-4eb0-3f9a08d293ed@ginzinger.com>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
 <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com> <5bfec26e-b09c-2fa0-4eb0-3f9a08d293ed@ginzinger.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 16 Feb 2018 17:38:43 +0100
Message-ID: <CAH9NwWeKXnA21-eUHUJ74SfdT_303USn8e36OFNhhm=g1SrDew@mail.gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: ar1021_i2c: enable touch mode
 during open
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-05 11:40 GMT+01:00 Martin Kepplinger <martin.kepplinger@ginzinger.com>:
>
>
>
>
> Martin Kepplinger | Entwicklung Software
>
> GINZINGER ELECTRONIC SYSTEMS GMBH
>
> Tel.: +43 7723 5422 157
> Mail: martin.kepplinger@ginzinger.com
> Web: www.ginzinger.com
>
>
>
>
> On 2018-02-05 11:07, Christian Gmeiner wrote:
>> Hi all.
>>
>> 2017-04-27 14:22 GMT+02:00 Martin Kepplinger <martin.kepplinger@ginzinger.com>:
>>> The device could as well be in command mode, in which this driver cannot
>>> handle the device. When opening the device, let's make sure the device
>>> will be in the mode we expect it to be for this driver.
>>>
>>
>> I run into issues caused by this change. It turns out that the device
>> is non-functional
>> after some warm-reboots and as a result I am not able to use xorg's
>> evdev driver.
>> So I have some questions about this change:
>>
>> * Should we enable irq before calling i2c_master_send(..) as the chip raises an
>>   irq if the command was processed?
>>
>> * Would it be enough to send this command only once during driver
>> lifetime? I can
>>   see that on my system open gets called 3 times during boot-up.
>
> It would. See below for my thought on this change.
>
>>
>> * What are the circumstances the touch device would be in an other state? In the
>>   official kernel driver the userspace can send commands via sysfs.
>> Also the driver
>>   does set the touch enable mode as this patch does.
>
> I did this change as the device was once non-functional unexpectedly
> because it wasn't in touch mode. We can set touch mode during open() or
> probe() but I figured during open() would keep the driver working even
> when others would use the device in command mode.
>
> Does your problem go away when you revert this change or put it into
> probe()?

I needed to postprone further research and reverted this commit locally as
a new software release gets releases soon. The good this that I have
an automated way to run a test to trigger this issue quite easily.

Will have a deeper look after release time.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info
