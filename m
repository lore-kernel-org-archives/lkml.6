Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81E6ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8261F2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs5NS74X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8261F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeINWEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:04:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46125 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINWEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:04:36 -0400
Received: by mail-qt0-f195.google.com with SMTP id l42-v6so9290192qtf.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2U/zRIYXi8MDOSKWcmEh9f8oUGxKPlT+23ncFeK4eJU=;
        b=Gs5NS74X7WM7GwpPtvLZ97up92D8fHBcpVH2zCMkToxORbBXWN2kJGZClpHrCf5IId
         Tck9kJ1zfK9KDYTAC9MH0bbDly/3h4RWUcOPiilKIqLlqzZR6XcloAlJEbCjEFDy3nUL
         LaLwE4ta+aWXCj0yDzosYnY9+M2b8Nw/A9jmsdCSYplcx5rL5EXEAxtCInM3IXHF3UCF
         t5j6CO79ulewyvvSrePxmZl0lbY21ejAoEcOI3MApQzLA+FrziB4gzMMide5DC+VrTkQ
         0gFVkizT/Bmq+7sBre5gkmQZGMs0evu4+6w1RR1FdVnUhWa39Ahelbyqm2na82Co3IXw
         F7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2U/zRIYXi8MDOSKWcmEh9f8oUGxKPlT+23ncFeK4eJU=;
        b=cFxuIpHBMrorCvle0CxcrfJeI9fkn/0uRMcrX9whw9kQ5J0sC+W+mVRFx/X3WxdojW
         kkeg7BswjB2twYmUPG1DyBI1eUI6D38PLHaeuNVBwU/XgnmonUrU8LdOHYXJeiXem++y
         EWbE5Ic03yGmpD2M7OPzlVzkwZ+RhhN4yJF0q+fuEuLYoYOiShUaKvAZY96jm7O4rhPZ
         qaxEXSKCnEE9w+0jsCeC86MqrttkLQ91RdSK2ATu3kLCgixuU9qfgFvPmvCo7PQ1h3Vm
         OLY2r6qLf6E/g4PxamXJgGXaYm68DS46YEM+UobwxIn7ZEwDyVh1qtveVTMEdFdV652a
         YflA==
X-Gm-Message-State: APzg51AQvbB4ra81fcedw7jDfWsLEgUh6qTRF397kkbge2Zfxd0p8Fc+
        +mwP90wYfB5K59N1zlL1VZCGIqv5BcwvidVkx9g=
X-Google-Smtp-Source: ANB0VdapTFzKVWtr4k4uoZULRuvAOSinf7KfkkZdGjhEYIgfrqV7VUbbKIxIQPAgEzwxbo9yB+jy/xkNOXsLfOKlDJA=
X-Received: by 2002:a0c:aac9:: with SMTP id g9-v6mr9781350qvb.78.1536943757659;
 Fri, 14 Sep 2018 09:49:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 09:48:57
 -0700 (PDT)
In-Reply-To: <2278505d-94ce-ab68-dbe3-5e4e1c9094ef@163.com>
References: <20180810023523.23923-1-douly.fnst@cn.fujitsu.com> <2278505d-94ce-ab68-dbe3-5e4e1c9094ef@163.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Sep 2018 18:48:57 +0200
Message-ID: <CANiq72=jvRaq6gfTYcfSXmKj-vjpydZ2arZ2Yt4qz9pYZg6ZMA@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Fix compiling warring in smp=n case
To:     Dou Liyang <dou_liyang@163.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 13, 2018 at 11:55 AM, Dou Liyang <dou_liyang@163.com> wrote:
>
>
> At 08/10/2018 10:35 AM, Dou Liyang wrote:
>>
>> When compiling kernel with SMP disabled, the build warns with:
>>
>> kernel/sched/core.c: In function =E2=80=98update_rq_clock_task=E2=80=99:
>> kernel/sched/core.c:139:17: warning: unused variable =E2=80=98irq_delta=
=E2=80=99
>> [-Wunused-variable]
>>    s64 steal =3D 0, irq_delta =3D 0;
>>
>> Fix this by revert the HAVE_SCHED_AVG_IRQ to
>>
>>    defined(CONFIG_IRQ_TIME_ACCOUNTING) ||
>> defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
>>
>> Fixes: 2e62c4743adc ("sched/fair: Remove #ifdefs from
>> scale_rt_capacity()")
>
>
> Hi,
>
>  Miguel also found this warning. Can we pick it up now? ;-)

Also Zhong has just sent another patch for this.

Whenever this is picked up, feel free to add:

  Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
