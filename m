Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A13C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7641D20883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ljTooiTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7641D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeKHAQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:16:36 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34744 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeKHAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:16:36 -0500
Received: by mail-io1-f65.google.com with SMTP id d80-v6so12078851iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5HtoEEObkIbud56Wa3SqTaoQbCyHLlq31Jxs9qh14aI=;
        b=ljTooiTTEcSfTTWoun1kg/asmDKrlz9HLUytOVsRRHKm+qhrNSQUK4V8VYPGr4izth
         sZu9kW57euF4mGEB8uBYR6ZgmdPdD5Ev6rgaZpYoKpyRyYgCeMxf2h6NB1giax3iOM+y
         MBhTMpQ1br4y7nQ6ck1eLBZuymiP0cCwHQL0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5HtoEEObkIbud56Wa3SqTaoQbCyHLlq31Jxs9qh14aI=;
        b=j+rW73fEHw0HwwnxM/TaXjiEh5GvO2xbcmcWfBWU2w/0Ezt+UY3rtahK+A7l4Cl1Rf
         m/Ao8VN/Gq/Pa/ov1OZoQ3OLwNv65vP5wrtGDCj1+vMxgOo8YIRmxPMptJDn/T/IBUlr
         mbCQ9Uhlmc7gYM7D5bj0SVCUqTcCTvR+HaCIyt/R0VpJJCdxyRaJmyA4Rf60YtpvFSiR
         2kRwVq3ZWWwD2anPvAhDsFSWPKA3bOwfOKopfBtuOjYDY6cnQCGWwzt+OSvPAISVVx0w
         VcTymeDzxUfNQ4uBWdNUlXUcXuRG34YqIAvU06iwe7Y7IIbeYkV4FYxKDU7SprmAHg12
         uQGg==
X-Gm-Message-State: AGRZ1gJiUZvSOPLbN5zaoQqde46Dde01YMN7Cw/MDqhEXIqzt1AAWY5U
        fxUM3PrjksymqMFNRAZ14/oTJ18XSzrM+WeNHLnLcQ==
X-Google-Smtp-Source: AJdET5evCp3pnMR6jHYFU0EQCzirTJ/+c9roqkqfnUjvo8F0EPImuMkq+QkK5UfqrGaXuOvEbs2ibY9L/wpmlivqbrc=
X-Received: by 2002:a5e:8b42:: with SMTP id z2-v6mr377479iom.144.1541601956953;
 Wed, 07 Nov 2018 06:45:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 06:45:55 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <6f27b5a5-0092-b23f-b28e-341ae093a241@virtuozzo.com>
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
 <154149666097.17764.12092615786683141764.stgit@localhost.localdomain>
 <CAJfpeguDTsG7vEAhH=CHp43vJak70VzR8YH8K6=vZAUXCZZeEQ@mail.gmail.com> <6f27b5a5-0092-b23f-b28e-341ae093a241@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 15:45:55 +0100
Message-ID: <CAJfpegtbwfioa0gv4j1SoRu3X8vX3kZUQC=QJo=dcfOD2OjKzw@mail.gmail.com>
Subject: Re: [PATCH 6/6] fuse: Verify userspace asks to requeue interrupt that
 we really sent
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 3:25 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 07.11.2018 16:55, Miklos Szeredi wrote:
>> On Tue, Nov 6, 2018 at 10:31 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>> When queue_interrupt() is called from fuse_dev_do_write(),
>>> it came from userspace directly. Userspace may pass any
>>> request id, even the request's we have not interrupted
>>> (or even background's request). This patch adds sanity
>>> check to make kernel safe against that.
>>
>> Okay, I understand this far.
>>
>>> The problem is real interrupt may be queued and requeued
>>> by two tasks on two cpus. This case, the requeuer has not
>>> guarantees it sees FR_INTERRUPTED bit on its cpu (since
>>> we know nothing about the way userspace manages requests
>>> between its threads and whether it uses smp barriers).
>>
>> This sounds like BS. There's an explicit  smp_mb__after_atomic()
>> after the set_bit(FR_INTERRUPTED,...).  Which means FR_INTERRUPTED is
>> going to be visible on all CPU's after this, no need to fool around
>> with setting FR_INTERRUPTED again, etc...
>
> Hm, but how does it make the bit visible on all CPUS?
>
> The problem is that smp_mb_xxx() barrier on a cpu has a sense
> only in pair with the appropriate barrier on the second cpu.
> There is no guarantee for visibility, if second cpu does not
> have a barrier:
>
>   CPU 1                  CPU2                        CPU3                       CPU4                        CPU5
>
>   set FR_INTERRUPTED     set FR_SENT
>   <smp mb>               <smp mb>
>   test FR_SENT (== 0)    test FR_INTERRUPTED (==1)
>                          list_add[&req->intr_entry]  read[req by intr_entry]
>                                                      <place to insert a barrier>
>                                                      goto userspace
>                                                      write in userspace buffer
>                                                                                 read from userspace buffer
>                                                                                 write to userspace buffer
>                                                                                                              read from userspace buffer
>                                                                                                              enter kernel
>                                                                                                              <place to insert a barrier>
>                                                                                                              test FR_INTERRUPTED <- Not visible
>
> The sequence:
>
> set_bit(FR_INTERRUPTED, ...)
> smp_mb__after_atomic();
> test_bit(FR_SENT, &req->flags)
>
> just guarantees the expected order on CPU2, which uses <smp mb>,
> but CPU5 does not have any guarantees.

What you are missing is that there are other things that synchronize
memory access besides the memory barrier.  In your example the
ordering will be guaranteed by the fiq->waitq.lock in
queue_interrupt() on CPU2: the set_bit() cannot move past the one-way
barrier provided by the spin_unlock().

Thanks,
Miklos
