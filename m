Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1896BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7AC267AF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCikj1RW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7AC267AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933868AbeFZJ1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:27:44 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45420 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932558AbeFZJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:27:40 -0400
Received: by mail-oi0-f67.google.com with SMTP id 188-v6so15317503oid.12;
        Tue, 26 Jun 2018 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yWBeA6VQJ80kE6+hyv2MTLa3ITL68W2PGaSKLhX3hBg=;
        b=nCikj1RWkQJmg1AZQnEt2iHEsQIhXfgTJKLj0JaezDa8bJP2uP/Xbi+mCPJm0AOyOM
         AJlFMLR8HwUR3iPaZLJMJgMabVos4FZSzNssEEILxY+ay0couebYATejY9otlJZ+wTR9
         P4DlHSxoR7i1VdXISyTKfNaFLpxKWpdwcVQJrVh9PmlSCGYxRcmCmYoFpFNmfKYg99JX
         KsM+iFIUONiB6l4xNeZ0vIHLt5I+fwqO+RC1uu61R7pKv0VcmOgUva4qer5HElrYeYXb
         Kmog5RM1sih5tC8PA9pIIERUegtUpIFipOiVcUvFpiMZntMllEyhjj53WIOtIMRG5djV
         Ou4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yWBeA6VQJ80kE6+hyv2MTLa3ITL68W2PGaSKLhX3hBg=;
        b=AwH6mDpszqk3xaPEJzfALlKqD3KBn2t2g8F2J7XN8ZNLiTtjzVcNPUVCoUHBEyqwqO
         R8dP6ppO+p+lR0CsI6m/DNEx7jGUHvGKykquROAlE47gNqwL3LmulFgzLALIYihG4L04
         Kn5FwSoaamQz4qABNQ9GMMBCnDhWri8AzVkDq+ExiloV6gjmf1WiYdhk5tZqzDsvvuon
         Qf5lemwOU3Ku4WU3t9jxR+MxlsDBMr4bIICLmce/gHMyUxqY5bwLoxniUg5DmekEfu50
         nYCJqXgmmMsrpgCprzkq8yBW5UIMWx7RF9KpzetzLWj6+7/podUIUtIvKrMAY/yWBoE9
         qwzA==
X-Gm-Message-State: APt69E07b4E+Qb3XBt4K2Uitp/kQMmamFW1WEjqdwZGSVjppDp93VqOZ
        y/9+YNMD7lPu/b+ncUb1z7EG2RdCbP7OCwd6Kb4=
X-Google-Smtp-Source: AAOMgpeTk07s/gk4C5JWcOE4gCotQwX/qK430fMg5X0GswfjVFyHHPOL+QcmP3UMwWT6KtV9pXR2FYVKKJk5DbcZlIA=
X-Received: by 2002:aca:5bc6:: with SMTP id p189-v6mr400753oib.116.1530005259783;
 Tue, 26 Jun 2018 02:27:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 02:27:39
 -0700 (PDT)
In-Reply-To: <dd30daab-caf6-91d6-2f72-998f640f85ae@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
 <98f43bb6-9ab5-2f79-05f2-be68a0f7f88e@linaro.org> <CAJZ5v0gv_y9DfEsqq_46D5hi3SA+UYy7cUoaCwb3_+HtRadDOg@mail.gmail.com>
 <dd30daab-caf6-91d6-2f72-998f640f85ae@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jun 2018 11:27:39 +0200
X-Google-Sender-Auth: SbIuC6Q7CgcMc7IQIT1gi1suvkE
Message-ID: <CAJZ5v0i6Mi0MtrcQRCJs-v1PiogKzxGZj-N_+rzkJ9+98wvuGw@mail.gmail.com>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:15 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 25/06/2018 23:55, Rafael J. Wysocki wrote:
>> On Mon, Jun 25, 2018 at 1:52 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>> On 25/06/2018 10:23, Rafael J. Wysocki wrote:
>>>
>>> [ ... ]
>>>
>>>>> + * It is up to the user of this framework to provide a lock at an
>>>>> + * upper level to prevent stupid things to happen, like starting while
>>>>> + * we are unregistering.
>>>>> + */
>>>>
>>>> The English above and elsewhere needs some polishing IMO, but I can
>>>> take care of that. :-)
>>>
>>> I can give a try and if you are still unhappy, you change them in a
>>> better way.
>>
>> Well, I could tell you what I would write, but then it'll take less
>> time and effort if I just write it myself. :-)
>
> Ok.
>
>>> [ ... ]
>>>
>>>>> +static void idle_injection_setup(unsigned int cpu)
>>>>> +{
>>>>> +       struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
>>>>> +
>>>>> +       set_freezable();
>>>>
>>>> Why do you need set_freezable() here?
>>>
>>> We don't want to continue injecting idle cycles when the system is
>>> suspended.
>>
>> And where's the corresponding try_to_freeze() called?
>
> Yes, it is missing. I suppose try_to_freeze() should be put at the
> beginning of the idle_inject_fn() function, right ?

Well, given that people want to get rid of kthread freezing entirely,
adding it may not be a good idea at all.

Also I'm not sure if we should avoid injecting idle on system suspend.
It may slow down the suspend process, but that's OK and after that it
shouldn't matter.  And if it turns out to matter, we'll address the
problem instead of trying to avoid it by freezing the kthreads.

So, I would just drop the set_freezable() and leave it like that.
