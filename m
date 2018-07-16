Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A94ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4683620BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQX6jEAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4683620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeGPKMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:12:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34055 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeGPKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:12:22 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so37214644ioj.1;
        Mon, 16 Jul 2018 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sJTq8AniM1Z+6gTI66hjrVaMXxjjiH/dBEBAepNZTdg=;
        b=DQX6jEAbElBeid5Yo7I0Ir0LxYpc8pAjADQdZ7sO0ZCYpyfiykk5YjN+IbXvUyuZGS
         aKomHEWgv0WOdOcVgy5Ru+Cnzgl/JbRRnXhQGFFGg2wdWHkuraTXHvR52sHqqbMdkbj9
         UM5elV3DwCLqz3G24z79uEVPYnjYTyP31r+GPxes70IzZFtLe0eWsh6A+yHeMo2Z+pi7
         Hevkx/5+MSF4wmctL5N1CqVzCr/RA60W1MSSIRW9a7YNovrB0+87N/9vhrKoL7CMoGhr
         dBm21Xnwfi0LeLLVqhvB6FkEj0QiPTy54Khk2VGWat6rjS7YJqzXmejlJZT5BKZkHtfo
         LhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sJTq8AniM1Z+6gTI66hjrVaMXxjjiH/dBEBAepNZTdg=;
        b=tT1lPZZXRQ3wxQjSnRfdH3iYUvWsYQrDTHtJ6HluFEIEZBbI1zzUXKclohDfZWAXrR
         IGn51H8Li0LGehv32StZB9/kJylgZr7wlks/hRP9efbiQhCW4ioZ5d2DQFAmkaEQPSBL
         pRJ9WU4Rd+vQX3K3LJlvy5VXhIXUpHcfFEYdK49eqgbzCoKqeySt/QlptC820zuE6/em
         ymhX9DuJgsBz1H5moBMu/E1OOeY2wWzFCW0pVvVdX8xF3bKetdQ6tGhQlUezbJPdHl7J
         YiXlFFE6Hn2SM6ASIQL8gqtjyU0J7BiV3vTiL0sgKklsMb+2NtMNHImHA/vZEhjec24W
         X5ow==
X-Gm-Message-State: AOUpUlE4/7SrpycQ32aAh7ZzIp2RqOTOFx6L46pqZgjKtmUpk6XCpxee
        bBaTyMjHvOd20/vrLM+9aKb+YcqoI8Jkd/Lrhis=
X-Google-Smtp-Source: AAOMgpcRFz5lSVyGmpa153g+bId7xP817NJPE1AaC4DtksERlVh8e/BJCQtZd57X76XZxXKV6DG1bycL1mtuhmF2BJ8=
X-Received: by 2002:a6b:6410:: with SMTP id t16-v6mr13029940iog.11.1531734347111;
 Mon, 16 Jul 2018 02:45:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 02:45:06
 -0700 (PDT)
In-Reply-To: <20180716075836.GC17280@dhcp22.suse.cz>
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com> <20180716075836.GC17280@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 16 Jul 2018 17:45:06 +0800
Message-ID: <CALOAHbD1+eYHDo5-q1--nsBTNj66ZX6iw2YU4koLgZD_0ZDy+w@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg in softirq
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 3:58 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Sat 14-07-18 16:32:02, Yafang Shao wrote:
>> try_charge maybe executed in packet receive path, which is in interrupt
>> context.
>> In this situation, the 'current' is the interrupted task, which may has
>> no relation to the rx softirq, So it is nonsense to use 'current'.
>>
>> Avoid bothering the interrupted if page_counter_try_charge failes.
>
> I agree with Shakeel that this changelog asks for more information about
> "why it matters". Small inconsistencies should be tolerable because the
> state we rely on is so rarely set that it shouldn't make a visible
> difference in practice.
>

HI Michal,

No, it can make a visible difference in pratice.
The difference is in __sk_mem_raise_allocated().

Without this patch, if the random interrupted task is oom victim or
fatal signal pending or exiting, the charge will success anyway. That
means the cgroup limit doesn't work in this situation.

With this patch, in the same situation the charged memory will be
uncharged as it hits the memcg limit.

That is okay if the memcg of the interrupted task is same with the
sk->sk_memcg,  but it may not okay if they are difference.

I'm trying to prove it, but seems it's very hard to produce this issue.

>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> ---
>>  mm/memcontrol.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 68ef266..13f95db 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2123,6 +2123,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>               goto retry;
>>       }
>>
>> +     if (in_softirq())
>> +             goto nomem;
>> +
>
> If anything would it make more sense to use in_interrupt() to be more
> bullet proof for future?
>
>>       /*
>>        * Unlike in global OOM situations, memcg is not in a physical
>>        * memory shortage.  Allow dying and OOM-killed tasks to
>> --
>> 1.8.3.1
>
> --
> Michal Hocko
> SUSE Labs
