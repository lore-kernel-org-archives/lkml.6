Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65487C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9C42075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRfZW6wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfBVMiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:38:13 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41849 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:38:13 -0500
Received: by mail-lf1-f43.google.com with SMTP id e27so1579107lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DnW/W4dtOxfMPKnfilGG+xd2jeKBqXzgWob1J9q+tZ4=;
        b=eRfZW6wzhbsWAetq2b0z5+mSx3cAXzTG8oHe0c3P0SHZ8UdrInsJ4H3I6GROBuvsUp
         3Mif5y/fQm6LEw0cKVR8HKsnJQNe6T8bJLh5H8kpX2OIlLjr+pkclrO83JLRgLrl2K+q
         BIGqaeGeaQ2ezZbkWtHQJu2L5Hf68CaXhEyPbAliZtOX4oc2SCOs7quAhbh71elkNboc
         8OGHJXCYWwnFDvhINhlpvEjXAz25o8YGxomlLt86KAiIKFXS9uZ0CQZWK2qDRyH6vsG2
         x3QaisZRC3nwMxMbjS077EISBMrXcLmA7614tdQDDeOGXsQIP24PcxVNacfuao3wMMNg
         15Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DnW/W4dtOxfMPKnfilGG+xd2jeKBqXzgWob1J9q+tZ4=;
        b=qc3aMzTWC0Idrdq3DnhVf12P3NzArt1ap+snwGf8hOLPnxZJkdlhnHXzSowjikmeHD
         frH4XUfXZNhVqAV6x9TTto9QotJ9/HU4YWm1HU2sH1+lMvF9FyoQ/5EgIHaRjUUkojGx
         XjN1GNILilunHAz/KugF0sQBqDGHGc7eB7V2vPpu0Io9A0IqQnLY1wF+mFa0tvO3/wXb
         O4vbb7nOCBpijsrtPFlBELCKpgIf0u6+l7geTc29Ye6Ua8g+VNuuatadG6juAdtDdt5W
         NCuPloE17OZDEu7LEb0RrUwTrbccJi0ZTyg8yRsnAyOFSiGoDxGLqlExohNr9EoCWBNN
         +/pQ==
X-Gm-Message-State: AHQUAubf45iVEhPqKio0uC8lHmFqa4S38BUvj3L28DzE30Nvlh41TXW8
        SAeqNU5pamjX/QU6VOR698w=
