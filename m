Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94B4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7764A2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TA2j7LmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7764A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeJEBnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:43:24 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52366 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeJEBnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:43:24 -0400
Received: by mail-it1-f193.google.com with SMTP id 134-v6so14580681itz.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/bGHkySm1qJPlLwcpKu3hmzXg3MmBYURlKzFW1nB+Hc=;
        b=TA2j7LmZ4Uaoov1bu4p5srCr13Kmxmk8Nt47+Pk6XZP6bN0mKOCy+5LKc6U0sBmf8R
         LpwX1b9LIrFwxx6g3bG0CkViU97kTDpnzTeRAJmNPcSOlF9P+Z61784uJajuqN8D9aVC
         r4HyRgQ2Cx7toE4BsDL8quYBAMAcm8/Xxl/eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/bGHkySm1qJPlLwcpKu3hmzXg3MmBYURlKzFW1nB+Hc=;
        b=prPPHFquDcuP9IaoGlOXhbJqed70ap4NjQuEsb0MJOF+L6rSj6Y2rbE7HACIuh8vvR
         m88Wn3UoiePePtHeBDJIQqhuEbWlGMoMGBMyDJ0k6xxSb7NlYgKYLhTQ5DgVecWV7u4F
         T6DdLSwmmvaGaRDXs6C3oRKMNwczbrsZ5Fxoms185QYUyEb/s2kwNvNuwBZSh6Lf9p7Z
         amYyXQqogS6/p3OxmKf88xH9UCxG0f2PeBjISLQHRo25edCJyU3mKcg7MDD4pU7WTfXM
         u3tdv2398kGb6KS3B/yScEW7NychIdusVxxgbiznuMOtbogDxCknCDV2VcYFmD4fqYgR
         7Hjw==
X-Gm-Message-State: ABuFfoh3zhUJZGka5fvmqK20eFU49UhUwuVEzwVrd0RE2g297lE2LOmb
        T815S+QeO+pljfFFJx5AdHENP3VxOZ1SZr4gVjg3VA==
X-Google-Smtp-Source: ACcGV60ZDpJbGoIAGDaXmxcSC2nGes+XSrr5XeSKtG+pdnhw+iA+6yyIzVkXsKTP8OJcMtx/rWb7qW96UVMRGktCB0I=
X-Received: by 2002:a24:8045:: with SMTP id g66-v6mr6266786itd.45.1538678931053;
 Thu, 04 Oct 2018 11:48:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 11:48:10 -0700 (PDT)
In-Reply-To: <CAJZ5v0ih4Hn5W-dTzOayMyMfLMe=djKVhxBcoQ=7oJz6QnpTJQ@mail.gmail.com>
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
 <CAJZ5v0ih4Hn5W-dTzOayMyMfLMe=djKVhxBcoQ=7oJz6QnpTJQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 20:48:10 +0200
Message-ID: <CAPDyKFqMHVvyrjDzoC+QbSLbtdMYcfzDenb+uWTu+Fr-awbU1A@mail.gmail.com>
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

On 4 October 2018 at 19:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Oct 4, 2018 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > If __device_suspend() returns early on an error or pending wakeup
>> > and the power.direct_complete flag has been set for the device
>> > already, the subsequent device_resume() will be confused by it
>> > and it will call pm_runtime_enable() incorrectly, as runtime PM
>> > has not been disabled for the device by __device_suspend().
>>
>> I think it would be fair to mention that is related to the async
>> suspend path, in dpm_suspend().
>
> OK, fair enough.
>
>> >
>> > To avoid that, clear power.direct_complete if __device_suspend()
>> > is not going to disable runtime PM for the device before returning.
>>
>> Overall, by looking at the behavior in dpm_suspend() of async
>> suspended devices, it does look a bit fragile to me.
>>
>> My worries is that we put asynced suspended devices in the
>> dpm_suspended_list, no matter if the device was successfully suspended
>> or not. This differs from the no-async path.
>
> That's because this was the most straightforward way to organize that
> (otherwise you need to worry about the list locking with respect to
> the async suspends etc and you really need to preserve the ordering
> there).

I understand about the lock, but not sure if that is something to
worry about, at least from contention point of view, if that is what
you mean?

In regards to the order, is that really problem for async enabled devices?

>
>> In the long run, maybe we should change that instead?
>
> Is there anything wrong with it really?

No, besides complexity. :-)

My, point was that we could potentially simplify the code in
device_resume() and in __device_suspend(), as the behavior would them
becomes more deterministic. device_resume() will never be called
unless __device_suspend() has succeeded for the device.

Anyway, as stated, I fine with your patch. And if I get some time I
might send a patch to show you what I mean.

Kind regards
Uffe
