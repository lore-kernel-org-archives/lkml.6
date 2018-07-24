Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3619C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F389205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npqi0Jb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F389205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbeGXJg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:36:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35579 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388439AbeGXJg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:36:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so6086741oik.2;
        Tue, 24 Jul 2018 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nGb1LDWuDLT4Brz4Yb+6LB4AuWKxe/VPLC7tlzSuG+Y=;
        b=Npqi0Jb0s9+RWdtR5V60klpaLF2HlEdoNwQnUpWvtFlNOuon76IvxwQuGgLJ46XdsF
         rTTIuHhYtFLGwanHRrTpeKZl7vgf+n+dANkTG8SHEw1gxfkzLCUAMN9auyPPESuHYcUW
         QLPYhi/jDL3in2lvChXwZMsRoaz40YLOQnNWUcaNPwxjZxvdQjNGFmsAXvVTcaHI59pS
         7TyQz/YdYh54IJiXm3kmtgNsBxCea0pfmW6OtiKhCFlw51XEiVdBbCY1+ASiA/eatx5N
         adqHcdPUVJowIds929xpD62ohauTV93u4kgwCq5IpHhKA9NYMIz+6mNG/UY5pwR3waCv
         nkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nGb1LDWuDLT4Brz4Yb+6LB4AuWKxe/VPLC7tlzSuG+Y=;
        b=LDMNGQFDbZu1PCRkQ/67m3uy7dCpqsFl5eH/34zqYLDWvnF2pbwB5wC+wfkfABnYKD
         6vvqBtI219RfZmSVHt4PcYk7K9og+0lOZ8L+zSDZdwNnA43VcivtjOUAkvxAW62z5/6H
         SgJcX2om7jugs+sAm/FzIc5VWOX1AQzRv/OdHKzjp59vMWhFDTtEgelbsBA6NB/VdUS/
         +Nu9L5VwfZk2pNdXNWVFO1uccVJ01iea9qxnnT1g8w9HVV8KIpmh3wj/kHWivMrdY4v3
         vxMhvl8LytH4cvOFj2F8L0yswke/IeTxYXNuIkG8S9D4LYV7/EqLo1G8tFNIYXKuetiL
         /Y7g==
X-Gm-Message-State: AOUpUlGH9lz7zhMMUZhJglitzMvgbmN4C5nP9KOxmjv7MKcQRrhsOoAn
        dHFHjv3lkuhrKY3ZphPTJ7STKE4H5uS6exVDpAo=
X-Google-Smtp-Source: AAOMgpfhChkGle3dxTHcFap3Gt5U64y6e6oMrZzoM29ICYXxpVRW53U/X/F/V1VafKXee0B2AnN/snwLR3hR9HDy/rg=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr2353288oih.227.1532421096091;
 Tue, 24 Jul 2018 01:31:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 01:31:35
 -0700 (PDT)
In-Reply-To: <20180723191627.GJ2494@hirez.programming.kicks-ass.net>
References: <1532368179-15263-1-git-send-email-longman@redhat.com>
 <1532368179-15263-3-git-send-email-longman@redhat.com> <20180723191627.GJ2494@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jul 2018 10:31:35 +0200
X-Google-Sender-Auth: TMcWQFCY2lQParMDCnWsFqTC5mY
Message-ID: <CAJZ5v0hbpk4FJQ3m4HCj_X44Jjp1JM21hwAAeisALmJQb8Cyfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Fix a circular lock dependency problem
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 9:16 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Jul 23, 2018 at 01:49:39PM -0400, Waiman Long wrote:
>>  drivers/cpufreq/cpufreq.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index b0dfd32..9cf02d7 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -922,8 +922,22 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>>       struct cpufreq_policy *policy = to_policy(kobj);
>>       struct freq_attr *fattr = to_attr(attr);
>>       ssize_t ret = -EINVAL;
>> +     int retries = 3;
>>
>> -     cpus_read_lock();
>> +     /*
>> +      * cpus_read_trylock() is used here to work around a circular lock
>> +      * dependency problem with respect to the cpufreq_register_driver().
>> +      * With a simple retry loop, the chance of not able to get the
>> +      * read lock is extremely small.
>> +      */
>> +     while (!cpus_read_trylock()) {
>> +             if (retries-- <= 0)
>> +                     return -EBUSY;
>> +             /*
>> +              * Sleep for about 50ms and retry again.
>> +              */
>> +             msleep(50);
>> +     }
>
> That's atrocious.

Agreed.