X-Google-Smtp-Source: AHgI3IZqnc4Ez3kPzERLE79L7wFDeE41Q3fH7/KuSii/EEHia0+UWCcaOulpyVRfBeO7dh4cLNkFEw==
X-Received: by 2002:a19:4847:: with SMTP id v68mr2219759lfa.136.1550839089536;
        Fri, 22 Feb 2019 04:38:09 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id w3sm559066lfe.18.2019.02.22.04.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:38:08 -0800 (PST)
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
To:     Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dave P Martin <dave.martin@arm.com>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
Date:   Fri, 22 Feb 2019 14:38:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 10:46 PM, Julien Grall wrote:
> (+ Andrew and Jan for feedback on the event channel interrupt)
>
> Hi Boris,
>
> Thank you for the your feedback.
>
> On 2/20/19 8:04 PM, Boris Ostrovsky wrote:
>> On 2/20/19 1:05 PM, Julien Grall wrote:
>>> Hi,
>>>
>>> On 20/02/2019 17:07, Boris Ostrovsky wrote:
>>>> On 2/20/19 9:15 AM, Julien Grall wrote:
>>>>> Hi Boris,
>>>>>
>>>>> Thank you for your answer.
>>>>>
>>>>> On 20/02/2019 00:02, Boris Ostrovsky wrote:
>>>>>> On Tue, Feb 19, 2019 at 05:31:10PM +0000, Julien Grall wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I have been looking at using Linux RT in Dom0. Once the guest is
>>>>>>> started,
>>>>>>> the console is ending to have a lot of warning (see trace below).
>>>>>>>
>>>>>>> After some investigation, this is because the irq handler will now
>>>>>>> be threaded.
>>>>>>> I can reproduce the same error with the vanilla Linux when passing
>>>>>>> the option
>>>>>>> 'threadirqs' on the command line (the trace below is from 5.0.0-rc7
>>>>>>> that has
>>>>>>> not RT support).
>>>>>>>
>>>>>>> FWIW, the interrupt for port 6 is used to for the guest to
>>>>>>> communicate with
>>>>>>> xenstore.
>>>>>>>
>>>>>>>    From my understanding, this is happening because the interrupt
>>>>>>> handler is now
>>>>>>> run in a thread. So we can have the following happening.
>>>>>>>
>>>>>>>       Interrupt context            |     Interrupt thread
>>>>>>>                                    |
>>>>>>>       receive interrupt port 6     |
>>>>>>>       clear the evtchn port        |
>>>>>>>       set IRQF_RUNTHREAD            |
>>>>>>>       kick interrupt thread        |
>>>>>>>                                    |    clear IRQF_RUNTHREAD
>>>>>>>                                    |    call evtchn_interrupt
>>>>>>>       receive interrupt port 6     |
>>>>>>>       clear the evtchn port        |
>>>>>>>       set IRQF_RUNTHREAD           |
>>>>>>>       kick interrupt thread        |
>>>>>>>                                    |    disable interrupt port 6
>>>>>>>                                    | evtchn->enabled = false
>>>>>>>                                    |    [....]
>>>>>>>                                    |
>>>>>>>                                    |    *** Handling the second
>>>>>>> interrupt ***
>>>>>>>                                    |    clear IRQF_RUNTHREAD
>>>>>>>                                    |    call evtchn_interrupt
>>>>>>>                                    |    WARN(...)
>>>>>>>
>>>>>>> I am not entirely sure how to fix this. I have two solutions in 
>>>>>>> mind:
>>>>>>>
>>>>>>> 1) Prevent the interrupt handler to be threaded. We would also
>>>>>>> need to
>>>>>>> switch from spin_lock to raw_spin_lock as the former may sleep on
>>>>>>> RT-Linux.
>>>>>>>
>>>>>>> 2) Remove the warning
>>>>>>
>>>>>> I think access to evtchn->enabled is racy so (with or without the
>>>>>> warning) we can't use it reliably.
>>>>>
>>>>> Thinking about it, it would not be the only issue. The ring is sized
>>>>> to contain only one instance of the same event. So if you receive
>>>>> twice the event, you may overflow the ring.
>>>>
>>>> Hm... That's another argument in favor of "unthreading" the handler.
>>>
>>> I first thought it would be possible to unthread it. However,
>>> wake_up_interruptible is using a spin_lock. On RT spin_lock can sleep,
>>> so this cannot be used in an interrupt context.
>>>
>>> So I think "unthreading" the handler is not an option here.
>>
>> That sounds like a different problem. I.e. there are two issues:
>> * threaded interrupts don't work properly (races, ring overflow)
>> * evtchn_interrupt() (threaded or not) has spin_lock(), which is not
>> going to work for RT
>
> I am afraid that's not correct, you can use spin_lock() in threaded 
> interrupt handler.
>
>> The first can be fixed by using non-threaded handlers.
>
> The two are somewhat related, if you use a non-threaded handler then 
> you are not going to help the RT case.
>
> In general, the unthreaded solution should be used in the last resort.
>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Another alternative could be to queue the irq if !evtchn->enabled 
>>>>>> and
>>>>>> handle it in evtchn_write() (which is where irq is supposed to be
>>>>>> re-enabled).
>>>>> What do you mean by queue? Is it queueing in the ring?
>>>>
>>>>
>>>> No, I was thinking about having a new structure for deferred 
>>>> interrupts.
>>>
>>> Hmmm, I am not entirely sure what would be the structure here. Could
>>> you expand your thinking?
>>
>> Some sort of a FIFO that stores {irq, data} tuple. It could obviously be
>> implemented as a ring but not necessarily as Xen shared ring (if that's
>> what you were referring to).
>
> The underlying question is what happen if you miss an interrupt. Is it 
> going to be ok? If no, then we have to record everything and can't 
> kill/send an error to the user app because it is not its fault.
>
> This means a FIFO would not be a viable. How do you size it? Static 
> (i.e pre-defined) size is not going to be possible because you don't 
> know how many interrupt you are going to receive before the thread 
> handler runs. You can't make it grow dynamically as it make become 
> quite big for the same reason.
>
> Discussing with my team, a solution that came up would be to introduce 
> one atomic field per event to record the number of event received. I 
> will explore that solution tomorrow.
How will this help if events have some payload?
>
> Cheers,
>

