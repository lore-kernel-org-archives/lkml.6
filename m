Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6963C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A9920877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A08x7IxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A9920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJEEV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:21:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52907 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeJEEV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:21:59 -0400
Received: by mail-it1-f193.google.com with SMTP id 134-v6so15210578itz.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lPuu3zvQx+tmy55+1lMJjtvhEJ58PYofg3LhN4bHqwI=;
        b=A08x7IxQBhch9W99eLxMTw7mBMETdsF9+LW+kHA/tnSuhGP6NXqCFzSjjjiRaYZfJY
         2mVb2M1QZDlLE27V72E0JgzpNa8H199M26GRyGn8NB1474sK15WFBL0dDuZrlRcwBB11
         XMOOY/SZ3PNleCRCJg67CguSEBY0kt4OMDkls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lPuu3zvQx+tmy55+1lMJjtvhEJ58PYofg3LhN4bHqwI=;
        b=Owcb81VmbYM3jgEI/sMMl1G/T8hDMPLGgJUU2lX/NjbkoyLK6JO3o90Lq3wmcrpxUS
         tkBDTknXaY6SZtYQZFNnOFAXl/eRzXzIfTSZLS2GxkQx2Ditv8I19yTZGCaykQyZ4jys
         MV7Eldo5wOpFk5HTw4S0h+4HbDrqPVJaib47OgIVORvltGMP234IIfwsa+/D2EdPyA9Y
         yzIHZMQrVpvDP8IZrb2z2KorPSFgp2yCQ5YP1Oz61rO01deXtuzym1z29WczwSvKvYT/
         vGI4PIv3qCpD17+iduknDooX6+Jm4rVTjHG3z+8taPA5f70QKpdvqZlQqVp8V4lFtgW8
         PYTg==
X-Gm-Message-State: ABuFfoiUg4dMznTf6xakEC44I6gokSG0BF5KF6QyiQ1D4gqvWTCktHKU
        ZONYK9oYmAH+7uYw38FIBTbWlmuIsegAZKqQ02XqQw==
X-Google-Smtp-Source: ACcGV6222958fm6MBhgJqNscup95P8xI+mLAw79SZSdwvRNpMGv89HkLsLSiOhL1loGOfpQZbRie751cjpKdRM5KMmc=
X-Received: by 2002:a24:8045:: with SMTP id g66-v6mr6722327itd.45.1538688406562;
 Thu, 04 Oct 2018 14:26:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 14:26:06 -0700 (PDT)
In-Reply-To: <CAJZ5v0jqb1iScje5PajN7F5EL4SQ0oMd4gFhss+=vYRHnogVhA@mail.gmail.com>
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
 <CAJZ5v0ih4Hn5W-dTzOayMyMfLMe=djKVhxBcoQ=7oJz6QnpTJQ@mail.gmail.com>
 <CAPDyKFqMHVvyrjDzoC+QbSLbtdMYcfzDenb+uWTu+Fr-awbU1A@mail.gmail.com> <CAJZ5v0jqb1iScje5PajN7F5EL4SQ0oMd4gFhss+=vYRHnogVhA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 23:26:06 +0200
Message-ID: <CAPDyKFq0OyXvcCFOOY4+3+_gu+rRnMYkQd5okqx99xoBwBKK2Q@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Al Cooper <alcooperx@gmail.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 October 2018 at 22:57, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Oct 4, 2018 at 8:48 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 4 October 2018 at 19:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Thu, Oct 4, 2018 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >>
>> >> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> >
>> >> > If __device_suspend() returns early on an error or pending wakeup
>> >> > and the power.direct_complete flag has been set for the device
>> >> > already, the subsequent device_resume() will be confused by it
>> >> > and it will call pm_runtime_enable() incorrectly, as runtime PM
>> >> > has not been disabled for the device by __device_suspend().
>> >>
>> >> I think it would be fair to mention that is related to the async
>> >> suspend path, in dpm_suspend().
>> >
>> > OK, fair enough.
>> >
>> >> >
>> >> > To avoid that, clear power.direct_complete if __device_suspend()
>> >> > is not going to disable runtime PM for the device before returning.
>> >>
>> >> Overall, by looking at the behavior in dpm_suspend() of async
>> >> suspended devices, it does look a bit fragile to me.
>> >>
>> >> My worries is that we put asynced suspended devices in the
>> >> dpm_suspended_list, no matter if the device was successfully suspended
>> >> or not. This differs from the no-async path.
>> >
>> > That's because this was the most straightforward way to organize that
>> > (otherwise you need to worry about the list locking with respect to
>> > the async suspends etc and you really need to preserve the ordering
>> > there).
>>
>> I understand about the lock, but not sure if that is something to
>> worry about, at least from contention point of view, if that is what
>> you mean?
>
> The contention may not be a problem, but there would be some extra
> overhead related to the dragging of the lock cache line between CPUs.
>
>> In regards to the order, is that really problem for async enabled devices?
>
> You may be underestimating the problem somewhat.
>
> For example, say you have 4 devices, A which is the parent of B and C,
> and D which is a child of C.  Say that D depends on B too, but it
> cannot be a child of it and there's no device link between B and D.
> [For instance, the driver of A has registered both B and C, and the
> driver of C has registered D, but it doesn't know about the dependency
> between D and B.]  Also say that A, B and C are all async, but D is
> sync and all A, B, C are before D in the original list order.
>
> dpm_suspend() will get to A, B and C only after dealing with D.  It
> will then start to suspend B and C almost at the same time and A will
> wait for both of them.  So far so good.
>
> Next, A will resume first, B and C after it, and D after C.  Say that
> B is somewhat faster to resume, but it actually adds itself back to
> the list after C and D (as they don't wait for it).  The resume of C
> and D succeeds (because B is already there physically), but the
> ordering of the list is now A->C->D->B and there will be trouble
> during the next suspend, because B will be suspending in parallel with
> D which depends on it.
>
> In this case you have to guarantee that D and B will not be reordered,
> but it generally is hard without an explicit "link" between them -
> unless the original ordering of the list is preserved entirely.

Thanks for the detailed description!

My naive approach was simply that these cases should not exist. Those
drivers that opt-in for the async method, must be very careful when
doing so. However, you certainly have a point that this may not be the
case.

>
>> >
>> >> In the long run, maybe we should change that instead?
>> >
>> > Is there anything wrong with it really?
>>
>> No, besides complexity. :-)
>
> And how exactly are you measuring the "complexity" here?
>
>> My, point was that we could potentially simplify the code in
>> device_resume() and in __device_suspend(), as the behavior would them
>> becomes more deterministic.
>
> No, it wouldn't be more deterministic.  In fact, it would then become
> less deterministic and provably so if you take consecutive
> suspend-resume cycles into account.  In principle, the order in which
> devices are handled might be different every time then and sorry, but
> I'm failing to see how that can be regarded as "more deterministic".
>
>> device_resume() will never be called unless __device_suspend() has succeeded for the device.
>
> Which doesn't matter.  What matters is that (and which is the case
> already) the resume callbacks will not be invoked without invoking the
> suspend callbacks for the device beforehand.

Right. I rest my case - and sorry for the noise.

Kind regards
Uffe
