Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A336C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FE320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fieahl-im.20150623.gappssmtp.com header.i=@fieahl-im.20150623.gappssmtp.com header.b="n37TjHIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FE320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieahl.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeIKCUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:20:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42167 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeIKCUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:20:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so17643081edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fieahl-im.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gAekfegsaJRwr2HigFS2Llvnm5QtdNDaPdMIR05nDG0=;
        b=n37TjHIV0Vlr7MmqyFHSeHhe0+FaxcYSSV8Jo8mS9o/Q6R5pIbHOl2G+gPUuso8r3C
         /FDduTbsUWvfiAjSh02ocP35ZAk0pxsSiA03CbaqeswzbrFKf5/mT1CmW1HtrlHWIdIo
         FIa8ga/RATVm76KtiRPUnzNSUjiKQaagS9aIFYonWrYma6MdgUqkH0XT1Z8OEXJJf4iR
         EXeJugi/4q46OPKYbdMdgWzp9AJrJ6w5IQNHwusR/tgYwyHdPuAvAbF7kLIH2F6qaM/N
         5Xr3AKNgup8dnXo7ajueG7bdof9Acms+YGXSRF712U151yiYl5THIpWt304TLzH6FJC3
         NEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gAekfegsaJRwr2HigFS2Llvnm5QtdNDaPdMIR05nDG0=;
        b=m9rIst4hLW6VvA4Wr+b0oR+h94pJRDRWfq6ZIfsLm147mHrIBYMWh3NwbQhitDl68I
         42dD+Bs1zSGyATylMCWhlv+L8v99w9RG+vdhRPR3XEkgJ8iuzXi1B01C5wHnCIisJlVl
         VhUMHJ641GUW+zjML6CRp5aL7KvPZbmype3KX90JPAs6TIgpEa3qJMaaOVnXgxUEmxay
         vGim+s+4R4KQOFv8oaOxJiduf/HhOf1A2iJy2vYVWAKBBK6DdXM4LCyL0H9XDCeQbK2U
         2HcNKJnCJqEslV5SaPLsZyypVyB09+kxH3hfSsN+iEo3ltdFUZ/mu6mePLl5CJ8AASiK
         V5HQ==
X-Gm-Message-State: APzg51BfGm25HrGFRiAzv0ZP4wN7GpkOW/ov7W/s/iJ3kqfI5nAdC0Gk
        yoyF7Qz+QNs0mVZOxMGoyMZFPTsq/U/6yHKahxGbvA==
X-Google-Smtp-Source: ANB0VdaY1FKvnSg1uzpsGSlBxG3huxI5gRtY+s/BXcwYHCSFD+tHAryc3UYayzjej7+rqdHLZa9Z3w4Zv+PcARSwq28=
X-Received: by 2002:a50:ab15:: with SMTP id s21-v6mr25278811edc.133.1536614677744;
 Mon, 10 Sep 2018 14:24:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a664:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 14:24:37
 -0700 (PDT)
X-Originating-IP: [60.51.52.116]
In-Reply-To: <CAJZ5v0ijVnhZ52GrVbCeRQMCTBzgpBgB7AYoqJegjSBEcXamSA@mail.gmail.com>
References: <20180910173953.10113-1-kw@fieahl.im> <CAJZ5v0ijVnhZ52GrVbCeRQMCTBzgpBgB7AYoqJegjSBEcXamSA@mail.gmail.com>
From:   Fieah Lim <kw@fieahl.im>
Date:   Tue, 11 Sep 2018 05:24:37 +0800
Message-ID: <CACXwQcBUZkHDy3HZTPYR8+hsa3GZ=Ogyuimdow=y_8trbALNeA@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: enter_state: Don't needlessly calculate diff time
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 4:17 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Sep 10, 2018 at 7:40 PM Fieah Lim <kw@fieahl.im> wrote:
>>
>> Currently we use ktime_us_delta() to calculate last residency and
>> state usage unconditionally, it makes no sense to do this calculation
>> when we fails to enter any idle state.
>> It can be optimize by moving the calculation after entered_state >= 0
>>
>> While at it, merge those comment blocks into one and remove a
>> space between type casting of diff.
>>
>> This patch has no functional changes.
>>
>> Signed-off-by: Fieah Lim <kw@fieahl.im>
>> ---
>> Changes from v1:
>>  - Rewrite changelog as Rafael J. Wysocki suggested
>> ---
>>  drivers/cpuidle/cpuidle.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 6df894d65d9e..5f6b2c9b6555 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>>         if (!cpuidle_state_is_coupled(drv, index))
>>                 local_irq_enable();
>>
>> -       diff = ktime_us_delta(time_end, time_start);
>> -       if (diff > INT_MAX)
>> -               diff = INT_MAX;
>> -
>> -       dev->last_residency = (int) diff;
>> +       dev->last_residency = 0;
>
> You don't need this line if you retain the "else" branch below, do you?
>
You are right, should I make a v3?

Please bear with me if anything wrong in this reply.
I'm not sure if I doing this right. This is my first reply to a mailing list.
Thank you.
>>
>>         if (entered_state >= 0) {
>> -               /* Update cpuidle counters */
>> -               /* This can be moved to within driver enter routine
>> +               /* Update cpuidle counters
>> +                * This can be moved to within driver enter routine,
>>                  * but that results in multiple copies of same code.
>>                  */
>> +               diff = ktime_us_delta(time_end, time_start);
>> +               if (diff > INT_MAX)
>> +                       diff = INT_MAX;
>> +
>> +               dev->last_residency = (int)diff;
>>                 dev->states_usage[entered_state].time += dev->last_residency;
>>                 dev->states_usage[entered_state].usage++;
>> -       } else {
>> -               dev->last_residency = 0;
>>         }
>>
>>         return entered_state;
>> --
>> 2.18.0
>>
